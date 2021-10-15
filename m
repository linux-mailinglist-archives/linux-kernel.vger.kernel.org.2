Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB4042F8B6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 18:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241644AbhJOQxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 12:53:38 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:41491 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241603AbhJOQxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 12:53:37 -0400
Received: by mail-il1-f199.google.com with SMTP id c4-20020a92b744000000b002592dabe954so4608379ilm.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 09:51:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=WT9Gmvy7G9VMulxfK+cY6LBRRIqgmpPJA6C4iC+HmLg=;
        b=LoIOMZwTyvWU29UIJHHftJj3htrJ54uHipm7UFNAst5nsPHvxHkLZ+CXdeqAy7tAox
         PkKJMQHC9X/8yYZEXwfjbZfFtRXxu1onVgXKuhYXPU616SLnXv8OtbbWW4yo5td956ms
         foW3n7tbMGWQBdc/MW/uhKN0hAlCKNMv9Fpth1okrMSvC439ShW0rMfiHqKvNGRC8OkG
         cif7237anvysAHliC6G+XVqBesSlR5cvTNtrIxdfphLMdfB0N2WNo7ijjQ6Q7TlSJEYF
         i17jn7EIk0zCmv0gfVGrZ+bV5lYXmKWP8/MhYFLahe/63h9ymdHRkuEj0blK+XN+CtjT
         dGTg==
X-Gm-Message-State: AOAM533IRVHKG63YoZF0mt9IWleCOB+AqwqJDwXZtlxyCUIUEU8j0DVC
        k+Fl/a24jZhIK/7QGA09wQxckHLMIeHUsFn0DuYkOEWVC6Zl
X-Google-Smtp-Source: ABdhPJw9bHVCCLSXVZz5DKeabqmc+LGU19HJmAutHHPltcEYX2wbmy68by+HE4gvyq/YVrC2rZKe7DfQqXpBOLHnFDAHF2ozS2xf
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1542:: with SMTP id h2mr4715473iow.198.1634316690858;
 Fri, 15 Oct 2021 09:51:30 -0700 (PDT)
Date:   Fri, 15 Oct 2021 09:51:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cf252605ce67014a@google.com>
Subject: [syzbot] possible deadlock in wake_up_all_idle_cpus
From:   syzbot <syzbot+d5b23b18d2f4feae8a67@syzkaller.appspotmail.com>
To:     bigeasy@linutronix.de, jgross@suse.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org, namit@vmware.com,
        peterz@infradead.org, rdunlap@infradead.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    8006b911c90a Add linux-next specific files for 20211013
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11e63434b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c7fd0a6a46d0131f
dashboard link: https://syzkaller.appspot.com/bug?extid=d5b23b18d2f4feae8a67
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d5b23b18d2f4feae8a67@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
5.15.0-rc5-next-20211013-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor.0/18539 is trying to acquire lock:
ffffffff8ba2e370 (cpu_hotplug_lock){++++}-{0:0}, at: wake_up_all_idle_cpus+0x13/0x80 kernel/smp.c:1173

