#!/bin/bash
TOOLCHAIN="/home/shivam/development/toolchains/linaro-4.9/bin/arm-eabi"
MODULES_DIR="/home/shivam/development/modules"
ZIMAGE="/home/shivam/development/android_kernel_sony_msm8930_fresh/arch/arm/boot/zImage"
KERNEL_DIR="/home/shivam/development/android_kernel_sony_msm8930_fresh"
BUILD_START=$(date +"%s")
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
BUILD_END=$(date +"%s")
DIFF=$(($BUILD_END - $BUILD_START))
echo "Build completed in $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds."
else
echo "Compilation failed! Fix the errors!"
fi
