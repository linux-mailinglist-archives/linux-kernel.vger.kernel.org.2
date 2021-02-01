Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A119830B11C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 21:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232773AbhBAUAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 15:00:18 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:41477 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbhBAUAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 15:00:00 -0500
Received: by mail-io1-f69.google.com with SMTP id w4so12751243iod.8
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 11:59:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=CxwKLDt4zkc9UOnKrz071c//CceAnESOZD4qIFQoHII=;
        b=rg8mr4fJ5MZD4iG/h1MGnwKyPn26JSskO07ae4o8Qmr3c+o4Tt8bfHNA4Bs5cYvq69
         Ur5n1LIX/xgsoOehzN/gRdB1RviK1U+TTVraBu7qsaNXc9ZfL+VrPaKbE+tVVMhhgflI
         ULAwRl3lH8FZz138S0sh55gSqgfv222Y964vcR0+bp49LQKacWgN9K7mdiweKCzWUGCn
         3RD9h97YsyjCi0WVUu0o9VV/VNussnEIJe0IaNtay4Dls7h/qVWXGTmDSvW35eQxG+k5
         oL56AvzVdsxnDOMeS73jjpD2UVmiU0LHK0tNs9nFt0NjgkiSnkhnbfDS8W9LMTbYEQ1V
         Avmw==
X-Gm-Message-State: AOAM530GAe4fUXJtgLZjG4auhj49/1DZlB7sxvcDNbAHWkKHQJqjwtcz
        FO0FYarNOL7nuK2sBtHBLPCKjXOHxpsdkEZHWQoSGg61KoOp
X-Google-Smtp-Source: ABdhPJwP0OTEo6g/u0tbIUsnJd7nPFeoW6vMY17YwLBjUxZgWNw+AqM31kwhPfjQbAEvCUJsk9HFGMJCblTP6mjC+TfttykWgWWg
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2197:: with SMTP id b23mr13095377iob.126.1612209559116;
 Mon, 01 Feb 2021 11:59:19 -0800 (PST)
Date:   Mon, 01 Feb 2021 11:59:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001323f405ba4bcaa4@google.com>
Subject: KASAN: use-after-free Read in __uprobe_register
From:   syzbot <syzbot+1182ffb2063c5d087a38@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=16b7fa90d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=80ac9f64e6e2c06
dashboard link: https://syzkaller.appspot.com/bug?extid=1182ffb2063c5d087a38

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1182ffb2063c5d087a38@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in uprobe_cmp kernel/events/uprobes.c:620 [inline]
BUG: KASAN: use-after-free in __uprobe_cmp kernel/events/uprobes.c:652 [inline]
BUG: KASAN: use-after-free in rb_find_add include/linux/rbtree.h:259 [inline]
BUG: KASAN: use-after-free in __insert_uprobe kernel/events/uprobes.c:688 [inline]
BUG: KASAN: use-after-free in insert_uprobe kernel/events/uprobes.c:710 [inline]
BUG: KASAN: use-after-free in alloc_uprobe kernel/events/uprobes.c:742 [inline]
BUG: KASAN: use-after-free in __uprobe_register+0x70f/0x850 kernel/events/uprobes.c:1167
Read of size 8 at addr ffff88802b6e0168 by task syz-executor.1/12712

CPU: 1 PID: 12712 Comm: syz-executor.1 Not tainted 5.11.0-rc6-next-20210201-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:120
 print_address_description.constprop.0.cold+0x5b/0x2f8 mm/kasan/report.c:232
 __kasan_report mm/kasan/report.c:399 [inline]
 kasan_report.cold+0x7c/0xd8 mm/kasan/report.c:416
 uprobe_cmp kernel/events/uprobes.c:620 [inline]
 __uprobe_cmp kernel/events/uprobes.c:652 [inline]
 rb_find_add include/linux/rbtree.h:259 [inline]
 __insert_uprobe kernel/events/uprobes.c:688 [inline]
 insert_uprobe kernel/events/uprobes.c:710 [inline]
 alloc_uprobe kernel/events/uprobes.c:742 [inline]
 __uprobe_register+0x70f/0x850 kernel/events/uprobes.c:1167
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
RIP: 0033:0x465b09
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fd028707188 EFLAGS: 00000246 ORIG_RAX: 000000000000012a
RAX: ffffffffffffffda RBX: 000000000056c008 RCX: 0000000000465b09
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000180
RBP: 00000000004b069f R08: 0000000000000000 R09: 0000000000000000
R10: ffffffffffffffff R11: 0000000000000246 R12: 000000000056c008
R13: 00007ffe5af7f2bf R14: 00007fd028707300 R15: 0000000000022000

Allocated by task 12710:
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

Freed by task 12710:
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

The buggy address belongs to the object at ffff88802b6e0000
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 360 bytes inside of
 512-byte region [ffff88802b6e0000, ffff88802b6e0200)
The buggy address belongs to the page:
page:000000005809f65c refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2b6e0
head:000000005809f65c order:1 compound_mapcount:0
flags: 0xfff00000010200(slab|head)
raw: 00fff00000010200 ffffea00008e7200 0000000200000002 ffff88800fc41c80
raw: 0000000000000000 0000000000080008 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88802b6e0000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88802b6e0080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88802b6e0100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                          ^
 ffff88802b6e0180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88802b6e0200: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
