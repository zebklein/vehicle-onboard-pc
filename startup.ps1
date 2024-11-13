##### PowerShell Settings #####

##### System Info #####

# Hardware and OS Information Script with Irregular Loading Simulation

# Function to simulate loading with irregular delays
function Show-Loading {
    param (
        [string]$message
    )
    
    Write-Host "$message" -ForegroundColor Yellow
    # Simulate a loading bar
    $barLength = 30
    for ($i = 0; $i -le $barLength; $i++) {
        $progress = [math]::Round(($i / $barLength) * 100)
        $progressBar = ('#' * $i) + ('-' * ($barLength - $i))
        Write-Host "`r[$progressBar] $progress% Complete" -NoNewline
        
        # Random delay between 50ms and 200ms
        Start-Sleep -Milliseconds (Get-Random -Minimum 1 -Maximum 50)
    }
    Write-Host "`n"  # Move to the next line
}

# Function to display system information
function Show-SystemInfo {
    # Get OS Information
    Show-Loading -message "Retrieving Operating System Information..."
    $os = Get-CimInstance Win32_OperatingSystem
    Write-Host "=== Operating System Information ===" -ForegroundColor Cyan
    Write-Host "Caption: $($os.Caption)"
    Write-Host "Version: $($os.Version)"
    Write-Host "Build Number: $($os.BuildNumber)"
    Write-Host "Architecture: $($os.OSArchitecture)"
    Write-Host "Manufacturer: $($os.Manufacturer)"
    Write-Host "Install Date: $(($os.InstallDate))"
    Write-Host "Last Boot Up Time: $(($os.LastBootUpTime))"
    Write-Host ""

    # Get Processor Information
    Show-Loading -message "Retrieving Processor Information..."
    $cpu = Get-CimInstance Win32_Processor
    Write-Host "=== Processor Information ===" -ForegroundColor Cyan
    foreach ($processor in $cpu) {
        Write-Host "Name: $($processor.Name)"
        Write-Host "Cores: $($processor.NumberOfCores)"
        Write-Host "Logical Processors: $($processor.NumberOfLogicalProcessors)"
        Write-Host "Manufacturer: $($processor.Manufacturer)"
        Write-Host "Max Clock Speed: $($processor.MaxClockSpeed) MHz"
        Write-Host ""
    }

    # Get Memory Information
    Show-Loading -message "Retrieving Memory Information..."
    $memory = Get-CimInstance Win32_PhysicalMemory
    $totalMemory = 0
    Write-Host "=== Memory Information ===" -ForegroundColor Cyan
    foreach ($mem in $memory) {
        $totalMemory += $mem.Capacity
        Write-Host "Module: $($mem.DeviceID)"
        Write-Host "Capacity: $([math]::round($mem.Capacity / 1GB, 2)) GB"
        Write-Host "Speed: $($mem.Speed) MHz"
        Write-Host "Manufacturer: $($mem.Manufacturer)"
        Write-Host ""
    }
    Write-Host "Total Installed Memory: $([math]::round($totalMemory / 1GB, 2)) GB"
    Write-Host ""

    # Get Disk Information
    Show-Loading -message "Retrieving Disk Information..."
    $disks = Get-CimInstance Win32_LogicalDisk -Filter "DriveType=3"
    Write-Host "=== Disk Information ===" -ForegroundColor Cyan
    foreach ($disk in $disks) {
        Write-Host "Device ID: $($disk.DeviceID)"
        Write-Host "Volume Name: $($disk.VolumeName)"
        Write-Host "File System: $($disk.FileSystem)"
        Write-Host "Size: $([math]::round($disk.Size / 1GB, 2)) GB"
        Write-Host "Free Space: $([math]::round($disk.FreeSpace / 1GB, 2)) GB"
        Write-Host ""
    }

    # Get Graphics Information
    Show-Loading -message "Retrieving Graphics Information..."
    $graphics = Get-CimInstance Win32_VideoController
    Write-Host "=== Graphics Information ===" -ForegroundColor Cyan
    foreach ($gpu in $graphics) {
        Write-Host "Name: $($gpu.Name)"
        Write-Host "Adapter RAM: $([math]::round($gpu.AdapterRAM / 1MB, 2)) MB"
        Write-Host "Driver Version: $($gpu.DriverVersion)"
        Write-Host ""
    }

    # Get Network Adapter Information
    Show-Loading -message "Retrieving Network Adapter Information..."
    $networkAdapters = Get-CimInstance Win32_NetworkAdapter | Where-Object { $_.PhysicalAdapter -eq $true }
    Write-Host "=== Network Adapter Information ===" -ForegroundColor Cyan
    foreach ($adapter in $networkAdapters) {
        Write-Host "Name: $($adapter.Name)"
        Write-Host "MAC Address: $($adapter.MACAddress)"
        Write-Host "Status: $($adapter.NetConnectionStatus)"
        Write-Host ""
    }

    Write-Host "=== System Status: Good ===" -ForegroundColor Green
    Write-Host ""
    Write-Host "NOTICE: The Windows Update Service on this machine has been disabled. To reenable this, please do so in services.msc" -ForegroundColor DarkYellow
    Start-Sleep -Milliseconds 2000
}

