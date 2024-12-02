# wadb-cli: A Simplified Wireless ADB CLI Tool

`wadb-cli` is a simple command-line interface (CLI) tool written in shell script to streamline the process of pairing and connecting to Android devices wirelessly using ADB.  It simplifies the common tasks of entering IP addresses and ports, providing a user-friendly experience.

## Features

* **Simplified Pairing:** Guides the user through the pairing process, prompting for the device's IP address, pairing port, and pairing code.  It validates user inputs to prevent errors.
* **Improved Connection:** After successful pairing, it prompts for a connection port and attempts to connect to the device.  It handles connection errors gracefully.
* **Device Selection for Disconnection:** Allows users to select a specific device to disconnect from a list of currently connected devices.
* **Bulk Disconnection:** Provides a single command to disconnect all currently connected ADB devices.
* **User-Friendly Interface:** Presents a clear menu with numbered options for easy navigation.
* **Error Handling:** Provides informative messages for successful operations and errors, including detailed error messages from ADB.
* **Input Validation:** Validates user inputs (IP address and port numbers) to prevent common errors.


## Usage

1. **Save the script:** Save the provided `wadb.sh` script to your system.
2. **Make executable:** Run `chmod +x wadb.sh` to make the script executable.
3. **Run the script:** Execute the script using `./wadb.sh`.

The script will then present a menu with the following options:

* **1. Pair a device:** Guides you through the pairing process.
* **2. Connect to device:** Connects to a device using a specified IP address and port.
* **3. Disconnect from device:** Allows you to disconnect a specific device from the list of connected devices.
* **4. Disconnect all:** Disconnects all currently connected ADB devices.
* **5. Exit:** Exits the script.

## Requirements

* **`adb` (Android Debug Bridge):** Must be installed and configured correctly in your system's PATH. You can usually find it in the Android SDK platform-tools directory.

## Installation

1. **Clone the repository (if using Git):**
   ```bash
   git clone https://github.com/AbrarAbe/wadb-cli.git
   ```
2. **Download `wadb.sh`:** Alternatively, download the `wadb.sh` script directly from the repository.
3. **Make executable:** `chmod +x wadb.sh`
4. **Place the script:** Place `wadb.sh` in a convenient location (e.g., `/usr/local/bin` or your personal bin directory).  Adding the directory to your `PATH` environment variable is recommended for easy access.
5. **Run the script:** Execute the script using `./wadb.sh` (or just `wadb.sh` if it's in your PATH).


## Troubleshooting

* **ADB not found:** Ensure `adb` is installed and in your `PATH`.
* **Connection errors:** Verify the device's IP address and port numbers.  Make sure the device is connected to the same network as your computer and that the firewall isn't blocking the connection.  Check for network connectivity issues.
* **Pairing failures:** Ensure the device is enabled for wireless debugging in its developer options. Double-check the pairing code entered.


## Contributing

Contributions are welcome! Please feel free to open issues or submit pull requests.