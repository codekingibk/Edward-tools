#!/bin/bash

# ASCII Art for EDWARD SOLOS
display_ascii() {
    clear
    echo -e "\e[1;35m"
    echo "███████╗██████╗ ██╗    ██╗ █████╗ ██████╗ ██████╗     ███████╗ ██████╗ ██╗      ██████╗ ███████╗"
    echo "██╔════╝██╔══██╗██║    ██║██╔══██╗██╔══██╗██╔══██╗    ██╔════╝██╔═══██╗██║     ██╔═══██╗██╔════╝"
    echo "█████╗  ██║  ██║██║ █╗ ██║███████║██████╔╝██║  ██║    ███████╗██║   ██║██║     ██║   ██║███████╗"
    echo "██╔══╝  ██║  ██║██║███╗██║██╔══██║██╔══██╗██║  ██║    ╚════██║██║   ██║██║     ██║   ██║╚════██║"
    echo "███████╗██████╔╝╚███╔███╔╝██║  ██║██║  ██║██████╔╝    ███████║╚██████╔╝███████╗╚██████╔╝███████║"
    echo "╚══════╝╚═════╝  ╚══╝╚══╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═════╝     ╚══════╝ ╚═════╝ ╚══════╝ ╚═════╝ ╚══════╝"
    echo -e "\e[0m"
    echo "GitHub: https://github.com/codekingibk/Edward-tools"
    echo
}

# Color scheme
text_color='\e[1;35m'
bg_color='\e[48;5;234m'
reset='\e[0m'

# Snake Game
snake_game() {
    clear
    display_ascii
    echo -e "${text_color}${bg_color}~ SNAKE GAME ~${reset}"
    echo "Use WASD to move, Q to quit"
    
    # Game variables
    snake=("10,10" "10,11" "10,12")
    direction="d"
    food_row=$((RANDOM % 20 + 1))
    food_col=$((RANDOM % 40 + 1))
    score=0
    game_over=0
    
    while [[ $game_over -eq 0 ]]; do
        # Draw game board
        clear
        echo -e "${text_color}${bg_color}Score: $score${reset}"
        echo
        
        # Draw top border
        printf '+'
        for i in {1..40}; do printf '-'; done
        printf '+\n'
        
        # Draw game area
        for (( row=1; row<=20; row++ )); do
            printf '|'
            for (( col=1; col<=40; col++ )); do
                cell_empty=1
                
                # Draw snake
                for segment in "${snake[@]}"; do
                    IFS=',' read s_row s_col <<< "$segment"
                    if [[ $row -eq $s_row && $col -eq $s_col ]]; then
                        printf 'O'
                        cell_empty=0
                        break
                    fi
                done
                
                # Draw food
                if [[ $row -eq $food_row && $col -eq $food_col ]]; then
                    printf '@'
                    cell_empty=0
                fi
                
                # Empty cell
                if [[ $cell_empty -eq 1 ]]; then
                    printf ' '
                fi
            done
            printf '|\n'
        done
        
        # Draw bottom border
        printf '+'
        for i in {1..40}; do printf '-'; done
        printf '+\n'
        
        # Process input
        read -rsn1 -t 0.1 input
        case $input in
            w) [[ "$direction" != "s" ]] && direction="w";;
            a) [[ "$direction" != "d" ]] && direction="a";;
            s) [[ "$direction" != "w" ]] && direction="s";;
            d) [[ "$direction" != "a" ]] && direction="d";;
            q) game_over=1;;
        esac
        
        # Move snake
        IFS=',' read head_row head_col <<< "${snake[-1]}"
        case $direction in
            w) ((head_row--));;
            a) ((head_col--));;
            s) ((head_row++));;
            d) ((head_col++));;
        esac
        
        # Check collisions
        if [[ $head_row -lt 1 || $head_row -gt 20 || $head_col -lt 1 || $head_col -gt 40 ]]; then
            echo -e "\033[31mGAME OVER! You hit the wall!\033[0m"
            game_over=1
            continue
        fi
        
        for segment in "${snake[@]}"; do
            IFS=',' read s_row s_col <<< "$segment"
            if [[ $head_row -eq $s_row && $head_col -eq $s_col ]]; then
                echo -e "\033[31mGAME OVER! You ate yourself!\033[0m"
                game_over=1
                continue 2
            fi
        done
        
        # Check food
        if [[ $head_row -eq $food_row && $head_col -eq $food_col ]]; then
            ((score++))
            food_row=$((RANDOM % 20 + 1))
            food_col=$((RANDOM % 40 + 1))
        else
            snake=("${snake[@]:1}")
        fi
        
        snake+=("$head_row,$head_col")
    done
    
    read -p "Press enter to continue..."
}

# ASCII Star Wars
star_wars() {
    echo "Connecting to towel.blinkenlights.nl..."
    telnet towel.blinkenlights.nl 2>/dev/null || {
        echo "Telnet not found. Installing..."
        sudo apt-get install telnet -y
        telnet towel.blinkenlights.nl
    }
    read -p "Press enter to continue..."
}

