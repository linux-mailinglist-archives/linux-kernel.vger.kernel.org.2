Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D46D543040E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 20:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244503AbhJPSJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 14:09:36 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:37729 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234167AbhJPSJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 14:09:34 -0400
Received: by mail-io1-f71.google.com with SMTP id w8-20020a0566022c0800b005dc06acea8dso7237702iov.4
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 11:07:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=PPS8mlXHBiUlm1vxGin45otZj0h7rSqeYQNJOrZpzVU=;
        b=WscR60PPp4wwBwfeYjLw7NHSb1JpBsG3WW4K7rVpQoWW+E19lQU/2qou+mLdSBzReV
         J2kMqIBSwjfn7sGX3M9fZOdVDmBUGp58wcLngL1qQdivB2QsDsAltoEBp5hI8iisJ+RE
         j061xECmNp5ZuQJQqfPuNMlxxFYnfRoFH7Fsq0Is70BvTHJqfOwPvMyh9n0N33lkhG4u
         oKAdHSEzTUB9HKywsmBFqlQ5/zYdIH8rIRwmvol7g2iE4y+DwPICZ5Vglqv9zO6NzDJO
         tBygZ3ZFIH6rExX3QTzRmJWbBB1bhIEh+a6yfqOnm+S+2/6MAruO/fkyu5F/dUrf88XV
         N08A==
X-Gm-Message-State: AOAM532ZiLeBcDV6mjvan8bV+pm2dFC3+S2lMOpWyuwE0mVRHUp+esTN
        1LwwNh+fL74YR3ulIcixAiGyD2p99VbcvrNxnAzExd40RJ62
X-Google-Smtp-Source: ABdhPJwnuS+vEpAo/NS8ZDMO5Hmac9HEd0zVPnbJxfa1J58Raz7HBfSAsrPCFBqhnBIx/8aLWjZLnnlfDypvqWq3AyDSmNsgV0jy
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2b1:: with SMTP id d17mr12522649jaq.89.1634407646329;
 Sat, 16 Oct 2021 11:07:26 -0700 (PDT)
Date:   Sat, 16 Oct 2021 11:07:26 -0700
In-Reply-To: <000000000000cf252605ce67014a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002d7f1505ce7c2f01@google.com>
Subject: Re: [syzbot] possible deadlock in wake_up_all_idle_cpus
From:   syzbot <syzbot+d5b23b18d2f4feae8a67@syzkaller.appspotmail.com>
To:     bigeasy@linutronix.de, jgross@suse.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org, namit@vmware.com,
        peterz@infradead.org, rdunlap@infradead.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    7c832d2f9b95 Add linux-next specific files for 20211015
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11aa8c78b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f6ac42766a768877
dashboard link: https://syzkaller.appspot.com/bug?extid=d5b23b18d2f4feae8a67
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14e920fcb00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13b83d80b00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d5b23b18d2f4feae8a67@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
5.15.0-rc5-next-20211015-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor097/6554 is trying to acquire lock:
ffffffff8ba2e370 (cpu_hotplug_lock){++++}-{0:0}, at: wake_up_all_idle_cpus+0x13/0x80 kernel/smp.c:1173

but task is already holding lock:
ffff888079003228 (&mm->mmap_lock#2){++++}-{3:3}, at: mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
ffff888079003228 (&mm->mmap_lock#2){++++}-{3:3}, at: vm_mmap_pgoff+0x15c/0x290 mm/util.c:517

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&mm->mmap_lock#2){++++}-{3:3}:
       __might_fault mm/memory.c:5244 [inline]
       __might_fault+0x104/0x170 mm/memory.c:5229
       _copy_from_user+0x27/0x180 lib/usercopy.c:13
       copy_from_user include/linux/uaccess.h:192 [inline]
       memdup_user+0x69/0xc0 mm/util.c:177
       strndup_user+0x70/0xe0 mm/util.c:232
       perf_event_set_filter kernel/events/core.c:10512 [inline]
       _perf_ioctl+0x1a2/0x1f00 kernel/events/core.c:5659
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
       start_kernel+0x2bb/0x49b init/main.c:1059
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
       kernel_init_freeable+0x477/0x73a init/main.c:1614
       kernel_init+0x1a/0x1d0 init/main.c:1511
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
       cpu_latency_qos_remove_request.part.0+0xc4/0x2f0 kernel/power/qos.c:328
       cpu_latency_qos_remove_request+0x65/0x80 kernel/power/qos.c:330
       snd_pcm_hw_params+0x1481/0x1990 sound/core/pcm_native.c:784
       snd_pcm_kernel_ioctl+0x164/0x310 sound/core/pcm_native.c:3355
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

2 locks held by syz-executor097/6554:
 #0: ffff888079003228 (&mm->mmap_lock#2){++++}-{3:3}, at: mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #0: ffff888079003228 (&mm->mmap_lock#2){++++}-{3:3}, at: vm_mmap_pgoff+0x15c/0x290 mm/util.c:517
 #1: ffff88802317a440 (&runtime->oss.params_lock){+.+.}-{3:3}, at: snd_pcm_oss_change_params sound/core/oss/pcm_oss.c:1086 [inline]
 #1: ffff88802317a440 (&runtime->oss.params_lock){+.+.}-{3:3}, at: snd_pcm_oss_mmap+0x424/0x550 sound/core/oss/pcm_oss.c:2910

stack backtrace:
CPU: 0 PID: 6554 Comm: syz-executor097 Not tainted 5.15.0-rc5-next-20211015-syzkaller #0
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
 cpu_latency_qos_remove_request.part.0+0xc4/0x2f0 kernel/power/qos.c:328
 cpu_latency_qos_remove_request+0x65/0x80 kernel/power/qos.c:330
 snd_pcm_hw_params+0x1481/0x1990 sound/core/pcm_native.c:784
 snd_pcm_kernel_ioctl+0x164/0x310 sound/core/pcm_native.c:3355
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
RIP: 0033:0x7fc0cb6221c9
Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffcd48ab28 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fc0cb6221c9
RDX: 0000000001800003 RSI: 0000000000800000 RDI: 0000000020000000
RBP: 00007fc0cb5e61b0 R08: 0000000000000004 R09: 0000000000000000

