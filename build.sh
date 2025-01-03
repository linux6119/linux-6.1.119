#!/bin/bash
\cp /boot/$(ls /boot/ | grep config | head -1)  arch/x86/configs/my_defconfig
sed -i 's/^CONFIG_MODULE_SIG=.*/CONFIG_MODULE_SIG=n/' arch/x86/configs/my_defconfig
sed -i 's/^CONFIG_MODULE_SIG_ALL=.*/CONFIG_MODULE_SIG_ALL=n/' arch/x86/configs/my_defconfig
sed -i 's/^CONFIG_SYSTEM_REVOCATION_KEYS=.*/CONFIG_SYSTEM_REVOCATION_KEYS=""/' arch/x86/configs/my_defconfig
sed -i 's/^CONFIG_MODULE_SIG_KEY=.*/CONFIG_MODULE_SIG_KEY=""/' arch/x86/configs/my_defconfig
sed -i 's/^CONFIG_SYSTEM_TRUSTED_KEYS=.*/CONFIG_SYSTEM_TRUSTED_KEYS=""/' arch/x86/configs/my_defconfig
make my_defconfig

if command -v apt &> /dev/null; then
sudo apt-get install build-essential ncurses-dev bison flex libssl-dev libelf-dev
fi

if command -v yum &> /dev/null; then
yum -y install  build-essential ncurses-dev bison flex libssl-dev libelf-dev
yum -y install openssl-devel
fi

make -j$(nproc)
make modules_install
rm -rf /boot/*6.1.119*
make install
