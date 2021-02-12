Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8541C31A597
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 20:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbhBLTmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 14:42:51 -0500
Received: from lizzard.sbs.de ([194.138.37.39]:46895 "EHLO lizzard.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229558AbhBLTmn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 14:42:43 -0500
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 11CJfS0J026359
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Feb 2021 20:41:28 +0100
Received: from [167.87.36.57] ([167.87.36.57])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 11CJVROM026402;
        Fri, 12 Feb 2021 20:31:27 +0100
Subject: Re: [PATCH v2 0/4] arm64: Add TI AM65x-based IOT2050 boards
From:   Jan Kiszka <jan.kiszka@siemens.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Le Jin <le.jin@siemens.com>,
        Bao Cheng Su <baocheng.su@siemens.com>
References: <cover.1613071976.git.jan.kiszka@siemens.com>
Message-ID: <13a79af7-bc00-e605-581f-12111a752d3e@siemens.com>
Date:   Fri, 12 Feb 2021 20:31:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <cover.1613071976.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.02.21 20:32, Jan Kiszka wrote:
> Changes in v2:
>  - address board-specific issues found by kernel_verify_patch
>  - remove dead l2-cache node from iot2050-basic DT
>  - add binding for Siemens vendor prefix
>  - factor out board bindings into separate patch
>  - add missing device_type to common ti,am654-pcie-rc nodes
> 
> Jan
> 
> Jan Kiszka (4):
>   dt-bindings: Add Siemens vendor prefix
>   dt-bindings: arm: ti: Add bindings for Siemens IOT2050 boards
>   arm64: dts: ti: Add support for Siemens IOT2050 boards
>   arm64: dts: ti: k3-am65-main: Add device_type to pcie*_rc nodes
> 
>  .../devicetree/bindings/arm/ti/k3.yaml        |   2 +
>  .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
>  arch/arm64/boot/dts/ti/Makefile               |   2 +
>  .../boot/dts/ti/k3-am65-iot2050-common.dtsi   | 679 ++++++++++++++++++
>  arch/arm64/boot/dts/ti/k3-am65-main.dtsi      |   2 +
>  .../boot/dts/ti/k3-am6528-iot2050-basic.dts   |  61 ++
>  .../dts/ti/k3-am6548-iot2050-advanced.dts     |  60 ++
>  7 files changed, 808 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dts
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts
> 

Forgot to include the requested boot log. Here it comes for the basic variant:

[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd034]
[    0.000000] Linux version 5.11.0-rc7+ (jan@md1f2u6c) (aarch64-linux-gnu-gcc (GNU Toolchain for the A-profile Architecture 9.2-2019.12 (arm-9.10)) 9.2.1 20191025, GNU ld (GNU Toolchain for the A-profile Architecture 9.2-2019.12 (arm-9.10)) 2.33.1.20191209) #113 SMP PREEMPT Thu Feb 11 21:26:46 CET 2021
[    0.000000] Machine model: SIMATIC IOT2050 Basic
[    0.000000] earlycon: ns16550a0 at MMIO32 0x0000000002810000 (options '')
[    0.000000] printk: bootconsole [ns16550a0] enabled
[    0.000000] Reserved memory: created DMA memory pool at 0x00000000a0000000, size 1 MiB
[    0.000000] OF: reserved mem: initialized node r5f-dma-memory@a0000000, compatible id shared-dma-pool
[    0.000000] Reserved memory: created DMA memory pool at 0x00000000a0100000, size 15 MiB
[    0.000000] OF: reserved mem: initialized node r5f-memory@a0100000, compatible id shared-dma-pool
[    0.000000] Reserved memory: created DMA memory pool at 0x00000000a1000000, size 1 MiB
[    0.000000] OF: reserved mem: initialized node r5f-dma-memory@a1000000, compatible id shared-dma-pool
[    0.000000] Reserved memory: created DMA memory pool at 0x00000000a1100000, size 15 MiB
[    0.000000] OF: reserved mem: initialized node r5f-memory@a1100000, compatible id shared-dma-pool
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000080000000-0x00000000bfffffff]
[    0.000000]   DMA32    empty
[    0.000000]   Normal   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000080000000-0x000000009e7fffff]
[    0.000000]   node   0: [mem 0x00000000a2200000-0x00000000bfffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000080000000-0x00000000bfffffff]
[    0.000000] On node 0 totalpages: 247296
[    0.000000]   DMA zone: 4096 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 247296 pages, LIFO batch:63
[    0.000000] cma: Reserved 24 MiB at 0x00000000bc400000
[    0.000000] psci: probing for conduit method from DT.
[    0.000000] psci: PSCIv1.1 detected in firmware.
[    0.000000] psci: Using standard PSCI v0.2 function IDs
[    0.000000] psci: Trusted OS migration not required
[    0.000000] psci: SMC Calling Convention v1.2
[    0.000000] percpu: Embedded 22 pages/cpu s49560 r8192 d32360 u90112
[    0.000000] pcpu-alloc: s49560 r8192 d32360 u90112 alloc=22*4096
[    0.000000] pcpu-alloc: [0] 0 [0] 1 
[    0.000000] Detected VIPT I-cache on CPU0
[    0.000000] CPU features: detected: ARM erratum 845719
[    0.000000] CPU features: detected: GIC system register CPU interface
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 243200
[    0.000000] Kernel command line: root=PARTUUID=e4abca5c-738d-48cd-ac11-7e578c11d495 console=ttyS3,115200n8 earlycon=ns16550a,mmio32,0x02810000 mtdparts=47040000.spi.0:512k(ospi.tiboot3),2m(ospi.tispl),4m(ospi.u-boot),128k(ospi.env),128k(ospi.env.backup),1m(ospi.sysfw),64k(pru0-fw),64k(pru1-fw),64k(rtu0-fw),64k(rtu1-fw),-@8m(ospi.rootfs) rw rootwait
[    0.000000] Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes, linear)
[    0.000000] Inode-cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] Memory: 926684K/989184K available (10560K kernel code, 1038K rwdata, 3976K rodata, 1600K init, 390K bss, 37924K reserved, 24576K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
[    0.000000] rcu: Preemptible hierarchical RCU implementation.
[    0.000000] rcu: 	RCU event tracing is enabled.
[    0.000000] rcu: 	RCU restricting CPUs from NR_CPUS=256 to nr_cpu_ids=2.
[    0.000000] 	Trampoline variant of Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] GICv3: GIC: Using split EOI/Deactivate mode
[    0.000000] GICv3: 960 SPIs implemented
[    0.000000] GICv3: 0 Extended SPIs implemented
[    0.000000] GICv3: Distributor has no Range Selector support
[    0.000000] GICv3: 16 PPIs implemented
[    0.000000] GICv3: CPU0: found redistributor 0 region 0:0x0000000001880000
[    0.000000] ITS [mem 0x01820000-0x0182ffff]
[    0.000000] GIC: enabling workaround for ITS: Socionext Synquacer pre-ITS
[    0.000000] ITS@0x0000000001820000: Devices Table too large, reduce ids 20->19
[    0.000000] ITS@0x0000000001820000: allocated 524288 Devices @81c00000 (flat, esz 8, psz 64K, shr 0)
[    0.000000] ITS: using cache flushing for cmd queue
[    0.000000] GICv3: using LPI property table @0x0000000081430000
[    0.000000] GIC: using cache flushing for LPI property table
[    0.000000] GICv3: CPU0: using allocated LPI pending table @0x0000000081440000
[    0.000000] random: get_random_bytes called from start_kernel+0x350/0x4fc with crng_init=0
[    0.000000] arch_timer: cp15 timer(s) running at 200.00MHz (phys).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x2e2049d3e8, max_idle_ns: 440795210634 ns
[    0.000000] sched_clock: 56 bits at 200MHz, resolution 5ns, wraps every 4398046511102ns
[    0.008496] Console: colour dummy device 80x25
[    0.013099] Calibrating delay loop (skipped), value calculated using timer frequency.. 400.00 BogoMIPS (lpj=800000)
[    0.023787] pid_max: default: 32768 minimum: 301
[    0.028610] LSM: Security Framework initializing
[    0.033388] Mount-cache hash table entries: 2048 (order: 2, 16384 bytes, linear)
[    0.040965] Mountpoint-cache hash table entries: 2048 (order: 2, 16384 bytes, linear)
[    0.050789] rcu: Hierarchical SRCU implementation.
[    0.056001] Platform MSI: msi-controller@1820000 domain created
[    0.062216] PCI/MSI: /bus@100000/interrupt-controller@1800000/msi-controller@1820000 domain created
[    0.071708] smp: Bringing up secondary CPUs ...
[    0.085317] Detected VIPT I-cache on CPU1
[    0.085362] GICv3: CPU1: found redistributor 1 region 0:0x00000000018a0000
[    0.085380] GICv3: CPU1: using allocated LPI pending table @0x0000000081450000
[    0.085447] CPU1: Booted secondary processor 0x0000000001 [0x410fd034]
[    0.085569] smp: Brought up 1 node, 2 CPUs
[    0.114965] SMP: Total of 2 processors activated.
[    0.119780] CPU features: detected: 32-bit EL0 Support
[    0.125057] CPU features: detected: CRC32 instructions
[    0.142427] CPU: All CPU(s) started at EL2
[    0.146659] alternatives: patching kernel code
[    0.152297] devtmpfs: initialized
[    0.162108] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.172114] futex hash table entries: 512 (order: 3, 32768 bytes, linear)
[    0.180084] pinctrl core: initialized pinctrl subsystem
[    0.186608] NET: Registered protocol family 16
[    0.192912] DMA: preallocated 128 KiB GFP_KERNEL pool for atomic allocations
[    0.200273] DMA: preallocated 128 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
[    0.208345] DMA: preallocated 128 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
[    0.217012] thermal_sys: Registered thermal governor 'step_wise'
[    0.217557] hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
[    0.230706] ASID allocator initialised with 65536 entries
[    0.263053] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    0.269951] HugeTLB registered 32.0 MiB page size, pre-allocated 0 pages
[    0.276812] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.283668] HugeTLB registered 64.0 KiB page size, pre-allocated 0 pages
[    0.294355] k3-chipinfo 43000014.chipid: Family:AM65X rev:SR1.0 JTAGID[0x0bb5a02f] Detected
[    0.304023] iommu: Default domain type: Translated 
[    0.309537] SCSI subsystem initialized
[    0.313584] usbcore: registered new interface driver usbfs
[    0.319238] usbcore: registered new interface driver hub
[    0.324700] usbcore: registered new device driver usb
[    0.330305] mc: Linux media interface: v0.10
[    0.334701] videodev: Linux video capture interface: v2.00
[    0.340374] EDAC MC: Ver: 3.0.0
[    0.344072] omap-mailbox 31f80000.mailbox: no available mbox devices found
[    0.351157] omap-mailbox 31f81000.mailbox: no available mbox devices found
[    0.358227] omap-mailbox 31f82000.mailbox: no available mbox devices found
[    0.365296] omap-mailbox 31f83000.mailbox: no available mbox devices found
[    0.372365] omap-mailbox 31f84000.mailbox: no available mbox devices found
[    0.379434] omap-mailbox 31f85000.mailbox: no available mbox devices found
[    0.386504] omap-mailbox 31f86000.mailbox: no available mbox devices found
[    0.393571] omap-mailbox 31f87000.mailbox: no available mbox devices found
[    0.400644] omap-mailbox 31f88000.mailbox: no available mbox devices found
[    0.407712] omap-mailbox 31f89000.mailbox: no available mbox devices found
[    0.414779] omap-mailbox 31f8a000.mailbox: no available mbox devices found
[    0.421847] omap-mailbox 31f8b000.mailbox: no available mbox devices found
[    0.429386] Advanced Linux Sound Architecture Driver Initialized.
[    0.436472] clocksource: Switched to clocksource arch_sys_counter
[    0.442937] VFS: Disk quotas dquot_6.6.0
[    0.447006] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.460347] NET: Registered protocol family 2
[    0.465463] tcp_listen_portaddr_hash hash table entries: 512 (order: 1, 8192 bytes, linear)
[    0.474077] TCP established hash table entries: 8192 (order: 4, 65536 bytes, linear)
[    0.482074] TCP bind hash table entries: 8192 (order: 5, 131072 bytes, linear)
[    0.489640] TCP: Hash tables configured (established 8192 bind 8192)
[    0.496324] UDP hash table entries: 512 (order: 2, 16384 bytes, linear)
[    0.503131] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes, linear)
[    0.510501] NET: Registered protocol family 1
[    0.515412] RPC: Registered named UNIX socket transport module.
[    0.521494] RPC: Registered udp transport module.
[    0.526333] RPC: Registered tcp transport module.
[    0.531148] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.537743] PCI: CLS 0 bytes, default 64
[    0.542472] hw perfevents: enabled with armv8_pmuv3 PMU driver, 7 counters available
[    0.551900] Initialise system trusted keyrings
[    0.556662] workingset: timestamp_bits=46 max_order=18 bucket_order=0
[    0.567752] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.574346] NFS: Registering the id_resolver key type
[    0.579557] Key type id_resolver registered
[    0.583840] Key type id_legacy registered
[    0.588021] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    0.595143] 9p: Installing v9fs 9p2000 file system support
[    0.644844] Key type asymmetric registered
[    0.649049] Asymmetric key parser 'x509' registered
[    0.654076] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 247)
[    0.661743] io scheduler mq-deadline registered
[    0.666395] io scheduler kyber registered
[    0.672910] pinctrl-single 4301c000.pinctrl: 70 pins, size 280
[    0.679413] pinctrl-single 11c000.pinctrl: 185 pins, size 740
[    0.685431] pinctrl-single 11c2e8.pinctrl: 9 pins, size 36
[    0.695652] k3-ringacc 2b800000.ringacc: Failed to get MSI domain
[    0.702001] k3-ringacc 3c000000.ringacc: Failed to get MSI domain
[    0.712187] Serial: 8250/16550 driver, 10 ports, IRQ sharing enabled
[    0.733613] brd: module loaded
[    0.744181] loop: module loaded
[    0.750357] libphy: Fixed MDIO Bus: probed
[    0.755258] tun: Universal TUN/TAP device driver, 1.6
[    0.761173] igbvf: Intel(R) Gigabit Virtual Function Network Driver
[    0.767594] igbvf: Copyright (c) 2009 - 2012 Intel Corporation.
[    0.773709] sky2: driver version 1.30
[    0.777988] VFIO - User Level meta-driver version: 0.3
[    0.784801] usbcore: registered new interface driver usb-storage
[    0.791493] i2c /dev entries driver
[    0.796015] sdhci: Secure Digital Host Controller Interface driver
[    0.802356] sdhci: Copyright(c) Pierre Ossman
[    0.807138] sdhci-pltfm: SDHCI platform and OF driver helper
[    0.814280] ledtrig-cpu: registered to indicate activity on CPUs
[    0.820536] ti-sci bus@100000:bus@28380000:bus@42040000:dmsc: invalid resource
[    0.828091] SMCCC: SOC_ID: ARCH_SOC_ID not implemented, skipping ....
[    0.834807] usbcore: registered new interface driver usbhid
[    0.840518] usbhid: USB HID core driver
[    0.846022] optee: probing for conduit method.
[    0.850608] optee: revision 3.11
[    0.851228] optee: initialized driver
[    0.859624] NET: Registered protocol family 17
[    0.864335] 9pnet: Installing 9P2000 support
[    0.868772] Key type dns_resolver registered
[    0.873423] registered taskstats version 1
[    0.877625] Loading compiled-in X.509 certificates
[    0.891629] k3-ringacc 2b800000.ringacc: Failed to get MSI domain
[    0.898122] k3-ringacc 3c000000.ringacc: Failed to get MSI domain
[    0.909334] ti-sci bus@100000:bus@28380000:bus@42040000:dmsc: invalid resource
[    0.917109] ti-sci bus@100000:bus@28380000:bus@42040000:dmsc: ABI: 3.1 (firmware rev 0x0014 '20.8.5--v2020.08b (Terrific Lla')
[    0.977963] omap_i2c 42120000.i2c: bus 0 rev0.12 at 400 kHz
[    1.008987] random: fast init done
[    1.012808] pca953x 1-0020: supply vcc not found, using dummy regulator
[    1.019696] pca953x 1-0020: using no AI
[    1.024414] pca953x 1-0021: supply vcc not found, using dummy regulator
[    1.031278] pca953x 1-0021: using no AI
[    1.035951] pca953x 1-0025: supply vcc not found, using dummy regulator
[    1.042828] pca953x 1-0025: using no AI
[    1.047395] omap_i2c 40b00000.i2c: bus 1 rev0.12 at 400 kHz
[    1.078186] rtc-pcf8563 2-0051: registered as rtc0
[    1.083459] rtc-pcf8563 2-0051: setting system clock to 2021-02-11T20:30:32 UTC (1613075432)
[    1.092743] omap_i2c 2000000.i2c: bus 2 rev0.12 at 400 kHz
[    1.099345] omap_i2c 2010000.i2c: bus 3 rev0.12 at 400 kHz
[    1.105871] omap_i2c 2020000.i2c: bus 4 rev0.12 at 400 kHz
[    1.112779] omap_i2c 2030000.i2c: bus 5 rev0.12 at 400 kHz
[    1.118832] ti-sci-intr bus@100000:bus@28380000:bus@42040000:interrupt-controller2: Interrupt Router 156 domain created
[    1.130062] ti-sci-intr bus@100000:interrupt-controller0: Interrupt Router 100 domain created
[    1.138983] ti-sci-intr bus@100000:main-navss:interrupt-controller1: Interrupt Router 182 domain created
[    1.149023] ti-sci-inta 33d00000.interrupt-controller: Interrupt Aggregator domain 179 created
[    1.169221] k3-ringacc 2b800000.ringacc: Ring Accelerator probed rings:286, gp-rings[96,160] sci-dev-id:195
[    1.179224] k3-ringacc 2b800000.ringacc: dma-ring-reset-quirk: enabled
[    1.185908] k3-ringacc 2b800000.ringacc: RA Proxy rev. 66344100, num_proxies:64
[    1.205592] k3-ringacc 3c000000.ringacc: Ring Accelerator probed rings:818, gp-rings[304,464] sci-dev-id:187
[    1.215687] k3-ringacc 3c000000.ringacc: dma-ring-reset-quirk: enabled
[    1.222368] k3-ringacc 3c000000.ringacc: RA Proxy rev. 66344100, num_proxies:64
[    1.231038] 40a00000.serial: ttyS1 at MMIO 0x40a00000 (irq = 16, base_baud = 6000000) is a 8250
[    1.241158] 2800000.serial: ttyS2 at MMIO 0x2800000 (irq = 24, base_baud = 3000000) is a 8250
[    1.250955] 2810000.serial: ttyS3 at MMIO 0x2810000 (irq = 25, base_baud = 3000000) is a 8250
[    1.259737] printk: console [ttyS3] enabled
[    1.268187] printk: bootconsole [ns16550a0] disabled
[    1.279792] tidss 4a00000.dss: WA for erratum i2000: YUV formats disabled
[    1.300101] xhci-hcd xhci-hcd.0.auto: xHCI Host Controller
[    1.305677] xhci-hcd xhci-hcd.0.auto: new USB bus registered, assigned bus number 1
[    1.313447] xhci-hcd xhci-hcd.0.auto: hcc params 0x0298fe6d hci version 0x110 quirks 0x0000000000010010
[    1.322889] xhci-hcd xhci-hcd.0.auto: irq 672, io mem 0x04010000
[    1.329239] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.11
[    1.337504] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.344723] usb usb1: Product: xHCI Host Controller
[    1.349607] usb usb1: Manufacturer: Linux 5.11.0-rc7+ xhci-hcd
[    1.355439] usb usb1: SerialNumber: xhci-hcd.0.auto
[    1.360789] hub 1-0:1.0: USB hub found
[    1.364570] hub 1-0:1.0: 1 port detected
[    1.368754] xhci-hcd xhci-hcd.0.auto: xHCI Host Controller
[    1.374249] xhci-hcd xhci-hcd.0.auto: new USB bus registered, assigned bus number 2
[    1.381911] xhci-hcd xhci-hcd.0.auto: Host supports USB 3.0 SuperSpeed
[    1.388509] usb usb2: We don't know the algorithms for LPM for this host, disabling LPM.
[    1.396682] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.11
[    1.404943] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.412166] usb usb2: Product: xHCI Host Controller
[    1.417043] usb usb2: Manufacturer: Linux 5.11.0-rc7+ xhci-hcd
[    1.422872] usb usb2: SerialNumber: xhci-hcd.0.auto
[    1.428097] hub 2-0:1.0: USB hub found
[    1.431871] hub 2-0:1.0: 1 port detected
[    1.438938] xhci-hcd xhci-hcd.1.auto: xHCI Host Controller
[    1.444503] xhci-hcd xhci-hcd.1.auto: new USB bus registered, assigned bus number 3
[    1.452260] xhci-hcd xhci-hcd.1.auto: hcc params 0x0298fe6d hci version 0x110 quirks 0x0000000000010010
[    1.461701] xhci-hcd xhci-hcd.1.auto: irq 674, io mem 0x04030000
[    1.467986] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.11
[    1.476281] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.483508] usb usb3: Product: xHCI Host Controller
[    1.488385] usb usb3: Manufacturer: Linux 5.11.0-rc7+ xhci-hcd
[    1.494214] usb usb3: SerialNumber: xhci-hcd.1.auto
[    1.499537] hub 3-0:1.0: USB hub found
[    1.503320] hub 3-0:1.0: 1 port detected
[    1.507496] xhci-hcd xhci-hcd.1.auto: xHCI Host Controller
[    1.512992] xhci-hcd xhci-hcd.1.auto: new USB bus registered, assigned bus number 4
[    1.520650] xhci-hcd xhci-hcd.1.auto: Host supports USB 3.0 SuperSpeed
[    1.527221] usb usb4: We don't know the algorithms for LPM for this host, disabling LPM.
[    1.535401] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.11
[    1.543673] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.550893] usb usb4: Product: xHCI Host Controller
[    1.555770] usb usb4: Manufacturer: Linux 5.11.0-rc7+ xhci-hcd
[    1.561600] usb usb4: SerialNumber: xhci-hcd.1.auto
[    1.566820] hub 4-0:1.0: USB hub found
[    1.570597] hub 4-0:1.0: 1 port detected
[    1.577329] mmc0: CQHCI version 5.10
[    1.642185] keystone-pcie 5600000.pcie: host bridge /bus@100000/pcie@5600000 ranges:
[    1.649995] keystone-pcie 5600000.pcie:       IO 0x0018020000..0x001802ffff -> 0x0000000000
[    1.658371] keystone-pcie 5600000.pcie:      MEM 0x0018030000..0x001fffffff -> 0x0018030000
[    1.666860] keystone-pcie 5600000.pcie: iATU unroll: enabled
[    1.672521] keystone-pcie 5600000.pcie: Detected iATU regions: 8 outbound, 8 inbound
[    1.704488] usb 1-1: new high-speed USB device number 2 using xhci-hcd
[    1.856618] usb 1-1: New USB device found, idVendor=0424, idProduct=2514, bcdDevice= b.b3
[    1.864795] usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    1.932634] hub 1-1:1.0: USB hub found
[    1.936415] hub 1-1:1.0: 4 ports detected
[    2.600661] keystone-pcie 5600000.pcie: Phy link never came up
[    2.606661] keystone-pcie 5600000.pcie: PCI host bridge to bus 0000:00
[    2.613193] pci_bus 0000:00: root bus resource [bus 00-ff]
[    2.618680] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    2.624859] pci_bus 0000:00: root bus resource [mem 0x18030000-0x1fffffff]
[    2.631764] pci 0000:00:00.0: [104c:b00c] type 01 class 0x060400
[    2.637783] pci 0000:00:00.0: reg 0x10: [mem 0x05600000-0x056fffff]
[    2.643121] mmc0: SDHCI controller on 4fa0000.sdhci [4fa0000.sdhci] using ADMA 64-bit
[    2.644054] pci 0000:00:00.0: reg 0x38: [mem 0x00000000-0x0000ffff pref]
[    2.658702] pci 0000:00:00.0: supports D1
[    2.662784] pci 0000:00:00.0: PME# supported from D0 D1 D3hot
[    2.724062] pci 0000:00:00.0: BAR 0: assigned [mem 0x18100000-0x181fffff]
[    2.730874] pci 0000:00:00.0: BAR 6: assigned [mem 0x18030000-0x1803ffff pref]
[    2.738105] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
[    2.747083] ti-udma 285c0000.dma-controller: Channels: 96 (tchan: 48, rchan: 48, gp-rflow: 48)
[    2.768172] mmc0: new high speed SDHC card at address 0001
[    2.768844] ti-udma 31150000.dma-controller: Channels: 267 (tchan: 119, rchan: 148, gp-rflow: 150)
[    2.774576] mmcblk0: mmc0:0001 EB1QT 29.8 GiB 
[    2.793842]  mmcblk0: p1
[    2.798100] tidss 4a00000.dss: WA for erratum i2000: YUV formats disabled
[    2.807180] [drm] Initialized tidss 1.0.0 20180215 for 4a00000.dss on minor 0
[    3.425503] Console: switching to colour frame buffer device 128x48
[    3.447638] tidss 4a00000.dss: [drm] fb0: tidssdrmfb frame buffer device
[    3.458668] spi-nor spi7.0: w25q128 (16384 Kbytes)
[    3.463518] 11 cmdlinepart partitions found on MTD device 47040000.spi.0
[    3.470239] Creating 11 MTD partitions on "47040000.spi.0":
[    3.475809] 0x000000000000-0x000000080000 : "ospi.tiboot3"
[    3.482637] 0x000000080000-0x000000280000 : "ospi.tispl"
[    3.489040] 0x000000280000-0x000000680000 : "ospi.u-boot"
[    3.495397] 0x000000680000-0x0000006a0000 : "ospi.env"
[    3.501621] 0x0000006a0000-0x0000006c0000 : "ospi.env.backup"
[    3.508356] 0x0000006c0000-0x0000007c0000 : "ospi.sysfw"
[    3.514694] 0x0000007c0000-0x0000007d0000 : "pru0-fw"
[    3.520780] 0x0000007d0000-0x0000007e0000 : "pru1-fw"
[    3.526812] 0x0000007e0000-0x0000007f0000 : "rtu0-fw"
[    3.532911] 0x0000007f0000-0x000000800000 : "rtu1-fw"
[    3.538944] 0x000000800000-0x000001000000 : "ospi.rootfs"
[    3.555855] debugfs: Directory 'pd:121' with parent 'pm_genpd' already present!
[    3.563374] debugfs: Directory 'pd:120' with parent 'pm_genpd' already present!
[    3.585944] ALSA device list:
[    3.588928]   No soundcards found.
[    3.608678] EXT4-fs (mmcblk0p1): mounted filesystem with ordered data mode. Opts: (null). Quota mode: none.
[    3.618522] VFS: Mounted root (ext4 filesystem) on device 179:1.
[    3.632595] devtmpfs: mounted
[    3.636862] Freeing unused kernel memory: 1600K
[    3.641585] Run /sbin/init as init process
[    3.645686]   with arguments:
[    3.645690]     /sbin/init
[    3.645695]   with environment:
[    3.645698]     HOME=/
[    3.645702]     TERM=linux
[    4.340066] NET: Registered protocol family 10
[    4.345602] Segment Routing with IPv6
[    4.384426] systemd[1]: systemd 241 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN2 +IDN -PCRE2 default-hierarchy=hybrid)
[    4.406189] systemd[1]: Detected architecture arm64.
[    4.449370] systemd[1]: Set hostname to <iot2050-debian>.
[    4.780163] systemd[1]: File /lib/systemd/system/systemd-journald.service:12 configures an IP firewall (IPAddressDeny=any), but the local system does not support BPF/cgroup based firewalling.
[    4.797263] systemd[1]: Proceeding WITHOUT firewalling in effect! (This warning is only shown for the first loaded unit using IP firewalling.)
[    5.039457] random: systemd: uninitialized urandom read (16 bytes read)
[    5.050371] random: systemd: uninitialized urandom read (16 bytes read)
[    5.059342] systemd[1]: Created slice User and Session Slice.
[    5.080772] random: systemd: uninitialized urandom read (16 bytes read)
[    5.088035] systemd[1]: Listening on udev Control Socket.
[    5.108864] systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
[    5.134780] systemd[1]: Created slice system-serial\x2dgetty.slice.
[    5.157035] systemd[1]: Listening on udev Kernel Socket.
[    5.625938] EXT4-fs (mmcblk0p1): re-mounted. Opts: (null). Quota mode: none.
[    5.995598] systemd-journald[128]: Received request to flush runtime journal from PID 1
[    7.066205] at24 2-0054: supply vcc not found, using dummy regulator
[    7.074050] at24 2-0054: 1024 byte 24c08 EEPROM, writable, 16 bytes/write
[    7.375215] pci-endpoint-test 0000:00:00.0: of_irq_parse_pci: failed with rc=-22
[    7.535480] cal 6f03000.cal: Neither port is configured, no point in staying up
[    8.148142] k3_r5_rproc bus@100000:bus@28380000:r5fss@41000000: lockstep mode not permitted, force configuring for split-mode
[    8.201607] platform 41000000.r5f: device does not have reserved memory regions, ret = -22
[    8.221425] k3_r5_rproc bus@100000:bus@28380000:r5fss@41000000: reserved memory init failed, ret = -22
[    8.254751] remoteproc remoteproc0: releasing 41000000.r5f
[    8.261591] k3_r5_rproc bus@100000:bus@28380000:r5fss@41000000: k3_r5_cluster_rproc_init failed, ret = -22
[    8.311507] k3_r5_rproc: probe of bus@100000:bus@28380000:r5fss@41000000 failed with error -22
[   10.700503] random: crng init done
[   10.703926] random: 7 urandom warning(s) missed due to ratelimiting
[   33.844585] tps62363-vout: disabling 

