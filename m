Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27A1740FE48
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 18:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244633AbhIQRAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 13:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232440AbhIQRA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 13:00:29 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02BFDC061574;
        Fri, 17 Sep 2021 09:59:07 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id lb1-20020a17090b4a4100b001993f863df2so7812951pjb.5;
        Fri, 17 Sep 2021 09:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language;
        bh=bqXj8sfKmgFcXRwi7yCP9NrUEgQTAdI8pTcMD8qFZKw=;
        b=QQw/EUv9QLENHqzjyRhusGs5zwquW/xA9tYVKQ3BipWcIB96A+Gye5Bi+WX4QUxV+E
         Wmt5fwi1NxOp1HWPANC6BdthE+x4uMOHmC/ZMMGanf0Dv+MC84OgT/FPfQ+baZkdWkAN
         Wu8mWL44X6hgheaeOG1MDWyoP5//z/+VmQAu+ur3i/ekpo/9o4vxbkgc6PbB/SBmKCVP
         y01XIHkcUG8Pr94CtwSVt1iOdZh1keq6ef9xpaI2501+2s7XllNGkg2myYfWgF+/QHT7
         tR0TxzWcww09RbThOpZ4YE9WcjUfks2zzHynQpCt3+vP118OIMRzRAJb5nW9bP1DwM4C
         pOFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language;
        bh=bqXj8sfKmgFcXRwi7yCP9NrUEgQTAdI8pTcMD8qFZKw=;
        b=1cDIiF0JAr5YAMwuJi26cghMcwvAghoNvn3y6zYAkhlDtwzv1xwc3CcFA6Z7UJ/npI
         L/Cfyfoo1m4Cb8Pt3hV6QFTgMCzxZiCRdoBV2wOQmMzpUzWYgL1IDikoMg8Z48TaOgvy
         9hMmuyoOKWFbg2tSP4UBF5cUMxh1dPkvkHyYDIBQdxjTUogWSbVCZBARohB7A35m/8Jx
         0m4LbVPjJdQ5E/ngumiV8aN8sQtfVeJJBux2baGYhqTUMUSMfW8NFlySXCR2f4nRqjn6
         rj+khDUXTVsYdws/BTdc0wg7QGNFZhckJ7Uh14J/I5ydkROkZAyNRI5fsHXFPYr+jPOp
         ojJA==
X-Gm-Message-State: AOAM531OV3N9G9SMybl8pi5ElGaxXa1zR3+dVdG3nMNaunS+mu0gCtjc
        K2tB3OUpL3KDGlVXVsmWYKzigq1rLpE=
X-Google-Smtp-Source: ABdhPJzDH2NC6jhI24liRDpS7nljZJfrrHIruK4v4pPbhotq/vbG8BWyKy8RMyfwWQqGg7lRX45BIA==
X-Received: by 2002:a17:90a:62ca:: with SMTP id k10mr13415397pjs.38.1631897946012;
        Fri, 17 Sep 2021 09:59:06 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id x9sm11601510pjp.50.2021.09.17.09.59.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Sep 2021 09:59:05 -0700 (PDT)
Subject: Re: [PATCH] Revert "of: property: fw_devlink: Add support for
 "phy-handle" property"
To:     Saravana Kannan <saravanak@google.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Russell King <linux@armlinux.org.uk>, kernel-team@android.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210915081933.485112-1-saravanak@google.com>
 <45576ceb-562c-9ca7-3ef4-31add52b2168@gmail.com>
 <CAGETcx9nbxH6hETP2LUENG8EV3v771qi9NpkFd-mix3G-NdZUA@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <6cc44234-ed1f-5fb3-671a-cf673ee08fb7@gmail.com>
