Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8910844E1D9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 07:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbhKLGYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 01:24:21 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:51760 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbhKLGYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 01:24:19 -0500
Received: by mail-io1-f72.google.com with SMTP id b1-20020a05660214c100b005e241049240so5573468iow.18
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 22:21:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=YmLlaQ4zi3zdC2mkpiEJCIAqQ5h1EVS4QEigFQ0canU=;
        b=nL6cKBh37AUuop7YLEK4HCBzVxDNEKsiqCt3QRbDMaQqwwCLiY335p77RmfqNDm2m2
         lJpom45mbgfawMwIA6zAqHTpreBE5HYhExQ0RUZYDWBm4GXAJxD7dquzJtASIxm4lYbU
         bkTppeT+K4lqBYeDM9FAdP+AfvMwQXL27mvGuMldF08bCX+0W4zRZk22xwranx59GTkA
         K7RVyMLqIy+4S5Y/gSiZVE3PQ87vbsQEKO9nRFEtl2lsuWrsTuhpM6USL/grSPbhuFbj
         hbiVo9PiB1CcYGfXqKdWNNhMU2wRKd7GrWp1s9LwvJ6n420BcsnfMai9Tu9q1yN1gcXc
         QFnA==
X-Gm-Message-State: AOAM531NMzTGLlszTuOcKgy9xZWkPf7aCEv65exzbx+uUcPVjnaE5Pbh
        W+5AMA17Jidt9bacIbA4GgpArFyRX5+qJxjzr/RKqnTDcfXZ
X-Google-Smtp-Source: ABdhPJz4kBRsbMUVzxLmhg9X3bbUWjJ3XUQfQhz3IvMh9EP3cCymfhGcEf4LaIo6qlmXrk3FfjjT+7JJmhFh+27p8mLMFE6rAfSJ
MIME-Version: 1.0
X-Received: by 2002:a02:c908:: with SMTP id t8mr9807494jao.55.1636698089457;
 Thu, 11 Nov 2021 22:21:29 -0800 (PST)
Date:   Thu, 11 Nov 2021 22:21:29 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003a0bcf05d0917857@google.com>
Subject: [syzbot] INFO: task hung in migrate_pages (2)
From:   syzbot <syzbot+67c846f7c9b8278e8471@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    5833291ab6de Merge tag 'pci-v5.16-fixes-1' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14b04e6eb00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9d7259f0deb293aa
dashboard link: https://syzkaller.appspot.com/bug?extid=67c846f7c9b8278e8471
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+67c846f7c9b8278e8471@syzkaller.appspotmail.com

INFO: task kcompactd0:30 blocked for more than 143 seconds.
      Not tainted 5.15.0-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kcompactd0      state:D stack:28032 pid:   30 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4969 [inline]
 __schedule+0xa9a/0x4940 kernel/sched/core.c:6250
 schedule+0xd2/0x260 kernel/sched/core.c:6323
 io_schedule+0xee/0x170 kernel/sched/core.c:8368
 folio_wait_bit_common+0x4f2/0xa60 mm/filemap.c:1371
 lock_page include/linux/pagemap.h:747 [inline]
 __unmap_and_move mm/migrate.c:980 [inline]
 unmap_and_move mm/migrate.c:1204 [inline]
 migrate_pages+0xa5a/0x3810 mm/migrate.c:1481
 compact_zone+0x1abb/0x3860 mm/compaction.c:2399
 kcompactd_do_work+0x2c9/0x730 mm/compaction.c:2839
 kcompactd+0x86b/0xf30 mm/compaction.c:2941
 kthread+0x405/0x4f0 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>

Showing all locks held in the system:
1 lock held by systemd/1:
 #0: ffff88801725c160 (mapping.invalidate_lock){++++}-{3:3}, at: filemap_invalidate_lock_shared include/linux/fs.h:838 [inline]
 #0: ffff88801725c160 (mapping.invalidate_lock){++++}-{3:3}, at: page_cache_ra_unbounded+0x1b3/0x940 mm/readahead.c:194
1 lock held by khungtaskd/27:
 #0: ffffffff8b983a20 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6458
1 lock held by kswapd1/99:
2 locks held by kworker/u4:4/942:
 #0: ffff8880b9d39a98 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2b/0x120 kernel/sched/core.c:478
 #1: ffff8880b9d279c8 (&per_cpu_ptr(group->pcpu, cpu)->seq){-.-.}-{0:0}, at: psi_task_switch+0x3a6/0x490 kernel/sched/psi.c:880
