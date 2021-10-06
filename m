Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6B7E42353C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 02:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237059AbhJFAot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 20:44:49 -0400
Received: from mail-0301.mail-europe.com ([188.165.51.139]:35961 "EHLO
        mail-0301.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbhJFAor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 20:44:47 -0400
Date:   Wed, 06 Oct 2021 00:42:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1633480967;
        bh=dSwkgZ/WPxqfoUpPvRYs8WMkeUiA3w3GoYyGYRAdePs=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=YMMG9dL/Yg2HifhTYsTEMrC98Phzy69LW4kbHH//ZiuIV+Mpjh5JL1Di50cepqtVx
         xRdBidVrT2zQBhgmCDcJeNagohu8QOd8hkMES28FEjqyEoU47OoS5Xr8GD5tjvhYul
         eEqXxpfpWDx2uApSMXfKgnU6/iXGMi+xbxJo/Lks=
To:     Borislav Petkov <bp@alien8.de>
From:   Ser Olmy <ser.olmy@protonmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        x86-ml <x86@kernel.org>
Reply-To: Ser Olmy <ser.olmy@protonmail.com>
Subject: Re: [x86] Kernel v5.14 series panic on Celeron Mendocino CPU
Message-ID: <YqPgABmVMzvEllmeYzm8tkSaqtC-Q8nzeNjgNBXVPnQtPCHAeFg7IdwpzBECDcFGjrCBkFVegcYvqh_KoGnyOsbK4oC91VHw5G-qUlwlCvM=@protonmail.com>
In-Reply-To: <YVwjY9TX6XMxkM2f@zn.tnic>
References: <CPeoI7yf4421QpWLM-CbgeDR17BBmhlLoixeYI3mu2WbDkgrZItfgImOO6BZez7CXQXXO9liq-rmZzgRVB95TP5MN0xUA8-d7-fSQZdyIZE=@protonmail.com> <YVtA67jImg3KlBTw@zn.tnic> <lxqAtqDf_kLUxIlvmYPvuKB36LOK-z_cVbS9OOl0MbjZKZEaCaEFmHCbSy5sWBer6f9V_WAPLxUuSNrDBvyzEeQOJXepkVUztPXAOhPZniQ=@protonmail.com> <YVwjY9TX6XMxkM2f@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, October 5th, 2021 at 12:05 PM, Borislav Petkov <bp@alien8.de> w=
rote:
>
> Can you apply the diff below on your 5.14.9 kernel, boot with it and
>
> send full dmesg again?

Sure:

[    0.000000] Linux version 5.14.9 (root@test.test.lan) (gcc (GCC) 11.2.0,=
 GNU ld version 2.37-slack15) #1 SMP Tue Oct 5 21:39:21
[    0.000000] fpu__init_system_mxcsr: mxcsr_feature_mask: 0xffbf, mask: 0x=
ffbf
[    0.000000] x86/fpu: x87 FPU will use FXSAVE
[    0.000000] signal: max sigframe size: 1440
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009f7ff] usabl=
e
[    0.000000] BIOS-e820: [mem 0x000000000009f800-0x000000000009ffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000017eeffff] usabl=
e
[    0.000000] BIOS-e820: [mem 0x0000000017ef0000-0x0000000017effbff] ACPI =
data
[    0.000000] BIOS-e820: [mem 0x0000000017effc00-0x0000000017efffff] ACPI =
NVS
[    0.000000] BIOS-e820: [mem 0x0000000017f00000-0x0000000017ffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fff00000-0x00000000ffffffff] reser=
ved
[    0.000000] Notice: NX (Execute Disable) protection missing in CPU!
[    0.000000] SMBIOS 2.3 present.
[    0.000000] DMI: Hewlett-Packard HP PC/HP Board, BIOS  JD.00.06 12/06/20=
01
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 531.638 MHz processor
[    0.004132] last_pfn =3D 0x17ef0 max_arch_pfn =3D 0x1000000
[    0.004417] x86/PAT: PAT not supported by the CPU.
[    0.006077] x86/PAT: Configuration [0-7]: WB  WT  UC- UC  WB  WT  UC- UC
[    0.035166] RAMDISK: [mem 0x17492000-0x17eeffff]
[    0.035212] ACPI: Early table checksum verification disabled
[    0.035248] ACPI: RSDP 0x00000000000F6510 000014 (v00 PTLTD )
[    0.035292] ACPI: RSDT 0x0000000017EF9B1D 000030 (v01 HP     HPBDD_JD 00=
001000  LTP 00000000)
[    0.035343] ACPI: FACP 0x0000000017EFFB0B 000074 (v01 HP     HPBDD_JD 00=
001000 PTL  00001002)
[    0.035400] ACPI: DSDT 0x0000000017EF9B4D 005FBE (v01 HP     HPBDD_IZ 00=
001000 MSFT 0100000B)
[    0.035442] ACPI: FACS 0x0000000017EFFFC0 000040
[    0.035477] ACPI: APIC 0x0000000017EFFB7F 00005A (v01 HP     HPBDD_JD 00=
001000  LTP 00000000)
[    0.035518] ACPI: BOOT 0x0000000017EFFBD9 000027 (v01 PTLTD  $SBFTBL$ 00=
001000  LTP 00000001)
[    0.035554] ACPI: Reserving FACP table memory at [mem 0x17effb0b-0x17eff=
b7e]
[    0.035575] ACPI: Reserving DSDT table memory at [mem 0x17ef9b4d-0x17eff=
b0a]
[    0.035593] ACPI: Reserving FACS table memory at [mem 0x17efffc0-0x17eff=
fff]
[    0.035611] ACPI: Reserving APIC table memory at [mem 0x17effb7f-0x17eff=
bd8]
[    0.035629] ACPI: Reserving BOOT table memory at [mem 0x17effbd9-0x17eff=
bff]
[    0.035743] 382MB LOWMEM available.
[    0.035759]   mapped low ram: 0 - 17ef0000
[    0.035772]   low ram: 0 - 17ef0000
[    0.035800] cma: Reserved 16 MiB at 0x0000000016400000
[    0.035830] Zone ranges:
[    0.035840]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.035861]   Normal   [mem 0x0000000001000000-0x0000000017eeffff]
[    0.035883] Movable zone start for each node
[    0.035893] Early memory node ranges
[    0.035902]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.035919]   node   0: [mem 0x0000000000100000-0x0000000017eeffff]
[    0.035939] Initmem setup node 0 [mem 0x0000000000001000-0x0000000017eef=
fff]
[    0.072818] Using APIC driver default
[    0.073119] ACPI: PM-Timer IO Port: 0x1008
[    0.073184] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.073237] IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-=
23
[    0.073269] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
[    0.073293] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.073328] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.073354] smpboot: Allowing 1 CPUs, 0 hotplug CPUs
[    0.073473] PM: hibernation: Registered nosave memory: [mem 0x00000000-0=
x00000fff]
[    0.073500] PM: hibernation: Registered nosave memory: [mem 0x0009f000-0=
x0009ffff]
[    0.073515] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0=
x000dffff]
[    0.073530] PM: hibernation: Registered nosave memory: [mem 0x000e0000-0=
x000fffff]
[    0.073554] [mem 0x18000000-0xffefffff] available for PCI devices
[    0.073585] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0=
xffffffff, max_idle_ns: 1910969940391419 ns
[    0.073659] setup_percpu: NR_CPUS:32 nr_cpumask_bits:32 nr_cpu_ids:1 nr_=
node_ids:1
[    0.075411] percpu: Embedded 36 pages/cpu s116300 r0 d31156 u147456
[    0.075667] Built 1 zonelists, mobility grouping on.  Total pages: 97168
[    0.075705] Kernel command line: auto BOOT_IMAGE=3D5.14.9-test ro panic=
=3D30 consoleblank=3D0 gpt vt.default_utf8=3D1 console=3DttyS0,9600n8
[    0.076804] Unknown command line parameters: auto BOOT_IMAGE=3D5.14.9-te=
st
[    0.078112] Dentry cache hash table entries: 65536 (order: 6, 262144 byt=
es, linear)
[    0.078930] Inode-cache hash table entries: 32768 (order: 5, 131072 byte=
s, linear)
[    0.079152] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.101941] Checking if this processor honours the WP bit even in superv=
isor mode...Ok.
[    0.102041] Memory: 344184K/391736K available (9197K kernel code, 1670K =
rwdata, 3592K rodata, 992K init, 624K bss, 31168K reserv)
[    0.102500] SLUB: HWalign=3D32, Order=3D0-3, MinObjects=3D0, CPUs=3D1, N=
odes=3D1
[    0.102597] Kernel/User page tables isolation: enabled
[    0.102679] ftrace: allocating 39072 entries in 77 pages
[    0.196722] ftrace: allocated 77 pages with 4 groups
[    0.197685] trace event string verifier disabled
[    0.198213] rcu: Hierarchical RCU implementation.
[    0.198251] rcu:     RCU restricting CPUs from NR_CPUS=3D32 to nr_cpu_id=
s=3D1.
[    0.198270]  Trampoline variant of Tasks RCU enabled.
[    0.198280]  Rude variant of Tasks RCU enabled.
[    0.198289]  Tracing variant of Tasks RCU enabled.
[    0.198300] rcu: RCU calculated value of scheduler-enlistment delay is 1=
00 jiffies.
[    0.198312] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=
=3D1
[    0.205150] NR_IRQS: 2304, nr_irqs: 256, preallocated irqs: 16
[    0.208911] Console: colour VGA+ 80x25
[    0.215633] printk: console [tty0] enabled
[    6.701438] printk: console [ttyS0] enabled
[    6.751602] ACPI: Core revision 20210604
[    6.799164] APIC: Switch to symmetric I/O mode setup
[    6.858680] Enabling APIC mode:  Flat.  Using 1 I/O APICs
[    6.924022] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D=
-1
[    7.000057] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles:=
 0x7a9cac8195, max_idle_ns: 440795211740 ns