# Call the function to display information
# Show-SystemInfo



##### App Selector #####

# Title printer
# Prints the following ASCII art:
# ██████╗  █████╗      ██╗███████╗██████╗  ██████╗ 
# ██╔══██╗██╔══██╗     ██║██╔════╝██╔══██╗██╔═══██╗
# ██████╔╝███████║     ██║█████╗  ██████╔╝██║   ██║
# ██╔═══╝ ██╔══██║██   ██║██╔══╝  ██╔══██╗██║   ██║
# ██║     ██║  ██║╚█████╔╝███████╗██║  ██║╚██████╔╝
# ╚═╝     ╚═╝  ╚═╝ ╚════╝ ╚══════╝╚═╝  ╚═╝ ╚═════╝ 

function Write-AsciiTitle {
    $title = @"
$([char]0x2588)$([char]0x2588)$([char]0x2588)$([char]0x2588)$([char]0x2588)$([char]0x2588)$([char]0x2557)  $([char]0x2588)$([char]0x2588)$([char]0x2588)$([char]0x2588)$([char]0x2588)$([char]0x2557)      $([char]0x2588)$([char]0x2588)$([char]0x2557)$([char]0x2588)$([char]0x2588)$([char]0x2588)$([char]0x2588)$([char]0x2588)$([char]0x2588)$([char]0x2588)$([char]0x2557)$([char]0x2588)$([char]0x2588)$([char]0x2588)$([char]0x2588)$([char]0x2588)$([char]0x2588)$([char]0x2557)  $([char]0x2588)$([char]0x2588)$([char]0x2588)$([char]0x2588)$([char]0x2588)$([char]0x2588)$([char]0x2557)
$([char]0x2588)$([char]0x2588)$([char]0x2554)$([char]0x2550)$([char]0x2550)$([char]0x2588)$([char]0x2588)$([char]0x2557)$([char]0x2588)$([char]0x2588)$([char]0x2554)$([char]0x2550)$([char]0x2550)$([char]0x2588)$([char]0x2588)$([char]0x2557)     $([char]0x2588)$([char]0x2588)$([char]0x2551)$([char]0x2588)$([char]0x2588)$([char]0x2554)$([char]0x2550)$([char]0x2550)$([char]0x2550)$([char]0x2550)$([char]0x255D)$([char]0x2588)$([char]0x2588)$([char]0x2554)$([char]0x2550)$([char]0x2550)$([char]0x2588)$([char]0x2588)$([char]0x2557)$([char]0x2588)$([char]0x2588)$([char]0x2554)$([char]0x2550)$([char]0x2550)$([char]0x2550)$([char]0x2588)$([char]0x2588)$([char]0x2557)
$([char]0x2588)$([char]0x2588)$([char]0x2588)$([char]0x2588)$([char]0x2588)$([char]0x2588)$([char]0x2554)$([char]0x255D)$([char]0x2588)$([char]0x2588)$([char]0x2588)$([char]0x2588)$([char]0x2588)$([char]0x2588)$([char]0x2588)$([char]0x2551)     $([char]0x2588)$([char]0x2588)$([char]0x2551)$([char]0x2588)$([char]0x2588)$([char]0x2588)$([char]0x2588)$([char]0x2588)$([char]0x2557)  $([char]0x2588)$([char]0x2588)$([char]0x2588)$([char]0x2588)$([char]0x2588)$([char]0x2588)$([char]0x2554)$([char]0x255D)$([char]0x2588)$([char]0x2588)$([char]0x2551)   $([char]0x2588)$([char]0x2588)$([char]0x2551)
$([char]0x2588)$([char]0x2588)$([char]0x2554)$([char]0x2550)$([char]0x2550)$([char]0x2550)$([char]0x255D) $([char]0x2588)$([char]0x2588)$([char]0x2554)$([char]0x2550)$([char]0x2550)$([char]0x2588)$([char]0x2588)$([char]0x2551)$([char]0x2588)$([char]0x2588)   $([char]0x2588)$([char]0x2588)$([char]0x2551)$([char]0x2588)$([char]0x2588)$([char]0x2554)$([char]0x2550)$([char]0x2550)$([char]0x255D)  $([char]0x2588)$([char]0x2588)$([char]0x2554)$([char]0x2550)$([char]0x2550)$([char]0x2588)$([char]0x2588)$([char]0x2557)$([char]0x2588)$([char]0x2588)$([char]0x2551)   $([char]0x2588)$([char]0x2588)$([char]0x2551)
$([char]0x2588)$([char]0x2588)$([char]0x2551)     $([char]0x2588)$([char]0x2588)$([char]0x2551)  $([char]0x2588)$([char]0x2588)$([char]0x2551)$([char]0x255A)$([char]0x2588)$([char]0x2588)$([char]0x2588)$([char]0x2588)$([char]0x2588)$([char]0x2554)$([char]0x255D)$([char]0x2588)$([char]0x2588)$([char]0x2588)$([char]0x2588)$([char]0x2588)$([char]0x2588)$([char]0x2588)$([char]0x2557)$([char]0x2588)$([char]0x2588)$([char]0x2551)  $([char]0x2588)$([char]0x2588)$([char]0x2551)$([char]0x255A)$([char]0x2588)$([char]0x2588)$([char]0x2588)$([char]0x2588)$([char]0x2588)$([char]0x2588)$([char]0x2554)$([char]0x255D)
$([char]0x255A)$([char]0x2550)$([char]0x255D)     $([char]0x255A)$([char]0x2550)$([char]0x255D)  $([char]0x255A)$([char]0x2550)$([char]0x255D) $([char]0x255A)$([char]0x2550)$([char]0x2550)$([char]0x2550)$([char]0x2550)$([char]0x255D) $([char]0x255A)$([char]0x2550)$([char]0x2550)$([char]0x2550)$([char]0x2550)$([char]0x2550)$([char]0x2550)$([char]0x255D)$([char]0x255A)$([char]0x2550)$([char]0x255D)  $([char]0x255A)$([char]0x2550)$([char]0x255D) $([char]0x255A)$([char]0x2550)$([char]0x2550)$([char]0x2550)$([char]0x2550)$([char]0x2550)$([char]0x255D) 
"@
    Write-Host $title -ForegroundColor Cyan
    
}

