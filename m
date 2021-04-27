Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41A9036C886
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 17:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237747AbhD0PTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 11:19:14 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:54927 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235659AbhD0PTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 11:19:11 -0400
Received: by mail-il1-f199.google.com with SMTP id a1-20020a92c5410000b02901689a5cd3bdso30456923ilj.21
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 08:18:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=OX6ZYj2C1JPfZNzwKRJUc3tSMh0rgRqCJ28q9aB2gHg=;
        b=bW4a4k9l6vq6X/R/TadXKxfJnhZY/0R4yxwAULL6v6Xs1IddjQd/lP7lPJICZx2T3R
         eEECATf/iB2j7t9oxoZwX8hAiiqlzmPILrw/snYNdunsYHSC0tGgYDQ/RhO8T9zNFck3
         7Lr1nTJEjwRz4U2+YXAMXXFqEkr2czwOsLYq+hNv4fSXlrOjrcn5vA60FSWzNaddXlgp
         hy28FRe3uv66FDt0kc1ZT/3aosMh/3JOz82FZJ+HaHECG9GoKZRrYppDfQshqsIRIREj
         fmB0ZjJJJUb8GFyxqAsPwBHRTtUhiL14uWDD9x/YWwMdGuXOshiwets6UddCxFrAwc5h
         7EoA==
X-Gm-Message-State: AOAM533x6Xxrv4vu2LF82gHrIwN769mcsfkXwhpI9BjRJi6dV8HQmRQm
        hgus3BpXufqGCmKE2eLznmcl6xKZ/oWzaYUyxS+9zSTUw4S5
X-Google-Smtp-Source: ABdhPJzerj/N3Gr9tqX47UAcDnGuc2M9ZzQ+uWpnXRrccKh8wNaNrjEB4hEDarLps2LoMWrgU9Ijlw5hSjcbZOwH/g0OiPcjvJDS
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b01:: with SMTP id i1mr19145201ilv.280.1619536707155;
 Tue, 27 Apr 2021 08:18:27 -0700 (PDT)
Date:   Tue, 27 Apr 2021 08:18:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000217d7005c0f5c6b1@google.com>
Subject: [syzbot] possible deadlock in vm_mmap_pgoff
From:   syzbot <syzbot+f619f7c0a2a5f87694e6@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        rostedt@goodmis.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    7af08140 Revert "gcov: clang: fix clang-11+ build"
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17d57dfed00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=76c0382ceab56d34
dashboard link: https://syzkaller.appspot.com/bug?extid=f619f7c0a2a5f87694e6

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f619f7c0a2a5f87694e6@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
5.12.0-rc8-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor.1/16055 is trying to acquire lock:
ffffffff8bfe2bc8 (event_mutex){+.+.}-{3:3}, at: perf_trace_destroy+0x23/0xf0 kernel/trace/trace_event_perf.c:241

but task is already holding lock:
ffff88801b887258 (&mm->mmap_lock#2){++++}-{3:3}, at: mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
ffff88801b887258 (&mm->mmap_lock#2){++++}-{3:3}, at: vm_mmap_pgoff+0x15c/0x290 mm/util.c:517

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&mm->mmap_lock#2){++++}-{3:3}:
       down_write_killable+0x95/0x170 kernel/locking/rwsem.c:1417
       mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
       dup_mmap kernel/fork.c:480 [inline]
       dup_mm+0x12e/0x1380 kernel/fork.c:1368
       copy_mm kernel/fork.c:1424 [inline]
       copy_process+0x2bc8/0x71a0 kernel/fork.c:2113
       kernel_clone+0xe7/0xab0 kernel/fork.c:2500
       __do_sys_clone+0xc8/0x110 kernel/fork.c:2617
       do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #2 (dup_mmap_sem){++++}-{0:0}:
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

-> #1 (&uprobe->register_rwsem){+.+.}-{3:3}:
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

-> #0 (event_mutex){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:2937 [inline]
       check_prevs_add kernel/locking/lockdep.c:3060 [inline]
       validate_chain kernel/locking/lockdep.c:3675 [inline]
       __lock_acquire+0x2b14/0x54c0 kernel/locking/lockdep.c:4901
       lock_acquire kernel/locking/lockdep.c:5511 [inline]
       lock_acquire+0x1ab/0x740 kernel/locking/lockdep.c:5476
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

other info that might help us debug this:

Chain exists of:
  event_mutex --> dup_mmap_sem --> &mm->mmap_lock#2

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&mm->mmap_lock#2);
                               lock(dup_mmap_sem);
                               lock(&mm->mmap_lock#2);
  lock(event_mutex);

 *** DEADLOCK ***

1 lock held by syz-executor.1/16055:
 #0: ffff88801b887258 (&mm->mmap_lock#2){++++}-{3:3}, at: mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #0: ffff88801b887258 (&mm->mmap_lock#2){++++}-{3:3}, at: vm_mmap_pgoff+0x15c/0x290 mm/util.c:517

stack backtrace:
CPU: 2 PID: 16055 Comm: syz-executor.1 Not tainted 5.12.0-rc8-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x141/0x1d7 lib/dump_stack.c:120
 check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2128
 check_prev_add kernel/locking/lockdep.c:2937 [inline]
 check_prevs_add kernel/locking/lockdep.c:3060 [inline]
 validate_chain kernel/locking/lockdep.c:3675 [inline]
 __lock_acquire+0x2b14/0x54c0 kernel/locking/lockdep.c:4901
 lock_acquire kernel/locking/lockdep.c:5511 [inline]
 lock_acquire+0x1ab/0x740 kernel/locking/lockdep.c:5476
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
RIP: 0033:0x466459
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007eff7f246188 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 000000000056bf60 RCX: 0000000000466459
RDX: 0000000000000000 RSI: 0000000000003000 RDI: 0000000020ffc000
RBP: 00000000004bf9fb R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000011 R11: 0000000000000246 R12: 000000000056bf60
R13: 00007fff0b32a74f R14: 00007eff7f246300 R15: 0000000000022000


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
