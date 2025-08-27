# PowerShell script to update all HTML files from San Jose, CA to San Pedro, TX
# and maintain ductless mini split category

# Define replacement mappings
$replacements = @(
    @{old = "San Jose"; new = "San Pedro"},
    @{old = "San Jose's"; new = "San Pedro's"},
    @{old = ", CA"; new = ", TX"},
    @{old = " CA "; new = " TX "},
    @{old = "California"; new = "Texas"},
    @{old = "South Bay"; new = "Rio Grande Valley"},
    @{old = "Santa Clara County"; new = "Hidalgo County"},
    @{old = "Mediterranean climate"; new = "subtropical climate"},
    @{old = "Santa Clara"; new = "McAllen"},
    @{old = "Sunnyvale"; new = "Brownsville"},
    @{old = "Milpitas"; new = "Harlingen"},
    @{old = "Campbell"; new = "Edinburg"},
    @{old = "Cupertino"; new = "Mission"},
    @{old = "Fremont"; new = "Pharr"},
    @{old = "Mountain View"; new = "Weslaco"},
    @{old = "Palo Alto"; new = "Mercedes"},
    @{old = "Union City"; new = "Rio Grande City"},
    @{old = "Hayward"; new = "Roma"},
    @{old = "95110"; new = "78559"},
    @{old = "sanjoseminisplits.com"; new = "sanpedrominisplits.com"},
    @{old = "1500 Technology Dr"; new = "1200 W Main St"},
    @{old = "37.3382"; new = "26.3167"},
    @{old = "-121.8863"; new = "-98.1833"},
    @{old = "37.4032"; new = "26.2034"},
    @{old = "-121.9776"; new = "-98.2300"},
    @{old = "3900 Freedom Cir"; new = "2000 N 10th St"},
    @{old = "95054"; new = "78501"},
    @{old = "John Smith"; new = "Jennifer Martinez"},
    @{old = "Maria Rodriguez"; new = "Carlos Rodriguez"},
    @{old = "Sarah Johnson"; new = "Ana Gonzalez"},
    @{old = "Mike Chen"; new = "Roberto Silva"},
    @{old = "hot summers or mild winters"; new = "hot, humid summers and mild winters"},
    @{old = "hot summers and mild winters"; new = "hot, humid summers and mild winters"},
    @{old = "seasonal pollen, dust, and urban air pollution"; new = "intense heat, humidity, dust, and occasional severe weather"},
    @{old = "tech campus buildings"; new = "modern commercial buildings"},
    @{old = "Victorian homes"; new = "historic adobe homes"},
    @{old = "Levi's Stadium"; new = "downtown San Pedro"},
    @{old = "Santa Clara University"; new = "the schools"},
    @{old = "Central Park"; new = "downtown area"},
    @{old = "Great America Parkway"; new = "the commercial zones"},
    @{old = "San Jose International Airport"; new = "the border"}
)

# Get all HTML files
$htmlFiles = Get-ChildItem -Path "." -Recurse -Include "*.html"

Write-Host "Found $($htmlFiles.Count) HTML files to update..."

foreach ($file in $htmlFiles) {
    Write-Host "Processing: $($file.Name)"
    
    try {
        # Read the file content
        $content = Get-Content $file.FullName -Raw -Encoding UTF8
        
        # Apply all replacements
        foreach ($replacement in $replacements) {
            $content = $content -replace [regex]::Escape($replacement.old), $replacement.new
        }
        
        # Write the updated content back to the file
        Set-Content -Path $file.FullName -Value $content -Encoding UTF8
        
        Write-Host "Updated: $($file.Name)" -ForegroundColor Green
    }
    catch {
        Write-Host "Error processing $($file.Name): $($_.Exception.Message)" -ForegroundColor Red
    }
}

Write-Host "Content update completed!" -ForegroundColor Yellow
