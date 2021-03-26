Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 629FF34A58C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 11:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhCZK3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 06:29:43 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:38092 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbhCZK3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 06:29:19 -0400
Received: by mail-io1-f69.google.com with SMTP id x9so5836927iob.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 03:29:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=fsls31gFi45Iu+3nG0BVy3y4DBCfQSDMDyV3tMZd58k=;
        b=sgniqTJMWiZ7XFILLjeLxTj+rq7LtUaQimJ/zMdFgBjJ+/aJUWkfBVDQ1MKSSEMBEo
         Wh+YI9OFtM5iJwmkUGHvXYVyx5tCef3agvCQ4PochTfHBWF/9eFQau74vtdNQwQxAMYf
         qdWk4yKMgG+MrrY/TUJKGyZYKzSXdbM6s/DcC4sc9b9miLdhPYV2RNlsQuvDvh5XQdxk
         RyhkLzpQfHj8RBciUQ0d6eGeAywrqOJeR7pPql5nfBP6lRkFzngTnpYMQ7M+XIe2SryT
         vWt0AhOxKQQATnVGuY/iT0DyuvkFCznGKb8fFbpI+bP84XRfwkgCPmJV3hPjYt/IJtnu
         rYxw==
X-Gm-Message-State: AOAM533+aRkbnAGdEPOSQUDczVML+1AIq7fEJvu01sDcoPFl94Xj44JM
        joQgUUycEQwXfbjtnGBwNYnfJPewC5Nxdv5+ynaJ9vgnOZkP
X-Google-Smtp-Source: ABdhPJxW0OMmr1dziYNgsUVMSlMre0Is+RztVBM2RkdBgJE5GygAxDkyPQYcKgrmP5peMx6Te5Vl4pLVyw/ZaxywjBYxAel3GCtV
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b2b:: with SMTP id e11mr970321ilu.149.1616754559198;
 Fri, 26 Mar 2021 03:29:19 -0700 (PDT)
Date:   Fri, 26 Mar 2021 03:29:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000030aca605be6e0102@google.com>
Subject: [syzbot] possible deadlock in register_for_each_vma
From:   syzbot <syzbot+b804f902bbb6bcf290cb@syzkaller.appspotmail.com>
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

HEAD commit:    0d02ec6b Linux 5.12-rc4
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1719e4aad00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5adab0bdee099d7a
dashboard link: https://syzkaller.appspot.com/bug?extid=b804f902bbb6bcf290cb

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b804f902bbb6bcf290cb@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
5.12.0-rc4-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor.3/23522 is trying to acquire lock:
ffffffff8c03e530 (dup_mmap_sem){++++}-{0:0}, at: register_for_each_vma+0x2c/0xc10 kernel/events/uprobes.c:1040

but task is already holding lock:
ffff8880624a8c90 (&uprobe->register_rwsem){+.+.}-{3:3}, at: __uprobe_register+0x531/0x850 kernel/events/uprobes.c:1177

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&uprobe->register_rwsem){+.+.}-{3:3}:
       down_write+0x92/0x150 kernel/locking/rwsem.c:1406
       __uprobe_register+0x531/0x850 kernel/events/uprobes.c:1177
       trace_uprobe_enable kernel/trace/trace_uprobe.c:1065 [inline]
       probe_event_enable+0x357/0xa00 kernel/trace/trace_uprobe.c:1134
       trace_uprobe_register+0x443/0x880 kernel/trace/trace_uprobe.c:1461
       perf_trace_event_reg kernel/trace/trace_event_perf.c:129 [inline]
       perf_trace_event_init+0x549/0xa20 kernel/trace/trace_event_perf.c:204
       perf_uprobe_init+0x16f/0x210 kernel/trace/trace_event_perf.c:336
       perf_uprobe_event_init+0xff/0x1c0 kernel/events/core.c:9754
       perf_try_init_event+0x12a/0x560 kernel/events/core.c:11071
       perf_init_event kernel/events/core.c:11123 [inline]
       perf_event_alloc.part.0+0xe3b/0x3960 kernel/events/core.c:11403
       perf_event_alloc kernel/events/core.c:11785 [inline]
       __do_sys_perf_event_open+0x647/0x2e60 kernel/events/core.c:11883
       do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #2 (event_mutex){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:949 [inline]
       __mutex_lock+0x139/0x1120 kernel/locking/mutex.c:1096
       perf_trace_destroy+0x23/0xf0 kernel/trace/trace_event_perf.c:241
       _free_event+0x2ee/0x1380 kernel/events/core.c:4863
       put_event kernel/events/core.c:4957 [inline]
       perf_mmap_close+0x572/0xe10 kernel/events/core.c:6002
       remove_vma+0xae/0x170 mm/mmap.c:180
       remove_vma_list mm/mmap.c:2653 [inline]
       __do_munmap+0x74f/0x11a0 mm/mmap.c:2909
       do_munmap mm/mmap.c:2917 [inline]
       munmap_vma_range mm/mmap.c:598 [inline]
       mmap_region+0x85a/0x1730 mm/mmap.c:1750
       do_mmap+0xcff/0x11d0 mm/mmap.c:1581
       vm_mmap_pgoff+0x1b7/0x290 mm/util.c:519
       ksys_mmap_pgoff+0x49c/0x620 mm/mmap.c:1632
       do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #1 (&mm->mmap_lock#2){++++}-{3:3}:
       down_write_killable+0x95/0x170 kernel/locking/rwsem.c:1417
       mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
       dup_mmap kernel/fork.c:480 [inline]
       dup_mm+0x12e/0x1380 kernel/fork.c:1368
       copy_mm kernel/fork.c:1424 [inline]
       copy_process+0x2b99/0x7150 kernel/fork.c:2107
       kernel_clone+0xe7/0xab0 kernel/fork.c:2500
       __do_sys_clone+0xc8/0x110 kernel/fork.c:2617
       do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #0 (dup_mmap_sem){++++}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:2936 [inline]
       check_prevs_add kernel/locking/lockdep.c:3059 [inline]
       validate_chain kernel/locking/lockdep.c:3674 [inline]
       __lock_acquire+0x2b14/0x54c0 kernel/locking/lockdep.c:4900
       lock_acquire kernel/locking/lockdep.c:5510 [inline]
       lock_acquire+0x1ab/0x740 kernel/locking/lockdep.c:5475
       percpu_down_write+0x95/0x440 kernel/locking/percpu-rwsem.c:217
       register_for_each_vma+0x2c/0xc10 kernel/events/uprobes.c:1040
       __uprobe_register+0x5c2/0x850 kernel/events/uprobes.c:1181
       trace_uprobe_enable kernel/trace/trace_uprobe.c:1065 [inline]
       probe_event_enable+0x357/0xa00 kernel/trace/trace_uprobe.c:1134
       trace_uprobe_register+0x443/0x880 kernel/trace/trace_uprobe.c:1461
       perf_trace_event_reg kernel/trace/trace_event_perf.c:129 [inline]
       perf_trace_event_init+0x549/0xa20 kernel/trace/trace_event_perf.c:204
       perf_uprobe_init+0x16f/0x210 kernel/trace/trace_event_perf.c:336
       perf_uprobe_event_init+0xff/0x1c0 kernel/events/core.c:9754
       perf_try_init_event+0x12a/0x560 kernel/events/core.c:11071
       perf_init_event kernel/events/core.c:11123 [inline]
       perf_event_alloc.part.0+0xe3b/0x3960 kernel/events/core.c:11403
       perf_event_alloc kernel/events/core.c:11785 [inline]
       __do_sys_perf_event_open+0x647/0x2e60 kernel/events/core.c:11883
       do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
       entry_SYSCALL_64_after_hwframe+0x44/0xae

