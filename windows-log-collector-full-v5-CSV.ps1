echo "---------------------------------------------------"
echo "windows-log-collector-full-v5-2024..."
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
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
}
catch
{
echo "could not set permission"
}

try{
echo "creating a new directory"
New-Item -ItemType "directory" -Path ".\wineventlog" -Force
}
catch
{
echo "can't create a new directory"
Write-Output $_.Exception.Message
}

try{
echo "Extracting WMI"
Get-Process -Name WmiPrvSE -ErrorAction SilentlyContinue | Select-Object -Property BasePriority,Id,SessionId,WorkingSet | Export-Csv -Path .\wineventlog\WmiData.csv -Delimiter ';' -NoTypeInformation
}
catch 
{
echo "Can't retrieve WMI"
Write-Output $_.Exception.Message
}
try {
    echo "Extracting Registry"
    Get-PSDrive | Export-Csv -Path .\wineventlog\Registry.csv -Delimiter ';' -NoTypeInformation
}
catch 
{
echo "Can't retrieve Registry"
Write-Output $_.Exception.Message
}

try{
echo "Extracting History Powershell"
Get-History | Export-Csv -Path .\wineventlog\History.csv -Delimiter ';' -NoTypeInformation
}
catch 
{
echo "Can't retrieve History Powershell"
Write-Output $_.Exception.Message
}

try{
echo "Extracting Process"
Get-Process -ErrorAction SilentlyContinue | Export-Csv -Path .\wineventlog\Processes.csv -Delimiter ';' -NoTypeInformation
}
catch 
{
echo "Can't retrieve Process"
Write-Output $_.Exception.Message
}

try{
echo "Extracting Registry"
Get-PSDrive | Export-Csv -Path .\wineventlog\Registry.csv -Delimiter ';' -NoTypeInformation
}
catch 
{
echo "Can't retrieve Registry"
Write-Output $_.Exception.Message
}

try{
echo "Extracting Setup Logs"
Get-WinEvent -LogName setup -ErrorAction SilentlyContinue | Export-Csv -Path .\wineventlog\Setup.csv -Delimiter ';' -NoTypeInformation
}
catch 
{
echo "Can't retrieve Setup Logs"
Write-Output $_.Exception.Message
}

try{
echo "Extracting Security Logs"
Get-EventLog -LogName Security -ErrorAction SilentlyContinue | Export-Csv -Path .\wineventlog\Security.csv -Delimiter ';' -NoTypeInformation
}
catch 
{
echo "Can't retrieve Security Logs"
Write-Output $_.Exception.Message
}
try
{
echo "Extracting System Logs"
Get-WinEvent -LogName System -ErrorAction SilentlyContinue | Export-Csv -Path .\wineventlog\System.csv -Delimiter ';' -NoTypeInformation
}
catch 
{
echo "Can't retrieve System Logs"
Write-Output $_.Exception.Message
}

try{
echo "Extracting Application Logs"
Get-WinEvent -LogName Application -ErrorAction SilentlyContinue | Export-Csv -Path .\wineventlog\Application.csv -Delimiter ';' -NoTypeInformation
}
catch 
{
echo "Can't retrieve Application Logs"
Write-Output $_.Exception.Message
}

try{
echo "Extracting Windows PowerShell Logs"
Get-WinEvent -LogName "Windows PowerShell" -ErrorAction SilentlyContinue | Export-Csv -Path .\wineventlog\Windows_PowerShell.csv -Delimiter ';' -NoTypeInformation
}
catch 
{
echo "Can't retrieve Windows PowerShell Logs"
Write-Output $_.Exception.Message
}

try{
echo "Extracting TerminalServices LocalSessionManager Logs"
Get-WinEvent -LogName "Microsoft-Windows-TerminalServices-LocalSessionManager/Operational" -ErrorAction SilentlyContinue | Export-Csv -Path .\wineventlog\LocalSessionManager.csv -Delimiter ';' -NoTypeInformation
}
catch 
{
echo "Can't retrieve Microsoft-Windows-TerminalServices-LocalSessionManager/Operational Logs"
Write-Output $_.Exception.Message
}

try{
echo "Extracting Windows Defender Logs"
Get-WinEvent -LogName "Microsoft-Windows-Windows Defender/Operational" -ErrorAction SilentlyContinue | Export-Csv -Path .\wineventlog\Windows_Defender.csv -Delimiter ';' -NoTypeInformation
}
catch 
{
echo "Can't retrieve Microsoft-Windows-Windows Defender/Operational Logs"
Write-Output $_.Exception.Message
}

try{
echo "Extracting WinRM Logs"
Get-WinEvent -LogName Microsoft-Windows-WinRM/Operational -ErrorAction SilentlyContinue | Export-Csv -Path .\wineventlog\WinRM.csv -Delimiter ';' -NoTypeInformation
}
catch 
{
echo "Can't retrieve Microsoft-Windows-WinRM/Operational Logs"
Write-Output $_.Exception.Message
}

try{
echo "Extracting PowerShell Logs"
Get-WinEvent -LogName Microsoft-Windows-PowerShell/Operational -ErrorAction SilentlyContinue | Export-Csv -Path .\wineventlog\Powershell_Operational.csv -Delimiter ';' -NoTypeInformation
}
catch 
{
echo "Can't retrieve Microsoft-Windows-PowerShell/Operational Logs"
Write-Output $_.Exception.Message
}

try{
echo "Extracting Sysmon Logs"
Get-WinEvent -LogName Microsoft-Windows-Sysmon/Operational -ErrorAction SilentlyContinue | Export-Csv -Path .\wineventlog\Sysmon.csv -Delimiter ';' -NoTypeInformation
}
catch 
{
echo "Can't retrieve Microsoft-Windows-Sysmon/Operational Logs"
Write-Output $_.Exception.Message
}

try
{
echo "Generating hashes for files *.exe"
Get-Childitem -path "C:\*.exe" -recurse -Filter *.exe -ErrorAction SilentlyContinue | Get-FileHash -ErrorAction SilentlyContinue | Export-Csv -Path .\wineventlog\Executaveis-exe.csv -Delimiter ';' -NoTypeInformation
}
catch
{
echo "couldn't generate the hashes for files *.exe"
Write-Output $_.Exception.Message
}

try{
echo "Extracting TaskScheduler Logs"
Get-WinEvent -LogName Microsoft-Windows-TaskScheduler/Operational -ErrorAction SilentlyContinue | Export-Csv -Path .\wineventlog\TaskScheduler.csv -Delimiter ';' -NoTypeInformation
}
catch 
{
echo "Can't retrieve Microsoft-Windows-TaskScheduler/Operational Logs"
Write-Output $_.Exception.Message
}

try
{
echo "Generating hashes for files"
Get-Childitem -path ".\wineventlog" -recurse | Get-FileHash -ErrorAction SilentlyContinue | Export-Csv -Path .\wineventlog\hashes.csv -Delimiter ';' -NoTypeInformation
}
catch
{
echo "couldn't generate the hashes for files"
Write-Output $_.Exception.Message
}

try
{
echo "Compressing All Generated Files"
Compress-Archive -Path .\wineventlog\* -DestinationPath .\logs.zip
}
catch
{
echo "couldn't compress the the log folder "
}

echo "End"


#by Geovane.oliveira

