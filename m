Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 218163DE4B7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 05:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233641AbhHCDfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 23:35:32 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:48649 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233197AbhHCDfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 23:35:30 -0400
Received: by mail-il1-f198.google.com with SMTP id p6-20020a056e021446b0290205af2e2342so9542023ilo.15
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 20:35:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=cDoPWhQ3zzR4QVHTckj2mt4keM5tVUqZ03dSCzHR0cA=;
        b=Fh7el+yUbaSP2S0FYbDHxSAvSF6CdHKiY9UTY5HRTjN+UPfMOaC1/23++UMd5NHPRN
         G5pEEqzUe0PlmgkwRn8dT/sUTl6XPXHizV/K2cPrTmGyM3dYfrB3I+rLHX6FUhF2bD/e
         3QEvkBuhJRt0Q7kIWNqj1ZsFqbT6tZ4GeNrPNDAiRI0ju+fPZBb3Gwu6GVow/8dZXgh5
         z+w94MkXAGtpSLr8QIogK9m06/v7UVwovRdqT59Q975Srp5XL3uYJQeiMjp0rMS9BdKd
         7od3z9S9AiR0jNDsR+Oyu71HRgPYoiZNvUJM1NLcqbMU8R3nUg4XTi5py97WEZzIGtTN
         dWqA==
X-Gm-Message-State: AOAM5300iEp/+mVnlxVTCRIsmoh7CcZ7dtbGRtmDFCHH9JxOuprO+M4g
        B48RV8y+TCb2xevWfUmqNh+QshWU922VMl9cYPJ+Ku3EBEmV
X-Google-Smtp-Source: ABdhPJxHkgtWTgOub7BPrT76NfeA6aZEI24xN0efajCcswbnwFcgowChoVs9Gtdw6r9QmgoaR+OedUG/RVBz3+aS6PFyKT2Jbkbx
MIME-Version: 1.0
X-Received: by 2002:a5d:9ac1:: with SMTP id x1mr1008220ion.191.1627961720434;
 Mon, 02 Aug 2021 20:35:20 -0700 (PDT)
Date:   Mon, 02 Aug 2021 20:35:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000df3b005c89f60ab@google.com>
Subject: [syzbot] INFO: task hung in __drain_all_pages (2)
From:   syzbot <syzbot+ef4bb06ce1e14f09f852@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    7e96bf476270 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=158907b6300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=40eef000d7648480
dashboard link: https://syzkaller.appspot.com/bug?extid=ef4bb06ce1e14f09f852
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1239e076300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=112ea71a300000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ef4bb06ce1e14f09f852@syzkaller.appspotmail.com

INFO: task syz-executor761:8468 blocked for more than 143 seconds.
      Not tainted 5.14.0-rc3-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor761 state:D stack:24312 pid: 8468 ppid:  8451 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:4683 [inline]
 __schedule+0x93a/0x26f0 kernel/sched/core.c:5940
 schedule+0xd3/0x270 kernel/sched/core.c:6019
 schedule_timeout+0x1db/0x2a0 kernel/time/timer.c:1855
 do_wait_for_common kernel/sched/completion.c:85 [inline]
 __wait_for_common kernel/sched/completion.c:106 [inline]
 wait_for_common kernel/sched/completion.c:117 [inline]
 wait_for_completion+0x176/0x280 kernel/sched/completion.c:138
 __flush_work+0x50e/0xad0 kernel/workqueue.c:3053
 __drain_all_pages+0x47d/0x6c0 mm/page_alloc.c:3255
 drain_all_pages mm/page_alloc.c:3269 [inline]
 __alloc_pages_direct_reclaim mm/page_alloc.c:4643 [inline]
 __alloc_pages_slowpath.constprop.0+0x8e5/0x21b0 mm/page_alloc.c:5033
 __alloc_pages+0x412/0x500 mm/page_alloc.c:5404
 alloc_pages+0x18c/0x2a0 mm/mempolicy.c:2244
 __get_free_pages+0x8/0x40 mm/page_alloc.c:5428
 kasan_populate_vmalloc_pte mm/kasan/shadow.c:266 [inline]
 kasan_populate_vmalloc_pte+0x25/0x160 mm/kasan/shadow.c:257
 apply_to_pte_range mm/memory.c:2532 [inline]
 apply_to_pmd_range mm/memory.c:2576 [inline]
 apply_to_pud_range mm/memory.c:2612 [inline]
 apply_to_p4d_range mm/memory.c:2648 [inline]
 __apply_to_page_range+0x694/0x1080 mm/memory.c:2682
 alloc_vmap_area+0xb2d/0x1e30 mm/vmalloc.c:1530
 __get_vm_area_node.constprop.0+0x128/0x380 mm/vmalloc.c:2389
 __vmalloc_node_range+0x12e/0x960 mm/vmalloc.c:2956
 __bpf_map_area_alloc+0xd5/0x150 kernel/bpf/syscall.c:311
 array_map_alloc+0x285/0x710 kernel/bpf/arraymap.c:139
 prog_array_map_alloc+0x1a0/0x290 kernel/bpf/arraymap.c:1055
 find_and_alloc_map kernel/bpf/syscall.c:127 [inline]
 map_create kernel/bpf/syscall.c:833 [inline]
 __sys_bpf+0xbc3/0x53b0 kernel/bpf/syscall.c:4451
 __do_sys_bpf kernel/bpf/syscall.c:4573 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:4571 [inline]
 __x64_sys_bpf+0x75/0xb0 kernel/bpf/syscall.c:4571
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x445919
RSP: 002b:00007fb397e31318 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00000000004ca408 RCX: 0000000000445919
RDX: 0000000000000040 RSI: 0000000020011fd4 RDI: 0000000000000000
RBP: 00000000004ca400 R08: 00007fb397e31700 R09: 0000000000000000
R10: 00007fb397e31700 R11: 0000000000000246 R12: 000000000049a074
R13: 00007fff4a85ccaf R14: 00007fb397e31400 R15: 0000000000022000

