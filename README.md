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

10. This part is optional. Use it if your `lscpu` output shows an unusually low minimum CPU MHz, and you want to improve baseline performance.

Please note: **this is not overclocking**. The goal is simply to optimize your CPU to run closer to its full potential.

Pros: Ideal for low-end systems with base CPU speeds below 1.8 GHz (like mine). 

Cons: Slightly higher power consumption, especially on laptops or when running on AC power.

A 👉 lscpu

/*
This will display the minimum and maximum supported CPU MHz. The goal is to make these values equal to prevent unnecessary downclocking.
*/

B 👉 watch -n1 "grep 'MHz' /proc/cpuinfo"

/*
This command allows you to monitor CPU frequency behavior in real-time. You will likely notice that most cores stay at minimum MHz unless under load.
*/


C 👉 sudo nano /etc/default/grub

/*
look for this section

GRUB_CMDLINE_LINUX_DEFAULT="quiet splash zswap.enabled=1"

then replace it with this

GRUB_CMDLINE_LINUX_DEFAULT="quiet splash zswap.enabled=1 intel_pstate=disable"
*/


D 👉 sudo update-grub

E 👉 sudo reboot


/*
once restarted, run the below command
*/


F 👉 cat /sys/devices/system/cpu/intel_pstate/status

/*
the output should no longer be passive or active, it should return something like 'No such file or directory'
*/


G 👉 cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_driver

/*
the returning output should be 'acpi-cpufreq'
*/


/*
Please make sure you have completed **Bash commands A–G of Step 10** before proceeding.

The following bash commands **H–Q** only apply during the current runtime session which means it will reset after every reboot. These configurations are not persistent unless scripted.

Please consider creating a shell script that you can run from your desktop or trigger during login to avoid repeating the steps.

All Changes made before this point i.e. GRUB modifications, are persistent and survive reboots.

The steps below are temporary and must be re-applied each session—unless automated.
*/

H 👉 sudo systemctl stop thermald
I 👉 sudo systemctl disable thermald
J 👉 sudo systemctl stop tlp
K 👉 sudo systemctl disable tlp


L 👉 sudo apt install linux-tools-common linux-tools-$(uname -r)
/*
Just in case this is not yet installed, please skip if you are done and move to the next command
*/
M 👉 sudo cpupower frequency-set -g performance


N 👉 for i in 0 1 2 3; do
  echo userspace | sudo tee /sys/devices/system/cpu/cpu$i/cpufreq/scaling_governor
  echo 2560000 | sudo tee /sys/devices/system/cpu/cpu$i/cpufreq/scaling_min_freq
done

/*
The value 2560000 represents 2.56 GHz — which is the maximum turbo frequency where the above command is tested.

Please make sure to set this value according to the maximum capacity of your CPU and do not exceed your rated max frequency.
*/


O 👉 for i in 0 1 2 3; do
  echo performance | sudo tee /sys/devices/system/cpu/cpu$i/cpufreq/scaling_governor
done

P 👉 systemctl suspend
/*
This step puts the system into sleep mode. Upon waking up, the CPU frequency often locks at higher values.

After waking and logging back in, monitor CPU frequencies again.
*/

Q 👉 watch -n1 "grep 'MHz' /proc/cpuinfo"

/*
You should now observe that the CPU cores are maintaining higher frequencies more consistently — behaving like it just drank three espresso shots and turned to berserk mode.

Nothing illegal was done here. No overclocking, no warranty violations, no shady BIOS hacks.
There is no reason to call the Bureau of Fire, EMS, or 911 for thermal arson.

Just pure Linux tricks, caffeine, and desperation from low MHz pain.
*/
