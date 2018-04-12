#!/bin/bash
# Basic Authentication
# create user & group

userFile="/etc/apache2/auth/basic/.htpasswd"
groupFile="/etc/apache2/auth/basic/.htgroup"

function fileExists(){
   if [[ ! -e "${1}"  ]]; then
        touch "${1}"
   fi
}

function addUser(){
    userPrefix="${1}"
    userPasswd="${2}"
    userGroup="${3}"
    userCount="${4}"

    echo "${userGroup}: " >> ${groupFile}
    for((x=1; x<="${userCount}"; x++)){
        var=$(printf "%0${#userCount}d" "${x}")
        htpasswd -b "${userFile}" "${userPrefix}${var}" "${userPasswd}"
        check=`cat "${groupFile}" | grep -w "${userGroup}"`
        sed -i "s/${check}/${check} ${userPrefix}${var}/g" "${groupFile}"
    }
}

fileExists "${userFile}"
fileExists "${groupFile}"

# adduser <userPrefix> <userPasswd> <userGroup> <userCount>
addUser "${1}" "${2}" "${3}" "${4}"
