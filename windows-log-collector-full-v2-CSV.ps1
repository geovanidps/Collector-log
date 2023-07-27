echo "---------------------------------------------------"
echo "windows-log-collector-full-v2-2023..."
echo "---------------------------------------------------"
echo ""


try{
echo "Date"
Get-Date
}
catch
{
echo "Not Date"
}

try{
echo "checking permission"
Set-ExecutionPolicy RemoteSigned
}
catch
{
echo "could not set permission"
}

try{
echo "creating a new directory"
New-Item -ItemType "directory" -Path "wineventlog" -erroraction 'silentlycontinue'
}
catch
{
echo "can't create a new directory"
}

try{
echo "Extracting Security Logs"
get-eventlog -log Security -erroraction 'silentlycontinue' | export-csv -Path wineventlog/Security.csv -Delimiter ';' -NoTypeInformation | Import-Csv -Path wineventlog/Security.csv
}
catch 
{
echo "Can't retrieve Security Logs"
}

try{
echo "Extracting WMI"
Get-Process -Name WmiPrvSE -erroraction 'silentlycontinue' | Select-Object -Property BasePriority,Id,SessionId,WorkingSet | Export-Csv -Path wineventlog/WmiData.csv -Delimiter ';' -NoTypeInformation | Import-Csv -Path wineventlog/WmiData.csv 
}
catch 
{
echo "Can't retrieve WMI"
}

try{
echo "Extracting History Powershell"
Get-History -erroraction 'silentlycontinue' | Format-List -Property * | export-csv -Path wineventlog/History.csv -Delimiter ';' -NoTypeInformation | Import-Csv -Path wineventlog/History.csv
}
catch 
{
echo "Can't retrieve History Powershell"
}


try{
echo "Extracting Process"
Get-Process -erroraction 'silentlycontinue' | Export-Csv -Path wineventlog/Processes.csv -Delimiter ';' -NoTypeInformation | Get-Content -Path wineventlog/Processes.csv
}
catch 
{
echo "Can't retrieve Process"
}

try{
echo "Extracting Registry"
get-psdrive -erroraction 'silentlycontinue' | export-csv -Path wineventlog/Registry.csv -Delimiter ';' -NoTypeInformation | Import-Csv -Path wineventlog/Registry.csv
}
catch 
{
echo "Can't retrieve Registry"
}

try{
echo "Extracting Setup Logs"
Get-WinEvent -LogName setup -erroraction 'silentlycontinue' | export-csv -Path wineventlog/Setup.csv -Delimiter ';' -NoTypeInformation | Import-Csv -Path wineventlog/Setup.csv
}
catch 
{
echo "Can't retrieve Setup Logs"
}

try
{
echo "Extracting System Logs"
Get-WinEvent -LogName System -erroraction 'silentlycontinue' | export-csv -Path wineventlog/System.csv -Delimiter ';' -NoTypeInformation | Import-Csv -Path wineventlog/System.csv
}
catch 
{
echo "Can't retrieve System Logs"
}

try{
echo "Extracting Application Logs"
Get-WinEvent -LogName Application -erroraction 'silentlycontinue' | export-csv -Path wineventlog/Application.csv -Delimiter ';' -NoTypeInformation | Import-Csv -Path wineventlog/Application.csv
}
catch 
{
echo "Can't retrieve Application Logs"
}


try{
echo "Extracting Windows PowerShell Logs"
Get-WinEvent -LogName "Windows PowerShell" -erroraction 'silentlycontinue' | export-csv -Path wineventlog/Windows_PowerShell.csv -Delimiter ';' -NoTypeInformation | Import-Csv -Path wineventlog/Windows_PowerShell.csv
}
catch 
{
echo "Can't retrieve Windows PowerShell Logs"
}

try{
echo "Extracting TerminalServices LocalSessionManager Logs"
Get-WinEvent -LogName "Microsoft-Windows-TerminalServices-LocalSessionManager/Operational" -erroraction 'silentlycontinue' | export-csv -Path wineventlog/LocalSessionManager.csv -Delimiter ';' -NoTypeInformation | Import-Csv -Path wineventlog/LocalSessionManager.csv
}
catch 
{
echo "Can't retrieve Microsoft-Windows-TerminalServices-LocalSessionManager/Operational Logs"
}

