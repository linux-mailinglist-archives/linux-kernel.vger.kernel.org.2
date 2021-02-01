Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7570230AD61
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 18:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbhBARGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 12:06:04 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:55999 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbhBARGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 12:06:01 -0500
Received: by mail-il1-f198.google.com with SMTP id q11so7793360ild.22
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 09:05:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=MYMEozv9mv+eNjit1PtyRVKgDDO9Jk3vPgSwhA/LXgw=;
        b=fert9cXKUnENeSf1nFlukpkjm8FYzl39V6FQDXUfZIeAf4CPTC9rhEXFx86TvsduYk
         rlgeQw/cY8Tw5Nm1hk9wK9kTltnPzeHLpRCHRsBM6dMxLUshhXxQm+Mrdc1Epn0a6qet
         f5mLvQMdFUaY3BH5UDTsKz2LP0G1fpNQH9fsXOxjcJpZXuHi8Y2z2gJyNGJf4YcMeafo
         dhwfpiXcXHJlIa1EznXHSaq+dUsEBPJ/uMcPz+g/B5XiM/PBKSzTXgiaFUBcLZkBTM4O
         BRtxrf4Kik5K3QyVA9Rou8NUjNojTWGrK5c3EY2f9PmyMzr1TwQZDFAak/PHX0ZIvE0f
         HjjA==
X-Gm-Message-State: AOAM530M870JXLquo3JNHPoW2xC0KRkzqDQRa5jo/KKiRpXRHLVupObo
        1WDqlrRPEmvMVCKyWm3874DJ9MQz9647z4q/epqnMjUA3/pH
X-Google-Smtp-Source: ABdhPJw148elYTD2QZj0SKs5h/Uz3Itq4sKPNHUQX8wSVHTw2SKeYOszt9DwPh2ksERU8Cr5oSurdTzWqrRIjtB9bN0WTsopiO/u
MIME-Version: 1.0
X-Received: by 2002:a05:6602:c9:: with SMTP id z9mr13154766ioe.174.1612199120685;
 Mon, 01 Feb 2021 09:05:20 -0800 (PST)
Date:   Mon, 01 Feb 2021 09:05:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e54dd405ba495b1b@google.com>
Subject: KASAN: use-after-free Read in uprobe_mmap
From:   syzbot <syzbot+1b42cf51b91edbad28c9@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=113333d8d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=80ac9f64e6e2c06
dashboard link: https://syzkaller.appspot.com/bug?extid=1b42cf51b91edbad28c9

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1b42cf51b91edbad28c9@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in find_node_in_range kernel/events/uprobes.c:1271 [inline]
BUG: KASAN: use-after-free in build_probe_list kernel/events/uprobes.c:1305 [inline]
BUG: KASAN: use-after-free in uprobe_mmap+0xdbb/0x1080 kernel/events/uprobes.c:1382
Read of size 8 at addr ffff888011a30168 by task syz-executor.5/11127

CPU: 1 PID: 11127 Comm: syz-executor.5 Not tainted 5.11.0-rc6-next-20210201-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:120
 print_address_description.constprop.0.cold+0x5b/0x2f8 mm/kasan/report.c:232
 __kasan_report mm/kasan/report.c:399 [inline]
 kasan_report.cold+0x7c/0xd8 mm/kasan/report.c:416
 find_node_in_range kernel/events/uprobes.c:1271 [inline]
 build_probe_list kernel/events/uprobes.c:1305 [inline]
 uprobe_mmap+0xdbb/0x1080 kernel/events/uprobes.c:1382
 mmap_region+0x56c/0x1730 mm/mmap.c:1881
 do_mmap+0xcff/0x11d0 mm/mmap.c:1580
 vm_mmap_pgoff+0x1b7/0x290 mm/util.c:519
 ksys_mmap_pgoff+0x49c/0x620 mm/mmap.c:1631
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x465b09
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f92c6d90188 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 000000000056bf60 RCX: 0000000000465b09
RDX: 0000000000000000 RSI: 0000000000003000 RDI: 0000000020007000
RBP: 00000000004b069f R08: 0000000000000003 R09: 0000000000000000
R10: 0000000000000412 R11: 0000000000000246 R12: 000000000056bf60
R13: 00007fff798b92af R14: 00007f92c6d90300 R15: 0000000000022000

Allocated by task 11130:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:46 [inline]
 set_alloc_info mm/kasan/common.c:403 [inline]
 ____kasan_kmalloc mm/kasan/common.c:434 [inline]
 ____kasan_kmalloc.constprop.0+0xa0/0xd0 mm/kasan/common.c:406
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

Freed by task 11130:
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

The buggy address belongs to the object at ffff888011a30000
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 360 bytes inside of
 512-byte region [ffff888011a30000, ffff888011a30200)
The buggy address belongs to the page:
page:00000000db11b7ab refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff888011a31000 pfn:0x11a30
head:00000000db11b7ab order:1 compound_mapcount:0
flags: 0xfff00000010200(slab|head)
raw: 00fff00000010200 dead000000000100 dead000000000122 ffff88800fc41c80
raw: ffff888011a31000 0000000080080007 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888011a30000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888011a30080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888011a30100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                          ^
 ffff888011a30180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888011a30200: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
