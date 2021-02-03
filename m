Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0371530DA55
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 13:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbhBCM47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 07:56:59 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:56072 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbhBCMx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 07:53:59 -0500
Received: by mail-io1-f70.google.com with SMTP id a2so1028214iod.22
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 04:53:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=zvn/6Zc7oSJJ3caw6ad+1DeePuwsSshlWIAxbsQOUDo=;
        b=pELO9BKcSNRw0ggwRNnAzRTsYNfhfh5Nt/REA/UZe8u5P2ybqNt95hNHVlFTQbNB2J
         CgaTyRXUR+seqWaHWielNEMzDABWT3VyfCPe6/w56hHcyiO1mgekWYZGh+YvPx+boCpe
         EKO5nW2P0vATXsQEK6Kl8/MLxKxxcLESunrtGRMwF0qHO5+haalLFSwMZ0kpsrr2sU1h
         Bosf5kwR2ObwX7PH6IWZJ/ZZj96t3EnLaMu84vIjFmdMion8PfjsOVnDW0abTkvJgbYg
         0x2cDgOOcm1G5ipGuA5pZB440v5RXuhF1ILeClNd94ot/O7r5E+NpbRG3fYQuNRiW9pS
         nALQ==
X-Gm-Message-State: AOAM533CsUcxFsKoJCI+1Z6trs3JM7oslFxmYnwAkc/n0OKcPHqVWHBj
        awe9+MOetD4YswyDy3ClHxepODLIsXe/90yhOpsTiaJFSrhm
X-Google-Smtp-Source: ABdhPJzsAAQIIWo1ckdTinx2TaRl0INVojTY82QJZ0Brr9/mrgeN2PUouybx5w2wFlpiENr2oKm4HtS+IYnI04V9CiGneGWP7oTY
MIME-Version: 1.0
X-Received: by 2002:a5e:aa05:: with SMTP id s5mr2250310ioe.59.1612356795532;
 Wed, 03 Feb 2021 04:53:15 -0800 (PST)
Date:   Wed, 03 Feb 2021 04:53:15 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000c8bdd05ba6e12b1@google.com>
Subject: WARNING: held lock freed in uprobe_unregister
From:   syzbot <syzbot+acc3353d66960200ec63@syzkaller.appspotmail.com>
To:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    fb2a9c32 Add linux-next specific files for 20210202
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1617dea0d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cbbb1de2a1f4c440
dashboard link: https://syzkaller.appspot.com/bug?extid=acc3353d66960200ec63

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+acc3353d66960200ec63@syzkaller.appspotmail.com

=========================
WARNING: held lock freed!
5.11.0-rc6-next-20210202-syzkaller #0 Not tainted
-------------------------
syz-executor.3/10020 is freeing memory ffff88801d094000-ffff88801d0941ff, with a lock still held there!
ffff88801d094090 (&uprobe->register_rwsem){+.+.}-{3:3}, at: uprobe_unregister+0x37/0x70 kernel/events/uprobes.c:1115
2 locks held by syz-executor.3/10020:
 #0: ffffffff8bfe10e8 (event_mutex){+.+.}-{3:3}, at: perf_uprobe_destroy+0x23/0x130 kernel/trace/trace_event_perf.c:347
 #1: ffff88801d094090 (&uprobe->register_rwsem){+.+.}-{3:3}, at: uprobe_unregister+0x37/0x70 kernel/events/uprobes.c:1115

