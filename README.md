# wadb-cli: A Simplified Wireless ADB CLI Tool

`wadb-cli` is a simple command-line interface (CLI) tool written in shell script to streamline the process of pairing and connecting to Android devices wirelessly using ADB.  It simplifies the common tasks of entering IP addresses and ports, providing a user-friendly experience.

## Features

* **Simplified Pairing:** Guides the user through the process of pairing a device, ensuring correct IP address and port number formats.
* **Improved Connection:**  After successful pairing, it prompts for a connection port and attempts to connect.
* **Bulk Disconnection:** Provides a single command to disconnect all currently connected ADB devices.
* **User-Friendly Interface:** Presents a clear menu with numbered options for easy navigation.
* **Input Validation:**  Validates user inputs (IP address and port numbers) to prevent errors.
* **Error Handling:**  Provides informative messages for successful operations and errors.

## Usage

1. **Save the script:** Save the provided `wadb.sh` script to your system.
2. **Make executable:**  Run `chmod +x wadb.sh` to make the script executable.
3. **Run the script:** Execute the script using `./wadb.sh`.

The script will then present a menu with the following options:

* **1. Pair a device:**  Guides you through the pairing process, asking for the device's IP address and port numbers.
* **2. Disconnect all:** Disconnects all currently connected ADB devices.
* **3. Exit:** Exits the script.

## Requirements

* `adb` (Android Debug Bridge) must be installed and configured correctly in your system's PATH.  You can usually find it in the Android SDK platform-tools directory.

## Installation

1.  Clone the repository (if using git):

    ```bash
    git clone https://github.com/AbrarAbe/wadb-cli.git
    ```
2.  Alternatively, download `wadb.sh`.
3.  Make the script executable: `chmod +x wadb.sh`
3.  Place the `wadb.sh` script in a convenient location (e.g., `/usr/local/bin` or your personal bin directory).
4.  Add it to your PATH (optional but recommended):  If you placed it in `/usr/local/bin`, it should already be in your PATH. Otherwise, you may need to add its directory to your PATH environment variable.
5.  Run the script using `./wadb.sh`.

## Troubleshooting

* **ADB not found:** Ensure that `adb` is installed and in your system's PATH.
* **Connection errors:** Verify the device's IP address and port numbers.  Ensure that the device is connected to the same network as your computer and that the firewall is not blocking the connection.
* **Pairing failures:**  Make sure the device is enabled for wireless debugging in its developer options.

## Contributing

Contributions are welcome!  Please feel free to open issues or submit pull requests.
