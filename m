Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D202F309864
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 21:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbhA3U7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 15:59:41 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:54853 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230036AbhA3U7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 15:59:39 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 70640EB2;
        Sat, 30 Jan 2021 15:58:53 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sat, 30 Jan 2021 15:58:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        to:cc:references:from:subject:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm1; bh=6
        AJfAjYN/yzq9a2IYeDeI2tPOPgXBjKjRLa6jhdvs/o=; b=UXyAUm6lE5iSBqNvT
        5tuFSAScEfBxbFdjVkhVj0vo0QbtxSiik09rz3HQPtsF/zdhny5CDJsh4U16hGD0
        sUtHond+/jnOAuE11oGSAguKMLIUacuNhBHRqLDIORFvFh9q/W58qendYsBFX8HB
        r3O6aB1wUQM5qyqY9f8qx86ZvknIrJeRengEgpVFJ3yhjf5RWLONVkPeLBDJgu8P
        omJTX0C9D7Map41xpqTT1tqX7KJgHgUyCsFubEfXM5OBtwxJ2zBxllGRvs7CWBpS
        2IIpAEB/NzpZi8umbF3Vk6e1l3/H1c3ezDwWX7CZ7/tsR8CuSEYjCLm27SqqI1wR
        ead1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=6AJfAjYN/yzq9a2IYeDeI2tPOPgXBjKjRLa6jhdvs
        /o=; b=QFQCN85PxojsVMzIOymnCXSDrMUguISw2Hb+RQhLxqEi08yH9GAbYY9x8
        DJwOTzyb0gpbzhm5UPsozb1tEH5I4QWmX+J2xj3Hq9Jm5zZf70ktUJnMrj9KxCk1
        xyZQ4xGXkrKbRA7z0e0ChekccrLcgs2Nyo2xYC6s57rq+Oy/yfvSitIPZawtj8c4
        fbGAY7AM98FtVk2MP57NfRNYYk6C/ZvLpcJ19HGq8h2ei7LFb3HbabnC15Kyk9oG
        K4lIHf3Rno/sqpb0JrizLqH/9QcMJM+XFb3m+vXWBxSfWImmUuQYpY0jNBXa9BLc
        qesjivle7GwaRhiH0gzEcm+KYEDeg==
X-ME-Sender: <xms:i8gVYF-bY1rh-UVdkIvZTyV9CTI6yV-wGh5Zhze8Jb8e0mSZiYzz0A>
    <xme:i8gVYJudit-pFBD-e1WaLVoFcO5DRT-qCP4sZsVf5pDDzFZegc4v_YLctDmg3eS4_
    -KLaKUI18-fCLY05w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeeggddugeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefvfhfhuffkffgfgggjtgfgsehtke
    ertddtfeejnecuhfhrohhmpefurghmuhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhes
    shhhohhllhgrnhgurdhorhhgqeenucggtffrrghtthgvrhhnpedvvddttdefhefgieektd
    euvdduhfeileevieeujeehuefggedvueeitdduleffieenucffohhmrghinhepkhgvrhhn
    vghlrdhorhhgnecukfhppeejtddrudefhedrudegkedrudehudenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgr
    nhgurdhorhhg
X-ME-Proxy: <xmx:i8gVYDC14mMwJFxPnvgO4JuOzFbbMrFlA3CYh1aplK1n_LBjmewYPw>
    <xmx:i8gVYJexcyNlnFcrQYIVxXw57G3weAqEE8lxqAdv3M3LsnwTpf1ypg>
    <xmx:i8gVYKMLSO_74jn0DdtIsfJ7AkuLD4l5a77jRapEZli8BBsOVsTlzg>
    <xmx:jcgVYB0fD6R2IqLSf70a3LvHH7sdfjMEjUzT2MSmXMWogDvEvKY-mA>
