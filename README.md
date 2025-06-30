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

10. This part is optional, just in case your 'lscpu' output in step 3 provides you unpleasant result for CPU minimum MHz. Please be informed that this step is not a form of overclocking. The process is just for you to have an idea to get the most potential of your CPU cores to its maximum performance.

Pros: Good for cheap computers with base processor speeds of 1.8 ghz below just like mine.
Cons: More battery consumption if you are using a laptop or more power consumption from the AC power supply.

👉 lscpu

/*
just like what you have done in step 3, check the max and min Mhz of your CPU cores, the goal here is to make them equal and not to overclock.
*/

👉 watch -n1 "grep 'MHz' /proc/cpuinfo"

/*
Observe how your CPU cores perform, you will see that most of your CPU cores are just running in minimum Mhz
*/


👉 sudo nano /etc/default/grub

/*
look for this section

GRUB_CMDLINE_LINUX_DEFAULT="quiet splash zswap.enabled=1"

then replace it with this

GRUB_CMDLINE_LINUX_DEFAULT="quiet splash zswap.enabled=1 intel_pstate=disable"
*/


👉 sudo update-grub

👉 sudo reboot


/*
once restarted, run the below command
*/


👉 cat /sys/devices/system/cpu/intel_pstate/status

/*
the output should no longer be passive or active, it should return something about 'No such file or directory'
*/


👉 cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_driver

/*
the returning output should be 'acpi-cpufreq'
*/

👉 sudo systemctl stop thermald
👉 sudo systemctl disable thermald
👉 sudo systemctl stop tlp
👉 sudo systemctl disable tlp


👉 sudo apt install linux-tools-common linux-tools-$(uname -r)
👉 sudo cpupower frequency-set -g performance


👉 for i in 0 1 2 3; do
  echo userspace | sudo tee /sys/devices/system/cpu/cpu$i/cpufreq/scaling_governor
  echo 2560000 | sudo tee /sys/devices/system/cpu/cpu$i/cpufreq/scaling_min_freq
done


👉 for i in 0 1 2 3; do
  echo performance | sudo tee /sys/devices/system/cpu/cpu$i/cpufreq/scaling_governor
done

👉 for i in 0 1 2 3; do
  echo 100 | sudo tee /sys/devices/system/cpu/cpu$i/cpufreq/energy_performance_preference
done


👉 watch -n1 "grep 'MHz' /proc/cpuinfo"

/*
Observe again the improvement
*/
