$Scripts = Get-ChildItem "$PSScriptROot\Commands" -Filter '*.ps1'
Foreach($script in $scripts){
    . $script.FullName
}

$ModuleFolder = Get-Item $PSScriptRoot

$Script:VariableFolder = "$($ModuleFolder.Parent.Parent.Parent.FullName)\Assets\Variables"

$Script:VariableNames = (Get-ChildItem $VariableFolder -Filter '*.json').BaseName

Export-ModuleMember -Function $Scripts.BaseName