Received: from [70.135.148.151] (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 33B6B108005B;
        Sat, 30 Jan 2021 15:58:51 -0500 (EST)
To:     Corentin Labbe <clabbe.montjoie@gmail.com>, mripard@kernel.org,
        wens@csie.org, jernej.skrabec@siol.net
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
References: <YBWQvzQNC1iYUXoG@Red>
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: Fail to boot on bpim3 with next-20210128
Message-ID: <f5f54184-f8ef-25bf-b63b-ed35a1099d97@sholland.org>
Date:   Sat, 30 Jan 2021 14:58:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux ppc64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <YBWQvzQNC1iYUXoG@Red>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/30/21 11:00 AM, Corentin Labbe wrote:
> Hello
> 
> next-20210128 cannot be booted on my bpim3.
> It start booting then freeze.
> 
> [    0.000000] Linux version 5.11.0-rc5-03084-g7426957d237f (compile@Red) (armv7a-unknown-linux-gnueabihf-gcc (Gentoo 9.3.0-r2 p4) 9.3.0, GNU ld (Gentoo 2.34 p6) 2.34.0) #390 SMP Sat Jan 30 14:59:48 CET 2021
> [    0.000000] CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7), cr=10c5387d
> [    0.000000] CPU: div instructions available: patching division code
> [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
> [    0.000000] OF: fdt: Machine model: Banana Pi BPI-M3
> [    0.000000] earlycon: uart0 at MMIO32 0x01c28000 (options '')
> [    0.000000] printk: bootconsole [uart0] enabled
> [    0.000000] Memory policy: Data cache writealloc
> [    0.000000] cma: Reserved 16 MiB at 0xbf000000
> [    0.000000] Zone ranges:
> [    0.000000]   Normal   [mem 0x0000000040000000-0x000000006fffffff]
> [    0.000000]   HighMem  [mem 0x0000000070000000-0x00000000bfffffff]
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x0000000040000000-0x00000000bfffffff]
> [    0.000000] Initmem setup node 0 [mem 0x0000000040000000-0x00000000bfffffff]
> [    0.000000] percpu: Embedded 15 pages/cpu s31244 r8192 d22004 u61440
> [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 522752
> [    0.000000] Kernel command line: console=ttyS0,115200n8 root=/dev/ram0 earlycon=uart,mmio32,0x01c28000 ip=dhcp
> [    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes, linear)
> [    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes, linear)
> [    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
> [    0.000000] Memory: 2021376K/2097152K available (7168K kernel code, 934K rwdata, 2316K rodata, 1024K init, 240K bss, 59392K reserved, 16384K cma-reserved, 1294336K highmem)
> [    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
> [    0.000000] rcu: Hierarchical RCU implementation.
> [    0.000000] rcu: 	RCU event tracing is enabled.
> [    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.
> [    0.000000] NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
> [    0.000000] random: get_random_bytes called from start_kernel+0x350/0x4e0 with crng_init=0
> [    0.000000] arch_timer: cp15 timer(s) running at 24.00MHz (virt).
> [    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x588fe9dc0, max_idle_ns: 440795202592 ns
> [    0.000003] sched_clock: 56 bits at 24MHz, resolution 41ns, wraps every 4398046511097ns
> [    0.008640] Switching to timer-based delay loop, resolution 41ns
> [    0.015437] clocksource: timer: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 79635851949 ns
> [    0.025858] Console: colour dummy device 80x30
> [    0.030736] Calibrating delay loop (skipped), value calculated using timer frequency.. 48.00 BogoMIPS (lpj=240000)
> [    0.041941] pid_max: default: 32768 minimum: 301
> [    0.047080] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes, linear)
> [    0.054990] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes, linear)
> [    0.064421] CPU: Testing write buffer coherency: ok
> [    0.070242] /cpus/cpu@0 missing clock-frequency property
> [    0.076025] /cpus/cpu@1 missing clock-frequency property
> [    0.081805] /cpus/cpu@2 missing clock-frequency property
> [    0.087546] /cpus/cpu@3 missing clock-frequency property
> [    0.093300] /cpus/cpu@100 missing clock-frequency property
> [    0.099227] /cpus/cpu@101 missing clock-frequency property
> [    0.105173] /cpus/cpu@102 missing clock-frequency property
> [    0.111111] /cpus/cpu@103 missing clock-frequency property
> [    0.117026] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
> [    0.123888] Setting up static identity map for 0x40100000 - 0x40100060
> [    0.131237] ARM CCI driver probed
> [    0.135530] sunxi multi cluster SMP support installed
> [    0.141501] rcu: Hierarchical SRCU implementation.
> [    0.147277] smp: Bringing up secondary CPUs ...
> [    0.153237] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
> [    0.154443] CPU2: thread -1, cpu 2, socket 0, mpidr 80000002
> [    0.155544] CPU3: thread -1, cpu 3, socket 0, mpidr 80000003
> [    0.156837] CPU4: thread -1, cpu 0, socket 1, mpidr 80000100
> [    0.158221] CPU5: thread -1, cpu 1, socket 1, mpidr 80000101
> [    0.159456] CPU6: thread -1, cpu 2, socket 1, mpidr 80000102
> [    0.160663] CPU7: thread -1, cpu 3, socket 1, mpidr 80000103
> [    0.160825] smp: Brought up 1 node, 8 CPUs
> [    0.207953] SMP: Total of 8 processors activated (384.00 BogoMIPS).
> [    0.214714] CPU: All CPU(s) started in SVC mode.
> [    0.221355] devtmpfs: initialized
> [    0.232737] VFP support v0.3: implementor 41 architecture 2 part 30 variant 7 rev 5
> [    0.241442] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
> [    0.252094] futex hash table entries: 2048 (order: 5, 131072 bytes, linear)
> [    0.261021] pinctrl core: initialized pinctrl subsystem
> [    0.268330] NET: Registered protocol family 16
> [    0.275235] DMA: preallocated 256 KiB pool for atomic coherent allocations
> [    0.284035] thermal_sys: Registered thermal governor 'step_wise'
> [    0.285104] hw-breakpoint: found 5 (+1 reserved) breakpoint and 4 watchpoint registers.
> [    0.300247] hw-breakpoint: maximum watchpoint size is 8 bytes.
> [    0.316313] irq: type mismatch, failed to map hwirq-0 for interrupt-controller@1f00c00!
> [    0.328179] irq: type mismatch, failed to map hwirq-0 for interrupt-controller@1f00c00!

[...]

> I bisected the problem to:
> ARM: dts: sunxi: Move wakeup-capable IRQs to r_intc
> 
> Reverting it permit a successfully boot.

This is due to next-20210128 including the device tree updates from
sunxi/sunxi/dt-for-5.12-late, but not the new driver from
irqchip/irq/irqchip-5.12. From [1]:

Merging irqchip/irq/irqchip-next (599b3063adf4 irqchip/mips-cpu: Set IPI
domain parent chip)

Where 599b3063adf4 is tag: irqchip-fixes-5.11-1.

Since then, irqchip/irq/irqchip-next has been updated to
irqchip/irq/irqchip-5.12, so this will be resolved in the next
linux-next release.

Cheers,
Samuel

[1]: https://lore.kernel.org/lkml/20210128201131.608c16ee@canb.auug.org.au/
