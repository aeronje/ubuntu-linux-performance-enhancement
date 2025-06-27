# ubuntu-linux-performance-enhancement
Several items that can enhance the performance of your ubuntu linux just in case you are not fortunate enough to have a good computer specifications for the year 2025.

The first 3 steps is for you to have ideas on seeing what it was and seeing how it performs better after applying the subsequent procedures after steps 1, 2 and 3.

1. Run the command  the below command so that it will give you the output details of your linux distro

👉 cat /etc/os-release 

2. Run the below command so that it will give you the output details of your memory information

👉 cat /proc/meminfo

3. Run the below command so that it will give you the output details of your cpu information

👉 lscpu

4. Install XFCE

👉 sudo apt update
👉 sudo apt upgrade
👉 sudo apt install xubuntu-desktop
👉 sudo reboot

/*

Once you hit the login screen, switch to XFCE.

*/



5. Disable GNOME animations 

👉 gsettings set org.gnome.desktop.interface enable-animations false

6. Autostart optimization

👉 gnome-session-properties

/*
Then uncheck applications that you do not require to run.
*/

7. Enable zswap instead of full swap reads/writes

👉 sudo nano /etc/default/grub

/*
Look for this section in the configuration file

GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"

Then change it to

GRUB_CMDLINE_LINUX_DEFAULT="quiet splash zswap.enabled=1"

*/

👉 sudo update-grub
👉 sudo reboot

8. Adjust swappiness to reduce disk usage

👉 echo 'vm.swappiness=10' | sudo tee -a /etc/sysctl.conf
👉 sudo sysctl -p

9. Switch from Mozilla Firefox to Midori or Falkon browser.
