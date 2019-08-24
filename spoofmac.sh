function spoofmac {
        echo "Old MAC:$(ifconfig en0 | grep ether | sed 's/.*ether//')"
        echo "Generating random MAC address..."
        echo "Assigning new MAC..."

        # Define "evens"
        eArray=("0" "2" "4" "6" "8" "a" "c" "e")

        # Seed random generator
        RANDOM=$$$(date +%s)

        # Pick an "even" value
        e=${eArray[$RANDOM % ${#eArray[@]} ]}

        openssl rand -hex 6 | sed "s/^\(.\)./\1$e/; s/\(..\)/\1:/g; s/.$//" | xargs sudo ifconfig en0 ether
        echo "Spoofed MAC:`ifconfig en0 | grep ether | sed 's/.*ether//'`"

}