2 locks held by in:imklog/6199:
1 lock held by cron/6194:
 #0: ffffffff8baa8140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim mm/page_alloc.c:4585 [inline]
 #0: ffffffff8baa8140 (fs_reclaim){+.+.}-{0:0}, at: __alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #0: ffffffff8baa8140 (fs_reclaim){+.+.}-{0:0}, at: __alloc_pages_slowpath.constprop.0+0xa1e/0x20d0 mm/page_alloc.c:5007
1 lock held by syz-executor.5/12840:

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 27 Comm: khungtaskd Not tainted 5.15.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 nmi_cpu_backtrace.cold+0x47/0x144 lib/nmi_backtrace.c:105
 nmi_trigger_cpumask_backtrace+0x1ae/0x220 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:210 [inline]
 watchdog+0xc1d/0xf50 kernel/hung_task.c:295
 kthread+0x405/0x4f0 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 942 Comm: kworker/u4:4 Not tainted 5.15.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events_unbound toggle_allocation_gate
RIP: 0010:update_load_avg+0xa/0x1830 kernel/sched/fair.c:3804
Code: e9 b3 fa ff ff 48 8b 7c 24 28 e8 a1 bd 6a 00 e9 38 f7 ff ff e8 97 bd 6a 00 e9 4e f7 ff ff 66 90 48 b8 00 00 00 00 00 fc ff df <41> 57 41 56 41 55 41 54 55 48 89 f5 53 48 89 fb 48 81 c7 c4 01 00
RSP: 0018:ffffc90004adfb10 EFLAGS: 00000046
RAX: dffffc0000000000 RBX: ffff8880178d5790 RCX: 1ffff110035fa014
RDX: 0000000000000000 RSI: ffff88801afd0080 RDI: ffff8880b9d39b40
RBP: ffff88801afd0080 R08: ffff88801afd0090 R09: 0000000000000001
R10: 0000000000000004 R11: 0000000000000000 R12: ffff8880178d5798
R13: ffff8880b9d39b40 R14: dffffc0000000000 R15: 000006eb640c7135
FS:  0000000000000000(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f3fc0028020 CR3: 000000000b68e000 CR4: 0000000000350ee0
Call Trace:
 <TASK>
 put_prev_entity+0x272/0x5b0 kernel/sched/fair.c:4541
 pick_next_task_fair+0x69c/0xe00 kernel/sched/fair.c:7308
 __pick_next_task kernel/sched/core.c:5590 [inline]
 pick_next_task kernel/sched/core.c:5662 [inline]
 __schedule+0x3e8/0x4940 kernel/sched/core.c:6214
 preempt_schedule_common+0x45/0xc0 kernel/sched/core.c:6416
 __cond_resched+0x13/0x20 kernel/sched/core.c:8129
 _cond_resched include/linux/sched.h:2017 [inline]
 process_one_work+0xaf4/0x1690 kernel/workqueue.c:2324
 worker_thread+0x658/0x11f0 kernel/workqueue.c:2445
 kthread+0x405/0x4f0 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>
----------------
Code disassembly (best guess):
   0:	e9 b3 fa ff ff       	jmpq   0xfffffab8
   5:	48 8b 7c 24 28       	mov    0x28(%rsp),%rdi
   a:	e8 a1 bd 6a 00       	callq  0x6abdb0
   f:	e9 38 f7 ff ff       	jmpq   0xfffff74c
  14:	e8 97 bd 6a 00       	callq  0x6abdb0
  19:	e9 4e f7 ff ff       	jmpq   0xfffff76c
  1e:	66 90                	xchg   %ax,%ax
  20:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  27:	fc ff df
* 2a:	41 57                	push   %r15 <-- trapping instruction
  2c:	41 56                	push   %r14
  2e:	41 55                	push   %r13
  30:	41 54                	push   %r12
  32:	55                   	push   %rbp
  33:	48 89 f5             	mov    %rsi,%rbp
  36:	53                   	push   %rbx
  37:	48 89 fb             	mov    %rdi,%rbx
  3a:	48                   	rex.W
  3b:	81                   	.byte 0x81
  3c:	c7                   	.byte 0xc7
  3d:	c4                   	.byte 0xc4
  3e:	01 00                	add    %eax,(%rax)


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
