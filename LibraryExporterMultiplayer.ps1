function global:ExportLibraryMultiplayer()
{
    $path = $PlayniteApi.Dialogs.SaveFile("CSV|*.csv|Formated TXT|*.txt")
    if ($path)
    {
        if ($path -match ".csv$")
        {
            $PlayniteApi.Database.Games | Where-Object {$_.Features.name -contains "Multiplayer"} | Select Name, Source, ReleaseDate, Playtime, IsInstalled | ConvertTo-Csv | Out-File $path -Encoding utf8
        }
        else
        {           
            $PlayniteApi.Database.Games | Where-Object {$_.Features.name -contains "Multiplayer"} | Select Name, Source, ReleaseDate, Playtime, IsInstalled | Format-Table -AutoSize | Out-File $path -Encoding utf8
        }
        
        $PlayniteApi.Dialogs.ShowMessage("Library exported successfully.");
    }
}

function global:GetMainMenuItems()
{
    param(
        $menuArgs
    )

    $menuItem = New-Object Playnite.SDK.Plugins.ScriptMainMenuItem
    $menuItem.Description = "Export Library Multiplayer"
    $menuItem.FunctionName = "ExportLibraryMultiplayer"
    $menuItem.MenuSection = "@"
    return $menuItem
}