[    7.125065] Calibrating delay loop (skipped), value calculated using tim=
er frequency.. 1063.27 BogoMIPS (lpj=3D531638)
[    7.126072] pid_max: default: 32768 minimum: 301
[    7.127252] LSM: Security Framework initializing
[    7.128179] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes, =
linear)
[    7.129089] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 by=
tes, linear)
[    7.132877] Last level iTLB entries: 4KB 32, 2MB 0, 4MB 2
[    7.133096] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 8, 1GB 0
[    7.134073] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user=
 pointer sanitization
[    7.135076] Spectre V2 : Spectre mitigation: kernel not compiled with re=
tpoline; no mitigation available!
[    7.135086] Speculative Store Bypass: Vulnerable
[    7.137074] MDS: Vulnerable: Clear CPU buffers attempted, no microcode
[    7.175393] Freeing SMP alternatives memory: 32K
[    7.280217] smpboot: CPU0: Intel Celeron (Mendocino) (family: 0x6, model=
: 0x6, stepping: 0x5)
[    7.283538] Performance Events: p6 PMU driver.
[    7.284085] ... version:                0
[    7.285073] ... bit width:              32
[    7.287071] ... generic registers:      2
[    7.288071] ... value mask:             00000000ffffffff
[    7.289071] ... max period:             000000007fffffff
[    7.290072] ... fixed-purpose events:   0
[    7.291070] ... event mask:             0000000000000003
[    7.292874] rcu: Hierarchical SRCU implementation.
[    7.294633] smp: Bringing up secondary CPUs ...
[    7.296080] smp: Brought up 1 node, 1 CPU
[    7.297080] smpboot: Max logical packages: 1
[    7.298070] smpboot: Total of 1 processors activated (1063.27 BogoMIPS)
[    7.301235] devtmpfs: initialized
[    7.304441] random: get_random_u32 called from bucket_table_alloc.isra.0=
+0x5d/0x130 with crng_init=3D0
[    7.307276] ACPI: PM: Registering ACPI NVS region [mem 0x17effc00-0x17ef=
ffff] (1024 bytes)
[    7.308511] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffffff=
f, max_idle_ns: 1911260446275000 ns
[    7.309102] futex hash table entries: 256 (order: 2, 16384 bytes, linear=
)
[    7.312360] prandom: seed boundary self test passed
[    7.319019] prandom: 100 self tests passed
[    7.362651] prandom32: self test passed (less than 6 bits correlated)
[    7.363072] pinctrl core: initialized pinctrl subsystem
[    7.366623] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    7.368910] audit: initializing netlink subsys (disabled)
[    7.371522] thermal_sys: Registered thermal governor 'fair_share'
[    7.371549] thermal_sys: Registered thermal governor 'bang_bang'
[    7.372092] thermal_sys: Registered thermal governor 'step_wise'
[    7.373075] thermal_sys: Registered thermal governor 'user_space'
[    7.374121] cpuidle: using governor ladder
[    7.376074] cpuidle: using governor menu
[    7.378456] Simple Boot Flag at 0x35 set to 0x1
[    7.380091] ACPI: bus type PCI registered
[    7.381080] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    7.384653] PCI: PCI BIOS revision 2.10 entry at 0xfd9c0, last bus=3D1
[    7.385083] PCI: Using configuration type 1 for base access
[    7.399303] audit: type=3D2000 audit(1633485980.253:1): state=3Dinitiali=
zed audit_enabled=3D0 res=3D1
[    7.420478] ACPI: Added _OSI(Module Device)
[    7.421095] ACPI: Added _OSI(Processor Device)
[    7.422084] ACPI: Added _OSI(3.0 _SCP Extensions)
[    7.423083] ACPI: Added _OSI(Processor Aggregator Device)
[    7.425075] ACPI: Added _OSI(Linux-Dell-Video)
[    7.426076] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    7.427075] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    7.454049] ACPI: 1 ACPI AML tables successfully acquired and loaded
[    7.461483] ACPI: Interpreter enabled
[    7.462227] ACPI: PM: (supports S0 S1 S4 S5)
[    7.463078] ACPI: Using IOAPIC for interrupt routing
[    7.464343] PCI: Using host bridge windows from ACPI; if necessary, use =
"pci=3Dnocrs" and report a bug
[    7.467030] ACPI: Enabled 2 GPEs in block 00 to 0F
[    7.467062] ACPI: Enabled 2 GPEs in block 10 to 1F
[    7.636640] acpi LNXCPU:00: Invalid PBLK length [5]
[    7.638670] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    7.639113] acpi PNP0A03:00: _OSC: OS supports [ASPM ClockPM Segments MS=
I HPX-Type3]
[    7.640115] acpi PNP0A03:00: fail to add MMCONFIG information, can't acc=
ess extended PCI configuration space under this bridge.
[    7.643593] PCI host bridge to bus 0000:00
[    7.644098] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window=
]
[    7.645077] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bfff=
f window]
[    7.646076] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000cfff=
f window]
[    7.647076] pci_bus 0000:00: root bus resource [mem 0x000d0000-0x000dfff=
f window]
[    7.648076] pci_bus 0000:00: root bus resource [mem 0x18000000-0xfebffff=
f window]
[    7.649076] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window=
]
[    7.650080] pci_bus 0000:00: root bus resource [bus 00-ff]
[    7.651158] pci 0000:00:00.0: [8086:7124] type 00 class 0x060000
[    7.652622] pci 0000:00:01.0: [8086:7125] type 00 class 0x030000
[    7.653118] pci 0000:00:01.0: reg 0x10: [mem 0xf8000000-0xfbffffff pref]
[    7.654087] pci 0000:00:01.0: reg 0x14: [mem 0xf4000000-0xf407ffff]
[    7.655656] pci 0000:00:1e.0: [8086:2418] type 01 class 0x060400
[    7.657701] pci 0000:00:1f.0: [8086:2410] type 00 class 0x060100
[    7.658254] pci 0000:00:1f.0: quirk: [io  0x1000-0x107f] claimed by ICH4=
 ACPI/GPIO/TCO
