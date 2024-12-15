[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$MobaUser = "AlekseyK"

$packages = @(
    "XPFCFKCNNTXGQD",          #Yandex Browser
    "XPDM1ZW6815MQM",          #VLC
    "9N0DX20HK701",            #Terminal
    "Docker.DockerDesktop",
    "Adobe.Acrobat.Reader.64-bit",
    "Notepad++.Notepad++",     
    "Skillbrains.Lightshot",    
    "Telegram.TelegramDesktop",
    "7zip.7zip",
    "Mobatek.MobaXterm",
    "Valve.Steam",
    "Discord.Discord",
    "Git.Git",
    "CrystalIDEASoftware.UninstallTool",
    "Logitech.GHUB",
    "qBittorrent.qBittorrent"
)

foreach ($package in $packages) {
    Write-Host "Установка пакета: $package"
    winget install --id $package --exact --accept-source-agreements --accept-package-agreements --ignore-security-hash
    if ($LASTEXITCODE -eq 0) {
        Write-Host "Пакет $package успешно установлен."
    } else {
        Write-Host "Ошибка при установке пакета $package."
    }
}
Write-Host "Установка завершена."

Write-Host "--------------------"
Write-Host "Активация Uninstall Tool"
Invoke-WebRequest -Uri "https://disk.yandex.ru/d/cD4xs8DVL_Hvpw" -OutFile msimg32.dll
Start-Process powershell -Verb RunAs -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command `"Move-Item '$PSScriptRoot\msimg32.dll' '${env:ProgramFiles}\Uninstall Tool\' -force`""
Write-Host "--------------------"

Write-Host "Активация MobaXtern"
$MobaPath = "C:\Program Files (x86)\Mobatek\MobaXterm"
$MobaVersion = Get-Content -Path "$MobaPath\version.dat" -TotalCount 1
$url = "https://mobaxterm.tanst.net/gen?name=$MobaUser&ver=$MobaVersion"
Invoke-WebRequest -Uri $url -OutFile Custom.mxtpro
Start-Process powershell -Verb RunAs -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command `"Move-Item '$PSScriptRoot\Custom.mxtpro' '${env:MobaPath}\Custom.mxtpro'`""

Write-Host "--------------------"
Write-Host "Установка Visual Studio Code..."
winget install --id Microsoft.VisualStudioCode --exact --silent --accept-source-agreements --accept-package-agreements
$vscodePath = "$env:LOCALAPPDATA\Programs\Microsoft VS Code\bin\code.cmd"
Write-Host "--------------------"

$extensions = @(
    "davidanson.vscode-markdownlint",
    "donjayamanne.githistory",
    "mechatroner.rainbow-csv",
    "ms-azuretools.vscode-docker",
    "ms-ceintl.vscode-language-pack-ru",
    "ms-python.debugpy",
    "ms-python.python",
    "ms-python.vscode-pylance",
    "ms-vscode-remote.remote-ssh",
    "ms-vscode-remote.remote-ssh-edit",
    "ms-vscode-remote.remote-wsl",
    "ms-vscode.powershell",
    "ms-vscode.remote-explorer",
    "rogalmic.bash-debug",
    "tlevesque2.duplicate-finder",
    "gitlab.gitlab-workflow",
    "ms-vscode.makefile-tools",
    "shd101wyy.markdown-preview-enhanced"
)

Write-Host "Установка расширений Visual Studio Code..."
foreach ($extension in $extensions) {
    Write-Host "Установка расширения: $extension"
    Start-Process -FilePath $vscodePath -ArgumentList "--install-extension $extension" -NoNewWindow -Wait
    if ($LASTEXITCODE -eq 0) {
        Write-Host "Ошибка при установке расширения $extension."
    } else {
        Write-Host "Расширение $extension успешно установлено."
    }
}
Write-Host "--------------------"
Write-Host "Активация MS"
irm https://get.activated.win | iex
Write-Host "--------------------"