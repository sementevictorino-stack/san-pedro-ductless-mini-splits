# PowerShell script to fix the TXlifornia issue
Write-Host "Fixing TXlifornia issues..." -ForegroundColor Yellow

# Get all HTML files
$htmlFiles = Get-ChildItem -Path "." -Recurse -Include "*.html"

foreach ($file in $htmlFiles) {
    try {
        # Read the file content
        $content = Get-Content $file.FullName -Raw -Encoding UTF8
        
        # Fix the TXlifornia issue
        $content = $content -replace "TXlifornia", "TX"
        
        # Write the updated content back to the file
        Set-Content -Path $file.FullName -Value $content -Encoding UTF8
        
        Write-Host "Fixed: $($file.Name)" -ForegroundColor Green
    }
    catch {
        Write-Host "Error processing $($file.Name): $($_.Exception.Message)" -ForegroundColor Red
    }
}

Write-Host "TXlifornia fixes completed!" -ForegroundColor Green
