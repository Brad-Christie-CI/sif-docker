# escape=`
FROM mcr.microsoft.com/windows/servercore:ltsc2016
SHELL ["powershell.exe", "-Command", "$ErrorActionPreferece='Stop';$ProgressPreference='SilentlyContinue';"]
RUN Install-PackageProvider -Name 'NuGet' -Force ; `
    Install-Module -Name 'PowerShellGet' -Force ; `
    Register-PSRepository 'SitecoreGallery' -SourceLocation 'https://sitecore.myget.org/F/sc-powershell/api/v2' -InstallationPolicy Trusted ; `
    Install-Module 'SitecoreInstallFramework' -Repository 'SitecoreGallery' -RequiredVersion "2.1.0"