[    7.659086] pci 0000:00:1f.0: quirk: [io  0x1180-0x11bf] claimed by ICH4=
 GPIO
[    7.661147] pci 0000:00:1f.1: [8086:2411] type 00 class 0x010180
[    7.662159] pci 0000:00:1f.1: reg 0x20: [io  0x1800-0x180f]
[    7.664082] pci 0000:00:1f.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x=
01f7]
[    7.665072] pci 0000:00:1f.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    7.666074] pci 0000:00:1f.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x=
0177]
[    7.667074] pci 0000:00:1f.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    7.669267] pci 0000:00:1f.2: [8086:2412] type 00 class 0x0c0300
[    7.670164] pci 0000:00:1f.2: reg 0x20: [io  0x1820-0x183f]
[    7.671857] pci 0000:00:1f.5: [8086:2415] type 00 class 0x040100
[    7.672124] pci 0000:00:1f.5: reg 0x10: [io  0x2000-0x20ff]
[    7.673090] pci 0000:00:1f.5: reg 0x14: [io  0x1840-0x187f]
[    7.675400] pci_bus 0000:01: extended config space not accessible
[    7.676298] pci 0000:01:0b.0: [1397:2bd0] type 00 class 0x028000
[    7.677115] pci 0000:01:0b.0: reg 0x10: [io  0x3000-0x3007]
[    7.678085] pci 0000:01:0b.0: reg 0x14: [mem 0xf4100000-0xf41000ff]
[    7.679245] pci 0000:01:0b.0: supports D1 D2
[    7.680081] pci 0000:01:0b.0: PME# supported from D0 D1 D2 D3hot
[    7.682417] pci 0000:01:0d.0: [10b7:9200] type 00 class 0x020000
[    7.683121] pci 0000:01:0d.0: reg 0x10: [io  0x3080-0x30ff]
[    7.684089] pci 0000:01:0d.0: reg 0x14: [mem 0xf4100400-0xf410047f]
[    7.685136] pci 0000:01:0d.0: reg 0x30: [mem 0x00000000-0x0001ffff pref]
[    7.686194] pci 0000:01:0d.0: supports D1 D2
[    7.687076] pci 0000:01:0d.0: PME# supported from D0 D1 D2 D3hot D3cold
[    7.688416] pci 0000:01:0e.0: [1033:0035] type 00 class 0x0c0310
[    7.689119] pci 0000:01:0e.0: reg 0x10: [mem 0xf4101000-0xf4101fff]
[    7.690252] pci 0000:01:0e.0: supports D1 D2
[    7.691078] pci 0000:01:0e.0: PME# supported from D0 D1 D2 D3hot
[    7.692393] pci 0000:01:0e.1: [1033:0035] type 00 class 0x0c0310
[    7.693116] pci 0000:01:0e.1: reg 0x10: [mem 0xf4102000-0xf4102fff]
[    7.694249] pci 0000:01:0e.1: supports D1 D2
[    7.695079] pci 0000:01:0e.1: PME# supported from D0 D1 D2 D3hot
[    7.697244] pci 0000:01:0e.2: [1033:00e0] type 00 class 0x0c0320
[    7.698112] pci 0000:01:0e.2: reg 0x10: [mem 0xf4100800-0xf41008ff]
[    7.699242] pci 0000:01:0e.2: supports D1 D2
[    7.700079] pci 0000:01:0e.2: PME# supported from D0 D1 D2 D3hot
[    7.702149] pci 0000:00:1e.0: PCI bridge to [bus 01] (subtractive decode=
)
[    7.703083] pci 0000:00:1e.0:   bridge window [io  0x3000-0x3fff]
[    7.704079] pci 0000:00:1e.0:   bridge window [mem 0xf4100000-0xf41fffff=
]
[    7.705082] pci 0000:00:1e.0:   bridge window [io  0x0000-0x0cf7 window]=
 (subtractive decode)
