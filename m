Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6FE236618D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 23:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234114AbhDTV0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 17:26:34 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58096 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233769AbhDTV0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 17:26:32 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <dann.frazier@canonical.com>)
        id 1lYxsd-0005yH-7q
        for linux-kernel@vger.kernel.org; Tue, 20 Apr 2021 21:25:59 +0000
Received: by mail-io1-f69.google.com with SMTP id y20-20020a6bd8140000b02903e6787c4986so8433037iob.23
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 14:25:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TEs0nic3x/FyVzr1EyD4XfahrtgnZRTpGNn4KI+XeKY=;
        b=hwjBccFQVFtTUXA5VEZShsIy06kBz4HHvqfU0em+WXj1uNJAYGQCq2CwWNJfZVnVOF
         CYQPoEW2o0zngUL5PHpV4tp1KIbefFyZkBSzIkE6kSxTwGPHF0yPVVmgfmzrijvy0lGl
         8ACcLqwaaFwLx80S14+Bq+shJBTUjtTLiLAS/ldMBmzkwvokh4C6RTYoVFixeqAUD4iP
         AOXCGl2W+p+iDk+w+TmAgQ52r3ib3uGlxCkKDpC+dqTi6nX634jjav7OOqxOmvpxJyHl
         JBc+hcqs7g7+xj+cYr5Yc9jzuSUMUD++MO3jIdquO/vgZL6eXVjdCOkuL9XPsp+fWxrG
         FEzA==
X-Gm-Message-State: AOAM532DCHACv30C7TW0qD3f0pxkiufOTlfkhzBoDQk5z1WW7NB5gHJc
        qYzN8nIWs8Rr+1q3ybytD1+UVMPGdzz7hkCnJFROxHvMduCqGuPwSZ+fsnCV2DG2DxohoAkC7l4
        T/nN3rth+JrxKCUaXRvYBKtzl86blGamrEsLbqqtnjg==
X-Received: by 2002:a5e:990e:: with SMTP id t14mr7249631ioj.107.1618953955711;
        Tue, 20 Apr 2021 14:25:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxvgbisAuLnT2wkyd5lJD676Bwkghtl9JPPG7OwHkNB66CKy1tmpugal7bZdwaxshptglCSmA==
X-Received: by 2002:a5e:990e:: with SMTP id t14mr7249595ioj.107.1618953954956;
        Tue, 20 Apr 2021 14:25:54 -0700 (PDT)
Received: from xps13.dannf (c-71-56-235-36.hsd1.co.comcast.net. [71.56.235.36])
        by smtp.gmail.com with ESMTPSA id o6sm16993ioa.21.2021.04.20.14.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 14:25:54 -0700 (PDT)
Date:   Tue, 20 Apr 2021 15:25:51 -0600
From:   dann frazier <dann.frazier@canonical.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>, kernel-team@android.com,
        Russell King <linux@arm.linux.org.uk>,
        Jason Cooper <jason@lakedaemon.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH 08/11] irqchip/gic: Configure SGIs as standard interrupts
Message-ID: <YH9G3+aDUWpcLCpD@xps13.dannf>
References: <20200519161755.209565-1-maz@kernel.org>
 <20200519161755.209565-9-maz@kernel.org>
 <YH87dtTfwYgavusz@xps13.dannf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YH87dtTfwYgavusz@xps13.dannf>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2021 at 02:37:10PM -0600, dann frazier wrote:
> On Tue, May 19, 2020 at 05:17:52PM +0100, Marc Zyngier wrote:
> > Change the way we deal with GIC SGIs by turning them into proper
> > IRQs, and calling into the arch code to register the interrupt range
> > instead of a callback.
> > 
> > Signed-off-by: Marc Zyngier <maz@kernel.org>
> 
> hey Marc,
> 
>   I bisected a boot failure on our Gigabyte R120-T33 systems (ThunderX
> CN88XX) down to this commit, but only when running in ACPI mode. See below:
> 
> 
> EFI stub: Booting Linux Kernel...
> EFI stub: EFI_RNG_PROTOCOL unavailable, KASLR will be disabled
> EFI stub: Using DTB from configuration table
> EFI stub: Exiting boot services and installing virtual address map...
> [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x431f0a11]
> [    0.000000] Linux version 5.11.0-13-generic (buildd@bos02-arm64-067) (gcc (Ubuntu 10.2.1-23ubuntu1) 10.2.1 20210312, GNU ld (GNU Binutils for Ubuntu) 2.36.1) #14-Ubuntu SMP Fri Mar 19 16:57:35 UTC 2021 (Ubuntu 5.11.0-13.14-generic 5.11.7)

Sorry, realized I posted a log from an Ubuntu kernel. Here's an
upstream one:

