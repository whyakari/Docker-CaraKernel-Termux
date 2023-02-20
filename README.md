# Docker-CaraKernel-Termux
> a repository to help you use **Docker** in Termux with the "CaraKernel" kernel

---

### Requirements:
 - **CaraKernel Support** (I just tested it on device [#Ginkgo](https://github.com/AkariOficial/Docker-CaraKernel-Termux#this-step-would-be-the-compilation-of-the-kernel-but-not-necessarily-if-your-kernel-already-has-the-parameters-enabled-good-luck))
 - **Recovery** (Recommended [OrangeFox](https://orangefox.download/))
 - **Module** [CaraKernel](https://t.me/GinkgoKernel/5804/40574?single) (necessary to work!)
 - **Magisk/ROOT** ([v23+](https://github.com/topjohnwu/Magisk))
 
 - **Some** [#Notes](https://github.com/AkariOficial/Docker-CaraKernel-Termux/blob/main/README.md#some-important-notes-to-read) **that are worth reading.**

---

1. __First I rooted my Xiaomi Redmi Note 8. Then I installed [PixelOS](https://pixelos.net/download) Android 13.__
2. __Install [Termux](https://github.com/HardcodedCat/termux-monet). Then execute Moby’s script to check kernel’s compatibility o running docker.__

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
 1. Before changing kernels, **backup dtbo and boot**
 2. **Download** [CaraKernel](https://t.me/GinkgoKernel/5804/40573?single) (for ginkgo)
 3. **Flash the ZIP to your** [#RECOVERY](https://github.com/AkariOficial/Docker-CaraKernel-Termux#requirements)
 4. **Flash the** [#MAGISK](https://github.com/AkariOficial/Docker-CaraKernel-Termux#requirements) **MANDATORY!**
   > **if it stays in bootloop, boot into recovery and restore the backup you made earlier.**

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

### Install docker and <br> docker-compose:
```bash
 pkg in root-repo -y
 pkg in docker docker-compose -y
```
## warning: docker in its current version will not work. don't install in the normal way above, install from here:
#### [Install Here](https://github.com/AkariOficial/termux-packages#install-package-docker--only-architeture-aarch64)

---

### Start docker daemon (Swipe from left edge of the screen and open a new session. Run containers)
```bash
 sudo dockerd --iptables=false
```

---

##### 3.1.1. Internet access
##### The two network drivers tested so far are `bridge` and `host`. Here's how to get each of them working.
> This is the default netwok driver. If you don't specify a driver, this is the type of network you are creating. Bridge networks isolate the container network by editing the iptables rules and creating a network interface called **Docker0** that serves as a bridge. All containers created with the bridge driver will use this interface. This is analogous to creating a VLAN and running the containers inside it.
##### But, there's a catch in Android: iptables rules policy is different here than on a conventional GNU/Linux system (more info here). For the bridge driver to work, you'll have to manually edit the iptable by running;
```bash
 sudo ip route add default via 192.168.1.1 dev wlan0
 sudo ip rule add from all lookup main pref 30000
```
> Note: change __192.168.1.1__ according to your gateway IP.

Unfortunately, this means that changing networks will require you to re-configure the rules again.

---

### Assuming you've done what you asked above, let's try creating an **Ubuntu** container
```bash
 sudo docker run -it ubuntu bash
```
> **The similar result will be**:
> ![Screenshot_Termux](https://user-images.githubusercontent.com/58480908/218167294-2e31a558-9a79-4ff9-95f2-59d92fa551ab.png)

---

### “Maybe you're wondering why the "apt update" command doesn't work”, yes, I let it go unnoticed, because I want to show you how to fix it:
```bash
sudo docker run -ti \
    --net="host" \
    --dns="8.8.8.8" \
    ubuntu
```
> running this way, the apt command will work normally. <br> ps: **Don't forget to remove the container we created earlier** 
### So we can do this:
```bash
 sudo docker ps -a
 sudo docker rm <container_id>
```
> **something similar to this will be**:
> ![Screenshot_Termux](https://user-images.githubusercontent.com/58480908/218170437-03cbf2d2-9ad1-42f3-a1aa-877a71c5dc3d.jpg)

---

## Some important notes to read:
 - Attention, the current version `Docker version v23.0.1, build` of docker in termux doesn't work correctly. so i compiled `Docker version v20.10.23-ce, build`
 - this method was tested on **Ginkgo** using a **PixelOS** Android 13 custom rom.
 - don't ask me if it works for other types of kernels, I don't know.

 - the kernels I tested and not tested:
   - **CaraKernel Kernel** `[work pass]`
   - **Cryo Kernel** `[test fail]`
   - **ElasticsPerf Kernel** `[not booted]`
   - **Meow Kernel** `[test fail]`
   - **LightNing Kernel** `[test fail]`
   - **Ryzen Kernel** `[idk]`
   - **Syxteen Kernel** `[idk lol]`
   - **QuickSilve Kernel** `[idk, probably fail]`

---

thanks to [Freedie Oliveira](https://gist.github.com/FreddieOliveira/efe850df7ff3951cb62d74bd770dce27) for providing an efficient method 
and also [docker-materia](https://ivonblog.com/en-us/posts/sony-xperia-5-ii-docker-kernel/)
