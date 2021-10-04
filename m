Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE31D421637
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 20:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232577AbhJDSTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 14:19:38 -0400
Received: from mail-4325.protonmail.ch ([185.70.43.25]:52625 "EHLO
        mail-4325.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236855AbhJDSTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 14:19:36 -0400
Date:   Mon, 04 Oct 2021 18:17:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1633371463;
        bh=GmllCnyT5B7ysLUtdmPkqR1uFUT4ai/Wugm384p3nSQ=;
        h=Date:To:From:Reply-To:Subject:In-Reply-To:References:From;
        b=bbNps/9DDt4Pi2cLqJ+mlIAyTIBUdutyD/68q16mxlyRmnZiE7BO6qgkLXQSm+K2d
         y0aZyqQLT8HnrOcjDLEGvTK0prEgK3bUVq5RGewXt4u2q5O2C8Zu7O2Fwsfh0N9wcO
         yEWEpkT1au9C1IgG1MAfkceFIUt0Ws/cPPdj80PM=
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Ser Olmy <ser.olmy@protonmail.com>
Reply-To: Ser Olmy <ser.olmy@protonmail.com>
Subject: Re: [x86] Kernel v5.14 series panic on Celeron Mendocino CPU
Message-ID: <lxqAtqDf_kLUxIlvmYPvuKB36LOK-z_cVbS9OOl0MbjZKZEaCaEFmHCbSy5sWBer6f9V_WAPLxUuSNrDBvyzEeQOJXepkVUztPXAOhPZniQ=@protonmail.com>
In-Reply-To: <YVtA67jImg3KlBTw@zn.tnic>
References: <CPeoI7yf4421QpWLM-CbgeDR17BBmhlLoixeYI3mu2WbDkgrZItfgImOO6BZez7CXQXXO9liq-rmZzgRVB95TP5MN0xUA8-d7-fSQZdyIZE=@protonmail.com> <YVtA67jImg3KlBTw@zn.tnic>
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

On Monday, October 4th, 2021 at 7:59 PM, Borislav Petkov <bp@alien8.de> wro=
te:
>
> I'm assuming your CPU cannot do 64-bit mode?

Correct, it's an old Socket 370 Celeron

> Can you send .config, /proc/cpuinfo and full dmesg pls?

I'm running a stock Slackware-current kernel. The .config is available here=
: https://mirrors.dotsrc.org/slackware/slackware-current/kernels/hugesmp.s/=
config

cpuinfo:

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 6
model name      : Celeron (Mendocino)
stepping        : 5
microcode       : 0x3
cpu MHz         : 531.632
cache size      : 128 KB
physical id     : 0
siblings        : 1
core id         : 0
cpu cores       : 1
apicid          : 0
initial apicid  : 0
fdiv_bug        : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca =
cmov pse36 mmx fxsr cpuid pti
bugs            : cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass l1tf=
 mds swapgs itlb_multihit
bogomips        : 1063.26
clflush size    : 32
cache_alignment : 32
address sizes   : 36 bits physical, 32 bits virtual
power management:


dmesg:

[    0.000000] Linux version 5.14.9-smp (root@z-mp32.slackware.lan) (gcc (G=
CC) 11.2.0, GNU ld version 2.37-slack15) #1 SMP Thu Sep 1
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
[    0.000000] tsc: Detected 531.615 MHz processor
[    0.004370] last_pfn =3D 0x17ef0 max_arch_pfn =3D 0x1000000
[    0.004645] x86/PAT: PAT not supported by the CPU.
[    0.006326] x86/PAT: Configuration [0-7]: WB  WT  UC- UC  WB  WT  UC- UC
[    0.034440] RAMDISK: [mem 0x174c1000-0x17eeffff]
[    0.034490] ACPI: Early table checksum verification disabled
[    0.034531] ACPI: RSDP 0x00000000000F6510 000014 (v00 PTLTD )
[    0.034574] ACPI: RSDT 0x0000000017EF9B1D 000030 (v01 HP     HPBDD_JD 00=
001000  LTP 00000000)
[    0.034626] ACPI: FACP 0x0000000017EFFB0B 000074 (v01 HP     HPBDD_JD 00=
001000 PTL  00001002)
[    0.034683] ACPI: DSDT 0x0000000017EF9B4D 005FBE (v01 HP     HPBDD_IZ 00=
001000 MSFT 0100000B)
[    0.034726] ACPI: FACS 0x0000000017EFFFC0 000040
[    0.034761] ACPI: APIC 0x0000000017EFFB7F 00005A (v01 HP     HPBDD_JD 00=
001000  LTP 00000000)
[    0.034804] ACPI: BOOT 0x0000000017EFFBD9 000027 (v01 PTLTD  $SBFTBL$ 00=
001000  LTP 00000001)
[    0.034840] ACPI: Reserving FACP table memory at [mem 0x17effb0b-0x17eff=
b7e]
[    0.034860] ACPI: Reserving DSDT table memory at [mem 0x17ef9b4d-0x17eff=
b0a]
[    0.034877] ACPI: Reserving FACS table memory at [mem 0x17efffc0-0x17eff=
fff]
[    0.034893] ACPI: Reserving APIC table memory at [mem 0x17effb7f-0x17eff=
bd8]
[    0.034910] ACPI: Reserving BOOT table memory at [mem 0x17effbd9-0x17eff=
bff]
[    0.035043] No NUMA configuration found
[    0.035057] Faking a node at [mem 0x0000000000000000-0x0000000017eeffff]
[    0.035092] NODE_DATA(0) allocated [mem 0x174bf000-0x174c0fff]
[    0.035138] 0MB HIGHMEM available.
[    0.035150] 382MB LOWMEM available.
[    0.035188]   mapped low ram: 0 - 17ef0000
[    0.035200]   low ram: 0 - 17ef0000
[    0.035280] Zone ranges:
[    0.035292]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.035315]   Normal   [mem 0x0000000001000000-0x0000000017eeffff]
[    0.035336]   HighMem  empty
[    0.035352] Movable zone start for each node
[    0.035362] Early memory node ranges
[    0.035372]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.035389]   node   0: [mem 0x0000000000100000-0x0000000017eeffff]
[    0.035407] Initmem setup node 0 [mem 0x0000000000001000-0x0000000017eef=
fff]
[    0.035470] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.036261] On node 0, zone DMA: 97 pages in unavailable ranges
[    0.066898] On node 0, zone Normal: 33040 pages in unavailable ranges
[    0.066942] Using APIC driver default
[    0.067215] ACPI: PM-Timer IO Port: 0x1008
[    0.067292] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.067353] IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-=
23
[    0.067388] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
[    0.067413] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.067450] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.067474] smpboot: Allowing 1 CPUs, 0 hotplug CPUs
[    0.067594] PM: hibernation: Registered nosave memory: [mem 0x00000000-0=
x00000fff]
[    0.067623] PM: hibernation: Registered nosave memory: [mem 0x0009f000-0=
x0009ffff]
[    0.067639] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0=
x000dffff]
[    0.067652] PM: hibernation: Registered nosave memory: [mem 0x000e0000-0=
x000fffff]
[    0.067678] [mem 0x18000000-0xffefffff] available for PCI devices
[    0.067693] Booting paravirtualized kernel on bare hardware
[    0.067718] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0=
xffffffff, max_idle_ns: 1910969940391419 ns
[    0.067790] setup_percpu: NR_CPUS:32 nr_cpumask_bits:32 nr_cpu_ids:1 nr_=
node_ids:1
[    0.069439] percpu: Embedded 34 pages/cpu s108556 r0 d30708 u139264
[    0.069731] Built 1 zonelists, mobility grouping on.  Total pages: 96976
[    0.069769] Policy zone: Normal
[    0.069784] Kernel command line: auto BOOT_IMAGE=3Dgeneric ro panic=3D30=
 consoleblank=3D0 gpt vt.default_utf8=3D1 console=3DttyS0,9600n8 ct
