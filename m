Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7A923D4DAE
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jul 2021 15:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbhGYMih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jul 2021 08:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbhGYMig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jul 2021 08:38:36 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32809C061757
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jul 2021 06:19:07 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id k1so8371709plt.12
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jul 2021 06:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=EGXhb3yHhv25z+ipOC8I2tSDJ1kEN+ooXRbqLaAPXzk=;
        b=AkKgTargisVfOqw90lYLsJQS1Xn3JaMvd1mrcp06VtyNNlLl0Dy/BVGRmWeZ8fW5cJ
         Gq4+AH1079yqHSV2gPYLbD9rRGiiNaxlOmsFjP274nvjxa82h81UB9rLtVKnSodor8Vt
         ABH6oC3O8OtF94dkI0Fd+QHfXuguzt+xAGuz+fX7gIrdmYFciBaxVMPCER1cAawqAYWz
         GJRD38m8P3BbaguZI+NueqAw+bP/drsP/Nvz1NTJR8U02sUwvvDIK8dN975Bg/jpYGWa
         lLl59v998G2IifSi5iqeTo7++3nbdcyLus1SnP+3fhULg+fqZOsgqAg7NqrBFgRlzqY0
         UiDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EGXhb3yHhv25z+ipOC8I2tSDJ1kEN+ooXRbqLaAPXzk=;
        b=V2q1aUpPQVcT4Rgm1oLsoawTZNZy0Ulso/1AJ3HHxS9NHQKGYHB0p+s+67qLqYIKm0
         C/oHbC6j069fjD/4ipzbkl0ekEpq0BIM0eR7y06B5KtMB1Z87Q+1mz70p9skCAwU8+0z
         Pz3ubfOKT33NF9hk+gFd5gcPr8iZAW2UlKQ+bO34jbndH+kuPqQcninJkANc6DE7FBY9
         0jTpV0GTfnNfiUAM7AsvMdeTCLP28U94EZjJ4z2nNJbNMQw1HvYQuPxx33wC86qmNlwh
         pWzbInjIbhEhV1oe/sWXp866/6hITShDtRL4whBxtXp00WjtkPITXvj/xuE92PjUsqyV
         9B1w==
X-Gm-Message-State: AOAM5323qR5JYnU/A2nfNfKfiWcZIgsoEo+AlUBMpDxfadfqN8mmEsca
        yo3N/gPRybm9c7hPlh9nT/I=
X-Google-Smtp-Source: ABdhPJydLj2n3MEHxhWdtj6kYHTxSU2e4EVpkop94/dBz4q2C1HrnNnVbGDp8PYq/9PXg+3U5JOI1A==
X-Received: by 2002:a17:902:b40d:b029:12b:9753:f075 with SMTP id x13-20020a170902b40db029012b9753f075mr10630937plr.40.1627219146672;
        Sun, 25 Jul 2021 06:19:06 -0700 (PDT)
Received: from [192.168.1.237] ([118.200.190.93])
        by smtp.gmail.com with ESMTPSA id 85sm40217753pfz.76.2021.07.25.06.19.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jul 2021 06:19:06 -0700 (PDT)
Subject: Re: [syzbot] possible deadlock in snd_timer_interrupt
To:     syzbot <syzbot+17c16b868e6af41acdd4@syzkaller.appspotmail.com>,
        allen.lkml@gmail.com, alsa-devel@alsa-project.org,
        boqun.feng@gmail.com, broonie@kernel.org, joe@perches.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com, perex@perex.cz,
        peterz@infradead.org, pierre-louis.bossart@linux.intel.com,
        syzkaller-bugs@googlegroups.com, tiwai@suse.com, will@kernel.org
