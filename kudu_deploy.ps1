Param (
 [string] $username, 
 [string] $password, 
 [string] $websiteName, 
 [string] $workbench_war,
 [string] $graphdb_username,
 [string] $graphdb_password
)

$base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $username,$password)))
$userAgent = "powershell/1.0"

$apiUrlVfs1 = "https://" + $websiteName + ".scm.azurewebsites.net/api/vfs/site/wwwroot/webapps/ROOT/index.jsp"
$apiUrlVfs2 = "https://" + $websiteName + ".scm.azurewebsites.net/api/vfs/site/wwwroot/webapps/ROOT/background.png"
$apiUrlZip = "https://" + $websiteName + ".scm.azurewebsites.net/api/zip/site/wwwroot/webapps/ROOT/"

$headers = @{
    "Authorization" = ("Basic {0}" -f $base64AuthInfo)
    "If-Match"      = "*"
}
Invoke-RestMethod -Uri $apiUrlVfs1 -Headers $headers -UserAgent $userAgent -Method DELETE 
Invoke-RestMethod -Uri $apiUrlVfs2 -Headers $headers -UserAgent $userAgent -Method DELETE 
Invoke-RestMethod -Uri $apiUrlZip -Headers $headers -UserAgent $userAgent -Method PUT -InFile $workbench_war

# Ping/ test-connection?

$payload = @{
    username = $graphdb_username
    password = $graphdb_password
    uri="https://api20170412115159.azure-api.net/fakeworkbench/"
}
$json = $payload | ConvertTo-Json
$response = Invoke-RestMethod "https://raphael000asdfg.azurewebsites.net/rest/locations" -Method Put -Body $json -ContentType "application/json"