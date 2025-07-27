#!/bin/bash
# Script to clean buildroot configuration
# Author: Your Name

set -e
cd `dirname $0`

echo "Cleaning buildroot..."
make -C buildroot distclean

echo "Removing generated configurations..."
rm -f base_external/configs/aesd_qemu_defconfig