[    0.070970] Unknown command line parameters: auto BOOT_IMAGE=3Dgeneric
[    0.072302] Dentry cache hash table entries: 65536 (order: 6, 262144 byt=
es, linear)
[    0.073128] Inode-cache hash table entries: 32768 (order: 5, 131072 byte=
s, linear)
[    0.073377] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.073442] Initializing HighMem for node 0 (00000000:00000000)
[    0.102061] Checking if this processor honours the WP bit even in superv=
isor mode...Ok.
[    0.102160] Memory: 357560K/391736K available (9623K kernel code, 1876K =
rwdata, 3908K rodata, 924K init, 600K bss, 34176K reserv)
[    0.102205] random: get_random_u32 called from __kmem_cache_create+0x21/=
0x510 with crng_init=3D0
[    0.103810] SLUB: HWalign=3D32, Order=3D0-3, MinObjects=3D0, CPUs=3D1, N=
odes=3D1
[    0.103985] Kernel/User page tables isolation: enabled
[    0.104087] ftrace: allocating 40478 entries in 80 pages
[    0.274419] ftrace: allocated 80 pages with 2 groups
[    0.275463] trace event string verifier disabled
[    0.276089] rcu: Hierarchical RCU implementation.
[    0.276125] rcu:     RCU dyntick-idle grace-period acceleration is enabl=
ed.
[    0.276137] rcu:     RCU restricting CPUs from NR_CPUS=3D32 to nr_cpu_id=
s=3D1.
[    0.276155]  Rude variant of Tasks RCU enabled.
[    0.276164]  Tracing variant of Tasks RCU enabled.
[    0.276178] rcu: RCU calculated value of scheduler-enlistment delay is 1=
00 jiffies.
[    0.276191] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=
=3D1
[    0.285133] NR_IRQS: 2304, nr_irqs: 256, preallocated irqs: 16
[    0.285911] rcu:     Offload RCU callbacks from CPUs: (none).
[    0.288971] Console: colour VGA+ 80x25
[    0.296624] printk: console [tty0] enabled
[    7.513807] printk: console [ttyS0] enabled
[    7.564139] ACPI: Core revision 20210604
[    7.611810] APIC: Switch to symmetric I/O mode setup
[    7.671367] Enabling APIC mode:  Flat.  Using 1 I/O APICs
[    7.736728] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D=
-1
[    7.813687] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles:=
 0x7a9b50fc70, max_idle_ns: 440795215981 ns