stack backtrace:
CPU: 0 PID: 10020 Comm: syz-executor.3 Not tainted 5.11.0-rc6-next-20210202-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:120
 print_freed_lock_bug kernel/locking/lockdep.c:6256 [inline]
 debug_check_no_locks_freed.cold+0x9d/0xa9 kernel/locking/lockdep.c:6289
 slab_free_hook mm/slub.c:1549 [inline]
 slab_free_freelist_hook+0xd8/0x1d0 mm/slub.c:1600
 slab_free mm/slub.c:3161 [inline]
 kfree+0xe5/0x7b0 mm/slub.c:4201
 put_uprobe kernel/events/uprobes.c:612 [inline]
 put_uprobe+0x13b/0x190 kernel/events/uprobes.c:601
 delete_uprobe kernel/events/uprobes.c:947 [inline]
 __uprobe_unregister+0x1e5/0x260 kernel/events/uprobes.c:1098
 uprobe_unregister+0x42/0x70 kernel/events/uprobes.c:1116
 __probe_event_disable+0x11e/0x240 kernel/trace/trace_uprobe.c:1084
 probe_event_disable+0x155/0x1c0 kernel/trace/trace_uprobe.c:1171
 trace_uprobe_register+0x45a/0x880 kernel/trace/trace_uprobe.c:1459
 perf_trace_event_unreg.isra.0+0xac/0x250 kernel/trace/trace_event_perf.c:162
 perf_uprobe_destroy+0xbb/0x130 kernel/trace/trace_event_perf.c:349
 _free_event+0x2ee/0x1380 kernel/events/core.c:4830
 put_event kernel/events/core.c:4924 [inline]
 perf_event_release_kernel+0xa24/0xe00 kernel/events/core.c:5039
 perf_release+0x33/0x40 kernel/events/core.c:5049
 __fput+0x283/0x920 fs/file_table.c:280
 task_work_run+0xdd/0x190 kernel/task_work.c:140
 exit_task_work include/linux/task_work.h:30 [inline]
 do_exit+0xc5c/0x2ae0 kernel/exit.c:825
 do_group_exit+0x125/0x310 kernel/exit.c:922
 get_signal+0x427/0x20f0 kernel/signal.c:2773
 arch_do_signal_or_restart+0x2a8/0x1eb0 arch/x86/kernel/signal.c:811
 handle_signal_work kernel/entry/common.c:147 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
 exit_to_user_mode_prepare+0x148/0x250 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:291 [inline]
 syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:302
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x465b09
Code: Unable to access opcode bytes at RIP 0x465adf.
RSP: 002b:00007fc20ad60188 EFLAGS: 00000246 ORIG_RAX: 000000000000012a
RAX: 0000000000000006 RBX: 000000000056bf60 RCX: 0000000000465b09
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000200000c0
RBP: 00000000004b069f R08: 0000000000000000 R09: 0000000000000000
R10: ffffffffffffffff R11: 0000000000000246 R12: 000000000056bf60
R13: 00007ffe2cf2866f R14: 00007fc20ad60300 R15: 0000000000022000
==================================================================
BUG: KASAN: use-after-free in __up_write kernel/locking/rwsem.c:1311 [inline]
BUG: KASAN: use-after-free in up_write+0x488/0x560 kernel/locking/rwsem.c:1459
Read of size 8 at addr ffff88801d094088 by task syz-executor.3/10020

CPU: 1 PID: 10020 Comm: syz-executor.3 Not tainted 5.11.0-rc6-next-20210202-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:120
 print_address_description.constprop.0.cold+0x5b/0x2f8 mm/kasan/report.c:232
 __kasan_report mm/kasan/report.c:399 [inline]
 kasan_report.cold+0x7c/0xd8 mm/kasan/report.c:416
 __up_write kernel/locking/rwsem.c:1311 [inline]
 up_write+0x488/0x560 kernel/locking/rwsem.c:1459
 uprobe_unregister+0x4a/0x70 kernel/events/uprobes.c:1117
 __probe_event_disable+0x11e/0x240 kernel/trace/trace_uprobe.c:1084
 probe_event_disable+0x155/0x1c0 kernel/trace/trace_uprobe.c:1171
 trace_uprobe_register+0x45a/0x880 kernel/trace/trace_uprobe.c:1459
 perf_trace_event_unreg.isra.0+0xac/0x250 kernel/trace/trace_event_perf.c:162
 perf_uprobe_destroy+0xbb/0x130 kernel/trace/trace_event_perf.c:349
 _free_event+0x2ee/0x1380 kernel/events/core.c:4830
 put_event kernel/events/core.c:4924 [inline]
 perf_event_release_kernel+0xa24/0xe00 kernel/events/core.c:5039
 perf_release+0x33/0x40 kernel/events/core.c:5049
 __fput+0x283/0x920 fs/file_table.c:280
 task_work_run+0xdd/0x190 kernel/task_work.c:140
 exit_task_work include/linux/task_work.h:30 [inline]
 do_exit+0xc5c/0x2ae0 kernel/exit.c:825
 do_group_exit+0x125/0x310 kernel/exit.c:922
 get_signal+0x427/0x20f0 kernel/signal.c:2773
 arch_do_signal_or_restart+0x2a8/0x1eb0 arch/x86/kernel/signal.c:811
 handle_signal_work kernel/entry/common.c:147 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
 exit_to_user_mode_prepare+0x148/0x250 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:291 [inline]
 syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:302
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x465b09
Code: Unable to access opcode bytes at RIP 0x465adf.
RSP: 002b:00007fc20ad60188 EFLAGS: 00000246 ORIG_RAX: 000000000000012a
RAX: 0000000000000006 RBX: 000000000056bf60 RCX: 0000000000465b09
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000200000c0
RBP: 00000000004b069f R08: 0000000000000000 R09: 0000000000000000
R10: ffffffffffffffff R11: 0000000000000246 R12: 000000000056bf60
R13: 00007ffe2cf2866f R14: 00007fc20ad60300 R15: 0000000000022000

