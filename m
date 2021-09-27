Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82A1B419D1A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 19:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237768AbhI0RmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 13:42:19 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:48758 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237065AbhI0RmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 13:42:01 -0400
Received: by mail-il1-f199.google.com with SMTP id x17-20020a927c11000000b0024da94ff1a6so19524690ilc.15
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 10:40:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=swVaGhsc6FB0JtyepZaFHR3VXX9wosPf7B18mHjCgo0=;
        b=Zxa+qO3601rCrRl4Vn0jrb9aYsHgEbWEWsNIoVU4SBLl+EZyRjY1r9bycwKR14YINE
         7JnXhP5VxUA2uJRaVxKf/rXq2OdRZoU4O85f1pagtJAUGzokOyhW6LhEB+wOKK6fTl/A
         F1asZyW4tY4XrA1F+F/+leCYqbE4N2uv16SxG9CMdsFs5D7NeZgxTwFFRQ585YwkzmUl
         egWeKuAGadXEQfqNCChfNeLgPsAp51h+7Z55x2FOyK53+KTPQYpl5seLDcseVY7yK7R1
         QofxPw75c0GTXu52BeQoQajCg+46wt7mtJa0WbAJMNE0q8d2gks4n+Q7O5VrDPL7cUUK
         9MrQ==
X-Gm-Message-State: AOAM5322l7ZfsZxbJxYCYvRgXQYSrXIrG2r6yGTUDkSnARYOvV7UMZuS
        CCRk7GxtAsd70HYkE8fqxBmbM9k4ekDSBJ0bfGzhJLl+3gEt
X-Google-Smtp-Source: ABdhPJw/JRGNnV6WNAd+DBpeMyJ8C9s3bfvXWTdo99KVQLCMObaIsIChQWqLa0GjAhai/S+amIDpHNi9VD2P7XfsH+QEHiG9casU
MIME-Version: 1.0
X-Received: by 2002:a5e:8d16:: with SMTP id m22mr711651ioj.62.1632764422730;
 Mon, 27 Sep 2021 10:40:22 -0700 (PDT)
Date:   Mon, 27 Sep 2021 10:40:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006b363405ccfd971d@google.com>
Subject: [syzbot] possible deadlock in register_for_each_vma (2)
From:   syzbot <syzbot+aca1f8067e639ef04ff7@syzkaller.appspotmail.com>
To:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, mark.rutland@arm.com,
        mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    7d42e9818258 Merge tag 'gpio-fixes-for-v5.15-rc3' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15ec2213300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=83fd90919369058f
dashboard link: https://syzkaller.appspot.com/bug?extid=aca1f8067e639ef04ff7
compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+aca1f8067e639ef04ff7@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
5.15.0-rc2-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor.5/15152 is trying to acquire lock:
ffffffff8c9a7c10 (dup_mmap_sem){++++}-{0:0}, at: register_for_each_vma+0x32/0xc50 kernel/events/uprobes.c:1041

but task is already holding lock:
ffff88807d694c90 (&uprobe->register_rwsem){+.+.}-{3:3}, at: __uprobe_register+0x4fd/0x860 kernel/events/uprobes.c:1178

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&uprobe->register_rwsem){+.+.}-{3:3}:
       lock_acquire+0x19f/0x4d0 kernel/locking/lockdep.c:5625
       down_write+0x97/0x170 kernel/locking/rwsem.c:1517
       __uprobe_register+0x4fd/0x860 kernel/events/uprobes.c:1178
       trace_uprobe_enable kernel/trace/trace_uprobe.c:1065 [inline]
       probe_event_enable+0x399/0xbd0 kernel/trace/trace_uprobe.c:1134
       perf_trace_event_reg kernel/trace/trace_event_perf.c:129 [inline]
       perf_trace_event_init+0x49b/0x950 kernel/trace/trace_event_perf.c:204
       perf_uprobe_init+0x138/0x1a0 kernel/trace/trace_event_perf.c:336
       perf_uprobe_event_init+0xfe/0x180 kernel/events/core.c:9886
       perf_try_init_event+0x13e/0x3d0 kernel/events/core.c:11193
       perf_init_event kernel/events/core.c:11257 [inline]
       perf_event_alloc+0x1155/0x2c10 kernel/events/core.c:11548
       __do_sys_perf_event_open kernel/events/core.c:12069 [inline]
       __se_sys_perf_event_open+0x7b2/0x4280 kernel/events/core.c:11961
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x44/0xd0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #2 (event_mutex){+.+.}-{3:3}:
       lock_acquire+0x19f/0x4d0 kernel/locking/lockdep.c:5625
       __mutex_lock_common+0x1df/0x2550 kernel/locking/mutex.c:596
       __mutex_lock kernel/locking/mutex.c:729 [inline]
       mutex_lock_nested+0x1a/0x20 kernel/locking/mutex.c:743
       perf_trace_destroy+0x27/0xb0 kernel/trace/trace_event_perf.c:241
       _free_event+0x874/0xe50 kernel/events/core.c:4958
       put_event kernel/events/core.c:5052 [inline]
       perf_mmap_close+0x8dd/0xde0 kernel/events/core.c:6111
       remove_vma mm/mmap.c:184 [inline]
       remove_vma_list mm/mmap.c:2629 [inline]
       __do_munmap+0x1c2f/0x1e80 mm/mmap.c:2887
       do_munmap mm/mmap.c:2895 [inline]
       munmap_vma_range mm/mmap.c:603 [inline]
       mmap_region+0x9e8/0x1b60 mm/mmap.c:1742
       do_mmap+0x88b/0xf30 mm/mmap.c:1575
       vm_mmap_pgoff+0x1e5/0x2f0 mm/util.c:519
       ksys_mmap_pgoff+0x4a4/0x740 mm/mmap.c:1624
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x44/0xd0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #1 (&mm->mmap_lock#2){++++}-{3:3}:
       lock_acquire+0x19f/0x4d0 kernel/locking/lockdep.c:5625
       down_write_killable+0xaa/0x1b0 kernel/locking/rwsem.c:1528
       mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
       dup_mmap+0xde/0xfd0 kernel/fork.c:499
       dup_mm+0x8c/0x310 kernel/fork.c:1453
       copy_mm kernel/fork.c:1505 [inline]
       copy_process+0x28d7/0x5c80 kernel/fork.c:2194
       kernel_clone+0x230/0x7d0 kernel/fork.c:2584
       __do_sys_clone kernel/fork.c:2701 [inline]
       __se_sys_clone kernel/fork.c:2685 [inline]
       __x64_sys_clone+0x245/0x2b0 kernel/fork.c:2685
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x44/0xd0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #0 (dup_mmap_sem){++++}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3051 [inline]
       check_prevs_add kernel/locking/lockdep.c:3174 [inline]
       validate_chain+0x1dfb/0x8240 kernel/locking/lockdep.c:3789
       __lock_acquire+0x1382/0x2b00 kernel/locking/lockdep.c:5015
       lock_acquire+0x19f/0x4d0 kernel/locking/lockdep.c:5625
       percpu_down_write+0x52/0x2f0 kernel/locking/percpu-rwsem.c:217
       register_for_each_vma+0x32/0xc50 kernel/events/uprobes.c:1041
       __uprobe_register+0x5d4/0x860 kernel/events/uprobes.c:1182
       trace_uprobe_enable kernel/trace/trace_uprobe.c:1065 [inline]
       probe_event_enable+0x399/0xbd0 kernel/trace/trace_uprobe.c:1134
       perf_trace_event_reg kernel/trace/trace_event_perf.c:129 [inline]
       perf_trace_event_init+0x49b/0x950 kernel/trace/trace_event_perf.c:204
       perf_uprobe_init+0x138/0x1a0 kernel/trace/trace_event_perf.c:336
       perf_uprobe_event_init+0xfe/0x180 kernel/events/core.c:9886
       perf_try_init_event+0x13e/0x3d0 kernel/events/core.c:11193
       perf_init_event kernel/events/core.c:11257 [inline]
       perf_event_alloc+0x1155/0x2c10 kernel/events/core.c:11548
       __do_sys_perf_event_open kernel/events/core.c:12069 [inline]
       __se_sys_perf_event_open+0x7b2/0x4280 kernel/events/core.c:11961
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x44/0xd0 arch/x86/entry/common.c:80
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

