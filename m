Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 112AA3546CB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 20:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235272AbhDESkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 14:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234701AbhDESkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 14:40:07 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1466C061756
        for <linux-kernel@vger.kernel.org>; Mon,  5 Apr 2021 11:39:58 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id r14-20020a05600c35ceb029010fe0f81519so4564626wmq.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Apr 2021 11:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=G8yFWb79A+f9Rm6R5nOamPLnCYJnizt6Qoeu+M+T4Os=;
        b=AoEN52puaw4Grah7Fztfb0/x0ny+7Rxl+EvdcrV5Nam2KKCdwOgXYT4fGkhvoJ7oSQ
         U0xsnfYFcNP+LcKJNSF3707Fse22yWTssZH8O+68vnqdXUq3WXEPmkShZKmlSr44dEt4
         Kpm87/Q9yPLPlPYDKzxDO2OYSiYWPocYLJcnmKrXOuMQLRSePN0xo0ZU3tavfh8+5tIz
         8TXEz63mpMZdWHxSxAlRaEmMfRhu1tbAeiomovkv0/Q8hNoTEXqx3gHAcIuj95eFR+73
         V3qDcLJSdYnq+sD0Rya8JWzZNITS4hnOYlbfNzGBnKf5ow9ojMnAzeL4d9HbPBvSPAVf
         dy6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=G8yFWb79A+f9Rm6R5nOamPLnCYJnizt6Qoeu+M+T4Os=;
        b=eRpmnv+Ed3NoxbdJXxrFs9wWLoSJ2Reufm9fTcAWoX2mcw27kEBaHsgdSTjn+yZnKz
         9WxpsmDXLGaUlAIbOREPHXm4x89fmBp877kedIv4bLhlHJnZxs/6V3Alu9eVCoc+zKBq
         1LS0Ri1rtgNthJzSzK76BW1QOWLHhF3AF9mLxoPzcCSy2zo7iBPSVxsXBnWsl/N/Kume
         I547MAWs8foWTpGzWJC27208f+EZAb4c6Pbxdli3MAgqdfAxp6mshMW5JFqEKFgVEqmG
         GAkPxO6nGvwW3/fn5wdExS5h5MCJYMPULBMW4rJR2tCrPn8N6h+Pxvf5j7djTVaUAGuZ
         fAxg==
X-Gm-Message-State: AOAM533DDgqJc4xk/T3dX1WGmxaXrNv8knFQqznHW93b8jIhbs60jy72
        gupDz56ckVGoXsRGkQZM0zI=
X-Google-Smtp-Source: ABdhPJzLn4Lfz3aUV29L9HDO6djDzpwhkKfv8bxrbKwhzlThKJPxKt78M1n6jifqAyJpkTncgcg/GQ==
X-Received: by 2002:a05:600c:358c:: with SMTP id p12mr403673wmq.19.1617647997382;
        Mon, 05 Apr 2021 11:39:57 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id d5sm4740409wrx.0.2021.04.05.11.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Apr 2021 11:39:56 -0700 (PDT)
Date:   Mon, 5 Apr 2021 20:39:54 +0200
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     linus.walleij@linaro.org, ulli.kroll@googlemail.com,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: gemini: sl3516: Mainlining of NS 2502
Message-ID: <YGtZeofmBv7hXK+a@Red>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I own an Edimax NS 2502, which is a NAS based on StormLinix 3516.