but task is already holding lock:
ffff8880888aea28 (&mm->mmap_lock#2){++++}-{3:3}, at: mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
ffff8880888aea28 (&mm->mmap_lock#2){++++}-{3:3}, at: vm_mmap_pgoff+0x15c/0x290 mm/util.c:517

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&mm->mmap_lock#2){++++}-{3:3}:
       __might_fault mm/memory.c:5244 [inline]
       __might_fault+0x104/0x170 mm/memory.c:5229
       _copy_from_user+0x27/0x180 lib/usercopy.c:13
       copy_from_user include/linux/uaccess.h:192 [inline]
       perf_event_query_prog_array+0xfa/0x3d0 kernel/trace/bpf_trace.c:1890
       _perf_ioctl+0x119/0x1f00 kernel/events/core.c:5694
       perf_ioctl+0x76/0xb0 kernel/events/core.c:5730
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:874 [inline]
       __se_sys_ioctl fs/ioctl.c:860 [inline]
       __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #2 (&cpuctx_mutex){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:599 [inline]
       __mutex_lock+0x12f/0x12f0 kernel/locking/mutex.c:732
       perf_event_init_cpu+0x172/0x3e0 kernel/events/core.c:13295
       perf_event_init+0x39d/0x408 kernel/events/core.c:13342
       start_kernel+0x2bb/0x49b init/main.c:1057
       secondary_startup_64_no_verify+0xb0/0xbb

-> #1 (pmus_lock){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:599 [inline]
       __mutex_lock+0x12f/0x12f0 kernel/locking/mutex.c:732
       perf_event_init_cpu+0xc4/0x3e0 kernel/events/core.c:13289
       cpuhp_invoke_callback+0x3b5/0x9a0 kernel/cpu.c:190
       cpuhp_invoke_callback_range kernel/cpu.c:665 [inline]
       cpuhp_up_callbacks kernel/cpu.c:693 [inline]
       _cpu_up+0x3b0/0x790 kernel/cpu.c:1368
       cpu_up kernel/cpu.c:1404 [inline]
       cpu_up+0xfe/0x1a0 kernel/cpu.c:1376
       bringup_nonboot_cpus+0xfe/0x130 kernel/cpu.c:1470
       smp_init+0x2e/0x145 kernel/smp.c:1092
       kernel_init_freeable+0x477/0x73a init/main.c:1612
       kernel_init+0x1a/0x1d0 init/main.c:1509
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

-> #0 (cpu_hotplug_lock){++++}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3063 [inline]
       check_prevs_add kernel/locking/lockdep.c:3186 [inline]
       validate_chain kernel/locking/lockdep.c:3801 [inline]
       __lock_acquire+0x2a07/0x54a0 kernel/locking/lockdep.c:5027
       lock_acquire kernel/locking/lockdep.c:5637 [inline]
       lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       cpus_read_lock+0x3e/0x140 kernel/cpu.c:308
       wake_up_all_idle_cpus+0x13/0x80 kernel/smp.c:1173
       cpu_latency_qos_apply kernel/power/qos.c:249 [inline]
       cpu_latency_qos_add_request+0x10d/0x370 kernel/power/qos.c:277
       snd_pcm_hw_params+0x1399/0x1990 sound/core/pcm_native.c:787
       snd_pcm_kernel_ioctl+0x164/0x310 sound/core/pcm_native.c:3363
       snd_pcm_oss_change_params_locked+0x1936/0x3a60 sound/core/oss/pcm_oss.c:947
       snd_pcm_oss_change_params sound/core/oss/pcm_oss.c:1091 [inline]
       snd_pcm_oss_mmap+0x442/0x550 sound/core/oss/pcm_oss.c:2910
       call_mmap include/linux/fs.h:2164 [inline]
       mmap_region+0xd8c/0x1650 mm/mmap.c:1787
       do_mmap+0x869/0xfb0 mm/mmap.c:1575
       vm_mmap_pgoff+0x1b7/0x290 mm/util.c:519
       ksys_mmap_pgoff+0x49f/0x620 mm/mmap.c:1624
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

other info that might help us debug this:

Chain exists of:
  cpu_hotplug_lock --> &cpuctx_mutex --> &mm->mmap_lock#2

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&mm->mmap_lock#2);
                               lock(&cpuctx_mutex);
                               lock(&mm->mmap_lock#2);
  lock(cpu_hotplug_lock);

 *** DEADLOCK ***

2 locks held by syz-executor.0/18539:
 #0: ffff8880888aea28 (&mm->mmap_lock#2){++++}-{3:3}, at: mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #0: ffff8880888aea28 (&mm->mmap_lock#2){++++}-{3:3}, at: vm_mmap_pgoff+0x15c/0x290 mm/util.c:517
 #1: ffff888018e76440 (&runtime->oss.params_lock){+.+.}-{3:3}, at: snd_pcm_oss_change_params sound/core/oss/pcm_oss.c:1086 [inline]
 #1: ffff888018e76440 (&runtime->oss.params_lock){+.+.}-{3:3}, at: snd_pcm_oss_mmap+0x424/0x550 sound/core/oss/pcm_oss.c:2910

stack backtrace:
CPU: 0 PID: 18539 Comm: syz-executor.0 Not tainted 5.15.0-rc5-next-20211013-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2143
 check_prev_add kernel/locking/lockdep.c:3063 [inline]
 check_prevs_add kernel/locking/lockdep.c:3186 [inline]
 validate_chain kernel/locking/lockdep.c:3801 [inline]
 __lock_acquire+0x2a07/0x54a0 kernel/locking/lockdep.c:5027
 lock_acquire kernel/locking/lockdep.c:5637 [inline]
 lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602
 percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
 cpus_read_lock+0x3e/0x140 kernel/cpu.c:308
 wake_up_all_idle_cpus+0x13/0x80 kernel/smp.c:1173
 cpu_latency_qos_apply kernel/power/qos.c:249 [inline]
 cpu_latency_qos_add_request+0x10d/0x370 kernel/power/qos.c:277
 snd_pcm_hw_params+0x1399/0x1990 sound/core/pcm_native.c:787
 snd_pcm_kernel_ioctl+0x164/0x310 sound/core/pcm_native.c:3363
 snd_pcm_oss_change_params_locked+0x1936/0x3a60 sound/core/oss/pcm_oss.c:947
 snd_pcm_oss_change_params sound/core/oss/pcm_oss.c:1091 [inline]
 snd_pcm_oss_mmap+0x442/0x550 sound/core/oss/pcm_oss.c:2910
 call_mmap include/linux/fs.h:2164 [inline]
 mmap_region+0xd8c/0x1650 mm/mmap.c:1787
 do_mmap+0x869/0xfb0 mm/mmap.c:1575
 vm_mmap_pgoff+0x1b7/0x290 mm/util.c:519
 ksys_mmap_pgoff+0x49f/0x620 mm/mmap.c:1624
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fcef50b8a39
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fcef262e188 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 00007fcef51bbf60 RCX: 00007fcef50b8a39
RDX: 0000000001800003 RSI: 0000000000800000 RDI: 0000000020000000
RBP: 00007fcef5112c5f R08: 0000000000000004 R09: 0000000000000000
R10: 0000000000000012 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffda8d3cfcf R14: 00007fcef262e300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
