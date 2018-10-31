<#
.SYNOPSIS
	This script will determine whether a machine is Laptop or not, and then join it to the appropriate Organization Unit in Active Directory.
.DESCRIPTION
	This script will determine whether a machine is Laptop or not, and then join it to the appropriate Organization Unit in Active Directory.
.INPUTS
 	None
.OUTPUTS
  On screen.
.NOTES
  Version:        1.0
  Author:         Matthew Harding
  Creation Date:  10/30/2018
  Purpose/Change: Initial script development

.EXAMPLE
  ActiveDirectory_JoinToAD.ps1
#>

#---------------------------------------------------------[Initialisations]--------------------------------------------------------

#Set Error Action to Silently Continue
$ErrorActionPreference = "SilentlyContinue"

#----------------------------------------------------------[Declarations]----------------------------------------------------------

# Set the environment variables.
$Cred = New-Object System.Management.Automation.PsCredential("domain\account", (ConvertTo-SecureString "password" -AsPlainText -Force))
$Domain = "domain.tld"
$OUMobile = "OU=Department,OU=Mobile,DC=domain,DC=tld"
$OUDesktop = "OU=Department,OU=Desktop,DC=domain,DC=tld"

#-----------------------------------------------------------[Functions]------------------------------------------------------------

# Function from http://www.techcrafters.com/scripts/windows-system-management/determine-whether-a-machine-is-laptop-or-not.html
# Why re-invent the wheel?
Function Detect-Laptop
	{
		Param( [string]$computer = “localhost” )
	$isLaptop = $false

# The chassis is the physical container that houses the components of a computer. Check if the machine’s chasis type is 9.Laptop 10.Notebook 14.Sub-Notebook
	if(Get-WmiObject -Class win32_systemenclosure -ComputerName $computer | Where-Object { $_.chassistypes -eq 9 -or $_.chassistypes -eq 10 -or $_.chassistypes -eq 14})
	{ $isLaptop = $true }

# Shows battery status, if true then the machine is a laptop.
	if(Get-WmiObject -Class win32_battery -ComputerName $computer)
		{ $isLaptop = $true }
			$isLaptop
		}

#-----------------------------------------------------------[Execution]------------------------------------------------------------

If(Detect-Laptop) {
    Write-Host "This is a laptop/tablet.”
    Add-Computer -DomainName $Domain -Credential $Cred -OUPath $OUMobile -Force
    }

    else {
    Write-Host “This is a desktop.”
    Add-Computer -DomainName $Domain -Credential $Cred -OUPath $OUDesktop -Force
    }
