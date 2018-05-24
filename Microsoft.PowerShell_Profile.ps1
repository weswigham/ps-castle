$env:PSModulePath = $env:PSModulePath + ";" + $PSScriptRoot + "\Modules"

ipmo posh-git
ipmo PSPowerline

$env:DIFF = "C:\Program Files\Beyond Compare 4\BCompare.exe"

$env:workerCount = 8

# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

function sudo
{
    $file, [string]$arguments = $args;
    $psi = new-object System.Diagnostics.ProcessStartInfo $file;
    $psi.Arguments = $arguments;
    $psi.Verb = "runas";
    $psi.WorkingDirectory = get-location;
    [System.Diagnostics.Process]::Start($psi);
}

function which($name){
	Get-Command $name | Select-Object -ExpandProperty Definition
}

function gco($branch) {
  git checkout $branch
}

function gs() {
  git status
}

function open($name) {
  code -r $name
}

function tailf($path) {
  Get-Content -Path $path -Wait
}

function travisDebug($job) {
  Invoke-WebRequest -Uri https://api.travis-ci.org/job/$job/debug -Headers @{"Content-Type" = "application/json"; "Accept" = "application/json"; "Travis-API-Version" = "3"; "Authorization" = "token JVjtyMePTZuvnsCg5Kc1cw"} -Method Post -Body '{ "quiet": true }'
}

function Remote($computername){
  if(!$global:credential){
    $global:credential =  Get-Credential
  }
  $session = New-PSSession -ComputerName $computername -Credential $credential
  Invoke-Command -FilePath $profile -Session $session
  Enter-PSSession -Session $session
}

function RemoteCI() {
  Remote TS-CD-003
}

$env:PROMPT = $true

