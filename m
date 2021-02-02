Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6374030B7FB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 07:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbhBBGoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 01:44:12 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:55213 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbhBBGoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 01:44:03 -0500
Received: by mail-il1-f198.google.com with SMTP id s4so5834678ilt.21
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 22:43:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=WB+jcfdWpGDt4XPZj1MZGlayBjfOagoKBQgU4EYM9lQ=;
        b=Y+zjvBmpVwoDq7VoQ/APY+E5Lmngbwc8L87CRry6GKxTSmnvxRWqEoazYCj4WPbG8v
         2iT4QEd9xT7tDyV75jrLmk9HbVFVu0UxXezvcW44n4Lmgo0lAODuHgNJmgpf29fnxbV1
         r4XQF0MhGIj5ER3HcyNuCJWSbJQAuCoYS+uNV4/UZ4L5/cOH6f0MwGK+XImzTxBt6xFt
         tqXxHLS1pCKrn2yKwWGgsyJA9h4ib8O/uFpxqYv+wzC9u3z+qpxO2+X8PKVuzVzHrg2g
         8zMq/X46XobXVh2Wrn664ExqHFIaBrlQ0zZVkyK3GBWc/NtFKkb5zlhawwvh1TPjkh70
         MKpw==
X-Gm-Message-State: AOAM532Pg/OYWHwvObkR+CO1Bp259ptwLBjdiA3p+YcWBG5+pIrpruIZ
        BKpDH2rpQfe2uHPF6ayxqclFLnlmnKpVevRWrLXk1MFy7A/l
X-Google-Smtp-Source: ABdhPJzdz03vZ/PW4VC5zleFGnUAWI84d8keOEVABTwZpnwB2VZFMWNmYtIziMqyBntADz4pR9lyK/METZ+nWRV2XuhpjmOP0nTV
MIME-Version: 1.0
X-Received: by 2002:a02:3844:: with SMTP id v4mr17909812jae.1.1612248202096;
 Mon, 01 Feb 2021 22:43:22 -0800 (PST)
Date:   Mon, 01 Feb 2021 22:43:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006036d305ba54c914@google.com>
Subject: KASAN: use-after-free Read in uprobe_munmap
From:   syzbot <syzbot+2f6d683983e3905ad8d6@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=1260a5bf500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=80ac9f64e6e2c06
dashboard link: https://syzkaller.appspot.com/bug?extid=2f6d683983e3905ad8d6

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2f6d683983e3905ad8d6@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in find_node_in_range kernel/events/uprobes.c:1271 [inline]
BUG: KASAN: use-after-free in vma_has_uprobes kernel/events/uprobes.c:1414 [inline]
BUG: KASAN: use-after-free in uprobe_munmap+0x485/0x560 kernel/events/uprobes.c:1435
Read of size 8 at addr ffff888027f6ad68 by task syz-executor.1/10054

CPU: 0 PID: 10054 Comm: syz-executor.1 Not tainted 5.11.0-rc6-next-20210201-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:120
 print_address_description.constprop.0.cold+0x5b/0x2f8 mm/kasan/report.c:232
 __kasan_report mm/kasan/report.c:399 [inline]
 kasan_report.cold+0x7c/0xd8 mm/kasan/report.c:416
 find_node_in_range kernel/events/uprobes.c:1271 [inline]
 vma_has_uprobes kernel/events/uprobes.c:1414 [inline]
 uprobe_munmap+0x485/0x560 kernel/events/uprobes.c:1435
 unmap_single_vma+0xe9/0x300 mm/memory.c:1472
 unmap_vmas+0x168/0x2e0 mm/memory.c:1528
 unmap_region+0x231/0x380 mm/mmap.c:2688
 __do_munmap+0x661/0x11a0 mm/mmap.c:2920
 do_munmap mm/mmap.c:2931 [inline]
 munmap_vma_range mm/mmap.c:598 [inline]
 mmap_region+0x85a/0x1730 mm/mmap.c:1749
 do_mmap+0xcff/0x11d0 mm/mmap.c:1580
 vm_mmap_pgoff+0x1b7/0x290 mm/util.c:519
 ksys_mmap_pgoff+0x49c/0x620 mm/mmap.c:1631
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x465b09
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f50b0979188 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 000000000056bf60 RCX: 0000000000465b09
RDX: 0000000000000000 RSI: 0000000000001000 RDI: 0000000020005000
RBP: 00000000004b069f R08: 0000000000000006 R09: 0000000000000000
R10: 0000000000002812 R11: 0000000000000246 R12: 000000000056bf60
R13: 00007fffcdb1e35f R14: 00007f50b0979300 R15: 0000000000022000

Allocated by task 10054:
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

Freed by task 10054:
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

The buggy address belongs to the object at ffff888027f6ac00
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 360 bytes inside of
 512-byte region [ffff888027f6ac00, ffff888027f6ae00)
The buggy address belongs to the page:
page:00000000511295cc refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x27f6a
head:00000000511295cc order:1 compound_mapcount:0
flags: 0xfff00000010200(slab|head)
raw: 00fff00000010200 ffffea0000bb4900 0000000200000002 ffff88800fc41c80
raw: 0000000000000000 0000000080080008 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888027f6ac00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888027f6ac80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888027f6ad00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                          ^
 ffff888027f6ad80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888027f6ae00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
