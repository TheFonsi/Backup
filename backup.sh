#!/bin/bash
version="1.0"

############################## CONFIG ##############################
DIRS_TO_BACKUP="/root/mc/"  #Example: "/root/mc/ /root/ts/ /home/"
BACKUP_SAVE=/root/backup/            
TIME_TO_DEL_BACKUP=7        #In days
####################################################################
NOW=$(date +"%d-%m-%Y_%H:%M:%S")
DELDATE=$(date -d "-$TIME_TO_DEL_BACKUP days" +"%d-%m-%Y_")
DAY=$(date +"%a")

echo ""
echo "Author: Dawid xCraftRayX Grzywniak"
echo "Contact TeamSpeak3: MineS.pl"
echo ""
echo ":: Version of Backup [$version]"
echo ""

installing()
{
        echo;
        echo -e "****************************************";
        echo -e "       INSTALLING: $1";
        echo -e "****************************************";
        echo;
}

check_installed_packets()
{
        if [ -z `which zip` ]; then
                installing "zip"
                apt-get install zip
        fi

        if [ -z `which unzip` ]; then
                installing "unzip"
                apt-get install unzip
        fi

        if [ -z `which wget` ]; then
                installing "wget"
                apt-get install wget
        fi
}

remove_old_backup()
{
  FILE="files-"
  rm -rf $BACKUP_SAVE$FILE$DELDATE*
}

make_backup()
{
  [ ! -d $BACKUP_SAVE ] && mkdir -p $BACKUP_SAVE || :
  #
  FILE="files-$NOW.zip"
  zip -rq $BACKUP_SAVE$FILE $DIRS_TO_BACKUP
  echo "Backup done!"

  remove_old_backup
}

check_installed_packets
make_backup
