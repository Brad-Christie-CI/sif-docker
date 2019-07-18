# escape=`
ARG BASE=mcr.microsoft.com/windows/servercore:ltsc2019
FROM ${BASE}
SHELL ["powershell.exe", "-Command", "$ErrorActionPreferece='Stop';$ProgressPreference='SilentlyContinue';"]
ARG SIF_VERSION=2.1.0
RUN Install-PackageProvider -Name 'NuGet' -Force ; `
    Install-Module -Name 'PowerShellGet' -Force ; `
    Register-PSRepository 'SitecoreGallery' -SourceLocation 'https://sitecore.myget.org/F/sc-powershell/api/v2' -InstallationPolicy Trusted ; `
    Install-Module 'SitecoreInstallFramework' -Repository 'SitecoreGallery' -RequiredVersion $env:SIF_VERSION