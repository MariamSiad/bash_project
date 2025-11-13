#!/bin/bash
#welcome page

dialog --title "User Management System" --yesno "Welcome to the User and Group Management System!\n\n💡Note! You MUST be administrator for start the program!!\n\nWould you like to start?" 10 60

if [ $? -ne 0 ]
then
    dialog --title "Goodbye" --msgbox "Exiting... See You Later" 8 40
    clear
    exit 0
fi
username=$(dialog --title "Check Administrator" --inputbox "Enter Username " 8 40 3>&1 1>&2 2>&3)
if groups "$username" | grep -E -q "(sudo|wheel)"
then
dialog --msgbox "✅ $username is an Administrator!" 6 50
# chosen command
while true 
do
 CH=$(dialog --title "Main Page"  --menu "Select an option:" 20 60 12 \
        1        "Add User        Add a user to the system"\
        2        "Modify User     Modify a user on the system"\
        3        "Delete User     Delete a user form the system"\
        4        "List Users      List all users on the system"\
        5        "Add Group       Add a user group to the system"\
        6        "Modify Group    Modify a group and its list members"\
        7        "Delete Group    Delete a group on the system"\
        8        "List Group      List all groups on the system"\
        9        "Disable User    Lock the user account"\
        10       "Enable User     Unlock the user account"\
        11       "Change Password Change a user password"\
        12       "About           Program information" 3>&1 1>&2 2>&3)

    exit_status=$?
    if [ $exit_status != 0 ]; then
        dialog --title "Goodbye" --msgbox "Exiting... See You Later" 8 40
        clear
        echo "Exited."
        exit
    fi
case $CH in
        1)
                # add user to your system
                username=$(dialog --inputbox "Enter username: " 8 40 3>&1 1>&2 2>&3)
                sudo useradd ${username} && dialog --msgbox "User👤${username} added successfully!" 8 40
                ;;
        2)
                # modify user in your system
                username=$(dialog --inputbox "Enter username to Modify:" 8 40 3>&1 1>&2 2>&3)
                # please write your option without '-'
                option=$(dialog --inputbox "Enter option (as: aG group)" 8 40 3>&1 1>&2 2>&3)
                sudo usermod -${option} ${username} && dialog --msgbox "User 🛠️  ${username} modified!" 6 40
                ;;
        3)
                # delete user in your system
                 username=$(dialog --inputbox "Enter username to Delete:" 8 40 3>&1 1>&2 2>&3)
             sudo userdel ${username} && dialog --msgbox "User ❌${username} Deleted!" 6 40
                 ;;
        4)
                # list users and numbered it  
                 dialog --msgbox "$(cut -d: -f1 /etc/passwd | nl)" 20 50
                ;;
        5)
                # add group to your system
                group=$(dialog --inputbox "Enter Group Name: " 8 40 3>&1 1>&2 2>&3)
                sudo groupadd $group && dialog --msgbox "Group 👥${group} Added!" 6 40
                ;;
        6)
                # modify group 
                group=$(dialog --inputbox "Enter Group or GID to modify: " 8 40 3>&1 1>&2 2>&3)
                # enter your option without '-'
                option=$(dialog --inputbox "Enter option (as: g gid , n new name )" 8 40 3>&1 1>&2 2>&3)
                sudo groupmod -${option} ${group} && dialog --msgbox "Group 🛠️  ${group} Moified!" 6 40
                ;;
        7)
                # Delete group
                group=$(dialog --inputbox "Enter group to deleted " 8 40 3>&1 1>&2 2>&3)
                sudo groupdel ${group} && dialog --msgbox "Group ❌${group} Deleted!" 6 40
                ;;
        8)
                # List group 
                dialog --msgbox "$(cut -d: -f1 /etc/group | nl)" 20 50
                ;;
        9)
                #Lock user 
                user=$(dialog --inputbox "Enter Username to Locked:" 8 40 3>&1 1>&2 2>&3)
                sudo usermod -L ${user} && dialog --msgbox "User 🚫${user} is Locked!" 6 40
                ;;
        10)
                #Unlock user
                user=$(dialog --inputbox "Enter Username to Unlocked:" 8 40 3>&1 1>&2 2>&3)
              sudo usermod -U ${user} && dialog --msgbox "User✅${user} is Unlocked!" 6 40
                ;;
        11)
                #Change Password 
                user=$(dialog --inputbox "Enter Username:" 8 40 3>&1 1>&2 2>&3)
                passwd=$(whiptail --passwordbox "Enter Strong Password:" 8 40 3>&1 1>&2 2>&3)
                echo "${passwd}" | sudo passwd --stdin "${user}" && dialog --msgbox "User 🔐 ${user} your password is changed" 6 40
                ;;
        12)
                #information about system
                dialog --title "✨ About This Program ✨" --msgbox "\
                ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
                  🧩 User & Group Management System  
                ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
        
                🔹 System: Red Hat Linux
                🔹 Language: Bash Script
                🔹 Developer: Mariam Said
               🔹 Supervisor:Eng/Romany Nageh

                ✨ Features:
                   ▪ Add / Modify / Delete users
                   ▪ Manage user groups
                   ▪ Lock / Unlock accounts
                   ▪ Change passwords securely
                
                🕐 $(date +"%A, %d %B %Y - %H:%M")

                ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
                 💡 Tip: Always run as root for full access.
                ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" 20 60
                ;;

esac
done
else
        dialog --title "Check Administrator" --msgbox "❌ $username is not an Administrator!" 8 40
clear
        echo "Exited."
        exit
fi

                                                 
