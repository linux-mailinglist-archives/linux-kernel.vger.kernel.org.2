Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E76F53BA46B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 21:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbhGBTsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 15:48:17 -0400
Received: from mail-il1-f177.google.com ([209.85.166.177]:38472 "EHLO
        mail-il1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbhGBTsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 15:48:15 -0400
Received: by mail-il1-f177.google.com with SMTP id v5so10789867ilo.5
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jul 2021 12:45:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8ZCaTOtKOmaECjUZfJZF5e028vU3AHeghf5wymLFvVc=;
        b=WLLSwsHwMLcXL8Gahsi6NYxuZayr/5Jmwg8KqOl+XvIVT3wNYOMcLD4fEgJb5f+aYj
         yw0f5qUADqYj8DMTNvcB/mVr8QE8WSQpTMyZajgb7RiOrljeFnzRyOcshyQEBV1jR45U
         WoV4WLUVFr+6MZXl44K7p9DDF9trSKoCBpZz7SaN9mHQRL8IHlFYm+QWCTPz6JbXfWzj
         LHxpFBiOJFHi6xeFXOFkwa5y2N8+vTX8myblye1TlwN6nwRNcT+kL1wMCqIINJxxc6tY
         akHK97Amt4FLPVr9hbXO7suau33dz6SWcrDCbAjzQ88OewysgyFyHTxoUp03atsO/77c
         2v+A==
X-Gm-Message-State: AOAM530fXF/TEUhm1GfKyr3Yi/WWSEj0DaM/0A9xdorp3l5RzzWHIT36
        ydfYQVzg3qbTKEUUNI7fok8=
X-Google-Smtp-Source: ABdhPJzddEkcOXqeLTAvSkWpj9y6VcywcFxp1nqM6JldQZ7QTkFA/3niMuAb2Cft7THvaj9TSinaMA==
X-Received: by 2002:a92:ad03:: with SMTP id w3mr999238ilh.225.1625255142229;
        Fri, 02 Jul 2021 12:45:42 -0700 (PDT)
Received: from google.com (243.199.238.35.bc.googleusercontent.com. [35.238.199.243])
        by smtp.gmail.com with ESMTPSA id d5sm2187728ilf.55.2021.07.02.12.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 12:45:41 -0700 (PDT)
Date:   Fri, 2 Jul 2021 19:45:40 +0000
From:   Dennis Zhou <dennis@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] percpu: implement partial chunk depopulation
Message-ID: <YN9s5HLjNeb1lxMK@google.com>
References: <20210419225047.3415425-1-dennis@kernel.org>
 <20210419225047.3415425-4-dennis@kernel.org>
 <20210702191140.GA3166599@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210702191140.GA3166599@roeck-us.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Jul 02, 2021 at 12:11:40PM -0700, Guenter Roeck wrote:
