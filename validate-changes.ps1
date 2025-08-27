# Validation Script - Check for remaining San Jose references
Write-Host "=== CONTENT VALIDATION REPORT ===" -ForegroundColor Yellow
Write-Host ""

# Check for any remaining San Jose references
$oldReferences = @()
$htmlFiles = Get-ChildItem -Path "." -Recurse -Include "*.html"

foreach ($file in $htmlFiles) {
    $content = Get-Content $file.FullName -Raw
    
    # Check for old location references
    if ($content -match "San Jose|Santa Clara|Sunnyvale|Milpitas|Campbell|Cupertino|Fremont|Mountain View|Palo Alto") {
        $oldReferences += "Found old location reference in: $($file.Name)"
    }
    
    # Check for old state references  
    if ($content -match " CA |California" -and $content -notmatch "Call") {
        $oldReferences += "Found CA/California reference in: $($file.Name)"
    }
}

if ($oldReferences.Count -eq 0) {
    Write-Host "✅ SUCCESS: No old location references found!" -ForegroundColor Green
} else {
    Write-Host "⚠️  WARNINGS: Found potential old references:" -ForegroundColor Yellow
    foreach ($ref in $oldReferences) {
        Write-Host "   $ref" -ForegroundColor Red
    }
}

Write-Host ""
Write-Host "=== SAMPLE CONTENT VERIFICATION ===" -ForegroundColor Yellow

# Check key elements in index.html
$indexContent = Get-Content "index.html" -Raw

Write-Host "Title contains 'San Pedro TX':" -NoNewline
if ($indexContent -match "San Pedro TX") {
    Write-Host " ✅ YES" -ForegroundColor Green
} else {
    Write-Host " ❌ NO" -ForegroundColor Red
}

Write-Host "Description mentions 'San Pedro, TX':" -NoNewline  
if ($indexContent -match "San Pedro, TX") {
    Write-Host " ✅ YES" -ForegroundColor Green
} else {
    Write-Host " ❌ NO" -ForegroundColor Red
}

Write-Host "Content mentions 'Rio Grande Valley':" -NoNewline
if ($indexContent -match "Rio Grande Valley") {
    Write-Host " ✅ YES" -ForegroundColor Green  
} else {
    Write-Host " ❌ NO" -ForegroundColor Red
}

Write-Host "Content mentions 'Texas':" -NoNewline
if ($indexContent -match "Texas") {
    Write-Host " ✅ YES" -ForegroundColor Green
} else {
    Write-Host " ❌ NO" -ForegroundColor Red
}

Write-Host ""
Write-Host "=== FILE COUNT VERIFICATION ===" -ForegroundColor Yellow
Write-Host "Total HTML files: $($htmlFiles.Count)"
Write-Host "Location files: $($(Get-ChildItem locations/*.html).Count)"  
Write-Host "Service files: $($(Get-ChildItem services/*.html).Count)"
Write-Host ""
Write-Host "Validation completed!" -ForegroundColor Green