Date:   Fri, 17 Sep 2021 09:58:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAGETcx9nbxH6hETP2LUENG8EV3v771qi9NpkFd-mix3G-NdZUA@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------F860B63EAC72EFDF6CF43631"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------F860B63EAC72EFDF6CF43631
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 9/16/21 7:27 PM, Saravana Kannan wrote:
> On Thu, Sep 16, 2021 at 7:21 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>>
>>
>>
>> On 9/15/2021 1:19 AM, Saravana Kannan wrote:
>>> This reverts commit cf4b94c8530d14017fbddae26aad064ddc42edd4.
>>>
>>> Some PHYs pointed to by "phy-handle" will never bind to a driver until a
>>> consumer attaches to it. And when the consumer attaches to it, they get
>>> forcefully bound to a generic PHY driver. In such cases, parsing the
>>> phy-handle property and creating a device link will prevent the consumer
>>> from ever probing. We don't want that. So revert support for
>>> "phy-handle" property until we come up with a better mechanism for
>>> binding PHYs to generic drivers before a consumer tries to attach to it.
>>>
>>> Signed-off-by: Saravana Kannan <saravanak@google.com>
>>
>> Thanks for getting this revert submitted, I just ran a bisection this
>> afternoon that pointed to this offending commit. It would cause the dead
>> lock
> 
> Dead lock in the kernel? Or do you mean just a hang waiting forever for network?

It locks up since we try to acquire __device_driver_lock() while we are
in the main driver's probe function.

> 
>> on boot with drivers/net/dsa/bcm_sf2.c pasted below.
> 
> The log is too jumbled up to be readable (word wrap I suppose) and
> maybe even multiple thread printing at the same time.

Re-attached (thunderbird is not really helping me).

> 
>> Saravana, can
>> you CC on me on your fix or what you would want me to be testing?
> 
> By fix, I assume you mean when I bring back phy-handle with a proper
> fix to handle the case in the commit text? Yeah, that's going to take
> a while. It's brewing in my head and there are some issues that's not
> fully resolved. But I haven't had time to code it up or dig into the
> net code to make sure it'll work. But yes, I'll CC you when I do so
> you can test it with this case.

Well by fix, I meant something that does not lock up on my system, it is
a different problem from supporting 'phy-handle', but it should not
regress an existing system, no matter how quirky that system behaves in
its probe function. For history and reference, the "offending" change
and background can be found here:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=771089c2a485958e423f305e974303760167b45c

Thanks for your patience working on the quirky MDIO/PHY subsystem :)
-- 
Florian

