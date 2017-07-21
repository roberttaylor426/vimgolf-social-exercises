#!/usr/bin/env bash

set -e

function printUsage {
    echo "Usage: ./submit_solution.sh --author [AUTHOR] --solution [SOLUTION]"
}

while test $# -gt 0; do
    case "$1" in
        -h|--help)
            printUsage
            exit 0
            ;;
        -a|--author)
            shift
            if test $# -gt 0; then
                export AUTHOR=$1
            else
                echo "no author specified"
                exit 1
            fi
            shift
            ;;
        -s|--solution)
            shift
            if test $# -gt 0; then
                export SOLUTION=$1
            else
                echo "no solution specified"
                exit 1
            fi
            shift
            ;;
        *)
            break
            ;;
    esac
done

if [[ -z $AUTHOR ]] || [[ -z $SOLUTION ]] ; then
    printUsage
    exit 1
fi

curl -X POST -H "Content-Type: application/json" http://35.176.237.81:3000/exercises/from_a_to_b/authors/$AUTHOR/solutions -d '{"solution": '"\"$SOLUTION\""'}'
