#!/bin/bash
# cpu_berserk.sh
# Berserk mode activator for your cheapie trashy machines
# Ron Penones | October 25th 2025 - Feel free to share and reproduce, the core idea is mine with some assistance of AI. Padayon!

echo "[+] Stopping thermald (prevents unwanted throttling)..."
sudo systemctl stop thermald
sudo systemctl disable thermald

echo "[+] Setting CPU governor to 'performance'..."
sudo cpupower frequency-set -g performance

echo "[+] Forcing userspace governor + locking minimum frequency to 2.56GHz..."
for i in 0 1 2 3; do
  echo userspace | sudo tee /sys/devices/system/cpu/cpu$i/cpufreq/scaling_governor > /dev/null
  echo 2560000 | sudo tee /sys/devices/system/cpu/cpu$i/cpufreq/scaling_min_freq > /dev/null
done

echo "[+] Switching all cores back to performance governor..."
for i in 0 1 2 3; do
  echo performance | sudo tee /sys/devices/system/cpu/cpu$i/cpufreq/scaling_governor > /dev/null
done

echo "[+] Sleeping for 15 seconds, will auto-wake via RTC..."
sudo rtcwake -m mem -s 15

echo "[+] System woke up — berserk mode active!"
