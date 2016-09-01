$packageName = "Wget"
$url = "https://eternallybored.org/misc/wget/releases/wget-1.17-win32.zip"
$url64 = "https://eternallybored.org/misc/wget/releases/wget-1.17-win64.zip"
$unzipLocation  = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# as per: https://www.gnu.org/prep/ftp.html
# which point to: http://wget.addictivecode.org/FrequentlyAskedQuestions?action=show&redirect=Faq#download
# I'm getting the binaries from: https://eternallybored.org/misc/wget/
Install-ChocolateyZipPackage $packageName $url $unzipLocation $url64
