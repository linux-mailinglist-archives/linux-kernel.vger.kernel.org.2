Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 862E23A35D9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 23:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbhFJVbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 17:31:05 -0400
Received: from mail-il1-f179.google.com ([209.85.166.179]:40712 "EHLO
        mail-il1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbhFJVbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 17:31:04 -0400
Received: by mail-il1-f179.google.com with SMTP id b14so3196733ilq.7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 14:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=g-ucla-edu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kM53Bhk37xfznO5V/aazbzKjR43EQA0kB7o1nO3KlkU=;
        b=HuHVldQyoF5v9Ag6iJvIx2uwVlSt9/2kOi4adwU5kaMm7tCl5kXno3XnOhT03sy0TK
         Aj1Sj82F83OmWze2Rq6zsSZQozxeekyBplThNXHRQHhHbn2bpJyXaRAmJ2d+DlELTa6H
         AvUFUykqEpO68JTgq9zJY7LuZXu4/QFfzW3nwTuOD/0abqJUOLsOgmhYbXPdfiIiFmII
         TQvFt/g/2ozJnNSvFb3IH7dtlPrw6Z7e9IF8ruQK3MvAXDjkdzfVJwW8fXIVbNMFihYc
         /dv8hDYwJ3kL6xP7zajx8mm/Ebqwdp+VLYw0+k67o+5Oh02xvFGOmCxkK6KXZxk/FXhF
         2Ilw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kM53Bhk37xfznO5V/aazbzKjR43EQA0kB7o1nO3KlkU=;
        b=Sz26wzGUCPx7KSht7rWIKQkDXYsUm5P2FR9Q1ubDSReV5tHxL7Q9BbklE0T8HiiCHa
         O7LcIt6plVd5yEojdVG0AMkiAGcs1cg7RspviN7QY/Z+nwvSRwj5KDMaVAas2pLCBzpr
         wgDMSIBVTRrN1pUlhzNehq1EgzUEGAMluZsufNIL1JE1ZSEhjbC3j2I3/1pMytwtMOlb
         mAf+LFLZi1ylgN7GUlr8F9QcSJsS9dx8KYSSq0Aeze91tgviD2JZuDLKknx8GEi2X9LW
         i3paqABsq/SRUu2Ho0XVetXaNlX51P3CSAhCsgKacBWbfPqv5ZUzk1F41yPxrNwqimIK
         GFHg==
X-Gm-Message-State: AOAM531vzsqWnbTgeudHq0HpiruwXeNYDg0udgoNnUheMjzWIIbq6aa5
        YXiMGKzrHtiSkUMSzrLazNWdLXNVxfwRPpdBsV40i/Gl/8Yovw==
X-Google-Smtp-Source: ABdhPJxIuqOosZFCZ6l/lcYQzwA33A6KPg3qanR9GQWtCucxK+j+e33hfLOGuHzyeS/x3GjJ+LYl8DXVj7+IFINS+4c=
X-Received: by 2002:a05:6e02:ec5:: with SMTP id i5mr625984ilk.168.1623360470297;
 Thu, 10 Jun 2021 14:27:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAMcO1Vu0e3mfK-s-vh57UmRu8_L_E_Q6n_d95U88j3wG3Sxaow@mail.gmail.com>
 <CAOoBcBVf2FNHu_CqNt9HoBR9Hm5y8+H0dLhvh2yD66b50E2ssA@mail.gmail.com>
In-Reply-To: <CAOoBcBVf2FNHu_CqNt9HoBR9Hm5y8+H0dLhvh2yD66b50E2ssA@mail.gmail.com>
From:   Sean Quinn <spq@g.ucla.edu>
Date:   Thu, 10 Jun 2021 14:27:24 -0700
Message-ID: <CAMcO1Vs4gPRmfrqpn7eBSe3mAiuiELh=fVDWhjKT_hgq-04bcQ@mail.gmail.com>
Subject: Re: Reserving memory
To:     Austin Kim <austinkernel.kim@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Austin,

Thanks for the reply!

Yeah, I am not sure what's going on with that address.

At any rate, I tested some other configurations using only 5.4 now

If I use the updated device tree below, things seem to work alright!
It boots, it's stable, I can devmem stuff into that region etc. Still
have to test out if the DMA device writes will succeed.

/ {
 model =3D "Enclustra MA-ZX2-10-2I-D9 SOM";
 chosen {
  bootargs =3D "console=3DttyPS0,115200 earlycon vmalloc=3D512M
root=3D/dev/mmcblk0p2 rw rootwait";
 };
 reserved-memory {
 #address-cells =3D <1>;
 #size-cells =3D <1>;
 ranges;

 fpga_reserved1: rambuffer@0x4000000 {
  reg =3D <0x4000000 0x8400000>;
 };
 };
};

Boot log

U-Boot 2020.01 (Jun 09 2021 - 21:37:56 +0000)

CPU:   Zynq 7z010
Silicon: v3.1
Model: Enclustra MA-ZX2-10-2I-D9 SOM
DRAM:  ECC disabled 512 MiB
Flash: 0 Bytes
NAND:  0 MiB
MMC:   mmc@e0100000: 0
Loading Environment from FAT... *** Warning - bad CRC, using default enviro=
nment

Loading Environment from SPI Flash... SF: Detected s25fl512s_256k with
page size 256 Bytes, erase size 256 KiB, total 64 MiB
*** Warning - bad CRC, using default environment

In:    serial@e0000000
Out:   serial@e0000000
Err:   serial@e0000000
Net:
ZYNQ GEM: e000b000, mdio bus e000b000, phyaddr 3, interface rgmii-id
eth0: ethernet@e000b000
Hit any key to stop autoboot:  0
switch to partitions #0, OK
mmc0 is current device
Scanning mmc 0:1...
Found U-Boot script /boot.scr
2010 bytes read in 19 ms (102.5 KiB/s)
## Executing script at 03000000
4349956 bytes read in 328 ms (12.6 MiB/s)
## Loading kernel from FIT Image at 10000000 ...
   Using 'conf@system-top.dtb' configuration
   Verifying Hash Integrity ... OK
   Trying 'kernel@1' kernel subimage
     Description:  Linux kernel
     Type:         Kernel Image
     Compression:  uncompressed
     Data Start:   0x100000f8
     Data Size:    4328048 Bytes =3D 4.1 MiB
     Architecture: ARM
     OS:           Linux
     Load Address: 0x00200000
     Entry Point:  0x00200000
     Hash algo:    sha256
     Hash value:
efedbd67e6d5dc525817819550a182c9650143669af52c31fa7d49cf57156a25
   Verifying Hash Integrity ... sha256+ OK
## Loading fdt from FIT Image at 10000000 ...
   Using 'conf@system-top.dtb' configuration
   Verifying Hash Integrity ... OK
   Trying 'fdt@system-top.dtb' fdt subimage
     Description:  Flattened Device Tree blob
     Type:         Flat Device Tree
     Compression:  uncompressed
     Data Start:   0x10420c74
     Data Size:    20009 Bytes =3D 19.5 KiB
     Architecture: ARM
     Hash algo:    sha256
     Hash value:
141f7ed36d3e8e1bc1d72085104e7bc77fa0658be04e427b4c0413ddd3a757c0
   Verifying Hash Integrity ... sha256+ OK
   Booting using the fdt blob at 0x10420c74
   Loading Kernel Image
   Loading Device Tree to 1eafe000, end 1eb05e28 ... OK

Starting kernel ...

Booting Linux on physical CPU 0x0
Linux version 5.4.0-xilinx-v2020.1 (oe-user@oe-host) (gcc version
9.2.0 (GCC)) #1 SMP PREEMPT Sat Jun 5 00:08:36 UTC 2021
CPU: ARMv7 Processor [413fc090] revision 0 (ARMv7), cr=3D18c5387d
CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
OF: fdt: Machine model: Enclustra MA-ZX2-10-2I-D9 SOM
earlycon: cdns0 at MMIO 0xe0000000 (options '115200n8')
printk: bootconsole [cdns0] enabled
Memory policy: Data cache writealloc
cma: Reserved 16 MiB at 0x1d800000
percpu: Embedded 15 pages/cpu s31948 r8192 d21300 u61440
Built 1 zonelists, mobility grouping on.  Total pages: 129938
Kernel command line: console=3DttyPS0,115200 earlycon vmalloc=3D512M
root=3D/dev/mmcblk0p2 rw rootwait
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes, linear)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes, linear)
mem auto-init: stack:off, heap alloc:off, heap free:off
Memory: 356396K/524288K available (6144K kernel code, 220K rwdata,
1844K rodata, 1024K init, 131K bss, 151508K reserved, 16384K
cma-reserved, 8192K highmem)
rcu: Preemptible hierarchical RCU implementation.
rcu: RCU restricting CPUs from NR_CPUS=3D4 to nr_cpu_ids=3D2.
Tasks RCU enabled.
rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.
rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=3D2
NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
efuse mapped to (ptrval)
slcr mapped to (ptrval)
L2C: platform modifies aux control register: 0x72360000 -> 0x72760000
L2C: DT/platform modifies aux control register: 0x72360000 -> 0x72760000
L2C-310 erratum 769419 enabled
L2C-310 enabling early BRESP for Cortex-A9
L2C-310 full line of zeros enabled for Cortex-A9
L2C-310 ID prefetch enabled, offset 1 lines
L2C-310 dynamic clock gating enabled, standby mode enabled
L2C-310 cache controller enabled, 8 ways, 512 kB
L2C-310: CACHE_ID 0x410000c8, AUX_CTRL 0x76760001
random: get_random_bytes called from start_kernel+0x260/0x440 with crng_ini=
t=3D0
zynq_clock_init: clkc starts at (ptrval)
Zynq clock init
sched_clock: 64 bits at 333MHz, resolution 3ns, wraps every 4398046511103ns
clocksource: arm_global_timer: mask: 0xffffffffffffffff max_cycles:
0x4ce07af025, max_idle_ns: 440795209040 ns
Switching to timer-based delay loop, resolution 3ns
Console: colour dummy device 80x30
Calibrating delay loop (skipped), value calculated using timer
frequency.. 666.66 BogoMIPS (lpj=3D3333333)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 1024 (order: 0, 4096 bytes, linear)
Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes, linear)
CPU: Testing write buffer coherency: ok
CPU0: Spectre v2: using BPIALL workaround
CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
Setting up static identity map for 0x100000 - 0x100060
rcu: Hierarchical SRCU implementation.
smp: Bringing up secondary CPUs ...
CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
CPU1: Spectre v2: using BPIALL workaround
smp: Brought up 1 node, 2 CPUs
SMP: Total of 2 processors activated (1333.33 BogoMIPS).
CPU: All CPU(s) started in SVC mode.
devtmpfs: initialized
VFP support v0.3: implementor 41 architecture 3 part 30 variant 9 rev 4
clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff,
max_idle_ns: 19112604462750000 ns
futex hash table entries: 512 (order: 3, 32768 bytes, linear)
pinctrl core: initialized pinctrl subsystem
NET: Registered protocol family 16
DMA: preallocated 256 KiB pool for atomic coherent allocations
cpuidle: using governor menu
hw-breakpoint: found 5 (+1 reserved) breakpoint and 1 watchpoint registers.
hw-breakpoint: maximum watchpoint size is 4 bytes.
zynq-ocm f800c000.ocmc: ZYNQ OCM pool: 256 KiB @ 0x(ptrval)
e0000000.serial: ttyPS0 at MMIO 0xe0000000 (irq =3D 25, base_baud =3D
6249999) is a xuartps
printk: console [ttyPS0] enabled
printk: console [ttyPS0] enabled
printk: bootconsole [cdns0] disabled
printk: bootconsole [cdns0] disabled
vgaarb: loaded
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
mc: Linux media interface: v0.10
videodev: Linux video capture interface: v2.00
pps_core: LinuxPPS API ver. 1 registered
pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti
<giometti@linux.it>
PTP clock support registered
EDAC MC: Ver: 3.0.0
FPGA manager framework
Advanced Linux Sound Architecture Driver Initialized.
clocksource: Switched to clocksource arm_global_timer
thermal_sys: Registered thermal governor 'step_wise'
NET: Registered protocol family 2
tcp_listen_portaddr_hash hash table entries: 512 (order: 0, 6144 bytes, lin=
ear)
TCP established hash table entries: 4096 (order: 2, 16384 bytes, linear)
TCP bind hash table entries: 4096 (order: 3, 32768 bytes, linear)
TCP: Hash tables configured (established 4096 bind 4096)
UDP hash table entries: 256 (order: 1, 8192 bytes, linear)
UDP-Lite hash table entries: 256 (order: 1, 8192 bytes, linear)
NET: Registered protocol family 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
PCI: CLS 0 bytes, default 64
hw perfevents: no interrupt-affinity property for /pmu@f8891000, guessing.
hw perfevents: enabled with armv7_cortex_a9 PMU driver, 7 counters availabl=
e
workingset: timestamp_bits=3D14 max_order=3D17 bucket_order=3D3
jffs2: version 2.2. (NAND) (SUMMARY)  =C2=A9 2001-2006 Red Hat, Inc.
bounce: pool size: 64 pages
io scheduler mq-deadline registered
io scheduler kyber registered
zynq-pinctrl 700.pinctrl: zynq pinctrl initialized
dma-pl330 f8003000.dmac: Loaded driver for PL330 DMAC-241330
dma-pl330 f8003000.dmac: DBUFF-128x8bytes Num_Chans-8 Num_Peri-4 Num_Events=
-16
brd: module loaded
loop: module loaded
spi_master spi0: cannot find modalias for /amba/spi@e000d000/flash@0
spi_master spi0: Failed to create SPI device for /amba/spi@e000d000/flash@0
libphy: Fixed MDIO Bus: probed
CAN device driver interface
libphy: MACB_mii_bus: probed
Micrel KSZ9031 Gigabit PHY e000b000.ethernet-ffffffff:03: attached PHY
driver [Micrel KSZ9031 Gigabit PHY]
(mii_bus:phy_addr=3De000b000.ethernet-ffffffff:03, irq=3DPOLL)
macb e000b000.ethernet eth0: Cadence GEM rev 0x00020118 at 0xe000b000
irq 27 (XX:XX:XX:XX:XX:XX)
e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci-pci: EHCI PCI platform driver
usbcore: registered new interface driver usb-storage
i2c /dev entries driver
cdns-i2c e0004000.i2c: 100 kHz mmio e0004000 irq 22
cdns-wdt f8005000.watchdog: Xilinx Watchdog Timer with timeout 10s
EDAC MC: ECC not enabled
Xilinx Zynq CpuIdle Driver started
sdhci: Secure Digital Host Controller Interface driver
sdhci: Copyright(c) Pierre Ossman
sdhci-pltfm: SDHCI platform and OF driver helper
mmc0: SDHCI controller on e0100000.mmc [e0100000.mmc] using ADMA
ledtrig-cpu: registered to indicate activity on CPUs
clocksource: ttc_clocksource: mask: 0xffff max_cycles: 0xffff,
max_idle_ns: 537538477 ns
timer #0 at (ptrval), irq=3D40
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
fpga_manager fpga0: Xilinx Zynq FPGA Manager registered
NET: Registered protocol family 10
Segment Routing with IPv6
sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
NET: Registered protocol family 17
can: controller area network core (rev 20170425 abi 9)
NET: Registered protocol family 29
can: raw protocol (rev 20170425)
can: broadcast manager protocol (rev 20170425 t)
can: netlink gateway (rev 20190810) max_hops=3D1
Registering SWP/SWPB emulation handler
of-fpga-region fpga-full: FPGA Region probed
hctosys: unable to open rtc device (rtc0)
of_cfs_init
of_cfs_init: OK
ALSA device list:
  No soundcards found.
