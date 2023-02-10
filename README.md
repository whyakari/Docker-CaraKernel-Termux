# Docker-CaraKernel-Termux
> a repository to help you use **Docker** in Termux with the "CaraKernel" kernel

---

### Requirements:
 - CaraKernel Support (I just tested it on device Ginkgo)
 - Recovery (Recommended OrangeFox)
 - Magisk/ROOT (v23+)

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

![Screenshot_Termux](https://user-images.githubusercontent.com/58480908/218159380-4b53280e-e049-4df7-a2ad-2ee46a8e8301.png)