try{
echo "Extracting Windows Defender Logs"
Get-WinEvent -LogName "Microsoft-Windows-Windows Defender/Operational" -erroraction 'silentlycontinue' | export-csv -Path wineventlog/Windows_Defender.csv -Delimiter ';' -NoTypeInformation | Import-Csv -Path wineventlog/Windows_Defender.csv
}
catch 
{
echo "Can't retrieve Microsoft-Windows-Windows Defender/Operational Logs"
}

try{
echo "Extracting WinRM Logs"
Get-WinEvent -LogName Microsoft-Windows-WinRM/Operational -erroraction 'silentlycontinue' | export-csv -Path wineventlog/WinRM.csv -Delimiter ';' -NoTypeInformation | Import-Csv -Path wineventlog/WinRM.csv
}
catch 
{
echo "Can't retrieve Microsoft-Windows-WinRM/Operational Logs"
}


try{
echo "Extracting PowerShell Logs"
Get-WinEvent -LogName Microsoft-Windows-PowerShell/Operational -erroraction 'silentlycontinue' | export-csv -Path wineventlog/Powershell_Operational.csv -Delimiter ';' -NoTypeInformation | Import-Csv -Path wineventlog/Powershell_Operational.csv
}
catch 
{
echo "Can't retrieve Microsoft-Windows-PowerShell/Operational Logs"
}

try{
echo "Extracting Sysmon Logs"
Get-WinEvent -LogName Microsoft-Windows-Sysmon/Operational -erroraction 'silentlycontinue' | export-csv -Path wineventlog/Sysmon.csv -Delimiter ';' -NoTypeInformation | Import-Csv -Path wineventlog/Sysmon.csv
}
catch 
{
echo "Can't retrieve Microsoft-Windows-Sysmon/Operational Logs"
}

try
{
echo "Generating hashes for files *.exe"
Get-Childitem -path "C:\*.exe" -recurse -Filter *.exe -erroraction 'silentlycontinue' | Get-FileHash -erroraction 'silentlycontinue' | export-csv -Path wineventlog/Executaveis-exe.csv -Delimiter ';' -NoTypeInformation | Import-Csv -Path wineventlog/Executaveis-exe.csv
}
catch
{
echo "couldn't generate the hashes for files *.exe"
}

try{
echo "Extracting TaskScheduler Logs"
Get-WinEvent -LogName Microsoft-Windows-TaskScheduler/Operational -erroraction 'silentlycontinue' | export-csv -Path wineventlog/TaskScheduler.csv -Delimiter ';' -NoTypeInformation | Import-Csv -Path wineventlog/TaskScheduler.csv
}
catch 
{
echo "Can't retrieve Microsoft-Windows-TaskScheduler/Operational Logs"
}

try
{
echo "Generating hashes for files"
Get-Childitem -path "wineventlog" -recurse | Get-FileHash -erroraction 'silentlycontinue' | export-csv -Path wineventlog/hashes.csv -Delimiter ';' -NoTypeInformation | Import-Csv -Path wineventlog/hashes.csv
}
catch
{
echo "couldn't generate the hashes for files"
}


try
{
echo "Compressing All Generated Files"
Compress-Archive -Path wineventlog -DestinationPath ./logs.zip
}
catch
{
echo "couldn't compress the the log folder "
}

echo "End"

#by Geovane.oliveira

 
#Extração de Usuarios do Azure AD
#try
#{
#echo "Extracting AzureADs"
#Get-AzureADUser  -path "wineventlog" -recurse -erroraction 'silentlycontinue' | export-csv -Path wineventlog/AzureAdUser.csv -Delimiter ';' -NoTypeInformation | Import-Csv -Path wineventlog/AzureAdUser.csv
#}
#catch
#{
#echo "couldn't retrieve AzureAD"
#}
