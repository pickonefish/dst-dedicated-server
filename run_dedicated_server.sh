#!/bin/bash

#steamcmd_dir="$HOME/steamcmd"  #This is unnecessary if you set the environment variables for the steam user correctly as outlined earlier
install_dir="$HOME/steamapps/DST"
cluster_name="MyDediServer" #SHOULD be changeable but I have not tested this.  Possible it's Hardcoded as well.
dontstarve_dir="$HOME/.klei/DoNotStarveTogether" #This folder structure [/.klei/DoNotStarveTogether] is HARD CODED into their program, do not change

function fail()
{
    echo Error: "$@" >&2
    exit 1
}

function check_for_file()
{
    if [ ! -e "$1" ]; then
        fail "Missing file: $1"
    fi
}

#cd "$steamcmd_dir" || fail "Missing $steamcmd_dir directory!"

#check_for_file "steamcmd.sh" #This is unecessary if you set the environment variables for the steam user correctly as outlined earlier
check_for_file "$dontstarve_dir/$cluster_name/cluster.ini"
check_for_file "$dontstarve_dir/$cluster_name/cluster_token.txt"
check_for_file "$dontstarve_dir/$cluster_name/Master/server.ini"
check_for_file "$dontstarve_dir/$cluster_name/Caves/server.ini"

steamcmd +force_install_dir "$install_dir" +login anonymous +app_update 343050 +quit

check_for_file "$install_dir/bin64"

cd "$install_dir/bin64" || fail

run_shared=(./dontstarve_dedicated_server_nullrenderer_x64)
run_shared+=(-console)
run_shared+=(-cluster "$cluster_name")
run_shared+=(-monitor_parent_process $$)

"${run_shared[@]}" -shard Caves  | sed 's/^/Caves:  /' &
"${run_shared[@]}" -shard Master | sed 's/^/Master: /'
