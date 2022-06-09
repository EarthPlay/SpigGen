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
    printf 'Spigot Generator version '$blue$version$reset'\n'
    printf '\n\n'
}


function check_dir() {
    if [[ ! -d "$directory" ]]; then
        printf $yellow'WARNING'$reset' Directory does not exist. Create?\n'
        printf '['$orange'Y'$reset'/'$gray'n'$reset']: '
        read answer
        printf '\n'
        if [ "$answer" == 'Y' ]; then
            mkdir -p "$directory"
        else
            printf $yellow'not creating'$reset'\n'
            exit
        fi
    fi
}

function directory() {
    if [ "$DIRECTORY" == '' ]; then
        DIRECTORY='./'
    fi

    printf 'Please enter a directory: '$blue'('$reset"$DIRECTORY"$blue')'$gray' '
    read answer
    if [ "$answer" == '' ]; then
        directory="$DIRECTORY"
    else
        directory="$answer"
    fi
    
    export DIRECTORY="$directory"

    directory="$(pwd)/$directory"
    printf $reset'using '$gray"$directory"$reset'\n\n'

    check_dir
}


function groupid() {
    printf 'Please enter the group id: '$blue'('$reset"$GROUP_ID"$blue')'$gray' '
    read answer
    if [ "$answer" == '' ]; then
        groupid="$GROUP_ID"
    else
        groupid="$answer"
    fi

    if [ "$groupid" == '' ]; then
        printf $yellow'WARNING'$reset' Valid group id expected\n'
        printf '\n'
        groupid
    else
        printf $reset'using '$gray"$groupid"$reset'\n\n'
    fi

    export GROUP_ID="$groupid"
}

function artifactid() {
    printf 'Please enter the artifact id: '$blue'('$reset"$ARTIFACT_ID"$blue')'$gray' '
    read answer
    if [ "$answer" == '' ]; then
        artifactid="$ARTIFACT_ID"
    else
        artifactid="$answer"
    fi

    if [ "$artifactid" == '' ]; then
        printf $yellow'WARNING'$reset' Valid artifact id expected\n'
        printf '\n'
        artifactid
    else
        printf $reset'using '$gray"$artifactid"$reset'\n\n'
    fi

    export ARTIFACT_ID="$artifactid"
}

function author() {
    printf 'Please enter the author: '$blue'('$reset"$AUTHOR"$blue')'$gray' '
    read answer
    if [ "$answer" == '' ]; then
        author="$AUTHOR"
    else
        author="$answer"
    fi

    if [ "$author" == '' ]; then
        printf $yellow'WARNING'$reset' Valid author expected\n'
        printf '\n'
        author
    else
        printf $reset'using '$gray"$author"$reset'\n\n'
    fi

    export AUTHOR="$author"
}

function description() {
    printf 'Please enter the description: '$blue'('$reset"$DESCRIPTION"$blue')'$gray' '
    read answer
    if [ "$answer" == '' ]; then
        description="$DESCRIPTION"
    else
        description="$answer"
    fi

    printf $reset'using '$gray"$description"$reset'\n\n'

    export DESCRIPTION="$description"
}

function confirm() {
    printf 'Directory: '$orange"$directory"$reset'\n'
    printf 'Group id: '$orange"$groupid"$reset'\n'
    printf 'Artifact id: '$orange"$artifactid"$reset'\n'
    printf 'Author: '$orange"$author"$reset'\n'
    printf 'Description: '$orange"$description"$reset'\n\n'
    printf $yellow'WARNING'$reset' Are you sure?\n'
    printf '['$orange'Y'$reset'/'$gray'n'$reset']: '

    read answer
    printf '\n'
    if [ ! "$answer" == 'Y' ]; then
        printf $yellow'not generating'$reset'\n'
        exit
    fi
}

function generate() {
    cp -R "$SPIGGEN_TEMPLATE/." "$directory"

    lartifactid=${artifactid,,}

    find $directory -type f -exec sed -i 's/%%%groupid%%%/'"$groupid"'/g' {} +
    find $directory -type f -exec sed -i 's/%%%artifactid%%%/'"$artifactid"'/g' {} +
    find $directory -type f -exec sed -i 's/%%%lartifactid%%%/'"$lartifactid"'/g' {} +
    find $directory -type f -exec sed -i 's/%%%author%%%/'"$author"'/g' {} +
    find $directory -type f -exec sed -i 's/%%%description%%%/'"$description"'/g' {} +

    dir="$directory/src/main/java/${groupid//.//}/${lartifactid}"

    mkdir -p "$dir"

    mv "$directory/Main.java.txt" "$dir/$artifactid.java"

    printf 'Successfully '$green'generated '$reset'plugin!\n'
}

function main() {
    print_logo

    directory

    groupid

    artifactid

    author
    
    description

    confirm

    generate
}

main