--------------F860B63EAC72EFDF6CF43631
Content-Type: text/x-log; charset=UTF-8;
 name="7445d0-lockup.log"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename="7445d0-lockup.log"

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 5.15.0-rc1-g02319bf15acf (fainelli@fainelli-desktop) (arm-linux-gcc (stbgcc-8.3-0.4-dirty) 8.3.0, GNU ld (stbgc
c-8.3-0.4-dirty) 2.32) #107 SMP Fri Sep 17 09:26:10 PDT 2021
[    0.000000] CPU: ARMv7 Processor [420f00f3] revision 3 (ARMv7), cr=30c5387d
[    0.000000] CPU: div instructions available: patching division code
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction cache
[    0.000000] OF: fdt: Machine model: BCM97445VMS
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] cma: Reserved 16 MiB at 0x00000000bec00000
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000000000-0x000000002fffffff]
[    0.000000]   Normal   empty
[    0.000000]   HighMem  [mem 0x0000000030000000-0x00000000bfffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000000000-0x000000003dffffff]
[    0.000000]   node   0: [mem 0x000000003e000000-0x000000003fffffff]
[    0.000000]   node   0: [mem 0x0000000040000000-0x00000000bfffefff]
[    0.000000]   node   0: [mem 0x00000000bffff000-0x00000000bfffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x00000000bfffffff]
[    0.000000] psci: probing for conduit method from DT.
[    0.000000] psci: PSCIv1.1 detected in firmware.
[    0.000000] psci: Using standard PSCI v0.2 function IDs
[    0.000000] psci: Trusted OS resident on physical CPU 0x0
[    0.000000] psci: SMC Calling Convention v1.1
[    0.000000] percpu: Embedded 16 pages/cpu s33676 r8192 d23668 u65536
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 784896
[    0.000000] Kernel command line:
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes, linear)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] Memory: 3035516K/3145728K available (12288K kernel code, 1222K rwdata, 2676K rodata, 16384K init, 238K bss, 93828K reserved,
16384K cma-reserved, 2310140K highmem)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] ftrace: allocating 38149 entries in 112 pages
[    0.000000] ftrace: allocated 112 pages with 3 groups
[    0.000000] trace event string verifier disabled
[    0.000000] rcu: Hierarchical RCU implementation.
[    0.000000] rcu:     RCU event tracing is enabled.
[    0.000000]  Rude variant of Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
[    0.000000] NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
[    0.000000] GIC: Using split EOI/Deactivate mode
[    0.000000] irq_brcmstb_l2: registered L2 intc (/rdb/interrupt-controller@f0403000, parent irq: 24)
[    0.000000] irq_brcmstb_l2: registered L2 intc (/rdb/interrupt-controller@f03e1000, parent irq: 25)
[    0.000000] irq_brcmstb_l2: registered L2 intc (/rdb/interrupt-controller@f03e1a00, parent irq: 26)
[    0.000000] irq_brcmstb_l2: registered L2 intc (/rdb/interrupt-controller@f0410640, parent irq: 27)
[    0.000000] irq_brcmstb_l2: registered L2 intc (/rdb/interrupt-controller@f04d1200, parent irq: 28)
[    0.000000] irq_brcmstb_l2: registered L2 intc (/rdb/interrupt-controller@f0417540, parent irq: 29)
[    0.000000] irq_bcm7120_l2: registered BCM7120 L2 intc (/rdb/interrupt-controller@f040a780, parent IRQ(s): 2)
[    0.000000] irq_bcm7120_l2: registered BCM7120 L2 intc (/rdb/interrupt-controller@f0417280, parent IRQ(s): 3)
[    0.000000] random: get_random_bytes called from start_kernel+0x560/0x73c with crng_init=0
[    0.000000] arch_timer: cp15 timer(s) running at 27.00MHz (phys).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x63a1e71a3, max_idle_ns: 440795203123 ns
[    0.000001] sched_clock: 56 bits at 27MHz, resolution 37ns, wraps every 4398046511093ns
[    0.000015] Switching to timer-based delay loop, resolution 37ns
[    0.000245] Console: colour dummy device 80x30
[    0.000611] printk: console [tty0] enabled
[    0.000651] Calibrating delay loop (skipped), value calculated using timer frequency.. 54.00 BogoMIPS (lpj=27000)
[    0.000675] pid_max: default: 32768 minimum: 301
[    0.000798] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes, linear)
[    0.000824] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes, linear)
[    0.001421] CPU: Testing write buffer coherency: ok
[    0.001475] CPU0: Spectre v2: using ICIALLU workaround
[    0.001709] CPU0: update cpu_capacity 1024
[    0.001726] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.002234] Setting up static identity map for 0x200000 - 0x200060
[    0.002330] rcu: Hierarchical SRCU implementation.
[    0.003252] brcmstb: biuctrl: MCP: Write pairing already disabled
[    0.003445] smp: Bringing up secondary CPUs ...
[    0.004489] CPU1: update cpu_capacity 1024
[    0.004497] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.004504] CPU1: Spectre v2: using ICIALLU workaround
[    0.005639] CPU2: update cpu_capacity 1024
[    0.005646] CPU2: thread -1, cpu 2, socket 0, mpidr 80000002
[    0.005653] CPU2: Spectre v2: using ICIALLU workaround
[    0.006742] CPU3: update cpu_capacity 1024
[    0.006748] CPU3: thread -1, cpu 3, socket 0, mpidr 80000003
[    0.006755] CPU3: Spectre v2: using ICIALLU workaround
[    0.006850] smp: Brought up 1 node, 4 CPUs
[    0.006868] SMP: Total of 4 processors activated (216.00 BogoMIPS).
[    0.006882] CPU: All CPU(s) started in HYP mode.
[    0.006893] CPU: Virtualization extensions available.
[    0.007682] devtmpfs: initialized
[    0.012066] VFP support v0.3: implementor 42 architecture 4 part 00 variant 0 rev 0
[    0.012285] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.012316] futex hash table entries: 1024 (order: 4, 65536 bytes, linear)
[    0.012791] pinctrl core: initialized pinctrl subsystem
[    0.013604] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.014876] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.015817] thermal_sys: Registered thermal governor 'step_wise'
[    0.015825] thermal_sys: Registered thermal governor 'user_space'
[    0.016089] cpuidle: using governor menu
[    0.016113] No ATAGs?
[    0.016216] hw-breakpoint: found 5 (+1 reserved) breakpoint and 4 watchpoint registers.
[    0.016234] hw-breakpoint: maximum watchpoint size is 8 bytes.
[    0.016421] /rdb/syscon@f03e2400: Broadcom Brahma-B15 readahead cache
[    0.016770] Serial: AMBA PL011 UART driver
[    0.042228] SCSI subsystem initialized
[    0.042530] usbcore: registered new interface driver usbfs
[    0.042578] usbcore: registered new interface driver hub
[    0.042622] usbcore: registered new device driver usb
[    0.042717] mc: Linux media interface: v0.10
[    0.042751] videodev: Linux video capture interface: v2.00
[    0.042784] pps_core: LinuxPPS API ver. 1 registered
[    0.042795] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.042824] PTP clock support registered
[    0.043208] arm-scmi brcm_scmi@0: SCMI Notifications - Core Enabled.
[    0.050787] arm-scmi brcm_scmi@0: SCMI Protocol v1.0 'brcm-scmi:' Firmware version 0x1
[    0.051168] Advanced Linux Sound Architecture Driver Initialized.
[    0.051988] clocksource: Switched to clocksource arch_sys_counter
[    0.116208] NET: Registered PF_INET protocol family
[    0.116438] IP idents hash table entries: 16384 (order: 5, 131072 bytes, linear)
[    0.117031] tcp_listen_portaddr_hash hash table entries: 512 (order: 0, 6144 bytes, linear)
[    0.117066] TCP established hash table entries: 8192 (order: 3, 32768 bytes, linear)
[    0.117119] TCP bind hash table entries: 8192 (order: 4, 65536 bytes, linear)
[    0.117212] TCP: Hash tables configured (established 8192 bind 8192)
[    0.117329] UDP hash table entries: 512 (order: 2, 16384 bytes, linear)
[    0.117362] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes, linear)
[    0.117505] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.118135] RPC: Registered named UNIX socket transport module.
[    0.118155] RPC: Registered udp transport module.
[    0.118165] RPC: Registered tcp transport module.
[    0.118175] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.118678] PCI: CLS 0 bytes, default 64
[    0.118871] armv7-pmu pmu: hw perfevents: no interrupt-affinity property, guessing.
[    0.533876] hw perfevents: enabled with armv7_cortex_a15 PMU driver, 7 counters available
[    0.535711] Initialise system trusted keyrings
[    0.535926] workingset: timestamp_bits=30 max_order=20 bucket_order=0
[    0.540338] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.541014] NFS: Registering the id_resolver key type
[    0.541048] Key type id_resolver registered
[    0.541060] Key type id_legacy registered
[    0.541144] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    0.541159] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Driver Registering...
[    0.541197] jffs2: version 2.2. (NAND) © 2001-2006 Red Hat, Inc.
[    0.541438] fuse: init (API version 7.34)
[    0.542078] Key type asymmetric registered
[    0.542097] Asymmetric key parser 'x509' registered
[    0.542164] bounce: pool size: 64 pages
[    0.542219] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 247)
[    0.542242] io scheduler mq-deadline registered
[    0.542256] io scheduler kyber registered
[    0.542944] brcm-gisb-arb f0400000.gisb-arb: registered irqs: 69, 70
[    0.543650] brcm-sata-phy f0458100.sata_phy: registered 2 port(s)
[    0.546916] brcm-pcie f0460000.pcie: host bridge /pcie@f0460000 ranges:
[    0.546990] brcm-pcie f0460000.pcie:      MEM 0x00c0000000..0x00cfffffff -> 0x00c0000000
[    0.547045] brcm-pcie f0460000.pcie:   IB MEM 0x0000000000..0x00bfffffff -> 0x0000000000
[    0.547217] brcm-pcie f0490000.pcie: host bridge /pcie@f0490000 ranges:
[    0.547252] brcm-pcie f0490000.pcie:      MEM 0x00d0000000..0x00dfffffff -> 0x00d0000000
[    0.547289] brcm-pcie f0490000.pcie:   IB MEM 0x0000000000..0x00bfffffff -> 0x0000000000
[    0.554849] random: fast init done
[    0.560552] arm-scmi brcm_scmi@0: Failed. SCMI protocol 22 not active.
[    0.606279] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    0.608867] f040ab00.serial: ttyS0 at MMIO 0xf040ab00 (irq = 48, base_baud = 5062500) is a 16550A
[    1.545608] printk: console [ttyS0] enabled
[    1.551074] f040ab40.serial: ttyS1 at MMIO 0xf040ab40 (irq = 49, base_baud = 5062500) is a 16550A
[    1.561115] f040ab80.serial: ttyS2 at MMIO 0xf040ab80 (irq = 50, base_baud = 5062500) is a 16550A
[    1.579482] brd: module loaded
[    1.589121] loop: module loaded
[    1.593165] brcm-ahci f045a000.sata: supply ahci not found, using dummy regulator
[    1.600901] brcm-ahci f045a000.sata: supply phy not found, using dummy regulator
[    1.608872] platform f045a000.sata:sata-port@0: supply target not found, using dummy regulator
[    1.618167] platform f045a000.sata:sata-port@1: supply target not found, using dummy regulator
[    1.627244] brcm-ahci f045a000.sata: controller can do ALPM, turning on CAP_ALPM
[    1.634704] brcm-ahci f045a000.sata: masking port_map 0x3 -> 0x3
[    1.640793] brcm-ahci f045a000.sata: SSS flag set, parallel bus scan disabled
[    1.658070] brcm-ahci f045a000.sata: AHCI 0001.0300 32 slots 2 ports 6 Gbps 0x3 impl platform mode
[    1.667085] brcm-ahci f045a000.sata: flags: 64bit ncq sntf stag pm clo pmp slum part
[    1.676677] scsi host0: brcm-ahci
[    1.680605] scsi host1: brcm-ahci
[    1.684253] ata1: SATA max UDMA/133 mmio [mem 0xf045a000-0xf045aa9b] port 0x100 irq 65
[    1.692231] ata2: SATA max UDMA/133 mmio [mem 0xf045a000-0xf045aa9b] port 0x180 irq 65
[    1.700205] brcm-ahci f045a000.sata: Broadcom AHCI SATA3 registered
[    1.708295] brcmstb_nand f03e2800.nand: enabling FLASH_DMA
[    1.714342] nand: device found, Manufacturer ID: 0x2c, Chip ID: 0x68
[    1.720753] nand: Micron MT29F32G08CBACAWP
[    1.724887] nand: 4096 MiB, MLC, erase size: 1024 KiB, page size: 4096, OOB size: 224
[    1.732764] brcmstb_nand f03e2800.nand: detected 4096MiB total, 1024KiB blocks, 4KiB pages, 28B OOB, 8-bit, BCH-24 (1KiB sector)
[    1.745693] Bad block table found at page 1048320, version 0x01
[    1.753460] Bad block table found at page 1048064, version 0x01
[    1.760002] nand_read_bbt: bad block at 0x000005a00000
[    1.765181] nand_read_bbt: bad block at 0x000005b00000
[    1.770565] 3 fixed-partitions partitions found on MTD device brcmnand.1
[    1.777307] Creating 3 MTD partitions on "brcmnand.1":
[    1.782474] 0x000000000000-0x000080000000 : "flash1.rootfs0"
[    1.789695] mtdblock: MTD device 'flash1.rootfs0' is NAND, please consider using UBI block devices instead.
[    1.800611] 0x000080000000-0x000100000000 : "flash1.rootfs1"
[    1.807757] mtdblock: MTD device 'flash1.rootfs1' is NAND, please consider using UBI block devices instead.
[    1.818574] 0x000000000000-0x000100000000 : "flash1"
[    1.826104] mtdblock: MTD device 'flash1' is NAND, please consider using UBI block devices instead.
[    1.837248] brcmstb_qspi f03e0920.qspi: using bspi-mspi mode
[    1.843943] spi-nor spi0.0: found mx25l12805d, expected m25p80
[    1.849850] spi-nor spi0.0: mx25l12805d (16384 Kbytes)
[    1.855101] 9 fixed-partitions partitions found on MTD device spi0.0
[    1.861491] Creating 9 MTD partitions on "spi0.0":
[    1.866317] 0x000000000000-0x000000100000 : "flash0.bolt"
[    1.873220] 0x000000100000-0x000000110000 : "flash0.macadr"
[    1.880168] 0x000000110000-0x000000120000 : "flash0.nvram"
[    1.887057] 0x000000120000-0x000000f50000 : "flash0.kernel"
[    1.894093] 0x000000f50000-0x000000f60000 : "flash0.bp30"
[    1.900867] 0x000000f60000-0x000000f70000 : "flash0.bp31"
[    1.907687] 0x000000f70000-0x000000f80000 : "flash0.devtree"
[    1.914686] 0x000000f80000-0x000001000000 : "flash0.splash"
[    1.921668] 0x000000000000-0x000001000000 : "flash0"
[    1.928495] brcmstb_qspi f0416000.mspi: using mspi mode
[    1.936357] libphy: Fixed MDIO Bus: probed
[    1.944984] libphy: unimac MII bus: probed
[    1.967012] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    1.973843] ata1.00: ATA-9: WDC WD10JPVX-22JC3T0, 01.01A01, max UDMA/133
[    1.980599] ata1.00: 1953525168 sectors, multi 0: LBA48 NCQ (depth 32)
[    1.987766] ata1.00: configured for UDMA/133
[    1.992402] scsi 0:0:0:0: Direct-Access     ATA      WDC WD10JPVX-22J 1A01 PQ: 0 ANSI: 5
[    2.001694] sd 0:0:0:0: [sda] 1953525168 512-byte logical blocks: (1.00 TB/932 GiB)
[    2.009403] sd 0:0:0:0: [sda] 4096-byte physical blocks
[    2.014750] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    2.020198] sd 0:0:0:0: [sda] Write Protect is off
[    2.025191] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.143489] ata2: SATA link down (SStatus 0 SControl 300)
[    3.551114] unimac-mdio f0b403c0.mdio: Broadcom UniMAC MDIO bus
[    4.605218]  sda: sda1 sda2 sda3 sda4
[    4.610168] sd 0:0:0:0: [sda] Attached SCSI disk
[   25.614971] rcu: INFO: rcu_sched self-detected stall on CPU
[   25.620564] rcu:     2-....: (20999 ticks this GP) idle=293/1/0x40000002 softirq=535/535 fqs=5249
[   25.629288]  (t=21000 jiffies g=-303 q=71)
[   25.633399] NMI backtrace for cpu 2
[   25.636898] CPU: 2 PID: 1 Comm: swapper/0 Not tainted 5.15.0-rc1-g02319bf15acf #107
[   25.644575] Hardware name: Broadcom STB (Flattened Device Tree)
[   25.650508] Backtrace:
[   25.652966] [<c0cc68dc>] (dump_backtrace) from [<c0cc6b24>] (show_stack+0x20/0x24)
[   25.660577]  r7:c0e021dc r6:00000002 r5:c0f74918 r4:60000193
[   25.666248] [<c0cc6b04>] (show_stack) from [<c0ccbb44>] (dump_stack_lvl+0x48/0x54)
[   25.673843] [<c0ccbafc>] (dump_stack_lvl) from [<c0ccbb68>] (dump_stack+0x18/0x1c)
[   25.681434]  r5:00000000 r4:20000193
[   25.685018] [<c0ccbb50>] (dump_stack) from [<c06c1bac>] (nmi_cpu_backtrace+0xdc/0x110)
[   25.692964] [<c06c1ad0>] (nmi_cpu_backtrace) from [<c06c1cf8>] (nmi_trigger_cpumask_backtrace+0x118/0x130)
[   25.702647]  r7:c0e021dc r6:00000002 r5:c22056e4 r4:c020fdc4
[   25.708318] [<c06c1be0>] (nmi_trigger_cpumask_backtrace) from [<c0210fd0>] (arch_trigger_cpumask_backtrace+0x20/0x24)
[   25.718960]  r7:c230f0b3 r6:00000002 r5:c2204e08 r4:c2249d80
[   25.724630] [<c0210fb0>] (arch_trigger_cpumask_backtrace) from [<c0cc83e4>] (rcu_dump_cpu_stacks+0x144/0x174)
[   25.734573] [<c0cc82a0>] (rcu_dump_cpu_stacks) from [<c02a30ec>] (rcu_sched_clock_irq+0x6b0/0xa90)
[   25.743563]  r10:2df11000 r9:00000000 r8:c2203d00 r7:c20b9fc0 r6:c230fe20 r5:effcafc0
[   25.751408]  r4:c2249d80
[   25.753947] [<c02a2a3c>] (rcu_sched_clock_irq) from [<c02b0b30>] (update_process_times+0xb0/0xdc)
[   25.762846]  r10:c02c5324 r9:effc48c0 r8:effc4880 r7:00000005 r6:00000000 r5:c2203d00
[   25.770692]  r4:effc3580
[   25.773232] [<c02b0a80>] (update_process_times) from [<c02c4fb8>] (tick_sched_handle+0x64/0x68)
[   25.781959]  r7:00000005 r6:f65b1770 r5:c2573bb8 r4:effc4be8
[   25.787629] [<c02c4f54>] (tick_sched_handle) from [<c02c5380>] (tick_sched_timer+0x5c/0xb8)
[   25.796005] [<c02c5324>] (tick_sched_timer) from [<c02b1a58>] (__hrtimer_run_queues+0x1bc/0x338)
[   25.804818]  r7:c23101e0 r6:c2310200 r5:effc4880 r4:effc4be8
[   25.810488] [<c02b189c>] (__hrtimer_run_queues) from [<c02b2ab8>] (hrtimer_interrupt+0x130/0x2b8)
[   25.819385]  r10:effc49d0 r9:effc4a00 r8:ffffffff r7:7fffffff r6:00000003 r5:20000193
[   25.827231]  r4:effc4880
[   25.829771] [<c02b2988>] (hrtimer_interrupt) from [<c0a0c904>] (arch_timer_handler_phys+0x38/0x40)
[   25.838759]  r10:c0fda808 r9:c20b8534 r8:c2573bb8 r7:00000024 r6:c251d940 r5:c22056fc
[   25.846605]  r4:c2520c00
[   25.849145] [<c0a0c8cc>] (arch_timer_handler_phys) from [<c028ceb4>] (handle_percpu_devid_irq+0x9c/0x1f0)
[   25.858740] [<c028ce18>] (handle_percpu_devid_irq) from [<c02867d8>] (handle_domain_irq+0x6c/0x88)
[   25.867726]  r7:0000001e r6:00000000 r5:00000000 r4:c20b8528
[   25.873396] [<c028676c>] (handle_domain_irq) from [<c0201204>] (gic_handle_irq+0x8c/0xa0)
[   25.881598]  r7:f080200c r6:f0802000 r5:c22b9118 r4:c22056fc
[   25.887268] [<c0201178>] (gic_handle_irq) from [<c0200ac8>] (__irq_svc+0x48/0x5c)
[   25.894772] Exception stack(0xc2573bb8 to 0xc2573c00)
[   25.899837] 3ba0:                                                       ???????? ????????
[   25.908030] 3bc0: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
[   25.916224] 3be0: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
[   25.924420]  r9:c2572000 r8:c4713578 r7:c2573bec r6:ffffffff r5:60000013 r4:c0cd8cbc
[   25.932178] [<c0cd8c94>] (mutex_lock) from [<c07b6a48>] (__device_driver_lock+0x38/0x48)
[   25.940298] [<c07b6a10>] (__device_driver_lock) from [<c07b8494>] (device_release_driver_internal+0x80/0x1d0)
[   25.950242]  r5:00000000 r4:c4485c00
[   25.953825] [<c07b8414>] (device_release_driver_internal) from [<c07b8604>] (device_release_driver+0x20/0x24)
[   25.963770]  r7:c2204d08 r6:c22cd800 r5:c4485c00 r4:c2c23030
[   25.969440] [<c07b85e4>] (device_release_driver) from [<c07b66c4>] (bus_remove_device+0xf0/0x148)
[   25.978337] [<c07b65d4>] (bus_remove_device) from [<c07b0fe0>] (device_del+0x194/0x418)
[   25.986367]  r7:c2204d08 r6:c236520c r5:c4485c44 r4:c4485c00
[   25.992037] [<c07b0e4c>] (device_del) from [<c089ccd4>] (phy_device_remove+0x1c/0x34)
[   25.999894]  r10:c0fda808 r9:efff4160 r8:c2204d08 r7:c2632840 r6:c2573d20 r5:efff43c0
[   26.007739]  r4:c4485c00
[   26.010278] [<c089ccb8>] (phy_device_remove) from [<c08a6ecc>] (bcm_sf2_sw_probe+0x640/0x900)
[   26.018828]  r5:efff43c0 r4:c2632840
[   26.022412] [<c08a688c>] (bcm_sf2_sw_probe) from [<c07ba910>] (platform_probe+0x6c/0xc8)
[   26.030528]  r10:c2332000 r9:c1253854 r8:00000000 r7:c22d1134 r6:c22d1134 r5:00000000
[   26.038373]  r4:c25eb010
[   26.040913] [<c07ba8a4>] (platform_probe) from [<c07b77c0>] (really_probe+0xe8/0x45c)
[   26.048768]  r7:c22d1134 r6:c231e128 r5:00000000 r4:c25eb010
[   26.054438] [<c07b76d8>] (really_probe) from [<c07b7be4>] (__driver_probe_device+0xb0/0x230)
[   26.062903]  r7:c231e128 r6:c22d1134 r5:c22d1134 r4:c25eb010
[   26.068574] [<c07b7b34>] (__driver_probe_device) from [<c07b7da8>] (driver_probe_device+0x44/0xd4)
[   26.077561]  r9:c1253854 r8:00000000 r7:c25eb010 r6:c22d1134 r5:c236523c r4:c2365238
[   26.085319] [<c07b7d64>] (driver_probe_device) from [<c07b8348>] (__driver_attach+0xdc/0x188)
[   26.093872]  r9:c1253854 r8:ffffe000 r7:c07b826c r6:c22d1134 r5:00000000 r4:c25eb010
[   26.101630] [<c07b826c>] (__driver_attach) from [<c07b5580>] (bus_for_each_dev+0x84/0xc4)
[   26.109834]  r7:c07b826c r6:c22d1134 r5:c2204d08 r4:c27334b4
[   26.115505] [<c07b54fc>] (bus_for_each_dev) from [<c07b7028>] (driver_attach+0x2c/0x30)
[   26.123535]  r7:00000000 r6:c2737580 r5:c22c3038 r4:c22d1134
[   26.129205] [<c07b6ffc>] (driver_attach) from [<c07b68ec>] (bus_add_driver+0x1d0/0x210)
[   26.137233] [<c07b671c>] (bus_add_driver) from [<c07b8e8c>] (driver_register+0x84/0x118)
[   26.145351]  r7:00000000 r6:c122ab04 r5:c2204d08 r4:c22d1134
[   26.151021] [<c07b8e08>] (driver_register) from [<c07ba560>] (__platform_driver_register+0x2c/0x34)
[   26.160093]  r5:c2204d08 r4:c230f6e0
[   26.163676] [<c07ba534>] (__platform_driver_register) from [<c122ab28>] (bcm_sf2_driver_init+0x24/0x28)
[   26.173097] [<c122ab04>] (bcm_sf2_driver_init) from [<c02020f8>] (do_one_initcall+0x64/0x23c)
[   26.181647] [<c0202094>] (do_one_initcall) from [<c12014e8>] (kernel_init_freeable+0x1d8/0x230)
[   26.190376]  r8:00000007 r7:c26f4900 r6:c1253834 r5:0000011a r4:c1289c30
[   26.197090] [<c1201310>] (kernel_init_freeable) from [<c0cd3ddc>] (kernel_init+0x20/0x138)
[   26.205384]  r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c0cd3dbc
[   26.213229]  r4:00000000
[   26.215769] [<c0cd3dbc>] (kernel_init) from [<c0200120>] (ret_from_fork+0x14/0x34)
[   26.223362] Exception stack(0xc2573fb0 to 0xc2573ff8)
[   26.228425] 3fa0:                                     ???????? ???????? ???????? ????????
[   26.236619] 3fc0: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
[   26.244813] 3fe0: ???????? ???????? ???????? ???????? ???????? ????????
[   26.251441]  r5:c0cd3dbc r4:00000000


--------------F860B63EAC72EFDF6CF43631--