I successfully upgraded it with a recent Linux.
The DTB I use is the following:
/dts-v1/;
#include "gemini.dtsi"
#include <dt-bindings/input/input.h>
/ {
	model = "Edimax NS-2502";
	compatible = "edimax,ns-2502", "cortina,gemini";
	#address-cells = <1>;
	#size-cells = <1>;
	memory@0 {
		/* 128 MB */
		device_type = "memory";
		reg = <0x00000000 0x8000000>;
	};
	chosen {
		bootargs = "console=ttyS0,19200n8";
		stdout-path = &uart0;
	};
	mdio0: ethernet-phy {
		compatible = "virtual,mdio-gpio";
		gpios = <&gpio0 22 GPIO_ACTIVE_HIGH>, /* MDC */
			<&gpio0 21 GPIO_ACTIVE_HIGH>; /* MDIO */
		#address-cells = <1>;
		#size-cells = <0>;
		phy0: ethernet-phy@1 {
			reg = <1>;
			device_type = "ethernet-phy";
		};
	};
	soc {
		flash@30000000 {
			status = "okay";
			/* 8MB of flash */
			reg = <0x30000000 0x00800000>;
			partition@0 {
				label = "RedBoot";
				reg = <0x00000000 0x00020000>;
				read-only;
			};
			partition@20000 {
				label = "kernel";
				reg = <0x00020000 0x00700000>;
			};
			partition@720000 {
				label = "VCTL";
				reg = <0x00720000 0x00020000>;
				read-only;
			};
			partition@740000 {
				label = "CurConf";
				reg = <0x00740000 0x000a0000>;
				read-only;
			};
			partition@7e0000 {
				label = "FIS";
				reg = <0x007e0000 0x00010000>;
				read-only;
			};
		};
		syscon: syscon@40000000 {
			pinctrl {
				/*
				 * gpio0agrp cover line 0-4
				 * gpio0bgrp cover line 5
				 */
				gpio0_default_pins: pinctrl-gpio0 {
					mux {
						function = "gpio0";
						groups = "gpio0agrp",
						"gpio0bgrp";
					};
				};
			};
		};
		gpio0: gpio@4d000000 {
			pinctrl-names = "default";
			pinctrl-0 = <&gpio0_default_pins>;
		};
		ethernet@60000000 {
			status = "okay";
			ethernet-port@0 {
				phy-mode = "rgmii";
				phy-handle = <&phy0>;
			};
			ethernet-port@1 {
				/* Not used in this platform */
			};
		};
		usb@68000000 {
			status = "okay";
		};
		usb@69000000 {
			status = "okay";
		};
	};
};

This is a bit of copy paste of other DTB.
With it I boot successfully to a shell.

BUT neither ethernet nor USB works.
This is the bootlog:
Flash Block Size = 65536

Storlink SL351x Boot Loader [Linux], version 1.0.9
Built by linux, 10:50:46, Aug  6 2008

Processor: SL3516c2
CPU Rate: 300000000
AHB Bus Clock:150MHz    Ratio:2/1
MAC 1 Address: 00:00:25:02:00:00
MAC 2 Address: 00:01:25:02:00:00
inet addr: 192.168.1.237/255.255.255.0
==> enter ^C to abort booting within 2 seconds ......
Load Kern image from 0x30020000 to 0x800000 size 7340032
Booting Linux on physical CPU 0x0
Linux version 5.12.0-rc5-next-20210401+ (compile@Red) (armv7a-unknown-linux-gnueabihf-gcc (Gentoo 9.3.0-r2 p4) 9.3.0, GNU ld (Gentoo 2.34 p6) 2.34.0) #47 PREEMPT Mon Apr 5 20:20:27 CEST 2021
CPU: FA526 [66015261] revision 1 (ARMv4), cr=0000397f
CPU: VIVT data cache, VIVT instruction cache
OF: fdt: Machine model: Edimax NS-2502
Memory policy: Data cache writeback
Zone ranges:
  Normal   [mem 0x0000000000000000-0x0000000007ffffff]
  HighMem  empty
Movable zone start for each node
Early memory node ranges
  node   0: [mem 0x0000000000000000-0x0000000007ffffff]
Initmem setup node 0 [mem 0x0000000000000000-0x0000000007ffffff]
Built 1 zonelists, mobility grouping on.  Total pages: 32512
Kernel command line: console=ttyS0,19200n8
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes, linear)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes, linear)
mem auto-init: stack:off, heap alloc:off, heap free:off
Memory: 119300K/131072K available (4922K kernel code, 577K rwdata, 1344K rodata, 3340K init, 212K bss, 11772K reserved, 0K cma-reserved, 0K highmem)
SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
rcu: Preemptible hierarchical RCU implementation.
        Trampoline variant of Tasks RCU enabled.
rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.
NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
random: get_random_bytes called from start_kernel+0x2fc/0x4f0 with crng_init=0
clocksource: FTTMR010-TIMER2: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 76450417870 ns
sched_clock: 32 bits at 25MHz, resolution 40ns, wraps every 85899345900ns
Switching to timer-based delay loop, resolution 40ns
Console: colour dummy device 80x30
Calibrating delay loop (skipped), value calculated using timer frequency.. 50.00 BogoMIPS (lpj=250000)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 1024 (order: 0, 4096 bytes, linear)
Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes, linear)
CPU: Testing write buffer coherency: ok
Setting up static identity map for 0x81e0 - 0x8228
rcu: Hierarchical SRCU implementation.
devtmpfs: initialized
clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
futex hash table entries: 256 (order: -1, 3072 bytes, linear)
pinctrl core: initialized pinctrl subsystem
NET: Registered protocol family 16
DMA: preallocated 256 KiB pool for atomic coherent allocations
thermal_sys: Registered thermal governor 'step_wise'
No ATAGs?
pinctrl-gemini 40000000.syscon:pinctrl: detected 3516 chip variant
pinctrl-gemini 40000000.syscon:pinctrl: GLOBAL MISC CTRL at boot: 0x83c22037
pinctrl-gemini 40000000.syscon:pinctrl: flash pin is not set
pinctrl-gemini 40000000.syscon:pinctrl: initialized Gemini pin control driver
random: fast init done
pl08xdmac 67000000.dma-controller: FTDMAC020 1.16 rel 1
pl08xdmac 67000000.dma-controller: FTDMAC020 4 channels, has built-in bridge, AHB0 and AHB1, supports linked lists
pl08xdmac 67000000.dma-controller: initialized 4 virtual memcpy channels
pl08xdmac 67000000.dma-controller: DMA: PL080 rev0 at 0x67000000 irq 27
Gemini SoC 3516 revision c2, set arbitration 00200030
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
clocksource: Switched to clocksource FTTMR010-TIMER2
NET: Registered protocol family 2
IP idents hash table entries: 2048 (order: 2, 16384 bytes, linear)
tcp_listen_portaddr_hash hash table entries: 512 (order: 0, 4096 bytes, linear)
TCP established hash table entries: 1024 (order: 0, 4096 bytes, linear)
TCP bind hash table entries: 1024 (order: 0, 4096 bytes, linear)
TCP: Hash tables configured (established 1024 bind 1024)
UDP hash table entries: 256 (order: 0, 4096 bytes, linear)
UDP-Lite hash table entries: 256 (order: 0, 4096 bytes, linear)
NET: Registered protocol family 1
Initialise system trusted keyrings
workingset: timestamp_bits=30 max_order=15 bucket_order=0
romfs: ROMFS MTD (C) 2007 Red Hat, Inc.
NET: Registered protocol family 38
Key type asymmetric registered
Asymmetric key parser 'x509' registered
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 251)
io scheduler mq-deadline registered
io scheduler kyber registered
ftgpio010-gpio 4d000000.gpio: FTGPIO010 @(ptrval) registered
ftgpio010-gpio 4e000000.gpio: FTGPIO010 @(ptrval) registered
ftgpio010-gpio 4f000000.gpio: FTGPIO010 @(ptrval) registered
Serial: 8250/16550 driver, 1 ports, IRQ sharing disabled
printk: console [ttyS0] disabled
42000000.serial: ttyS0 at MMIO 0x42000000 (irq = 18, base_baud = 3000000) is a 16550A
printk: console [ttyS0] enabled
brd: module loaded
physmap-flash 30000000.flash: no enabled pin control state
physmap-flash 30000000.flash: no disabled pin control state
physmap-flash 30000000.flash: initialized Gemini-specific physmap control
physmap-flash 30000000.flash: physmap platform flash device: [mem 0x30000000-0x307fffff]
30000000.flash: Found 1 x16 devices at 0x0 in 16-bit bank. Manufacturer ID 0x0000c2 Chip ID 0x0022cb
Support for command set 0002 not present
gen_probe: No supported Vendor Command Set found
physmap-flash 30000000.flash: map_probe failed
libphy: Fixed MDIO Bus: probed
mdio-gpio ethernet-phy: failed to get alias id
libphy: GPIO Bitbanged MDIO: probed
tun: Universal TUN/TAP device driver, 1.6
gmac-gemini 60000000.ethernet: Ethernet device ID: 0x000, revision 0x1
gemini-ethernet-port 60008000.ethernet-port: probe 60008000.ethernet-port ID 0
gemini-ethernet-port 60008000.ethernet-port: using a random ethernet address
RTL8211B Gigabit Ethernet gpio-0:01: attached PHY driver (mii_bus:phy_addr=gpio-0:01, irq=POLL)
gemini-ethernet-port 60008000.ethernet-port eth0: irq 30, DMA @ 0x0x60008000, GMAC @ 0x0x6000a000
gemini-ethernet-port 6000c000.ethernet-port: probe 6000c000.ethernet-port ID 1
gemini-ethernet-port 6000c000.ethernet-port: using a random ethernet address
gemini-ethernet-port 6000c000.ethernet-port (unnamed net_device) (uninitialized): PHY init failed
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
fotg210_hcd: FOTG210 Host Controller (EHCI) Driver
fotg210-hcd 68000000.usb: Faraday USB2.0 Host Controller
fotg210-hcd 68000000.usb: new USB bus registered, assigned bus number 1
fotg210-hcd 68000000.usb: irq 28, io mem 0x68000000
fotg210-hcd 68000000.usb: USB 2.0 started, EHCI 1.00
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
fotg210-hcd 69000000.usb: Faraday USB2.0 Host Controller
fotg210-hcd 69000000.usb: new USB bus registered, assigned bus number 2
fotg210-hcd 69000000.usb: irq 29, io mem 0x69000000
fotg210-hcd 69000000.usb: USB 2.0 started, EHCI 1.00
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 1 port detected
usbcore: registered new interface driver usb-storage
rtc-ftrtc010 45000000.rtc: registered as rtc0
rtc-ftrtc010 45000000.rtc: setting system clock to 1970-01-01T00:00:00 UTC (0)
gemini-poweroff 4b000000.power-controller: other power management IRQ
gemini-poweroff 4b000000.power-controller: Gemini poweroff driver registered
ftwdt010-wdt 41000000.watchdog: FTWDT010 watchdog driver enabled
device-mapper: ioctl: 4.45.0-ioctl (2021-03-22) initialised: dm-devel@redhat.com
NET: Registered protocol family 10
Segment Routing with IPv6
sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
8021q: 802.1Q VLAN Support v1.8
Loading compiled-in X.509 certificates
Freeing unused kernel memory: 3340K
Kernel memory protection not selected by kernel config.
Run /init as init process
Starting syslogd: OK
Starting klogd: OK
Running sysctl: OK
Saving random seed: random: dd: uninitialized urandom read (512 bytes read)
OK
Starting network: OK
random: crng init done
ssh-keygen: generating new host keys: RSA DSA ECDSA ED25519
Starting sshd: OK