EFI stub: Booting Linux Kernel...
EFI stub: EFI_RNG_PROTOCOL unavailable
EFI stub: Using DTB from configuration table
EFI stub: Exiting boot services and installing virtual address map...
[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x431f0a11]
[    0.000000] Linux version 5.12.0-rc8 (ubuntu@seidel) (gcc (Ubuntu 10.3.0-1ubuntu1) 10.3.0, GNU ld (GNU Binutils for Ubuntu) 2.36.1) #19 SMP Tue Apr 20 21:09:04 UTC 2021
[    0.000000] Machine model: Cavium ThunderX CN88XX board
[    0.000000] efi: EFI v2.40 by American Megatrends
[    0.000000] efi: ESRT=0xffce0ff18 SMBIOS 3.0=0xfffb0000 ACPI 2.0=0xffec60000 MEMRESERVE=0xffc889d98 
[    0.000000] esrt: Reserving ESRT space from 0x0000000ffce0ff18 to 0x0000000ffce0ff50.
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x0000000FFEC60000 000024 (v02 ALASKA)
[    0.000000] ACPI: XSDT 0x0000000FFEC60028 00008C (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: FACP 0x0000000FFEC600B8 000114 (v06 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: DSDT 0x0000000FFEC601D0 00220B (v02 CAVIUM THUNDERX 00000001 INTL 20130517)
[    0.000000] ACPI: SPMI 0x0000000FFEC623E0 000041 (v05 ALASKA A M I    00000000 AMI. 00000000)
[    0.000000] ACPI: FIDT 0x0000000FFEC62428 00009C (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: APIC 0x0000000FFEC624C8 000F68 (v03 CAVIUM THUNDERX 00000001 INTL 20150619)
[    0.000000] ACPI: DBG2 0x0000000FFEC63430 000067 (v01 CAVIUM CN88XDBG 00000000 INTL 20150619)
[    0.000000] ACPI: GTDT 0x0000000FFEC63498 0000E0 (v02 CAVIUM THUNDERX 00000001 INTL 20150619)
[    0.000000] ACPI: IORT 0x0000000FFEC63578 0013D4 (v01 CAVIUM THUNDERX 00000001 INTL 20150619)
[    0.000000] ACPI: MCFG 0x0000000FFEC64950 00006C (v01 CAVIUM THUNDERX 00000001 INTL 20150619)
[    0.000000] ACPI: SSDT 0x0000000FFEC649C0 00089C (v02 CAVIUM NETWORK  00000001 INTL 20150619)
[    0.000000] ACPI: OEM1 0x0000000FFEC65260 0001E8 (v02 CAVIUM THUNDERX 00000001 INTL 20150619)
[    0.000000] ACPI: SLIT 0x0000000FFEC65448 000030 (v01 CAVIUM TEMPLATE 00000001 INTL 20150619)
[    0.000000] ACPI: SPCR 0x0000000FFEC65478 000050 (v02 A M I  APTIO V  01072009 AMI. 0005000B)
[    0.000000] ACPI: BGRT 0x0000000FFEC654C8 000038 (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: SPCR: console: pl011,mmio32,0x87e024000000,115200
[    0.000000] efi_bgrt: Ignoring BGRT: Incorrect BMP magic number 0x3707 (expected 0x4d42)
[    0.000000] NUMA: Failed to initialise from firmware
[    0.000000] NUMA: Faking a node at [mem 0x0000000000500000-0x0000000fff0fffff]
[    0.000000] NUMA: NODE_DATA [mem 0xff677c480-0xff6780fff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000500000-0x00000000ffffffff]
[    0.000000]   DMA32    empty
[    0.000000]   Normal   [mem 0x0000000100000000-0x0000000fff0fffff]
[    0.000000]   Device   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000500000-0x0000000000dfffff]
[    0.000000]   node   0: [mem 0x0000000000e00000-0x000000000fffffff]
[    0.000000]   node   0: [mem 0x0000000010000000-0x00000000102fffff]
[    0.000000]   node   0: [mem 0x0000000010300000-0x00000000fff9ffff]
[    0.000000]   node   0: [mem 0x00000000fffa0000-0x00000000ffffffff]
[    0.000000]   node   0: [mem 0x0000000100000000-0x0000000fee6affff]
[    0.000000]   node   0: [mem 0x0000000fee6b0000-0x0000000fee6cffff]
[    0.000000]   node   0: [mem 0x0000000fee6d0000-0x0000000ffac2ffff]
[    0.000000]   node   0: [mem 0x0000000ffac30000-0x0000000ffb0affff]
[    0.000000]   node   0: [mem 0x0000000ffb0b0000-0x0000000ffc8bffff]
[    0.000000]   node   0: [mem 0x0000000ffc8c0000-0x0000000ffc91ffff]
[    0.000000]   node   0: [mem 0x0000000ffc920000-0x0000000ffca3ffff]
[    0.000000]   node   0: [mem 0x0000000ffca40000-0x0000000ffca4ffff]
[    0.000000]   node   0: [mem 0x0000000ffca50000-0x0000000ffcdbffff]
[    0.000000]   node   0: [mem 0x0000000ffcdc0000-0x0000000ffd12ffff]
[    0.000000]   node   0: [mem 0x0000000ffd130000-0x0000000ffec2ffff]
[    0.000000]   node   0: [mem 0x0000000ffec30000-0x0000000ffec5ffff]
[    0.000000]   node   0: [mem 0x0000000ffec60000-0x0000000ffec6ffff]
[    0.000000]   node   0: [mem 0x0000000ffec70000-0x0000000ffed1ffff]
[    0.000000]   node   0: [mem 0x0000000ffed20000-0x0000000fff0fffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000500000-0x0000000fff0fffff]
[    0.000000]   Normal zone: 256 pages in unavailable ranges
[    0.000000] cma: Reserved 32 MiB at 0x00000000fdc00000
[    0.000000] psci: probing for conduit method from ACPI.
[    0.000000] psci: PSCIv0.2 detected in firmware.
[    0.000000] psci: Using standard PSCI v0.2 function IDs
[    0.000000] psci: Trusted OS resident on physical CPU 0x0
[    0.000000] ACPI: SRAT not present
[    0.000000] percpu: Embedded 33 pages/cpu s98072 r8192 d28904 u135168
[    0.000000] Detected VIPT I-cache on CPU0
[    0.000000] CPU features: detected: GIC system register CPU interface
[    0.000000] CPU features: detected: Software prefetching using PRFM
[    0.000000] CPU features: detected: Cavium erratum 27456
[    0.000000] CPU features: detected: Cavium erratum 30115
[    0.000000] CPU features: kernel page table isolation forced OFF by ARM64_WORKAROUND_CAVIUM_27456
[    0.000000] CPU features: detected: Spectre-v2
[    0.000000] CPU features: detected: Spectre-v4
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 16510032
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-dannf root=UUID=76e81d96-78e4-4432-a490-bb852f6111e8 ro sysrq_always_enabled acpi=force
[    0.000000] sysrq: sysrq always enabled.
[    0.000000] printk: log_buf_len individual max cpu contribution: 4096 bytes
[    0.000000] printk: log_buf_len total cpu_extra contributions: 192512 bytes
[    0.000000] printk: log_buf_len min size: 262144 bytes
[    0.000000] printk: log_buf_len: 524288 bytes
[    0.000000] printk: early log buf free: 255872(97%)
[    0.000000] Dentry cache hash table entries: 8388608 (order: 14, 67108864 bytes, linear)
[    0.000000] Inode-cache hash table entries: 4194304 (order: 13, 33554432 bytes, linear)
[    0.000000] mem auto-init: stack:off, heap alloc:on, heap free:off
[    0.000000] software IO TLB: mapped [mem 0x00000000f9c00000-0x00000000fdc00000] (64MB)
[    0.000000] Memory: 65572072K/67088384K available (15616K kernel code, 3626K rwdata, 11808K rodata, 7616K init, 1157K bss, 1483544K reserved, 32768K cma-reserved)
[    0.000000] random: get_random_u64 called from __kmem_cache_create+0x38/0x5b4 with crng_init=0
[    0.000000] SLUB: HWalign=128, Order=0-3, MinObjects=0, CPUs=48, Nodes=1
[    0.000000] ftrace: allocating 49728 entries in 195 pages
[    0.000000] ftrace: allocated 195 pages with 4 groups
[    0.000000] rcu: Hierarchical RCU implementation.
[    0.000000] rcu:     RCU restricting CPUs from NR_CPUS=256 to nr_cpu_ids=48.
[    0.000000]  Rude variant of Tasks RCU enabled.
[    0.000000]  Tracing variant of Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=48
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] GICv3: GIC: Using split EOI/Deactivate mode
[    0.000000] GIC: enabling workaround for GICv3: Cavium erratum 38539
[    0.000000] GICv3: 128 SPIs implemented
[    0.000000] GICv3: 0 Extended SPIs implemented
[    0.000000] GICv3: Distributor has no Range Selector support
[    0.000000] GICv3: 16 PPIs implemented
[    0.000000] GICv3: CPU0: found redistributor 0 region 0:0x0000801080000000
[    0.000000] ACPI: SRAT not present
[    0.000000] ITS [mem 0x801000020000-0x80100003ffff]
[    0.000000] ITS@0x0000801000020000: Devices Table too large, reduce ids 21->19
[    0.000000] ITS@0x0000801000020000: allocated 524288 Devices @100800000 (flat, esz 8, psz 64K, shr 1)
[    0.000000] GICv3: using LPI property table @0x0000000100270000
[    0.000000] GICv3: CPU0: using allocated LPI pending table @0x0000000100280000
[    0.000000] arch_timer: Failed to initialize memory-mapped timer.
[    0.000000] arch_timer: cp15 timer(s) running at 100.00MHz (phys).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x171024e7e0, max_idle_ns: 440795205315 ns
[    0.000000] sched_clock: 56 bits at 100MHz, resolution 10ns, wraps every 4398046511100ns
[    0.000149] Console: colour dummy device 80x25
[    0.000230] ACPI: Core revision 20210105
[    0.000451] Calibrating delay loop (skipped), value calculated using timer frequency.. 200.00 BogoMIPS (lpj=400000)
[    0.000462] pid_max: default: 49152 minimum: 384
[    0.000575] LSM: Security Framework initializing
[    0.000590] Yama: becoming mindful.
[    0.000648] AppArmor: AppArmor initialized
[    0.000801] Mount-cache hash table entries: 131072 (order: 8, 1048576 bytes, linear)
[    0.000866] Mountpoint-cache hash table entries: 131072 (order: 8, 1048576 bytes, linear)
[    0.001656] ACPI PPTT: No PPTT table found, CPU and cache topology may be inaccurate
[    0.002242] rcu: Hierarchical SRCU implementation.
[    0.002993] Platform MSI: ITS@0x801000020000 domain created
[    0.003007] PCI/MSI: ITS@0x801000020000 domain created
[    0.003019] fsl-mc MSI: ITS@0x801000020000 domain created
[    0.003036] Remapping and enabling EFI services.
[    0.005145] smp: Bringing up secondary CPUs ...
[    0.005629] Detected VIPT I-cache on CPU1
[    0.005644] GICv3: CPU1: found redistributor 1 region 0:0x0000801080020000
[    0.005669] GICv3: CPU1: using allocated LPI pending table @0x0000000100290000
[    0.005690] CPU1: Booted secondary processor 0x0000000001 [0x431f0a11]
[    0.006245] Detected VIPT I-cache on CPU2
[    0.006255] GICv3: CPU2: found redistributor 2 region 0:0x0000801080040000
[    0.006279] GICv3: CPU2: using allocated LPI pending table @0x00000001002a0000
[    0.006298] CPU2: Booted secondary processor 0x0000000002 [0x431f0a11]
[    0.006840] Detected VIPT I-cache on CPU3
[    0.006851] GICv3: CPU3: found redistributor 3 region 0:0x0000801080060000
[    0.006876] GICv3: CPU3: using allocated LPI pending table @0x00000001002b0000
[    0.006896] CPU3: Booted secondary processor 0x0000000003 [0x431f0a11]
[    0.007435] Detected VIPT I-cache on CPU4
[    0.007446] GICv3: CPU4: found redistributor 4 region 0:0x0000801080080000
[    0.007470] GICv3: CPU4: using allocated LPI pending table @0x00000001002c0000
[    0.007490] CPU4: Booted secondary processor 0x0000000004 [0x431f0a11]
[    0.008034] Detected VIPT I-cache on CPU5
[    0.008045] GICv3: CPU5: found redistributor 5 region 0:0x00008010800a0000
[    0.008069] GICv3: CPU5: using allocated LPI pending table @0x00000001002d0000
[    0.008089] CPU5: Booted secondary processor 0x0000000005 [0x431f0a11]
[    0.008626] Detected VIPT I-cache on CPU6
[    0.008637] GICv3: CPU6: found redistributor 6 region 0:0x00008010800c0000
[    0.008664] GICv3: CPU6: using allocated LPI pending table @0x00000001002e0000
[    0.008685] CPU6: Booted secondary processor 0x0000000006 [0x431f0a11]
[    0.009228] Detected VIPT I-cache on CPU7
[    0.009239] GICv3: CPU7: found redistributor 7 region 0:0x00008010800e0000
[    0.009265] GICv3: CPU7: using allocated LPI pending table @0x00000001002f0000
[    0.009286] CPU7: Booted secondary processor 0x0000000007 [0x431f0a11]
[    0.009825] Detected VIPT I-cache on CPU8
[    0.009837] GICv3: CPU8: found redistributor 8 region 0:0x0000801080100000
[    0.009862] GICv3: CPU8: using allocated LPI pending table @0x0000000100300000
[    0.009883] CPU8: Booted secondary processor 0x0000000008 [0x431f0a11]
[    0.010436] Detected VIPT I-cache on CPU9
[    0.010447] GICv3: CPU9: found redistributor 9 region 0:0x0000801080120000
[    0.010473] GICv3: CPU9: using allocated LPI pending table @0x0000000100310000
[    0.010494] CPU9: Booted secondary processor 0x0000000009 [0x431f0a11]
[    0.011040] Detected VIPT I-cache on CPU10
[    0.011052] GICv3: CPU10: found redistributor a region 0:0x0000801080140000
[    0.011078] GICv3: CPU10: using allocated LPI pending table @0x0000000100320000
[    0.011099] CPU10: Booted secondary processor 0x000000000a [0x431f0a11]
[    0.011647] Detected VIPT I-cache on CPU11
[    0.011659] GICv3: CPU11: found redistributor b region 0:0x0000801080160000
[    0.011686] GICv3: CPU11: using allocated LPI pending table @0x0000000100330000
[    0.011707] CPU11: Booted secondary processor 0x000000000b [0x431f0a11]
[    0.012266] Detected VIPT I-cache on CPU12
[    0.012278] GICv3: CPU12: found redistributor c region 0:0x0000801080180000
[    0.012304] GICv3: CPU12: using allocated LPI pending table @0x0000000100340000
[    0.012326] CPU12: Booted secondary processor 0x000000000c [0x431f0a11]
[    0.012889] Detected VIPT I-cache on CPU13
[    0.012901] GICv3: CPU13: found redistributor d region 0:0x00008010801a0000
[    0.012928] GICv3: CPU13: using allocated LPI pending table @0x0000000100350000
[    0.012950] CPU13: Booted secondary processor 0x000000000d [0x431f0a11]
[    0.013498] Detected VIPT I-cache on CPU14
[    0.013511] GICv3: CPU14: found redistributor e region 0:0x00008010801c0000
[    0.013537] GICv3: CPU14: using allocated LPI pending table @0x0000000100360000
[    0.013560] CPU14: Booted secondary processor 0x000000000e [0x431f0a11]
[    0.014110] Detected VIPT I-cache on CPU15
[    0.014124] GICv3: CPU15: found redistributor f region 0:0x00008010801e0000
[    0.014152] GICv3: CPU15: using allocated LPI pending table @0x0000000100370000
[    0.014175] CPU15: Booted secondary processor 0x000000000f [0x431f0a11]
[    0.014719] Detected VIPT I-cache on CPU16
[    0.014732] GICv3: CPU16: found redistributor 100 region 0:0x0000801080200000
[    0.014759] GICv3: CPU16: using allocated LPI pending table @0x0000000100380000
[    0.014782] CPU16: Booted secondary processor 0x0000000100 [0x431f0a11]
[    0.015323] Detected VIPT I-cache on CPU17
[    0.015337] GICv3: CPU17: found redistributor 101 region 0:0x0000801080220000
[    0.015363] GICv3: CPU17: using allocated LPI pending table @0x0000000100390000
[    0.015386] CPU17: Booted secondary processor 0x0000000101 [0x431f0a11]
[    0.015955] Detected VIPT I-cache on CPU18
[    0.015969] GICv3: CPU18: found redistributor 102 region 0:0x0000801080240000
[    0.015996] GICv3: CPU18: using allocated LPI pending table @0x00000001003a0000
[    0.016019] CPU18: Booted secondary processor 0x0000000102 [0x431f0a11]
[    0.016582] Detected VIPT I-cache on CPU19
[    0.016595] GICv3: CPU19: found redistributor 103 region 0:0x0000801080260000
[    0.016623] GICv3: CPU19: using allocated LPI pending table @0x00000001003b0000
[    0.016647] CPU19: Booted secondary processor 0x0000000103 [0x431f0a11]
[   0.017266] CPU20: Booted secondary processor 0x0000000104 [0x431f0a11]
[    0.017811] Detected VIPT I-cache on CPU21
[    0.017826] GICv3: CPU21: found redistributor 105 region 0:0x00008010802a0000
[    0.017853] GICv3: CPU21: using allocated LPI pending table @0x00000001003d0000
[    0.017877] CPU21: Booted secondary processor 0x0000000105 [0x431f0a11]
[    0.018439] Detected VIPT I-cache on CPU22
[    0.018453] GICv3: CPU22: found redistributor 106 region 0:0x00008010802c0000
[    0.018481] GICv3: CPU22: using allocated LPI pending table @0x00000001003e0000
[    0.018505] CPU22: Booted secondary processor 0x0000000106 [0x431f0a11]
[    0.019068] Detected VIPT I-cache on CPU23
[    0.019083] GICv3: CPU23: found redistributor 107 region 0:0x00008010802e0000
[    0.019111] GICv3: CPU23: using allocated LPI pending table @0x00000001003f0000
[    0.019135] CPU23: Booted secondary processor 0x0000000107 [0x431f0a11]
[    0.019684] Detected VIPT I-cache on CPU24
[    0.019698] GICv3: CPU24: found redistributor 108 region 0:0x0000801080300000
[    0.019726] GICv3: CPU24: using allocated LPI pending table @0x0000000100c00000
[    0.019751] CPU24: Booted secondary processor 0x0000000108 [0x431f0a11]
[    0.020328] Detected VIPT I-cache on CPU25
[    0.020343] GICv3: CPU25: found redistributor 109 region 0:0x0000801080320000
[    0.020372] GICv3: CPU25: using allocated LPI pending table @0x0000000100c10000
[    0.020396] CPU25: Booted secondary processor 0x0000000109 [0x431f0a11]
[    0.020948] Detected VIPT I-cache on CPU26
[    0.020963] GICv3: CPU26: found redistributor 10a region 0:0x0000801080340000
[    0.020992] GICv3: CPU26: using allocated LPI pending table @0x0000000100c20000
[    0.021017] CPU26: Booted secondary processor 0x000000010a [0x431f0a11]
[    0.021585] Detected VIPT I-cache on CPU27
[    0.021601] GICv3: CPU27: found redistributor 10b region 0:0x0000801080360000
[    0.021629] GICv3: CPU27: using allocated LPI pending table @0x0000000100c30000
[    0.021655] CPU27: Booted secondary processor 0x000000010b [0x431f0a11]
[    0.022205] Detected VIPT I-cache on CPU28
[    0.022220] GICv3: CPU28: found redistributor 10c region 0:0x0000801080380000
[    0.022248] GICv3: CPU28: using allocated LPI pending table @0x0000000100c40000
[    0.022274] CPU28: Booted secondary processor 0x000000010c [0x431f0a11]
[    0.022835] Detected VIPT I-cache on CPU29
[    0.022851] GICv3: CPU29: found redistributor 10d region 0:0x00008010803a0000
[    0.022880] GICv3: CPU29: using allocated LPI pending table @0x0000000100c50000
[    0.022906] CPU29: Booted secondary processor 0x000000010d [0x431f0a11]
[    0.023469] Detected VIPT I-cache on CPU30
[    0.023484] GICv3: CPU30: found redistributor 10e region 0:0x00008010803c0000
[    0.023513] GICv3: CPU30: using allocated LPI pending table @0x0000000100c60000
[    0.023539] CPU30: Booted secondary processor 0x000000010e [0x431f0a11]
[    0.024102] Detected VIPT I-cache on CPU31
[    0.024118] GICv3: CPU31: found redistributor 10f region 0:0x00008010803e0000
[    0.024147] GICv3: CPU31: using allocated LPI pending table @0x0000000100c70000
[    0.024174] CPU31: Booted secondary processor 0x000000010f [0x431f0a11]
[    0.024748] Detected VIPT I-cache on CPU32
[    0.024764] GICv3: CPU32: found redistributor 200 region 0:0x0000801080400000
[    0.024793] GICv3: CPU32: using allocated LPI pending table @0x0000000100c80000
[    0.024820] CPU32: Booted secondary processor 0x0000000200 [0x431f0a11]
[    0.025388] Detected VIPT I-cache on CPU33
[    0.025405] GICv3: CPU33: found redistributor 201 region 0:0x0000801080420000
[    0.025434] GICv3: CPU33: using allocated LPI pending table @0x0000000100c90000
[    0.025461] CPU33: Booted secondary processor 0x0000000201 [0x431f0a11]
[    0.026028] Detected VIPT I-cache on CPU34
[    0.026044] GICv3: CPU34: found redistributor 202 region 0:0x0000801080440000
[    0.026074] GICv3: CPU34: using allocated LPI pending table @0x0000000100ca0000
[    0.026101] CPU34: Booted secondary processor 0x0000000202 [0x431f0a11]
[    0.026670] Detected VIPT I-cache on CPU35
[    0.026687] GICv3: CPU35: found redistributor 203 region 0:0x0000801080460000
[    0.026716] GICv3: CPU35: using allocated LPI pending table @0x0000000100cb0000
[    0.026744] CPU35: Booted secondary processor 0x0000000203 [0x431f0a11]
[    0.027305] Detected VIPT I-cache on CPU36
[    0.027322] GICv3: CPU36: found redistributor 204 region 0:0x0000801080480000
[    0.027352] GICv3: CPU36: using allocated LPI pending table @0x0000000100cc0000
[    0.027380] CPU36: Booted secondary processor 0x0000000204 [0x431f0a11]
[    0.027942] Detected VIPT I-cache on CPU37
[    0.027959] GICv3: CPU37: found redistributor 205 region 0:0x00008010804a0000
[    0.027989] GICv3: CPU37: using allocated LPI pending table @0x0000000100cd0000
[    0.028018] CPU37: Booted secondary processor 0x0000000205 [0x431f0a11]
[    0.028597] Detected VIPT I-cache on CPU38
[    0.028614] GICv3: CPU38: found redistributor 206 region 0:0x00008010804c0000
[    0.028644] GICv3: CPU38: using allocated LPI pending table @0x0000000100ce0000
[    0.028672] CPU38: Booted secondary processor 0x0000000206 [0x431f0a11]
[    0.029233] Detected VIPT I-cache on CPU39
[    0.029251] GICv3: CPU39: found redistributor 207 region 0:0x00008010804e0000
[    0.029282] GICv3: CPU39: using allocated LPI pending table @0x0000000100cf0000
[    0.029310] CPU39: Booted secondary processor 0x0000000207 [0x431f0a11]
[    0.029885] Detected VIPT I-cache on CPU40
[    0.029902] GICv3: CPU40: found redistributor 208 region 0:0x0000801080500000
[    0.029932] GICv3: CPU40: using allocated LPI pending table @0x0000000100d00000
[    0.029961] CPU40: Booted secondary processor 0x0000000208 [0x431f0a11]
[    0.030544] Detected VIPT I-cache on CPU41
[    0.030562] GICv3: CPU41: found redistributor 209 region 0:0x0000801080520000
[    0.030592] GICv3: CPU41: using allocated LPI pending table @0x0000000100d10000
[    0.030622] CPU41: Booted secondary processor 0x0000000209 [0x431f0a11]
[    0.031188] Detected VIPT I-cache on CPU42
[    0.031205] GICv3: CPU42: found redistributor 20a region 0:0x0000801080540000
[    0.031236] GICv3: CPU42: using allocated LPI pending table @0x0000000100d20000
[    0.031266] CPU42: Booted secondary processor 0x000000020a [0x431f0a11]
[    0.031845] Detected VIPT I-cache on CPU43
[    0.031863] GICv3: CPU43: found redistributor 20b region 0:0x0000801080560000
[    0.031896] GICv3: CPU43: using allocated LPI pending table @0x0000000100d30000
[    0.031925] CPU43: Booted secondary processor 0x000000020b [0x431f0a11]
[    0.032520] Detected VIPT I-cache on CPU44
[    0.032538] GICv3: CPU44: found redistributor 20c region 0:0x0000801080580000
[    0.032569] GICv3: CPU44: using allocated LPI pending table @0x0000000100d40000
[    0.032599] CPU44: Booted secondary processor 0x000000020c [0x431f0a11]
[    0.033181] Detected VIPT I-cache on CPU45
[    0.033200] GICv3: CPU45: found redistributor 20d region 0:0x00008010805a0000
[    0.033231] GICv3: CPU45: using allocated LPI pending table @0x0000000100d50000
[    0.033261] CPU45: Booted secondary processor 0x000000020d [0x431f0a11]
[    0.033833] Detected VIPT I-cache on CPU46
[    0.033852] GICv3: CPU46: found redistributor 20e region 0:0x00008010805c0000
[    0.033883] GICv3: CPU46: using allocated LPI pending table @0x0000000100d60000
[    0.033913] CPU46: Booted secondary processor 0x000000020e [0x431f0a11]
[    0.035252] Detected VIPT I-cache on CPU47
[    0.035271] GICv3: CPU47: found redistributor 20f region 0:0x00008010805e0000
[    0.035303] GICv3: CPU47: using allocated LPI pending table @0x0000000100d70000
[    0.035334] CPU47: Booted secondary processor 0x000000020f [0x431f0a11]
[    0.035443] smp: Brought up 1 node, 48 CPUs
[    0.035708] SMP: Total of 48 processors activated.
[    0.035715] CPU features: detected: Data cache clean to the PoU not required for I/D coherence
[    0.035720] CPU features: detected: CRC32 instructions
[    0.035948] CPU features: emulated: Privileged Access Never (PAN) using TTBR0_EL1 switching
[    0.044445] CPU: All CPU(s) started at EL2
[    0.044603] alternatives: patching kernel code
[    0.058479] devtmpfs: initialized
[    0.078107] Registered cp15_barrier emulation handler
[    0.078132] Registered setend emulation handler
[    0.078139] KASLR disabled due to lack of seed
[    0.078309] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.078378] futex hash table entries: 16384 (order: 8, 1048576 bytes, linear)
[    0.079795] pinctrl core: initialized pinctrl subsystem
[    0.080358] SMBIOS 3.0.0 present.
[    0.080372] DMI: GIGABYTE R120-T33/MT30-GS1, BIOS F02 08/06/2019
[    0.080861] NET: Registered protocol family 16
[    0.082637] DMA: preallocated 4096 KiB GFP_KERNEL pool for atomic allocations
[    0.083107] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
[    0.083586] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
[    0.083620] audit: initializing netlink subsys (disabled)
[    0.083779] audit: type=2000 audit(0.080:1): state=initialized audit_enabled=0 res=1
[    0.084319] thermal_sys: Registered thermal governor 'fair_share'
[    0.084325] thermal_sys: Registered thermal governor 'bang_bang'
[    0.084330] thermal_sys: Registered thermal governor 'step_wise'
[    0.084335] thermal_sys: Registered thermal governor 'user_space'
[    0.084339] thermal_sys: Registered thermal governor 'power_allocator'
[    0.084521] cpuidle: using governor ladder
[    0.084784] cpuidle: using governor menu
[    0.084931] hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
[    0.085512] ASID allocator initialised with 65536 entries
[    0.085808] ACPI: bus type PCI registered
[    0.085815] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.086052] Serial: AMBA PL011 UART driver
[    0.096807] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    0.096815] HugeTLB registered 32.0 MiB page size, pre-allocated 0 pages
[    0.096821] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.096826] HugeTLB registered 64.0 KiB page size, pre-allocated 0 pages
[    0.101895] ACPI: Added _OSI(Module Device)
[    0.101903] ACPI: Added _OSI(Processor Device)
[    0.101907] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.101912] ACPI: Added _OSI(Processor Aggregator Device)
[    0.101917] ACPI: Added _OSI(Linux-Dell-Video)
[    0.101923] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    0.101928] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    0.105849] ACPI: 2 ACPI AML tables successfully acquired and loaded
[    0.107742] ACPI: Interpreter enabled
[    0.107749] ACPI: Using GIC for interrupt routing
[    0.107778] ACPI: MCFG table detected, 4 entries
[    0.131437] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-1f])
[    0.131454] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[    0.131603] acpi PNP0A08:00: _OSC: platform does not support [PCIeHotplug SHPCHotplug PME AER LTR]
[    0.131732] acpi PNP0A08:00: _OSC: OS now controls [PCIeCapability]
[    0.132192] acpi PNP0A08:00: ECAM area [mem 0x848000000000-0x848001ffffff] reserved by CAVA02C:00
[    0.132210] acpi PNP0A08:00: ECAM at [mem 0x848000000000-0x848001ffffff] for [bus 00-1f]
[    0.132366] PCI host bridge to bus 0000:00
[    0.132374] pci_bus 0000:00: root bus resource [mem 0x801000000000-0x807fffffffff window]
[    0.132381] pci_bus 0000:00: root bus resource [mem 0x838000000000-0x841fffffffff window]
[    0.132388] pci_bus 0000:00: root bus resource [mem 0x846000000000-0x847fffffffff window]
[    0.132394] pci_bus 0000:00: root bus resource [mem 0x868000000000-0x87e023ffffff window]
[    0.132400] pci_bus 0000:00: root bus resource [mem 0x87e026000000-0x87e0bfffffff window]
[    0.132407] pci_bus 0000:00: root bus resource [mem 0x87e0c6000000-0x87ffffffffff window]
[    0.132414] pci_bus 0000:00: root bus resource [bus 00-1f]
[    0.132444] pci 0000:00:01.0: [177d:a002] type 01 class 0x060400
[    0.132615] pci 0000:00:09.0: [177d:a018] type 00 class 0x120000
[    0.132651] pci 0000:00:09.0: BAR 0: [mem 0x87e040000000-0x87e0400fffff 64bit] (from Enhanced Allocation, properties 0x0)
[    0.132660] pci 0000:00:09.0: VF BAR 0: [mem 0x840000800000-0x8400008fffff 64bit] (from Enhanced Allocation, properties 0x4)
[    1.153436] pci 0000:00:09.0: VF(n) BAR0 space: [mem 0x840000800000-0x8400008fffff 64bit] (contains BAR0 for 1 VFs)
[    1.153589] pci 0000:00:10.0: [177d:a01b] type 00 class 0x0c0330
[    1.153625] pci 0000:00:10.0: BAR 0: [mem 0x868000000000-0x8680001fffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.153634] pci 0000:00:10.0: BAR 4: [mem 0x868000200000-0x8680002fffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.153761] pci 0000:00:11.0: [177d:a01b] type 00 class 0x0c0330
[    1.153797] pci 0000:00:11.0: BAR 0: [mem 0x869000000000-0x8690001fffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.153806] pci 0000:00:11.0: BAR 4: [mem 0x869000200000-0x8690002fffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.153931] pci 0000:00:14.0: [177d:a002] type 01 class 0x060400
[    1.154132] pci 0000:01:00.0: [177d:a001] type 00 class 0x088000
[    1.154167] pci 0000:01:00.0: BAR 0: [mem 0x87e0fc000000-0x87e0fc0fffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.154177] pci 0000:01:00.0: BAR 4: [mem 0x87e0fcf00000-0x87e0fcffffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.154302] pci 0000:01:00.1: [177d:a00e] type 00 class 0x088000
[    1.154338] pci 0000:01:00.1: BAR 0: [mem 0x87e006000000-0x87e0067fffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.154347] pci 0000:01:00.1: BAR 4: [mem 0x87e006f00000-0x87e006ffffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.154467] pci 0000:01:01.3: [177d:a02b] type 00 class 0x0c8000
[    1.154501] pci 0000:01:01.3: BAR 0: [mem 0x87e005000000-0x87e0057fffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.154619] pci 0000:01:01.4: [177d:a010] type 00 class 0x058000
[    1.154659] pci 0000:01:01.4: BAR 0: [mem 0x87e009000000-0x87e0097fffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.154668] pci 0000:01:01.4: BAR 4: [mem 0x87e009f00000-0x87e009ffffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.154790] pci 0000:01:06.0: [177d:a02e] type 00 class 0x058000
[    1.154826] pci 0000:01:06.0: BAR 0: [mem 0x87e050000000-0x87e0507fffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.154836] pci 0000:01:06.0: BAR 4: [mem 0x87e050f00000-0x87e050ffffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.154961] pci 0000:01:06.1: [177d:a02e] type 00 class 0x058000
[    1.154997] pci 0000:01:06.1: BAR 0: [mem 0x87e051000000-0x87e0517fffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.155006] pci 0000:01:06.1: BAR 4: [mem 0x87e051f00000-0x87e051ffffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.155127] pci 0000:01:06.2: [177d:a02e] type 00 class 0x058000
[    1.155163] pci 0000:01:06.2: BAR 0: [mem 0x87e052000000-0x87e0527fffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.155172] pci 0000:01:06.2: BAR 4: [mem 0x87e052f00000-0x87e052ffffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.155291] pci 0000:01:06.3: [177d:a02e] type 00 class 0x058000
[    1.155326] pci 0000:01:06.3: BAR 0: [mem 0x87e053000000-0x87e0537fffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.155335] pci 0000:01:06.3: BAR 4: [mem 0x87e053f00000-0x87e053ffffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.155455] pci 0000:01:06.4: [177d:a02e] type 00 class 0x058000
[    1.155491] pci 0000:01:06.4: BAR 0: [mem 0x87e054000000-0x87e0547fffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.155500] pci 0000:01:06.4: BAR 4: [mem 0x87e054f00000-0x87e054ffffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.155621] pci 0000:01:06.5: [177d:a02e] type 00 class 0x058000
[    1.155657] pci 0000:01:06.5: BAR 0: [mem 0x87e055000000-0x87e0557fffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.155666] pci 0000:01:06.5: BAR 4: [mem 0x87e055f00000-0x87e055ffffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.155785] pci 0000:01:06.6: [177d:a02e] type 00 class 0x058000
[    1.155821] pci 0000:01:06.6: BAR 0: [mem 0x87e056000000-0x87e0567fffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.155830] pci 0000:01:06.6: BAR 4: [mem 0x87e056f00000-0x87e056ffffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.155950] pci 0000:01:06.7: [177d:a02e] type 00 class 0x058000
[    1.155989] pci 0000:01:06.7: BAR 0: [mem 0x87e057000000-0x87e0577fffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.155998] pci 0000:01:06.7: BAR 4: [mem 0x87e057f00000-0x87e057ffffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.156120] pci 0000:01:07.0: [177d:a02f] type 00 class 0x058000
[    1.156156] pci 0000:01:07.0: BAR 0: [mem 0x87e058000000-0x87e0587fffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.156165] pci 0000:01:07.0: BAR 4: [mem 0x87e058f00000-0x87e058ffffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.156291] pci 0000:01:07.1: [177d:a02f] type 00 class 0x058000
[    1.156327] pci 0000:01:07.1: BAR 0: [mem 0x87e059000000-0x87e0597fffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.156336] pci 0000:01:07.1: BAR 4: [mem 0x87e059f00000-0x87e059ffffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.156456] pci 0000:01:07.2: [177d:a02f] type 00 class 0x058000
[    1.156492] pci 0000:01:07.2: BAR 0: [mem 0x87e05a000000-0x87e05a7fffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.156501] pci 0000:01:07.2: BAR 4: [mem 0x87e05af00000-0x87e05affffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.156623] pci 0000:01:07.3: [177d:a02f] type 00 class 0x058000
[    1.156659] pci 0000:01:07.3: BAR 0: [mem 0x87e05b000000-0x87e05b7fffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.156668] pci 0000:01:07.3: BAR 4: [mem 0x87e05bf00000-0x87e05bffffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.156787] pci 0000:01:07.4: [177d:a030] type 00 class 0x058000
[    1.156822] pci 0000:01:07.4: BAR 0: [mem 0x87e05c000000-0x87e05c7fffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.156831] pci 0000:01:07.4: BAR 4: [mem 0x87e05cf00000-0x87e05cffffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.156951] pci 0000:01:07.5: [177d:a030] type 00 class 0x058000
[    1.156986] pci 0000:01:07.5: BAR 0: [mem 0x87e05d000000-0x87e05d7fffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.156995] pci 0000:01:07.5: BAR 4: [mem 0x87e05df00000-0x87e05dffffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.157118] pci 0000:01:07.6: [177d:a030] type 00 class 0x058000
[    1.157153] pci 0000:01:07.6: BAR 0: [mem 0x87e05e000000-0x87e05e7fffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.157162] pci 0000:01:07.6: BAR 4: [mem 0x87e05ef00000-0x87e05effffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.157286] pci 0000:01:07.7: [177d:a030] type 00 class 0x058000
[    1.157334] pci 0000:01:07.7: BAR 0: [mem 0x87e05f000000-0x87e05f7fffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.157343] pci 0000:01:07.7: BAR 4: [mem 0x87e05ff00000-0x87e05fffffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.157476] pci 0000:01:09.2: [177d:a012] type 00 class 0x0c8000
[    1.157513] pci 0000:01:09.2: BAR 0: [mem 0x87e0d2000000-0x87e0d27fffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.157522] pci 0000:01:09.2: BAR 4: [mem 0x87e0d2f00000-0x87e0d2ffffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.157649] pci 0000:01:09.4: [177d:a012] type 00 class 0x0c8000
[    1.157685] pci 0000:01:09.4: BAR 0: [mem 0x87e0d4000000-0x87e0d47fffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.157694] pci 0000:01:09.4: BAR 4: [mem 0x87e0d4f00000-0x87e0d4ffffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.157815] pci 0000:01:0a.0: [177d:a022] type 00 class 0x058000
[    1.157851] pci 0000:01:0a.0: BAR 0: [mem 0x87e088000000-0x87e0887fffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.157860] pci 0000:01:0a.0: BAR 4: [mem 0x87e088f00000-0x87e088ffffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.157983] pci 0000:01:0a.1: [177d:a022] type 00 class 0x058000
[    1.158018] pci 0000:01:0a.1: BAR 0: [mem 0x87e089000000-0x87e0897fffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.158027] pci 0000:01:0a.1: BAR 4: [mem 0x87e089f00000-0x87e089ffffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.158150] pci 0000:01:10.0: [177d:a026] type 00 class 0x028000
[    1.158185] pci 0000:01:10.0: BAR 0: [mem 0x87e0e0000000-0x87e0e03fffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.158194] pci 0000:01:10.0: BAR 4: [mem 0x87e0e0400000-0x87e0e07fffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.158316] pci 0000:01:10.1: [177d:a026] type 00 class 0x028000
[    1.158351] pci 0000:01:10.1: BAR 0: [mem 0x87e0e1000000-0x87e0e13fffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.158360] pci 0000:01:10.1: BAR 4: [mem 0x87e0e1400000-0x87e0e17fffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.158471] pci 0000:01:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
[    1.158637] pci 0000:02:00.0: [177d:a01d] type 00 class 0x010400
[    1.158676] pci 0000:02:00.0: BAR 0: [mem 0x870000000000-0x8700007fffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.158685] pci 0000:02:00.0: BAR 4: [mem 0x870000f00000-0x870000ffffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.158800] pci 0000:02:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
[    1.158875] pci 0000:00:01.0: PCI bridge to [bus 01]
[    1.158889] pci 0000:00:14.0: PCI bridge to [bus 02]
[    1.158897] pci_bus 0000:00: resource 4 [mem 0x801000000000-0x807fffffffff window]
[    1.158903] pci_bus 0000:00: resource 5 [mem 0x838000000000-0x841fffffffff window]
[    1.158910] pci_bus 0000:00: resource 6 [mem 0x846000000000-0x847fffffffff window]
[    1.158916] pci_bus 0000:00: resource 7 [mem 0x868000000000-0x87e023ffffff window]
[    1.158922] pci_bus 0000:00: resource 8 [mem 0x87e026000000-0x87e0bfffffff window]
[    1.158929] pci_bus 0000:00: resource 9 [mem 0x87e0c6000000-0x87ffffffffff window]
[    1.159085] ACPI: PCI Root Bridge [PCI1] (domain 0001 [bus 00-1f])
[    1.159098] acpi PNP0A08:01: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[    1.159240] acpi PNP0A08:01: _OSC: platform does not support [PCIeHotplug SHPCHotplug PME AER LTR]
[    1.159369] acpi PNP0A08:01: _OSC: OS now controls [PCIeCapability]
[    1.159842] acpi PNP0A08:01: ECAM area [mem 0x849000000000-0x849001ffffff] reserved by CAVA02C:01
[    1.159858] acpi PNP0A08:01: ECAM at [mem 0x849000000000-0x849001ffffff] for [bus 00-1f]
[    1.159988] PCI host bridge to bus 0001:00
[    1.159995] pci_bus 0001:00: root bus resource [mem 0x810000000000-0x817fffffffff window]
[    1.160003] pci_bus 0001:00: root bus resource [bus 00-1f]
[    1.160031] pci 0001:00:08.0: [177d:a01c] type 00 class 0x010601
[    1.160063] pci 0001:00:08.0: BAR 0: [mem 0x814000000000-0x8140001fffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.160072] pci 0001:00:08.0: BAR 4: [mem 0x814000200000-0x8140002fffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.160200] pci 0001:00:09.0: [177d:a01c] type 00 class 0x010601
[    1.160239] pci 0001:00:09.0: BAR 0: [mem 0x815000000000-0x8150001fffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.160248] pci 0001:00:09.0: BAR 4: [mem 0x815000200000-0x8150002fffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.160378] pci 0001:00:0a.0: [177d:a01c] type 00 class 0x010601
[    1.160413] pci 0001:00:0a.0: BAR 0: [mem 0x816000000000-0x8160001fffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.160422] pci 0001:00:0a.0: BAR 4: [mem 0x816000200000-0x8160002fffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.160548] pci 0001:00:0b.0: [177d:a01c] type 00 class 0x010601
[    1.160583] pci 0001:00:0b.0: BAR 0: [mem 0x817000000000-0x8170001fffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.160592] pci 0001:00:0b.0: BAR 4: [mem 0x817000200000-0x8170002fffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.160724] pci_bus 0001:00: resource 4 [mem 0x810000000000-0x817fffffffff window]
[    1.160832] ACPI: PCI Root Bridge [PCI2] (domain 0002 [bus 00-1f])
[    1.160845] acpi PNP0A08:02: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[    1.160985] acpi PNP0A08:02: _OSC: platform does not support [PCIeHotplug SHPCHotplug PME AER LTR]
[    1.161113] acpi PNP0A08:02: _OSC: OS now controls [PCIeCapability]
[    1.161617] acpi PNP0A08:02: ECAM area [mem 0x84a000000000-0x84a001ffffff] reserved by CAVA02C:02
[    1.161632] acpi PNP0A08:02: ECAM at [mem 0x84a000000000-0x84a001ffffff] for [bus 00-1f]
[    1.161765] PCI host bridge to bus 0002:00
[    1.161773] pci_bus 0002:00: root bus resource [mem 0x842000000000-0x843fffffffff window]
[    1.161780] pci_bus 0002:00: root bus resource [bus 00-1f]
[    1.161804] pci 0002:00:02.0: [177d:a002] type 01 class 0x060400
[    1.161952] pci 0002:00:03.0: [177d:a01f] type 00 class 0x028000
[    1.161986] pci 0002:00:03.0: BAR 0: [mem 0x842000000000-0x84200000ffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.161995] pci 0002:00:03.0: BAR 2: [mem 0x842040000000-0x84207fffffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.162004] pci 0002:00:03.0: BAR 4: [mem 0x842000f00000-0x842000ffffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.162195] pci 0002:01:00.0: [177d:a01e] type 00 class 0x020000
[    1.162231] pci 0002:01:00.0: BAR 0: [mem 0x843000000000-0x84303fffffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.162240] pci 0002:01:00.0: BAR 4: [mem 0x843060000000-0x8430600fffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.162249] pci 0002:01:00.0: VF BAR 0: [mem 0x8430a0000000-0x8430a01fffff 64bit] (from Enhanced Allocation, properties 0x4)
[    1.162257] pci 0002:01:00.0: VF BAR 4: [mem 0x8430e0000000-0x8430e01fffff 64bit] (from Enhanced Allocation, properties 0x4)
[    2.178767] pci 0002:01:00.0: VF(n) BAR0 space: [mem 0x8430a0000000-0x8430afffffff 64bit] (contains BAR0 for 128 VFs)
[    2.178782] pci 0002:01:00.0: VF(n) BAR4 space: [mem 0x8430e0000000-0x8430efffffff 64bit] (contains BAR4 for 128 VFs)
[    2.178990] pci 0002:01:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
[    2.179016] pci 0002:00:02.0: PCI bridge to [bus 01]
[    2.179025] pci_bus 0002:00: resource 4 [mem 0x842000000000-0x843fffffffff window]
[    2.179134] ACPI: PCI Root Bridge [PCI3] (domain 0003 [bus 00-1f])
[    2.179147] acpi PNP0A08:03: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[    2.179291] acpi PNP0A08:03: _OSC: platform does not support [PCIeHotplug SHPCHotplug PME AER LTR]
[    2.179421] acpi PNP0A08:03: _OSC: OS now controls [PCIeCapability]
[    2.179941] acpi PNP0A08:03: ECAM area [mem 0x84b000000000-0x84b001ffffff] reserved by CAVA02C:03
[    2.179957] acpi PNP0A08:03: ECAM at [mem 0x84b000000000-0x84b001ffffff] for [bus 00-1f]
[    2.180087] PCI host bridge to bus 0003:00
[    2.180094] pci_bus 0003:00: root bus resource [mem 0x818000000000-0x81ffffffffff window]
[    2.180102] pci_bus 0003:00: root bus resource [bus 00-1f]
[    2.180136] pci_bus 0003:00: resource 4 [mem 0x818000000000-0x81ffffffffff window]
[    2.180243] ACPI: PCI Root Bridge [PEM0] (domain 0004 [bus 1f-57])
[    2.180255] acpi PNP0A08:04: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[    2.180395] acpi PNP0A08:04: _OSC: platform does not support [PCIeHotplug SHPCHotplug PME AER LTR]
[    2.180525] acpi PNP0A08:04: _OSC: OS now controls [PCIeCapability]
[    2.180534] acpi PNP0A08:04: MCFG quirk: ECAM at [mem 0x88001f000000-0x880057ffffff] for [bus 1f-57] with thunder_pem_ecam_ops
[    2.181084] acpi PNP0A08:04: ECAM area [mem 0x88001f000000-0x880057ffffff] reserved by CAVA02B:00
[    2.181680] acpi PNP0A08:04: ECAM at [mem 0x88001f000000-0x880057ffffff] for [bus 1f-57]
[    2.181715] Remapped I/O 0x0000883000000000 to [io  0x0000-0xffff window]
[    2.181851] PCI host bridge to bus 0004:1f
[    2.181858] pci_bus 0004:1f: root bus resource [io  0x0000-0xffff window]
[    2.181866] pci_bus 0004:1f: root bus resource [mem 0x881010000000-0x881fffffffff window] (bus address [0x10000000-0xfffffffff])
[    2.181874] pci_bus 0004:1f: root bus resource [mem 0x882000000000-0x882fffffffff pref window] (bus address [0x1000000000-0x1fffffffff])
[    2.181881] pci_bus 0004:1f: root bus resource [mem 0x87e0c0000000-0x87e0c0ffffff window]
[    2.181888] pci_bus 0004:1f: root bus resource [bus 1f-57]
[    2.181914] pci 0004:1f:00.0: [177d:a100] type 01 class 0x060400
[    2.181928] pci 0004:1f:00.0: reg 0x10: [mem 0x00000000-0x00007fff 64bit pref]
[    2.181938] pci 0004:1f:00.0: reg 0x38: [mem 0x00000000-0x0000ffff pref]
[    2.181953] pci 0004:1f:00.0: enabling Extended Tags
[    2.181977] pci 0004:1f:00.0: BAR 0: [mem 0x87e0c0f00000-0x87e0c0ffffff 64bit] (from Enhanced Allocation, properties 0x0)
[    2.182150] pci 0004:1f:00.0: Primary bus is hard wired to 0
[    2.182244] pci 0004:20:00.0: [1a03:1150] type 01 class 0x060400
[    2.182294] pci 0004:20:00.0: Upstream bridge's Max Payload Size set to 128 (was 256, max 256)
[    2.182303] pci 0004:20:00.0: Max Payload Size set to 128 (was 128, max 128)
[    2.182312] pci 0004:20:00.0: enabling Extended Tags
[    2.182398] pci 0004:20:00.0: supports D1 D2
[    2.182404] pci 0004:20:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    2.182575] pci 0004:20:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
[    2.182640] pci_bus 0004:21: extended config space not accessible
[    2.182701] pci 0004:21:00.0: [1a03:2000] type 00 class 0x030000
[    2.182721] pci 0004:21:00.0: reg 0x10: [mem 0x881010000000-0x881010ffffff]
[    2.182734] pci 0004:21:00.0: reg 0x14: [mem 0x881011000000-0x88101101ffff]
[    2.182746] pci 0004:21:00.0: reg 0x18: [io  0x0000-0x007f]
[    2.182806] pci 0004:21:00.0: BAR 0: assigned to efifb
[    2.182855] pci 0004:21:00.0: supports D1 D2
[    2.182861] pci 0004:21:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    2.183056] pci 0004:1f:00.0: Primary bus is hard wired to 0
[    2.183074] pci 0004:1f:00.0: BAR 14: assigned [mem 0x881010000000-0x8810117fffff]
[    2.183082] pci 0004:1f:00.0: BAR 6: assigned [mem 0x881011800000-0x88101180ffff pref]
[    2.183090] pci 0004:1f:00.0: BAR 13: assigned [io  0x1000-0x1fff]
[    2.183098] pci 0004:20:00.0: BAR 14: assigned [mem 0x881010000000-0x8810117fffff]
[    2.183105] pci 0004:20:00.0: BAR 13: assigned [io  0x1000-0x1fff]
[    2.183113] pci 0004:21:00.0: BAR 0: assigned [mem 0x881010000000-0x881010ffffff]
[    2.183122] pci 0004:21:00.0: BAR 1: assigned [mem 0x881011000000-0x88101101ffff]
[    2.183131] pci 0004:21:00.0: BAR 2: assigned [io  0x1000-0x107f]
[    2.183140] pci 0004:20:00.0: PCI bridge to [bus 21]
[    2.183147] pci 0004:20:00.0:   bridge window [io  0x1000-0x1fff]
[    2.183153] pci 0004:20:00.0:   bridge window [mem 0x881010000000-0x8810117fffff]
[    2.183160] pci 0004:1f:00.0: PCI bridge to [bus 20-21]
[    2.183166] pci 0004:1f:00.0:   bridge window [io  0x1000-0x1fff]
[    2.183173] pci 0004:1f:00.0:   bridge window [mem 0x881010000000-0x8810117fffff]
[    2.183180] pci_bus 0004:1f: resource 4 [io  0x0000-0xffff window]
[    2.183186] pci_bus 0004:1f: resource 5 [mem 0x881010000000-0x881fffffffff window]
[    2.183193] pci_bus 0004:1f: resource 6 [mem 0x882000000000-0x882fffffffff pref window]
[    2.183199] pci_bus 0004:1f: resource 7 [mem 0x87e0c0000000-0x87e0c0ffffff window]
[    2.183206] pci_bus 0004:20: resource 0 [io  0x1000-0x1fff]
[    2.183212] pci_bus 0004:20: resource 1 [mem 0x881010000000-0x8810117fffff]
[    2.183218] pci_bus 0004:21: resource 0 [io  0x1000-0x1fff]
[    2.183224] pci_bus 0004:21: resource 1 [mem 0x881010000000-0x8810117fffff]
[    2.183336] ACPI: PCI Interrupt Link [LN0A] (IRQs *48)
[    2.183387] ACPI: PCI Interrupt Link [LN0B] (IRQs *49)
[    2.183434] ACPI: PCI Interrupt Link [LN0C] (IRQs *50)
[    2.183480] ACPI: PCI Interrupt Link [LN0D] (IRQs *51)
[    2.183772] ARMH0011:00: ttyAMA0 at MMIO 0x87e024000000 (irq = 21, base_baud = 0) is a SBSA
[    6.382848] printk: console [ttyAMA0] enabled
[    6.390414] ARMH0011:01: ttyAMA1 at MMIO 0x87e025000000 (irq = 22, base_baud = 0) is a SBSA
[    6.404767] iommu: Default domain type: Translated 
[    6.409783] pci 0004:21:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
[    6.418137] pci 0004:21:00.0: vgaarb: bridge control possible
[    6.423876] pci 0004:21:00.0: vgaarb: setting as boot device (VGA legacy resources not available)
[    6.432738] vgaarb: loaded
[    6.436158] SCSI subsystem initialized
[    6.440133] ACPI: bus type USB registered
[    6.444193] usbcore: registered new interface driver usbfs
[    6.449703] usbcore: registered new interface driver hub
[    6.455057] usbcore: registered new device driver usb
[    6.460202] pps_core: LinuxPPS API ver. 1 registered
[    6.465165] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    6.474295] PTP clock support registered
[    6.478411] EDAC MC: Ver: 3.0.0
[    6.481993] Registered efivars operations
[    6.487793] NetLabel: Initializing
[    6.491196] NetLabel:  domain hash size = 128
[    6.495544] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    6.501233] NetLabel:  unlabeled traffic allowed by default
[    6.507333] clocksource: Switched to clocksource arch_sys_counter
[    6.553602] VFS: Disk quotas dquot_6.6.0
[    6.557582] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    6.564907] AppArmor: AppArmor Filesystem Enabled
[    6.569703] pnp: PnP ACPI init
[    6.573376] system 00:00: [mem 0x848000000000-0x848001ffffff] could not be reserved
[    6.581230] system 00:01: [mem 0x849000000000-0x849001ffffff] could not be reserved
[    6.589075] system 00:02: [mem 0x84a000000000-0x84a001ffffff] could not be reserved
[    6.596921] system 00:03: [mem 0x84b000000000-0x84b001ffffff] could not be reserved
[    6.604770] system 00:04: [mem 0x87e0c0000000-0x87e0c0ffffff] could not be reserved
[    6.612431] system 00:04: [mem 0x88001f000000-0x880057ffffff] could not be reserved
[    6.622306] pnp: PnP ACPI: found 5 devices
[    6.632232] NET: Registered protocol family 2
[    6.637376] tcp_listen_portaddr_hash hash table entries: 32768 (order: 7, 524288 bytes, linear)
[    6.646603] TCP established hash table entries: 524288 (order: 10, 4194304 bytes, linear)
[    6.656465] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes, linear)
[    6.664233] TCP: Hash tables configured (established 524288 bind 65536)
[    6.671254] MPTCP token hash table entries: 65536 (order: 8, 1572864 bytes, linear)
[    6.679469] UDP hash table entries: 32768 (order: 8, 1048576 bytes, linear)
[    6.687022] UDP-Lite hash table entries: 32768 (order: 8, 1048576 bytes, linear)
[    6.695198] NET: Registered protocol family 1
[    6.699568] NET: Registered protocol family 44
[    6.704208] PCI: CLS 0 bytes, default 64
[    6.708237] Trying to unpack rootfs image as initramfs...
[    7.713965] Freeing initrd memory: 68180K
[    7.721067] hw perfevents: enabled with armv8_pmuv3_0 PMU driver, 7 counters available
[    7.729104] kvm [1]: IPA Size Limit: 48 bits
[    7.734986] kvm [1]: GICv3: no GICV resource entry
[    7.739781] kvm [1]: disabling GICv2 emulation
[    7.744217] kvm [1]: GICv3 sysreg trapping enabled ([G0G1], reduced performance)
[    7.751617] kvm [1]: GIC system register CPU interface enabled
[    7.758605] kvm [1]: vgic interrupt IRQ9
[    7.763776] kvm [1]: Hyp mode initialized successfully
[    7.771680] Initialise system trusted keyrings
[    7.776151] Key type blacklist registered
[    7.780323] workingset: timestamp_bits=40 max_order=24 bucket_order=0
[    7.791059] zbud: loaded
[    7.794771] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    7.801149] fuse: init (API version 7.33)
[    7.805555] integrity: Platform Keyring initialized
[    7.833189] Key type asymmetric registered
[    7.837286] Asymmetric key parser 'x509' registered
[    7.842174] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 243)
[    7.849699] io scheduler mq-deadline registered
[    7.857591] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    7.865127] efifb: probing for efifb
[    7.868738] efifb: No BGRT, not showing boot graphics
[    7.873783] efifb: framebuffer at 0x881010000000, using 3072k, total 3072k
[    7.880649] efifb: mode is 1024x768x32, linelength=4096, pages=1
[    7.886647] efifb: scrolling: redraw
[    7.890212] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    7.895905] fbcon: Deferring console take-over
[    7.900350] fb0: EFI VGA frame buffer device
[    7.905289] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    7.913714] ACPI: button: Power Button [PWRB]
[    7.919549] ACPI GTDT: [Firmware Bug]: failed to get the Watchdog base address.
[    7.927289] Unable to handle kernel read from unreadable memory at virtual address 0000000000000028
[    7.936326] Mem abort info:
[    7.939108]   ESR = 0x96000004
[    7.942151]   EC = 0x25: DABT (current EL), IL = 32 bits
[    7.947451]   SET = 0, FnV = 0
[    7.950494]   EA = 0, S1PTW = 0
[    7.953624] Data abort info:
[    7.956492]   ISV = 0, ISS = 0x00000004
[    7.960316]   CM = 0, WnR = 0
[    7.963273] [0000000000000028] user address but active_mm is swapper
[    7.969616] Internal error: Oops: 96000004 [#1] SMP
[    7.974483] Modules linked in:
[    7.977531] CPU: 9 PID: 1 Comm: swapper/0 Not tainted 5.12.0-rc8 #19
[    7.983874] Hardware name: GIGABYTE R120-T33/MT30-GS1, BIOS F02 08/06/2019
[    7.990737] pstate: 40400085 (nZcv daIf +PAN -UAO -TCO BTYPE=--)
[    7.996732] pc : __ipi_send_mask+0x60/0x114
[    8.000910] lr : smp_cross_call+0x40/0xcc
[    8.004913] sp : ffff800012753c10
[    8.008216] x29: ffff800012753c10 x28: ffff000100de5d00 
[    8.013521] x27: 000000000000000a x26: ffff80001225da20 
[    8.018825] x25: 0000000000000000 x24: ffff000ff62719b0 
[    8.024129] x23: ffff80001225d000 x22: ffff800012368108 
[    8.029433] x21: ffff800010f69a20 x20: 0000000000000000 
[    8.034737] x19: ffff000100143c60 x18: 0000000000000020 
[    8.040041] x17: 000000008e74252f x16: 00000000bf0ab2ad 
[    8.045345] x15: ffffffffffffffff x14: 0000000000000000 
[    8.050649] x13: 003d090000000000 x12: 00003d0900000000 
[    8.055953] x11: 0000000000000000 x10: 00003d0900000000 
[    8.061257] x9 : ffff800010027f14 x8 : 0000000000000000 
[    8.066561] x7 : 00000000ffffffff x6 : ffff000ff6148698 
[    8.071865] x5 : ffff80001159d040 x4 : ffff80001159d110 
[    8.077169] x3 : ffff800010f69a00 x2 : 0000000000000000 
[    8.082473] x1 : ffff800010f69a20 x0 : 0000000000000000 
[    8.087777] Call trace:
[    8.090213]  __ipi_send_mask+0x60/0x114
[    8.094038]  smp_cross_call+0x40/0xcc
[    8.097691]  smp_send_reschedule+0x3c/0x50
[    8.101778]  resched_curr+0x5c/0xb0
[    8.105258]  check_preempt_curr+0x58/0x90
[    8.109258]  ttwu_do_wakeup+0x2c/0x190
[    8.112996]  ttwu_do_activate+0x7c/0x114
[    8.116909]  try_to_wake_up+0x388/0x670
[    8.120735]  wake_up_process+0x24/0x30
[    8.124474]  swake_up_one+0x48/0x9c
[    8.127953]  rcu_gp_kthread_wake+0x68/0x8c
[    8.132041]  rcu_accelerate_cbs_unlocked+0xb4/0xf0
[    8.136822]  rcu_core+0x520/0x694
[    8.140128]  rcu_core_si+0x1c/0x2c
[    8.143520]  __do_softirq+0x128/0x388
[    8.147172]  irq_exit+0xc4/0xec
[    8.150304]  __handle_domain_irq+0x8c/0xec
[    8.154394]  gic_handle_irq+0xd8/0x2f0
[    8.158132]  el1_irq+0xc0/0x180
[    8.161262]  __pi_strcmp+0x20/0x158
[    8.164742]  driver_register+0x68/0x140
[    8.168571]  __platform_driver_register+0x34/0x40
[    8.173265]  imx8mp_clk_driver_init+0x28/0x34
[    8.177614]  do_one_initcall+0x50/0x260
[    8.181440]  kernel_init_freeable+0x24c/0x2d4
[    8.185790]  kernel_init+0x20/0x134
[    8.189271]  ret_from_fork+0x10/0x18
[    8.192840] Code: a90363f7 aa0103f5 d0010957 f9401260 (b9402800) 
[    8.198955] ---[ end trace c24172add816c1f0 ]---
[    8.203562] Kernel panic - not syncing: Oops: Fatal exception in interrupt
[    8.210442] SMP: stopping secondary CPUs
[    9.258360] SMP: failed to stop secondary CPUs 0,9
[    9.263141] Kernel Offset: disabled
[    9.266617] CPU features: 0x00040002,69101108
[    9.270963] Memory Limit: none
[    9.274024] ---[ end Kernel panic - not syncing: Oops: Fatal exception in interrupt ]---
