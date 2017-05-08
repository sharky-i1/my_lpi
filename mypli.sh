#!/bin/sh
#moj LPI
#datum kreiranja 22.04.2017
#beleske
#bleachbit pre pokretanja u bilokom smislu nema ini fajl u ~/.config/bleachbit
version=0.0.1
answer=0

#cofiguracioni fajlovi
cfgb=$(pwd)/bleachbit.ini
cfgs=$(pwd)/smplayer.ini

echo "This is version $version"

# da ne funkcija
# cita ans promenjljivu i lokalu i vraca yna 
# u global sa 1 ili 0

function yes_no {
ans=
yna=
    until [[ $ans == "y" || $ans == "n" ]]; do        
        echo "?"
        read ans
        if [[ $ans == "y" ]]; then
            yna=1
        elif [[ $ans == "n" ]]; then
            yna=0
        else
            echo "pleas answer just with y or n" 
        fi

    done
return $yna

}

# da ne funkcija kraj


# funkcija update

function sys_update {
	echo "Do you want to update your sisyem?"
    yes_no
    if [[ $yna == 1 ]]; then
            sudo apt-get update && sudo apt-get upgrade -y
    fi
}

# funkcija update kraj



# post instalaciono azuriranje sistema poceta

function postinstall {
    echo ""
    echo "installin default pacage list"
    sudo apt-get install vim bleachbit krita smplayer smtube openshot gimp thunderbird firefox gedit gparted inkscape audacious audacity bluefish deluge doublecmd-gtk dconf-tools -y
    echo "instalation is finished!"
    echo ""
}

function services {
    echo "Do you want to install sshd?"
    yes_no
    if [[ $yna == 1 ]]; then
        sudo apt-get install openssh-client openssh-server -y
        echo ""
        echo "Do you want to sshd service be active?"
        yes_no
        if [[  $yna == 1  ]]; then
            sudo systemctl enable sshd
            sudo systemctl start sshd
        else
            sudo systemctl disable sshd
            sudo systemctl stop sshd        
        fi
    fi
}

function installplus {
    echo ""
    echo "Do you want to install nvidia-304 graphic dirver"
    yes_no
    if [[ $yna == 1 ]]; then
        local socket1="nvidia-304"
    fi

    echo "Do you want to install pavucontrol"
    yes_no
    if [[ $yna == 1 ]]; then
        local socket2="pavucontrol"
    fi

    echo "Do you want to install ninja-ide"
    yes_no
    if [[ $yna == 1 ]]; then
        local socket3="ninja-ide"
    fi

    echo "Do you want to install libreoffice"
    yes_no
    if [[ $yna == 1 ]]; then
        local socket4="libreoffice"
    fi

    echo "following paccages will be installed:"
    echo $socket1 $socket2 $socket3 $socket4
    echo ""
    echo "do you agree"
    yes_no
    if [[ $yna == 1 ]]; then
        sudo apt-get install $socket1 $socket2 $socket3 $socket4 -y
        echo ""
        echo "additional pacage instalation is finished!"
    
    else
        echo ""
        echo "step skipped!"
    fi


}

# post instalaciono azuriranje sistema kraj

# konfigurisanje sistema
# za sad samo bleach bit

function configure {
    echo "Bleach bit will be configured"
    mkdir -p ~/.config/bleachbit
    cp $cfgb ~/.config/bleachbit/
    echo ""
    echo "done!"
    echo ""
    echo "Now SMPlayer will be configured..."
    echo ""
    mkdir -p ~/.config/smplayer
    cp $cfgs ~/.config/smplayer/


}

# brisanje nepotrebnih paketa pocetak
# OVA FUNKCIJA SE IZVRSAVA NAKOD PODESENOG BLEACHBITA

function system_maid {
    echo "****************************************************************"
    echo ""
    echo "After all this instalation you may have some pacages that is no"
    echo "more required, and your temp is full, do you want to clen it up"
    echo ""
    yes_no
    if [[ $yna == 1 ]]; then
        sudo apt-get autoremove
        bleachbit -co --preset
    fi
    echo ""
    echo "Cleaning is done!"
}

#brisanje nepotrebnih paketa kraj

function main {
    echo ""
    echo "This is Linux Post Instalation script."
    echo ""
    echo "It will update your system, install some pacages, star ssh service,"
    echo "setup nVidia video driver, and let you chouse some additional"
    echo "pacages to installe"
    echo ""
    echo "For this script your internet must work!"
    echo ""
    echo "Can scrypt bagin?"
    yes_no
    if [[  $yna == 1  ]]; then
        
    sys_update

    services

    installplus

    postinstall    

    configure

    system_maid

    else
       echo "Script is stopped."
    fi
}

main
# kraj skripte
