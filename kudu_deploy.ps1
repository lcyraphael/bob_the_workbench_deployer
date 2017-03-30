$base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $env:username,$env:password)))
$userAgent = "powershell/1.0"
$apiUrl = "https://" + $env:websiteName + ".scm.azurewebsites.net/api/zip/site/wwwroot/webapps/ROOT/"
Invoke-RestMethod -Uri $apiUrl -Headers @{Authorization=("Basic {0}" -f $base64AuthInfo)} -UserAgent $userAgent -Method PUT -InFile $env:workbench 
