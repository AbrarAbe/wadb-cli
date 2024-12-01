#!/usr/bin/env sh

get_ip_address() {
    while true; do
        read -p "Enter IP address (192.168.X.X, enter X for oktet): 192.168." ip_address
        if [[ "$ip_address" =~ ^([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$ ]]; then
            echo "192.168.$ip_address"1
        else
            echo "Invalid IP address format. Please use the format X.X (0-255)"
        fi
        return
    done
}

get_pair_port() {
    while true; do
        read -p "Enter port number (5 digits, e.g., 55555): " port_number
        if [[ "$port_number" =~ ^[0-9]{5}$ ]]; then
            echo "$port_number"
        else
            echo "Invalid port number. Please enter a 5-digit number"
        fi
        return
    done
}

pair_device() {
    ip_address=$(get_ip_address)
    pair_port_number=$(get_pair_port)
    ip_address_port="$ip_address:$pair_port_number"
    adb pair "$ip_address_port"
    if [ $? -eq 0 ]; then
        echo "Pairing successful."
        read -p "Enter port number for connection (5 digits, e.g., 55555): " connect_port_number
        echo
        if [[ "$connect_port_number" =~ ^[0-9]{5}$ ]]; then
            ip_address_connect="${ip_address}:$connect_port_number"
            adb connect "$ip_address_connect"
            echo
            if [ $? -eq 0 ]; then
                sleep 5
                break
                clear
            else
                echo "Error connecting with $ip_address_connect"
            fi
            clear
        else
            echo "Invalid port number. Please enter a 5-digit number"
        fi
    else
        echo "Error pairing with $ip_address_port"
        sleep 2
    fi
}

disconnect_all_device() {
    adb disconnect
    echo "Processing..."
    sleep 5
    echo "Done."
    sleep 3
    clear
}

while true; do
    echo
    echo "  WADB-CLI - Wireless ADB simplified"
    echo
    echo "List of connected devices:"
    adb devices -l | tail -n +2 | awk '{print $1" "$4" "$5}'
    echo "Choose an action:"
    echo "1. Pair a device"
    echo "2. Disconnect all"
    echo "3. Exit"
    echo
    read -p "Enter your choice (1-3): " choice
    echo

    case "$choice" in
        1)
            pair_device
            ;;
        2)
            disconnect_all_device
            ;;
        3)
            echo "Exited"
            exit 0
            ;;
        *)
            echo "Invalid choice. Please enter 1, 2, or 3."
            ;;
    esac
done
