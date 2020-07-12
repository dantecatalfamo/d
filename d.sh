#!/bin/sh

dhome="~/src/github.com/dantecatalfamo/d/"

function d {
    case $1 in
        cl*)
            d-clone $@
            ;;
        cd)
            d-cd $@
            ;;
        *)
            echo "Not implimented"
            ;;
    esac
}

function d-clone {
    repo=$2
    if [ x$repo == x ];then
        echo "Repo required"
        return
    fi

    echo "Cloning" $repo
    output=$(raku $dhome/clone.raku $repo)

    if [ $? -eq 0 ]; then
        cd $output
    elif [ $? -eq 2 ]; then
        echo "Project already cloned"
    else
        echo "Error cloning project"
    fi
}

function d-cd {
    search=$2

    output=$(raku $dhome/cd.raku $search)

    if [ $? -eq 0 ]; then
        cd $output
    else
        echo "Error selecting project directory"
    fi
}
