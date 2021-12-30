#!/usr/bin/env pwsh
# Constants
$HGSyncPath = $PSScriptRoot
$MonoRepoPath = Join-Path $PSScriptRoot ".."
# Commands
# Functions
<#
.SYNOPSIS
Commit MonoRepo

.DESCRIPTION
Commit MonoRepo State

.EXAMPLE
commit-monorepo
#>
function Commit-MonoRepo {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=0, Position=0)]
        [string]
        $Message
    )

    process {
        # Internal Variables
        $_colorMain = 'Yellow';
        $_colorSecondary = 'DarkCyan';
        $_maxSteps = 6;
        $_step = 0;
        $_process = "Committing MonoRepo State"
        # Variables for Script
        $oldPWD = $PWD;
        $HGRepo = Join-Path $MonoRepoPath ".hg"
        $HGRepoSyncPath = Join-Path $HGSyncPath "hg"

        # Argument with Default message
        $generatedMessage = "Auto Commit"
        if ($Message)
        {
            $generatedMessage = $Message;
        }

        # Logic

        $_m = "Making Commit with message: $generatedMessage in Mercurial MonoRepo";
        $_step = $_step + 1;
        Write-Host -ForegroundColor $_colorMain $_m;
        $_percent = ((100 / $_maxSteps) * $_step);
        Write-Progress -Activity "$_process" -Status "$_percent %" -Id 1 -PercentComplete $_percent -CurrentOperation "$_m";

        Start-Sleep -Milliseconds 500;
        Set-Location $MonoRepoPath;


        $_m = "Adding files to Mercurial Repo";
        $_step = $_step + 1;
        Write-Host -ForegroundColor $_colorSecondary $_m;
        $_percent = ((100 / $_maxSteps) * $_step);
        Write-Progress -Activity "$_process" -Status "$_percent %" -Id 1 -PercentComplete $_percent -CurrentOperation "$_m";

        Start-Sleep -Milliseconds 500;
        hg addremove;
        Start-Sleep -Milliseconds 500;


        $_m = "Commiting Mercurial Repo";
        $_step = $_step + 1;
        Write-Host -ForegroundColor $_colorSecondary $_m;
        $_percent = ((100 / $_maxSteps) * $_step);
        Write-Progress -Activity "$_process" -Status "$_percent %" -Id 1 -PercentComplete $_percent -CurrentOperation "$_m";

        Start-Sleep -Milliseconds 500;
        hg commit -m $generatedMessage;
        Start-Sleep -Milliseconds 500;


        $_m = "Synchronizing Mercurial Sync Repo";
        $_step = $_step + 1;
        Write-Host -ForegroundColor $_colorSecondary $_m;
        $_percent = ((100 / $_maxSteps) * $_step);
        Write-Progress -Activity "$_process" -Status "$_percent %" -Id 1 -PercentComplete $_percent -CurrentOperation "$_m";

        Start-Sleep -Milliseconds 500;
        Remove-Item -Recurse -Force $HGRepoSyncPath;
        Copy-Item -Recurse -Force $HGRepo $HGRepoSyncPath;
        Start-Sleep -Milliseconds 500;


        $_m = "Updating Git <> Mercurial Sync Repo";
        $_step = $_step + 1;
        Write-Host -ForegroundColor $_colorSecondary $_m;
        $_percent = ((100 / $_maxSteps) * $_step);
        Write-Progress -Activity "$_process" -Status "$_percent %" -Id 1 -PercentComplete $_percent -CurrentOperation "$_m";

        Start-Sleep -Milliseconds 500;
        Set-Location $HGSyncPath;

        git add -A;
        git commit -m $generatedMessage;
        Start-Sleep -Milliseconds 500;


        $_m = "Repository Git <> Mercurial Sync is ready to be pushed";
        $_step = $_step + 1;
        Write-Host -ForegroundColor $_colorMain $_m;
        $_percent = ((100 / $_maxSteps) * $_step) - 1;
        Write-Progress -Activity "$_process" -Status "$_percent %" -Id 1 -PercentComplete $_percent -CurrentOperation "$_m";

        Start-Sleep -Milliseconds 500;
        Set-Location $oldPWD;
    }
}

<#
.SYNOPSIS
Update MonoRepo from hgsync

.DESCRIPTION
Update MonoRepo State from hgsync