> Hi,
> 
> On Mon, Apr 19, 2021 at 10:50:46PM +0000, Dennis Zhou wrote:
> > From: Roman Gushchin <guro@fb.com>
> > 
> > This patch implements partial depopulation of percpu chunks.
> > 
> > As of now, a chunk can be depopulated only as a part of the final
> > destruction, if there are no more outstanding allocations. However
> > to minimize a memory waste it might be useful to depopulate a
> > partially filed chunk, if a small number of outstanding allocations
> > prevents the chunk from being fully reclaimed.
> > 
> > This patch implements the following depopulation process: it scans
> > over the chunk pages, looks for a range of empty and populated pages
> > and performs the depopulation. To avoid races with new allocations,
> > the chunk is previously isolated. After the depopulation the chunk is
> > sidelined to a special list or freed. New allocations prefer using
> > active chunks to sidelined chunks. If a sidelined chunk is used, it is
> > reintegrated to the active lists.
> > 
> > The depopulation is scheduled on the free path if the chunk is all of
> > the following:
> >   1) has more than 1/4 of total pages free and populated
> >   2) the system has enough free percpu pages aside of this chunk
> >   3) isn't the reserved chunk
> >   4) isn't the first chunk
> > If it's already depopulated but got free populated pages, it's a good
> > target too. The chunk is moved to a special slot,
> > pcpu_to_depopulate_slot, chunk->isolated is set, and the balance work
> > item is scheduled. On isolation, these pages are removed from the
> > pcpu_nr_empty_pop_pages. It is constantly replaced to the
> > to_depopulate_slot when it meets these qualifications.
> > 
> > pcpu_reclaim_populated() iterates over the to_depopulate_slot until it
> > becomes empty. The depopulation is performed in the reverse direction to
> > keep populated pages close to the beginning. Depopulated chunks are
> > sidelined to preferentially avoid them for new allocations. When no
> > active chunk can suffice a new allocation, sidelined chunks are first
> > checked before creating a new chunk.
> > 
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> > Co-developed-by: Dennis Zhou <dennis@kernel.org>
> > Signed-off-by: Dennis Zhou <dennis@kernel.org>
> 
> This patch results in a number of crashes and other odd behavior
> when trying to boot mips images from Megasas controllers in qemu.
> Sometimes the boot stalls, but I also see various crashes.
> Some examples and bisect logs are attached.

Ah, this doesn't look good.. Do you have a reproducer I could use to
debug this?

Thanks,
Dennis

