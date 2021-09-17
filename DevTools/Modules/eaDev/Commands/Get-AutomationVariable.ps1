Function Get-AutomationVariable {
    Param(
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [ArgumentCompleter({
            Param($CommandName, $ParameterName, $WordToComplete, $CommandAst, $FakeBoundParameter)
            
            $VariableNames = ( Get-Module eaDev ).Invoke( { $Script:VariableNames } )
            foreach($instance in $VariableNames){
                if($instance -like "$($WordToComplete)*"){
                    New-Object System.Management.Automation.CompletionResult (
                        $instance,
                        $instance,
                        "ParameterValue",
                        $instance
                    )
                }
            }
        })]
        [string]$Name
    )
    begin{
        $AutomationEnvironment = Get-AutomationEnvironment

        $VariableFilePath = "$Script:VariableFolder\$Name.json"
        
    }
    process{
        if(Test-Path $VariableFilePath){
            $VariableHash = Get-Content $VariableFilePath | ConvertFrom-Json
            return $VariableHash."$($AutomationEnvironment)"
        }
        else{
            throw "Could not find the variable file $("$Script:VariableFolder\$Name.json")"
            return
        }
    }
    end{

    }
}