[    7.707072] pci 0000:00:1e.0:   bridge window [mem 0x000a0000-0x000bffff=
 window] (subtractive decode)
[    7.708074] pci 0000:00:1e.0:   bridge window [mem 0x000c0000-0x000cffff=
 window] (subtractive decode)
[    7.709075] pci 0000:00:1e.0:   bridge window [mem 0x000d0000-0x000dffff=
 window] (subtractive decode)
[    7.710076] pci 0000:00:1e.0:   bridge window [mem 0x18000000-0xfebfffff=
 window] (subtractive decode)
[    7.711076] pci 0000:00:1e.0:   bridge window [io  0x0d00-0xffff window]=
 (subtractive decode)
[    7.714593] ACPI: PCI: Interrupt link LNKA configured for IRQ 11
[    7.716203] ACPI: PCI: Interrupt link LNKB configured for IRQ 10
[    7.717512] ACPI: PCI: Interrupt link LNKC configured for IRQ 5
[    7.719090] ACPI: PCI: Interrupt link LNKD configured for IRQ 9
[    7.724259] iommu: Default domain type: Translated
[    7.726342] pci 0000:00:01.0: vgaarb: setting as boot VGA device
[    7.727062] pci 0000:00:01.0: vgaarb: VGA device added: decodes=3Dio+mem=
,owns=3Dio+mem,locks=3Dnone
[    7.727121] pci 0000:00:01.0: vgaarb: bridge control possible
[    7.728078] vgaarb: loaded
[    7.731153] SCSI subsystem initialized
[    7.732681] ACPI: bus type USB registered
[    7.734121] usbcore: registered new interface driver usbfs
[    7.735154] usbcore: registered new interface driver hub
[    7.736156] usbcore: registered new device driver usb
[    7.737354] pps_core: LinuxPPS API ver. 1 registered
[    7.739070] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo =
Giometti <giometti@linux.it>
[    7.740108] PTP clock support registered
[    7.741243] EDAC MC: Ver: 3.0.0
[    7.745588] NetLabel: Initializing
[    7.746082] NetLabel:  domain hash size =3D 128
[    7.747071] NetLabel:  protocols =3D UNLABELED CIPSOv4 CALIPSO
[    7.748196] NetLabel:  unlabeled traffic allowed by default
[    7.749077] PCI: Using ACPI for IRQ routing
[    7.751968] clocksource: Switched to clocksource tsc-early
[    7.863543] VFS: Disk quotas dquot_6.6.0
[    7.910771] VFS: Dquot-cache hash table entries: 1024 (order 0, 4096 byt=
es)
[    7.994538] pnp: PnP ACPI init
[    8.032470] system 00:00: [io  0x1000-0x107f] has been reserved
[    8.103480] system 00:00: [io  0x1180-0x11bf] has been reserved
[    8.174473] system 00:00: [io  0x04d0-0x04d1] has been reserved
[    8.245378] system 00:00: [io  0x0290-0x0297] has been reserved
[    8.316305] system 00:00: [io  0x0400-0x0404] has been reserved
[    8.387204] system 00:00: [io  0xfe00-0xfe0f] has been reserved
[    8.458117] system 00:00: [mem 0xfec00000-0xfec00fff] could not be reser=
ved
[    8.541616] system 00:00: [mem 0xfee00000-0xfee00fff] has been reserved
[    8.620838] system 00:00: [mem 0xff800000-0xffffffff] could not be reser=
ved
[    8.771524] pnp: PnP ACPI: found 9 devices
[    8.900816] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, m=
ax_idle_ns: 2085701024 ns
[    9.007739] NET: Registered PF_INET protocol family
[    9.066627] IP idents hash table entries: 8192 (order: 4, 65536 bytes, l=
inear)
[    9.154618] tcp_listen_portaddr_hash hash table entries: 512 (order: 0, =
6144 bytes, linear)
[    9.254907] TCP established hash table entries: 4096 (order: 2, 16384 by=
tes, linear)
[    9.347834] TCP bind hash table entries: 4096 (order: 3, 32768 bytes, li=
near)
[    9.433462] TCP: Hash tables configured (established 4096 bind 4096)
[    9.510214] MPTCP token hash table entries: 512 (order: 1, 8192 bytes, l=
inear)
[    9.596990] UDP hash table entries: 256 (order: 1, 8192 bytes, linear)
[    9.675323] UDP-Lite hash table entries: 256 (order: 1, 8192 bytes, line=
ar)
[    9.759219] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    9.827144] NET: Registered PF_XDP protocol family
[    9.884697] pci 0000:00:1e.0: BAR 15: assigned [mem 0x18000000-0x180ffff=
f pref]
[    9.972364] pci 0000:01:0d.0: BAR 6: assigned [mem 0x18000000-0x1801ffff=
 pref]