[    7.938730] Calibrating delay loop (skipped), value calculated using tim=
er frequency.. 1063.23 BogoMIPS (lpj=3D531615)
[    7.939710] pid_max: default: 32768 minimum: 301
[    7.941012] LSM: Security Framework initializing
[    7.941885] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes, =
linear)
[    7.942735] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 by=
tes, linear)
[    7.947285] Last level iTLB entries: 4KB 32, 2MB 0, 4MB 2
[    7.947724] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 8, 1GB 0
[    7.948735] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user=
 pointer sanitization
[    7.949716] Spectre V2 : Mitigation: Full generic retpoline
[    7.950709] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB=
 on context switch
[    7.951710] Speculative Store Bypass: Vulnerable
[    7.952728] MDS: Vulnerable: Clear CPU buffers attempted, no microcode
[    8.004471] Freeing SMP alternatives memory: 40K
[    8.108411] smpboot: CPU0: Intel Celeron (Mendocino) (family: 0x6, model=
: 0x6, stepping: 0x5)
[    8.111448] Performance Events: p6 PMU driver.
[    8.111726] ... version:                0
[    8.112713] ... bit width:              32
[    8.113710] ... generic registers:      2
[    8.114710] ... value mask:             00000000ffffffff
[    8.115710] ... max period:             000000007fffffff
[    8.117710] ... fixed-purpose events:   0
[    8.118710] ... event mask:             0000000000000003
[    8.120810] rcu: Hierarchical SRCU implementation.
[    8.123395] smp: Bringing up secondary CPUs ...
[    8.123740] smp: Brought up 1 node, 1 CPU
[    8.124714] smpboot: Max logical packages: 1
[    8.125712] smpboot: Total of 1 processors activated (1063.23 BogoMIPS)
[    8.129260] devtmpfs: initialized
[    8.133280] ACPI: PM: Registering ACPI NVS region [mem 0x17effc00-0x17ef=
ffff] (1024 bytes)
[    8.134967] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffffff=
f, max_idle_ns: 1911260446275000 ns
[    8.135797] futex hash table entries: 256 (order: 2, 16384 bytes, linear=
)
[    8.137229] pinctrl core: initialized pinctrl subsystem
[    8.141549] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    8.144051] audit: initializing netlink subsys (disabled)
[    8.146606] thermal_sys: Registered thermal governor 'fair_share'
[    8.146639] thermal_sys: Registered thermal governor 'bang_bang'
[    8.146729] thermal_sys: Registered thermal governor 'step_wise'
[    8.147711] thermal_sys: Registered thermal governor 'user_space'
[    8.148755] audit: type=3D2000 audit(1633374988.215:1): state=3Dinitiali=
zed audit_enabled=3D0 res=3D1
[    8.150800] cpuidle: using governor ladder
[    8.151719] cpuidle: using governor menu
[    8.153953] Simple Boot Flag at 0x35 set to 0x1
[    8.154805] ACPI: bus type PCI registered
[    8.155721] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    8.159595] PCI: PCI BIOS revision 2.10 entry at 0xfd9c0, last bus=3D1
[    8.159722] PCI: Using configuration type 1 for base access
[    8.183790] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    8.196115] cryptd: max_cpu_qlen set to 1000
[    8.225958] raid6: skip pq benchmark and using algorithm mmxx2
[    8.226730] raid6: using intx1 recovery algorithm
[    8.229133] ACPI: Added _OSI(Module Device)
[    8.229741] ACPI: Added _OSI(Processor Device)
[    8.230714] ACPI: Added _OSI(3.0 _SCP Extensions)
[    8.231718] ACPI: Added _OSI(Processor Aggregator Device)
[    8.232716] ACPI: Added _OSI(Linux-Dell-Video)
[    8.233715] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    8.234715] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    8.266310] ACPI: 1 ACPI AML tables successfully acquired and loaded
[    8.274523] ACPI: Interpreter enabled
[    8.274870] ACPI: PM: (supports S0 S1 S4 S5)
[    8.275717] ACPI: Using IOAPIC for interrupt routing
[    8.276987] PCI: Using host bridge windows from ACPI; if necessary, use =
"pci=3Dnocrs" and report a bug
[    8.279128] ACPI: Enabled 2 GPEs in block 00 to 0F
[    8.279701] ACPI: Enabled 2 GPEs in block 10 to 1F
[    8.473864] acpi LNXCPU:00: Invalid PBLK length [5]
[    8.477045] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    8.477745] acpi PNP0A03:00: _OSC: OS supports [ASPM ClockPM Segments MS=
I EDR HPX-Type3]
[    8.478801] acpi PNP0A03:00: fail to add MMCONFIG information, can't acc=
ess extended PCI configuration space under this bridge.
[    8.481938] PCI host bridge to bus 0000:00
[    8.482726] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window=
]
[    8.483715] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bfff=
f window]
[    8.484714] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000cfff=
f window]
[    8.485714] pci_bus 0000:00: root bus resource [mem 0x000d0000-0x000dfff=
f window]
[    8.486715] pci_bus 0000:00: root bus resource [mem 0x18000000-0xfebffff=
f window]
[    8.487715] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window=
]
[    8.488718] pci_bus 0000:00: root bus resource [bus 00-ff]
[    8.489802] pci 0000:00:00.0: [8086:7124] type 00 class 0x060000
[    8.492207] pci 0000:00:01.0: [8086:7125] type 00 class 0x030000
[    8.492757] pci 0000:00:01.0: reg 0x10: [mem 0xf8000000-0xfbffffff pref]
[    8.493724] pci 0000:00:01.0: reg 0x14: [mem 0xf4000000-0xf407ffff]
[    8.496343] pci 0000:00:1e.0: [8086:2418] type 01 class 0x060400
[    8.498331] pci 0000:00:1f.0: [8086:2410] type 00 class 0x060100
[    8.498883] pci 0000:00:1f.0: quirk: [io  0x1000-0x107f] claimed by ICH4=
 ACPI/GPIO/TCO
[    8.499729] pci 0000:00:1f.0: quirk: [io  0x1180-0x11bf] claimed by ICH4=
 GPIO
[    8.501841] pci 0000:00:1f.1: [8086:2411] type 00 class 0x010180
[    8.502799] pci 0000:00:1f.1: reg 0x20: [io  0x1800-0x180f]
[    8.503745] pci 0000:00:1f.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x=
01f7]
[    8.504714] pci 0000:00:1f.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    8.505714] pci 0000:00:1f.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x=
0177]
[    8.506713] pci 0000:00:1f.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    8.509062] pci 0000:00:1f.2: [8086:2412] type 00 class 0x0c0300
[    8.509805] pci 0000:00:1f.2: reg 0x20: [io  0x1820-0x183f]
[    8.511921] pci 0000:00:1f.5: [8086:2415] type 00 class 0x040100
[    8.512761] pci 0000:00:1f.5: reg 0x10: [io  0x2000-0x20ff]
[    8.513728] pci 0000:00:1f.5: reg 0x14: [io  0x1840-0x187f]
[    8.516455] pci_bus 0000:01: extended config space not accessible
[    8.517790] pci 0000:01:0b.0: [1397:2bd0] type 00 class 0x028000
[    8.518741] pci 0000:01:0b.0: reg 0x10: [io  0x3000-0x3007]
[    8.519724] pci 0000:01:0b.0: reg 0x14: [mem 0xf4100000-0xf41000ff]
[    8.520885] pci 0000:01:0b.0: supports D1 D2
[    8.521716] pci 0000:01:0b.0: PME# supported from D0 D1 D2 D3hot
[    8.523106] pci 0000:01:0d.0: [10b7:9200] type 00 class 0x020000
[    8.523755] pci 0000:01:0d.0: reg 0x10: [io  0x3080-0x30ff]
[    8.524727] pci 0000:01:0d.0: reg 0x14: [mem 0xf4100400-0xf410047f]
[    8.525774] pci 0000:01:0d.0: reg 0x30: [mem 0x00000000-0x0001ffff pref]
[    8.526837] pci 0000:01:0d.0: supports D1 D2
[    8.527717] pci 0000:01:0d.0: PME# supported from D0 D1 D2 D3hot D3cold
[    8.529124] pci 0000:01:0e.0: [1033:0035] type 00 class 0x0c0310
[    8.529753] pci 0000:01:0e.0: reg 0x10: [mem 0xf4101000-0xf4101fff]
[    8.531889] pci 0000:01:0e.0: supports D1 D2
[    8.532717] pci 0000:01:0e.0: PME# supported from D0 D1 D2 D3hot
[    8.534149] pci 0000:01:0e.1: [1033:0035] type 00 class 0x0c0310
[    8.534760] pci 0000:01:0e.1: reg 0x10: [mem 0xf4102000-0xf4102fff]
[    8.536899] pci 0000:01:0e.1: supports D1 D2
[    8.537716] pci 0000:01:0e.1: PME# supported from D0 D1 D2 D3hot
[    8.539074] pci 0000:01:0e.2: [1033:00e0] type 00 class 0x0c0320
[    8.539749] pci 0000:01:0e.2: reg 0x10: [mem 0xf4100800-0xf41008ff]
[    8.541876] pci 0000:01:0e.2: supports D1 D2
[    8.542714] pci 0000:01:0e.2: PME# supported from D0 D1 D2 D3hot
[    8.544104] pci 0000:00:1e.0: PCI bridge to [bus 01] (subtractive decode=
)
[    8.544736] pci 0000:00:1e.0:   bridge window [io  0x3000-0x3fff]
[    8.545718] pci 0000:00:1e.0:   bridge window [mem 0xf4100000-0xf41fffff=
]
[    8.546721] pci 0000:00:1e.0:   bridge window [io  0x0000-0x0cf7 window]=
 (subtractive decode)
[    8.547716] pci 0000:00:1e.0:   bridge window [mem 0x000a0000-0x000bffff=
 window] (subtractive decode)
[    8.548714] pci 0000:00:1e.0:   bridge window [mem 0x000c0000-0x000cffff=
 window] (subtractive decode)
[    8.549714] pci 0000:00:1e.0:   bridge window [mem 0x000d0000-0x000dffff=
 window] (subtractive decode)
[    8.550715] pci 0000:00:1e.0:   bridge window [mem 0x18000000-0xfebfffff=
 window] (subtractive decode)
[    8.551714] pci 0000:00:1e.0:   bridge window [io  0x0d00-0xffff window]=
 (subtractive decode)
[    8.555135] ACPI: PCI: Interrupt link LNKA configured for IRQ 11
[    8.556777] ACPI: PCI: Interrupt link LNKB configured for IRQ 10
[    8.558194] ACPI: PCI: Interrupt link LNKC configured for IRQ 5
[    8.559788] ACPI: PCI: Interrupt link LNKD configured for IRQ 9
[    8.564008] iommu: Default domain type: Translated
[    8.565979] pci 0000:00:01.0: vgaarb: setting as boot VGA device
[    8.566701] pci 0000:00:01.0: vgaarb: VGA device added: decodes=3Dio+mem=
,owns=3Dio+mem,locks=3Dnone
[    8.566741] pci 0000:00:01.0: vgaarb: bridge control possible
[    8.567716] vgaarb: loaded
[    8.571055] SCSI subsystem initialized
[    8.572719] ACPI: bus type USB registered
[    8.573938] usbcore: registered new interface driver usbfs
[    8.574819] usbcore: registered new interface driver hub
[    8.575873] usbcore: registered new device driver usb
[    8.576892] pps_core: LinuxPPS API ver. 1 registered
[    8.577714] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo =
Giometti <giometti@linux.it>
[    8.578740] PTP clock support registered
[    8.581015] EDAC MC: Ver: 3.0.0
[    8.584824] PCI: Using ACPI for IRQ routing
[    8.587663] clocksource: Switched to clocksource tsc-early
[    8.715847] VFS: Disk quotas dquot_6.6.0
[    9.054721] clocksource: timekeeping watchdog on CPU0: Marking clocksour=
ce 'tsc-early' as unstable because the skew is too large:
[    9.194370] clocksource:                       'refined-jiffies' wd_nsec=
: 503923392 wd_now: fffb7018 wd_last: fffb6e20 mask: ffff
[    9.338164] clocksource:                       'tsc-early' cs_nsec: 6702=
584311 cs_now: 83820308a cs_last: 763be2891 mask: fffffff
[    9.487168] clocksource:                       'tsc-early' is current cl=
ocksource.
[    9.577842] tsc: Marking TSC unstable due to clocksource watchdog
[   10.998226] clocksource: Switched to clocksource refined-jiffies
[   11.000385] VFS: Dquot-cache hash table entries: 1024 (order 0, 4096 byt=
es)
[   11.002569] pnp: PnP ACPI init
[   11.004798] system 00:00: [io  0x1000-0x107f] has been reserved
[   11.005249] system 00:00: [io  0x1180-0x11bf] has been reserved
[   11.006209] system 00:00: [io  0x04d0-0x04d1] has been reserved
[   11.007210] system 00:00: [io  0x0290-0x0297] has been reserved
[   11.008214] system 00:00: [io  0x0400-0x0404] has been reserved
[   11.009210] system 00:00: [io  0xfe00-0xfe0f] has been reserved
[   11.010215] system 00:00: [mem 0xfec00000-0xfec00fff] could not be reser=
ved
[   11.011207] system 00:00: [mem 0xfee00000-0xfee00fff] has been reserved
[   11.012210] system 00:00: [mem 0xff800000-0xffffffff] could not be reser=
ved
[   11.093727] pnp: PnP ACPI: found 9 devices
[   11.148306] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, m=
ax_idle_ns: 2085701024 ns
[   11.149268] clocksource: Switched to clocksource acpi_pm
[   11.213931] NET: Registered PF_INET protocol family
[   11.273001] IP idents hash table entries: 8192 (order: 4, 65536 bytes, l=
inear)
[   11.361862] tcp_listen_portaddr_hash hash table entries: 512 (order: 0, =
6144 bytes, linear)
[   11.462333] TCP established hash table entries: 4096 (order: 2, 16384 by=
tes, linear)
[   11.555390] TCP bind hash table entries: 4096 (order: 3, 32768 bytes, li=
near)
[   11.641144] TCP: Hash tables configured (established 4096 bind 4096)
[   11.718098] MPTCP token hash table entries: 512 (order: 1, 8192 bytes, l=
inear)
[   11.805027] UDP hash table entries: 256 (order: 1, 8192 bytes, linear)
[   11.883430] UDP-Lite hash table entries: 256 (order: 1, 8192 bytes, line=
ar)
[   11.967335] NET: Registered PF_UNIX/PF_LOCAL protocol family
[   12.037010] RPC: Registered named UNIX socket transport module.
[   12.108079] RPC: Registered udp transport module.
[   12.164507] RPC: Registered tcp transport module.
[   12.220864] RPC: Registered tcp NFSv4.1 backchannel transport module.
[   12.298131] NET: Registered PF_XDP protocol family
[   12.355794] pci 0000:00:1e.0: BAR 15: assigned [mem 0x18000000-0x180ffff=
f pref]
[   12.443493] pci 0000:01:0d.0: BAR 6: assigned [mem 0x18000000-0x1801ffff=
 pref]
[   12.530129] pci 0000:00:1e.0: PCI bridge to [bus 01]
[   12.589721] pci 0000:00:1e.0:   bridge window [io  0x3000-0x3fff]
[   12.662804] pci 0000:00:1e.0:   bridge window [mem 0xf4100000-0xf41fffff=
]
[   12.744241] pci 0000:00:1e.0:   bridge window [mem 0x18000000-0x180fffff=
 pref]
[   12.830851] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[   12.904989] pci_bus 0000:00: resource 5 [mem 0x000a0000-0x000bffff windo=
w]
[   12.987438] pci_bus 0000:00: resource 6 [mem 0x000c0000-0x000cffff windo=
w]
[   13.069885] pci_bus 0000:00: resource 7 [mem 0x000d0000-0x000dffff windo=
w]
[   13.152241] pci_bus 0000:00: resource 8 [mem 0x18000000-0xfebfffff windo=
w]
[   13.234594] pci_bus 0000:00: resource 9 [io  0x0d00-0xffff window]
[   13.308633] pci_bus 0000:01: resource 0 [io  0x3000-0x3fff]
[   13.375387] pci_bus 0000:01: resource 1 [mem 0xf4100000-0xf41fffff]
[   13.450462] pci_bus 0000:01: resource 2 [mem 0x18000000-0x180fffff pref]
[   13.530737] pci_bus 0000:01: resource 4 [io  0x0000-0x0cf7 window]
[   13.604775] pci_bus 0000:01: resource 5 [mem 0x000a0000-0x000bffff windo=
w]
[   13.687127] pci_bus 0000:01: resource 6 [mem 0x000c0000-0x000cffff windo=
w]
[   13.769482] pci_bus 0000:01: resource 7 [mem 0x000d0000-0x000dffff windo=
w]
[   13.851835] pci_bus 0000:01: resource 8 [mem 0x18000000-0xfebfffff windo=
w]
[   13.934191] pci_bus 0000:01: resource 9 [io  0x0d00-0xffff window]
[   14.008919] pci 0000:00:01.0: Video device with shadowed ROM at [mem 0x0=
00c0000-0x000dffff]
[   14.110462] pci 0000:00:01.0: pci_fixup_video+0x0/0xd0 took 99181 usecs
[   14.191046] pci 0000:01:0e.0: enabling device (0114 -> 0116)
[   14.260910] pci 0000:01:0e.0: quirk_usb_early_handoff+0x0/0x710 took 682=
58 usecs
[   14.349848] pci 0000:01:0e.1: enabling device (0114 -> 0116)
[   14.419488] pci 0000:01:0e.1: quirk_usb_early_handoff+0x0/0x710 took 680=
19 usecs
[   14.508445] pci 0000:01:0e.2: enabling device (0114 -> 0116)
[   14.578240] pci 0000:01:0e.2: quirk_usb_early_handoff+0x0/0x710 took 681=
67 usecs
[   14.667046] PCI: CLS 32 bytes, default 32
[   14.715676] Trying to unpack rootfs image as initramfs...
[   14.785663] Initialise system trusted keyrings
[   14.839272] Key type blacklist registered
[   14.935927] workingset: timestamp_bits=3D11 max_order=3D17 bucket_order=
=3D6
[   15.122699] zbud: loaded
[   15.189206] NFS: Registering the id_resolver key type
[   15.310457] Key type id_resolver registered
[   15.410863] Key type id_legacy registered
[   15.515683] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[   15.687016] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Driver Regist=
ering...
[   15.880313] romfs: ROMFS MTD (C) 2007 Red Hat, Inc.
[   16.266779] xor: measuring software checksum speed
[   16.331119]    pII_mmx         :  1442 MB/sec
[   16.389952]    p5_mmx          :  1505 MB/sec
[   16.442146] xor: using function: p5_mmx (1505 MB/sec)
[   16.502673] async_tx: api initialized (async)
[   16.868099] Key type asymmetric registered
[   16.965546] Asymmetric key parser 'x509' registered
[   17.085586] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 244)
[   17.269789] io scheduler mq-deadline registered
[   17.380919] atomic64_test: passed for i586+ platform with CX8 and withou=
t SSE
[   17.555189] isapnp: Scanning for PnP cards...
[   18.350887] isapnp: No Plug & Play device found
[   18.553433] Freeing initrd memory: 10428K
[   18.617914] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[   18.693644] 00:04: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D 115200) =
is a 16550A
[   18.791886] Floppy drive(s): fd0 is 1.44M
[   18.880314] brd: module loaded
[   18.930209] scsi host0: ata_piix
[   18.970835] FDC 0 is a post-1991 82077
[   19.017559] scsi host1: ata_piix
[   19.057405] ata1: PATA max UDMA/66 cmd 0x1f0 ctl 0x3f6 bmdma 0x1800 irq =
14
[   19.139912] ata2: PATA max UDMA/66 cmd 0x170 ctl 0x376 bmdma 0x1808 irq =
15
[   19.232257] i8042: PNP: PS/2 Controller [PNP0303:KBC0,PNP0f13:MSE0] at 0=
x60,0x64 irq 1,12
[   19.334899] serio: i8042 KBD port at 0x60,0x64 irq 1
[   19.395192] serio: i8042 AUX port at 0x60,0x64 irq 12
[   19.458568] ata1.00: ATA-5: WDC WD200EB-00CSF0, 04.01B04, max UDMA/100
[   19.536966] ata1.00: 39102336 sectors, multi 16: LBA
[   19.597750] ata2.00: HPA detected: current 39062500, native 39102336
[   19.673951] ata2.00: ATA-5: WDC WD200BB-18DEA0, 05.03E05, max UDMA/100
[   19.752228] ata2.00: 39062500 sectors, multi 16: LBA
[   19.813509] mousedev: PS/2 mouse device common for all mice
[   19.881090] rtc_cmos 00:01: RTC can wake from S4
[   19.938077] rtc_cmos 00:01: registered as rtc0
[   19.992016] rtc_cmos 00:01: alarms up to one month, y3k, 114 bytes nvram
[   20.074799] scsi 0:0:0:0: Direct-Access     ATA      WDC WD200EB-00CS 1B=
04 PQ: 0 ANSI: 5
[   20.172684] device-mapper: uevent: version 1.0.3
[   20.229228] device-mapper: ioctl: 4.45.0-ioctl (2021-03-22) initialised:=
 dm-devel@redhat.com
[   20.332823] sd 0:0:0:0: [sda] 39102336 512-byte logical blocks: (20.0 GB=
/18.6 GiB)
[   20.425590] scsi 1:0:0:0: Direct-Access     ATA      WDC WD200BB-18DE 3E=
05 PQ: 0 ANSI: 5
[   20.523192] input: AT Translated Set 2 keyboard as /devices/platform/i80=
42/serio0/input/input0
[   20.626586] intel_pstate: CPU model not supported
[   20.683196] sd 0:0:0:0: [sda] Write Protect is off
[   20.743022] sd 1:0:0:0: [sdb] 39062500 512-byte logical blocks: (20.0 GB=
/18.6 GiB)
[   20.836436] Initializing XFRM netlink socket
[   20.888241] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[   20.997314] NET: Registered PF_PACKET protocol family
[   21.058269] sd 1:0:0:0: [sdb] Write Protect is off
[   21.116496] Key type dns_resolver registered
[   21.168190] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[   21.281496] microcode: sig=3D0x665, pf=3D0x10, revision=3D0x3
[   21.345273] microcode: Microcode Update Driver: v2.2.
[   21.345319] IPI shorthand broadcast: enabled
[   21.457426]  sda: sda1 sda2 sda3
[   21.503615] registered taskstats version 1
[   21.553874] Loading compiled-in X.509 certificates
[   21.611956]  sdb: sdb1 sdb2
[   21.646262] sd 0:0:0:0: [sda] Attached SCSI disk
[   21.702238] zswap: loaded using pool lzo/zbud
[   21.759098] Key type ._fscrypt registered
[   21.808114] sd 1:0:0:0: [sdb] Attached SCSI disk
[   21.863583] Key type .fscrypt registered
[   21.910753] Key type fscrypt-provisioning registered
[   22.026812] Key type encrypted registered
[   22.076244] Unstable clock detected, switching default tracing clock to =
"global"
[   22.076244] If you want to keep using the local clock, then add:
[   22.076244]   "trace_clock=3Dlocal"
[   22.076244] on the kernel command line
[   22.342821] Freeing unused kernel image (initmem) memory: 924K
[   22.413147] Write protecting kernel text and read-only data: 13532k
[   22.488377] rodata_test: all tests were successful
[   22.546247] Run /init as init process
[   22.610556] init[1] bad frame in sigreturn frame:(ptrval) ip:b7d46be6 sp=
:bff3af30 orax:ffffffff in libc-2.33.so[b7c94000+156000]
[   22.749531] Kernel panic - not syncing: Attempted to kill init! exitcode=
=3D0x0000000b
[   22.750240] CPU: 0 PID: 1 Comm: init Not tainted 5.14.9-smp #1
[   22.750240] Hardware name: Hewlett-Packard HP PC/HP Board, BIOS  JD.00.0=
6 12/06/2001
[   22.750240] Call Trace:
[   22.750240]  ? dump_stack_lvl+0x32/0x41
[   22.750240]  ? dump_stack+0xa/0xc
[   22.750240]  ? panic+0xa2/0x23f
[   22.750240]  ? do_exit.cold+0x94/0x94
[   22.750240]  ? do_group_exit+0x2a/0x80
[   22.750240]  ? get_signal+0x142/0x7a0
[   22.750240]  ? arch_do_signal_or_restart+0xb1/0x570
[   22.750240]  ? force_sig_info_to_task+0x65/0xf0
[   22.750240]  ? vprintk_emit+0x150/0x190
[   22.750240]  ? exit_to_user_mode_prepare+0x145/0x1e0
[   22.750240]  ? syscall_exit_to_user_mode+0x18/0x40
[   22.750240]  ? do_int80_syscall_32+0x3d/0x80
[   22.750240]  ? entry_INT80_32+0xf0/0xf0
[   22.750240] Kernel Offset: disabled

Regards,

Olmy
