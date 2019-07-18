[CmdletBinding()]
Param(
  [Parameter(Position = 0)]
  [ValidateNotNullOrEmpty()]
  [string]$Repository = "bchsitecore/sitecoreinstallframework"
)
Begin {
  $__eap = $ErrorActionPreference
  $ErrorActionPreference = "Stop"
}
Process {
  Function GetBuilds {
    [CmdletBinding()]
    Param()
    Begin {
      $BuildJson = Get-Content "${PSScriptRoot}\build.json" | ConvertFrom-Json
    }
    Process {
      $BuildJson.PSObject.Properties.Name | ForEach-Object {
        $tag = $_
        $target = $BuildJson.$tag
        $result = @{
          BuildArgs = @{}
          Labels = @{}
          Tags = @($tag)
        }

        If ($target.PSObject.Properties.Name -contains "AdditionalTags") {
          $result.Tags += @($target.AdditionalTags)
        }

        If ($target.PSObject.Properties.Name -contains "BuildArgs") {
          $buildArgs = $target.BuildArgs
          $buildArgs.PSObject.Properties.Name | ForEach-Object {
            $buildArgName = $_
            $buildArgValue = $buildArgs.$buildArgName
            $result.BuildArgs.Add($buildArgName, $buildArgValue)
          }
        }

        If ($target.PSObject.Properties.Name -contains "Labels") {
          $labels = $target.Labels
          $labels.PSObject.Properties.Name | ForEach-Object {
            $labelName = $_
            $labelValue = $labels.$labelName
            $result.Labels.Add($labelName, $labelValue)
          }
        }

        Return $result
      }
    }
  }

  Function BuildImage {
    [CmdletBinding()]
    Param(
      [Parameter(Position = 0, Mandatory, ValueFromPipeline)]
      [psobject]$Target
    )
    Process {
      $dockerArgs = @("build")
      $Target.Tags | ForEach-Object { $dockerArgs += @("--tag", "${Repository}:${_}") }
      $Target.BuildArgs.GetEnumerator() | ForEach-Object {
        $dockerArgs += @("--build-arg", "$($_.Key)=$($_.Value)")
      }
      $Target.Labels.GetEnumerator() | ForEach-Object {
        $dockerArgs += @("--label", "$($_.Key)=$($_.Value)")
      }
      $dockerArgs += @($PSScriptRoot)
      Try {
        & docker.exe $dockerArgs
        If ($LASTEXITCODE -eq 0) {
          $Target.Tags | ForEach-Object {
            & docker.exe push "${Repository}:${_}"
          }
        }
      } Catch {
        Write-Warning "$($Target.Tags -join ',') failed to build."
      }
    }
  }

  GetBuilds | BuildImage
}
End {
  $ErrorActionPreference = $__eap
}