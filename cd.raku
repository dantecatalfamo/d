#!/bin/env raku

enum Exits (
    'Success' => 0,
    'Error'
);

sub MAIN($search? = '') {
    chdir $*HOME.add("src");
    my @paths;
    my @sites = dir;
    for @sites -> $site {
        next if !$site.d;
        my @users = dir $site;
        for @users -> $user {
            next if !$user.d;
            my @projects = dir $user;
            for @projects -> $project {
                next if !$project.d;
                @paths.push($project);
            }
        }
    }

    my @filtered = @paths.grep: /$search/;

    if !@filtered.elems {
        note "No results";
        exit(Error);
    }

    if @filtered.elems == 1 {
        put @filtered[0].absolute;
        exit(Success);
    }

    for @filtered.kv -> $idx, $path {
        note "$idx) $path";
    }

    $*ERR.write("Selection [0]: ".encode);
    my $selection = prompt;
    $selection = try $selection.Int;
    if !$selection.defined || !(0 <= $selection < @filtered.elems) {
        note "Invalid selection";
        exit(Error);
    }
    put @filtered[$selection].absolute;
}
