# Docker-CaraKernel-Termux
> a repository to help you use **Docker** in Termux with the "CaraKernel" kernel

---

### Requirements:
 - **CaraKernel Support** (I just tested it on device Ginkgo)
 - **Recovery** (Recommended OrangeFox)
 - **Magisk/ROOT** (v23+)

---

1. __First I rooted my Xiaomi Redmi Note 8. Then I installed PixelOS Android 13.__
2. __Install Termux. Then execute Moby’s script to check kernel’s compatibility o running docker.__

### Before we proceed <br> Check kernel compatibility
```bash
 pkg in wget tsu -y
 wget https://raw.githubusercontent.com/moby/moby/master/contrib/check-config.sh
 chmod +x check-config.sh
 sed -i '1s_.*_#!/data/data/com.termux/files/usr/bin/bash_' check-config.sh
 sudo ./check-config.sh
```

--- 

3. __The missing configs will be displayed. Take notes of these red missing configs (especially configs under Generally Necessary), we have to enable them during kernel compliation.__
> ![Screenshot_Termux](https://user-images.githubusercontent.com/58480908/218159380-4b53280e-e049-4df7-a2ad-2ee46a8e8301.png)

---

### This step would be the compilation of the kernel. but not necessarily if your kernel already has the parameters [enabled](https://ivonblog.com/en-us/posts/sony-xperia-5-ii-docker-kernel/) (good luck)
 1. before changing kernels, **backup dtbo and boot**
 2. Download [CaraKernel](https://t.me/GinkgoKernel/5804/40573?single) (for ginkgo)
 3. Flash the ZIP to your RECOVERY
 4. Flash the MAGISK **(mandatory)**
   > if it stays in bootloop, boot into recovery and restore the backup you made earlier.

---

## It's show time...

> Running Docker containers
### A message “There is an internal problem with your device” will pop up on every boot. Just ignore it.

 1. **Open Termux, mount cgroups**:
 ```bash
  sudo mount -t tmpfs -o uid=0,gid=0,mode=0755 cgroup /sys/fs/cgroup
 ```
 2. **Enable binfmt_misc**:
 ```bash
  su
  mount binfmt_misc -t binfmt_misc /proc/sys/fs/binfmt_misc
  echo 1 > /proc/sys/fs/binfmt_misc/status
 ```
 3. Execute Moby’s script again: **sudo ./check-config.sh**. Make sure everything turns green.
 > ![Screenshot-Termux](https://user-images.githubusercontent.com/58480908/218163609-d6a5feeb-9477-43f4-83f1-83ed189f7a26.png) <br> Don't worry if it says: "**CONFIG_PID_NS: missing**, **CONFIG_IPC_NS: missing**, **CONFIG_CGROUP_DEVICE: missing**"     
