# Informations sur le CPU
$cpuInfo = Get-WmiObject -Class Win32_Processor | Select-Object Name

# Informations sur le GPU
$gpuInfo = Get-WmiObject -Class Win32_VideoController | Select-Object Name

# Informations sur la RAM et sa vitesse
$ramInfo = Get-WmiObject -Class Win32_PhysicalMemory | Measure-Object -Property Capacity -Sum | Select-Object @{Name="Total RAM (Go)";Expression={$_.Sum / 1GB}},@{Name="Vitesse RAM (MHz)";Expression={(Get-WmiObject -Class Win32_PhysicalMemory | Select-Object -First 1).Speed}}

# Informations sur la carte mère et le BIOS
$motherboardInfo = Get-WmiObject -Class Win32_BaseBoard | Select-Object Product
$biosInfo = Get-WmiObject -Class Win32_BIOS | Select-Object Version

# Informations sur l'OS
$osInfo = Get-WmiObject -Class Win32_OperatingSystem | Select-Object Caption, Version

# Informations sur les disques durs
$hddInfo = Get-WmiObject -Class Win32_DiskDrive | Select-Object Model, Size

# Afficher les informations
Write-Host "Configuration matérielle :"
Write-Host "------------------------"
Write-Host "CPU : $($cpuInfo.Name)"
Write-Host "GPU : $($gpuInfo.Name)"
Write-Host "RAM totale et Vitesse de la RAM : $($ramInfo.'Total RAM (Go)') Go - $($ramInfo.'Vitesse RAM (MHz)') MHz"
Write-Host "Système d'exploitation : $($osInfo.Caption) $($osInfo.Version)"
Write-Host "Carte mère et Version du BIOS : $($motherboardInfo.Product) - BIOS $($biosInfo.Version)"
Write-Host "Disques durs :"
$hddInfo | ForEach-Object { Write-Host "  - $($_.Model) - Taille : $($_.Size / 1GB) Go" }
