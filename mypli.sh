#!/bin/sh
#my LPI
#created on 22.04.2017
#notes
#bleachbit font have config file before first run ~/.config/bleachbit
version=0.0.1
answer=0

#cofiguration failes
cfgb=$(pwd)/bleachbit.ini
cfgs=$(pwd)/smplayer.ini

echo "This is version $version"

# yes-no fiunction
# read ans variable in local and return yna variable in global 
# yna is 1 or 0

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

# yes-no fucntion end


# function update

function sys_update {
	echo "Do you want to update your sisyem?"
    yes_no
    if [[ $yna == 1 ]]; then
            sudo apt-get update && sudo apt-get upgrade -y
    fi
}

# function update end



# app instalation

function postinstall {
    echo ""
    echo "installing default pacage list"
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

# app install end

# configuring system
# for now just bleachbit and smplayer

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

# deleting cache and temp files
# this fuction is startin anfter bleachbit is configured!!!

function system_maid {
    echo "****************************************************************"
    echo ""
    echo "After all this instalations you may have some pacages that is no"
    echo "more required, and your temp is full, do you want to clean it up"
    echo ""
    yes_no
    if [[ $yna == 1 ]]; then
        sudo apt-get autoremove
        bleachbit -co --preset
    fi
    echo ""
    echo "Cleaning is done!"
}

#cleaning system

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
# end of script