Showing all locks held in the system:
3 locks held by kworker/0:1/7:
2 locks held by kworker/1:1/26:
1 lock held by khungtaskd/1634:
 #0: ffffffff8b97ba40 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6446
1 lock held by khugepaged/1665:
 #0: ffffffff8ba5e6a8 (lock#6){+.+.}-{3:3}, at: __lru_add_drain_all+0x65/0x760 mm/swap.c:791
1 lock held by in:imklog/8146:
 #0: ffff888029644ff0 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0xe9/0x100 fs/file.c:974
1 lock held by syz-executor761/8468:
 #0: ffffffff8ba9d4e8 (pcpu_drain_mutex){+.+.}-{3:3}, at: __drain_all_pages+0x4f/0x6c0 mm/page_alloc.c:3204

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 1634 Comm: khungtaskd Not tainted 5.14.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:105
 nmi_cpu_backtrace.cold+0x44/0xd7 lib/nmi_backtrace.c:105
 nmi_trigger_cpumask_backtrace+0x1b3/0x230 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:210 [inline]
 watchdog+0xd0a/0xfc0 kernel/hung_task.c:295
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 26 Comm: kworker/1:1 Not tainted 5.14.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events prog_array_map_clear_deferred
RIP: 0010:hlock_class kernel/locking/lockdep.c:199 [inline]
RIP: 0010:lookup_chain_cache_add kernel/locking/lockdep.c:3701 [inline]
RIP: 0010:validate_chain kernel/locking/lockdep.c:3757 [inline]
RIP: 0010:__lock_acquire+0x1637/0x54a0 kernel/locking/lockdep.c:5015
Code: 20 66 81 e3 ff 1f 0f b7 db be 08 00 00 00 48 89 d8 48 c1 f8 06 48 8d 3c c5 a0 28 cd 8f e8 c1 04 61 00 48 0f a3 1d 49 5e 72 0e <0f> 83 fe 02 00 00 48 bd eb 83 b5 80 46 86 c8 61 49 0f af ef 48 c1
RSP: 0018:ffffc90000e0f8e8 EFLAGS: 00000047
RAX: 0000000000000001 RBX: 0000000000000656 RCX: ffffffff815aca4f
RDX: fffffbfff1f9a52e RSI: 0000000000000008 RDI: ffffffff8fcd2968
RBP: ffff888011b3c2e2 R08: 0000000000000000 R09: ffffffff8fcd296f
R10: fffffbfff1f9a52d R11: 0000000000000000 R12: ffff888011b3c2c0
R13: ffff888011b3b880 R14: 0000000000000000 R15: 38d833c71a517839
FS:  0000000000000000(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000236a2b8 CR3: 0000000036efe000 CR4: 0000000000350ee0
Call Trace:
 lock_acquire kernel/locking/lockdep.c:5625 [inline]
 lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5590
 __mutex_lock_common kernel/locking/mutex.c:959 [inline]
 __mutex_lock+0x12a/0x10a0 kernel/locking/mutex.c:1104
 fd_array_map_delete_elem+0x120/0x2e0 kernel/bpf/arraymap.c:801
 bpf_fd_array_map_clear kernel/bpf/arraymap.c:851 [inline]
 prog_array_map_clear_deferred+0x10b/0x1b0 kernel/bpf/arraymap.c:1030
 process_one_work+0x98d/0x1630 kernel/workqueue.c:2276
 worker_thread+0x658/0x11f0 kernel/workqueue.c:2422
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