Allocated by task 10020:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:46 [inline]
 set_alloc_info mm/kasan/common.c:427 [inline]
 ____kasan_kmalloc mm/kasan/common.c:506 [inline]
 __kasan_kmalloc mm/kasan/common.c:515 [inline]
 __kasan_kmalloc+0x99/0xc0 mm/kasan/common.c:512
 kmalloc include/linux/slab.h:556 [inline]
 kzalloc include/linux/slab.h:686 [inline]
 alloc_uprobe kernel/events/uprobes.c:731 [inline]
 __uprobe_register+0x19c/0x850 kernel/events/uprobes.c:1167
 trace_uprobe_enable kernel/trace/trace_uprobe.c:1063 [inline]
 probe_event_enable+0x441/0xa00 kernel/trace/trace_uprobe.c:1129
 trace_uprobe_register+0x443/0x880 kernel/trace/trace_uprobe.c:1456
 perf_trace_event_reg kernel/trace/trace_event_perf.c:129 [inline]
 perf_trace_event_init+0x549/0xa20 kernel/trace/trace_event_perf.c:204
 perf_uprobe_init+0x16f/0x210 kernel/trace/trace_event_perf.c:336
 perf_uprobe_event_init+0xff/0x1c0 kernel/events/core.c:9721
 perf_try_init_event+0x12a/0x560 kernel/events/core.c:11038
 perf_init_event kernel/events/core.c:11090 [inline]
 perf_event_alloc.part.0+0xe3b/0x3960 kernel/events/core.c:11370
 perf_event_alloc kernel/events/core.c:11749 [inline]
 __do_sys_perf_event_open+0x647/0x2e60 kernel/events/core.c:11847
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Freed by task 10020:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_set_track+0x1c/0x30 mm/kasan/common.c:46
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:357
 ____kasan_slab_free mm/kasan/common.c:360 [inline]
 __kasan_slab_free+0xf5/0x130 mm/kasan/common.c:367
 kasan_slab_free include/linux/kasan.h:199 [inline]
 slab_free_hook mm/slub.c:1562 [inline]
 slab_free_freelist_hook+0x82/0x1d0 mm/slub.c:1600
 slab_free mm/slub.c:3161 [inline]
 kfree+0xe5/0x7b0 mm/slub.c:4201
 put_uprobe kernel/events/uprobes.c:612 [inline]
 put_uprobe+0x13b/0x190 kernel/events/uprobes.c:601
 delete_uprobe kernel/events/uprobes.c:947 [inline]
 __uprobe_unregister+0x1e5/0x260 kernel/events/uprobes.c:1098
 uprobe_unregister+0x42/0x70 kernel/events/uprobes.c:1116
 __probe_event_disable+0x11e/0x240 kernel/trace/trace_uprobe.c:1084
 probe_event_disable+0x155/0x1c0 kernel/trace/trace_uprobe.c:1171
 trace_uprobe_register+0x45a/0x880 kernel/trace/trace_uprobe.c:1459
 perf_trace_event_unreg.isra.0+0xac/0x250 kernel/trace/trace_event_perf.c:162
 perf_uprobe_destroy+0xbb/0x130 kernel/trace/trace_event_perf.c:349
 _free_event+0x2ee/0x1380 kernel/events/core.c:4830
 put_event kernel/events/core.c:4924 [inline]
 perf_event_release_kernel+0xa24/0xe00 kernel/events/core.c:5039
 perf_release+0x33/0x40 kernel/events/core.c:5049
 __fput+0x283/0x920 fs/file_table.c:280
 task_work_run+0xdd/0x190 kernel/task_work.c:140
 exit_task_work include/linux/task_work.h:30 [inline]
 do_exit+0xc5c/0x2ae0 kernel/exit.c:825
 do_group_exit+0x125/0x310 kernel/exit.c:922
 get_signal+0x427/0x20f0 kernel/signal.c:2773
 arch_do_signal_or_restart+0x2a8/0x1eb0 arch/x86/kernel/signal.c:811
 handle_signal_work kernel/entry/common.c:147 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
 exit_to_user_mode_prepare+0x148/0x250 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:291 [inline]
 syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:302
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

The buggy address belongs to the object at ffff88801d094000
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 136 bytes inside of
 512-byte region [ffff88801d094000, ffff88801d094200)
The buggy address belongs to the page:
page:000000008d65b794 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1d094
head:000000008d65b794 order:1 compound_mapcount:0
flags: 0xfff00000010200(slab|head)
raw: 00fff00000010200 0000000000000000 0000000600000001 ffff888010841c80
raw: 0000000000000000 0000000000080008 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88801d093f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88801d094000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88801d094080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                      ^
 ffff88801d094100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88801d094180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
