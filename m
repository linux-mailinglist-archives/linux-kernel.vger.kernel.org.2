Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6508E45326F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 13:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236441AbhKPMyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 07:54:45 -0500
Received: from mail.yujinakao.com ([107.191.43.40]:53214 "EHLO
        mail.yujinakao.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236429AbhKPMyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 07:54:40 -0500
X-Greylist: delayed 416 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Nov 2021 07:54:40 EST
Received: from localhost (150-66-68-225m5.mineo.jp [150.66.68.225])
        by mail.yujinakao.com (Postfix) with ESMTPSA id 4F6E27D00C;
        Tue, 16 Nov 2021 12:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yujinakao.com;
        s=201707; t=1637066684;
        bh=9ZRyXrza3xzlXvQhURCtvGJh/MXaKw0U1pzeAnNoXPk=;
        h=From:To:Cc:Subject:Date:From;
        b=wFfAqH51tathCTiD2/DA7wBANOLz13iGviG1RBczFz7bTAzOt8KKyK8vgCBulvKqX
         fnjJbxYjZ07NhpMvJu9TKTrrrmS3tdNkiJqQVvIDbbu/QwUSsSnHZ4raOK6xKZu9Vs
         KQzYry4SC83xzPeGjitpRfmsqlGwQlzHITKZJ6J8TdnDTtWkM/f5y0Q/qk2u7lVed3
         /Tdylrux1Kzajradw3DXAjy5I29H63bbCRaFPV099GcSzlnvsMfdHV6O+PxQPf2ygm
         19nlx9O29ySxl8QNhEgjnoiZW4gIIE+apYyPzTpALIAGLaNmjKKiSLhVpyW7PwfZ7P
         1ej2cJjnodWEg==
From:   Yuji Nakao <contact@yujinakao.com>
To:     linux-kernel@vger.kernel.org
Cc:     damien.lemoal@opensource.wdc.com
Subject: Kernel 5.15 doesn't detect SATA drive on boot
Date:   Tue, 16 Nov 2021 21:44:43 +0900
Message-ID: <87h7ccw9qc.fsf@yujinakao.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

Hello,

I'm using Arch Linux on MacBook Air 2010. I updated `linux` package[1]
from v5.14.16 to v5.15.2 the other day, and the boot process stalled
with the following message.

```shell
:: running early hook [udev]
Starting version 249.6-3-arch
:: running hook [udev]
:: Triggering uevents...
Waiting 10 seconds for device /dev/sda3 ...
ERROR: device '/dev/sda3' not found. Skipping fsck.
:: mounting '/dev/sda' on real root
mount: /new_root: no filesystem type specified.
You are now being dropped into an emergency shell.
sh: can't access tty; job control turned off
[rootfs ]#
```

In the emergency shell there's no `sda` devices when I type `$ ls
/dev/`. By downgrading the kernel, boot process works properly.

See also Arch Linux bug tracker[2]. There are similar reports on
Apple devices.

`dmesg` output in the emergency shell is attached. I guess this issue is
related to libata, so CCed to Damien Le Moal.

Regards.

[1] https://archlinux.org/packages/core/x86_64/linux/
[2] https://bugs.archlinux.org/task/72734


--=-=-=
Content-Type: text/plain
Content-Disposition: inline; filename=dmesg_output.log
Content-Description: dmesg_output.log

[    0.000000] microcode: microcode updated early to revision 0xa0b, date = 2010-09-28
[    0.000000] Linux version 5.15.2-arch1-1 (linux@archlinux) (gcc (GCC) 11.1.0, GNU ld (GNU Binutils) 2.36.1) #1 SMP PREEMPT Fri, 12 Nov 2021 19:22:10 +0000
[    0.000000] Command line: initrd=\intel-ucode.img initrd=\initramfs-linux.img root=/dev/sda3 rw ipv6.disable=1
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Enabled xstate features 0x3, context size is 576 bytes, using 'standard' format.
[    0.000000] signal: max sigframe size: 1520
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000008efff] usable
[    0.000000] BIOS-e820: [mem 0x000000000008f000-0x000000000008ffff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x0000000000090000-0x000000000009ffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000006effffff] usable
[    0.000000] BIOS-e820: [mem 0x000000006f000000-0x000000007effffff] reserved
[    0.000000] BIOS-e820: [mem 0x000000007f000000-0x000000007f718fff] usable
[    0.000000] BIOS-e820: [mem 0x000000007f719000-0x000000007f938fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000007f939000-0x000000007f953fff] usable
[    0.000000] BIOS-e820: [mem 0x000000007f954000-0x000000007f96afff] ACPI data
[    0.000000] BIOS-e820: [mem 0x000000007f96b000-0x000000007f96dfff] usable
[    0.000000] BIOS-e820: [mem 0x000000007f96e000-0x000000007f99afff] reserved
[    0.000000] BIOS-e820: [mem 0x000000007f99b000-0x000000007f9affff] usable
[    0.000000] BIOS-e820: [mem 0x000000007f9b0000-0x000000007f9dafff] reserved
[    0.000000] BIOS-e820: [mem 0x000000007f9db000-0x000000007fef8fff] usable
[    0.000000] BIOS-e820: [mem 0x000000007fef9000-0x000000007fefffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000093200000-0x0000000093200fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ffc00000-0x00000000ffffffff] reserved
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] e820: update [mem 0x6d43a018-0x6d448c57] usable ==> usable
[    0.000000] e820: update [mem 0x6d43a018-0x6d448c57] usable ==> usable
[    0.000000] e820: update [mem 0x6d439018-0x6d439984] usable ==> usable
[    0.000000] e820: update [mem 0x6d439018-0x6d439984] usable ==> usable
[    0.000000] extended physical RAM map:
[    0.000000] reserve setup_data: [mem 0x0000000000000000-0x000000000008efff] usable
[    0.000000] reserve setup_data: [mem 0x000000000008f000-0x000000000008ffff] ACPI NVS
[    0.000000] reserve setup_data: [mem 0x0000000000090000-0x000000000009ffff] usable
[    0.000000] reserve setup_data: [mem 0x0000000000100000-0x000000006d439017] usable
[    0.000000] reserve setup_data: [mem 0x000000006d439018-0x000000006d439984] usable
[    0.000000] reserve setup_data: [mem 0x000000006d439985-0x000000006d43a017] usable
[    0.000000] reserve setup_data: [mem 0x000000006d43a018-0x000000006d448c57] usable
[    0.000000] reserve setup_data: [mem 0x000000006d448c58-0x000000006effffff] usable
[    0.000000] reserve setup_data: [mem 0x000000006f000000-0x000000007effffff] reserved
[    0.000000] reserve setup_data: [mem 0x000000007f000000-0x000000007f718fff] usable
[    0.000000] reserve setup_data: [mem 0x000000007f719000-0x000000007f938fff] ACPI NVS
[    0.000000] reserve setup_data: [mem 0x000000007f939000-0x000000007f953fff] usable
[    0.000000] reserve setup_data: [mem 0x000000007f954000-0x000000007f96afff] ACPI data
[    0.000000] reserve setup_data: [mem 0x000000007f96b000-0x000000007f96dfff] usable
[    0.000000] reserve setup_data: [mem 0x000000007f96e000-0x000000007f99afff] reserved
[    0.000000] reserve setup_data: [mem 0x000000007f99b000-0x000000007f9affff] usable
[    0.000000] reserve setup_data: [mem 0x000000007f9b0000-0x000000007f9dafff] reserved
[    0.000000] reserve setup_data: [mem 0x000000007f9db000-0x000000007fef8fff] usable
[    0.000000] reserve setup_data: [mem 0x000000007fef9000-0x000000007fefffff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000093200000-0x0000000093200fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000ffc00000-0x00000000ffffffff] reserved
[    0.000000] efi: EFI v1.10 by Apple
[    0.000000] efi: ACPI=0x7f96a000 ACPI 2.0=0x7f96a014 SMBIOS=0x7f71a000 
[    0.000000] SMBIOS 2.4 present.
[    0.000000] DMI: Apple Inc. MacBookAir3,1/Mac-942452F5819B1C1B, BIOS    MBA31.88Z.0061.B07.1201241641 01/24/12
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 1397.185 MHz processor
[    0.000027] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000036] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000054] last_pfn = 0x7fef9 max_arch_pfn = 0x400000000
[    0.001564] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.027471] Secure boot disabled
[    0.027478] RAMDISK: [mem 0x67891000-0x684ddfff]
[    0.027491] ACPI: Early table checksum verification disabled
[    0.027499] ACPI: RSDP 0x000000007F96A014 000024 (v02 APPLE )
[    0.027510] ACPI: XSDT 0x000000007F96A1C0 000084 (v01 APPLE  Apple00  00000061      01000013)
[    0.027525] ACPI: FACP 0x000000007F968000 0000F4 (v04 APPLE  Apple00  00000061 Loki 0000005F)
[    0.027540] ACPI: DSDT 0x000000007F95B000 00572C (v01 APPLE  MacBookA 00030001 INTL 20061109)
[    0.027550] ACPI: FACS 0x000000007F71E000 000040
[    0.027558] ACPI: FACS 0x000000007F71E000 000040
[    0.027566] ACPI: HPET 0x000000007F967000 000038 (v01 APPLE  Apple00  00000001 Loki 0000005F)
[    0.027576] ACPI: APIC 0x000000007F966000 000068 (v01 APPLE  Apple00  00000001 Loki 0000005F)
[    0.027586] ACPI: APIC 0x000000007F965000 000068 (v02 APPLE  Apple00  00000001 Loki 0000005F)
[    0.027596] ACPI: ASF! 0x000000007F963000 0000A5 (v32 APPLE  Apple00  00000001 Loki 0000005F)
[    0.027606] ACPI: SBST 0x000000007F962000 000030 (v01 APPLE  Apple00  00000001 Loki 0000005F)
[    0.027615] ACPI: ECDT 0x000000007F961000 000053 (v01 APPLE  Apple00  00000001 Loki 0000005F)
[    0.027625] ACPI: SSDT 0x000000007F958000 000107 (v01 APPLE  SataAhci 00001000 INTL 20061109)
[    0.027635] ACPI: SSDT 0x000000007F957000 000024 (v01 APPLE  Apple    00001000 INTL 20061109)
[    0.027645] ACPI: SSDT 0x000000007F955000 00008A (v01 APPLE  NoSDCard 00001000 INTL 20061109)
[    0.027654] ACPI: SSDT 0x000000007F954000 0004DC (v01 APPLE  CpuPm    00003000 INTL 20061109)
[    0.027663] ACPI: MCFG 0x000000007F964000 00003C (v01 APPLE  Apple00  00000001 Loki 0000005F)
[    0.027671] ACPI: Reserving FACP table memory at [mem 0x7f968000-0x7f9680f3]
[    0.027676] ACPI: Reserving DSDT table memory at [mem 0x7f95b000-0x7f96072b]
[    0.027679] ACPI: Reserving FACS table memory at [mem 0x7f71e000-0x7f71e03f]
[    0.027682] ACPI: Reserving FACS table memory at [mem 0x7f71e000-0x7f71e03f]
[    0.027685] ACPI: Reserving HPET table memory at [mem 0x7f967000-0x7f967037]
[    0.027688] ACPI: Reserving APIC table memory at [mem 0x7f966000-0x7f966067]
[    0.027692] ACPI: Reserving APIC table memory at [mem 0x7f965000-0x7f965067]
[    0.027695] ACPI: Reserving ASF! table memory at [mem 0x7f963000-0x7f9630a4]
[    0.027698] ACPI: Reserving SBST table memory at [mem 0x7f962000-0x7f96202f]
[    0.027701] ACPI: Reserving ECDT table memory at [mem 0x7f961000-0x7f961052]
[    0.027704] ACPI: Reserving SSDT table memory at [mem 0x7f958000-0x7f958106]
[    0.027707] ACPI: Reserving SSDT table memory at [mem 0x7f957000-0x7f957023]
[    0.027711] ACPI: Reserving SSDT table memory at [mem 0x7f955000-0x7f955089]
[    0.027714] ACPI: Reserving SSDT table memory at [mem 0x7f954000-0x7f9544db]
[    0.027717] ACPI: Reserving MCFG table memory at [mem 0x7f964000-0x7f96403b]
[    0.027725] ACPI: BIOS bug: multiple APIC/MADT found, using 0
[    0.027728] ACPI: If "acpi_apic_instance=2" works better, notify linux-acpi@vger.kernel.org
[    0.027740] ACPI: DMI detected to setup _OSI("Darwin"): Apple hardware
[    0.027838] No NUMA configuration found
[    0.027840] Faking a node at [mem 0x0000000000000000-0x000000007fef8fff]
[    0.027849] NODE_DATA(0) allocated [mem 0x7fef5000-0x7fef8fff]
[    0.027902] Zone ranges:
[    0.027904]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.027910]   DMA32    [mem 0x0000000001000000-0x000000007fef8fff]
[    0.027915]   Normal   empty
[    0.027918]   Device   empty
[    0.027921] Movable zone start for each node
[    0.027923] Early memory node ranges
[    0.027925]   node   0: [mem 0x0000000000001000-0x000000000008efff]
[    0.027929]   node   0: [mem 0x0000000000090000-0x000000000009ffff]
[    0.027932]   node   0: [mem 0x0000000000100000-0x000000006effffff]
[    0.027936]   node   0: [mem 0x000000007f000000-0x000000007f718fff]
[    0.027939]   node   0: [mem 0x000000007f939000-0x000000007f953fff]
[    0.027942]   node   0: [mem 0x000000007f96b000-0x000000007f96dfff]
[    0.027945]   node   0: [mem 0x000000007f99b000-0x000000007f9affff]
[    0.027949]   node   0: [mem 0x000000007f9db000-0x000000007fef8fff]
[    0.027953] Initmem setup node 0 [mem 0x0000000000001000-0x000000007fef8fff]
[    0.027964] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.027968] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.028046] On node 0, zone DMA: 96 pages in unavailable ranges
[    0.046116] On node 0, zone DMA32: 32768 pages in unavailable ranges
[    0.046146] On node 0, zone DMA32: 544 pages in unavailable ranges
[    0.046150] On node 0, zone DMA32: 23 pages in unavailable ranges
[    0.046157] On node 0, zone DMA32: 45 pages in unavailable ranges
[    0.046214] On node 0, zone DMA32: 43 pages in unavailable ranges
[    0.046227] On node 0, zone DMA32: 263 pages in unavailable ranges
[    0.046560] ACPI: PM-Timer IO Port: 0x408
[    0.046581] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.046586] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.046603] IOAPIC[0]: apic_id 1, version 17, address 0xfec00000, GSI 0-23
[    0.046611] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.046616] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.046625] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.046628] ACPI: HPET id: 0x10de8201 base: 0xfed00000
[    0.046641] smpboot: Allowing 2 CPUs, 0 hotplug CPUs
[    0.046695] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.046702] PM: hibernation: Registered nosave memory: [mem 0x0008f000-0x0008ffff]
[    0.046707] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000fffff]
[    0.046713] PM: hibernation: Registered nosave memory: [mem 0x6d439000-0x6d439fff]
[    0.046718] PM: hibernation: Registered nosave memory: [mem 0x6d439000-0x6d439fff]
[    0.046721] PM: hibernation: Registered nosave memory: [mem 0x6d43a000-0x6d43afff]
[    0.046726] PM: hibernation: Registered nosave memory: [mem 0x6d448000-0x6d448fff]
[    0.046731] PM: hibernation: Registered nosave memory: [mem 0x6f000000-0x7effffff]
[    0.046736] PM: hibernation: Registered nosave memory: [mem 0x7f719000-0x7f938fff]
[    0.046742] PM: hibernation: Registered nosave memory: [mem 0x7f954000-0x7f96afff]
[    0.046747] PM: hibernation: Registered nosave memory: [mem 0x7f96e000-0x7f99afff]
[    0.046752] PM: hibernation: Registered nosave memory: [mem 0x7f9b0000-0x7f9dafff]
[    0.046757] [mem 0x93201000-0xffbfffff] available for PCI devices
[    0.046763] Booting paravirtualized kernel on bare hardware
[    0.046771] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 6370452778343963 ns
[    0.061652] setup_percpu: NR_CPUS:320 nr_cpumask_bits:320 nr_cpu_ids:2 nr_node_ids:1
[    0.062557] percpu: Embedded 53 pages/cpu s180224 r8192 d28672 u1048576
[    0.062577] pcpu-alloc: s180224 r8192 d28672 u1048576 alloc=1*2097152
[    0.062584] pcpu-alloc: [0] 0 1 
[    0.062648] Built 1 zonelists, mobility grouping on.  Total pages: 450424
[    0.062655] Policy zone: DMA32
[    0.062658] Kernel command line: initrd=\intel-ucode.img initrd=\initramfs-linux.img root=/dev/sda3 rw ipv6.disable=1
[    0.063637] Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.064103] Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes, linear)
[    0.065156] mem auto-init: stack:byref_all(zero), heap alloc:on, heap free:off
[    0.086639] Memory: 1690096K/1830944K available (14344K kernel code, 2070K rwdata, 10772K rodata, 1832K init, 3876K bss, 140588K reserved, 0K cma-reserved)
[    0.086659] random: get_random_u64 called from __kmem_cache_create+0x2a/0x540 with crng_init=0
[    0.087078] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
[    0.087117] Kernel/User page tables isolation: enabled
[    0.087166] ftrace: allocating 44240 entries in 173 pages
[    0.124641] ftrace: allocated 173 pages with 5 groups
[    0.124964] rcu: Preemptible hierarchical RCU implementation.
[    0.124968] rcu: 	RCU dyntick-idle grace-period acceleration is enabled.
[    0.124970] rcu: 	RCU restricting CPUs from NR_CPUS=320 to nr_cpu_ids=2.
[    0.124974] rcu: 	RCU priority boosting: priority 1 delay 500 ms.
[    0.124977] 	Trampoline variant of Tasks RCU enabled.
[    0.124979] 	Rude variant of Tasks RCU enabled.
[    0.124980] 	Tracing variant of Tasks RCU enabled.
[    0.124982] rcu: RCU calculated value of scheduler-enlistment delay is 30 jiffies.
[    0.124985] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
[    0.136091] NR_IRQS: 20736, nr_irqs: 440, preallocated irqs: 16
[    0.136615] kfence: initialized - using 2097152 bytes for 255 objects at 0x(____ptrval____)-0x(____ptrval____)
[    0.136715] spurious 8259A interrupt: IRQ7.
[    0.136753] Console: colour dummy device 80x25
[    0.136801] printk: console [tty0] enabled
[    0.136852] ACPI: Core revision 20210730
[    0.137070] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 76450417870 ns
[    0.137098] APIC: Switch to symmetric I/O mode setup
[    0.137620] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.153763] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x1423bd24a8e, max_idle_ns: 440795254148 ns
[    0.153776] Calibrating delay loop (skipped), value calculated using timer frequency.. 2795.80 BogoMIPS (lpj=4657283)
[    0.153783] pid_max: default: 32768 minimum: 301
[    0.175456] LSM: Security Framework initializing
[    0.175480] landlock: Up and running.
[    0.175484] Yama: becoming mindful.
[    0.175504] LSM support for eBPF active
[    0.175548] Mount-cache hash table entries: 4096 (order: 3, 32768 bytes, linear)
[    0.175568] Mountpoint-cache hash table entries: 4096 (order: 3, 32768 bytes, linear)
[    0.176218] CPU0: Thermal monitoring enabled (TM2)
[    0.176241] process: using mwait in idle threads
[    0.176247] Last level iTLB entries: 4KB 128, 2MB 4, 4MB 4
[    0.176251] Last level dTLB entries: 4KB 256, 2MB 0, 4MB 32, 1GB 0
[    0.176260] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.176265] Spectre V2 : Mitigation: Full generic retpoline
[    0.176267] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.176270] Speculative Store Bypass: Vulnerable
[    0.176276] MDS: Vulnerable: Clear CPU buffers attempted, no microcode
[    0.182847] Freeing SMP alternatives memory: 36K
[    0.290013] smpboot: CPU0: Intel(R) Core(TM)2 Duo CPU     U9400  @ 1.40GHz (family: 0x6, model: 0x17, stepping: 0xa)
[    0.290438] Performance Events: PEBS fmt0+, Core2 events, 4-deep LBR, Intel PMU driver.
[    0.290438] ... version:                2
[    0.290438] ... bit width:              40
[    0.290438] ... generic registers:      2
[    0.290438] ... value mask:             000000ffffffffff
[    0.290438] ... max period:             000000007fffffff
[    0.290438] ... fixed-purpose events:   3
[    0.290438] ... event mask:             0000000700000003
[    0.290438] rcu: Hierarchical SRCU implementation.
[    0.290438] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    0.290438] smp: Bringing up secondary CPUs ...
[    0.290438] x86: Booting SMP configuration:
[    0.290438] .... node  #0, CPUs:      #1
[    0.299182] smp: Brought up 1 node, 2 CPUs
[    0.299182] smpboot: Max logical packages: 1
[    0.299182] smpboot: Total of 2 processors activated (5590.60 BogoMIPS)
[    0.303947] devtmpfs: initialized
[    0.303947] x86/mm: Memory block size: 128MB
[    0.304574] ACPI: PM: Registering ACPI NVS region [mem 0x0008f000-0x0008ffff] (4096 bytes)
[    0.304574] ACPI: PM: Registering ACPI NVS region [mem 0x7f719000-0x7f938fff] (2228224 bytes)
[    0.304574] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 6370867519511994 ns
[    0.304574] futex hash table entries: 512 (order: 3, 32768 bytes, linear)
[    0.304574] pinctrl core: initialized pinctrl subsystem
[    0.304574] PM: RTC time: 04:30:03, date: 2001-01-01
[    0.304789] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.305098] DMA: preallocated 256 KiB GFP_KERNEL pool for atomic allocations
[    0.305182] DMA: preallocated 256 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
[    0.305265] DMA: preallocated 256 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
[    0.305285] audit: initializing netlink subsys (disabled)
[    0.305307] audit: type=2000 audit(978323403.166:1): state=initialized audit_enabled=0 res=1
[    0.305307] thermal_sys: Registered thermal governor 'fair_share'
[    0.305307] thermal_sys: Registered thermal governor 'bang_bang'
[    0.305307] thermal_sys: Registered thermal governor 'step_wise'
[    0.305307] thermal_sys: Registered thermal governor 'user_space'
[    0.305307] thermal_sys: Registered thermal governor 'power_allocator'
[    0.305307] cpuidle: using governor ladder
[    0.305307] cpuidle: using governor menu
[    0.307200] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
[    0.307204] ACPI: bus type PCI registered
[    0.307207] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.307649] PCI: MMCONFIG for domain 0000 [bus 00-02] at [mem 0xf0000000-0xf02fffff] (base 0xf0000000)
[    0.307662] PCI: not using MMCONFIG
[    0.307670] PCI: Using configuration type 1 for base access
[    0.311786] Kprobes globally optimized
[    0.311838] HugeTLB: can free 6 vmemmap pages for hugepages-2048kB
[    0.311838] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.314044] ACPI: Disabled all _OSI OS vendors
[    0.314049] ACPI: Added _OSI(Module Device)
[    0.314052] ACPI: Added _OSI(Processor Device)
[    0.314054] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.314057] ACPI: Added _OSI(Processor Aggregator Device)
[    0.314060] ACPI: Added _OSI(Linux-Dell-Video)
[    0.314063] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    0.314065] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    0.314068] ACPI: Added _OSI(Darwin)
[    0.327512] ACPI: 5 ACPI AML tables successfully acquired and loaded
[    0.328422] ACPI: EC: EC started
[    0.328425] ACPI: EC: interrupt blocked
[    0.330113] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.330113] ACPI: EC: Boot ECDT EC used to handle transactions
[    0.330113] ACPI: BIOS _OSI(Darwin) query honored via DMI
[    0.330967] ACPI: Dynamic OEM Table Load:
[    0.330985] ACPI: SSDT 0xFFFF906EC180A200 0001FB (v01 APPLE  Cpu0Ist  00003000 INTL 20061109)
[    0.332541] ACPI: Dynamic OEM Table Load:
[    0.332557] ACPI: SSDT 0xFFFF906EC13BF800 0005A6 (v01 APPLE  Cpu0Cst  00003001 INTL 20061109)
[    0.334674] ACPI: Dynamic OEM Table Load:
[    0.334689] ACPI: SSDT 0xFFFF906EC13DFF00 0000C8 (v01 APPLE  Cpu1Ist  00003000 INTL 20061109)
[    0.335835] ACPI: Dynamic OEM Table Load:
[    0.335849] ACPI: SSDT 0xFFFF906EC13ED180 000085 (v01 APPLE  Cpu1Cst  00003000 INTL 20061109)
[    0.337278] ACPI: Interpreter enabled
[    0.337324] ACPI: PM: (supports S0 S3 S4 S5)
[    0.337328] ACPI: Using IOAPIC for interrupt routing
[    0.337392] PCI: MMCONFIG for domain 0000 [bus 00-02] at [mem 0xf0000000-0xf02fffff] (base 0xf0000000)
[    0.338248] PCI: MMCONFIG at [mem 0xf0000000-0xf02fffff] reserved in ACPI motherboard resources
[    0.338271] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.338838] ACPI: Enabled 7 GPEs in block 00 to 1F
[    0.338855] ACPI: Enabled 2 GPEs in block 20 to 5F
[    0.365651] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.365670] acpi PNP0A08:00: _OSC: OS assumes control of [PCIeHotplug SHPCHotplug AER PCIeCapability LTR DPC]
[    0.365695] acpi PNP0A08:00: [Firmware Info]: MMCONFIG for domain 0000 [bus 00-02] only partially covers this bridge
[    0.366369] PCI host bridge to bus 0000:00
[    0.366374] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.366381] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.366385] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.366390] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000c3fff window]
[    0.366394] pci_bus 0000:00: root bus resource [mem 0x000c4000-0x000c7fff window]
[    0.366398] pci_bus 0000:00: root bus resource [mem 0x000c8000-0x000cbfff window]
[    0.366402] pci_bus 0000:00: root bus resource [mem 0x000cc000-0x000cffff window]
[    0.366406] pci_bus 0000:00: root bus resource [mem 0x000d0000-0x000d3fff window]
[    0.366410] pci_bus 0000:00: root bus resource [mem 0x000d4000-0x000d7fff window]
[    0.366414] pci_bus 0000:00: root bus resource [mem 0x000d8000-0x000dbfff window]
[    0.366418] pci_bus 0000:00: root bus resource [mem 0x000dc000-0x000dffff window]
[    0.366422] pci_bus 0000:00: root bus resource [mem 0x000e0000-0x000e3fff window]
[    0.366426] pci_bus 0000:00: root bus resource [mem 0x000e4000-0x000e7fff window]
[    0.366430] pci_bus 0000:00: root bus resource [mem 0x000e8000-0x000ebfff window]
[    0.366434] pci_bus 0000:00: root bus resource [mem 0x000ec000-0x000effff window]
[    0.366438] pci_bus 0000:00: root bus resource [mem 0x000f0000-0x000fffff window]
[    0.366442] pci_bus 0000:00: root bus resource [mem 0x80000000-0xfebfffff window]
[    0.366446] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.366671] pci 0000:00:00.0: [10de:0d60] type 00 class 0x060000
[    0.367178] pci 0000:00:00.1: [10de:0d68] type 00 class 0x050000
[    0.367587] pci 0000:00:01.0: [10de:0d6d] type 00 class 0x050000
[    0.368107] pci 0000:00:01.1: [10de:0d6e] type 00 class 0x050000
[    0.368503] pci 0000:00:01.2: [10de:0d6f] type 00 class 0x050000
[    0.368929] pci 0000:00:01.3: [10de:0d70] type 00 class 0x050000
[    0.369360] pci 0000:00:02.0: [10de:0d71] type 00 class 0x050000
[    0.369798] pci 0000:00:02.1: [10de:0d72] type 00 class 0x050000
[    0.370313] pci 0000:00:03.0: [10de:0d80] type 00 class 0x060100
[    0.370332] pci 0000:00:03.0: reg 0x10: [io  0x2100-0x21ff]
[    0.370739] pci 0000:00:03.1: [10de:0d7b] type 00 class 0x050000
[    0.371158] pci 0000:00:03.2: [10de:0d79] type 00 class 0x0c0500
[    0.371178] pci 0000:00:03.2: reg 0x10: [io  0x2000-0x20ff]
[    0.371190] pci 0000:00:03.2: reg 0x14: [mem 0x93286000-0x93287fff]
[    0.371215] pci 0000:00:03.2: reg 0x20: [io  0x2240-0x227f]
[    0.371227] pci 0000:00:03.2: reg 0x24: [io  0x2200-0x223f]
[    0.371279] pci 0000:00:03.2: PME# supported from D3hot D3cold
[    0.371564] pci 0000:00:03.3: [10de:0d69] type 00 class 0x050000
[    0.372124] pci 0000:00:03.4: [10de:0d7a] type 00 class 0x0b4000
[    0.372161] pci 0000:00:03.4: reg 0x10: [mem 0x93200000-0x9327ffff]
[    0.372660] pci 0000:00:04.0: [10de:0d9c] type 00 class 0x0c0310
[    0.372679] pci 0000:00:04.0: reg 0x10: [mem 0x9328a000-0x9328afff]
[    0.372758] pci 0000:00:04.0: supports D1 D2
[    0.372762] pci 0000:00:04.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.373875] pci 0000:00:04.1: [10de:0d9d] type 00 class 0x0c0320
[    0.373895] pci 0000:00:04.1: reg 0x10: [mem 0x9328b100-0x9328b1ff]
[    0.373982] pci 0000:00:04.1: supports D1 D2
[    0.373986] pci 0000:00:04.1: PME# supported from D0 D1 D2 D3hot D3cold
[    0.375280] pci 0000:00:06.0: [10de:0d9c] type 00 class 0x0c0310
[    0.375301] pci 0000:00:06.0: reg 0x10: [mem 0x93289000-0x93289fff]
[    0.375381] pci 0000:00:06.0: supports D1 D2
[    0.375385] pci 0000:00:06.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.376462] pci 0000:00:06.1: [10de:0d9d] type 00 class 0x0c0320
[    0.376483] pci 0000:00:06.1: reg 0x10: [mem 0x9328b000-0x9328b0ff]
[    0.376570] pci 0000:00:06.1: supports D1 D2
[    0.376574] pci 0000:00:06.1: PME# supported from D0 D1 D2 D3hot D3cold
[    0.377851] pci 0000:00:08.0: [10de:0d94] type 00 class 0x040300
[    0.377870] pci 0000:00:08.0: reg 0x10: [mem 0x93280000-0x93283fff]
[    0.377947] pci 0000:00:08.0: PME# supported from D3hot D3cold
[    0.378564] pci 0000:00:0a.0: [10de:0d88] type 00 class 0x010601
[    0.378582] pci 0000:00:0a.0: reg 0x10: [io  0x2298-0x229f]
[    0.378593] pci 0000:00:0a.0: reg 0x14: [io  0x22a4-0x22a7]
[    0.378604] pci 0000:00:0a.0: reg 0x18: [io  0x2290-0x2297]
[    0.378614] pci 0000:00:0a.0: reg 0x1c: [io  0x22a0-0x22a3]
[    0.378624] pci 0000:00:0a.0: reg 0x20: [io  0x2280-0x228f]
[    0.378634] pci 0000:00:0a.0: reg 0x24: [mem 0x93284000-0x93285fff]
[    0.379684] pci 0000:00:0b.0: [10de:0d75] type 00 class 0x050000
[    0.379702] pci 0000:00:0b.0: reg 0x10: [mem 0x93288000-0x93288fff]
[    0.380212] pci 0000:00:15.0: [10de:0d9b] type 01 class 0x060400
[    0.380362] pci 0000:00:15.0: enabling Extended Tags
[    0.380557] pci 0000:00:15.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.381015] pci 0000:00:17.0: [10de:0d76] type 01 class 0x060400
[    0.381089] pci 0000:00:17.0: PME# supported from D0 D3hot D3cold
[    0.381505] pci 0000:01:00.0: [14e4:4353] type 00 class 0x028000
[    0.381540] pci 0000:01:00.0: reg 0x10: [mem 0x93100000-0x93103fff 64bit]
[    0.381611] pci 0000:01:00.0: enabling Extended Tags
[    0.381711] pci 0000:01:00.0: supports D1 D2
[    0.381714] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
[    0.381988] pci 0000:00:15.0: PCI bridge to [bus 01]
[    0.382016] pci 0000:00:15.0:   bridge window [mem 0x93100000-0x931fffff]
[    0.382060] pci_bus 0000:02: extended config space not accessible
[    0.382144] pci 0000:02:00.0: [10de:08a2] type 00 class 0x030000
[    0.382162] pci 0000:02:00.0: reg 0x10: [mem 0x92000000-0x92ffffff]
[    0.382176] pci 0000:02:00.0: reg 0x14: [mem 0x80000000-0x8fffffff 64bit pref]
[    0.382190] pci 0000:02:00.0: reg 0x1c: [mem 0x90000000-0x91ffffff 64bit pref]
[    0.382200] pci 0000:02:00.0: reg 0x24: [io  0x1000-0x107f]
[    0.382210] pci 0000:02:00.0: reg 0x30: [mem 0x93000000-0x9301ffff pref]
[    0.382231] pci 0000:02:00.0: Enabling HDA controller
[    0.382238] pci 0000:02:00.0: BAR 1: assigned to efifb
[    0.384256] pci 0000:00:17.0: PCI bridge to [bus 02]
[    0.384265] pci 0000:00:17.0:   bridge window [io  0x1000-0x1fff]
[    0.384272] pci 0000:00:17.0:   bridge window [mem 0x92000000-0x930fffff]
[    0.384279] pci 0000:00:17.0:   bridge window [mem 0x80000000-0x91ffffff 64bit pref]
[    0.385415] ACPI: PCI: Interrupt link LNK1 configured for IRQ 16
[    0.385767] ACPI: PCI: Interrupt link LNK2 configured for IRQ 17
[    0.386116] ACPI: PCI: Interrupt link LNK3 configured for IRQ 18
[    0.386465] ACPI: PCI: Interrupt link LNK4 configured for IRQ 19
[    0.386815] ACPI: PCI: Interrupt link Z00J configured for IRQ 21
[    0.387174] ACPI: PCI: Interrupt link Z00K configured for IRQ 21
[    0.387588] ACPI: PCI: Interrupt link Z00L configured for IRQ 21
[    0.387939] ACPI: PCI: Interrupt link Z00M configured for IRQ 21
[    0.388289] ACPI: PCI: Interrupt link LSMB configured for IRQ 22
[    0.388637] ACPI: PCI: Interrupt link LUS0 configured for IRQ 17
[    0.388986] ACPI: PCI: Interrupt link LUS2 configured for IRQ 17
[    0.389340] ACPI: PCI: Interrupt link LMAC configured for IRQ 17
[    0.389689] ACPI: PCI: Interrupt link LAZA configured for IRQ 20
[    0.390038] ACPI: PCI: Interrupt link LGPU configured for IRQ 16
[    0.390379] ACPI: PCI: Interrupt link LPID configured for IRQ 0
[    0.390383] ACPI: PCI: Interrupt link LPID disabled
[    0.390738] ACPI: PCI: Interrupt link LSI0 configured for IRQ 18
[    0.391085] ACPI: PCI: Interrupt link Z000 configured for IRQ 18
[    0.391433] ACPI: PCI: Interrupt link Z001 configured for IRQ 22
[    0.391772] ACPI: PCI: Interrupt link LPMU configured for IRQ 0
[    0.391777] ACPI: PCI: Interrupt link LPMU disabled
[    0.392415] ACPI: EC: interrupt unblocked
[    0.392419] ACPI: EC: event unblocked
[    0.392427] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.392430] ACPI: EC: GPE=0x57
[    0.392434] ACPI: \_SB_.PCI0.LPCB.EC__: Boot ECDT EC initialization complete
[    0.392439] ACPI: \_SB_.PCI0.LPCB.EC__: EC: Used to handle transactions and events
[    0.392602] iommu: Default domain type: Translated 
[    0.392606] iommu: DMA domain TLB invalidation policy: lazy mode 
[    0.393804] pci 0000:02:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
[    0.393804] pci 0000:02:00.0: vgaarb: bridge control possible
[    0.393808] pci 0000:02:00.0: vgaarb: setting as boot device
[    0.393811] vgaarb: loaded
[    0.394294] SCSI subsystem initialized
[    0.394316] libata version 3.00 loaded.
[    0.394316] ACPI: bus type USB registered
[    0.394316] usbcore: registered new interface driver usbfs
[    0.394316] usbcore: registered new interface driver hub
[    0.394316] usbcore: registered new device driver usb
[    0.394316] pps_core: LinuxPPS API ver. 1 registered
[    0.394316] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.394316] PTP clock support registered
[    0.394316] EDAC MC: Ver: 3.0.0
[    0.394316] Registered efivars operations
[    0.397417] NetLabel: Initializing
[    0.397420] NetLabel:  domain hash size = 128
[    0.397422] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.397465] NetLabel:  unlabeled traffic allowed by default
[    0.397477] PCI: Using ACPI for IRQ routing
[    0.397481] PCI: pci_cache_line_size set to 64 bytes
[    0.397607] e820: reserve RAM buffer [mem 0x0008f000-0x0008ffff]
[    0.397612] e820: reserve RAM buffer [mem 0x6d439018-0x6fffffff]
[    0.397616] e820: reserve RAM buffer [mem 0x6d43a018-0x6fffffff]
[    0.397619] e820: reserve RAM buffer [mem 0x6f000000-0x6fffffff]
[    0.397622] e820: reserve RAM buffer [mem 0x7f719000-0x7fffffff]
[    0.397627] e820: reserve RAM buffer [mem 0x7f954000-0x7fffffff]
[    0.397631] e820: reserve RAM buffer [mem 0x7f96e000-0x7fffffff]
[    0.397635] e820: reserve RAM buffer [mem 0x7f9b0000-0x7fffffff]
[    0.397639] e820: reserve RAM buffer [mem 0x7fef9000-0x7fffffff]
[    0.399507] hpet: 4 channels of 0 reserved for per-cpu timers
[    0.399507] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 31, 31
[    0.399507] hpet0: 4 comparators, 64-bit 25.000000 MHz counter
[    0.400448] clocksource: Switched to clocksource tsc-early
[    0.429312] VFS: Disk quotas dquot_6.6.0
[    0.429355] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.429516] pnp: PnP ACPI init
[    0.429839] system 00:00: [mem 0xf0000000-0xf3ffffff] has been reserved
[    0.430256] system 00:01: [mem 0xfed00000-0xfed003ff] has been reserved
[    0.430666] system 00:02: [io  0x0400-0x047f] has been reserved
[    0.430673] system 00:02: [io  0x0480-0x04ff] has been reserved
[    0.430678] system 00:02: [io  0x0500-0x057f] has been reserved
[    0.430683] system 00:02: [io  0x0580-0x05ff] has been reserved
[    0.430688] system 00:02: [io  0x0800-0x087f] has been reserved
[    0.430692] system 00:02: [io  0x0880-0x08ff] has been reserved
[    0.430698] system 00:02: [io  0x04d0-0x04d1] has been reserved
[    0.430706] system 00:02: [io  0x0295-0x0296] has been reserved
[    0.431955] pnp: PnP ACPI: found 4 devices
[    0.435653] pci 0000:02:00.0: assigning 36 device properties
[    0.435704] pci 0000:00:08.0: assigning 4 device properties
[    0.440259] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.440416] NET: Registered PF_INET protocol family
[    0.440578] IP idents hash table entries: 32768 (order: 6, 262144 bytes, linear)
[    0.442530] tcp_listen_portaddr_hash hash table entries: 1024 (order: 2, 16384 bytes, linear)
[    0.442606] TCP established hash table entries: 16384 (order: 5, 131072 bytes, linear)
[    0.442763] TCP bind hash table entries: 16384 (order: 6, 262144 bytes, linear)
[    0.442844] TCP: Hash tables configured (established 16384 bind 16384)
[    0.443014] MPTCP token hash table entries: 2048 (order: 3, 49152 bytes, linear)
[    0.443067] UDP hash table entries: 1024 (order: 3, 32768 bytes, linear)
[    0.443098] UDP-Lite hash table entries: 1024 (order: 3, 32768 bytes, linear)
[    0.443188] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.443203] NET: Registered PF_XDP protocol family
[    0.443247] pci 0000:00:15.0: PCI bridge to [bus 01]
[    0.443270] pci 0000:00:15.0:   bridge window [mem 0x93100000-0x931fffff]
[    0.443297] pci 0000:00:17.0: PCI bridge to [bus 02]
[    0.443302] pci 0000:00:17.0:   bridge window [io  0x1000-0x1fff]
[    0.443309] pci 0000:00:17.0:   bridge window [mem 0x92000000-0x930fffff]
[    0.443314] pci 0000:00:17.0:   bridge window [mem 0x80000000-0x91ffffff 64bit pref]
[    0.443323] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.443327] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.443332] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    0.443336] pci_bus 0000:00: resource 7 [mem 0x000c0000-0x000c3fff window]
[    0.443341] pci_bus 0000:00: resource 8 [mem 0x000c4000-0x000c7fff window]
[    0.443345] pci_bus 0000:00: resource 9 [mem 0x000c8000-0x000cbfff window]
[    0.443349] pci_bus 0000:00: resource 10 [mem 0x000cc000-0x000cffff window]
[    0.443354] pci_bus 0000:00: resource 11 [mem 0x000d0000-0x000d3fff window]
[    0.443358] pci_bus 0000:00: resource 12 [mem 0x000d4000-0x000d7fff window]
[    0.443362] pci_bus 0000:00: resource 13 [mem 0x000d8000-0x000dbfff window]
[    0.443366] pci_bus 0000:00: resource 14 [mem 0x000dc000-0x000dffff window]
[    0.443370] pci_bus 0000:00: resource 15 [mem 0x000e0000-0x000e3fff window]
[    0.443375] pci_bus 0000:00: resource 16 [mem 0x000e4000-0x000e7fff window]
[    0.443379] pci_bus 0000:00: resource 17 [mem 0x000e8000-0x000ebfff window]
[    0.443383] pci_bus 0000:00: resource 18 [mem 0x000ec000-0x000effff window]
[    0.443387] pci_bus 0000:00: resource 19 [mem 0x000f0000-0x000fffff window]
[    0.443392] pci_bus 0000:00: resource 20 [mem 0x80000000-0xfebfffff window]
[    0.443397] pci_bus 0000:01: resource 1 [mem 0x93100000-0x931fffff]
[    0.443402] pci_bus 0000:02: resource 0 [io  0x1000-0x1fff]
[    0.443406] pci_bus 0000:02: resource 1 [mem 0x92000000-0x930fffff]
[    0.443410] pci_bus 0000:02: resource 2 [mem 0x80000000-0x91ffffff 64bit pref]
[    0.444702] ACPI: \_SB_.PCI0.LUS0: Enabled at IRQ 23
[    0.445943] ACPI: \_SB_.PCI0.LUS2: Enabled at IRQ 23
[    0.447091] ACPI: \_SB_.PCI0.Z000: Enabled at IRQ 20
[    0.448274] ACPI: \_SB_.PCI0.Z001: Enabled at IRQ 19
[    0.448765] PCI: CLS 256 bytes, default 64
[    0.448935] Trying to unpack rootfs image as initramfs...
[    0.456350] Initialise system trusted keyrings
[    0.456381] Key type blacklist registered
[    0.457975] workingset: timestamp_bits=41 max_order=19 bucket_order=0
[    0.461957] zbud: loaded
[    0.487986] Key type asymmetric registered
[    0.487997] Asymmetric key parser 'x509' registered
[    0.488095] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 242)
[    0.491325] io scheduler mq-deadline registered
[    0.491331] io scheduler kyber registered
[    0.491450] io scheduler bfq registered
[    0.492812] ACPI: \_SB_.PCI0.Z00J: Enabled at IRQ 22
[    0.493329] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    0.493658] Monitor-Mwait will be used to enter C-1 state
[    0.493695] Monitor-Mwait will be used to enter C-2 state
[    0.493708] Monitor-Mwait will be used to enter C-3 state
[    0.493745] ACPI: \_PR_.CPU0: Found 3 idle states
[    0.494271] ACPI: AC: AC Adapter [ADP1] (on-line)
[    0.494405] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input0
[    0.503898] ACPI: button: Lid Switch [LID0]
[    0.504018] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input1
[    0.504078] ACPI: button: Power Button [PWRB]
[    0.504159] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input2
[    0.504205] ACPI: button: Sleep Button [SLPB]
[    0.504349] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input3
[    0.504423] ACPI: button: Power Button [PWRF]
[    0.505345] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    0.509791] Non-volatile memory driver v1.3
[    0.509797] Linux agpgart interface v0.103
[    0.509800] AMD-Vi: AMD IOMMUv2 driver by Joerg Roedel <jroedel@suse.de>
[    0.509803] AMD-Vi: AMD IOMMUv2 functionality not available on this system
[    0.510844] ahci 0000:00:0a.0: version 3.0
[    0.511757] ACPI: \_SB_.PCI0.LSI0: Enabled at IRQ 18
[    0.511914] ahci 0000:00:0a.0: AHCI 0001.0300 32 slots 1 ports 3 Gbps 0x1 impl SATA mode
[    0.511924] ahci 0000:00:0a.0: flags: 64bit ncq sntf pm led pio slum part apst 
[    0.512402] scsi host0: ahci
[    0.512576] ata1: SATA max UDMA/133 abar m8192@0x93284000 port 0x93284100 irq 25
[    0.512675] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.512690] ehci-pci: EHCI PCI platform driver
[    0.513096] ehci-pci 0000:00:04.1: EHCI Host Controller
[    0.513111] ehci-pci 0000:00:04.1: new USB bus registered, assigned bus number 1
[    0.513126] ehci-pci 0000:00:04.1: debug port 1
[    0.513169] ehci-pci 0000:00:04.1: disable ppcd for nvidia mcp89
[    0.513201] ehci-pci 0000:00:04.1: irq 23, io mem 0x9328b100
[    0.523846] ehci-pci 0000:00:04.1: USB 2.0 started, EHCI 1.10
[    0.524028] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.15
[    0.524035] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.524040] usb usb1: Product: EHCI Host Controller
[    0.524044] usb usb1: Manufacturer: Linux 5.15.2-arch1-1 ehci_hcd
[    0.524047] usb usb1: SerialNumber: 0000:00:04.1
[    0.524402] hub 1-0:1.0: USB hub found
[    0.524424] hub 1-0:1.0: 6 ports detected
[    0.525505] ehci-pci 0000:00:06.1: EHCI Host Controller
[    0.525519] ehci-pci 0000:00:06.1: new USB bus registered, assigned bus number 2
[    0.525535] ehci-pci 0000:00:06.1: debug port 1
[    0.525577] ehci-pci 0000:00:06.1: disable ppcd for nvidia mcp89
[    0.525616] ehci-pci 0000:00:06.1: irq 19, io mem 0x9328b000
[    0.537174] ehci-pci 0000:00:06.1: USB 2.0 started, EHCI 1.10
[    0.537333] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.15
[    0.537341] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.537345] usb usb2: Product: EHCI Host Controller
[    0.537349] usb usb2: Manufacturer: Linux 5.15.2-arch1-1 ehci_hcd
[    0.537353] usb usb2: SerialNumber: 0000:00:06.1
[    0.537675] hub 2-0:1.0: USB hub found
[    0.537696] hub 2-0:1.0: 6 ports detected
[    0.538355] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    0.538367] ohci-pci: OHCI PCI platform driver
[    0.538779] ohci-pci 0000:00:04.0: OHCI PCI host controller
[    0.538795] ohci-pci 0000:00:04.0: new USB bus registered, assigned bus number 3
[    0.538850] ohci-pci 0000:00:04.0: irq 23, io mem 0x9328a000
[    0.595973] usb usb3: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 5.15
[    0.595988] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.595993] usb usb3: Product: OHCI PCI host controller
[    0.595997] usb usb3: Manufacturer: Linux 5.15.2-arch1-1 ohci_hcd
[    0.596000] usb usb3: SerialNumber: 0000:00:04.0
[    0.596354] hub 3-0:1.0: USB hub found
[    0.596374] hub 3-0:1.0: 6 ports detected
[    0.597508] ohci-pci 0000:00:06.0: OHCI PCI host controller
[    0.597528] ohci-pci 0000:00:06.0: new USB bus registered, assigned bus number 4
[    0.597589] ohci-pci 0000:00:06.0: irq 20, io mem 0x93289000
[    0.607567] Freeing initrd memory: 12596K
[    0.631473] usb usb4: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 5.15
[    0.631485] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.631490] usb usb4: Product: OHCI PCI host controller
[    0.631494] usb usb4: Manufacturer: Linux 5.15.2-arch1-1 ohci_hcd
[    0.631498] usb usb4: SerialNumber: 0000:00:06.0
[    0.631832] hub 4-0:1.0: USB hub found
[    0.631859] hub 4-0:1.0: 6 ports detected
[    0.632500] uhci_hcd: USB Universal Host Controller Interface driver
[    0.632636] usbcore: registered new interface driver usbserial_generic
[    0.632649] usbserial: USB Serial support registered for generic
[    0.633046] rtc_cmos 00:03: RTC can wake from S4
[    0.633636] rtc_cmos 00:03: registered as rtc0
[    0.633729] rtc_cmos 00:03: setting system clock to 2001-01-01T04:30:03 UTC (978323403)
[    0.633768] rtc_cmos 00:03: alarms up to one year, y3k, 242 bytes nvram, hpet irqs
[    0.633940] intel_pstate: CPU model not supported
[    0.633987] ledtrig-cpu: registered to indicate activity on CPUs
[    0.634357] efifb: probing for efifb
[    0.634391] efifb: No BGRT, not showing boot graphics
[    0.634394] efifb: framebuffer at 0x80010000, using 6144k, total 6144k
[    0.634397] efifb: mode is 1366x768x32, linelength=8192, pages=1
[    0.634401] efifb: scrolling: redraw
[    0.634403] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    0.634507] fbcon: Deferring console take-over
[    0.634510] fb0: EFI VGA frame buffer device
[    0.634551] hid: raw HID events driver (C) Jiri Kosina
[    0.634733] drop_monitor: Initializing network drop monitor service
[    0.634884] Initializing XFRM netlink socket
[    0.634892] IPv6: Loaded, but administratively disabled, reboot required to enable
[    0.634896] NET: Registered PF_PACKET protocol family
[    0.635324] microcode: sig=0x1067a, pf=0x80, revision=0xa0b
[    0.635339] microcode: Microcode Update Driver: v2.2.
[    0.635348] IPI shorthand broadcast: enabled
[    0.635373] sched_clock: Marking stable (634463590, 678134)->(646882971, -11741247)
[    0.635671] registered taskstats version 1
[    0.635852] Loading compiled-in X.509 certificates
[    0.648208] Loaded X.509 cert 'Build time autogenerated kernel key: ac48247ae4b694dd45afa078318e6038d5aa91dc'
[    0.648601] zswap: loaded using pool lz4/z3fold
[    0.649033] Key type ._fscrypt registered
[    0.649038] Key type .fscrypt registered
[    0.649040] Key type fscrypt-provisioning registered
[    0.649783] PM:   Magic number: 1:939:513
[    0.650156] RAS: Correctable Errors collector initialized.
[    0.717187] usb 2-2: new high-speed USB device number 2 using ehci-pci
[    0.741848] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    0.807503] usb 2-2: New USB device found, idVendor=0411, idProduct=00a0, bcdDevice= 1.10
[    0.807516] usb 2-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    0.807521] usb 2-2: Product: USB Flash Disk
[    0.807525] usb 2-2: Manufacturer: BUFFALO
[    0.807529] usb 2-2: SerialNumber: 07980E08B2F10E23
[    0.874036] usb 3-1: new full-speed USB device number 2 using ohci-pci
[    0.930835] random: fast init done
[    0.930838] clocksource: timekeeping watchdog on CPU1: Marking clocksource 'tsc-early' as unstable because the skew is too large:
[    0.930845] clocksource:                       'hpet' wd_nsec: 506667400 wd_now: 1913bc9 wd_last: cff48c mask: ffffffff
[    0.930851] clocksource:                       'tsc-early' cs_nsec: 284910581 cs_now: 5b52e75f0 cs_last: 59d745a16 mask: ffffffffffffffff
[    0.930856] clocksource:                       'tsc-early' is current clocksource.
[    0.930869] tsc: Marking TSC unstable due to clocksource watchdog
[    0.930886] TSC found unstable after boot, most likely due to broken BIOS. Use 'tsc=unstable'.
[    0.930888] sched_clock: Marking unstable (930207429, 678134)<-(942626783, -11741247)
[    0.931144] clocksource: Switched to clocksource hpet
[    1.307381] usb 3-1: New USB device found, idVendor=04fe, idProduct=0008, bcdDevice= 1.02
[    1.307394] usb 3-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    1.307399] usb 3-1: Product: Generic USB Hub
[    1.307404] usb 3-1: Manufacturer: Chicony
[    1.310515] hub 3-1:1.0: USB hub found
[    1.313375] hub 3-1:1.0: 3 ports detected
[    1.623917] usb 3-1.1: new full-speed USB device number 3 using ohci-pci
[    1.740377] usb 3-1.1: New USB device found, idVendor=04fe, idProduct=0006, bcdDevice= 1.02
[    1.740390] usb 3-1.1: New USB device strings: Mfr=3, Product=4, SerialNumber=0
[    1.740395] usb 3-1.1: Product: PFU-65 USB Keyboard
[    1.740399] usb 3-1.1: Manufacturer: Chicony
[    1.927258] usb 3-5: new full-speed USB device number 4 using ohci-pci
[    2.166377] usb 3-5: New USB device found, idVendor=0a5c, idProduct=4500, bcdDevice= 1.00
[    2.166390] usb 3-5: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    2.166395] usb 3-5: Product: BRCM2070 Hub
[    2.166399] usb 3-5: Manufacturer: Apple Inc.
[    2.169491] hub 3-5:1.0: USB hub found
[    2.172374] hub 3-5:1.0: 3 ports detected
[    2.490594] usb 3-5.1: new full-speed USB device number 5 using ohci-pci
[    2.590596] usb 1-6: new high-speed USB device number 4 using ehci-pci
[    2.607293] usb 3-5.1: New USB device found, idVendor=05ac, idProduct=820a, bcdDevice= 1.00
[    2.607306] usb 3-5.1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    2.690591] usb 3-5.2: new full-speed USB device number 6 using ohci-pci
[    2.761600] usb 1-6: New USB device found, idVendor=05ac, idProduct=850a, bcdDevice= 6.25
[    2.761612] usb 1-6: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    2.761617] usb 1-6: Product: Built-in iSight
[    2.761621] usb 1-6: Manufacturer: Apple Inc.
[    2.761625] usb 1-6: SerialNumber: CCGA9SAZ4UDF9KF0
[    2.807300] usb 3-5.2: New USB device found, idVendor=05ac, idProduct=820b, bcdDevice= 1.00
[    2.807312] usb 3-5.2: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    2.890592] usb 3-5.3: new full-speed USB device number 7 using ohci-pci
[    3.017304] usb 3-5.3: New USB device found, idVendor=05ac, idProduct=821b, bcdDevice= 0.42
[    3.017317] usb 3-5.3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    3.017322] usb 3-5.3: Product: Bluetooth USB Host Controller
[    3.017326] usb 3-5.3: Manufacturer: Apple Inc.
[    5.950599] ata1.00: qc timeout (cmd 0xec)
[    5.950616] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[    6.260968] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   16.403925] ata1.00: qc timeout (cmd 0xec)
[   16.403940] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[   16.403947] ata1: limiting SATA link speed to 1.5 Gbps
[   16.714298] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   47.550603] ata1.00: qc timeout (cmd 0xec)
[   47.550620] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[   47.860955] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   47.864399] Freeing unused decrypted memory: 2036K
[   47.865556] Freeing unused kernel image (initmem) memory: 1832K
[   47.865651] Write protecting the kernel read-only data: 28672k
[   47.867568] Freeing unused kernel image (text/rodata gap) memory: 2036K
[   47.868760] Freeing unused kernel image (rodata/data gap) memory: 1516K
[   47.984641] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[   47.984653] rodata_test: all tests were successful
[   47.984693] x86/mm: Checking user space page tables
[   48.097099] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[   48.097162] Run /init as init process
[   48.097166]   with arguments:
[   48.097169]     /init
[   48.097172]   with environment:
[   48.097175]     HOME=/
[   48.097177]     TERM=linux
[   48.986214] fbcon: Taking over console
[   48.986557] Console: switching to colour frame buffer device 170x48
[   49.374948] usb-storage 2-2:1.0: USB Mass Storage device detected
[   49.375941] scsi host1: usb-storage 2-2:1.0
[   49.376315] usbcore: registered new interface driver usb-storage
[   49.381292] input: Chicony PFU-65 USB Keyboard as /devices/pci0000:00/0000:00:04.0/usb3/3-1/3-1.1/3-1.1:1.0/0003:04FE:0006.0001/input/input4
[   49.392300] usbcore: registered new interface driver uas
[   49.437571] hid-generic 0003:04FE:0006.0001: input,hidraw0: USB HID v1.00 Keyboard [Chicony PFU-65 USB Keyboard] on usb-0000:00:04.0-1.1/input0
[   49.444480] input: HID 05ac:820a as /devices/pci0000:00/0000:00:04.0/usb3/3-5/3-5.1/3-5.1:1.0/0003:05AC:820A.0002/input/input5
[   49.500873] hid-generic 0003:05AC:820A.0002: input,hidraw1: USB HID v1.11 Keyboard [HID 05ac:820a] on usb-0000:00:04.0-5.1/input0
[   49.507257] input: HID 05ac:820b as /devices/pci0000:00/0000:00:04.0/usb3/3-5/3-5.2/3-5.2:1.0/0003:05AC:820B.0003/input/input6
[   49.507469] hid-generic 0003:05AC:820B.0003: input,hidraw2: USB HID v1.11 Mouse [HID 05ac:820b] on usb-0000:00:04.0-5.2/input0
[   49.507569] usbcore: registered new interface driver usbhid
[   49.507573] usbhid: USB HID core driver

--=-=-=
Content-Type: multipart/signed; boundary="==-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"

--==-=-=
Content-Type: text/plain


--==-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJKBAEBCAA0FiEETYVHHTrlVWkmzOhy22IiAuK1hSMFAmGTp7sWHGNvbnRhY3RA
eXVqaW5ha2FvLmNvbQAKCRDbYiIC4rWFIzAVD/95szjHRRcRaHXPrRXjROB0Sgd/
Op3ysyjMSITyB8EXcZL17CswsMxvhJvep6XqFdI61Wr9tYdyMZae1vyX/6EBrIRh
5ysjHaJbNFDH7SWJ18uA8iDSK4NAJ50ND5/AKyn4BKtLanPenvI/4EcPfOv5BAKF
TiQXCtaUKigtKRFID3BzpxvslZso/4DrTDjdpqQ04Aj6KfxdGOvHaC6Ryl/lvsO+
ZeTKeo50TJDK1h+OMaS+6TIZRcz8L4B7f6yswhWCIZ3i4wfwKhFX0Qa9d4lQPdoh
2PgK5ZkSnjqENUfML1gi9nqbXzbd5E69SsIovXr7yVoElTH3tLvXY5Y7BG8FbzS+
j4qUGhKe6/Qi8EFsG1eD6os/GpwxkqqQHJDkWUItz7DfuVWou/iLY+hF+0gljm9f
9CDU54A5VynpMSxZ462sCQxC1bdQSWJ/i3jvQ+0Ajhzy03cwVChFREFUyyP/owVD
YBzd/FxHnnfCT6wvbaZjPCmzhWnY5YUGdsg6fuaIiT3uaU68jpsJvTeg9mjmaWYm
n6eJfaUucAvgPFaj+K90e7DmB6rzezQJsa8KnUkK3NflCNB3TxTeFEt1iP9/Dt1/
0uL452uDrL+8sKhkaSsAqNTUXOFE+KUUFKvgAyXCH8Morq5aPnTgPewGcOlaURoR
Y8Trc5jgEu9JEo0V5A==
=Gpnd
-----END PGP SIGNATURE-----
--==-=-=--

--=-=-=--
