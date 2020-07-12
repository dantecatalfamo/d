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
            d-usage
            ;;
    esac
}

function d-usage {
    echo "usage: d <command> [<args>]"
    echo
    echo "Commands:"
    echo "  cd      Change to a project directory under ~/src"
    echo "  clone   Clone a repository into ~/src according to the site, user, and project"
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