# System Info Dashboard
system_dashboard() {
    while true; do
        clear
        display_ascii
        echo -e "${text_color}${bg_color}~ SYSTEM DASHBOARD ~${reset}"
        echo
        echo -e "Hostname: \033[36m$(hostname)\033[0m"
        echo -e "Uptime: \033[33m$(uptime -p)\033[0m"
        echo -e "CPU Load: \033[35m$(uptime | awk -F'[a-z]:' '{ print $2 }')\033[0m"
        echo -e "Memory: \033[32m$(free -h | awk '/Mem/{print $3 "/" $2}')\033[0m"
        echo -e "Disk: \033[34m$(df -h / | awk 'NR==2{print $3 "/" $2 " (" $5 ")"}')\033[0m"
        echo -e "IP: \033[31m$(hostname -I 2>/dev/null || echo "Not connected")\033[0m"
        echo
        echo "1) Process monitor"
        echo "2) Network stats"
        echo "3) Disk usage"
        echo "4) Return to main menu"
        read -p "Select option: " dash_opt
        
        case $dash_opt in
            1) top -n 1 -b | head -20;;
            2) netstat -tuln;;
            3) df -h;;
            4) break;;
            *) echo "Invalid option";;
        esac
        read -p "Press enter to continue..."
    done
}

# Main menu
main_menu() {
    while true; do
        clear
        display_ascii
        echo -e "${text_color}${bg_color}~ MAIN MENU ~${reset}"
        echo "1) Install HackerPro"
        echo "2) Install RED_HAWK"
        echo "3) Install TigerVirus"
        echo "4) Install Info-Site"
        echo "5) Install BadMod"
        echo "6) Install FaceBash"
        echo "7) Install DARKARMY"
        echo "8) Install Auto_Tor_IP_changer"
        echo "9) Play Snake Game"
        echo "10) Watch Star Wars (ASCII)"
        echo "11) System Dashboard"
        echo "0) Exit"
        read -p "Enter your choice: " choice

        case $choice in
            1)
                echo -e "\033[47;3;35m Installation may take some time\033[0m"
                sleep 3
                mkdir -p Tools
                cd Tools
                apt update && apt upgrade && apt install git && apt install python2
                git clone https://github.com/jaykali/hackerpro.git
                cd hackerpro
                sudo bash install.sh
                python2 hackerpro.py
                cd ../..
                ;;
            2)
                echo -e "\033[47;3;35m Installation may take some time\033[0m"
                sleep 3
                mkdir -p Tools
                cd Tools
                git clone https://github.com/Tuhinshubhra/RED_HAWK
                cd RED_HAWK
                php rhawk.php
                cd ../..
                ;;
            3)
                echo -e "\033[47;3;35m Installation may take some time\033[0m"
                sleep 3
                mkdir -p Tools
                cd Tools
                git clone https://github.com/Devil-Tigers/TigerVirus
                apt update
                apt upgrade -y
                pkg install git -y
                cd TigerVirus
                bash app.sh
                cd ../..
                ;;
            4)
                echo -e "\033[47;3;35m Installation may take some time\033[0m"
                sleep 3
                mkdir -p Tools
                cd Tools
                pkg install curl -y
                upgrade -y
                pkg install git -y
                git clone https://github.com/king-hacking/info-site.git
                cd info-site
                bash info.sh
                cd ../..
                ;;
            5)
                echo -e "\033[47;3;35m Installation may take some time\033[0m"
                sleep 3
                mkdir -p Tools
                cd Tools
                sudo apt-get update
                sudo apt-get install php
                sudo apt-get install php-curl
                git clone https://github.com/MrSqar-Ye/BadMod.git
                cd BadMod
                chmod u+x INSTALL
                chmod u+x BadMod.php
                sudo php BadMod.php
                cd ../..
                ;;
            6)
                echo -e "\033[47;3;35m Installation may take some time\033[0m"
                sleep 3
                mkdir -p Tools
                cd Tools
                git clone https://github.com/fu8uk1/facebash
                cd facebash
                bash install.sh
                chmod +x facebash.sh
                tor
                sudo ./facebash.sh
                cd ../..
                ;;
            7)
                echo -e "\033[47;3;35m Installation may take some time\033[0m"
                sleep 3
                mkdir -p Tools
                cd Tools
                pkg install git
                pkg install python2
                apt install git
                apt install python2
                git clone https://github.com/D4RK-4RMY/DARKARMY
                cd DARKARMY
                chmod +x darkarmy.py
                python2 darkarmy.py
                cd ../..
                ;;
            8)
                echo -e "\033[47;3;35m Installation may take some time\033[0m"
                echo -e "\033[47;3;35m This tool requires you to be (ROOT)\033[0m"
                sleep 3
                mkdir -p Tools
                cd Tools
                sudo apt-get install tor
                pip3 install requests
                git clone https://github.com/FDX100/Auto_Tor_IP_changer.git
                cd Auto_Tor_IP_changer
                echo -e "\033[47;3;35m Go to your browser / change the proxy to 127.0.0.1:9050\033[0m"
                sleep 8
                python3 install.py
                aut
                cd ../..
                ;;
            9)
                snake_game
                ;;
            10)
                star_wars
                ;;
            11)
                system_dashboard
                ;;
            0)
                clear
                exit 0
                ;;
            *)
                echo -e '\033[36;40;1m Invalid selection'
                sleep 1
                ;;
        esac
    done
}

# Start the script
main_menu
