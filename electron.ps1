$found = 0

$tempPath = "$env:windir\temp"
wget "https://download.sysinternals.com/files/Strings.zip" -outfile "$tempPath\strings.zip"
Expand-Archive "$tempPath\strings.zip" -DestinationPath $tempPath -Force

$Drives = Get-PSDrive -PSProvider 'FileSystem'


foreach($Drive in $Drives) {
    Get-ChildItem -Path $Drive.Root -Filter *.exe -Recurse -File -Force -ErrorAction SilentlyContinue | ForEach-Object {
        $path = $_.FullName
        Write-Progress -Activity "Searching for Electron apps vulnerable to CVE-2023-4863 / CVE-2023-5129" -CurrentOperation "$found apps found" -Status "Checking $path"
        $stringsOutput = ""
        $strings = $tempPath+"\strings.exe -n 11 -nobanner `"$path`" 2>nul"+' | findstr /l /c:"Electron v" 2>nul'
        $v = cmd.exe /c $strings | Tee-Object -Variable stringsOutput
        if($stringsOutput.Contains("Electron")) {
            $vuln = $false
            $patchedVersion = ""
            $detectedVersion = [version]($stringsOutput.Trim("Electron v"))
            switch ($detectedVersion.Major) {
                27 { if ($detectedVersion -lt [version]"27.0.0-beta.8") { $vuln = $true; $patchedVersion = "27.0.0-beta.8" } else { break } }
                26 { if ($detectedVersion -lt [version]"26.2.4") { $vuln = $true; $patchedVersion = "26.2.4" } else { break } }
                25 { if ($detectedVersion -lt [version]"25.8.4") { $vuln = $true; $patchedVersion = "25.8.4" } else { break } }
                24 { if ($detectedVersion -lt [version]"24.8.5") { $vuln = $true; $patchedVersion = "24.8.5" } else { break } }
                22 { if ($detectedVersion -lt [version]"22.3.25") { $vuln = $true; $patchedVersion = "22.3.25" } else { break } }
                Default {
                    if ($detectedVersion -lt [version]"26.2.4") { $vuln = $true; $patchedVersion = "26.2.4" } else { break }
                }
            }
            if ($vuln) {
                $found++
                "File: `"$path`" | Version: $stringsOutput | Patched Version: $patchedVersion"
            }
        }
    }
}