And this is for the advanced one:

[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd034]
[    0.000000] Linux version 5.11.0-rc7+ (jan@md1f2u6c) (aarch64-linux-gnu-gcc (GNU Toolchain for the A-profile Architecture 9.2-2019.12 (arm-9.10)) 9.2.1 20191025, GNU ld (GNU Toolchain for the A-profile Architecture 9.2-2019.12 (arm-9.10)) 2.33.1.20191209) #114 SMP PREEMPT Fri Feb 12 20:23:32 CET 2021
[    0.000000] Machine model: SIMATIC IOT2050 Advanced
[    0.000000] earlycon: ns16550a0 at MMIO32 0x0000000002810000 (options '')
[    0.000000] printk: bootconsole [ns16550a0] enabled
[    0.000000] Reserved memory: created DMA memory pool at 0x00000000a0000000, size 1 MiB
[    0.000000] OF: reserved mem: initialized node r5f-dma-memory@a0000000, compatible id shared-dma-pool
[    0.000000] Reserved memory: created DMA memory pool at 0x00000000a0100000, size 15 MiB
[    0.000000] OF: reserved mem: initialized node r5f-memory@a0100000, compatible id shared-dma-pool
[    0.000000] Reserved memory: created DMA memory pool at 0x00000000a1000000, size 1 MiB
[    0.000000] OF: reserved mem: initialized node r5f-dma-memory@a1000000, compatible id shared-dma-pool
[    0.000000] Reserved memory: created DMA memory pool at 0x00000000a1100000, size 15 MiB
[    0.000000] OF: reserved mem: initialized node r5f-memory@a1100000, compatible id shared-dma-pool
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000080000000-0x00000000ffffffff]
[    0.000000]   DMA32    empty
[    0.000000]   Normal   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000080000000-0x000000009e7fffff]
[    0.000000]   node   0: [mem 0x00000000a2200000-0x00000000ffffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000080000000-0x00000000ffffffff]
[    0.000000] On node 0 totalpages: 509440
[    0.000000]   DMA zone: 8192 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 509440 pages, LIFO batch:63
[    0.000000] cma: Reserved 24 MiB at 0x00000000fe000000
[    0.000000] psci: probing for conduit method from DT.
[    0.000000] psci: PSCIv1.1 detected in firmware.
[    0.000000] psci: Using standard PSCI v0.2 function IDs
[    0.000000] psci: Trusted OS migration not required
[    0.000000] psci: SMC Calling Convention v1.2
[    0.000000] percpu: Embedded 22 pages/cpu s49560 r8192 d32360 u90112
[    0.000000] pcpu-alloc: s49560 r8192 d32360 u90112 alloc=22*4096
[    0.000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3 
[    0.000000] Detected VIPT I-cache on CPU0
[    0.000000] CPU features: detected: ARM erratum 845719
[    0.000000] CPU features: detected: GIC system register CPU interface
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 501248
[    0.000000] Kernel command line: root=PARTUUID=5b41c2ce-baaf-4ead-ab35-bf49ecc9f0e9 console=ttyS3,115200n8 earlycon=ns16550a,mmio32,0x02810000 mtdparts=47040000.spi.0:512k(ospi.tiboot3),2m(ospi.tispl),4m(ospi.u-boot),128k(ospi.env),128k(ospi.env.backup),1m(ospi.sysfw),64k(pru0-fw),64k(pru1-fw),64k(rtu0-fw),64k(rtu1-fw),-@8m(ospi.rootfs) rw rootwait
[    0.000000] Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.000000] Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes, linear)
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] Memory: 1955108K/2037760K available (10560K kernel code, 1038K rwdata, 3976K rodata, 1600K init, 390K bss, 58076K reserved, 24576K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] rcu: Preemptible hierarchical RCU implementation.
[    0.000000] rcu: 	RCU event tracing is enabled.
[    0.000000] rcu: 	RCU restricting CPUs from NR_CPUS=256 to nr_cpu_ids=4.
[    0.000000] 	Trampoline variant of Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] GICv3: GIC: Using split EOI/Deactivate mode
[    0.000000] GICv3: 960 SPIs implemented
[    0.000000] GICv3: 0 Extended SPIs implemented
[    0.000000] GICv3: Distributor has no Range Selector support
[    0.000000] GICv3: 16 PPIs implemented
[    0.000000] GICv3: CPU0: found redistributor 0 region 0:0x0000000001880000
[    0.000000] ITS [mem 0x01820000-0x0182ffff]
[    0.000000] GIC: enabling workaround for ITS: Socionext Synquacer pre-ITS
[    0.000000] ITS@0x0000000001820000: Devices Table too large, reduce ids 20->19
[    0.000000] ITS@0x0000000001820000: allocated 524288 Devices @81c00000 (flat, esz 8, psz 64K, shr 0)
[    0.000000] ITS: using cache flushing for cmd queue
[    0.000000] GICv3: using LPI property table @0x0000000081440000
[    0.000000] GIC: using cache flushing for LPI property table
[    0.000000] GICv3: CPU0: using allocated LPI pending table @0x0000000081450000
[    0.000000] random: get_random_bytes called from start_kernel+0x350/0x4fc with crng_init=0
[    0.000000] arch_timer: cp15 timer(s) running at 200.00MHz (phys).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x2e2049d3e8, max_idle_ns: 440795210634 ns
[    0.000001] sched_clock: 56 bits at 200MHz, resolution 5ns, wraps every 4398046511102ns
[    0.008510] Console: colour dummy device 80x25
[    0.013108] Calibrating delay loop (skipped), value calculated using timer frequency.. 400.00 BogoMIPS (lpj=800000)
[    0.023796] pid_max: default: 32768 minimum: 301
[    0.028617] LSM: Security Framework initializing
[    0.033401] Mount-cache hash table entries: 4096 (order: 3, 32768 bytes, linear)
[    0.040983] Mountpoint-cache hash table entries: 4096 (order: 3, 32768 bytes, linear)
[    0.050834] rcu: Hierarchical SRCU implementation.
[    0.056051] Platform MSI: msi-controller@1820000 domain created
[    0.062271] PCI/MSI: /bus@100000/interrupt-controller@1800000/msi-controller@1820000 domain created
[    0.071823] smp: Bringing up secondary CPUs ...
[    0.085416] Detected VIPT I-cache on CPU1
[    0.085458] GICv3: CPU1: found redistributor 1 region 0:0x00000000018a0000
[    0.085476] GICv3: CPU1: using allocated LPI pending table @0x0000000081460000
[    0.085537] CPU1: Booted secondary processor 0x0000000001 [0x410fd034]
[    0.094689] Detected VIPT I-cache on CPU2
[    0.094740] GICv3: CPU2: found redistributor 100 region 0:0x00000000018c0000
[    0.094759] GICv3: CPU2: using allocated LPI pending table @0x0000000081470000
[    0.094824] CPU2: Booted secondary processor 0x0000000100 [0x410fd034]
[    0.103920] Detected VIPT I-cache on CPU3
[    0.103945] GICv3: CPU3: found redistributor 101 region 0:0x00000000018e0000
[    0.103957] GICv3: CPU3: using allocated LPI pending table @0x0000000081480000
[    0.103994] CPU3: Booted secondary processor 0x0000000101 [0x410fd034]
[    0.104138] smp: Brought up 1 node, 4 CPUs
[    0.184244] SMP: Total of 4 processors activated.
[    0.189062] CPU features: detected: 32-bit EL0 Support
[    0.194337] CPU features: detected: CRC32 instructions
[    0.213629] CPU: All CPU(s) started at EL2
[    0.217873] alternatives: patching kernel code
[    0.223686] devtmpfs: initialized
[    0.233585] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.243593] futex hash table entries: 1024 (order: 4, 65536 bytes, linear)
[    0.251633] pinctrl core: initialized pinctrl subsystem
[    0.258154] NET: Registered protocol family 16
[    0.264530] DMA: preallocated 256 KiB GFP_KERNEL pool for atomic allocations
[    0.271939] DMA: preallocated 256 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
[    0.280082] DMA: preallocated 256 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
[    0.288714] thermal_sys: Registered thermal governor 'step_wise'
[    0.289249] hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
[    0.302459] ASID allocator initialised with 65536 entries
[    0.335136] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    0.342031] HugeTLB registered 32.0 MiB page size, pre-allocated 0 pages
[    0.348890] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.355747] HugeTLB registered 64.0 KiB page size, pre-allocated 0 pages
[    0.367291] k3-chipinfo 43000014.chipid: Family:AM65X rev:SR1.0 JTAGID[0x0bb5a02f] Detected
[    0.376978] iommu: Default domain type: Translated 
[    0.382318] SCSI subsystem initialized
[    0.386366] usbcore: registered new interface driver usbfs
[    0.392015] usbcore: registered new interface driver hub
[    0.397480] usbcore: registered new device driver usb
[    0.403068] mc: Linux media interface: v0.10
[    0.407464] videodev: Linux video capture interface: v2.00
[    0.413136] EDAC MC: Ver: 3.0.0
[    0.416827] omap-mailbox 31f80000.mailbox: no available mbox devices found
[    0.423931] omap-mailbox 31f81000.mailbox: no available mbox devices found
[    0.431002] omap-mailbox 31f82000.mailbox: no available mbox devices found
[    0.438072] omap-mailbox 31f83000.mailbox: no available mbox devices found
[    0.445138] omap-mailbox 31f84000.mailbox: no available mbox devices found
[    0.452208] omap-mailbox 31f85000.mailbox: no available mbox devices found
[    0.459276] omap-mailbox 31f86000.mailbox: no available mbox devices found
[    0.466345] omap-mailbox 31f87000.mailbox: no available mbox devices found
[    0.473412] omap-mailbox 31f88000.mailbox: no available mbox devices found
[    0.480482] omap-mailbox 31f89000.mailbox: no available mbox devices found
[    0.487556] omap-mailbox 31f8a000.mailbox: no available mbox devices found
[    0.494624] omap-mailbox 31f8b000.mailbox: no available mbox devices found
[    0.502168] Advanced Linux Sound Architecture Driver Initialized.
[    0.509250] clocksource: Switched to clocksource arch_sys_counter
[    0.515689] VFS: Disk quotas dquot_6.6.0
[    0.519761] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.533593] NET: Registered protocol family 2
[    0.538731] tcp_listen_portaddr_hash hash table entries: 1024 (order: 2, 16384 bytes, linear)
[    0.547577] TCP established hash table entries: 16384 (order: 5, 131072 bytes, linear)
[    0.555819] TCP bind hash table entries: 16384 (order: 6, 262144 bytes, linear)
[    0.563607] TCP: Hash tables configured (established 16384 bind 16384)
[    0.570489] UDP hash table entries: 1024 (order: 3, 32768 bytes, linear)
[    0.577405] UDP-Lite hash table entries: 1024 (order: 3, 32768 bytes, linear)
[    0.584917] NET: Registered protocol family 1
[    0.589874] RPC: Registered named UNIX socket transport module.
[    0.595954] RPC: Registered udp transport module.
[    0.600794] RPC: Registered tcp transport module.
[    0.605611] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.612207] PCI: CLS 0 bytes, default 64
[    0.617270] hw perfevents: enabled with armv8_pmuv3 PMU driver, 7 counters available
[    0.626815] Initialise system trusted keyrings
[    0.631588] workingset: timestamp_bits=46 max_order=19 bucket_order=0
[    0.642617] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.649202] NFS: Registering the id_resolver key type
[    0.654419] Key type id_resolver registered
[    0.658701] Key type id_legacy registered
[    0.662871] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    0.669935] 9p: Installing v9fs 9p2000 file system support
[    0.719428] Key type asymmetric registered
[    0.723630] Asymmetric key parser 'x509' registered
[    0.728656] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 247)
[    0.736380] io scheduler mq-deadline registered
[    0.741026] io scheduler kyber registered
[    0.747529] pinctrl-single 4301c000.pinctrl: 70 pins, size 280
[    0.754044] pinctrl-single 11c000.pinctrl: 185 pins, size 740
[    0.760087] pinctrl-single 11c2e8.pinctrl: 9 pins, size 36
[    0.770390] k3-ringacc 2b800000.ringacc: Failed to get MSI domain
[    0.776737] k3-ringacc 3c000000.ringacc: Failed to get MSI domain
[    0.787143] Serial: 8250/16550 driver, 10 ports, IRQ sharing enabled
[    0.809214] brd: module loaded
[    0.820498] loop: module loaded
[    0.826637] libphy: Fixed MDIO Bus: probed
[    0.831552] tun: Universal TUN/TAP device driver, 1.6
[    0.837481] igbvf: Intel(R) Gigabit Virtual Function Network Driver
[    0.843898] igbvf: Copyright (c) 2009 - 2012 Intel Corporation.
[    0.850010] sky2: driver version 1.30
[    0.854301] VFIO - User Level meta-driver version: 0.3
[    0.861072] usbcore: registered new interface driver usb-storage
[    0.867750] i2c /dev entries driver
[    0.872288] sdhci: Secure Digital Host Controller Interface driver
[    0.878625] sdhci: Copyright(c) Pierre Ossman
[    0.883409] sdhci-pltfm: SDHCI platform and OF driver helper
[    0.890677] ledtrig-cpu: registered to indicate activity on CPUs
[    0.896933] ti-sci bus@100000:bus@28380000:bus@42040000:dmsc: invalid resource
[    0.904489] SMCCC: SOC_ID: ARCH_SOC_ID not implemented, skipping ....
[    0.911212] usbcore: registered new interface driver usbhid
[    0.916918] usbhid: USB HID core driver
[    0.922423] optee: probing for conduit method.
[    0.927008] optee: revision 3.12
[    0.927496] optee: initialized driver
[    0.935831] NET: Registered protocol family 17
[    0.940546] 9pnet: Installing 9P2000 support
[    0.944978] Key type dns_resolver registered
[    0.949614] registered taskstats version 1
[    0.953817] Loading compiled-in X.509 certificates
[    0.967738] k3-ringacc 2b800000.ringacc: Failed to get MSI domain
[    0.974232] k3-ringacc 3c000000.ringacc: Failed to get MSI domain
[    0.985895] ti-sci bus@100000:bus@28380000:bus@42040000:dmsc: invalid resource
[    0.993493] ti-sci bus@100000:bus@28380000:bus@42040000:dmsc: ABI: 3.1 (firmware rev 0x0014 '20.8.5--v2020.08b (Terrific Lla')
[    1.054359] omap_i2c 42120000.i2c: bus 0 rev0.12 at 400 kHz
[    1.085523] random: fast init done
[    1.089563] pca953x 1-0020: supply vcc not found, using dummy regulator
[    1.096480] pca953x 1-0020: using no AI
[    1.101216] pca953x 1-0021: supply vcc not found, using dummy regulator
[    1.108081] pca953x 1-0021: using no AI
[    1.112755] pca953x 1-0025: supply vcc not found, using dummy regulator
[    1.119621] pca953x 1-0025: using no AI
[    1.124194] omap_i2c 40b00000.i2c: bus 1 rev0.12 at 400 kHz
[    1.154921] rtc-pcf8563 2-0051: registered as rtc0
[    1.160189] rtc-pcf8563 2-0051: setting system clock to 2021-02-12T19:27:36 UTC (1613158056)
[    1.169446] omap_i2c 2000000.i2c: bus 2 rev0.12 at 400 kHz
[    1.176012] omap_i2c 2010000.i2c: bus 3 rev0.12 at 400 kHz
[    1.182497] omap_i2c 2020000.i2c: bus 4 rev0.12 at 400 kHz
[    1.189346] omap_i2c 2030000.i2c: bus 5 rev0.12 at 400 kHz
[    1.195380] ti-sci-intr bus@100000:bus@28380000:bus@42040000:interrupt-controller2: Interrupt Router 156 domain created
[    1.206608] ti-sci-intr bus@100000:interrupt-controller0: Interrupt Router 100 domain created
[    1.215533] ti-sci-intr bus@100000:main-navss:interrupt-controller1: Interrupt Router 182 domain created
[    1.225565] ti-sci-inta 33d00000.interrupt-controller: Interrupt Aggregator domain 179 created
[    1.245432] k3-ringacc 2b800000.ringacc: Ring Accelerator probed rings:286, gp-rings[96,160] sci-dev-id:195
[    1.255439] k3-ringacc 2b800000.ringacc: dma-ring-reset-quirk: enabled
[    1.262128] k3-ringacc 2b800000.ringacc: RA Proxy rev. 66344100, num_proxies:64
[    1.281881] k3-ringacc 3c000000.ringacc: Ring Accelerator probed rings:818, gp-rings[304,464] sci-dev-id:187
[    1.291977] k3-ringacc 3c000000.ringacc: dma-ring-reset-quirk: enabled
[    1.298660] k3-ringacc 3c000000.ringacc: RA Proxy rev. 66344100, num_proxies:64
[    1.307314] 40a00000.serial: ttyS1 at MMIO 0x40a00000 (irq = 16, base_baud = 6000000) is a 8250
[    1.317403] 2810000.serial: ttyS3 at MMIO 0x2810000 (irq = 24, base_baud = 3000000) is a 8250
[    1.326186] printk: console [ttyS3] enabled
[    1.334648] printk: bootconsole [ns16550a0] disabled
[    1.346229] tidss 4a00000.dss: WA for erratum i2000: YUV formats disabled
[    1.366448] xhci-hcd xhci-hcd.0.auto: xHCI Host Controller
[    1.372012] xhci-hcd xhci-hcd.0.auto: new USB bus registered, assigned bus number 1
[    1.379813] xhci-hcd xhci-hcd.0.auto: hcc params 0x0298fe6d hci version 0x110 quirks 0x0000000000010010
[    1.389260] xhci-hcd xhci-hcd.0.auto: irq 672, io mem 0x04010000
[    1.395591] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.11
[    1.403857] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.411081] usb usb1: Product: xHCI Host Controller
[    1.415957] usb usb1: Manufacturer: Linux 5.11.0-rc7+ xhci-hcd
[    1.421797] usb usb1: SerialNumber: xhci-hcd.0.auto
[    1.427135] hub 1-0:1.0: USB hub found
[    1.430920] hub 1-0:1.0: 1 port detected
[    1.435125] xhci-hcd xhci-hcd.0.auto: xHCI Host Controller
[    1.440621] xhci-hcd xhci-hcd.0.auto: new USB bus registered, assigned bus number 2
[    1.448285] xhci-hcd xhci-hcd.0.auto: Host supports USB 3.0 SuperSpeed
[    1.454860] usb usb2: We don't know the algorithms for LPM for this host, disabling LPM.
[    1.463031] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.11
[    1.471293] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.478513] usb usb2: Product: xHCI Host Controller
[    1.483395] usb usb2: Manufacturer: Linux 5.11.0-rc7+ xhci-hcd
[    1.489234] usb usb2: SerialNumber: xhci-hcd.0.auto
[    1.494456] hub 2-0:1.0: USB hub found
[    1.498232] hub 2-0:1.0: 1 port detected
[    1.505178] xhci-hcd xhci-hcd.1.auto: xHCI Host Controller
[    1.510709] xhci-hcd xhci-hcd.1.auto: new USB bus registered, assigned bus number 3
[    1.518471] xhci-hcd xhci-hcd.1.auto: hcc params 0x0298fe6d hci version 0x110 quirks 0x0000000000010010
[    1.527918] xhci-hcd xhci-hcd.1.auto: irq 674, io mem 0x04030000
[    1.534223] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.11
[    1.542514] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.549736] usb usb3: Product: xHCI Host Controller
[    1.554612] usb usb3: Manufacturer: Linux 5.11.0-rc7+ xhci-hcd
[    1.560441] usb usb3: SerialNumber: xhci-hcd.1.auto
[    1.565704] hub 3-0:1.0: USB hub found
[    1.569486] hub 3-0:1.0: 1 port detected
[    1.573656] xhci-hcd xhci-hcd.1.auto: xHCI Host Controller
[    1.579153] xhci-hcd xhci-hcd.1.auto: new USB bus registered, assigned bus number 4
[    1.586816] xhci-hcd xhci-hcd.1.auto: Host supports USB 3.0 SuperSpeed
[    1.593388] usb usb4: We don't know the algorithms for LPM for this host, disabling LPM.
[    1.601561] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.11
[    1.609834] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.617056] usb usb4: Product: xHCI Host Controller
[    1.621933] usb usb4: Manufacturer: Linux 5.11.0-rc7+ xhci-hcd
[    1.627762] usb usb4: SerialNumber: xhci-hcd.1.auto
[    1.632989] hub 4-0:1.0: USB hub found
[    1.636765] hub 4-0:1.0: 1 port detected
[    1.643928] mmc0: CQHCI version 5.10
[    1.643927] mmc1: CQHCI version 5.10
[    1.692448] mmc0: SDHCI controller on 4f80000.sdhci [4f80000.sdhci] using ADMA 64-bit
[    1.702933] keystone-pcie 5600000.pcie: host bridge /bus@100000/pcie@5600000 ranges:
[    1.710732] keystone-pcie 5600000.pcie:       IO 0x0018020000..0x001802ffff -> 0x0000000000
[    1.719099] keystone-pcie 5600000.pcie:      MEM 0x0018030000..0x001fffffff -> 0x0018030000
[    1.727609] keystone-pcie 5600000.pcie: iATU unroll: enabled
[    1.733271] keystone-pcie 5600000.pcie: Detected iATU regions: 8 outbound, 8 inbound
[    1.773263] usb 1-1: new high-speed USB device number 2 using xhci-hcd
[    1.789197] mmc0: Command Queue Engine enabled
[    1.793669] mmc0: new HS200 MMC card at address 0001
[    1.799324] mmcblk0: mmc0:0001 S0J56X 14.8 GiB 
[    1.804116] mmcblk0boot0: mmc0:0001 S0J56X partition 1 31.5 MiB
[    1.810304] mmcblk0boot1: mmc0:0001 S0J56X partition 2 31.5 MiB
[    1.816428] mmcblk0rpmb: mmc0:0001 S0J56X partition 3 4.00 MiB, chardev (245:0)
[    1.925418] usb 1-1: New USB device found, idVendor=0424, idProduct=2514, bcdDevice= b.b3
[    1.933625] usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    1.999005] hub 1-1:1.0: USB hub found
[    2.002831] hub 1-1:1.0: 4 ports detected
[    2.349255] usb 1-1.4: new full-speed USB device number 3 using xhci-hcd
[    2.454888] usb 1-1.4: New USB device found, idVendor=10c4, idProduct=ea60, bcdDevice= 1.00
[    2.463243] usb 1-1.4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    2.470550] usb 1-1.4: Product: CP2102N USB to UART Bridge Controller
[    2.476987] usb 1-1.4: Manufacturer: Silicon Labs
[    2.481692] usb 1-1.4: SerialNumber: dcfb480fd22aea11ba71bcfad0cd4f36
[    2.714073] mmc1: SDHCI controller on 4fa0000.sdhci [4fa0000.sdhci] using ADMA 64-bit
[    2.741343] keystone-pcie 5600000.pcie: Phy link never came up
[    2.747365] keystone-pcie 5600000.pcie: PCI host bridge to bus 0000:00
[    2.753907] pci_bus 0000:00: root bus resource [bus 00-ff]
[    2.755552] mmc1: new high speed SDHC card at address 0001
[    2.759397] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    2.765618] mmcblk1: mmc1:0001 EB1QT 29.8 GiB 
[    2.771064] pci_bus 0000:00: root bus resource [mem 0x18030000-0x1fffffff]
[    2.782183]  mmcblk1: p1
[    2.782435] pci 0000:00:00.0: [104c:b00c] type 01 class 0x060400
[    2.790926] pci 0000:00:00.0: reg 0x10: [mem 0x05600000-0x056fffff]
[    2.797203] pci 0000:00:00.0: reg 0x38: [mem 0x00000000-0x0000ffff pref]
[    2.803960] pci 0000:00:00.0: supports D1
[    2.807973] pci 0000:00:00.0: PME# supported from D0 D1 D3hot
[    2.869181] pci 0000:00:00.0: BAR 0: assigned [mem 0x18100000-0x181fffff]
[    2.875982] pci 0000:00:00.0: BAR 6: assigned [mem 0x18030000-0x1803ffff pref]
[    2.883209] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
[    2.892353] ti-udma 285c0000.dma-controller: Channels: 96 (tchan: 48, rchan: 48, gp-rflow: 48)
[    2.913768] ti-udma 31150000.dma-controller: Channels: 267 (tchan: 119, rchan: 148, gp-rflow: 150)
[    2.936853] tidss 4a00000.dss: WA for erratum i2000: YUV formats disabled
[    2.946023] [drm] Initialized tidss 1.0.0 20180215 for 4a00000.dss on minor 0
[    2.953641] tidss 4a00000.dss: [drm] Cannot find any crtc or sizes
[    2.964356] spi-nor spi7.0: w25q128 (16384 Kbytes)
[    2.969191] 11 cmdlinepart partitions found on MTD device 47040000.spi.0
[    2.975891] Creating 11 MTD partitions on "47040000.spi.0":
[    2.981463] 0x000000000000-0x000000080000 : "ospi.tiboot3"
[    2.988251] 0x000000080000-0x000000280000 : "ospi.tispl"
[    2.994640] 0x000000280000-0x000000680000 : "ospi.u-boot"
[    3.001158] 0x000000680000-0x0000006a0000 : "ospi.env"
[    3.007340] 0x0000006a0000-0x0000006c0000 : "ospi.env.backup"
[    3.014123] 0x0000006c0000-0x0000007c0000 : "ospi.sysfw"
[    3.020507] 0x0000007c0000-0x0000007d0000 : "pru0-fw"
[    3.026589] 0x0000007d0000-0x0000007e0000 : "pru1-fw"
[    3.032699] 0x0000007e0000-0x0000007f0000 : "rtu0-fw"
[    3.038826] 0x0000007f0000-0x000000800000 : "rtu1-fw"
[    3.044934] 0x000000800000-0x000001000000 : "ospi.rootfs"
[    3.061702] debugfs: Directory 'pd:121' with parent 'pm_genpd' already present!
[    3.069108] debugfs: Directory 'pd:120' with parent 'pm_genpd' already present!
[    3.092768] ALSA device list:
[    3.095770]   No soundcards found.
[    3.115490] EXT4-fs (mmcblk1p1): mounted filesystem with ordered data mode. Opts: (null). Quota mode: none.
[    3.125351] VFS: Mounted root (ext4 filesystem) on device 179:97.
[    3.139299] devtmpfs: mounted
[    3.143384] Freeing unused kernel memory: 1600K
[    3.148102] Run /sbin/init as init process
[    3.152205]   with arguments:
[    3.152209]     /sbin/init
[    3.152213]   with environment:
[    3.152217]     HOME=/
[    3.152221]     TERM=linux
[    3.846631] NET: Registered protocol family 10
[    3.852223] Segment Routing with IPv6
[    3.890207] systemd[1]: systemd 241 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN2 +IDN -PCRE2 default-hierarchy=hybrid)
[    3.911981] systemd[1]: Detected architecture arm64.
[    3.962185] systemd[1]: Set hostname to <iot2050-debian>.
[    4.176337] systemd[1]: File /lib/systemd/system/systemd-journald.service:12 configures an IP firewall (IPAddressDeny=any), but the local system does not support BPF/cgroup based firewalling.
[    4.193481] systemd[1]: Proceeding WITHOUT firewalling in effect! (This warning is only shown for the first loaded unit using IP firewalling.)
[    4.432797] random: systemd: uninitialized urandom read (16 bytes read)
[    4.443728] random: systemd: uninitialized urandom read (16 bytes read)
[    4.451143] systemd[1]: Listening on Journal Socket (/dev/log).
[    4.473434] systemd[1]: Condition check resulted in Arbitrary Executable File Formats File System Automount Point being skipped.
[    4.485063] random: systemd: uninitialized urandom read (16 bytes read)
[    4.494680] systemd[1]: Created slice system-serial\x2dgetty.slice.
[    4.517678] systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
[    4.541368] systemd[1]: Reached target Remote File Systems.
[    4.890858] EXT4-fs (mmcblk1p1): re-mounted. Opts: (null). Quota mode: none.
[    5.302022] systemd-journald[148]: Received request to flush runtime journal from PID 1
[    5.887034] at24 2-0054: supply vcc not found, using dummy regulator
[    5.900548] at24 2-0054: 1024 byte 24c08 EEPROM, writable, 16 bytes/write
[    6.032708] pci-endpoint-test 0000:00:00.0: of_irq_parse_pci: failed with rc=-22
[    6.104255] cal 6f03000.cal: Neither port is configured, no point in staying up
[    6.214760] usbcore: registered new interface driver cp210x
[    6.228193] usbserial: USB Serial support registered for cp210x
[    6.239597] cp210x 1-1.4:1.0: cp210x converter detected
[    6.253751] usb 1-1.4: cp210x converter now attached to ttyUSB0
[    6.445964] platform 41000000.r5f: device does not have reserved memory regions, ret = -22
[    6.468107] k3_r5_rproc bus@100000:bus@28380000:r5fss@41000000: reserved memory init failed, ret = -22
[    6.481711] remoteproc remoteproc0: releasing 41000000.r5f
[    6.487940] k3_r5_rproc bus@100000:bus@28380000:r5fss@41000000: k3_r5_cluster_rproc_init failed, ret = -22
[    6.500350] k3_r5_rproc: probe of bus@100000:bus@28380000:r5fss@41000000 failed with error -22
[    9.853279] random: crng init done
[    9.856706] random: 7 urandom warning(s) missed due to ratelimiting
[   13.150202] tidss 4a00000.dss: [drm] Cannot find any crtc or sizes
[   33.885326] tps62363-vout: disabling

At this chance the note that booting mainline requires WiP mainline 
firmware which can be built from [1] already. But installing it is at 
own risk until we released it officially.

Jan

[1] https://github.com/siemens/meta-iot2050/tree/master/recipes-bsp/u-boot
    (./kas-container build kas-iot2050-boot-advanced.yml:kas/opt/upstream.yml)

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux
