# sif-docker
Docker base images with Sitecore Install Framework pre-installed.

[![Build status](https://ci.appveyor.com/api/projects/status/hh7np2noye9eo4vd?svg=true)](https://ci.appveyor.com/project/Brad-Christie/sif-docker)

## Example

```
# escape=`
FROM bchsitecore/sitecoreinstallframework:latest-windowsservercore-ltsc2016
SHELL ["powershell.exe","-Command","$ErrorActionPreference='Stop';$ProgressPreference='SilentlyContinue';"]

COPY ./config.json .
RUN Install-SitecoreConfiguration .\config.json *>&1 | Tee-Object .\config.log ; `
    Remove-Item .\config.json
```

## Available Tags

| Tag Name                            | SIF Version | Contaienr Base                                |
|-------------------------------------|-------------|-----------------------------------------------|
| latest-windowsservercore-ltsc2019   | 2.1.0       | mcr.microsoft.com/windows/servercore:ltsc2019 |
| latest-windowsservercore-ltsc2016   | 2.1.0       | mcr.microsoft.com/windows/servercore:ltsc2016 |
| 2.1.0-windowsservercore-ltsc2019    | 2.1.0       | mcr.microsoft.com/windows/servercore:ltsc2019 |
| 2.1.0-windowsservercore-ltsc2016    | 2.1.0       | mcr.microsoft.com/windows/servercore:ltsc2016 |
| 2-windowsservercore-ltsc2019        | 2.1.0       | mcr.microsoft.com/windows/servercore:ltsc2019 |
| 2-windowsservercore-ltsc2016        | 2.1.0       | mcr.microsoft.com/windows/servercore:ltsc2016 |
| 2.0.0-windowsservercore-ltsc2019    | 2.0.0       | mcr.microsoft.com/windows/servercore:ltsc2019 |
| 2.0.0-windowsservercore-ltsc2016    | 2.0.0       | mcr.microsoft.com/windows/servercore:ltsc2016 |