Waiting for root device /dev/mmcblk0p2...
mmc0: new high speed SDHC card at address e624
mmcblk0: mmc0:e624 SA08G 7.40 GiB
 mmcblk0: p1 p2
EXT4-fs (mmcblk0p2): mounted filesystem with ordered data mode. Opts: (null=
)
VFS: Mounted root (ext4 filesystem) on device 179:2.
devtmpfs: mounted
Freeing unused kernel memory: 1024K
Run /sbin/init as init process
random: fast init done
systemd[1]: System time before build time, advancing clock.
systemd[1]: Failed to look up module alias 'autofs4': Function not implemen=
ted
systemd[1]: systemd 245.4-4ubuntu3.6 running in system mode. (+PAM
+AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP
+GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2
-IDN +PCRE2 default-hierarchy=3Dhybrid)
systemd[1]: Detected architecture arm.

On Wed, Jun 9, 2021 at 4:51 PM Austin Kim <austinkernel.kim@gmail.com> wrot=
e:
>
> Hello,
>
> 2021=EB=85=84 6=EC=9B=94 9=EC=9D=BC (=EC=88=98) =EC=98=A4=ED=9B=84 5:33, =
Sean Quinn <spq@g.ucla.edu>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> >
> > Hi,
> >
> > Kernel newb here, sorry if this is could be sent to a more suitable lis=
t.
> >
> > I have an embedded project using a Zynq based SoM (Enclustra
> > MA-ZX2-10-2I-D9 SOM). We have a device using a DMA that writes data
> > into system SDRAM shared by the processing system/OS.
> >
> > [..]
> > 8<--- cut here ---
> > Unable to handle kernel paging request at virtual address deafe000
>
> It seems that void *fdt contains deafe000, which is not handled by mmu.
>
> https://elixir.bootlin.com/linux/v5.4.124/source/scripts/dtc/libfdt/fdt.c
> int fdt_check_header(const void *fdt)
> {
> size_t hdrsize;
>
> if (fdt_magic(fdt) !=3D FDT_MAGIC)  //<<-- exception point
> return -FDT_ERR_BADMAGIC;