.EXAMPLE
pull-monorepo
#>
function Pull-MonoRepo {
    [CmdletBinding()]
    param (
    )

    process {
        # Internal Variables
        $_colorMain = 'Yellow';
        $_colorSecondary = 'DarkCyan';
        $_maxSteps = 4;
        $_step = 0;
        $_process = "Pulling MonoRepo State"
        # Variables for Script
        $oldPWD = $PWD;
        $HGRepo = Join-Path $MonoRepoPath ".hg"
        $HGRepoSyncPath = Join-Path $HGSyncPath "hg"

        # Logic

        $_m = "Pulling Mercurial MonoRepo";
        $_step = $_step + 1;
        Write-Host -ForegroundColor $_colorMain $_m;
        $_percent = ((100 / $_maxSteps) * $_step);
        Write-Progress -Activity "$_process" -Status "$_percent %" -Id 1 -PercentComplete $_percent -CurrentOperation "$_m";


        $_m = "Synchronizing Mercurial Mono Repo";
        $_step = $_step + 1;
        Write-Host -ForegroundColor $_colorSecondary $_m;
        $_percent = ((100 / $_maxSteps) * $_step);
        Write-Progress -Activity "$_process" -Status "$_percent %" -Id 1 -PercentComplete $_percent -CurrentOperation "$_m";

        Start-Sleep -Milliseconds 500;
        Remove-Item -Recurse -Force $HGRepo;
        Copy-Item -Recurse -Force $HGRepoSyncPath $HGRepo;
        Start-Sleep -Milliseconds 500;


        $_m = "Reverting files in MonoRepo";
        $_step = $_step + 1;
        Write-Host -ForegroundColor $_colorSecondary $_m;
        $_percent = ((100 / $_maxSteps) * $_step);
        Write-Progress -Activity "$_process" -Status "$_percent %" -Id 1 -PercentComplete $_percent -CurrentOperation "$_m";

        Start-Sleep -Milliseconds 500;
        Set-Location $MonoRepoPath;
        hg revert --all;
        Start-Sleep -Milliseconds 500;

        $_m = "Repository Mercurial Monorepo is ready to be used";
        $_step = $_step + 1;
        Write-Host -ForegroundColor $_colorMain $_m;
        $_percent = ((100 / $_maxSteps) * $_step) - 1;
        Write-Progress -Activity "$_process" -Status "$_percent %" -Id 1 -PercentComplete $_percent -CurrentOperation "$_m";

        Start-Sleep -Milliseconds 500;
        Set-Location $oldPWD;
    }
}

<#
.SYNOPSIS
Status of MonoRepo

.DESCRIPTION
Status of MonoRepo

.EXAMPLE
status-monorepo
#>
function Status-MonoRepo {
    [CmdletBinding()]
    param (
    )

    process {
        # Internal Variables
        $_colorMain = 'Yellow';
        $_colorSecondary = 'DarkCyan';
        $_maxSteps = 3;
        $_step = 0;
        $_process = "Committing MonoRepo State"
        # Variables for Script
        $oldPWD = $PWD;

        # Logic

        $_m = "Checking Status of Mercurial Repo";
        $_step = $_step + 1;
        Write-Host -ForegroundColor $_colorMain $_m;
        $_percent = ((100 / $_maxSteps) * $_step);
        Write-Progress -Activity "$_process" -Status "$_percent %" -Id 1 -PercentComplete $_percent -CurrentOperation "$_m";

        Start-Sleep -Milliseconds 500;
        Set-Location $MonoRepoPath;


        $_m = "Status of Mercurial Repo";
        $_step = $_step + 1;
        Write-Host -ForegroundColor $_colorSecondary $_m;
        $_percent = ((100 / $_maxSteps) * $_step);
        Write-Progress -Activity "$_process" -Status "$_percent %" -Id 1 -PercentComplete $_percent -CurrentOperation "$_m";

        Start-Sleep -Milliseconds 500;
        hg summary;
        hg status;
        Start-Sleep -Milliseconds 500;

        $_m = "Mercurial MonoRepo Repository status is ready";
        $_step = $_step + 1;
        Write-Host -ForegroundColor $_colorMain $_m;
        $_percent = ((100 / $_maxSteps) * $_step) - 1;
        Write-Progress -Activity "$_process" -Status "$_percent %" -Id 1 -PercentComplete $_percent -CurrentOperation "$_m";

        Start-Sleep -Milliseconds 500;
        Set-Location $oldPWD;
    }
}
