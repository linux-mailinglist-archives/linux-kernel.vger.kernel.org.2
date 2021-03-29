Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D67034D6C9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 20:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbhC2SPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 14:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbhC2SO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 14:14:58 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66416C061574;
        Mon, 29 Mar 2021 11:14:57 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 15so17047174ljj.0;
        Mon, 29 Mar 2021 11:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Xp0DNvADzdpsmcMxHg16emnm8nYmWsDpEqyY7QOXb00=;
        b=ruW0bZtqKy+5mC++ltWcLZ2zbUlIHseGo76A7gJEtaXsSo17Q4FsI02NEW0anhGY5Y
         hLc2Hd5lCDFV8Mkq5+ruWnqcZD1zVLHvGd3HS9FeiS19/L97PcqO/mtZoWwLFX1GbJX0
         WghPTLbqEFYfgOa/GCjJY9wOqGhR5Xb+LIhuV6TeAUa+84McrghiXyclrvSywscKew0s
         fdE3JhWz/VaxWywzJekgT7hBWH4im9FLJMKNs3ZSjB0AXVY8jKMB5LfR9S03VAFoX2Th
         /16x2DcFSc5HLmP3WaOLL38so2OPjUb8FPpHLdYX/rkFfeNlPXYBr5j1+KDUkOT0cdoL
         Ot5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Xp0DNvADzdpsmcMxHg16emnm8nYmWsDpEqyY7QOXb00=;
        b=dxKrixaiGImT0yQ15uXQ9yhOYkjim++CzP8NnMgeQNOL/2V27iLBw9pOFunACWR6hy
         jXE1tu9ndo12zrcD65fLh4U9Wkgu16/KW0U2/CZC0EgWG+ETUWePmh0PgwhZqSrC9+WX
         ervuKGJb6KWnCtQo4gNJgEctXAHmiN4J2BjtqMbPhpaWmxqYRnjmI9i7Bskpkv+PW72M
         bBKx/KHHkGnbsUnacEncd7hN70nmldnfFAeT+6tLDvL3tuHXPG0IJ870+n0f3Vjk+g9o
         No+tnRcEDXJjIvFTgzjeJuzp8BdgXTs9V4ACCxNMiFyOhnv3uHjD8Hj7ERWvVFsTc0MH
         THEA==
X-Gm-Message-State: AOAM533MeX8AJjYBLcJxGMbr9NIupRqcIOrR9Ntpml5yrNctNAI8KiKM
        iufaq2EjqHF35gn2RHtuIPE=
X-Google-Smtp-Source: ABdhPJyyjmeljfPVOTXDaJJSF/DN0lt/0QY2UZ8Yy+u47+HLDd179bhHbCOJST+6vq4/nB/rTYnKKQ==
X-Received: by 2002:a2e:b011:: with SMTP id y17mr18609781ljk.390.1617041695754;
        Mon, 29 Mar 2021 11:14:55 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id q8sm1904955lfc.223.2021.03.29.11.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 11:14:55 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Mon, 29 Mar 2021 20:14:53 +0200
To:     Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Colin King <colin.king@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Nicholas Piggin <npiggin@gmail.com>, linux-mm@kvack.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        urezki@gmail.com
Subject: Re: [PATCH][next] mm/vmalloc: Fix read of pointer area after it has
 been free'd
Message-ID: <20210329181453.GA13467@pc638.lan>
References: <20210329170730.121943-1-colin.king@canonical.com>
 <20210329171434.GH351017@casper.infradead.org>
 <20210329174029.GA457@pc638.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210329174029.GA457@pc638.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 07:40:29PM +0200, Uladzislau Rezki wrote:
