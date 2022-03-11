initramfs.cpio.gz: initramfs_1.cpio.gz modules.cpio.gz confs.cpio.gz
	cat initramfs_1.cpio.gz modules.cpio.gz confs.cpio.gz > initramfs.cpio.gz
initramfs_1.cpio.gz:
	mkinitfs -P $(realpath confs/features.d) -c mkinitfs.conf -i init -K -n -o initramfs_1.cpio.gz
modules.cpio.gz:
	find /lib/modules | cpio --quiet -H newc -o | gzip -9 > modules.cpio.gz
confs.cpio.gz:
	find confs | cpio --quiet -H newc -o | \
		gzip -9 > confs.cpio.gz
test:
	mkinitfs -P $(realpath confs/features.d) -c mkinitfs.conf -i init -K -l -n
clean:
	rm initramfs.cpio.gz initramfs_1.cpio.gz confs.cpio.gz modules.cpio.gz
