#Set Execution Policy
Set-ExecutionPolicy -ExecutionPolicy Bypass

#Check for RSAT installation and install if needed
$Modules = Get-Module -ListAvailable

if ($Modules | where name -match "ActiveDirectory") {
Write-Host "Active Directory Module is installed"
}

else {
Write-Host "Installing RSAT Active Directory Module"
Get-WindowsCapability -Name RSAT.ActiveDirectory* -Online | Add-WindowsCapability -Online -Verbose
}

#Import the AD Module
Import-Module ActiveDirectory

#Get Servers in AD Computers
Write-Host "Finding Servers..."
$Servers = Get-ADComputer -Filter {operatingsystem -like "*server*"} 

#Get all NetWork Adapter info for each server in list
Write-Host "Collecting Server IP's"
$ServerIps = foreach ($computer in $Servers) {
Get-CimInstance Win32_NetworkAdapterConfiguration -ComputerName $computer.name 2> $null | 
where description -like "*net*" | 
select PSComputername, IPAddress, Description} 

#Find Mail Server
Write-Host "Finding Mail Server"
$MailServer = foreach ($computer in $Servers) {
Get-CimInstance Win32_InstalledWin32Program -ComputerName $computer.name 2> $null | where name -Like "*Exchange*"
}

#Obtain DC parameters
$DC = Get-ADDomainController

Clear-Host

#Begin write output

Write-Host "Your Domain Controller is "$DC.name""
Write-Host "Your Domain Name is "$DC.forest""
Write-Host "The DC IPV4 address is "$DC.IPv4Address""
Write-Host "Your local Mail Server is on "$MailServer.PSComputername""
Write-Host "Mail Server OS is "$MailServer.name" and Version "$MailServer.version""
Write-Host ""
Write-Host "The list of all Active Servers and IP addresses:"
$ServerIps



