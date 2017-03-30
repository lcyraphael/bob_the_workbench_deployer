﻿Param (
 [string] $username, 
 [string] $password, 
 [string] $websiteName, 
 [string] $workbench_war
)

$base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $username,$password)))
$userAgent = "powershell/1.0"
$apiUrlVfs = "https://" + $websiteName + ".scm.azurewebsites.net/api/vfs/site/wwwroot/webapps/ROOT/index.jsp"
$apiUrlZip = "https://" + $websiteName + ".scm.azurewebsites.net/api/zip/site/wwwroot/webapps/ROOT/"

$headers = @{
    "Authorization" = ("Basic {0}" -f $base64AuthInfo)
    "If-Match"      = "*"
}
Invoke-RestMethod -Uri $apiUrlVfs -Headers $headers -UserAgent $userAgent -Method DELETE 
Invoke-RestMethod -Uri $apiUrlZip -Headers $headers -UserAgent $userAgent -Method PUT -InFile $workbench_war