References: <0000000000004c664005c7f1ede0@google.com>
From:   Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
Message-ID: <7f2074af-4540-1b01-9dc0-9b9d24872d2c@gmail.com>
Date:   Sun, 25 Jul 2021 21:19:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <0000000000004c664005c7f1ede0@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/7/21 8:39 pm, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    f0fddcec6b62 Merge tag 'for-5.14-rc2-tag' of git://git.ker..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=13cbb70e300000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5dc0e3202ae2f574
> dashboard link: https://syzkaller.appspot.com/bug?extid=17c16b868e6af41acdd4
> compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.1
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17667ecc300000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=179e0582300000
> 
> The issue was bisected to:
> 
> commit e918188611f073063415f40fae568fa4d86d9044
> Author: Boqun Feng <boqun.feng@gmail.com>
> Date:   Fri Aug 7 07:42:20 2020 +0000
> 
>      locking: More accurate annotations for read_lock()
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=109610b2300000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=129610b2300000
> console output: https://syzkaller.appspot.com/x/log.txt?x=149610b2300000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+17c16b868e6af41acdd4@syzkaller.appspotmail.com
> Fixes: e918188611f0 ("locking: More accurate annotations for read_lock()")
> 
> ========================================================
> WARNING: possible irq lock inversion dependency detected
> 5.14.0-rc2-syzkaller #0 Not tainted
> --------------------------------------------------------
> syz-executor065/8431 just changed the state of lock:
> ffff888027e94148 (&timer->lock){..-.}-{2:2}, at: snd_timer_interrupt+0x210/0x1410 sound/core/timer.c:857
> but this lock took another, SOFTIRQ-READ-unsafe lock in the past:
>   (&f->f_owner.lock){.+.+}-{2:2}
> 
> 
> and interrupts could create inverse lock ordering between them.
> 
> 
> other info that might help us debug this:
> Chain exists of:
>    &timer->lock --> &new->fa_lock --> &f->f_owner.lock
> 
>   Possible interrupt unsafe locking scenario:
> 
>         CPU0                    CPU1
>         ----                    ----
>    lock(&f->f_owner.lock);
>                                 local_irq_disable();
>                                 lock(&timer->lock);
>                                 lock(&new->fa_lock);
>    <Interrupt>
>      lock(&timer->lock);
> 
>   *** DEADLOCK ***
> 
> 4 locks held by syz-executor065/8431:
>   #0: ffff888029390460 (sb_writers#5){.+.+}-{0:0}, at: mnt_want_write+0x3b/0x80 fs/namespace.c:375
>   #1: ffff888039f60e80 (&type->i_mutex_dir_key#4/1){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:809 [inline]
>   #1: ffff888039f60e80 (&type->i_mutex_dir_key#4/1){+.+.}-{3:3}, at: filename_create+0x19f/0x700 fs/namei.c:3602
>   #2: ffffffff8c7177c0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0x5/0x30 include/linux/rcupdate.h:266
>   #3: ffffc90000dc0be0 ((&priv->tlist)){+.-.}-{0:0}, at: lockdep_copy_map include/linux/lockdep.h:45 [inline]
>   #3: ffffc90000dc0be0 ((&priv->tlist)){+.-.}-{0:0}, at: call_timer_fn+0xbd/0x210 kernel/time/timer.c:1407
> 
> the shortest dependencies between 2nd lock and 1st lock:
>    -> (&f->f_owner.lock){.+.+}-{2:2} {
>       HARDIRQ-ON-R at:
>                          lock_acquire+0x182/0x4a0 kernel/locking/lockdep.c:5625
>                          __raw_read_lock include/linux/rwlock_api_smp.h:149 [inline]
>                          _raw_read_lock+0x32/0x40 kernel/locking/spinlock.c:223
>                          f_getown_ex fs/fcntl.c:211 [inline]
>                          do_fcntl+0x150/0x1510 fs/fcntl.c:395
>                          __do_sys_fcntl fs/fcntl.c:471 [inline]
>                          __se_sys_fcntl+0xd8/0x1b0 fs/fcntl.c:456
>                          do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>                          do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
>                          entry_SYSCALL_64_after_hwframe+0x44/0xae
>       SOFTIRQ-ON-R at:
>                          lock_acquire+0x182/0x4a0 kernel/locking/lockdep.c:5625
>                          __raw_read_lock include/linux/rwlock_api_smp.h:149 [inline]
>                          _raw_read_lock+0x32/0x40 kernel/locking/spinlock.c:223
>                          f_getown_ex fs/fcntl.c:211 [inline]
>                          do_fcntl+0x150/0x1510 fs/fcntl.c:395
>                          __do_sys_fcntl fs/fcntl.c:471 [inline]
>                          __se_sys_fcntl+0xd8/0x1b0 fs/fcntl.c:456
>                          do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>                          do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
>                          entry_SYSCALL_64_after_hwframe+0x44/0xae
>       INITIAL READ USE at:
>                              lock_acquire+0x182/0x4a0 kernel/locking/lockdep.c:5625
>                              __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:159 [inline]
>                              _raw_read_lock_irqsave+0xbb/0x100 kernel/locking/spinlock.c:231
>                              send_sigio+0x2f/0x300 fs/fcntl.c:795
>                              kill_fasync_rcu fs/fcntl.c:1019 [inline]
>                              kill_fasync+0x1e3/0x430 fs/fcntl.c:1033
>                              snd_timer_user_ccallback+0x3ee/0x710 sound/core/timer.c:1387
>                              snd_timer_notify1+0x19e/0x340 sound/core/timer.c:516
>                              snd_timer_start1+0x53d/0x640 sound/core/timer.c:578
>                              snd_timer_start sound/core/timer.c:697 [inline]
>                              snd_timer_user_start sound/core/timer.c:1985 [inline]
>                              __snd_timer_user_ioctl+0xe18/0x5ed0 sound/core/timer.c:2108
>                              snd_timer_user_ioctl+0x5d/0x80 sound/core/timer.c:2129
>                              vfs_ioctl fs/ioctl.c:51 [inline]
>                              __do_sys_ioctl fs/ioctl.c:1069 [inline]
>                              __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:1055
>                              do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>                              do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
>                              entry_SYSCALL_64_after_hwframe+0x44/0xae
>     }
>     ... key      at: [<ffffffff907d04a0>] __alloc_file.__key+0x0/0x10
>     ... acquired at:
>     lock_acquire+0x182/0x4a0 kernel/locking/lockdep.c:5625
>     __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:159 [inline]
>     _raw_read_lock_irqsave+0xbb/0x100 kernel/locking/spinlock.c:231
>     send_sigio+0x2f/0x300 fs/fcntl.c:795
>     kill_fasync_rcu fs/fcntl.c:1019 [inline]
>     kill_fasync+0x1e3/0x430 fs/fcntl.c:1033
>     snd_timer_user_ccallback+0x3ee/0x710 sound/core/timer.c:1387
>     snd_timer_notify1+0x19e/0x340 sound/core/timer.c:516
>     snd_timer_start1+0x53d/0x640 sound/core/timer.c:578
>     snd_timer_start sound/core/timer.c:697 [inline]
>     snd_timer_user_start sound/core/timer.c:1985 [inline]
>     __snd_timer_user_ioctl+0xe18/0x5ed0 sound/core/timer.c:2108
>     snd_timer_user_ioctl+0x5d/0x80 sound/core/timer.c:2129
>     vfs_ioctl fs/ioctl.c:51 [inline]
>     __do_sys_ioctl fs/ioctl.c:1069 [inline]
>     __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:1055
>     do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>     do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
>     entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
>   -> (&new->fa_lock){....}-{2:2} {
>      INITIAL USE at:
>                       lock_acquire+0x182/0x4a0 kernel/locking/lockdep.c:5625
>                       __raw_write_lock_irq include/linux/rwlock_api_smp.h:196 [inline]
>                       _raw_write_lock_irq+0xae/0xf0 kernel/locking/spinlock.c:311
>                       fasync_remove_entry+0xff/0x1d0 fs/fcntl.c:890
>                       __fput+0x65b/0x7b0 fs/file_table.c:277
>                       task_work_run+0x146/0x1c0 kernel/task_work.c:164
>                       exit_task_work include/linux/task_work.h:32 [inline]
>                       do_exit+0x72b/0x2510 kernel/exit.c:825
>                       do_group_exit+0x168/0x2d0 kernel/exit.c:922
>                       get_signal+0x16b0/0x2080 kernel/signal.c:2808
>                       arch_do_signal_or_restart+0x8e/0x6d0 arch/x86/kernel/signal.c:865
>                       handle_signal_work kernel/entry/common.c:148 [inline]
>                       exit_to_user_mode_loop kernel/entry/common.c:172 [inline]
>                       exit_to_user_mode_prepare+0x191/0x220 kernel/entry/common.c:209
>                       __syscall_exit_to_user_mode_work kernel/entry/common.c:291 [inline]
>                       syscall_exit_to_user_mode+0x26/0x60 kernel/entry/common.c:302
>                       do_syscall_64+0x4c/0xb0 arch/x86/entry/common.c:86
>                       entry_SYSCALL_64_after_hwframe+0x44/0xae
>      INITIAL READ USE at:
>                            lock_acquire+0x182/0x4a0 kernel/locking/lockdep.c:5625
>                            __raw_read_lock include/linux/rwlock_api_smp.h:149 [inline]
>                            _raw_read_lock+0x32/0x40 kernel/locking/spinlock.c:223
>                            kill_fasync_rcu fs/fcntl.c:1012 [inline]
>                            kill_fasync+0x13b/0x430 fs/fcntl.c:1033
>                            snd_timer_user_ccallback+0x3ee/0x710 sound/core/timer.c:1387
>                            snd_timer_notify1+0x19e/0x340 sound/core/timer.c:516
>                            snd_timer_start1+0x53d/0x640 sound/core/timer.c:578
>                            snd_timer_start sound/core/timer.c:697 [inline]
>                            snd_timer_user_start sound/core/timer.c:1985 [inline]
>                            __snd_timer_user_ioctl+0xe18/0x5ed0 sound/core/timer.c:2108
>                            snd_timer_user_ioctl+0x5d/0x80 sound/core/timer.c:2129
>                            vfs_ioctl fs/ioctl.c:51 [inline]
>                            __do_sys_ioctl fs/ioctl.c:1069 [inline]
>                            __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:1055
>                            do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>                            do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
>                            entry_SYSCALL_64_after_hwframe+0x44/0xae
>    }
>    ... key      at: [<ffffffff907d1360>] fasync_insert_entry.__key+0x0/0x40
>    ... acquired at:
>     lock_acquire+0x182/0x4a0 kernel/locking/lockdep.c:5625
>     __raw_read_lock include/linux/rwlock_api_smp.h:149 [inline]
>     _raw_read_lock+0x32/0x40 kernel/locking/spinlock.c:223
>     kill_fasync_rcu fs/fcntl.c:1012 [inline]
>     kill_fasync+0x13b/0x430 fs/fcntl.c:1033
>     snd_timer_user_ccallback+0x3ee/0x710 sound/core/timer.c:1387
>     snd_timer_notify1+0x19e/0x340 sound/core/timer.c:516
>     snd_timer_start1+0x53d/0x640 sound/core/timer.c:578
>     snd_timer_start sound/core/timer.c:697 [inline]
>     snd_timer_user_start sound/core/timer.c:1985 [inline]
>     __snd_timer_user_ioctl+0xe18/0x5ed0 sound/core/timer.c:2108
>     snd_timer_user_ioctl+0x5d/0x80 sound/core/timer.c:2129
>     vfs_ioctl fs/ioctl.c:51 [inline]
>     __do_sys_ioctl fs/ioctl.c:1069 [inline]
>     __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:1055
>     do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>     do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
>     entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> -> (&timer->lock){..-.}-{2:2} {
>     IN-SOFTIRQ-W at:
>                      lock_acquire+0x182/0x4a0 kernel/locking/lockdep.c:5625
>                      __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>                      _raw_spin_lock_irqsave+0xb3/0x100 kernel/locking/spinlock.c:159
>                      snd_timer_interrupt+0x210/0x1410 sound/core/timer.c:857
>                      call_timer_fn+0xf6/0x210 kernel/time/timer.c:1417
>                      expire_timers kernel/time/timer.c:1462 [inline]
>                      __run_timers+0x6ff/0x910 kernel/time/timer.c:1731
>                      run_timer_softirq+0x63/0xf0 kernel/time/timer.c:1744
>                      __do_softirq+0x372/0x783 kernel/softirq.c:558
>                      invoke_softirq kernel/softirq.c:432 [inline]
>                      __irq_exit_rcu+0x21b/0x260 kernel/softirq.c:636
>                      irq_exit_rcu+0x5/0x20 kernel/softirq.c:648
>                      sysvec_apic_timer_interrupt+0x91/0xb0 arch/x86/kernel/apic/apic.c:1100
>                      asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:638
>                      __preempt_count_add arch/x86/include/asm/preempt.h:80 [inline]
>                      rcu_is_watching+0xd/0xb0 kernel/rcu/tree.c:1159
>                      rcu_read_lock include/linux/rcupdate.h:688 [inline]
>                      get_cached_acl+0x103/0x540 fs/posix_acl.c:44
>                      get_acl+0x20/0x2e0 fs/posix_acl.c:108
>                      posix_acl_create+0x119/0x560 fs/posix_acl.c:616
>                      ext4_init_acl+0xa6/0x3d0 fs/ext4/acl.c:282
>                      __ext4_new_inode+0x44e7/0x5810 fs/ext4/ialloc.c:1316
>                      ext4_mkdir+0x3fa/0xc10 fs/ext4/namei.c:2921
>                      vfs_mkdir+0x451/0x630 fs/namei.c:3823
>                      do_mkdirat+0x267/0x3e0 fs/namei.c:3848
>                      do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>                      do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
>                      entry_SYSCALL_64_after_hwframe+0x44/0xae
>     INITIAL USE at:
>                     lock_acquire+0x182/0x4a0 kernel/locking/lockdep.c:5625
>                     __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>                     _raw_spin_lock_irqsave+0xb3/0x100 kernel/locking/spinlock.c:159
>                     snd_timer_resolution sound/core/timer.c:489 [inline]
>                     snd_timer_user_params sound/core/timer.c:1852 [inline]
>                     __snd_timer_user_ioctl+0x1df7/0x5ed0 sound/core/timer.c:2101
>                     snd_timer_user_ioctl+0x5d/0x80 sound/core/timer.c:2129
>                     vfs_ioctl fs/ioctl.c:51 [inline]
>                     __do_sys_ioctl fs/ioctl.c:1069 [inline]
>                     __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:1055
>                     do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>                     do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
>                     entry_SYSCALL_64_after_hwframe+0x44/0xae
>   }
>   ... key      at: [<ffffffff90b60220>] snd_timer_new.__key+0x0/0x40
>   ... acquired at:
>     mark_usage kernel/locking/lockdep.c:4488 [inline]
>     __lock_acquire+0xca1/0x6100 kernel/locking/lockdep.c:4969
>     lock_acquire+0x182/0x4a0 kernel/locking/lockdep.c:5625
>     __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>     _raw_spin_lock_irqsave+0xb3/0x100 kernel/locking/spinlock.c:159
>     snd_timer_interrupt+0x210/0x1410 sound/core/timer.c:857
>     call_timer_fn+0xf6/0x210 kernel/time/timer.c:1417
>     expire_timers kernel/time/timer.c:1462 [inline]
>     __run_timers+0x6ff/0x910 kernel/time/timer.c:1731
>     run_timer_softirq+0x63/0xf0 kernel/time/timer.c:1744
>     __do_softirq+0x372/0x783 kernel/softirq.c:558
>     invoke_softirq kernel/softirq.c:432 [inline]
>     __irq_exit_rcu+0x21b/0x260 kernel/softirq.c:636
>     irq_exit_rcu+0x5/0x20 kernel/softirq.c:648
>     sysvec_apic_timer_interrupt+0x91/0xb0 arch/x86/kernel/apic/apic.c:1100
>     asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:638
>     __preempt_count_add arch/x86/include/asm/preempt.h:80 [inline]
>     rcu_is_watching+0xd/0xb0 kernel/rcu/tree.c:1159
>     rcu_read_lock include/linux/rcupdate.h:688 [inline]
>     get_cached_acl+0x103/0x540 fs/posix_acl.c:44
>     get_acl+0x20/0x2e0 fs/posix_acl.c:108
>     posix_acl_create+0x119/0x560 fs/posix_acl.c:616
>     ext4_init_acl+0xa6/0x3d0 fs/ext4/acl.c:282
>     __ext4_new_inode+0x44e7/0x5810 fs/ext4/ialloc.c:1316
>     ext4_mkdir+0x3fa/0xc10 fs/ext4/namei.c:2921
>     vfs_mkdir+0x451/0x630 fs/namei.c:3823
>     do_mkdirat+0x267/0x3e0 fs/namei.c:3848
>     do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>     do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
>     entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> 
> stack backtrace:
> CPU: 1 PID: 8431 Comm: syz-executor065 Not tainted 5.14.0-rc2-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>   <IRQ>
>   __dump_stack lib/dump_stack.c:88 [inline]
>   dump_stack_lvl+0x1ae/0x29f lib/dump_stack.c:105
>   print_irq_inversion_bug+0xa58/0xda0 kernel/locking/lockdep.c:4000
>   check_usage_forwards kernel/locking/lockdep.c:2585 [inline]
>   mark_lock_irq kernel/locking/lockdep.c:4163 [inline]
>   mark_lock+0x1064/0x1eb0 kernel/locking/lockdep.c:4593
>   mark_usage kernel/locking/lockdep.c:4488 [inline]
>   __lock_acquire+0xca1/0x6100 kernel/locking/lockdep.c:4969
>   lock_acquire+0x182/0x4a0 kernel/locking/lockdep.c:5625
>   __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>   _raw_spin_lock_irqsave+0xb3/0x100 kernel/locking/spinlock.c:159
>   snd_timer_interrupt+0x210/0x1410 sound/core/timer.c:857
>   call_timer_fn+0xf6/0x210 kernel/time/timer.c:1417
>   expire_timers kernel/time/timer.c:1462 [inline]
>   __run_timers+0x6ff/0x910 kernel/time/timer.c:1731
>   run_timer_softirq+0x63/0xf0 kernel/time/timer.c:1744
>   __do_softirq+0x372/0x783 kernel/softirq.c:558
>   invoke_softirq kernel/softirq.c:432 [inline]
>   __irq_exit_rcu+0x21b/0x260 kernel/softirq.c:636
>   irq_exit_rcu+0x5/0x20 kernel/softirq.c:648
>   sysvec_apic_timer_interrupt+0x91/0xb0 arch/x86/kernel/apic/apic.c:1100
>   </IRQ>
>   asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:638
> RIP: 0010:rcu_dynticks_curr_cpu_in_eqs kernel/rcu/tree.c:339 [inline]
> RIP: 0010:rcu_is_watching+0xd/0xb0 kernel/rcu/tree.c:1160
> Code: 41 5e 41 5f 5d c3 e8 92 a8 6d 08 41 f7 c4 00 02 00 00 75 b6 eb b5 e8 62 a8 6d 08 66 90 41 57 41 56 53 65 83 05 4b e3 96 7e 01 <e8> 1e bb 6d 08 89 c3 83 f8 08 73 74 49 bf 00 00 00 00 00 fc ff df
> RSP: 0018:ffffc9000164f820 EFLAGS: 00000282
> RAX: 12a9aafecb760900 RBX: 1ffff920002c9f0c RCX: ffffffff816213c5
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: ffffc9000164f8e8 R08: dffffc0000000000 R09: fffffbfff1f5e1b1
> R10: fffffbfff1f5e1b1 R11: 0000000000000000 R12: 0000000000004000
> R13: dffffc0000000000 R14: 1ffff920002c9f10 R15: ffff888039f60d48
>   rcu_read_lock include/linux/rcupdate.h:688 [inline]
>   get_cached_acl+0x103/0x540 fs/posix_acl.c:44
>   get_acl+0x20/0x2e0 fs/posix_acl.c:108
>   posix_acl_create+0x119/0x560 fs/posix_acl.c:616
>   ext4_init_acl+0xa6/0x3d0 fs/ext4/acl.c:282
>   __ext4_new_inode+0x44e7/0x5810 fs/ext4/ialloc.c:1316
>   ext4_mkdir+0x3fa/0xc10 fs/ext4/namei.c:2921
>   vfs_mkdir+0x451/0x630 fs/namei.c:3823
>   do_mkdirat+0x267/0x3e0 fs/namei.c:3848
>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>   do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
>   entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x445d87
> Code: 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 53 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffc332de6a8 EFLAGS: 00000202 ORIG_RAX: 0000000000000053
> RAX: ffffffffffffffda RBX: 000000000000e3bb RCX: 0000000000445d87
> RDX: 0000000000000000 RSI: 00000000000001ff RDI: 00007ffc332de740
> RBP: 0000000000002ebc R08: 0000000000000000 R09: 0000000000000005
> R10: 00007ffc332de445 R11: 0000000000000202 R12: 00007ffc332de6e4
> R13: 00007ffc332de740 R14: 00000000000000bd R15: 431bde82d7b634db
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> syzbot can test patches for this issue, for details see:
> https://goo.gl/tpsmEJ#testing-patches
> 

#syz fix: fcntl: fix potential deadlocks for &fown_struct.lock

This deadlock has the same root cause, and thus the same fix [1], as 
"possible deadlock in do_fcntl" [2].

[1]: 
https://lore.kernel.org/lkml/20210702091831.615042-2-desmondcheongzx@gmail.com/
[2]: 
https://syzkaller.appspot.com/bug?id=923cfc6c6348963f99886a0176ef11dcc429547b

Best,
Desmond