> On Mon, Mar 29, 2021 at 06:14:34PM +0100, Matthew Wilcox wrote:
> > On Mon, Mar 29, 2021 at 06:07:30PM +0100, Colin King wrote:
> > > From: Colin Ian King <colin.king@canonical.com>
> > > 
> > > Currently the memory pointed to by area is being freed by the
> > > free_vm_area call and then area->nr_pages is referencing the
> > > free'd object. Fix this swapping the order of the warn_alloc
> > > message and the free.
> > > 
> > > Addresses-Coverity: ("Read from pointer after free")
> > > Fixes: 014ccf9b888d ("mm/vmalloc: improve allocation failure error messages")
> > 
> > i don't have this git sha.  if this is -next, the sha ids aren't stable
> > and shouldn't be referenced in commit logs, because these fixes should
> > just be squashed into the not-yet-upstream commits.
> > 
> > > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > > ---
> > >  mm/vmalloc.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > index b73e4e715e0d..7936405749e4 100644
> > > --- a/mm/vmalloc.c
> > > +++ b/mm/vmalloc.c
> > > @@ -2790,11 +2790,11 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
> > >  	}
> > >  
> > >  	if (!pages) {
> > > -		free_vm_area(area);
> > >  		warn_alloc(gfp_mask, NULL,
> > >  			   "vmalloc size %lu allocation failure: "
> > >  			   "page array size %lu allocation failed",
> > >  			   area->nr_pages * PAGE_SIZE, array_size);
> > > +		free_vm_area(area);
> > >  		return NULL;
> > 
> > this fix looks right to me.
> > 
> That is from the linux-next. Same to me.
> 
> Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> 
> --
> Vlad Rezki
Is the linux-next(next-20210329) broken?

@pc638:~/data/raid0/coding/linux-next.git$ git branch 
  master
  next-20210225
  next-20210326
* next-20210329
urezki@pc638:~/data/raid0/coding/linux-next.git$ ../run_linux.sh ./arch/x86_64/boot/bzImage
File ‘quantal-trinity-x86_64.cgz’ already there; not retrieving.

early console in setup code
Probing EDD (edd=off to disable)... ok
[    0.000000] Linux version 5.12.0-rc4-next-20210329+ (urezki@pc638) (gcc (Debian 8.3.0-6) 8.3.0, GNU ld (GNU Binutils for Debian) 2.31.1) #497 SMP PREEMPT Mon Mar 29 19:59:25 CEST 2021
[    0.000000] Command line: root=/dev/ram0 hung_task_panic=1 debug apic=debug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=100 net.ifnames=0 printk.devkmsg=on panic=-1 softlockup_panic=1 nmi_watchdog=panic oops=panic load_ramdisk=2 prompt_ramdisk=0 drbd.minor_count=8 systemd.log_level=err ignore_loglevel console=tty0 earlyprintk=ttyS0,115200 console=ttyS0,115200 vga=normal rw rcuperf.shutdown=0 watchdog_thresh=60 run_self_test=1 threadirqs
[    0.000000] x86/fpu: x87 FPU will use FXSAVE
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000bffdffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000bffe0000-0x00000000bfffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000023fffffff] usable
[    0.000000] printk: debug: ignoring loglevel setting.
[    0.000000] printk: bootconsole [earlyser0] enabled
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.8 present.
[    0.000000] DMI: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[    0.000000] Hypervisor detected: KVM
[    0.000000] kvm-clock: Using msrs 4b564d01 and 4b564d00
[    0.000000] kvm-clock: cpu 0, msr 1e96be001, primary cpu clock
[    0.000000] kvm-clock: using sched offset of 1302025291 cycles
[    0.000492] clocksource: kvm-clock: mask: 0xffffffffffffffff max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
[    0.001870] tsc: Detected 3700.134 MHz processor
[    0.002721] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.003285] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.028860] AGP: No AGP bridge found
[    0.029382] last_pfn = 0x240000 max_arch_pfn = 0x400000000
[    0.029868] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT
Memory KASLR using RDTSC...
[    0.030657] last_pfn = 0xbffe0 max_arch_pfn = 0x400000000
[    0.031108] Scan for SMP in [mem 0x00000000-0x000003ff]
[    0.031555] Scan for SMP in [mem 0x0009fc00-0x0009ffff]
[    0.031999] Scan for SMP in [mem 0x000f0000-0x000fffff]
[    0.034146] found SMP MP-table at [mem 0x000f5a80-0x000f5a8f]
[    0.034622]   mpc: f5a90-f5b74
[    0.034881] ACPI: Early table checksum verification disabled
[    0.035349] ACPI: RSDP 0x00000000000F5850 000014 (v00 BOCHS )
[    0.035833] ACPI: RSDT 0x00000000BFFE15C9 000030 (v01 BOCHS  BXPCRSDT 00000001 BXPC 00000001)
[    0.036549] ACPI: FACP 0x00000000BFFE149D 000074 (v01 BOCHS  BXPCFACP 00000001 BXPC 00000001)
[    0.037267] ACPI: DSDT 0x00000000BFFE0040 00145D (v01 BOCHS  BXPCDSDT 00000001 BXPC 00000001)
[    0.037978] ACPI: FACS 0x00000000BFFE0000 000040
[    0.038364] ACPI: APIC 0x00000000BFFE1511 000080 (v01 BOCHS  BXPCAPIC 00000001 BXPC 00000001)
[    0.039087] ACPI: HPET 0x00000000BFFE1591 000038 (v01 BOCHS  BXPCHPET 00000001 BXPC 00000001)
[    0.039802] ACPI: Reserving FACP table memory at [mem 0xbffe149d-0xbffe1510]
[    0.040393] ACPI: Reserving DSDT table memory at [mem 0xbffe0040-0xbffe149c]
[    0.040987] ACPI: Reserving FACS table memory at [mem 0xbffe0000-0xbffe003f]
[    0.041576] ACPI: Reserving APIC table memory at [mem 0xbffe1511-0xbffe1590]
[    0.042173] ACPI: Reserving HPET table memory at [mem 0xbffe1591-0xbffe15c8]
[    0.043023] RAMDISK: [mem 0x7ff58000-0x7fffffff]
[    0.043417] ACPI: Local APIC address 0xfee00000
[    0.043798] mapped APIC to ffffffffff5fd000 (        fee00000)
[    0.044425] Zone ranges:
[    0.044640]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.045164]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.045683]   Normal   [mem 0x0000000100000000-0x000000023fffffff]
[    0.046201]   Device   empty
[    0.046443] Movable zone start for each node
[    0.046800] Early memory node ranges
[    0.047096]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.047620]   node   0: [mem 0x0000000000100000-0x00000000bffdffff]
[    0.048148]   node   0: [mem 0x0000000100000000-0x000000023fffffff]
[    0.048673] Initmem setup node 0 [mem 0x0000000000001000-0x000000023fffffff]
[    0.049265] On node 0 totalpages: 2097022
[    0.049606]   DMA zone: 64 pages used for memmap
[    0.049993]   DMA zone: 21 pages reserved
[    0.050333]   DMA zone: 3998 pages, LIFO batch:0
[    0.050982]   DMA zone: 28770 pages in unavailable ranges
[    0.051434]   DMA32 zone: 12224 pages used for memmap
[    0.051861]   DMA32 zone: 782304 pages, LIFO batch:63
[    0.057426]   DMA32 zone: 32 pages in unavailable ranges
[    0.057901]   Normal zone: 20480 pages used for memmap
[    0.058333]   Normal zone: 1310720 pages, LIFO batch:63
[    0.067784] ACPI: PM-Timer IO Port: 0x608
[    0.068135] ACPI: Local APIC address 0xfee00000
[    0.068521] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
[    0.069030] IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI 0-23
[    0.069604] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.070139] Int: type 0, pol 0, trig 0, bus 00, IRQ 00, APIC ID 0, APIC INT 02
[    0.070743] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
[    0.071300] Int: type 0, pol 1, trig 3, bus 00, IRQ 05, APIC ID 0, APIC INT 05
[    0.071909] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.072461] Int: type 0, pol 1, trig 3, bus 00, IRQ 09, APIC ID 0, APIC INT 09
[    0.073070] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
[    0.073640] Int: type 0, pol 1, trig 3, bus 00, IRQ 0a, APIC ID 0, APIC INT 0a
[    0.074246] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)
[    0.074811] Int: type 0, pol 1, trig 3, bus 00, IRQ 0b, APIC ID 0, APIC INT 0b
[    0.075419] ACPI: IRQ0 used by override.
[    0.075748] Int: type 0, pol 0, trig 0, bus 00, IRQ 01, APIC ID 0, APIC INT 01
[    0.076353] Int: type 0, pol 0, trig 0, bus 00, IRQ 03, APIC ID 0, APIC INT 03
[    0.076962] Int: type 0, pol 0, trig 0, bus 00, IRQ 04, APIC ID 0, APIC INT 04
[    0.077568] ACPI: IRQ5 used by override.
[    0.077899] Int: type 0, pol 0, trig 0, bus 00, IRQ 06, APIC ID 0, APIC INT 06
[    0.078503] Int: type 0, pol 0, trig 0, bus 00, IRQ 07, APIC ID 0, APIC INT 07
[    0.079106] Int: type 0, pol 0, trig 0, bus 00, IRQ 08, APIC ID 0, APIC INT 08
[    0.079710] ACPI: IRQ9 used by override.
[    0.080039] ACPI: IRQ10 used by override.
[    0.080373] ACPI: IRQ11 used by override.
[    0.080709] Int: type 0, pol 0, trig 0, bus 00, IRQ 0c, APIC ID 0, APIC INT 0c
[    0.081322] Int: type 0, pol 0, trig 0, bus 00, IRQ 0d, APIC ID 0, APIC INT 0d
[    0.081925] Int: type 0, pol 0, trig 0, bus 00, IRQ 0e, APIC ID 0, APIC INT 0e
[    0.082524] Int: type 0, pol 0, trig 0, bus 00, IRQ 0f, APIC ID 0, APIC INT 0f
[    0.083134] Using ACPI (MADT) for SMP configuration information
[    0.083632] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.084067] smpboot: Allowing 2 CPUs, 0 hotplug CPUs
[    0.084485] mapped IOAPIC to ffffffffff5fc000 (fec00000)
[    0.084948] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.085582] PM: hibernation: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
[    0.086216] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000effff]
[    0.086847] PM: hibernation: Registered nosave memory: [mem 0x000f0000-0x000fffff]
[    0.087480] PM: hibernation: Registered nosave memory: [mem 0xbffe0000-0xbfffffff]
[    0.088110] PM: hibernation: Registered nosave memory: [mem 0xc0000000-0xfeffbfff]
[    0.088745] PM: hibernation: Registered nosave memory: [mem 0xfeffc000-0xfeffffff]
[    0.089382] PM: hibernation: Registered nosave memory: [mem 0xff000000-0xfffbffff]
[    0.090015] PM: hibernation: Registered nosave memory: [mem 0xfffc0000-0xffffffff]
[    0.090650] [mem 0xc0000000-0xfeffbfff] available for PCI devices
[    0.091161] Booting paravirtualized kernel on KVM
[    0.091553] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.095173] setup_percpu: NR_CPUS:64 nr_cpumask_bits:64 nr_cpu_ids:2 nr_node_ids:1
[    0.095999] percpu: Embedded 55 pages/cpu s185688 r8192 d31400 u1048576
[    0.096558] pcpu-alloc: s185688 r8192 d31400 u1048576 alloc=1*2097152
[    0.097105] pcpu-alloc: [0] 0 1
[    0.097389] kvm-guest: stealtime: cpu 0, msr 237c17fc0
[    0.097825] Built 1 zonelists, mobility grouping on.  Total pages: 2064233
[    0.098415] Kernel command line: root=/dev/ram0 hung_task_panic=1 debug apic=debug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=100 net.ifnames=0 printk.devkmsg=on panic=-1 softlockup_panic=1 nmi_watchdog=panic oops=panic load_ramdisk=2 prompt_ramdisk=0 drbd.minor_count=8 systemd.log_level=err ignore_loglevel console=tty0 earlyprintk=ttyS0,115200 console=ttyS0,115200 vga=normal rw rcuperf.shutdown=0 watchdog_thresh=60 run_self_test=1 threadirqs
[    0.101867] sysrq: sysrq always enabled.
[    0.102242] ignoring the deprecated load_ramdisk= option
[    0.103405] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
[    0.104406] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes, linear)
[    0.105090] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.110955] AGP: Checking aperture...
[    0.136611] AGP: No AGP bridge found
[    0.145794] Memory: 8150204K/8388088K available (12295K kernel code, 1678K rwdata, 3956K rodata, 1552K init, 1412K bss, 237624K reserved, 0K cma-reserved)
[    0.147013] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
[    0.147573] ftrace: allocating 36220 entries in 142 pages
[    0.155737] ftrace: allocated 142 pages with 4 groups
[    0.156335] rcu: Preemptible hierarchical RCU implementation.
[    0.156828] rcu:     RCU restricting CPUs from NR_CPUS=64 to nr_cpu_ids=2.
[    0.157390]  RCU CPU stall warnings timeout set to 100 (rcu_cpu_stall_timeout).
[    0.158009]  Trampoline variant of Tasks RCU enabled.
[    0.158436]  Rude variant of Tasks RCU enabled.
[    0.158818]  Tracing variant of Tasks RCU enabled.
[    0.159221] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
[    0.159867] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
[    0.162743] NR_IRQS: 4352, nr_irqs: 440, preallocated irqs: 16
[    0.163398] random: get_random_bytes called from start_kernel+0x3eb/0x5b5 with crng_init=0
[    0.169694] Console: colour VGA+ 80x25
[    0.196697] printk: console [tty0] enabled
[    0.197196] printk: console [ttyS0] enabled
[    0.197196] printk: console [ttyS0] enabled
[    0.198039] printk: bootconsole [earlyser0] disabled
[    0.198039] printk: bootconsole [earlyser0] disabled
[    0.199025] ACPI: Core revision 20210105
[    0.199568] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604467 ns
[    0.200616] APIC: Switch to symmetric I/O mode setup
[    0.201302] x2apic enabled
[    0.201757] Switched APIC routing to physical x2apic.
[    0.202433] masked ExtINT on CPU#0
[    0.203204] ENABLING IO-APIC IRQs
[    0.203615] init IO_APIC IRQs
[    0.203986]  apic 0 pin 0 not connected
[    0.204441] IOAPIC[0]: Preconfigured routing entry (0-1 -> IRQ 1 Level:0 ActiveLow:0)
[    0.205352] IOAPIC[0]: Preconfigured routing entry (0-2 -> IRQ 0 Level:0 ActiveLow:0)
[    0.206218] IOAPIC[0]: Preconfigured routing entry (0-3 -> IRQ 3 Level:0 ActiveLow:0)
[    0.207089] IOAPIC[0]: Preconfigured routing entry (0-4 -> IRQ 4 Level:0 ActiveLow:0)
[    0.207952] IOAPIC[0]: Preconfigured routing entry (0-5 -> IRQ 5 Level:1 ActiveLow:0)
[    0.208827] IOAPIC[0]: Preconfigured routing entry (0-6 -> IRQ 6 Level:0 ActiveLow:0)
[    0.209687] IOAPIC[0]: Preconfigured routing entry (0-7 -> IRQ 7 Level:0 ActiveLow:0)
[    0.210549] IOAPIC[0]: Preconfigured routing entry (0-8 -> IRQ 8 Level:0 ActiveLow:0)
[    0.211415] IOAPIC[0]: Preconfigured routing entry (0-9 -> IRQ 9 Level:1 ActiveLow:0)
[    0.212277] IOAPIC[0]: Preconfigured routing entry (0-10 -> IRQ 10 Level:1 ActiveLow:0)
[    0.213203] IOAPIC[0]: Preconfigured routing entry (0-11 -> IRQ 11 Level:1 ActiveLow:0)
[    0.214085] IOAPIC[0]: Preconfigured routing entry (0-12 -> IRQ 12 Level:0 ActiveLow:0)
[    0.214971] IOAPIC[0]: Preconfigured routing entry (0-13 -> IRQ 13 Level:0 ActiveLow:0)
[    0.215850] IOAPIC[0]: Preconfigured routing entry (0-14 -> IRQ 14 Level:0 ActiveLow:0)
[    0.216737] IOAPIC[0]: Preconfigured routing entry (0-15 -> IRQ 15 Level:0 ActiveLow:0)
[    0.217635]  apic 0 pin 16 not connected
[    0.218099]  apic 0 pin 17 not connected
[    0.218559]  apic 0 pin 18 not connected
[    0.219022]  apic 0 pin 19 not connected
[    0.219483]  apic 0 pin 20 not connected
[    0.219945]  apic 0 pin 21 not connected
[    0.220406]  apic 0 pin 22 not connected
[    0.220902]  apic 0 pin 23 not connected
[    0.221471] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.222131] tsc: Marking TSC unstable due to TSCs unsynchronized
[    0.222784] Calibrating delay loop (skipped) preset value.. 7400.26 BogoMIPS (lpj=14800536)
[    0.223697] pid_max: default: 32768 minimum: 301
[    0.224231] LSM: Security Framework initializing
[    0.226788] Yama: becoming mindful.
[    0.227217] AppArmor: AppArmor initialized
[    0.227694] TOMOYO Linux initialized
[    0.228131] Mount-cache hash table entries: 16384 (order: 5, 131072 bytes, linear)
[    0.229101] Mountpoint-cache hash table entries: 16384 (order: 5, 131072 bytes, linear)
Poking KASLR using RDTSC...
[    0.230332] mce: Couldn't allocate MCE records pool!
[    0.230786] Last level iTLB entries: 4KB 512, 2MB 255, 4MB 127
[    0.231419] Last level dTLB entries: 4KB 512, 2MB 255, 4MB 127, 1GB 0
[    0.232119] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.233047] Spectre V2 : Mitigation: Full AMD retpoline
[    0.233624] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.235407] Freeing SMP alternatives memory: 32K
[    0.235958] BUG: kernel NULL pointer dereference, address: 000000000000084c
[    0.236707] #PF: supervisor write access in kernel mode
[    0.237292] #PF: error_code(0x0002) - not-present page
[    0.237870] PGD 0 P4D 0
[    0.238202] Oops: 0002 [#1] PREEMPT SMP NOPTI
[    0.238703] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.12.0-rc4-next-20210329+ #497
[    0.238783] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[    0.238783] RIP: 0010:_raw_spin_lock_irqsave+0x2c/0x50
[    0.238783] Code: 44 00 00 55 53 48 89 fb 9c 58 0f 1f 44 00 00 48 89 c5 fa 66 0f 1f 44 00 00 bf 01 00 00 00 e8 cb 49 85 ff 31 c0 ba 01 00 00 00 <f0> 0f b1 13 75 06 48 89 e8 5b 5d c3 89 c6 48 89 df e8 ee d2 87 ff
[    0.238783] RSP: 0000:ffffffffac203e70 EFLAGS: 00010046
[    0.238783] RAX: 0000000000000000 RBX: 000000000000084c RCX: 0000000000000000
[    0.238783] RDX: 0000000000000001 RSI: ffffffffac203ec0 RDI: 0000000000000001
[    0.238783] RBP: 0000000000000246 R08: ffffffffac2df9e0 R09: ffff995b40049940
[    0.238783] R10: 0000000000000000 R11: ffffffffac23a7c8 R12: ffffffffac162900
[    0.238783] R13: 000000000000084c R14: 0000000000000000 R15: 0000000000000000
[    0.238783] FS:  0000000000000000(0000) GS:ffff995c77c00000(0000) knlGS:0000000000000000
[    0.238783] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.238783] CR2: 000000000000084c CR3: 00000001e900a000 CR4: 00000000000006b0
[    0.238783] Call Trace:
[    0.238783]  task_rq_lock+0x32/0xf0
[    0.238783]  __set_cpus_allowed_ptr+0x32/0x160
[    0.238783]  rest_init+0x56/0xb5
[    0.238783]  start_kernel+0x592/0x5b5
[    0.238783]  secondary_startup_64_no_verify+0xb0/0xbb
[    0.238783] Modules linked in:
[    0.238783] CR2: 000000000000084c
[    0.238783] ---[ end trace 7ce8c1a275774645 ]---
[    0.238783] RIP: 0010:_raw_spin_lock_irqsave+0x2c/0x50
[    0.238783] Code: 44 00 00 55 53 48 89 fb 9c 58 0f 1f 44 00 00 48 89 c5 fa 66 0f 1f 44 00 00 bf 01 00 00 00 e8 cb 49 85 ff 31 c0 ba 01 00 00 00 <f0> 0f b1 13 75 06 48 89 e8 5b 5d c3 89 c6 48 89 df e8 ee d2 87 ff
[    0.238783] RSP: 0000:ffffffffac203e70 EFLAGS: 00010046
[    0.238783] RAX: 0000000000000000 RBX: 000000000000084c RCX: 0000000000000000
[    0.238783] RDX: 0000000000000001 RSI: ffffffffac203ec0 RDI: 0000000000000001
[    0.238783] RBP: 0000000000000246 R08: ffffffffac2df9e0 R09: ffff995b40049940
[    0.238783] R10: 0000000000000000 R11: ffffffffac23a7c8 R12: ffffffffac162900
[    0.238783] R13: 000000000000084c R14: 0000000000000000 R15: 0000000000000000
[    0.238783] FS:  0000000000000000(0000) GS:ffff995c77c00000(0000) knlGS:0000000000000000
[    0.238783] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.238783] CR2: 000000000000084c CR3: 00000001e900a000 CR4: 00000000000006b0
[    0.238783] Kernel panic - not syncing: Fatal exception
urezki@pc638:~/data/raid0/coding/linux-next.git$

--
Vlad Rezki
