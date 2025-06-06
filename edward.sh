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
    echo "GitHub: https://github.com/codekingibk/Edward-tools/edward.sh"
    echo
}

# Color scheme
text_color='\e[1;35m'
bg_color='\e[48;5;234m'
reset='\e[0m'

# Shell-based Space Invaders Game
space_invaders() {
    clear
    display_ascii
    echo -e "${text_color}${bg_color}~ SPACE INVADERS ~${reset}"
    echo "Use A/D to move, SPACE to shoot, Q to quit"
    
    # Game variables
    ship_pos=20
    score=0
    aliens=("5,10" "5,20" "5,30" "10,10" "10,20" "10,30")
    bullets=()
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
        for (( y=1; y<=15; y++ )); do
            printf '|'
            for (( x=1; x<=40; x++ )); do
                cell_empty=1
                
                # Draw ship
                if [[ $y -eq 15 && $x -eq $ship_pos ]]; then
                    printf '^'
                    cell_empty=0
                fi
                
                # Draw bullets
                for bullet in "${bullets[@]}"; do
                    IFS=',' read by bx <<< "$bullet"
                    if [[ $bx -eq $x && $by -eq $y ]]; then
                        printf '|'
                        cell_empty=0
                        break
                    fi
                done
                
                # Draw aliens
                for alien in "${aliens[@]}"; do
                    IFS=',' read ay ax <<< "$alien"
                    if [[ $ax -eq $x && $ay -eq $y ]]; then
                        printf '👾'
                        cell_empty=0
                        break
                    fi
                done
                
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
            a) (( ship_pos > 1 )) && (( ship_pos-- ));;
            d) (( ship_pos < 40 )) && (( ship_pos++ ));;
            ' ') bullets+=("$((15-1)),$ship_pos");;
            q) game_over=1;;
        esac
        
        # Move bullets
        new_bullets=()
        for bullet in "${bullets[@]}"; do
            IFS=',' read by bx <<< "$bullet"
            (( by-- ))
            if (( by > 0 )); then
                new_bullets+=("$by,$bx")
                
                # Check for alien hits
                new_aliens=()
                hit=0
                for alien in "${aliens[@]}"; do
                    IFS=',' read ay ax <<< "$alien"
                    if [[ $ax -eq $bx && $ay -eq $by ]]; then
                        (( score += 10 ))
                        hit=1
                    else
                        new_aliens+=("$ay,$ax")
                    fi
                done
                aliens=("${new_aliens[@]}")
                [[ $hit -eq 1 ]] && continue
            fi
        done
        bullets=("${new_bullets[@]}")
        
        # Check win condition
        if [[ ${#aliens[@]} -eq 0 ]]; then
            echo -e "\033[32mYOU WIN! Final score: $score\033[0m"
            game_over=1
        fi
        
        # Random alien movement
        if (( RANDOM % 10 == 0 )); then
            new_aliens=()
            for alien in "${aliens[@]}"; do
                IFS=',' read ay ax <<< "$alien"
                move=$(( RANDOM % 3 - 1 )) # -1, 0, or 1
                (( new_ax = ax + move ))
                if (( new_ax >= 1 && new_ax <= 40 )); then
                    ax=$new_ax
                fi
                (( ay++ ))
                if (( ay >= 15 )); then
                    echo -e "\033[31mGAME OVER! The aliens reached Earth!\033[0m"
                    game_over=1
                    break
                fi
                new_aliens+=("$ay,$ax")
            done
            aliens=("${new_aliens[@]}")
        fi
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
        echo "9) Play Space Invaders"
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
                space_invaders
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
