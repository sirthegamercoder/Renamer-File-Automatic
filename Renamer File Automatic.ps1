function Rename-FilesInSubfolders {
    $folderPath = Read-Host "Enter the folder path"

    if (-not (Test-Path $folderPath)) {
        Write-Host "Error: The specified folder path does not exist." -ForegroundColor Red
        return
    }

    $subfolders = Get-ChildItem -Path $folderPath -Directory
    
    if ($subfolders.Count -eq 0) {
        Write-Host "No subfolders found in the specified path." -ForegroundColor Yellow
        return
    }
    
    Write-Host "Found $($subfolders.Count) subfolder(s) in the specified path." -ForegroundColor Green

    foreach ($subfolder in $subfolders) {
        Write-Host "`n--- Processing subfolder: $($subfolder.Name) ---" -ForegroundColor Cyan

        $files = Get-ChildItem -Path $subfolder.FullName -File
        Write-Host "Files in this subfolder: $($files.Count)" -ForegroundColor Yellow
        
        if ($files.Count -eq 0) {
            Write-Host "No files found in this subfolder. Skipping..." -ForegroundColor Yellow
            continue
        }

        Write-Host "Current files:" -ForegroundColor Gray
        $files | ForEach-Object { Write-Host "  - $($_.Name)" -ForegroundColor Gray }

        $baseName = Read-Host "`nEnter the base name for files in this subfolder"
        
        if ([string]::IsNullOrWhiteSpace($baseName)) {
            Write-Host "No name entered. Skipping this subfolder..." -ForegroundColor Yellow
            continue
        }

        $counter = 1
        $renamedCount = 0
        
        foreach ($file in $files) {
            $sequenceNumber = $counter.ToString("0000")

            $newName = "${baseName}${sequenceNumber}$($file.Extension)"
            $newPath = Join-Path -Path $subfolder.FullName -ChildPath $newName
            
            try {
                Rename-Item -Path $file.FullName -NewName $newName -ErrorAction Stop
                Write-Host "Renamed: '$($file.Name)' -> '$newName'" -ForegroundColor Green
                $renamedCount++
            }
            catch {
                Write-Host "Error renaming '$($file.Name)': $($_.Exception.Message)" -ForegroundColor Red
            }
            
            $counter++
        }
        
        Write-Host "Successfully renamed $renamedCount files in subfolder: $($subfolder.Name)" -ForegroundColor Green

        if ($subfolder -ne $subfolders[-1]) {
            $continue = Read-Host "`nPress Enter to continue to next subfolder or type 'exit' to quit"
            if ($continue -eq 'exit') {
                Write-Host "Script terminated by user." -ForegroundColor Yellow
                return
            }
        }
    }
    
    Write-Host "`nAll subfolders have been processed!" -ForegroundColor Green
}

Rename-FilesInSubfolders

Write-Host "`nScript execution completed." -ForegroundColor Cyan