other info that might help us debug this:

Chain exists of:
  dup_mmap_sem --> event_mutex --> &uprobe->register_rwsem

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&uprobe->register_rwsem);
                               lock(event_mutex);
                               lock(&uprobe->register_rwsem);
  lock(dup_mmap_sem);

 *** DEADLOCK ***

3 locks held by syz-executor.3/23522:
 #0: ffffffff8fe4fcd8 (&pmus_srcu){....}-{0:0}, at: perf_event_alloc.part.0+0xc8e/0x3960 kernel/events/core.c:11401
 #1: ffffffff8bfe5688 (event_mutex){+.+.}-{3:3}, at: perf_uprobe_init+0x164/0x210 kernel/trace/trace_event_perf.c:335
 #2: ffff8880624a8c90 (&uprobe->register_rwsem){+.+.}-{3:3}, at: __uprobe_register+0x531/0x850 kernel/events/uprobes.c:1177

stack backtrace:
CPU: 0 PID: 23522 Comm: syz-executor.3 Not tainted 5.12.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x141/0x1d7 lib/dump_stack.c:120
 check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2127
 check_prev_add kernel/locking/lockdep.c:2936 [inline]
 check_prevs_add kernel/locking/lockdep.c:3059 [inline]
 validate_chain kernel/locking/lockdep.c:3674 [inline]
 __lock_acquire+0x2b14/0x54c0 kernel/locking/lockdep.c:4900
 lock_acquire kernel/locking/lockdep.c:5510 [inline]
 lock_acquire+0x1ab/0x740 kernel/locking/lockdep.c:5475
 percpu_down_write+0x95/0x440 kernel/locking/percpu-rwsem.c:217
 register_for_each_vma+0x2c/0xc10 kernel/events/uprobes.c:1040
 __uprobe_register+0x5c2/0x850 kernel/events/uprobes.c:1181
 trace_uprobe_enable kernel/trace/trace_uprobe.c:1065 [inline]
 probe_event_enable+0x357/0xa00 kernel/trace/trace_uprobe.c:1134
 trace_uprobe_register+0x443/0x880 kernel/trace/trace_uprobe.c:1461
 perf_trace_event_reg kernel/trace/trace_event_perf.c:129 [inline]
 perf_trace_event_init+0x549/0xa20 kernel/trace/trace_event_perf.c:204
 perf_uprobe_init+0x16f/0x210 kernel/trace/trace_event_perf.c:336
 perf_uprobe_event_init+0xff/0x1c0 kernel/events/core.c:9754
 perf_try_init_event+0x12a/0x560 kernel/events/core.c:11071
 perf_init_event kernel/events/core.c:11123 [inline]
 perf_event_alloc.part.0+0xe3b/0x3960 kernel/events/core.c:11403
 perf_event_alloc kernel/events/core.c:11785 [inline]
 __do_sys_perf_event_open+0x647/0x2e60 kernel/events/core.c:11883
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x466459
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f30c08b8188 EFLAGS: 00000246 ORIG_RAX: 000000000000012a
RAX: ffffffffffffffda RBX: 000000000056bf60 RCX: 0000000000466459
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000180
RBP: 00000000004bf9fb R08: 0000000000000000 R09: 0000000000000000
R10: ffffffffffffffff R11: 0000000000000246 R12: 000000000056bf60
R13: 00007ffedcea592f R14: 00007f30c08b8300 R15: 0000000000022000


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