> 
> Note: Bisect on mainline ended with
> 
> # first bad commit: [e267992f9ef0bf717d70a9ee18049782f77e4b3a] Merge branch 'for-5.14' of git://git.kernel.org/pub/scm/l
> inux/kernel/git/dennis/percpu
> 
> I then checked out the merge branch and ran a bisect there, which
> points to this commit. I also rebased the merge branch to v5.13
> and bisected again. Bisect results were the same.
> 
> Guenter
> 
> ---
> ...
> sd 0:2:0:0: [sda] Add. Sense: Internal target failure
> CPU 0 Unable to handle kernel paging request at virtual address 00000004, epc == 805cf8fc, ra == 802ff3b0
> Oops[#1]:
> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.13.0-00005-g0bd2212ebd7a #1
> $ 0   : 00000000 00000001 00000000 8258fc90
> $ 4   : 825dbd40 820e7624 00000000 fffffff0
> $ 8   : 80c70000 805e1a64 fffffffc 00000000
> $12   : 81006d00 0000001f ffffffe0 00001e83
> $16   : 00000000 825dbd30 80c70000 820e75f8
> $20   : 8275c584 80cc4418 80c9409c 00000008
> $24   : 0000004c 00000000
> $28   : 8204c000 8204fc70 80c26c54 802ff3b0
> Hi    : 0000004c
> Lo    : 00000000
> epc   : 805cf8fc rb_insert_color+0x1c/0x1e0
> ra    : 802ff3b0 kernfs_link_sibling+0x94/0x120
> Status: 1000a403	KERNEL EXL IE
> Cause : 00800008 (ExcCode 02)
> BadVA : 00000004
> PrId  : 00019300 (MIPS 24Kc)
> Modules linked in:
> Process swapper/0 (pid: 1, threadinfo=(ptrval), task=(ptrval), tls=00000000)
> Stack : 820e75f8 820e75f8 820e75f8 00000000 8275c584 fffffffe 825dbd30 8030084c
>         820e75f8 803003f8 00000000 db668853 00000000 801655f4 00000000 00000000
>         00000001 825dbd30 820e75f8 820e75f8 00000000 80300970 81006c80 82150fc0
>         8204fd64 00000001 00000000 00000001 00000000 00000000 82150fc0 8275c580
>         80c50000 80303dc8 82150fc0 8015ab94 81006c80 8015a960 00000000 8275c580
>         ...
> Call Trace:
> [<805cf8fc>] rb_insert_color+0x1c/0x1e0
> [<802ff3b0>] kernfs_link_sibling+0x94/0x120
> [<8030084c>] kernfs_add_one+0xb8/0x184
> [<80300970>] kernfs_create_dir_ns+0x58/0xb0
> [<80303dc8>] sysfs_create_dir_ns+0x74/0x108
> [<805ca51c>] kobject_add_internal+0xb4/0x364
> [<805caaa0>] kobject_init_and_add+0x64/0xa8
> [<8066f768>] bus_add_driver+0x98/0x230
> [<806715a0>] driver_register+0x80/0x144
> [<807c17b8>] usb_register_driver+0xa8/0x1c0
> [<80cb89b8>] uas_init+0x44/0x78
> [<8010065c>] do_one_initcall+0x50/0x1d4
> [<80c95014>] kernel_init_freeable+0x20c/0x29c
> [<80a66bd4>] kernel_init+0x14/0x118
> [<80103098>] ret_from_kernel_thread+0x14/0x1c
> 
> Code: 30460001  14c00016  240afffc <8c460004> 34480001  10c30028  00404825  10c00012  00000000
> 
> ---[ end trace bb7aba36814796cb ]---
> Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
> 
> ---
> scsi host0: Avago SAS based MegaRAID driver
> ata_piix 0000:00:0a.1: enabling device (0000 -> 0001)
> random: fast init done
> scsi 0:2:0:0: Direct-Access     QEMU     QEMU HARDDISK    2.5+ PQ: 0 ANSI: 5
> scsi host1: ata_piix
> BUG: spinlock bad magic on CPU#0, kworker/u2:1/41
>  lock: 0x82598a50, .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0
> CPU: 0 PID: 41 Comm: kworker/u2:1 Not tainted 5.13.0-00005-g0bd2212ebd7a #1
> Workqueue: events_unbound async_run_entry_fn
> Stack : 822839e4 80c4eee3 80c50000 80a54338 80c80000 801865e0 00000000 00000004
>         822839e4 5e03e26b 80c50000 8014b4c8 80c50000 00000001 822839e0 8207e4c0
>         00000000 00000000 80b7b9ac 82283828 00000001 8228383c 00000000 0000ffff
>         00000008 00000007 00000280 822b7c00 80c50000 80c70000 00000000 80b80000
>         00000003 00000000 80c50000 00000012 00000000 806591f8 00000000 80cf0000
>         ...
> Call Trace:
> [<80109adc>] show_stack+0x84/0x11c
> [<80a62b1c>] dump_stack+0xa8/0xe4
> [<80181468>] do_raw_spin_lock+0xb0/0x128
> [<80a70170>] _raw_spin_lock_irqsave+0x28/0x3c
> [<80176640>] __wake_up_common_lock+0x68/0xe8
> [<801766d4>] __wake_up+0x14/0x20
> [<8054eb48>] percpu_ref_kill_and_confirm+0x120/0x178
> [<80526d2c>] blk_freeze_queue_start+0x58/0x94
> [<8051af0c>] blk_set_queue_dying+0x2c/0x60
> [<8051afb4>] blk_cleanup_queue+0x40/0x130
> [<806975b4>] __scsi_remove_device+0xd4/0x168
> [<80693594>] scsi_probe_and_add_lun+0x53c/0xf44
> [<806944c4>] __scsi_scan_target+0x158/0x754
> [<80694eb4>] scsi_scan_host_selected+0x17c/0x2e0
> [<806950c4>] do_scsi_scan_host+0xac/0xb4
> [<806952f8>] do_scan_async+0x30/0x228
> [<8015510c>] async_run_entry_fn+0x40/0x100
> [<80148384>] process_one_work+0x170/0x428
> [<80148be0>] worker_thread+0x188/0x578
> [<80150d9c>] kthread+0x130/0x160
> [<80103098>] ret_from_kernel_thread+0x14/0x1c
> 
> CPU 0 Unable to handle kernel paging request at virtual address 00000000, epc == 801764a0, ra == 80176664
> Oops[#1]:
> CPU: 0 PID: 41 Comm: kworker/u2:1 Not tainted 5.13.0-00005-g0bd2212ebd7a #1
> Workqueue: events_unbound async_run_entry_fn
> $ 0   : 00000000 00000001 00000000 00000000
> $ 4   : 82283b14 00000003 00000000 00000000
> $ 8   : 00000001 822837ac 00000000 0000ffff
> $12   : 00000008 00000007 00000280 822b7c00
> $16   : 82598a50 00000000 82283b08 00000003
> $20   : 00000000 00000000 00000000 fffffff4
> $24   : 00000000 806591f8
> $28   : 82280000 82283ab8 82598a60 80176664
> Hi    : 000000a7
> Lo    : 3333335d
> epc   : 801764a0 __wake_up_common+0x6c/0x1a4
> ra    : 80176664 __wake_up_common_lock+0x8c/0xe8
> Status: 1000a402	KERNEL EXL
> Cause : 40808008 (ExcCode 02)
> BadVA : 00000000
> PrId  : 00019300 (MIPS 24Kc)
> Modules linked in:
> Process kworker/u2:1 (pid: 41, threadinfo=(ptrval), task=(ptrval), tls=00000000)
> Stack : 82716400 82283c98 8246a880 8052cfe8 82598a50 00000000 00000000 00000000
>         00000003 00000000 80c50000 00000012 80c80000 80176664 00000000 82126c80
>         801762ec 82283afc 00000000 82283b08 00000000 00000000 00000000 82283b14
>         82283b14 5e03e26b 825985c8 80c70000 00000001 00000000 80d10000 00000024
>         00000003 801766d4 00000001 825985c8 80c70000 00000001 00000000 80d10000
>         ...
> Call Trace:
> [<801764a0>] __wake_up_common+0x6c/0x1a4
> [<80176664>] __wake_up_common_lock+0x8c/0xe8
> [<801766d4>] __wake_up+0x14/0x20
> [<8054eb48>] percpu_ref_kill_and_confirm+0x120/0x178
> [<80526d2c>] blk_freeze_queue_start+0x58/0x94
> [<8051af0c>] blk_set_queue_dying+0x2c/0x60
> [<8051afb4>] blk_cleanup_queue+0x40/0x130
> [<806975b4>] __scsi_remove_device+0xd4/0x168
> [<80693594>] scsi_probe_and_add_lun+0x53c/0xf44
> [<806944c4>] __scsi_scan_target+0x158/0x754
> [<80694eb4>] scsi_scan_host_selected+0x17c/0x2e0
> [<806950c4>] do_scsi_scan_host+0xac/0xb4
> [<806952f8>] do_scan_async+0x30/0x228
> [<8015510c>] async_run_entry_fn+0x40/0x100
> [<80148384>] process_one_work+0x170/0x428
> [<80148be0>] worker_thread+0x188/0x578
> [<80150d9c>] kthread+0x130/0x160
> [<80103098>] ret_from_kernel_thread+0x14/0x1c
> 
> ---
> 
> megaraid_sas 0000:00:14.0: Max firmware commands: 1007 shared with default hw_queues = 1 poll_queues 0
> scsi host0: Avago SAS based MegaRAID driver
> ata_piix 0000:00:0a.1: enabling device (0000 -> 0001)
> scsi 0:2:0:0: Direct-Access     QEMU     QEMU HARDDISK    2.5+ PQ: 0 ANSI: 5
> scsi host1: ata_piix
> scsi host2: ata_piix
> CPU 0 Unable to handle kernel paging request at virtual address 00000000, epc == 00000000, ra == 8019d0b4
> Oops[#1]:
> CPU: 0 PID: 40 Comm: kworker/u2:1 Not tainted 5.13.0-07637-g3dbdb38e2869 #1
> Workqueue: events_unbound async_run_entry_fn
> $ 0   : 00000000 00000001 82568620 00000000
> $ 4   : 82568620 00000200 8019d0b4 8212d580
> $ 8   : ffffffe0 000003fc 00000000 81006d70
> $12   : 81006d40 0000020c 00000000 80ab4400
> $16   : 81007480 00000008 8201ff00 0000000a
> $20   : 00000000 810074bc 80ced800 80cd0000
> $24   : 000b0f1b 00000739
> $28   : 82298000 8201fee8 8019d2f8 8019d0b4
> Hi    : 00003f05
> Lo    : 0000000f
> epc   : 00000000 0x0
> ra    : 8019d0b4 rcu_core+0x260/0x754
> Status: 1000a403	KERNEL EXL IE
> Cause : 00800008 (ExcCode 02)
> BadVA : 00000000
> PrId  : 00019300 (MIPS 24Kc)
> Modules linked in:
> Process kworker/u2:1 (pid: 40, threadinfo=(ptrval), task=(ptrval), tls=00000000)
> Stack : 00000000 8018b544 ffffffc8 ffffffc8 80bde598 00000000 00000000 8201ff00
>         00000048 2942dcc1 80ccc2c8 80cb8080 80d68358 0000000a 00000024 00000009
>         00000100 80cb80a4 00000000 80aaac38 80cd0000 80cba400 80cba400 80191214
>         00014680 2942dcc1 80cf9980 80ab3ce0 80bd9020 80d682f4 80d6e880 80d6e880
>         ffff8fcf 80cd0000 80ab0000 04208060 80ccc2c8 00000001 00000020 80da0000
>         ...
> Call Trace:
> 
> [<8018b544>] __handle_irq_event_percpu+0xbc/0x184
> [<80aaac38>] __do_softirq+0x190/0x33c
> [<80191214>] handle_level_irq+0x130/0x1e8
> [<80132fb8>] irq_exit+0x130/0x138
> [<806112d0>] plat_irq_dispatch+0x9c/0x118
> [<80103404>] handle_int+0x144/0x150
> 
> Code: (Bad address in epc)
> 
> 
> ---[ end trace 5d4c5bf55a0bb13f ]---
> Kernel panic - not syncing: Fatal exception in interrupt
> ------------[ cut here ]------------
> 
> ---
> Bisect on mainline:
> 
> # bad: [3dbdb38e286903ec220aaf1fb29a8d94297da246] Merge branch 'for-5.14' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup
> # good: [007b350a58754a93ca9fe50c498cc27780171153] Merge tag 'dlm-5.14' of git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm
> git bisect start '3dbdb38e2869' '007b350a5875'
> # good: [b6df00789e2831fff7a2c65aa7164b2a4dcbe599] Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
> git bisect good b6df00789e2831fff7a2c65aa7164b2a4dcbe599
> # good: [990ec3014deedfed49e610cdc31dc6930ca63d8d] drm/amdgpu: add psp runtime db structures
> git bisect good 990ec3014deedfed49e610cdc31dc6930ca63d8d
> # good: [c288d9cd710433e5991d58a0764c4d08a933b871] Merge tag 'for-5.14/io_uring-2021-06-30' of git://git.kernel.dk/linux-block
> git bisect good c288d9cd710433e5991d58a0764c4d08a933b871
> # good: [514798d36572fb8eba6ccff3de10c9615063a7f5] Merge tag 'clk-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux
> git bisect good 514798d36572fb8eba6ccff3de10c9615063a7f5
> # good: [630e438f040c3838206b5e6717b9b5c29edf3548] RDMA/rtrs: Introduce head/tail wr
> git bisect good 630e438f040c3838206b5e6717b9b5c29edf3548
> # good: [a32b344e6f4375c5bdc3e89d0997b7eae187a3b1] Merge tag 'pinctrl-v5.14-1' of git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl
> git bisect good a32b344e6f4375c5bdc3e89d0997b7eae187a3b1
> # good: [cad065ed8d8831df67b9754cc4437ed55d8b48c0] MIPS: MT extensions are not available on MIPS32r1
> git bisect good cad065ed8d8831df67b9754cc4437ed55d8b48c0
> # good: [e4d777003a43feab2e000749163e531f6c48c385] percpu: optimize locking in pcpu_balance_workfn()
> git bisect good e4d777003a43feab2e000749163e531f6c48c385
> # bad: [e267992f9ef0bf717d70a9ee18049782f77e4b3a] Merge branch 'for-5.14' of git://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu
> git bisect bad e267992f9ef0bf717d70a9ee18049782f77e4b3a
> # good: [ab3040e1379bd6fcc260f1f7558ee9c2da62766b] MIPS: Ingenic: Add MAC syscon nodes for Ingenic SoCs.
> git bisect good ab3040e1379bd6fcc260f1f7558ee9c2da62766b
> # good: [34c522a07ccbfb0e6476713b41a09f9f51a06c9f] MIPS: CI20: Add second percpu timer for SMP.
> git bisect good 34c522a07ccbfb0e6476713b41a09f9f51a06c9f
> # good: [19b438592238b3b40c3f945bb5f9c4ca971c0c45] Merge tag 'mips_5.14' of git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux
> git bisect good 19b438592238b3b40c3f945bb5f9c4ca971c0c45
> # first bad commit: [e267992f9ef0bf717d70a9ee18049782f77e4b3a] Merge branch 'for-5.14' of git://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu
> 
> ---
> Bisect on merge branch:
> 
> # bad: [e4d777003a43feab2e000749163e531f6c48c385] percpu: optimize locking in pcpu_balance_workfn()
> # good: [d434405aaab7d0ebc516b68a8fc4100922d7f5ef] Linux 5.12-rc7
> git bisect start 'HEAD' 'v5.12-rc7'
> # bad: [f183324133ea535db4127f9fad3e19725ca88bf3] percpu: implement partial chunk depopulation
> git bisect bad f183324133ea535db4127f9fad3e19725ca88bf3
> # good: [67c2669d69fb5ada0f3b5123fb6ebf6fef9faee5] percpu: split __pcpu_balance_workfn()
> git bisect good 67c2669d69fb5ada0f3b5123fb6ebf6fef9faee5
> # good: [1c29a3ceaf5f02919e0a89119a70382581453dbb] percpu: use pcpu_free_slot instead of pcpu_nr_slots - 1
> git bisect good 1c29a3ceaf5f02919e0a89119a70382581453dbb
> # first bad commit: [f183324133ea535db4127f9fad3e19725ca88bf3] percpu: implement partial chunk depopulation
> 
> ---
> Bisect on rebased merge branch:
> 
> # bad: [737dc4074d4969ee54d7f781591bcc608fc6990f] percpu: optimize locking in pcpu_balance_workfn()
> # good: [62fb9874f5da54fdb243003b386128037319b219] Linux 5.13
> git bisect start 'HEAD' 'v5.13'
> # bad: [0bd2212ebd7a02a6c0e870bb4b35abc321c203bc] percpu: implement partial chunk depopulation
> git bisect bad 0bd2212ebd7a02a6c0e870bb4b35abc321c203bc
> # good: [a7aebdb482a3aa87a61f6414a87f31eb657c41f6] percpu: split __pcpu_balance_workfn()
> git bisect good a7aebdb482a3aa87a61f6414a87f31eb657c41f6
> # good: [123a0c4318bb8cfb984f41c0499064c383dd9eee] percpu: use pcpu_free_slot instead of pcpu_nr_slots - 1
> git bisect good 123a0c4318bb8cfb984f41c0499064c383dd9eee
> # first bad commit: [0bd2212ebd7a02a6c0e870bb4b35abc321c203bc] percpu: implement partial chunk depopulation
