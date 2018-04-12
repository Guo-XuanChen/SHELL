#!/bin/bash
commandNumberPrev=""
firstLogin="1"

function commandLog(){
    commandInfo=`history 1`
    commandNumber=`echo ${commandInfo} | awk '{print $1}'`
    commandString=`echo ${commandInfo} | sed -r 's/^([0-9]+)(.)//g'`

    if [[ ${commandNumber} != ${commandNumberPrev} ]]; then
        dateFormat=`date +"%b %e %H:%M:%S"`
        messagesLog="${dateFormat} ${USER}: ${commandString}"
        inputFile="/var/log/command/${USER}.log"

        if [[ ${firstLogin} = "2" ]]; then
            echo $messagesLog >> ${inputFile}
        fi

        firstLogin="2"
        commandNumberPrev=${commandNumber}
    fi
}

export PROMPT_COMMAND="commandLog"
readonly PROMPT_COMMAND
