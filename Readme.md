# EDWARD SOLOS - Ultimate Hacking Toolkit

![EDWARD SOLOS ASCII Art](https://ik.imagekit.io/rmlbayysp/1749254010677-IMG-20250604-WA0000_---7cdiQG.jpg)  


A powerful all-in-one hacking toolkit with utilities, games, and system tools wrapped in a stylish shell interface.

## Features

- 🛠️ **Penetration Testing Tools**: 8+ pre-configured hacking tools
- 🎮 **Interactive Games**: Space Invaders clone in your terminal
- 🎥 **ASCII Movies**: Watch Star Wars in ASCII art
- 📊 **System Dashboard**: Real-time monitoring
- 🎨 **Custom UI**: Colorful interface with EDWARD SOLOS branding

## Platforms Supported

- Termux (Android)
- Kali Linux
- Ubuntu/Debian
- Other Linux distributions
- macOS (with Homebrew)

## Installation

### Termux (Android)

```bash
pkg update && pkg upgrade -y
pkg install git -y
pkg install python -y
git clone https://github.com/codekingibk/edward.sh.git
cd edward.sh
chmod +x edward.sh
./edward.sh
```

### Kali Linux

```bash
sudo apt update && sudo apt upgrade -y
sudo apt install git -y
git clone https://github.com/codekingibk/edward.sh.git
cd edward.sh
chmod +x edward.sh
./edward.sh
```

### Ubuntu/Debian

```bash
sudo apt update && sudo apt upgrade -y
sudo apt install git python3 -y
git clone https://github.com/codekingibk/edward.sh.git
cd edward.sh
chmod +x edward.sh
./edward.sh
```

### macOS (Requires Homebrew)

```bash
brew update
brew install git python
git clone https://github.com/codekingibk/edward.sh.git
cd edward.sh
chmod +x edward.sh
./edward.sh
```

## Tool List

| #  | Tool Name            | Description                          |
|----|----------------------|--------------------------------------|
| 1  | HackerPro            | Multi-tool hacking framework         |
| 2  | RED_HAWK             | All-in-one scanning tool             |
| 3  | TigerVirus           | File infection tool                  |
| 4  | Info-Site            | Website information gatherer         |
| 5  | BadMod               | CMS vulnerability scanner            |
| 6  | FaceBash             | Facebook brute-force tool            |
| 7  | DARKARMY             | Another multi-tool framework         |
| 8  | Auto_Tor_IP_changer  | Automate Tor IP rotation             |
| 9  | Space Invaders       | Terminal-based action game           |
| 10 | Star Wars ASCII      | Watch Episode IV in terminal         |
| 11 | System Dashboard     | Real-time system monitoring          |

## Usage Guide

1. **Navigation**:
   - Use numbers to select menu items
   - Follow on-screen instructions for each tool

2. **Game Controls** (Space Invaders):
   - `A`: Move left
   - `D`: Move right
   - `SPACE`: Shoot
   - `Q`: Quit game

3. **System Dashboard**:
   - View real-time system stats
   - Monitor processes and network

## Troubleshooting

**Common Issues**:

1. *Missing dependencies*:
   ```bash
   sudo apt install -f  # On Debian-based
   pkg install -y python git  # On Termux
   ```

2. *Permission denied*:
   ```bash
   chmod +x edward.sh
   ```

3. *Tool not installing*:
   - Ensure you have root access where required
   - Check your internet connection

## Contributing

Pull requests are welcome! For major changes, please open an issue first.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Disclaimer

This tool is for educational purposes only. The developer is not responsible for any misuse of this software.
