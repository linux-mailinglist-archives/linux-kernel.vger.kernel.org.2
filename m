Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5343096FE
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 18:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbhA3RBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 12:01:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhA3RBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 12:01:31 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F69C061573;
        Sat, 30 Jan 2021 09:00:51 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id c127so9584460wmf.5;
        Sat, 30 Jan 2021 09:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=hzLXWw6uvmu+176p4p9kffbjIrYZ0HJrx4Mr7rSdqn4=;
        b=S8JkHvpIONyxqLuCmfdRrCK/8hHDJj+5PIupqGM+XR6vIJMfAOdYT//xjwOWj6dj8M
         JOXjy87V24lYS/lm2Rp0qbChMP5WsHRoZ/yqA5Ywkdfg+mrN9BrUEap2jpz8CItD4HwQ
         6O1DJSkNxDz/NLEMp28Ku8FKOrr5G4PhnpC4YvYxDwIFT8ZnbYrvDdMf++eSPvinhPbI
         y0tBdRZtFX/xMLkKeJG4VLNchRekp5tWJOgwOVkY98BjpjIMCjcJhwy0m/UKcnJW7Zz6
         R4PLX0ReneWmAhiYmTMaD0K5W8CojA3gjsCoCGd4/WCazvvvrrJm/JBs2bYEU9TijzT4
         SNGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=hzLXWw6uvmu+176p4p9kffbjIrYZ0HJrx4Mr7rSdqn4=;
        b=rpAFkbFk6CCDrlPTc5SQvXEpbIT8xNjqk29ZQPJpBUAefTTEkj34AbeLVW1haDfmxO
         nQ+7APODi/dqk6yxrikbC/GCUdALj3BxETteYjIHfp9/fHD4b1cWBP87wn3kZuxb39Jr
         85ywy+lLZi29Ql3w5+mib+esF9B+lxov11zOVH9ojW4rXjFJurVIvF3w1SgnboFhPXuZ
         4XvP5kxXg738vpgSV9NPE3ophDdPk2oGqKULjympZnuuAv28PwcPIybggy9xrz+rMwjH
         9A0cC00oyzmjLoeCykAfhTtHJT7bL5Mxyli6MCHBd7BGboN+Q0vTAAUfQ8oxWZGvK5ZR
         aC/w==
X-Gm-Message-State: AOAM531JBdUp0/2ts401vq02WnCRvr6Yo4CCxrENZfOZUkQhIsNhyndU
        4RJMAwQ/HZ7jzc4ncnQkkeA=
X-Google-Smtp-Source: ABdhPJxefPkMf9eXvnNvsUAkLGMsH/XQYBmOqPBIqcyeg40zgqKLUQtswnXNSbrsRq0mcQL4iNQBdg==
X-Received: by 2002:a1c:4e17:: with SMTP id g23mr8380670wmh.130.1612026049815;
        Sat, 30 Jan 2021 09:00:49 -0800 (PST)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id n15sm18397966wrx.2.2021.01.30.09.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jan 2021 09:00:49 -0800 (PST)
Date:   Sat, 30 Jan 2021 18:00:47 +0100
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     mripard@kernel.org, wens@csie.org, jernej.skrabec@siol.net,
        samuel@sholland.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Fail to boot on bpim3 with next-20210128
Message-ID: <YBWQvzQNC1iYUXoG@Red>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

next-20210128 cannot be booted on my bpim3.
It start booting then freeze.

