Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB2631E84C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 10:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbhBRJzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 04:55:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbhBRIta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 03:49:30 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA74C061788
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 00:48:07 -0800 (PST)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id BD27922237;
        Thu, 18 Feb 2021 09:46:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1613637982;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VcnaU9Fh0i3qMNdhVKTcPf6Br1ClwoiRFt9mT7ZLt6o=;
        b=BtBz9xvaU5rqdk22wrnLJot9LWmlexGnPvI5OeASHJWTwMIsIHJVm1i0OF6gj4aGUQaKxZ
        8kOUsar48TBJeXmq9nt4EuGX82iaZvjVjVzEXgq6FWlGvVdYC84DanOv9zZ7olXTcWAtM1
        TLdvW3xf3lfT2NMT+lNyKJKBt71Plkg=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 18 Feb 2021 09:46:22 +0100
From:   Michael Walle <michael@walle.cc>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, maz@kernel.org, tglx@linutronix.de
Subject: Re: [PATCH] irqdomain: remove debugfs_file from struct irq_domain
In-Reply-To: <YC4oGsBTyMJrGJ9C@kroah.com>
References: <YCvYV53ZdzQSWY6w@kroah.com>
 <20210217195717.13727-1-michael@walle.cc> <YC4oGsBTyMJrGJ9C@kroah.com>
User-Agent: Roundcube Webmail/1.4.10
Message-ID: <c209f6c778469aaa347862c5be2f2251@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2021-02-18 09:40, schrieb Greg KH:
> On Wed, Feb 17, 2021 at 08:57:17PM +0100, Michael Walle wrote:
>> Hi Greg,
>> 
>> > There's no need to keep around a dentry pointer to a simple file that
>> > debugfs itself can look up when we need to remove it from the system.
>> > So simplify the code by deleting the variable and cleaning up the logic
>> > around the debugfs file.
>> 
>> This will generate the following oops on my board (arm64,
>> freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dts). In debugfs_lookup()
>> debugfs_mount is NULL.
>> 
>> [    0.000000] Linux version 5.11.0-next-20210217-00014-g41e0e92a2d05 
>> (mwalle@mwalle01) (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0, GNU 
>> ld (GNU Binutils for Debian) 2.31.1) #69 SMP PREEMPT Wed Feb 17 
>> 20:47:10 CET 2021
>> [..]
>> [    0.000000] Unable to handle kernel NULL pointer dereference at 
>> virtual address 0000000000000000
>> [    0.000000] Mem abort info:
>> [    0.000000]   ESR = 0x96000004
> 
> <snip>
> 
> Back to this log, do you see:
> 	"Unable to pin filesystem for file "
> anywhere before this crash?

No.

Here is the complete log:

[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd083]
[    0.000000] Linux version 
5.11.0-next-20210217-00013-g960bc30321c0-dirty (mwalle@mwalle01) 
(aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0, GNU ld (GNU Binutils for 
Debian) 2.31.1) #73 SMP PREEMPT Thu Feb 18 09:19:21 CET 2021
[    0.000000] Machine model: Kontron SMARC-sAL28 (Single PHY) on SMARC 
Eval 2.0 carrier
[    0.000000] efi: UEFI not found.
[    0.000000] earlycon: ns16550a0 at MMIO 0x00000000021c0500 (options 
'115200n8')
[    0.000000] printk: bootconsole [ns16550a0] enabled
[    0.000000] NUMA: No NUMA configuration found
[    0.000000] NUMA: Faking a node at [mem 
0x0000000080000000-0x00000020ffffffff]
[    0.000000] NUMA: NODE_DATA [mem 0x20ff7d9200-0x20ff7dafff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000000000-0x00000000ffffffff]
[    0.000000]   DMA32    empty
[    0.000000]   Normal   [mem 0x0000000100000000-0x00000020ffffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000080000000-0x00000000ffffffff]
[    0.000000]   node   0: [mem 0x0000002080000000-0x00000020ffffffff]
[    0.000000] Initmem setup node 0 [mem 
0x0000000080000000-0x00000020ffffffff]
[    0.000000] On node 0 totalpages: 1048576
[    0.000000]   DMA zone: 8192 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 524288 pages, LIFO batch:63
[    0.000000]   Normal zone: 8192 pages used for memmap
[    0.000000]   Normal zone: 524288 pages, LIFO batch:63
[    0.000000] cma: Reserved 32 MiB at 0x00000000fcc00000
[    0.000000] percpu: Embedded 31 pages/cpu s89752 r8192 d29032 u126976
[    0.000000] pcpu-alloc: s89752 r8192 d29032 u126976 alloc=31*4096
[    0.000000] pcpu-alloc: [0] 0 [0] 1
[    0.000000] Detected PIPT I-cache on CPU0
[    0.000000] CPU features: detected: GIC system register CPU interface
[    0.000000] CPU features: detected: Spectre-v3a
[    0.000000] CPU features: detected: Spectre-v2
[    0.000000] CPU features: detected: Spectre-v4
[    0.000000] CPU features: detected: ARM errata 1165522, 1319367, or 
1530923
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 
1032192
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: debug root=/dev/mmcblk0p2 rootwait 
earlycon
[    0.000000] Dentry cache hash table entries: 524288 (order: 10, 
4194304 bytes, linear)
[    0.000000] Inode-cache hash table entries: 262144 (order: 9, 2097152 
bytes, linear)
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] software IO TLB: mapped [mem 
0x00000000f8c00000-0x00000000fcc00000] (64MB)
[    0.000000] Memory: 3986440K/4194304K available (14912K kernel code, 
2164K rwdata, 5876K rodata, 4864K init, 849K bss, 175096K reserved, 
32768K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, 
Nodes=1
[    0.000000] ftrace: allocating 52190 entries in 204 pages
[    0.000000] ftrace: allocated 204 pages with 4 groups
[    0.000000] rcu: Preemptible hierarchical RCU implementation.
[    0.000000] rcu: 	RCU restricting CPUs from NR_CPUS=256 to 
nr_cpu_ids=2.
[    0.000000] 	Trampoline variant of Tasks RCU enabled.
[    0.000000] 	Rude variant of Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay 
is 25 jiffies.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, 
nr_cpu_ids=2
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] GICv3: GIC: Using split EOI/Deactivate mode
[    0.000000] GICv3: 256 SPIs implemented
[    0.000000] GICv3: 0 Extended SPIs implemented
[    0.000000] Unable to handle kernel NULL pointer dereference at 
virtual address 0000000000000000
[    0.000000] Mem abort info:
[    0.000000]   ESR = 0x96000004
[    0.000000]   EC = 0x25: DABT (current EL), IL = 32 bits
[    0.000000]   SET = 0, FnV = 0
[    0.000000]   EA = 0, S1PTW = 0
[    0.000000] Data abort info:
[    0.000000]   ISV = 0, ISS = 0x00000004
[    0.000000]   CM = 0, WnR = 0
[    0.000000] [0000000000000000] user address but active_mm is swapper
[    0.000000] Internal error: Oops: 96000004 [#1] PREEMPT SMP
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 
5.11.0-next-20210217-00013-g960bc30321c0-dirty #73
[    0.000000] Hardware name: Kontron SMARC-sAL28 (Single PHY) on SMARC 
Eval 2.0 carrier (DT)
[    0.000000] pstate: 00000085 (nzcv daIf -PAN -UAO -TCO BTYPE=--)
[    0.000000] pc : debugfs_lookup+0x5c/0x94
[    0.000000] lr : debugfs_lookup+0x3c/0x94
[    0.000000] sp : ffff800011933ca0
[    0.000000] x29: ffff800011933ca0 x28: 0000000000000000
[    0.000000] x27: 0000000000000000 x26: 0000000000000001
[    0.000000] x25: ffff00200016f100 x24: ffff800010f19750
[    0.000000] x23: ffff80001193d000 x22: ffff800011939948
[    0.000000] x21: ffff8000119cbcc8 x20: 0000000000000000
[    0.000000] x19: ffff00200016f200 x18: 0000000000000010
[    0.000000] x17: 0000000000007fff x16: 00000000ffffffff
[    0.000000] x15: ffffffffffffffff x14: ffff800011939948
[    0.000000] x13: ffff8000919339a7 x12: ffff8000119cb670
[    0.000000] x11: 0000000000000003 x10: ffff8000119b3630
[    0.000000] x9 : ffff800010102bc4 x8 : 0000000000017fe8
[    0.000000] x7 : c0000000ffffefff x6 : 0000000000000001
[    0.000000] x5 : 0000000000000000 x4 : 0000000000000000
[    0.000000] x3 : 00000000ffffffff x2 : 0000000000000000
[    0.000000] x1 : 0000000000000000 x0 : 0000000000000000
[    0.000000] Call trace:
[    0.000000]  debugfs_lookup+0x5c/0x94
[    0.000000]  debugfs_remove_domain_dir+0x24/0x38
[    0.000000]  irq_domain_update_bus_token+0x6c/0xb8
[    0.000000]  gic_init_bases+0x19c/0x64c
[    0.000000]  gic_of_init+0x188/0x228
[    0.000000]  of_irq_init+0x1a8/0x350
[    0.000000]  irqchip_init+0x20/0x48
[    0.000000]  init_IRQ+0xd4/0x178
[    0.000000]  start_kernel+0x628/0x85c
[    0.000000]  0x0
[    0.000000] Code: 540001a8 b5000094 b0006ca0 f947d000 (f9400014)
[    0.000000] random: get_random_bytes called from 
print_oops_end_marker+0x34/0x60 with crng_init=0
[    0.000000] ---[ end trace 0000000000000000 ]---
[    0.000000] Kernel panic - not syncing: Attempted to kill the idle 
task!
[    0.000000] ---[ end Kernel panic - not syncing: Attempted to kill 
the idle task! ]---

-michael
