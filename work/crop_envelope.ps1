param([string]$InputPath,[string]$OutputPath)
Add-Type -AssemblyName System.Drawing
$image=[System.Drawing.Bitmap]::FromFile($InputPath)
# The supplied portrait contains the envelope from x=45..635 and y=438..855.
$crop=New-Object System.Drawing.Rectangle 42,430,595,440
$result=New-Object System.Drawing.Bitmap $crop.Width,$crop.Height
$g=[System.Drawing.Graphics]::FromImage($result)
$g.DrawImage($image,(New-Object System.Drawing.Rectangle 0,0,$crop.Width,$crop.Height),$crop,[System.Drawing.GraphicsUnit]::Pixel)
$result.Save($OutputPath,[System.Drawing.Imaging.ImageFormat]::Jpeg)
$g.Dispose();$result.Dispose();$image.Dispose()
