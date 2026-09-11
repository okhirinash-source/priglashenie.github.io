param([string]$InputPath, [string]$OutputPath)

Add-Type -AssemblyName System.Drawing
$source = [System.Drawing.Bitmap]::FromFile($InputPath)
$result = New-Object System.Drawing.Bitmap $source.Width, $source.Height, ([System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
for ($y = 0; $y -lt $source.Height; $y++) {
  for ($x = 0; $x -lt $source.Width; $x++) {
    $pixel = $source.GetPixel($x, $y)
    $minimum = [Math]::Min($pixel.R, [Math]::Min($pixel.G, $pixel.B))
    $maximum = [Math]::Max($pixel.R, [Math]::Max($pixel.G, $pixel.B))
    # White/near-white neutral pixels are background; retain colorful light petals.
    if ($minimum -gt 225 -and ($maximum - $minimum) -lt 18) { $result.SetPixel($x, $y, [System.Drawing.Color]::FromArgb(0, $pixel.R, $pixel.G, $pixel.B)) }
    else { $result.SetPixel($x, $y, $pixel) }
  }
}
$result.Save($OutputPath, [System.Drawing.Imaging.ImageFormat]::Png)
$source.Dispose(); $result.Dispose()
