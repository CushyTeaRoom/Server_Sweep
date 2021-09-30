# Server_Sweep
Lookup all active servers in a domain

This script was originally meant to be a BASH conversion of a pentesting script I came across. It would ping a subnet and look for pivot points on a network. Powershell works very different than BASH, so the project changed dramatically while working on it. Now, the script is more of a New-System's-Administrator/Engineer script that will find crucial on-premise domain information, such as:

1) Find all active servers in a domain environment
2) Find the primary Domain Controller
3) Print domain name
4) Find the server running the mail server
5) Print all server NIC information (IP addresses and card type)

For success with this script, your environment (PC) and Active Directory account will need a few things:

1) Your PC needs to be joined to the domain your are querying.
2) You need to have the rights to install and use the RSAT (Remote Server Administration Tools) powershell module. RSAT will be checked (and installed if need be) automatically by the script. Running this as administrator will work best. 
3) You must be networked to the Domain Controller. If you can't ping the Domain Controller (E.G. working remotely with no VPN) this won't work.

If anyone has any suggestions on additional searches or features for this script, please feel free to reach out. 
