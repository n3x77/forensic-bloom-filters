#!/bin/bash
# Helper Script that extracts and converts the sha1 hash and md5hash
# from the NSRL file. All hashes will be converted to lower case

usage(){
  echo Helper that extracts the hashes from the NSRL hashset
  echo './extract_hashes.sh <NSRLFile.txt> sha1'
  echo './extract_hashes.sh <NSRLFile.txt> md5'

  exit $1
}

fatal(){
  echo ERROR: $*
  usage 1
}

[ "$1" = -h ] && usage 0
[ $# -lt 1 ] && fatal PATH to NSRLFile and Hash Type sha1|md5 parameters are missing.
[ $# -lt 2 ] && fatal Hash Type paramater missing. Please choose sha1 or md5.

NSRLFile=$1
HASH=$2

if [[ $HASH = sha1 ]]
then
    # SHA1
    tail -n+1 "$NSRLFile" | cut -d "," -f1 | tr '[:upper:]' '[:lower:]' | sed -e 's/"//g'
elif [[ $HASH = md5 ]]
then
    # MD5
    tail -n+1 "$NSRLFile" | cut -d "," -f2 | tr '[:upper:]' '[:lower:]' | sed -e 's/"//g'
else
    echo "ERROR: wrong Hash Type specified. This script can only use sha1 or md5"
    usage 2
fi
