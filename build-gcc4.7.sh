#!/bin/bash
TOOLCHAIN="/home/shivam/development/arm-linux-androideabi-4.7/bin/arm-linux-androideabi"
MODULES_DIR="/home/shivam/development/modules"
ZIMAGE="/home/shivam/development/android_kernel_sony_msm8930_fresh/arch/arm/boot/zImage"
KERNEL_DIR="/home/shivam/development/android_kernel_sony_msm8930_fresh"
if [ -a $KERNEL_DIR/arch/arm/boot/zImage ];
then
rm $ZIMAGE
rm $MODULES_DIR/*
fi
make ARCH=arm CROSS_COMPILE=$TOOLCHAIN- cyanogenmod_taoshan_defconfig
make ARCH=arm CROSS_COMPILE=$TOOLCHAIN- -j8
if [ -a $KERNEL_DIR/arch/arm/boot/zImage ];
then
echo "Copying modules"
rm $MODULES_DIR/*
find . -name '*.ko' -exec cp {} $MODULES_DIR/ \;
cd $MODULES_DIR
echo "Stripping modules for size"
$TOOLCHAIN-strip --strip-unneeded *.ko
cd $KERNEL_DIR
else
echo "Compilation failed! Fix the errors!"
fi