[    0.000000] Linux version 5.11.0-rc5-03084-g7426957d237f (compile@Red) (armv7a-unknown-linux-gnueabihf-gcc (Gentoo 9.3.0-r2 p4) 9.3.0, GNU ld (Gentoo 2.34 p6) 2.34.0) #390 SMP Sat Jan 30 14:59:48 CET 2021
[    0.000000] CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7), cr=10c5387d
[    0.000000] CPU: div instructions available: patching division code
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] OF: fdt: Machine model: Banana Pi BPI-M3
[    0.000000] earlycon: uart0 at MMIO32 0x01c28000 (options '')
[    0.000000] printk: bootconsole [uart0] enabled
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] cma: Reserved 16 MiB at 0xbf000000
[    0.000000] Zone ranges:
[    0.000000]   Normal   [mem 0x0000000040000000-0x000000006fffffff]
[    0.000000]   HighMem  [mem 0x0000000070000000-0x00000000bfffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000040000000-0x00000000bfffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000040000000-0x00000000bfffffff]
[    0.000000] percpu: Embedded 15 pages/cpu s31244 r8192 d22004 u61440
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 522752
[    0.000000] Kernel command line: console=ttyS0,115200n8 root=/dev/ram0 earlycon=uart,mmio32,0x01c28000 ip=dhcp
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes, linear)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] Memory: 2021376K/2097152K available (7168K kernel code, 934K rwdata, 2316K rodata, 1024K init, 240K bss, 59392K reserved, 16384K cma-reserved, 1294336K highmem)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
[    0.000000] rcu: Hierarchical RCU implementation.
[    0.000000] rcu: 	RCU event tracing is enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.
[    0.000000] NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
[    0.000000] random: get_random_bytes called from start_kernel+0x350/0x4e0 with crng_init=0
[    0.000000] arch_timer: cp15 timer(s) running at 24.00MHz (virt).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x588fe9dc0, max_idle_ns: 440795202592 ns
[    0.000003] sched_clock: 56 bits at 24MHz, resolution 41ns, wraps every 4398046511097ns
[    0.008640] Switching to timer-based delay loop, resolution 41ns
[    0.015437] clocksource: timer: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 79635851949 ns
[    0.025858] Console: colour dummy device 80x30
[    0.030736] Calibrating delay loop (skipped), value calculated using timer frequency.. 48.00 BogoMIPS (lpj=240000)
[    0.041941] pid_max: default: 32768 minimum: 301
[    0.047080] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes, linear)
[    0.054990] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes, linear)
[    0.064421] CPU: Testing write buffer coherency: ok
[    0.070242] /cpus/cpu@0 missing clock-frequency property
[    0.076025] /cpus/cpu@1 missing clock-frequency property
[    0.081805] /cpus/cpu@2 missing clock-frequency property
[    0.087546] /cpus/cpu@3 missing clock-frequency property
[    0.093300] /cpus/cpu@100 missing clock-frequency property
[    0.099227] /cpus/cpu@101 missing clock-frequency property
[    0.105173] /cpus/cpu@102 missing clock-frequency property
[    0.111111] /cpus/cpu@103 missing clock-frequency property
[    0.117026] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.123888] Setting up static identity map for 0x40100000 - 0x40100060
[    0.131237] ARM CCI driver probed
[    0.135530] sunxi multi cluster SMP support installed
[    0.141501] rcu: Hierarchical SRCU implementation.
[    0.147277] smp: Bringing up secondary CPUs ...
[    0.153237] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.154443] CPU2: thread -1, cpu 2, socket 0, mpidr 80000002
[    0.155544] CPU3: thread -1, cpu 3, socket 0, mpidr 80000003
[    0.156837] CPU4: thread -1, cpu 0, socket 1, mpidr 80000100
[    0.158221] CPU5: thread -1, cpu 1, socket 1, mpidr 80000101
[    0.159456] CPU6: thread -1, cpu 2, socket 1, mpidr 80000102
[    0.160663] CPU7: thread -1, cpu 3, socket 1, mpidr 80000103
[    0.160825] smp: Brought up 1 node, 8 CPUs
[    0.207953] SMP: Total of 8 processors activated (384.00 BogoMIPS).
[    0.214714] CPU: All CPU(s) started in SVC mode.
[    0.221355] devtmpfs: initialized
[    0.232737] VFP support v0.3: implementor 41 architecture 2 part 30 variant 7 rev 5
[    0.241442] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.252094] futex hash table entries: 2048 (order: 5, 131072 bytes, linear)
[    0.261021] pinctrl core: initialized pinctrl subsystem
[    0.268330] NET: Registered protocol family 16
[    0.275235] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.284035] thermal_sys: Registered thermal governor 'step_wise'
[    0.285104] hw-breakpoint: found 5 (+1 reserved) breakpoint and 4 watchpoint registers.
[    0.300247] hw-breakpoint: maximum watchpoint size is 8 bytes.
[    0.316313] irq: type mismatch, failed to map hwirq-0 for interrupt-controller@1f00c00!
[    0.328179] irq: type mismatch, failed to map hwirq-0 for interrupt-controller@1f00c00!
[    0.348555] alg: extra crypto tests enabled.  This is intended for developer use only.
[    0.447487] SCSI subsystem initialized
[    0.452007] usbcore: registered new interface driver usbfs
[    0.458018] usbcore: registered new interface driver hub
[    0.463794] usbcore: registered new device driver usb
[    0.469473] mc: Linux media interface: v0.10
[    0.474117] videodev: Linux video capture interface: v2.00
[    0.480240] pps_core: LinuxPPS API ver. 1 registered
[    0.485606] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.495480] PTP clock support registered
[    0.500158] Advanced Linux Sound Architecture Driver Initialized.
[    0.507915] clocksource: Switched to clocksource arch_sys_counter
[    0.523702] NET: Registered protocol family 2
[    0.529170] tcp_listen_portaddr_hash hash table entries: 512 (order: 0, 6144 bytes, linear)
[    0.538246] TCP established hash table entries: 8192 (order: 3, 32768 bytes, linear)
[    0.546678] TCP bind hash table entries: 8192 (order: 4, 65536 bytes, linear)
[    0.554532] TCP: Hash tables configured (established 8192 bind 8192)
[    0.561663] UDP hash table entries: 512 (order: 2, 16384 bytes, linear)
[    0.568935] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes, linear)
[    0.576916] NET: Registered protocol family 1
[    0.582365] RPC: Registered named UNIX socket transport module.
[    0.588809] RPC: Registered udp transport module.
[    0.593888] RPC: Registered tcp transport module.
[    0.598962] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.606330] Trying to unpack rootfs image as initramfs...
[    2.652118] Freeing initrd memory: 29168K
[    2.659215] workingset: timestamp_bits=30 max_order=19 bucket_order=0
[    2.673985] NFS: Registering the id_resolver key type
[    2.679579] Key type id_resolver registered
[    2.684092] Key type id_legacy registered
[    2.688606] NET: Registered protocol family 38
[    2.693455] bounce: pool size: 64 pages
[    2.697640] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 246)
[    2.705647] io scheduler mq-deadline registered
[    2.710537] io scheduler kyber registered
[    2.716147] sun4i-usb-phy 1c19400.phy: Couldn't request ID GPIO
[    2.726140] irq: type mismatch, failed to map hwirq-0 for interrupt-controller@1f00c00!
[    2.734863] sun8i-a83t-r-pinctrl 1f02c00.pinctrl: IRQ index 0 not found
[    2.803568] Serial: 8250/16550 driver, 8 ports, IRQ sharing disabled
[    2.830196] brd: module loaded
[    2.848799] loop: module loaded
[    2.854115] libphy: Fixed MDIO Bus: probed
[    2.859652] CAN device driver interface
[    2.864659] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    2.871754] ehci-platform: EHCI generic platform driver
[    2.878212] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    2.884966] ohci-platform: OHCI generic platform driver
[    2.890966] usbcore: registered new interface driver usb-storage
[    2.898828] i2c /dev entries driver
[    2.904234] sun8i-rotate 1020000.rotate: Device registered as /dev/video0
[    2.913659] sunxi-wdt 1c20ca0.watchdog: Watchdog enabled (timeout=16 sec, nowayout=0)
[    2.922762] device-mapper: ioctl: 4.43.0-ioctl (2020-10-01) initialised: dm-devel@redhat.com
[    2.933710] sun8i-ss 1c15000.crypto: will run requests pump with realtime priority
[    2.942085] sun8i-ss 1c15000.crypto: will run requests pump with realtime priority
[    2.950392] sun8i-ss 1c15000.crypto: DEBUG: Register cbc(aes)
[    2.999280] sun8i-ss 1c15000.crypto: Fallback for cbc-aes-sun8i-ss is cbc(aes-generic)
[    3.219352] sun8i-ss 1c15000.crypto: DEBUG: Register ecb(aes)
[    3.259293] sun8i-ss 1c15000.crypto: Fallback for ecb-aes-sun8i-ss is ecb(aes-generic)
[    3.448588] sun8i-ss 1c15000.crypto: DEBUG: Register cbc(des3_ede)
[    3.509105] sun8i-ss 1c15000.crypto: Fallback for cbc-des3-sun8i-ss is cbc(des3_ede-generic)
[    4.151285] sun8i-ss 1c15000.crypto: DEBUG: Register ecb(des3_ede)
[    4.212187] sun8i-ss 1c15000.crypto: Fallback for ecb-des3-sun8i-ss is ecb(des3_ede-generic)
[    4.832090] alg: No test for stdrng (sun8i-ss-prng)
[    4.837379] sun8i-ss 1c15000.crypto: Register md5
[    4.842631] sun8i-ss 1c15000.crypto: Fallback for md5-sun8i-ss is md5-generic
[    4.941269] sun8i-ss 1c15000.crypto: Register sha1
[    4.946686] sun8i-ss 1c15000.crypto: Fallback for sha1-sun8i-ss is sha1-generic
[    5.069264] sun8i-ss 1c15000.crypto: Register sha224
[    5.131726] sun8i-ss 1c15000.crypto: Fallback for sha224-sun8i-ss is sha224-generic
[    5.287483] sun8i-ss 1c15000.crypto: Register sha256
[    5.293088] sun8i-ss 1c15000.crypto: Fallback for sha256-sun8i-ss is sha256-generic
[    5.457947] sun8i-ss 1c15000.crypto: Security System Die ID 7
[    5.465436] usbcore: registered new interface driver usbhid
[    5.471499] usbhid: USB HID core driver
[    5.481648] NET: Registered protocol family 17
[    5.486469] can: controller area network core
[    5.491357] NET: Registered protocol family 29
[    5.496156] can: raw protocol
[    5.499372] can: broadcast manager protocol
[    5.503898] can: netlink gateway - max_hops=1
[    5.508925] Key type dns_resolver registered
[    5.513697] Registering SWP/SWPB emulation handler
[    5.535312] sun4i-usb-phy 1c19400.phy: Couldn't request ID GPIO
[    5.543888] irq: type mismatch, failed to map hwirq-0 for interrupt-controller@1f00c00!
[    5.552598] sun8i-a83t-pinctrl 1c20800.pinctrl: IRQ index 1 not found
[    5.569983] sunxi-rsb 1f03400.rsb: deferred probe timeout, ignoring dependency
[    5.578460] sun4i-usb-phy 1c19400.phy: Couldn't request ID GPIO
[    5.585279] dw-apb-uart 1c28000.serial: deferred probe timeout, ignoring dependency
[    5.593822] dw-apb-uart 1c28400.serial: deferred probe timeout, ignoring dependency
[    5.602411] sun8i-dw-hdmi 1ee0000.hdmi: deferred probe timeout, ignoring dependency
[    5.611137] dwmac-sun8i 1c30000.ethernet: deferred probe timeout, ignoring dependency
[    5.621267] sunxi-ir 1f02000.ir: deferred probe timeout, ignoring dependency
[    5.630980] sunxi-mmc 1c0f000.mmc: deferred probe timeout, ignoring dependency
[    5.631655] sunxi-mmc 1c10000.mmc: deferred probe timeout, ignoring dependency
[    5.632327] sunxi-mmc 1c11000.mmc: deferred probe timeout, ignoring dependency

I bisected the problem to:
ARM: dts: sunxi: Move wakeup-capable IRQs to r_intc

Reverting it permit a successfully boot.

Regards
