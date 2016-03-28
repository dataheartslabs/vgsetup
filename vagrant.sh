#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

VAGRANT_PATH=~/datahearts/vagrant/
CENTOS="centos"
UBUNTU="ubuntu"

menu(){

  echo "========================="
  echo "1) Centos"
  echo "2) Ubuntu"
  echo "3) Exit"
  echo "========================="
  read -p "Please enter the command:" cmd
  if [[ "$cmd" = "1" ]];then
    os_path=${VAGRANT_PATH}${CENTOS}
    os_name=$CENTOS
  elif [[ "$cmd" = "2" ]];then
    os_path=${VAGRANT_PATH}${UBUNTU}
    os_name=$UBUNTU
  else
    exit
  fi
  cd $os_path

  submenu os_name

  menu
}
submenu(){
  echo "========================="
  echo "1) Start  Vagrant Server"
  echo "2) Reload Vagrant Server"
  echo "3) Stop   Vagrant Server"
  echo "4) SSH    Vagrant Server"
  echo "5) main menu"
  echo "========================="
  read -p "Please enter number:" Number

  if [ $Number = 1 ] || [ $Number = 2 ] || [ $Number = 3 ] || [ $Number = 4 ];then
    read -p "Please enter the number of vm [all]:" num

    if [[ "$num" = "" ]];then
      os_name2=""
    elif [[ $num -ge 5 ]];then
      echo "The number is wrong![1-4]!"
      exit
    else
      os_name2=${os_name}${num}
    fi
  fi


  case $Number in
    "1")
            echo "Begin run $os_name Server"
            vagrant up $os_name2
            if [ "$os_name2" != "" ]; then
              echo "SSH to connetc Server"
              vagrant ssh $os_name2
            fi
            ;;
    "2")
            echo "Begin Reload Vagrant Server"
            vagrant reload $os_name2
            if [ "$os_name2" != "" ]; then
              echo "SSH to connetc Server"
              vagrant ssh $os_name2
            fi
            ;;
    "3")
            echo "Power off Server Server"
            vagrant halt $os_name2
            echo "successfull..."
            ;;
    "4")    echo "SSH to connetc Server"
            vagrant ssh $os_name2
            ;;
    *)
            # "Exit..."
            return
  esac

  submenu

}

menu
