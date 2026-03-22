#!/bin/bash
set -eo pipefail
##################################################################################################################

##################################################################################################################
#
#   DO NOT JUST RUN THIS. EXAMINE AND JUDGE. RUN AT YOUR OWN RISK.
#
##################################################################################################################
#tput setaf 0 = black
#tput setaf 1 = red
#tput setaf 2 = green
#tput setaf 3 = yellow
#tput setaf 4 = dark blue
#tput setaf 5 = purple
#tput setaf 6 = cyan
#tput setaf 7 = gray
#tput setaf 8 = light blue
##################################################################################################################

# variables and functions
workdir=$(pwd)

##################################################################################################################

#!/bin/bash

# Define array of target directories
dirs=(
    "limalinux_calamares_config"
    )

# Loop through each directory
for dir in "${dirs[@]}"; do
    echo "Entering $dir"
    cd "$dir" || { echo "Failed to enter $dir"; continue; }

    # Find and execute build* scripts
    for script in build*; do
        if [[ -x "$script" && -f "$script" ]]; then
            echo "Running $script"
            ./"$script"
        else
            echo "No executable build* script found in $dir"
        fi
    done
    cd ..
done


echo
tput setaf 6
echo "##############################################################"
echo "###################  $(basename $0) done"
echo "##############################################################"
tput sgr0
echo
