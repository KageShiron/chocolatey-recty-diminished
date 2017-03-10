
$ErrorActionPreference = 'Stop';

$packageName= 'fonts-ricty-diminished'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://www.rs.tus.ac.jp/yyusa/ricty_diminished/ricty_diminished-4.1.0.tar.gz'
$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = '.tar.gz'
  url           = $url

  softwareName  = 'fonts-ricty-diminished*'

  checksum      = '6DCE3E5D3E044E2EE77B3B181A62D541'
  checksumType  = 'sha256'
}

# un gz
Install-ChocolateyZipPackage @packageArgs

# un tar
$dist =  Join-Path $toolsDir "fonts"
$tar = Join-Path $toolsDir ([System.IO.Path]::GetFileNameWithoutExtension($url))
Get-ChocolateyUnzip -FileFullPath $tar -Destination $dist

# Install fonts
powershell -f """$(Split-Path -parent $MyInvocation.MyCommand.Definition)\Add-Font.ps1"""  $dist

Write-ChocolateySuccess "$packageName"
