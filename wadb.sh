#!/usr/bin/env bash

# Check if 'adb' command is available
if ! command -v adb &>/dev/null; then
    echo "Error: 'adb' command not found. Please install ADB and try again."
    exit 1
fi

get_ip_address() {
    while true; do
        read -p "Enter IP Address (192.168.X.X, enter X for oktet): 192.168." ip_address
        if [[ "$ip_address" =~ ^[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
            echo "192.168.$ip_address"
        else
            echo "Invalid IP address format. Please use the format X.X (0-255)"
        fi
        return
    done
}

get_pair_port() {
    while true; do
        read -p "Enter pairing port number (5 digits, e.g., 55555): " pair_port_number
        if [[ "$pair_port_number" =~ ^[0-9]{5}$ ]]; then
            echo "$pair_port_number"
        else
            echo "Invalid port number. Please enter a 5-digit number"
        fi
        return
    done
}

get_pairing_code() {
    while true; do
        read -p "Enter pairing code: " pairing_number
        if [[ "$pairing_number" =~ ^[0-9]{6}$ ]]; then
        echo "$pairing_number"
        else
            echo "Invalid pairing number. Please try again"
        fi
        return
    done
}

get_connect_port() {
    while true; do
        read -p "Enter port number for connection (5 digits, e.g., 55555): " connect_port_number
        if [[ "$connect_port_number" =~ ^[0-9]{5}$ ]]; then
            echo "$connect_port_number"
        else
            echo "Invalid port number. Please enter a 5-digit number"
        fi
        return
    done
}

pair_device() {
    ip_address=$(get_ip_address)
    echo "IP Address entered: $ip_address"
    pair_port=$(get_pair_port)
    echo "Pairing Port entered: $pair_port"
    pairing_code=$(get_pairing_code)
    echo "Pairing Code entered: $pairing_code"

    adb_pair="$ip_address:$pair_port"
    echo "Pairing with $adb_pair..."
    sleep 1

    # Execute adb pair and capture the output
    pair_output=$(adb pair "$adb_pair" "$pairing_code" 2>&1)

    # Check for errors using specific keywords
    if echo "$pair_output" | grep -q -i "protocol fault\|error\|couldn't read"; then
        echo "Pairing failed! Please check your pairing code."
        echo "Error details: $pair_output"
        sleep 4
    elif echo "$pair_output" | grep -iq "success"; then
        sleep 1
        echo
        echo "Pairing successful!"
        sleep 1
        echo

        # Proceed to connect
        connect_port=$(get_connect_port)
        echo "Port entered: $connect_port"
        ip_address_connect="${ip_address}:$connect_port"
        echo "Connecting to $ip_address_connect..."
        sleep 2
        connect_output=$(adb connect "$ip_address_connect" 2>&1)

        if echo "$connect_output" | grep -iq "connected"; then
            echo
            echo "Connection successful!"
            sleep 4
            clear
        else
            echo "Connection failed!"
            echo "Error: $connect_output"
            sleep 4
        fi
    else
        echo "Unexpected pairing response!"
        echo "Output: $pair_output"
        sleep 4
    fi
}

connect_device() {
    ip_address=$(get_ip_address)
    echo "IP Address entered: $ip_address"
    connect_port=$(get_connect_port)
    echo "Port entered: $connect_port"
    ip_address_connect="${ip_address}:$connect_port"
    echo "Connecting to $ip_address_connect..."
    sleep 2
    connect_output=$(adb connect "$ip_address_connect" 2>&1)

    if echo "$connect_output" | grep -iq "connected"; then
        echo
        echo "Connection successful!"
        sleep 4
        clear
    else
        echo "Connection failed!"
        echo "Error: $connect_output"
        sleep 4
    fi
}

disconnect_device() {
    connected_devices=$(adb devices -l | tail -n +2 | awk '{print $1" "$4" "$5}')
    if [ $? -ne 0 ]; then
        echo "Error getting connected devices."
        return
    fi

    devices=()
    while [[ "$connected_devices" =~ ([^\s]+) ]]; do
        devices+=("${BASH_REMATCH[1]}")
        connected_devices="${connected_devices#* }"
    done

    if [ ${#devices[@]} -eq 0 ]; then
        echo "No connected devices found."
        return
    fi

    echo "Connected devices:"
    for i in "${!devices[@]}"; do
        echo "$((i + 1)). ${devices[i]%%	*}" #Remove the tab character from device name
    done

    while true; do
        read -p "Select a device to disconnect (enter number): " choice
        if [[ "$choice" =~ ^[0-9]+$ ]] && (( choice >= 1 && choice <= ${#devices[@]} )); then
            selected_device="${devices[choice-1]%%	*}" #Remove the tab character from device name
            adb disconnect "$selected_device"
            if [ $? -eq 0 ]; then
                echo "Disconnected from $selected_device..."
                break
            else
                echo "Error disconnecting from $selected_device"
            fi
            break
        else
            echo "Invalid choice. Please enter a number from the list."
        fi
    done
}

disconnect_all_device() {
    echo "Processing..."
    sleep 3
    adb disconnect
    sleep 1
    echo "Done."
    echo "Exited."
    exit 0
}

while true; do
    echo
    echo "  WADB-CLI - Wireless ADB simplified"
    echo
    echo "List of connected devices:"
    adb devices -l | tail -n +2 | awk '{print $1" "$4" "$5}'
    echo "Choose an action:"
    echo "1. Pair a device"
    echo "2. Connect to device"
    echo "3. Disconnect from device"
    echo "4. Disconnect all"
    echo "5. Exit"
    echo
    read -p "Enter your choice (1-3): " choice
    echo

        case "$choice" in
            1)
                pair_device
                ;;
            2)
                connect_device
                ;;
            3)
                disconnect_device
                ;;
            4)
                disconnect_all_device
                ;;
            5)
                echo "Exited."
                exit 0
                ;;
            *)
                echo "Invalid choice. Please enter a number between 1 and 5."
                ;;
        esac
    done
