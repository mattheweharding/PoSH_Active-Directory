<#
.SYNOPSIS
  Imports the phone numbers of users into Active Directory.
.DESCRIPTION
  Imports the phone numbers of users into Active Directory.
.INPUTS
  None.
.OUTPUTS
  None.
.NOTES
  Version:        1.0
  Author:         Matthew Harding
  Creation Date:  10/30/2018
  Purpose/Change: Initial script development

.EXAMPLE
  ActiveDirectoryt_BulkTelephoneNumberImport.ps1
#>

#---------------------------------------------------------[Initialisations]--------------------------------------------------------

Import-Module ActiveDirectory

#----------------------------------------------------------[Declarations]----------------------------------------------------------

$inputFile = Import-CSV c:\test.csv
$log = “.\Error-Log.txt”
$date = Get-Date

#-----------------------------------------------------------[Functions]------------------------------------------------------------

Function ChangeTelephoneNumber
{
“Change Process Started On: ” + $date + “) :” | Out-File $log -Append
“————————————————-” | Out-File $log -Append
foreach($line in $inputFile)
{
        $sam = $line.SamAccountName
        $officephone = $line.OfficePhone
            Set-ADUser -Identity $sam -OfficePhone $officephone
            Write-Host “Completed Telephone Number Change For: $sam”
            “Completed Telephone Number Change For: $sam” | Out-File $log -Append
}


#-----------------------------------------------------------[Execution]------------------------------------------------------------
Write-Host “Active Directory – Telephone Number Change Script”
Start-Sleep 2

Write-Host “The change process is now commencing, please wait…”
Start-Sleep 2

ChangeTelephoneNumber

Start-Sleep 2
Write-Host “The process is now complete, please review the log file for any errors.”
