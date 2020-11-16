$env:PSModulePath = $env:PSModulePath + "$([System.IO.Path]::PathSeparator)C:\Users\Emman\Documents\WindowsPowerShell\Modules"
Import-Module posh-git
Import-Module oh-my-posh
Set-Theme Paradox
# posh-winfetch takes too long, sorry

## Commands
# Laravel:
# pa - php artisan
# pas - php artisan serve - opens webbrowser
# pam - php artisan migrate
# pams - php artisan migrate --seed
# pamf - php artisan migrate:fresh --seed
# Utility:
# .. - cd ..
# gac - git add . - git commit -m ""
# workspace - cd workspace
# hosts - open hosts in vs
# touch - unix alternative
# stat - ^^
# c - composer alias

# Laravel
function pa() {
    php artisan $args
}
function pas {
    Start-Process "http://localhost:8000"
    pa('serve')
}
function pam {
    pa('migrate')
}
function pams {
    pa('migrate --seed')
}
function pamf {
    pa('migrate:fresh --seed')
}

# Utility

function .. {
    Set-Location ..
}

function gac() {
    git add .
    git commit -m $alias
}

function workspace() {
    Set-Location "$home\Desktop\Workspace\$args"
}

function hosts {
    code "C:\Windows\System32\drivers\etc\hosts"
}

function touch {
    Param(
        [Parameter(ValueFromPipeline)]
        [string[]]$Path = $PWD
    )
    foreach ($p in $Path) {
        if (Test-Path -LiteralPath $p) {
            (Get-Item -Path $p).LastWriteTime = Get-Date
        }
        else {
            New-Item -Type File -Path $p
        }
    }
}

function stat($fName) {
    Get-ItemProperty $fName | Select-Object *
}

Set-Alias c composer
