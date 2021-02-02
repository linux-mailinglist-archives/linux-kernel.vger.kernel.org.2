Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4847330B8E6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 08:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbhBBHrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 02:47:03 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:55454 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbhBBHq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 02:46:58 -0500
Received: by mail-il1-f200.google.com with SMTP id q11so9524974ild.22
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 23:46:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=OuTP3FRYAYcOYUseN1TdpYA0fEaWE26jTfKQb0lFcIQ=;
        b=JKfK7YhcXZzjUGINM1CQSrC3G9UNKo4Mc5S8SfQ2T7U2jnK0w8MKCsLN9C8dbP937R
         WSPDgZG7oiRlkInAeUoDmhAnmTFVmVsNtLjeyXErB5dA7N+GBB5KzaN9pixfej+cJ3Fs
         cpa0QRzlfuMyZzUA71dIR6H2teIJYFlDJxLzjYG5L22vSdNRQxUbAtZnQFIegXNiXKMv
         wpd7Wh5HG8GQ/YsSJUmlEmBiy9dzc2TqU0TPjR7zO6YLRRVXXr14b6CrQDKACStKhdXz
         H06vUk7ZjmBo8FLjN9eBYGyy0ieLvWiSQ/ebFGMblEOGSLfoIKY3S/PW05Mq3OjPa43v
         RKSw==
X-Gm-Message-State: AOAM530RCYGqx93qmzdnywIo+fqsUWE3lam3teLZsfeqR4+hl06+PMUE
        POGeeKbqhLbeDqOU/r41/xfF3LGSroDrCrGOaxXFz6d6C1qm
X-Google-Smtp-Source: ABdhPJwGEvpqcKs1wVNk2mBMjmFzxB+vY/rWScwgdpXtIdPTAFQx7TlgOhaRantjlG/5smUxmkY0noBF0THzuJ2SAqCLeANYRJmt
MIME-Version: 1.0
X-Received: by 2002:a5e:850b:: with SMTP id i11mr15572507ioj.42.1612251977363;
 Mon, 01 Feb 2021 23:46:17 -0800 (PST)
Date:   Mon, 01 Feb 2021 23:46:17 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006637f205ba55aa77@google.com>
Subject: KASAN: use-after-free Read in find_uprobe
From:   syzbot <syzbot+9b2492a161dae05a29f0@syzkaller.appspotmail.com>
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

HEAD commit:    fd821bf0 Add linux-next specific files for 20210201
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11261e08d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=80ac9f64e6e2c06
dashboard link: https://syzkaller.appspot.com/bug?extid=9b2492a161dae05a29f0

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9b2492a161dae05a29f0@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in uprobe_cmp kernel/events/uprobes.c:620 [inline]
BUG: KASAN: use-after-free in __uprobe_cmp_key kernel/events/uprobes.c:646 [inline]
BUG: KASAN: use-after-free in rb_find include/linux/rbtree.h:289 [inline]
BUG: KASAN: use-after-free in __find_uprobe kernel/events/uprobes.c:661 [inline]
BUG: KASAN: use-after-free in find_uprobe+0x12c/0x150 kernel/events/uprobes.c:678
Read of size 8 at addr ffff88802fe70d68 by task syz-executor.0/9832

CPU: 1 PID: 9832 Comm: syz-executor.0 Not tainted 5.11.0-rc6-next-20210201-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:120
 print_address_description.constprop.0.cold+0x5b/0x2f8 mm/kasan/report.c:232
 __kasan_report mm/kasan/report.c:399 [inline]
 kasan_report.cold+0x7c/0xd8 mm/kasan/report.c:416
 uprobe_cmp kernel/events/uprobes.c:620 [inline]
 __uprobe_cmp_key kernel/events/uprobes.c:646 [inline]
 rb_find include/linux/rbtree.h:289 [inline]
 __find_uprobe kernel/events/uprobes.c:661 [inline]
 find_uprobe+0x12c/0x150 kernel/events/uprobes.c:678
 uprobe_unregister+0x1e/0x70 kernel/events/uprobes.c:1111
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
RSP: 002b:00007fb218a64188 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: 0000000000000008 RBX: 000000000056c008 RCX: 0000000000465b09
RDX: 0000000000000008 RSI: 0000000020000400 RDI: 0000000000000005
RBP: 00000000004b069f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000056c008
R13: 00007ffc0ac02e6f R14: 00007fb218a64300 R15: 0000000000022000

Allocated by task 9838:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:46 [inline]
 set_alloc_info mm/kasan/common.c:403 [inline]
 ____kasan_kmalloc mm/kasan/common.c:434 [inline]
 ____kasan_kmalloc.constprop.0+0xa0/0xd0 mm/kasan/common.c:406
 kmalloc include/linux/slab.h:556 [inline]
 kzalloc include/linux/slab.h:686 [inline]
 alloc_uprobe kernel/events/uprobes.c:731 [inline]
 __uprobe_register+0x19c/0x850 kernel/events/uprobes.c:1167
 trace_uprobe_enable kernel/trace/trace_uprobe.c:1060 [inline]
 probe_event_enable+0x357/0xa00 kernel/trace/trace_uprobe.c:1129
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

Freed by task 9838:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_set_track+0x1c/0x30 mm/kasan/common.c:46
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:357
 ____kasan_slab_free.part.0+0xe1/0x110 mm/kasan/common.c:364
 kasan_slab_free include/linux/kasan.h:191 [inline]
 slab_free_hook mm/slub.c:1562 [inline]
 slab_free_freelist_hook+0x82/0x1d0 mm/slub.c:1600
 slab_free mm/slub.c:3161 [inline]
 kfree+0xe5/0x7b0 mm/slub.c:4202
 put_uprobe kernel/events/uprobes.c:612 [inline]
 put_uprobe+0x13b/0x190 kernel/events/uprobes.c:601
 uprobe_apply+0xfc/0x130 kernel/events/uprobes.c:1231
 uprobe_perf_open kernel/trace/trace_uprobe.c:1311 [inline]
 trace_uprobe_register+0x5c9/0x880 kernel/trace/trace_uprobe.c:1463
 perf_trace_event_open kernel/trace/trace_event_perf.c:186 [inline]
 perf_trace_event_init kernel/trace/trace_event_perf.c:208 [inline]
 perf_trace_event_init+0x17a/0xa20 kernel/trace/trace_event_perf.c:195
 perf_uprobe_init+0x16f/0x210 kernel/trace/trace_event_perf.c:336
 perf_uprobe_event_init+0xff/0x1c0 kernel/events/core.c:9721
 perf_try_init_event+0x12a/0x560 kernel/events/core.c:11038
 perf_init_event kernel/events/core.c:11090 [inline]
 perf_event_alloc.part.0+0xe3b/0x3960 kernel/events/core.c:11370
 perf_event_alloc kernel/events/core.c:11749 [inline]
 __do_sys_perf_event_open+0x647/0x2e60 kernel/events/core.c:11847
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

The buggy address belongs to the object at ffff88802fe70c00
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 360 bytes inside of
 512-byte region [ffff88802fe70c00, ffff88802fe70e00)
The buggy address belongs to the page:
page:0000000088bdd300 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88802fe70000 pfn:0x2fe70
head:0000000088bdd300 order:1 compound_mapcount:0
flags: 0xfff00000010200(slab|head)
raw: 00fff00000010200 ffffea00008e0088 ffffea0000bc2c08 ffff88800fc41c80
raw: ffff88802fe70000 0000000000080007 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88802fe70c00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88802fe70c80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88802fe70d00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                          ^
 ffff88802fe70d80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88802fe70e00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