Welcome to Buildroot
ns2502 login: root
# ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop qlen 1000
    link/ether b6:95:3c:18:98:62 brd ff:ff:ff:ff:ff:ff
3: sit0@NONE: <NOARP> mtu 1480 qdisc noop qlen 1000
    link/sit 0.0.0.0 brd 0.0.0.0
# udhcpc -i eth0
udhcpc: started, v1.33.0
gmac-gemini 60000000.ethernet: allocate 512 pages for queue
gemini-ethernet-port 60008000.ethernet-port eth0: Unsupported PHY speed (-1) on gpio-0:01
gemini-ethernet-port 60008000.ethernet-port eth0: Link is Down
gemini-ethernet-port 60008000.ethernet-port eth0: link flow control: none
udhcpc: socket: Address family not supported by protocol
# gemini-ethernet-port 60008000.ethernet-port eth0: Link is Up - 1Gbps/Full - flow control rx/tx
gemini-ethernet-port 60008000.ethernet-port eth0: link flow control: tx
IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready

# udhcpc -i eth0
udhcpc: started, v1.33.0
udhcpc: socket: Address family not supported by protocol


Inserting an USB dongle give nothing.
As shown, udhcp cannot get an IP.
Setting one at hand does not fix anything, ping fail.

Can someone help me bring up at least ethernet ?

Thanks
