#!/bin/sh

repohome=~/src/github.com/dantecatalfamo/repo

function repo {
    case $1 in
        cl*)
            repo-clone $@
            ;;
        cd)
            repo-cd $@
            ;;
        *)
            repo-usage
            ;;
    esac
}

function repo-usage {
    echo "usage: repo <command> [<args>]"
    echo
    echo "Commands:"
    echo "  cd      Change to a project directory under ~/src"
    echo "  clone   Clone a repository into ~/src according to the site, user, and project"
}

function repo-clone {
    repo=$2
    if [ x$repo == x ];then
        echo "Repo required"
        return
    fi

    echo "Cloning" $repo
    output=$(raku $repohome/clone.raku $repo)

    if [ $? -eq 0 ]; then
        cd $output
    elif [ $? -eq 2 ]; then
        echo "Project already cloned"
    else
        echo "Error cloning project"
    fi
}

function repo-cd {
    search=$2

    output=$(raku $repohome/cd.raku $search)

    if [ $? -eq 0 ]; then
        cd $output
    else
        echo "Error selecting project directory"
    fi
}
