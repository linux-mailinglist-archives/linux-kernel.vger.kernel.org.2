Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0C03DCADA
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Aug 2021 11:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbhHAJI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 05:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbhHAJIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 05:08:22 -0400
Received: from yawp.biot.com (yawp.biot.com [IPv6:2a01:4f8:10a:8e::fce2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7693C06175F
        for <linux-kernel@vger.kernel.org>; Sun,  1 Aug 2021 02:08:14 -0700 (PDT)
Received: from debian-spamd by yawp.biot.com with sa-checked (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1mA7S7-006pI0-JE
        for linux-kernel@vger.kernel.org; Sun, 01 Aug 2021 11:08:11 +0200
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on yawp
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.4
Received: from [2a02:578:460c:1:ae1f:6bff:fed1:9ca8]
        by yawp.biot.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1mA7Rl-006pGX-Fu; Sun, 01 Aug 2021 11:07:49 +0200
Subject: Re: [PATCH 3/5] ARM: dts: Add basic support for EcoNet EN7523
To:     Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        SoC Team <soc@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        John Crispin <john@phrozen.org>, Felix Fietkau <nbd@nbd.name>
References: <20210730134552.853350-1-bert@biot.com>
 <20210730134552.853350-4-bert@biot.com>
 <CACRpkdYvMtE8b-Xiy6=Aiz20jvY0M0Bz9XmcEQDHhqeS+LErEA@mail.gmail.com>
 <87y29n26po.wl-maz@kernel.org>
From:   Bert Vermeulen <bert@biot.com>
Message-ID: <0fe113c6-4160-fd3c-488d-53d40b6043ee@biot.com>
Date:   Sun, 1 Aug 2021 11:07:48 +0200
MIME-Version: 1.0
In-Reply-To: <87y29n26po.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/30/21 4:53 PM, Marc Zyngier wrote:
> On Fri, 30 Jul 2021 15:31:36 +0100,
> Linus Walleij <linus.walleij@linaro.org> wrote:
>> 
>> Paging Marc Z and Catalin just so they can see this:
>> 
>> On Fri, Jul 30, 2021 at 3:49 PM Bert Vermeulen <bert@biot.com> wrote:
>> 
>> > From: John Crispin <john@phrozen.org>
>> >
>> > Add basic support for EcoNet EN7523, enough for booting to console.
>> >
>> > The UART is basically 8250-compatible, except for the clock selection.
>> > A clock-frequency value is synthesized to get this to run at 115200 bps.
>> >
>> > Signed-off-by: John Crispin <john@phrozen.org>
>> > Signed-off-by: Bert Vermeulen <bert@biot.com>
>> (...)
>> > +       gic: interrupt-controller@09000000 {
>> > +               compatible = "arm,gic-v3";
>> > +               interrupt-controller;
>> > +               #interrupt-cells = <3>;
>> > +               #address-cells = <1>;
>> > +               #size-cells = <1>;
>> > +               reg = <0x09000000 0x20000>,
>> > +                         <0x09080000 0x80000>;
>> > +               interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_LOW>;
>> > +
>> > +               its: gic-its@09020000 {
>> > +                       compatible = "arm,gic-v3-its";
>> > +                       msi-controller;
>> > +                       #msi-cell = <1>;
>> > +                       reg = <0x090200000 0x20000>;
>> > +               };
>> > +       };
>> 
>> Yup GICv3 on ARM32-only silicon.
> 
> Hey, why not. But that's very unlikely, as Cortex-A7 doesn't have a
> GICv3 CPU interface built in (it only has the memory mapped version),
> and A53/57 were the first CPUs to ever support GICv3. I don't believe
> the description of the CPU in the DT is accurate.
> 
> Bert, please send a kernel boot log.

At the bottom of this mail.

>> > +       timer {
>> > +               compatible = "arm,armv8-timer";
>> > +               interrupt-parent = <&gic>;
>> > +               interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>> > +                            <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>> > +                            <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>> > +                            <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
> 
> Copy paste bug. These are not valid intspecs for GICv3.

FWIW all these were taken verbatim from the vendor's SDK. Not that this 
makes them necessarily correct :)

>> > +               clock-frequency = <25000000>;
>> > +       };
>> 
>> Also arm,armv8-timer on ARM32-only silicon.
> 
> Probably because that's not what it actually is. My bet is on A53 with
> a crippled firmware.

kernel boot log:

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 5.14.0-rc3-00042-g3af70c6f8e95-dirty 
(bert@sumner) (arm-linux-gnueabi-gcc (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0, 
GNU ld (GNU Binutils for Ubuntu) 2.34) #392 SMP Sun Aug 1 10:28:13 CEST 2021
[    0.000000] CPU: ARMv7 Processor [410fd034] revision 4 (ARMv7), cr=10c5383d
[    0.000000] CPU: div instructions available: patching division code
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing 
instruction cache
[    0.000000] OF: fdt: Machine model: econet,en7523
[    0.000000] earlycon: uart8250 at MMIO32 0x1fbf0000 (options '')
[    0.000000] printk: bootconsole [uart8250] enabled
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] Zone ranges:
[    0.000000]   Normal   [mem 0x0000000080000000-0x000000009fffffff]
[    0.000000]   HighMem  empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000080000000-0x0000000083ffffff]
[    0.000000]   node   0: [mem 0x0000000084000000-0x00000000849fffff]
[    0.000000]   node   0: [mem 0x0000000084a00000-0x0000000084afffff]
[    0.000000]   node   0: [mem 0x0000000084b00000-0x0000000084bfffff]
[    0.000000]   node   0: [mem 0x0000000084c00000-0x0000000084ffffff]
[    0.000000]   node   0: [mem 0x0000000085000000-0x00000000869fffff]
[    0.000000]   node   0: [mem 0x0000000086a00000-0x0000000086afffff]
[    0.000000]   node   0: [mem 0x0000000086b00000-0x0000000086bfffff]
[    0.000000]   node   0: [mem 0x0000000086c00000-0x0000000086cfffff]
[    0.000000]   node   0: [mem 0x0000000086d00000-0x0000000086dfffff]
[    0.000000]   node   0: [mem 0x0000000086e00000-0x000000009fffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000080000000-0x000000009fffffff]
[    0.000000] percpu: Embedded 15 pages/cpu s30604 r8192 d22644 u61440
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 129920
[    0.000000] Kernel command line: earlycon=uart8250,mmio32,0x1fbf0000 
console=ttyS0,115200
[    0.000000] Dentry cache hash table entries: 65536 (order: 6, 262144 
bytes, linear)
[    0.000000] Inode-cache hash table entries: 32768 (order: 5, 131072 
bytes, linear)
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] Memory: 461316K/524288K available (7168K kernel code, 312K 
rwdata, 1488K rodata, 8192K init, 142K bss, 62972K reserved, 0K 
cma-reserved, 0K highmem)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
[    0.000000] rcu: Hierarchical RCU implementation.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 10 
jiffies.
[    0.000000] NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
[    0.000000] GICv3: 256 SPIs implemented
[    0.000000] GICv3: 0 Extended SPIs implemented
[    0.000000] GICv3: Distributor has no Range Selector support
[    0.000000] GICv3: 16 PPIs implemented
[    0.000000] GICv3: CPU0: found redistributor 0 region 0:0x09080000
[    0.000000] random: get_random_bytes called from start_kernel+0x484/0x628 
with crng_init=0
[    0.000000] arch_timer: cp15 timer(s) running at 25.00MHz (virt).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff 
max_cycles: 0x5c40939b5, max_idle_ns: 440795202646 ns
[    0.000000] sched_clock: 56 bits at 25MHz, resolution 40ns, wraps every 
4398046511100ns
[    0.008791] Switching to timer-based delay loop, resolution 40ns
[    0.015454] Calibrating delay loop (skipped), value calculated using 
timer frequency.. 50.00 BogoMIPS (lpj=250000)
[    0.026833] pid_max: default: 32768 minimum: 301
[    0.032013] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes, 
linear)
[    0.040047] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 
bytes, linear)
[    0.049172] CPU: Testing write buffer coherency: ok
[    0.054780] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.061362] Setting up static identity map for 0x80100000 - 0x80100060
[    0.068667] rcu: Hierarchical SRCU implementation.
[    0.074290] gic-its@09020000: unable to locate ITS domain
[    0.080461] smp: Bringing up secondary CPUs ...
[    0.085769] smp: Brought up 1 node, 1 CPU
[    0.090179] SMP: Total of 1 processors activated (50.00 BogoMIPS).
[    0.097013] CPU: All CPU(s) started in SVC mode.
[    0.103634] clocksource: jiffies: mask: 0xffffffff max_cycles: 
0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.114499] futex hash table entries: 512 (order: 3, 32768 bytes, linear)
[    0.122380] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.129153] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.137265] thermal_sys: Registered thermal governor 'step_wise'
[    0.137333] No ATAGs?
[    0.153205] iommu: Default domain type: Translated
[    0.158713] usbcore: registered new interface driver usbfs
[    0.164769] usbcore: registered new interface driver hub
[    0.170660] usbcore: registered new device driver usb
[    0.176704] NET: Registered PF_ATMPVC protocol family
[    0.182296] NET: Registered PF_ATMSVC protocol family
[    0.188055] clocksource: Switched to clocksource arch_sys_counter
[    0.195462] NET: Registered PF_INET protocol family
[    0.200971] IP idents hash table entries: 8192 (order: 4, 65536 bytes, 
linear)
[    0.209452] tcp_listen_portaddr_hash hash table entries: 512 (order: 0, 
6144 bytes, linear)
[    0.218713] TCP established hash table entries: 4096 (order: 2, 16384 
bytes, linear)
[    0.227251] TCP bind hash table entries: 4096 (order: 3, 32768 bytes, linear)
[    0.235158] TCP: Hash tables configured (established 4096 bind 4096)
[    0.242212] UDP hash table entries: 256 (order: 1, 8192 bytes, linear)
[    0.249416] UDP-Lite hash table entries: 256 (order: 1, 8192 bytes, linear)
[    0.257205] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.263464] PCI: CLS 0 bytes, default 64
[    0.348846] workingset: timestamp_bits=14 max_order=17 bucket_order=3
[    0.360684] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.367197] ntfs: driver 2.1.32 [Flags: R/W DEBUG].
[    0.372785] jffs2: version 2.2. (NAND) © 2001-2006 Red Hat, Inc.
[    0.598557] io scheduler mq-deadline registered
[    0.603555] io scheduler kyber registered
[    0.619475] Serial: 8250/16550 driver, 2 ports, IRQ sharing enabled
[    0.626838] printk: console [ttyS0] disabled
[    0.631671] 1fbf0000.serial: ttyS0 at MMIO 0x1fbf0000 (irq = 28, 
base_baud = 115200) is a 8250
[    0.641169] printk: console [ttyS0] enabled
[    0.641169] printk: console [ttyS0] enabled
[    0.649943] printk: bootconsole [uart8250] disabled
[    0.649943] printk: bootconsole [uart8250] disabled
[    0.706413] brd: module loaded
[    0.709758] PPP generic driver version 2.4.2
[    0.714097] PPP BSD Compression module registered
[    0.718832] PPP Deflate Compression module registered
[    0.723877] NET: Registered PF_PPPOX protocol family
[    0.728989] usbcore: registered new interface driver cdc_acm
[    0.734648] cdc_acm: USB Abstract Control Model driver for USB modems and 
ISDN adapters
[    0.742712] usbcore: registered new interface driver usbserial_generic
[    0.749278] usbserial: USB Serial support registered for generic
[    0.755299] usbcore: registered new interface driver cypress_m8
[    0.761234] usbserial: USB Serial support registered for DeLorme 
Earthmate USB
[    0.768476] usbserial: USB Serial support registered for HID->COM RS232 
Adapter
[    0.775790] usbserial: USB Serial support registered for Nokia CA-42 V2 
Adapter
[    0.783121] usbcore: registered new interface driver ftdi_sio
[    0.788889] usbserial: USB Serial support registered for FTDI USB Serial 
Device
[    0.796272] hid: raw HID events driver (C) Jiri Kosina
[    0.801492] usbcore: registered new interface driver usbhid
[    0.807061] usbhid: USB HID core driver
[    0.811617] IPv4 over IPsec tunneling driver
[    0.816458] ipt_CLUSTERIP: ClusterIP Version 0.8 loaded successfully
[    0.822866] Initializing XFRM netlink socket
[    0.827522] NET: Registered PF_INET6 protocol family
[    0.955712] Segment Routing with IPv6
[    0.959637] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    0.966526] NET: Registered PF_PACKET protocol family
[    0.971663] NET: Registered PF_KEY protocol family
[    0.976464] 8021q: 802.1Q VLAN Support v1.8
[    0.980675] lib80211: common routines for IEEE802.11 drivers
[    0.986398] Registering SWP/SWPB emulation handler
[    0.999840] Freeing unused kernel image (initmem) memory: 8192K
[    1.006133] Run /init as init process



-- 
Bert Vermeulen
bert@biot.com
