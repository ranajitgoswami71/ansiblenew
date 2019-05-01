a=`lsblk | grep xvdb | wc -l`

if [ $a -eq 1 ]

then

echo -e "\np\nn\np\n1\n\n\nw\n"         | fdisk /dev/xvdb
partprobe /dev/xvdb
/sbin/mkfs.xfs -L /u03 /dev/xvdb1 -f
mkdir -p /u03
echo "/dev/xvdb1    /u03    xfs    defaults   0 0" >> /etc/fstab
mount -a -v | tee -a /tmp/mount.log
mkdir -p /u03/app/oracle/product/12.1.0/dbhome_1
chown -R ubuntu:ubuntu /u03
chmod 775 -R /u03

else

rm -R -f /u03
mkdir -p /u03
echo "/dev/xvdb1    /u03    xfs    defaults   0 0" >> /etc/fstab
mount -a -v | tee -a /tmp/mount.log
mkdir -p /u03/app/oracle/product/12.1.0/dbhome_1
chown -R ubuntu:ubuntu /u03
chmod 775 -R /u03

fi