[   10.058949] pci 0000:00:1e.0: PCI bridge to [bus 01]
[   10.118423] pci 0000:00:1e.0:   bridge window [io  0x3000-0x3fff]
[   10.191411] pci 0000:00:1e.0:   bridge window [mem 0xf4100000-0xf41fffff=
]
[   10.272717] pci 0000:00:1e.0:   bridge window [mem 0x18000000-0x180fffff=
 pref]
[   10.359344] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[   10.433462] pci_bus 0000:00: resource 5 [mem 0x000a0000-0x000bffff windo=
w]
[   10.515814] pci_bus 0000:00: resource 6 [mem 0x000c0000-0x000cffff windo=
w]
[   10.598161] pci_bus 0000:00: resource 7 [mem 0x000d0000-0x000dffff windo=
w]
[   10.680509] pci_bus 0000:00: resource 8 [mem 0x18000000-0xfebfffff windo=
w]
[   10.762859] pci_bus 0000:00: resource 9 [io  0x0d00-0xffff window]
[   10.836900] pci_bus 0000:01: resource 0 [io  0x3000-0x3fff]
[   10.903645] pci_bus 0000:01: resource 1 [mem 0xf4100000-0xf41fffff]
[   10.978715] pci_bus 0000:01: resource 2 [mem 0x18000000-0x180fffff pref]
[   11.058986] pci_bus 0000:01: resource 4 [io  0x0000-0x0cf7 window]
[   11.133018] pci_bus 0000:01: resource 5 [mem 0x000a0000-0x000bffff windo=
w]
[   11.215368] pci_bus 0000:01: resource 6 [mem 0x000c0000-0x000cffff windo=
w]
[   11.297718] pci_bus 0000:01: resource 7 [mem 0x000d0000-0x000dffff windo=
w]
[   11.380064] pci_bus 0000:01: resource 8 [mem 0x18000000-0xfebfffff windo=
w]
[   11.462418] pci_bus 0000:01: resource 9 [io  0x0d00-0xffff window]
[   11.536787] pci 0000:00:01.0: Video device with shadowed ROM at [mem 0x0=
00c0000-0x000dffff]
[   11.636906] pci 0000:00:01.0: pci_fixup_video+0x0/0xb0 took 97783 usecs
[   11.717437] pci 0000:01:0e.0: enabling device (0114 -> 0116)
[   11.787609] pci 0000:01:0e.0: quirk_usb_early_handoff+0x0/0x6e0 took 685=
56 usecs
[   11.876449] pci 0000:01:0e.1: enabling device (0114 -> 0116)
[   11.945745] pci 0000:01:0e.1: quirk_usb_early_handoff+0x0/0x6e0 took 676=
79 usecs
[   12.034655] pci 0000:01:0e.2: enabling device (0114 -> 0116)
[   12.104115] pci 0000:01:0e.2: quirk_usb_early_handoff+0x0/0x6e0 took 678=
39 usecs
[   12.192889] PCI: CLS 32 bytes, default 32
[   12.243237] Trying to unpack rootfs image as initramfs...
[   12.396162] Initialise system trusted keyrings
[   12.508278] workingset: timestamp_bits=3D30 max_order=3D17 bucket_order=
=3D0
[   12.594511] zbud: loaded
[   12.625642] romfs: ROMFS MTD (C) 2007 Red Hat, Inc.
[   13.132303] tsc: Refined TSC clocksource calibration: 531.608 MHz
[   13.205430] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x7a9=
ae70401, max_idle_ns: 440795209195 ns
[   13.353585] Key type asymmetric registered
[   13.402856] Asymmetric key parser 'x509' registered
[   13.461509] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 242)
[   13.731384] clocksource: Switched to clocksource tsc
[   13.822338] atomic64_test: passed for i586+ platform with CX8 and withou=
t SSE
[   13.913610] gbefb: couldn't reserve mmio region
[   13.968050] gbefb: probe of gbefb.0 failed with error -16
[   14.034343] isapnp: Scanning for PnP cards...
[   14.443908] isapnp: No Plug & Play device found
[   15.335655] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[   15.431926] 00:04: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D 115200) =
is a 16550A
[   15.737710] Floppy drive(s): fd0 is 1.44M
[   15.871483] brd: module loaded
[   15.934306] FDC 0 is a post-1991 82077
[   15.997939] st: Version 20160209, fixed bufsize 32768, s/g segs 256
[   16.206894] Freeing initrd memory: 10616K
[   16.449180] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[   16.527685] ehci-pci: EHCI PCI platform driver
[   16.582177] ehci-pci 0000:01:0e.2: EHCI Host Controller
[   16.654763] ehci-pci 0000:01:0e.2: new USB bus registered, assigned bus =
number 1
[   16.743836] ehci-pci 0000:01:0e.2: irq 18, io mem 0xf4100800
[   16.818137] ehci-pci 0000:01:0e.2: USB 2.0 started, EHCI 1.00
[   16.887516] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 5.14
[   16.986575] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[   17.073168] usb usb1: Product: EHCI Host Controller
[   17.131608] usb usb1: Manufacturer: Linux 5.14.9 ehci_hcd
[   17.196316] usb usb1: SerialNumber: 0000:01:0e.2
[   17.253221] hub 1-0:1.0: USB hub found
[   17.299937] hub 1-0:1.0: 5 ports detected
[   17.350043] ehci-platform: EHCI generic platform driver
[   17.413364] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[   17.487524] ohci-platform: OHCI generic platform driver
[   17.550293] uhci_hcd: USB Universal Host Controller Interface driver
[   17.627329] uhci_hcd 0000:00:1f.2: UHCI Host Controller
[   17.699776] uhci_hcd 0000:00:1f.2: new USB bus registered, assigned bus =
number 2
[   17.788743] uhci_hcd 0000:00:1f.2: irq 19, io base 0x00001820
[   17.859471] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001, bcdDevice=3D 5.14
[   17.958667] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[   18.045210] usb usb2: Product: UHCI Host Controller
[   18.103638] usb usb2: Manufacturer: Linux 5.14.9 uhci_hcd
[   18.168335] usb usb2: SerialNumber: 0000:00:1f.2
[   18.224957] hub 2-0:1.0: USB hub found
[   18.271783] hub 2-0:1.0: 2 ports detected
[   18.322231] usbcore: registered new interface driver usb-storage
[   18.394416] usbcore: registered new interface driver ums-alauda
[   18.465498] usbcore: registered new interface driver ums-cypress
[   18.537550] usbcore: registered new interface driver ums-datafab
[   18.609633] usbcore: registered new interface driver ums-freecom
[   18.681830] usbcore: registered new interface driver ums-isd200
[   18.752903] usbcore: registered new interface driver ums-jumpshot
[   18.826004] usbcore: registered new interface driver ums-karma
[   18.896054] usbcore: registered new interface driver ums-onetouch
[   18.969190] usbcore: registered new interface driver ums-sddr09
[   19.040203] usbcore: registered new interface driver ums-sddr55
[   19.111262] usbcore: registered new interface driver ums-usbat
[   19.181849] i8042: PNP: PS/2 Controller [PNP0303:KBC0,PNP0f13:MSE0] at 0=
x60,0x64 irq 1,12
[   19.306966] serio: i8042 KBD port at 0x60,0x64 irq 1
[   19.366606] serio: i8042 AUX port at 0x60,0x64 irq 12
[   19.433701] mousedev: PS/2 mouse device common for all mice
[   19.500966] rtc_cmos 00:01: RTC can wake from S4
[   19.562645] rtc_cmos 00:01: registered as rtc0
[   19.616158] rtc_cmos 00:01: setting system clock to 2021-10-06T02:06:50 =
UTC (1633486010)
[   19.713395] rtc_cmos 00:01: alarms up to one month, y3k, 114 bytes nvram
[   19.795257] device-mapper: uevent: version 1.0.3
[   19.866845] device-mapper: ioctl: 4.45.0-ioctl (2021-03-22) initialised:=
 dm-devel@redhat.com
[   19.968219] intel_pstate: CPU model not supported
[   20.027881] ledtrig-cpu: registered to indicate activity on CPUs
[   20.102754] Initializing XFRM netlink socket
[   20.154876] NET: Registered PF_INET6 protocol family
[   20.219427] input: AT Translated Set 2 keyboard as /devices/platform/i80=
42/serio0/input/input0
[   20.339902] Segment Routing with IPv6
[   20.383980] RPL Segment Routing with IPv6
[   20.432214] NET: Registered PF_PACKET protocol family
[   20.493376] Key type dns_resolver registered
[   20.548825] microcode: sig=3D0x665, pf=3D0x10, revision=3D0x3
[   20.613960] microcode: Microcode Update Driver: v2.2.
[   20.614002] IPI shorthand broadcast: enabled
[   20.726024] sched_clock: Marking stable (13815698178, 6910160635)->(3125=
9594849, -10533736036)
[   20.830876] registered taskstats version 1
[   20.880182] Loading compiled-in X.509 certificates
[   20.937853] zswap: loaded using pool lzo/zbud
[   20.992298] Key type ._fscrypt registered
[   21.040453] Key type .fscrypt registered
[   21.087525] Key type fscrypt-provisioning registered
[   21.192325] Key type encrypted registered
[   21.258189] Freeing unused kernel image (initmem) memory: 992K
[   21.329692] Write protecting kernel text and read-only data: 12792k
[   21.405027] rodata_test: all tests were successful
[   21.462575] Run /init as init process
[   21.615488] ------------[ cut here ]------------
[   21.670972] fpu->state.fxsave.mxcsr: 0xb7be13b4, mxcsr_feature_mask: 0xf=
fbf
[   21.754383] WARNING: CPU: 0 PID: 1 at arch/x86/kernel/fpu/signal.c:384 _=
_fpu_restore_sig+0x51f/0x540
[   21.863860] Modules linked in:
[   21.900489] CPU: 0 PID: 1 Comm: init Not tainted 5.14.9 #1
[   21.966283] Hardware name: Hewlett-Packard HP PC/HP Board, BIOS  JD.00.0=
6 12/06/2001
[   22.059135] EIP: __fpu_restore_sig+0x51f/0x540
[   22.112375] Code: c0 0f 84 17 fe ff ff 0f 0b e9 10 fe ff ff 80 3d b0 ef =
e0 c1 00 75 18 c6 05 b0 ef e0 c1 01 52 50 68 68 6a b5 c16
[   22.337305] EAX: 0000003f EBX: 00000000 ECX: 00000000 EDX: 00000000
[   22.412364] ESI: c20f0000 EDI: c20f0800 EBP: c20e1f08 ESP: c20e1e70
[   22.487436] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 0001029=
2
[   22.568751] CR0: 80050033 CR2: bf932db0 CR3: 03614000 CR4: 000002f0
[   22.643839] Call Trace:
[   22.673170]  fpu__restore_sig+0x48/0xa0
[   22.719225]  restore_sigcontext.constprop.0+0xc6/0xe0
[   22.779744]  __do_sys_sigreturn+0x60/0x90
[   22.827778]  do_int80_syscall_32+0x32/0x90
[   22.876963]  entry_INT80_32+0x10d/0x10d
[   22.922922] EIP: 0xb7c9fbe6
[   22.956402] Code: 8d 74 24 20 85 c0 0f 85 f8 01 00 00 c6 44 24 10 01 8d =
6c 24 68 8b 8c 24 e4 00 00 00 b8 72 00 00 00 8b 94 24 e80
[   23.181331] EAX: 00000227 EBX: ffffffff ECX: bf93344c EDX: 00000000
[   23.256391] ESI: 00000000 EDI: 00000000 EBP: 00000000 ESP: bf933310
[   23.331465] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 0000024=
6
[   23.412785] ---[ end trace 906a5cf3c33b02c7 ]---
[   23.468106] init[1] bad frame in sigreturn frame:(ptrval) ip:b7c9fbe6 sp=
:bf933310 orax:ffffffff in libc-2.33.so[b7bed000+156000]
[   23.606909] Kernel panic - not syncing: Attempted to kill init! exitcode=
=3D0x0000000b
[   23.698718] CPU: 0 PID: 1 Comm: init Tainted: G        W         5.14.9 =
#1
[   23.781069] Hardware name: Hewlett-Packard HP PC/HP Board, BIOS  JD.00.0=
6 12/06/2001
[   23.873821] Call Trace:
[   23.903150]  dump_stack_lvl+0x34/0x44
[   23.947026]  dump_stack+0xd/0x10
[   23.985707]  panic+0xa3/0x22b
[   24.021269]  do_exit.cold+0x3e/0x94
[   24.063072]  do_group_exit+0x2f/0x90
[   24.105911]  get_signal+0x13b/0x790
[   24.147714]  arch_do_signal_or_restart+0x90/0x550
[   24.204071]  ? force_sig_info_to_task+0x69/0x100
[   24.259389]  ? force_sig+0x34/0x40
[   24.300153]  exit_to_user_mode_prepare+0x155/0x1f0
[   24.357550]  syscall_exit_to_user_mode+0x1b/0x40
[   24.412868]  do_int80_syscall_32+0x3c/0x90
[   24.461949]  entry_INT80_32+0x10d/0x10d
[   24.507908] EIP: 0xb7c9fbe6
[   24.541390] Code: 8d 74 24 20 85 c0 0f 85 f8 01 00 00 c6 44 24 10 01 8d =
6c 24 68 8b 8c 24 e4 00 00 00 b8 72 00 00 00 8b 94 24 e80
[   24.766303] EAX: 00000000 EBX: ffffffff ECX: bf93344c EDX: 00000000
[   24.841379] ESI: 00000000 EDI: 00000000 EBP: 00000000 ESP: bf933310
[   24.916453] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 0000024=
6
[   24.997790] Kernel Offset: disabled