3 locks held by syz-executor.5/15152:
 #0: ffffffff90984d78 (&pmus_srcu){....}-{0:0}, at: rcu_lock_acquire+0x9/0x30 include/linux/rcupdate.h:267
 #1: ffffffff8c96a3c8 (event_mutex){+.+.}-{3:3}, at: perf_uprobe_init+0x12d/0x1a0 kernel/trace/trace_event_perf.c:335
 #2: ffff88807d694c90 (&uprobe->register_rwsem){+.+.}-{3:3}, at: __uprobe_register+0x4fd/0x860 kernel/events/uprobes.c:1178

stack backtrace:
CPU: 1 PID: 15152 Comm: syz-executor.5 Not tainted 5.15.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1dc/0x2d8 lib/dump_stack.c:106
 check_noncircular+0x2f9/0x3b0 kernel/locking/lockdep.c:2131
 check_prev_add kernel/locking/lockdep.c:3051 [inline]
 check_prevs_add kernel/locking/lockdep.c:3174 [inline]
 validate_chain+0x1dfb/0x8240 kernel/locking/lockdep.c:3789
 __lock_acquire+0x1382/0x2b00 kernel/locking/lockdep.c:5015
 lock_acquire+0x19f/0x4d0 kernel/locking/lockdep.c:5625
 percpu_down_write+0x52/0x2f0 kernel/locking/percpu-rwsem.c:217
 register_for_each_vma+0x32/0xc50 kernel/events/uprobes.c:1041
 __uprobe_register+0x5d4/0x860 kernel/events/uprobes.c:1182
 trace_uprobe_enable kernel/trace/trace_uprobe.c:1065 [inline]
 probe_event_enable+0x399/0xbd0 kernel/trace/trace_uprobe.c:1134
 perf_trace_event_reg kernel/trace/trace_event_perf.c:129 [inline]
 perf_trace_event_init+0x49b/0x950 kernel/trace/trace_event_perf.c:204
 perf_uprobe_init+0x138/0x1a0 kernel/trace/trace_event_perf.c:336
 perf_uprobe_event_init+0xfe/0x180 kernel/events/core.c:9886
 perf_try_init_event+0x13e/0x3d0 kernel/events/core.c:11193
 perf_init_event kernel/events/core.c:11257 [inline]
 perf_event_alloc+0x1155/0x2c10 kernel/events/core.c:11548
 __do_sys_perf_event_open kernel/events/core.c:12069 [inline]
 __se_sys_perf_event_open+0x7b2/0x4280 kernel/events/core.c:11961
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x44/0xd0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f7a6e6c4709
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f7a6bbf9188 EFLAGS: 00000246 ORIG_RAX: 000000000000012a
RAX: ffffffffffffffda RBX: 00007f7a6e7c90e0 RCX: 00007f7a6e6c4709
RDX: 0000000000000000 RSI: ffffffffffffffff RDI: 0000000020000180
RBP: 00007f7a6e71ecb4 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffffffffffff R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffe2403e64f R14: 00007f7a6bbf9300 R15: 0000000000022000


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
