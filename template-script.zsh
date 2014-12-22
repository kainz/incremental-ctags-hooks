#!/usr/bin/env sh
# vim:filetype=zsh
#

# run in users std shell and get our preamble
[ "$_" = "$SHELL" -o -n "$_INSCRIPT" ] || _INSCRIPT=1 exec "$SHELL" "$0" "$@" #run in user's std shell
unset _INSCRIPT
set -e
preambles=( "$(dirname $0)/../util-functions" "$(dirname $0)/util-functions" )
for i in "${preambles[@]}"; do
    [ -r "$i" ] && source "$i"
done
set +e
