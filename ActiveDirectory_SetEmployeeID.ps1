<#
.SYNOPSIS
    Imports the employeeID of users into Active Directory
.DESCRIPTION
    This script uses the Users.csv CSV file located in C:\Temp to import the EmployeeID into Active Directory.
    It uses the CSV file to declare the Username and EmmployeeID as variables, and the imports them into AD.
.INPUTS
  None.
.OUTPUTS
  None.
.NOTES
  Version:        1.0
  Author:         Matthew Harding
  Creation Date:  10/30/18
  Purpose/Change: Initial script development

.EXAMPLE
  <Example goes here. Repeat this attribute for more than one example>
#>

#----------------------------------------------------------[Declarations]----------------------------------------------------------

Import-Module ActiveDirectory
$File = "C:\temp\Users.csv"

Import-CSV $File | % {

    $User = $_.UserName
    $EmployeeID = $_.EmployeeID

#-----------------------------------------------------------[Execution]------------------------------------------------------------

Set-ADUser $User -employeeID $EmployeeID

                                    }