##### App Selector #####

# Open Microsoft Edge
function Open-Edge {
    Start-Process "msedge"
    Write-Host "Opening a browser"
    Start-Sleep -Milliseconds 2000
}

# Open Spotify
function Open-Spotify {
    Start-Process "C:\Users\zebkl\AppData\Roaming\Spotify\spotify.exe"
    Write-Host "Opening Spotify"
    Start-Sleep -Milliseconds 2000
}

# Get installed Steam games
function Get-SteamGames {
    $steamPath = "$env:ProgramFiles (x86)\Steam\steamapps\common"
    if (Test-Path $steamPath) {
        Get-ChildItem -Path $steamPath -Directory |
            Where-Object { $_.Name -ne "Steamworks Shared" } |
            Select-Object -ExpandProperty Name
    } else {
        Write-Host "Steam is not installed or the games folder was not found." -ForegroundColor Red
        return $null
    }
}

# Load a video
function Watch-Video {
    $videoPath = Join-Path -Path (Get-Location) -ChildPath "videos"
    
    if (Test-Path $videoPath) {
        while ($true) {
            # Get list of video files without extensions
            $videos = Get-ChildItem -Path $videoPath -File | ForEach-Object { $_.BaseName }

            if ($videos.Count -eq 0) {
                Write-Host "No videos found in the 'videos' folder." -ForegroundColor Yellow
                return
            }

            Write-Host "Available videos:" -ForegroundColor Yellow
            for ($i = 0; $i -lt $videos.Count; $i++) {
                Write-Host "$($i + 1). $($videos[$i])"
            }

            $videoSelection = Read-Host "Please enter the number of the video you want to watch (1-$($videos.Count)), or 'q' to return to the main menu"
            
            if ($videoSelection.ToLower() -eq 'q') {
                Write-Host "Returning to main menu..." -ForegroundColor Cyan
                break
            }
            
            if ($videoSelection -match '^\d+$' -and [int]$videoSelection -ge 1 -and [int]$videoSelection -le $videos.Count) {
                $selectedVideo = $videos[[int]$videoSelection - 1] + ".mp4"
                $videoFilePath = Join-Path -Path $videoPath -ChildPath $selectedVideo
                Start-Process -FilePath $videoFilePath
                Write-Host "Playing $selectedVideo"
                Start-Sleep -Milliseconds 2000
            } else {
                Write-Host "Invalid selection. Please enter a number between 1 and $($videos.Count), or 'q' to return to the main menu." -ForegroundColor Red
            }
        }
    } else {
        Write-Host "'videos' folder was not found." -ForegroundColor Red
    }
}

