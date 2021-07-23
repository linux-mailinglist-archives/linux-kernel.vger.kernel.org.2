Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E00F3D3C46
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 17:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235526AbhGWOfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 10:35:51 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:52841 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235438AbhGWOfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 10:35:47 -0400
Received: by mail-io1-f71.google.com with SMTP id n22-20020a6bf6160000b0290520c8d13420so1849855ioh.19
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 08:16:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Km+DYDs17/9wFjoELvIfqqJkBddDn8eXSDbKAdEDiK8=;
        b=pad7AO0fI1yLyyraCssYnKgVmEyLwRcbY35UNhp7vZC/94NuAnB5USpvZEbpd46cbD
         tbsWPF/hquXQLG1imK4EMjhbmnP8dZqmxIzHajSFhMXZDBOKSjQuSU5VOAVcRICBaKnv
         x1Ru0tzsEzl1uJzEK2GOLKKCL+8Nz8d8+blWXnucda84eFPNl6nOQeZ9QsU0JhvWNd6S
         BhLorObmMFmR9tWF0hXzlsCw0vffvqfn84M0FPJzZtcbVTrxgOoForWxz4IIEOzqP+V6
         zbLFRrK6cm98ZS2W/DPzLvhvtakiGf/gEX3PWnzkDlVrXoW56drZMdFj4ZTOGVNFhVFP
         EljA==
X-Gm-Message-State: AOAM533ywGoF7Jz5PQNL8NZYY0PpE8l24HzrlRN5cB2Fgt78Owch9vvM
        itsNBTon/J+dTdLKs7VwhzR20Il/4SHjcOVmeWMzVX1hnvRE
X-Google-Smtp-Source: ABdhPJyxjeIvBtxjTFQKXZF3xzQur+uigWE35IKnKaQmobk5Uo3SUZ06Z30VQEHyEyqeYM4Rfm1pia8cAjVnTYlp2m7mkeRJTzxT
MIME-Version: 1.0
X-Received: by 2002:a05:6638:130d:: with SMTP id r13mr4538053jad.103.1627053380806;
 Fri, 23 Jul 2021 08:16:20 -0700 (PDT)
Date:   Fri, 23 Jul 2021 08:16:20 -0700
In-Reply-To: <000000000000217d7005c0f5c6b1@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cb2cbe05c7cbe222@google.com>
Subject: Re: [syzbot] possible deadlock in vm_mmap_pgoff
From:   syzbot <syzbot+f619f7c0a2a5f87694e6@syzkaller.appspotmail.com>
To:     hdanton@sina.com, jolsa@redhat.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, oleg@redhat.com, peterz@infradead.org,
        rostedt@goodmis.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    9bead1b58c4c Merge tag 'array-bounds-fixes-5.14-rc3' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=155a1f5c300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5dc0e3202ae2f574
dashboard link: https://syzkaller.appspot.com/bug?extid=f619f7c0a2a5f87694e6
compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14e2e196300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11cc4846300000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f619f7c0a2a5f87694e6@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
5.14.0-rc2-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor238/8449 is trying to acquire lock:
ffffffff8c7658e8 (event_mutex){+.+.}-{3:3}, at: perf_trace_destroy+0x27/0xb0 kernel/trace/trace_event_perf.c:241

