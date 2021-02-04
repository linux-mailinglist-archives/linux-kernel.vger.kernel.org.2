Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D490C30FA00
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 18:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237995AbhBDRmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 12:42:43 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:39750 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238644AbhBDRk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 12:40:58 -0500
Received: by mail-io1-f71.google.com with SMTP id r140so3570207iod.6
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 09:40:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=SKawFtHmVUvK9ogagJWV/d3JLfJ7PCa7VvPMesvyybU=;
        b=kYk2Lo4vNhkZlaOie/0NQ6VL5vkTRjCI0k0hFjbi+z7Rpv1q61IrBkvCjlEtZB3bV3
         AIapQeGzKZ7QPpL/QEdGvGseaVgp8K7s9psk4VJDAeee51XcRAyr+BXqyaKeq1WDMIFq
         vV1ikFqR39TtNw8O0J0h8UcSp1vqj+74IRNxLNn0PDft75AcvX/qtoMJK4+uzO3XYwub
         QLNqsSApiYPEJVn6ewA1byfdq9ub0Ff5hie9HG90T4omoI7PnyTINx7NRCiIDoFfoLpR
         folEJTrJMHnDwbii5hEFzwu4onp6sJuMSTARUEmK14UHsVgGuJuflbL6ga8eYSsQp1Ku
         f7Bg==
X-Gm-Message-State: AOAM532sEzMFpbnW98mLiCxOzqwmkHal0vSFc/ylDjhIcjM2R3kKIHp8
        t7HeqigOEjxAJNeCCVN6iQ+uX+I8RnDO9liqG+R+6FIGKuFw
X-Google-Smtp-Source: ABdhPJymkNeSf6wtiMNOKNY2WO3Evmag/b6JVGBRO10eyoqPP8Li0QiZ5gO90g2rzf169dZWgu9+gqwfsJsJIfBs2fQjwC2o7TaN
MIME-Version: 1.0
X-Received: by 2002:a05:6638:164c:: with SMTP id a12mr650591jat.128.1612460417360;
 Thu, 04 Feb 2021 09:40:17 -0800 (PST)
Date:   Thu, 04 Feb 2021 09:40:17 -0800
In-Reply-To: <0000000000006637f205ba55aa77@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000064319505ba86323c@google.com>
Subject: Re: KASAN: use-after-free Read in find_uprobe
From:   syzbot <syzbot+9b2492a161dae05a29f0@syzkaller.appspotmail.com>
To:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    0e2c50f4 Add linux-next specific files for 20210204
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12665674d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b5009c5bf1512a87
dashboard link: https://syzkaller.appspot.com/bug?extid=9b2492a161dae05a29f0
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=178163e8d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1094915f500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9b2492a161dae05a29f0@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in uprobe_cmp kernel/events/uprobes.c:620 [inline]
BUG: KASAN: use-after-free in __uprobe_cmp_key kernel/events/uprobes.c:646 [inline]
BUG: KASAN: use-after-free in rb_find include/linux/rbtree.h:289 [inline]
BUG: KASAN: use-after-free in __find_uprobe kernel/events/uprobes.c:661 [inline]
BUG: KASAN: use-after-free in find_uprobe+0x12c/0x150 kernel/events/uprobes.c:678
Read of size 8 at addr ffff888017f05d68 by task syz-executor109/8411

CPU: 1 PID: 8411 Comm: syz-executor109 Not tainted 5.11.0-rc6-next-20210204-syzkaller #0
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
 __do_sys_exit_group kernel/exit.c:933 [inline]
 __se_sys_exit_group kernel/exit.c:931 [inline]
 __x64_sys_exit_group+0x3a/0x50 kernel/exit.c:931
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x43daf9
Code: Unable to access opcode bytes at RIP 0x43dacf.
RSP: 002b:00007ffd1d03f8e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00000000004ae230 RCX: 000000000043daf9
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffffffffffc0 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00000000004ae230
R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000001

Allocated by task 8411:
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

Freed by task 8411:
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

The buggy address belongs to the object at ffff888017f05c00
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 360 bytes inside of
 512-byte region [ffff888017f05c00, ffff888017f05e00)
The buggy address belongs to the page:
page:00000000b82340ef refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x17f04
head:00000000b82340ef order:1 compound_mapcount:0
flags: 0xfff00000010200(slab|head)
raw: 00fff00000010200 dead000000000100 dead000000000122 ffff888010841c80
raw: 0000000000000000 0000000000080008 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888017f05c00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888017f05c80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888017f05d00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                          ^
 ffff888017f05d80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888017f05e00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================

