#! /usr/bin/bash

#   _________      .__         ________               
#  /   _____/_____ |__| ____  /  _____/  ____   ____  
#  \_____  \\____ \|  |/ ___\/   \  ____/ __ \ /    \ 
#  /        \  |_> >  / /_/  >    \_\  \  ___/|   |  \
# /_______  /   __/|__\___  / \______  /\___  >___|  /
#         \/|__|     /_____/         \/     \/     \/ 
# A plugin template generator which allows rappid plugin development.
#
# It is licensed under the MIT license.
# 
# (c) 2022 EarthPlay
#
# https://github.com/EarthPlay/SpigotGenerator


####################################################
## █ █▄░█ █▀ ▀█▀ ▄▀█ █░░ █░░ █▀ █▀▀ █▀█ █ █▀█ ▀█▀ ##
## █ █░▀█ ▄█ ░█░ █▀█ █▄▄ █▄▄ ▄█ █▄▄ █▀▄ █ █▀▀ ░█░ ##
####################################################
#   This script allows an easy installation and    #
#           deinstallation of ReSVG.               #


version='0.0.0alpha0'

red='\033[38;2;255;100;100m'
dark_red='\033[38;2;230;40;40m'
blue='\033[38;2;100;100;255m'
orange='\033[38;2;255;150;0m'
yellow='\033[38;2;255;205;50m'
gray='\033[38;2;140;140;140m'
green='\033[38;2;130;255;130m'
reset='\033[0m'


function print_logo() {
    printf '\n'
    printf $orange'  _________      .__         ________               '$reset'\n'
    printf $orange' /   _____/_____ |__| ____  /  _____/  ____   ____  '$reset'\n'
    printf $orange' \_____  \\\\____ \|  |/ ___\/   \  ____/ __ \ /    \ '$reset'\n'
    printf $orange' /        \  |_> >  / /_/  >    \_\  \  ___/|   |  \\'$reset'\n'
    printf $orange'/_______  /   __/|__\___  / \______  /\___  >___|  /'$reset'\n'
    printf $orange'        \/|__|     /_____/         \/     \/     \/ '$reset'\n'
    printf '\n'
    printf 'SpigGen installer version '$blue$version$reset'\n'
    printf '\n\n'
}


function uninstall() {
    printf 'Uninstalling...\n'
    sed -i '/SPIGGEN INSTALL/,/# END SPIGGEN INSTALL/d' ~/.bashrc
    printf '\n'
    printf 'Successfully '$red'uninstalled '$reset'SpigGen!\n'
}

function install() {
    printf 'Installing...\n'

    chmod +x spiggen.sh

    echo '# SPIGGEN INSTALL' >> ~/.bashrc
    echo 'export PATH="'$(pwd)':$PATH"' >> ~/.bashrc
    echo 'export SPIGGEN_TEMPLATE="'$(pwd)'/template"' >> ~/.bashrc
    echo 'alias spiggen=". spiggen.sh"' >> ~/.bashrc
    echo '# END SPIGGEN INSTALL' >> ~/.bashrc

    printf '\n'
    printf 'Successfully '$green'installed '$reset'SpigGen!\n'
}

function check() {
    installed=$(cat ~/.bashrc | grep -Eo '# SPIGGEN INSTALL')

    if [ -z "$installed" ]; then
        printf 'Do you really want to '$orange'install '$reset'SpigGen?\n'
        printf '['$orange'Y'$reset'/'$gray'n'$reset']: '
        read answer
        printf '\n'
        if [ "$answer" == 'Y' ]; then
            install
        else
            printf $yellow'not installing'$reset'\n'
        fi
        printf '\n'
    else
        printf $dark_red'WARNING '$reset'Already installed! Do you want to '$red'uninstall'$reset'?\n'
        printf '['$red'Y'$reset'/'$gray'n'$reset']: '
        read answer
        printf '\n'
        if [ "$answer" == 'Y' ]; then
            uninstall
        else
            printf $yellow'not uninstalling'$reset'\n'
        fi
        printf '\n'
    fi
}

function main() {
    print_logo

    check
}

main