but task is already holding lock:
ffff888033788f28 (&mm->mmap_lock#2){++++}-{3:3}, at: mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
ffff888033788f28 (&mm->mmap_lock#2){++++}-{3:3}, at: vm_mmap_pgoff+0x14d/0x2b0 mm/util.c:517

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&mm->mmap_lock#2){++++}-{3:3}:
       lock_acquire+0x182/0x4a0 kernel/locking/lockdep.c:5625
       down_write_killable+0xaa/0x1b0 kernel/locking/rwsem.c:1417
       mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
       dup_mmap+0xde/0xed0 kernel/fork.c:484
       dup_mm+0x8c/0x310 kernel/fork.c:1379
       copy_mm kernel/fork.c:1431 [inline]
       copy_process+0x22e8/0x5b00 kernel/fork.c:2119
       kernel_clone+0x21a/0x7d0 kernel/fork.c:2509
       __do_sys_clone kernel/fork.c:2626 [inline]
       __se_sys_clone kernel/fork.c:2610 [inline]
       __x64_sys_clone+0x236/0x2b0 kernel/fork.c:2610
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #2 (dup_mmap_sem){++++}-{0:0}:
       lock_acquire+0x182/0x4a0 kernel/locking/lockdep.c:5625
       percpu_down_write+0x52/0x2f0 kernel/locking/percpu-rwsem.c:217
       register_for_each_vma+0x32/0xc20 kernel/events/uprobes.c:1041
       __uprobe_register+0x5d4/0x860 kernel/events/uprobes.c:1182
       trace_uprobe_enable kernel/trace/trace_uprobe.c:1065 [inline]
       probe_event_enable+0x399/0xbd0 kernel/trace/trace_uprobe.c:1134
       perf_trace_event_reg kernel/trace/trace_event_perf.c:129 [inline]
       perf_trace_event_init+0x49b/0x950 kernel/trace/trace_event_perf.c:204
       perf_uprobe_init+0x138/0x1a0 kernel/trace/trace_event_perf.c:336
       perf_uprobe_event_init+0xfe/0x180 kernel/events/core.c:9875
       perf_try_init_event+0x13e/0x3d0 kernel/events/core.c:11192
       perf_init_event kernel/events/core.c:11256 [inline]
       perf_event_alloc+0x1155/0x2c10 kernel/events/core.c:11547
       __do_sys_perf_event_open kernel/events/core.c:12037 [inline]
       __se_sys_perf_event_open+0x7a6/0x4020 kernel/events/core.c:11929
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #1 (&uprobe->register_rwsem){+.+.}-{3:3}:
       lock_acquire+0x182/0x4a0 kernel/locking/lockdep.c:5625
       down_write+0x97/0x170 kernel/locking/rwsem.c:1406
       __uprobe_register+0x4fd/0x860 kernel/events/uprobes.c:1178
       trace_uprobe_enable kernel/trace/trace_uprobe.c:1065 [inline]
       probe_event_enable+0x399/0xbd0 kernel/trace/trace_uprobe.c:1134
       perf_trace_event_reg kernel/trace/trace_event_perf.c:129 [inline]
       perf_trace_event_init+0x49b/0x950 kernel/trace/trace_event_perf.c:204
       perf_uprobe_init+0x138/0x1a0 kernel/trace/trace_event_perf.c:336
       perf_uprobe_event_init+0xfe/0x180 kernel/events/core.c:9875
       perf_try_init_event+0x13e/0x3d0 kernel/events/core.c:11192
       perf_init_event kernel/events/core.c:11256 [inline]
       perf_event_alloc+0x1155/0x2c10 kernel/events/core.c:11547
       __do_sys_perf_event_open kernel/events/core.c:12037 [inline]
       __se_sys_perf_event_open+0x7a6/0x4020 kernel/events/core.c:11929
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #0 (event_mutex){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3051 [inline]
       check_prevs_add+0x4f9/0x5b30 kernel/locking/lockdep.c:3174
       validate_chain kernel/locking/lockdep.c:3789 [inline]
       __lock_acquire+0x4476/0x6100 kernel/locking/lockdep.c:5015
       lock_acquire+0x182/0x4a0 kernel/locking/lockdep.c:5625
       __mutex_lock_common+0x1ad/0x3770 kernel/locking/mutex.c:959
       __mutex_lock kernel/locking/mutex.c:1104 [inline]
       mutex_lock_nested+0x1a/0x20 kernel/locking/mutex.c:1119
       perf_trace_destroy+0x27/0xb0 kernel/trace/trace_event_perf.c:241
       _free_event+0xd4d/0x12f0 kernel/events/core.c:4959
       put_event kernel/events/core.c:5053 [inline]
       perf_mmap_close+0x8ed/0xdf0 kernel/events/core.c:6098
       remove_vma mm/mmap.c:186 [inline]
       remove_vma_list mm/mmap.c:2656 [inline]
       __do_munmap+0x1b95/0x2050 mm/mmap.c:2914
       do_munmap mm/mmap.c:2922 [inline]
       munmap_vma_range mm/mmap.c:604 [inline]
       mmap_region+0x90c/0x1df0 mm/mmap.c:1753
       do_mmap+0x89e/0x10c0 mm/mmap.c:1584
       vm_mmap_pgoff+0x19e/0x2b0 mm/util.c:519
       ksys_mmap_pgoff+0x504/0x7b0 mm/mmap.c:1635
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
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

1 lock held by syz-executor238/8449:
 #0: ffff888033788f28 (&mm->mmap_lock#2){++++}-{3:3}, at: mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #0: ffff888033788f28 (&mm->mmap_lock#2){++++}-{3:3}, at: vm_mmap_pgoff+0x14d/0x2b0 mm/util.c:517

stack backtrace:
CPU: 1 PID: 8449 Comm: syz-executor238 Not tainted 5.14.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1ae/0x29f lib/dump_stack.c:105
 print_circular_bug+0xb17/0xdc0 kernel/locking/lockdep.c:2009
 check_noncircular+0x2cc/0x390 kernel/locking/lockdep.c:2131
 check_prev_add kernel/locking/lockdep.c:3051 [inline]
 check_prevs_add+0x4f9/0x5b30 kernel/locking/lockdep.c:3174
 validate_chain kernel/locking/lockdep.c:3789 [inline]
 __lock_acquire+0x4476/0x6100 kernel/locking/lockdep.c:5015
 lock_acquire+0x182/0x4a0 kernel/locking/lockdep.c:5625
 __mutex_lock_common+0x1ad/0x3770 kernel/locking/mutex.c:959
 __mutex_lock kernel/locking/mutex.c:1104 [inline]
 mutex_lock_nested+0x1a/0x20 kernel/locking/mutex.c:1119
 perf_trace_destroy+0x27/0xb0 kernel/trace/trace_event_perf.c:241
 _free_event+0xd4d/0x12f0 kernel/events/core.c:4959
 put_event kernel/events/core.c:5053 [inline]
 perf_mmap_close+0x8ed/0xdf0 kernel/events/core.c:6098
 remove_vma mm/mmap.c:186 [inline]
 remove_vma_list mm/mmap.c:2656 [inline]
 __do_munmap+0x1b95/0x2050 mm/mmap.c:2914
 do_munmap mm/mmap.c:2922 [inline]
 munmap_vma_range mm/mmap.c:604 [inline]
 mmap_region+0x90c/0x1df0 mm/mmap.c:1753
 do_mmap+0x89e/0x10c0 mm/mmap.c:1584
 vm_mmap_pgoff+0x19e/0x2b0 mm/util.c:519
 ksys_mmap_pgoff+0x504/0x7b0 mm/mmap.c:1635
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x44e009
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 91 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fefce402308 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 00000000004cc4e8 RCX: 000000000044e009
RDX: 0000000000000000 RSI: 0000000000003000 RDI: 0000000020ffc000
RBP: 00000000004cc4e0 R08: 00

