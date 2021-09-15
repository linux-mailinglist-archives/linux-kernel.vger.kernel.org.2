Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9365840BD85
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 04:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234650AbhIOCHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 22:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbhIOCHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 22:07:34 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED056C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 19:06:15 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id dw14so1065489pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 19:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=63zgsp6M5ZnAkCfVuAW7bCzJGOiDzdOJ0iemXPlQDJw=;
        b=nzxFaRSe/Ro3deWpOAVG3/AYw+O6dZRE8dkBh27FKC164HoGOnY57yIc4C150QrKIm
         f9+NTTlZQqg+xBcgaDhctPtOSzjvYkaN3nDUgeshIl+wkH6AiFILha9dLb7I5ECxyiew
         TPYvSv5PipCbjWptDQ8xWN8/h7oH5mQWtMxyg4UD27C90b2A6nXF6Kqq7xZrKZ/vtgcF
         Z5MJdmO4fUNfnLAe6DDBi6dNlnGnIO0mcejB0oqV14bfgc+F6Rgt1P+dMBTELgzwGRHz
         h+p9vwUquFRQ8ZrAQGO21NTITBOBnDtDM5PRTUfTT8J5W5U0aXr61FcaH1/4/TJO5g7v
         kb3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=63zgsp6M5ZnAkCfVuAW7bCzJGOiDzdOJ0iemXPlQDJw=;
        b=ZXZiQfAvGh0JV6TrWGV175seyTZ2DWDTO6x04PzZEvRhr3vEwF9DOx3atvzdms+gg3
         EUdkwYf9sW9v5msPbtQUvoyqmb1wUxu2Xcog+HIM/boYWH5Tlnvmbw/0RhdLIHOgkYFa
         CgRwAxN5UTqeoBgayTK5uA602o3drtGKtNW8RoI2yjZuascZ7/SdHdAuzB3l4vcLpWKj
         RrCP1ZuH4tyz7W5Ucn9xeitJgjt9zf/5pIuOj8oZ7mWRrDVCnwCiP3WwXgcLP1/6zTNq
         nzzDnwlICbdcD+O7vaHiXwuxru1QCasDOIv2F1A9wUuFzO9rWaUGG9eIEtqYFNBJnfsS
         ychA==
X-Gm-Message-State: AOAM531qQzYJndwr7mODxHPZZVB5hkALe7yutz4Rz+4hX4lIrErEwavj
        yE9bXY4BGfi1RCKLIfq4GBUUFEPt3mD5yMktF+pkp10g8A1MmY4=
X-Google-Smtp-Source: ABdhPJzy5L56rYve7jU9NM24QMogZt7/4Ohv2Zdxsg4ZPG2/0+Yty2PQKbvUY9KObc8xiDN8m5yPGMLv0Nat/bNTo/0=
X-Received: by 2002:a17:90a:b794:: with SMTP id m20mr5668093pjr.178.1631671575119;
 Tue, 14 Sep 2021 19:06:15 -0700 (PDT)
MIME-Version: 1.0
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Wed, 15 Sep 2021 10:06:04 +0800
Message-ID: <CACkBjsZsS31MaquS55p09z-FSN8-+_Nfw=Rv0Y_n4GmqoJJ7XQ@mail.gmail.com>
Subject: INFO: task hung in migrate_pages
To:     akpm@linux-foundation.org, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

When using Healer to fuzz the latest Linux kernel, the following crash
was triggered.

HEAD commit: 6880fa6c5660 Linux 5.15-rc1
git tree: upstream
console output:
https://drive.google.com/file/d/11Zt6XyEDkbGHQTN6qCAdSyCvDzTtoWPH/view?usp=sharing
kernel config: https://drive.google.com/file/d/1rUzyMbe5vcs6khA3tL9EHTLJvsUdWcgB/view?usp=sharing

Sorry, I don't have a reproducer for this crash, hope the symbolized
report can help.
If you fix this issue, please add the following tag to the commit:
Reported-by: Hao Sun <sunhao.th@gmail.com>

INFO: task kcompactd1:43 blocked for more than 147 seconds.
      Not tainted 5.15.0-rc1 #16
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kcompactd1      state:D stack:14152 pid:   43 ppid:     2 flags:0x00004000
Call Trace:
 context_switch kernel/sched/core.c:4940 [inline]
 __schedule+0x323/0xae0 kernel/sched/core.c:6287
 schedule+0x36/0xe0 kernel/sched/core.c:6366
 io_schedule+0xd/0x30 kernel/sched/core.c:8389
 wait_on_page_bit_common+0x234/0x5c0 mm/filemap.c:1356
 lock_page include/linux/pagemap.h:625 [inline]
 __unmap_and_move mm/migrate.c:987 [inline]
 unmap_and_move mm/migrate.c:1211 [inline]
 migrate_pages+0x1271/0x1be0 mm/migrate.c:1488
 compact_zone+0x838/0x1710 mm/compaction.c:2393
 kcompactd_do_work+0x16e/0x590 mm/compaction.c:2833
 kcompactd+0x36e/0x550 mm/compaction.c:2935
 kthread+0x178/0x1b0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

Showing all locks held in the system:
1 lock held by khungtaskd/39:
 #0: ffffffff85a1d560 (rcu_read_lock){....}-{1:2}, at:
debug_show_all_locks+0xe/0x1a0 kernel/locking/lockdep.c:6446
1 lock held by khugepaged/45:
 #0: ffffffff85a4ac48 (lock#5){+.+.}-{3:3}, at: __lru_add_drain_all
mm/swap.c:769 [inline]
 #0: ffffffff85a4ac48 (lock#5){+.+.}-{3:3}, at:
lru_add_drain_all+0x40/0x380 mm/swap.c:828
3 locks held by kworker/u10:2/514:
 #0: ffff8881000b6d38 ((wq_completion)writeback){+.+.}-{0:0}, at:
set_work_data kernel/workqueue.c:633 [inline]
 #0: ffff8881000b6d38 ((wq_completion)writeback){+.+.}-{0:0}, at:
set_work_pool_and_clear_pending kernel/workqueue.c:661 [inline]
 #0: ffff8881000b6d38 ((wq_completion)writeback){+.+.}-{0:0}, at:
process_one_work+0x2a0/0x850 kernel/workqueue.c:2268
 #1: ffffc9000282fe70
((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at:
set_work_data kernel/workqueue.c:633 [inline]
 #1: ffffc9000282fe70
((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at:
set_work_pool_and_clear_pending kernel/workqueue.c:661 [inline]
 #1: ffffc9000282fe70
((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at:
process_one_work+0x2a0/0x850 kernel/workqueue.c:2268
 #2: ffff888008d740e0 (&type->s_umount_key#47){.+.+}-{3:3}, at:
trylock_super+0x1a/0x70 fs/super.c:418
1 lock held by in:imklog/6097:
 #0: ffff88800f8144f0 (&f->f_pos_lock){+.+.}-{3:3}, at:
__fdget_pos+0x55/0x60 fs/file.c:990
3 locks held by rs:main Q:Reg/6098:
 #0: ffff88800f81b0f0 (&f->f_pos_lock){+.+.}-{3:3}, at:
__fdget_pos+0x55/0x60 fs/file.c:990
 #1: ffff88800e6a0460 (sb_writers#5){.+.+}-{0:0}, at:
ksys_write+0xd2/0x120 fs/read_write.c:647
 #2: ffff88800e6a7bd8 (&sbi->s_writepages_rwsem){++++}-{0:0}, at:
do_writepages+0xec/0x260 mm/page-writeback.c:2364
2 locks held by agetty/23165:
 #0: ffff88801a712098 (&tty->ldisc_sem){++++}-{0:0}, at:
tty_ldisc_ref_wait+0x20/0x50 drivers/tty/tty_ldisc.c:252
 #1: ffffc9000133f2e8 (&ldata->atomic_read_lock){+.+.}-{3:3}, at:
n_tty_read+0x1df/0x720 drivers/tty/n_tty.c:2113
5 locks held by kworker/u9:0/6489:
1 lock held by syz-executor/9324:
3 locks held by syz-executor/10051:
 #0: ffff88800e6a0650 (sb_internal){.+.+}-{0:0}, at: evict+0xfd/0x1e0
fs/inode.c:586
 #1: ffff88800e6a4990 (jbd2_handle){++++}-{0:0}, at:
start_this_handle+0x16f/0x690 fs/jbd2/transaction.c:427
 #2: ffff8880172e9578 (&ei->i_data_sem){++++}-{3:3}, at:
ext4_truncate+0x5c2/0x7e0 fs/ext4/inode.c:4263
3 locks held by syz-executor/10055:
 #0: ffff88800e6a0650 (sb_internal){.+.+}-{0:0}, at: evict+0xfd/0x1e0
fs/inode.c:586
 #1: ffff88800e6a4990 (jbd2_handle){++++}-{0:0}, at:
start_this_handle+0x16f/0x690 fs/jbd2/transaction.c:427
 #2: ffff88810bfabb78 (&ei->i_data_sem){++++}-{3:3}, at:
ext4_truncate+0x5c2/0x7e0 fs/ext4/inode.c:4263

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 39 Comm: khungtaskd Not tainted 5.15.0-rc1 #16
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x8d/0xcf lib/dump_stack.c:106
 nmi_cpu_backtrace+0x1e9/0x210 lib/nmi_backtrace.c:105
 nmi_trigger_cpumask_backtrace+0x120/0x180 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:210 [inline]
 watchdog+0x4e1/0x980 kernel/hung_task.c:295
 kthread+0x178/0x1b0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
Sending NMI from CPU 1 to CPUs 0,2-3:
NMI backtrace for cpu 3
CPU: 3 PID: 3008 Comm: systemd-journal Not tainted 5.15.0-rc1 #16
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
RIP: 0010:memset_erms+0xb/0x10 arch/x86/lib/memset_64.S:65
Code: 03 40 0f b6 f6 48 b8 01 01 01 01 01 01 01 01 48 0f af c6 f3 48
ab 89 d1 f3 aa 4c 89 c8 c3 90 49 89 f9 40 88 f0 48 89 d1 f3 aa <4c> 89
c8 c3 90 49 89 fa 40 0f b6 ce 48 b8 01 01 01 01 01 01 01 01
RSP: 0018:ffffc9000084fdc8 EFLAGS: 00000246
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: 0000000000001000 RSI: 0000000000000000 RDI: ffff8881000e5000
RBP: 0000000003ffffff R08: ffffc9000084fe28 R09: ffff8881000e4000
R10: ffffc9000084fcb0 R11: 0000000000000001 R12: ffffc9000084fe28
R13: 0000000000000001 R14: ffff888100005100 R15: 0000000000000000
FS:  00007f96b26c78c0(0000) GS:ffff88813dd00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f96af6c3000 CR3: 0000000102679000 CR4: 0000000000750ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 memset include/linux/fortify-string.h:175 [inline]
 slab_post_alloc_hook+0x48/0x3c0 mm/slab.h:521
 slab_alloc_node mm/slub.c:3206 [inline]
 slab_alloc mm/slub.c:3214 [inline]
 kmem_cache_alloc+0x11b/0x280 mm/slub.c:3219
 getname_flags+0x56/0x250 fs/namei.c:138
 user_path_at_empty+0x28/0x60 fs/namei.c:2800
 user_path_at include/linux/namei.h:57 [inline]
 do_faccessat+0xa3/0x370 fs/open.c:421
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x34/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f96b19839c7
Code: 83 c4 08 48 3d 01 f0 ff ff 73 01 c3 48 8b 0d c8 d4 2b 00 f7 d8
64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 b8 15 00 00 00 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 8b 0d a1 d4 2b 00 f7 d8 64 89 01 48
RSP: 002b:00007fff85caab38 EFLAGS: 00000246 ORIG_RAX: 0000000000000015
RAX: ffffffffffffffda RBX: 00007fff85cadb60 RCX: 00007f96b19839c7
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000055e70720d9a3
RBP: 00007fff85caac80 R08: 000055e7072033e5 R09: 0000000000000018
R10: 0000000000000069 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 000055e707c3c8a0 R15: 00007fff85cab170
NMI backtrace for cpu 2
CPU: 2 PID: 6489 Comm: kworker/u9:0 Not tainted 5.15.0-rc1 #16
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
Workqueue: events_unbound toggle_allocation_gate
RIP: 0010:csd_lock_wait kernel/smp.c:440 [inline]
RIP: 0010:smp_call_function_many_cond+0x1d2/0x550 kernel/smp.c:969
Code: a6 04 00 4c 63 fd 49 8b 1c 24 49 83 ff 07 0f 87 31 03 00 00 4a
03 1c fd 80 98 62 85 8b 43 08 a8 01 74 0e e8 40 a6 04 00 f3 90 <8b> 43
08 a8 01 75 f2 e8 32 a6 04 00 eb ad 48 83 c4 40 5b 5d 41 5c
RSP: 0018:ffffc90005e77c80 EFLAGS: 00000293
RAX: 0000000000000000 RBX: ffff88807dc318e0 RCX: 0000000000000000
RDX: ffff888019b60000 RSI: ffffffff8132ebc0 RDI: 00000000ffffffff
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
R10: ffffc90005e77c28 R11: 0000000000000000 R12: ffff88807dd2a900
R13: ffff88807dd2a908 R14: ffffffff85a27620 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88807dd00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004dc120 CR3: 000000000588a000 CR4: 0000000000750ee0
DR0: 0000000000003000 DR1: 0000000000004000 DR2: 0000000000010000
DR3: 000000000000d000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 on_each_cpu_cond_mask+0x48/0x90 kernel/smp.c:1135
 on_each_cpu include/linux/smp.h:71 [inline]
 text_poke_sync arch/x86/kernel/alternative.c:929 [inline]
 text_poke_bp_batch+0xb6/0x2c0 arch/x86/kernel/alternative.c:1114
 text_poke_flush arch/x86/kernel/alternative.c:1268 [inline]
 text_poke_finish+0x16/0x30 arch/x86/kernel/alternative.c:1275
 arch_jump_label_transform_apply+0x13/0x20 arch/x86/kernel/jump_label.c:146
 jump_label_update+0xbc/0x190 kernel/jump_label.c:830
 static_key_enable_cpuslocked+0x77/0xb0 kernel/jump_label.c:177
 static_key_enable+0x16/0x20 kernel/jump_label.c:190
 toggle_allocation_gate+0x71/0x240 mm/kfence/core.c:626
 process_one_work+0x359/0x850 kernel/workqueue.c:2297
 worker_thread+0x41/0x4d0 kernel/workqueue.c:2444
 kthread+0x178/0x1b0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
NMI backtrace for cpu 0
CPU: 0 PID: 9324 Comm: syz-executor Not tainted 5.15.0-rc1 #16
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
RIP: 0010:clear_page_erms+0x7/0x10 arch/x86/lib/clear_page_64.S:49
Code: 48 89 47 18 48 89 47 20 48 89 47 28 48 89 47 30 48 89 47 38 48
8d 7f 40 75 d9 90 c3 0f 1f 80 00 00 00 00 b9 00 10 00 00 31 c0 <f3> aa
c3 cc cc cc cc cc cc 41 57 41 56 41 55 41 54 55 53 48 89 fb
RSP: 0018:ffffc90003f679e0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 00000000018a8000 RCX: 0000000000001000
RDX: ffff88811344c480 RSI: 0000000000000001 RDI: ffff888062a00000
RBP: 00000000018a8040 R08: 0000000000001000 R09: 0000000000000001
R10: ffffc90003f679c0 R11: 0000000000000001 R12: ffff888000000000
R13: 0000000000112c40 R14: 0000000000000000 R15: ffff88807fffb700
FS:  00000000021c6940(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000002eebc48 CR3: 000000011010e000 CR4: 0000000000750ef0
DR0: 0000000000003000 DR1: 0000000000004000 DR2: 0000000000010000
DR3: 000000000000d000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 clear_page arch/x86/include/asm/page_64.h:49 [inline]
 clear_highpage include/linux/highmem.h:181 [inline]
 kernel_init_free_pages.part.95+0x67/0xa0 mm/page_alloc.c:1278
 kernel_init_free_pages mm/page_alloc.c:1267 [inline]
 post_alloc_hook+0x70/0x110 mm/page_alloc.c:2414
 prep_new_page+0x16/0x50 mm/page_alloc.c:2424
 get_page_from_freelist+0x64d/0x29a0 mm/page_alloc.c:4153
 __alloc_pages+0xde/0x2a0 mm/page_alloc.c:5375
 alloc_pages+0x85/0x150 mm/mempolicy.c:2197
 __page_cache_alloc+0x167/0x210 mm/filemap.c:1022
 page_cache_ra_unbounded+0x106/0x370 mm/readahead.c:216
 do_page_cache_ra+0x65/0x80 mm/readahead.c:269
 do_sync_mmap_readahead mm/filemap.c:2981 [inline]
 filemap_fault+0x5e4/0xc30 mm/filemap.c:3074
 __do_fault+0x5a/0x18e mm/memory.c:3857
 do_shared_fault mm/memory.c:4226 [inline]
 do_fault mm/memory.c:4304 [inline]
 handle_pte_fault mm/memory.c:4558 [inline]
 __handle_mm_fault+0x1529/0x1c70 mm/memory.c:4693
 handle_mm_fault+0x1b6/0x550 mm/memory.c:4791
 do_user_addr_fault arch/x86/mm/fault.c:1390 [inline]
 handle_page_fault arch/x86/mm/fault.c:1475 [inline]
 exc_page_fault+0x3be/0xbf0 arch/x86/mm/fault.c:1531
 asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:568
RIP: 0033:0x466d78
Code: d1 f3 a4 c3 80 fa 10 73 17 80 fa 08 73 27 80 fa 04 73 33 80 fa
01 77 3b 72 05 0f b6 0e 88 0f c3 c5 fa 6f 06 c5 fa 6f 4c 16 f0 <c5> fa
7f 07 c5 fa 7f 4c 17 f0 c3 48 8b 4c 16 f8 48 8b 36 48 89 4c
RSP: 002b:00007ffc306897d8 EFLAGS: 00010246
RAX: 00000000200000c0 RBX: 0000000000790210 RCX: 0000000000000000
RDX: 0000000000000010 RSI: 0000000000790230 RDI: 00000000200000c0
RBP: 0000000000790218 R08: 00000000000004f0 R09: 0000000008bc24f2
R10: 00007ffc30689900 R11: 0000000000000246 R12: 0000000000255d7c
R13: 000000000071f880 R14: 000000000078c0a0 R15: 0000000000255d77
----------------
Code disassembly (best guess):
   0: 03 40 0f              add    0xf(%rax),%eax
   3: b6 f6                mov    $0xf6,%dh
   5: 48 b8 01 01 01 01 01 movabs $0x101010101010101,%rax
   c: 01 01 01
   f: 48 0f af c6          imul   %rsi,%rax
  13: f3 48 ab              rep stos %rax,%es:(%rdi)
  16: 89 d1                mov    %edx,%ecx
  18: f3 aa                rep stos %al,%es:(%rdi)
  1a: 4c 89 c8              mov    %r9,%rax
  1d: c3                    retq
  1e: 90                    nop
  1f: 49 89 f9              mov    %rdi,%r9
  22: 40 88 f0              mov    %sil,%al
  25: 48 89 d1              mov    %rdx,%rcx
  28: f3 aa                rep stos %al,%es:(%rdi)
* 2a: 4c 89 c8              mov    %r9,%rax <-- trapping instruction
  2d: c3                    retq
  2e: 90                    nop
  2f: 49 89 fa              mov    %rdi,%r10
  32: 40 0f b6 ce          movzbl %sil,%ecx
  36: 48 b8 01 01 01 01 01 movabs $0x101010101010101,%rax
  3d: 01 01 01