# Main
[System.Console]::Clear()
Write-AsciiTitle

Write-Host "Application Selector" -BackgroundColor Black -ForegroundColor Magenta
Write-Host "NOTICE: Some of these applications require a persistent connection to the internet. Navigate to the system settings to search for available connections" -ForegroundColor DarkYellow

while ($true) {
    # Prompt user for action
    $action = Read-Host "Please choose how to proceed: (b for browse, m for music, g for games, w for watch, q for quit)" 

    if ($action.ToLower() -eq "q") {
        Write-Host "Exiting the program. To restart, enter '.\startup.ps1'" -ForegroundColor Cyan
        break
    }

    switch ($action.ToLower()) {
        "b" {
            Open-Edge
        }
        "m" {
            Open-Spotify
        }
        "g" {
            $games = Get-SteamGames
            if ($games) {
                $steamGameIDs = @{ 
                    'BloonsTD5' = 306020
                    'BloonsTD6' = 960090
                    'Kingdom Rush Vengeance' = 1367550
                    'Plants vs Zombies' = 3590
                    'Spore' = 17390
                    'Half-Life' = 70
                }
                Write-Host "Available games:" -ForegroundColor Yellow
                for ($i = 0; $i -lt $games.Count; $i++) {
                    Write-Host "$($i + 1). $($games[$i])"
                }
                $gameSelection = Read-Host "Please enter the number of the game you want to play (1-$($games.Count))"
                if ($gameSelection -match '^\d+$' -and [int]$gameSelection -ge 1 -and [int]$gameSelection -le $games.Count) {
                    $selectedGame = $games[[int]$gameSelection - 1]
                    
                    # Check if the selected game exists in the steamGameIDs mapping
                    if ($steamGameIDs.ContainsKey($selectedGame)) {
                        $gameID = $steamGameIDs[$selectedGame]
                        $steamExePath = Join-Path -Path "$env:ProgramFiles (x86)\Steam" -ChildPath "steam.exe"
                        
                        # Start the game using the retrieved game ID
                        Start-Process -FilePath $steamExePath -ArgumentList "steam://rungameid/$gameID"
                        Write-Host "Opening $selectedGame"
                        Start-Sleep -Milliseconds 2000
                    } else {
                        Write-Host "The selected game is not valid." -ForegroundColor Red
                    }
                } else {
                    Write-Host "Invalid selection. Please enter a number between 1 and $($games.Count)." -ForegroundColor Red
                }
            }
        }
        "w" {
            Watch-Video
        }
        default {
            Write-Host "Invalid choice. Please enter 'b', 'm', 'g', 'w', or 'q'." -ForegroundColor Red
        }
    }
}
