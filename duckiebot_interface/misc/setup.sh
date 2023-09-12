#!/bin/bash

set -e

check_apt_lock() {
    while sudo fuser /var/lib/dpkg/lock >/dev/null 2>&1 || sudo fuser /var/lib/apt/lists/lock >/dev/null 2>&1; do
        echo "APT is currently in use. Waiting..."
        sleep 5
    done
}

# Update and Upgrade
echo "Checking for APT locks..."
check_apt_lock
echo "Updating package list..."
sudo apt update

echo "Checking for APT locks..."
check_apt_lock
echo "Upgrading installed packages..."
sudo apt upgrade -y

# Install tools
echo "Checking for APT locks..."
check_apt_lock
echo "Installing curl, vim, and tmux..."
sudo apt install curl vim tmux -y

# Install python pip
echo "Checking for APT locks..."
check_apt_lock
echo "Installing python3-pip..."
sudo apt install python3-pip -y

# Install pip packages from requirements.txt
echo "Installing pip packages from requirements.txt..."
pip3 install -r requirements.txt

# Setup ROS repositories
echo "Setting up ROS repositories..."
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
echo "Adding ROS keys..."
curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -

echo "Checking for APT locks..."
check_apt_lock
echo "Updating package list with ROS repos..."
sudo apt update

# Install ROS Noetic Desktop Full
echo "Checking for APT locks..."
check_apt_lock
echo "Installing ROS Noetic Desktop Full..."
sudo apt install ros-noetic-desktop-full -y

# Source ROS setup.bash in bashrc
echo "Sourcing ROS setup in bashrc..."
echo "source /opt/ros/noetic/setup.bash" >> /home/pi/.bashrc
source ~/.bashrc

# Copy udev rules
echo "Copying udev rules..."
sudo cp 99-duckiebot.rules /etc/udev/rules.d/

# Rebooting
echo "Make sure to reboot now using 'sudo reboot'"
