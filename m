Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD3F32BD7A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384529AbhCCQIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 11:08:19 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:36944 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353421AbhCCLgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 06:36:46 -0500
Received: by mail-io1-f72.google.com with SMTP id a18so4610125ioo.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 03:36:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=tciw2JxRbT2P1cxtZkX1ZojiqjIjZQ7jo168QH9ICpg=;
        b=eXvjPIOrlzxNYkfTndG1tbR5Cfr9QWuC1gfOIyFY9f4m5tDX++sbsm6iiMcqHpUDs+
         c2PXgbliqj8l5RFo44vlcAot3wymkjm4SuJamTcQRJYiZpUX1tupmYweQ3OCtiwph6G/
         k6tUSfovTSOAF7DNDuWXyaw7x8x3mCLzB+STIPw+NDzBYWwEHu5t9Z7/OByARuR9IfhW
         8beGPN5x3h3C7BXamQaazab7gd8KTPycIUcc11puOevCLM7FFjLKFR8QPGK1mnoKl31j
         RDLg46DJX2k2dMqCaWUvpxuMltKaJNOYvyii+D/HvB5MdUvFfgJLsaibXZHFLRlLzIz5
         idaQ==
X-Gm-Message-State: AOAM530OCl9unwriD8IJZRltQ8ikNX0stMbPRfBaxbvGX1QDlI7uoxXM
        qAP7iQtkeCA7qB6n3V8X95bmYGX25rE+bjCE7XflBEXuIHEy
X-Google-Smtp-Source: ABdhPJwskh1ojxo9l/GYgjfio1+GsMj1CJlinUlNr5NkX6+EOr2T2CXdMujaW7maG0lVwabpebC7UNc/NxHC8QtL9gC8Y7nLc0+V
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12a1:: with SMTP id f1mr21062550ilr.124.1614771364788;
 Wed, 03 Mar 2021 03:36:04 -0800 (PST)
Date:   Wed, 03 Mar 2021 03:36:04 -0800
In-Reply-To: <f83bda00-251c-af17-1073-05fd4da80f59@kernel.dk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000977f9005bca0418d@google.com>
Subject: Re: possible deadlock in io_poll_double_wake (2)
From:   syzbot <syzbot+28abd693db9e92c160d8@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
possible deadlock in io_poll_double_wake

poll and dpoll head different
============================================
WARNING: possible recursive locking detected
5.12.0-rc1-syzkaller #0 Not tainted
--------------------------------------------
kworker/1:3/8637 is trying to acquire lock:
ffff888040471130 (&runtime->sleep){..-.}-{2:2}, at: spin_lock include/linux/spinlock.h:354 [inline]
ffff888040471130 (&runtime->sleep){..-.}-{2:2}, at: io_poll_double_wake.cold+0x115/0x4e0 fs/io_uring.c:4931

but task is already holding lock:
ffff888040473130 (&runtime->sleep){..-.}-{2:2}, at: __wake_up_common_lock+0xb4/0x130 kernel/sched/wait.c:137

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&runtime->sleep);
  lock(&runtime->sleep);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

5 locks held by kworker/1:3/8637:
 #0: ffff888020d60938 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888020d60938 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: atomic64_set include/asm-generic/atomic-instrumented.h:856 [inline]
 #0: ffff888020d60938 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: atomic_long_set include/asm-generic/atomic-long.h:41 [inline]
 #0: ffff888020d60938 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:616 [inline]
 #0: ffff888020d60938 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:643 [inline]
 #0: ffff888020d60938 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work+0x871/0x1600 kernel/workqueue.c:2246
 #1: ffffc900027bfda8 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_one_work+0x8a5/0x1600 kernel/workqueue.c:2250
 #2: ffffffff8ce7d028 (rtnl_mutex){+.+.}-{3:3}, at: addrconf_dad_work+0xa3/0x12b0 net/ipv6/addrconf.c:4031
 #3: ffff8880209d8908 (&group->lock){..-.}-{2:2}, at: _snd_pcm_stream_lock_irqsave+0x9f/0xd0 sound/core/pcm_native.c:170
 #4: ffff888040473130 (&runtime->sleep){..-.}-{2:2}, at: __wake_up_common_lock+0xb4/0x130 kernel/sched/wait.c:137

stack backtrace:
CPU: 1 PID: 8637 Comm: kworker/1:3 Not tainted 5.12.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: ipv6_addrconf addrconf_dad_work
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0xfa/0x151 lib/dump_stack.c:120
 print_deadlock_bug kernel/locking/lockdep.c:2829 [inline]
 check_deadlock kernel/locking/lockdep.c:2872 [inline]
 validate_chain kernel/locking/lockdep.c:3661 [inline]
 __lock_acquire.cold+0x14c/0x3b4 kernel/locking/lockdep.c:4900
 lock_acquire kernel/locking/lockdep.c:5510 [inline]
 lock_acquire+0x1ab/0x730 kernel/locking/lockdep.c:5475
 __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
 _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:151
 spin_lock include/linux/spinlock.h:354 [inline]
 io_poll_double_wake.cold+0x115/0x4e0 fs/io_uring.c:4931
 __wake_up_common+0x147/0x650 kernel/sched/wait.c:108
 __wake_up_common_lock+0xd0/0x130 kernel/sched/wait.c:138
 snd_pcm_update_state+0x46a/0x540 sound/core/pcm_lib.c:203
 snd_pcm_update_hw_ptr0+0xa75/0x1a50 sound/core/pcm_lib.c:464
 snd_pcm_period_elapsed+0x160/0x250 sound/core/pcm_lib.c:1805
 dummy_hrtimer_callback+0x94/0x1b0 sound/drivers/dummy.c:378
 __run_hrtimer kernel/time/hrtimer.c:1519 [inline]
 __hrtimer_run_queues+0x609/0xe40 kernel/time/hrtimer.c:1583
 hrtimer_run_softirq+0x17b/0x360 kernel/time/hrtimer.c:1600
 __do_softirq+0x29b/0x9f6 kernel/softirq.c:345
 do_softirq.part.0+0xc8/0x110 kernel/softirq.c:248
 </IRQ>
 do_softirq kernel/softirq.c:240 [inline]
 __local_bh_enable_ip+0x102/0x120 kernel/softirq.c:198
 mld_send_initial_cr.part.0+0xf4/0x150 net/ipv6/mcast.c:2094
 mld_send_initial_cr net/ipv6/mcast.c:1191 [inline]
 ipv6_mc_dad_complete+0x1bb/0x6b0 net/ipv6/mcast.c:2103
 addrconf_dad_completed+0x94d/0xc70 net/ipv6/addrconf.c:4175
 addrconf_dad_work+0x79f/0x12b0 net/ipv6/addrconf.c:4105
 process_one_work+0x98d/0x1600 kernel/workqueue.c:2275
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2421
 kthread+0x3b1/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
poll and dpoll head different
poll and dpoll head different
poll and dpoll head different
poll and dpoll head different
poll and dpoll head different
poll and dpoll head different
poll and dpoll head different
poll and dpoll head different
poll and dpoll head different
poll and dpoll head different
poll and dpoll head different
poll and dpoll head different
poll and dpoll head different
poll and dpoll head different
poll and dpoll head different
poll and dpoll head different
poll and dpoll head different
poll and dpoll head different
poll and dpoll head different
poll and dpoll head different
poll and dpoll head different
poll and dpoll head different
poll and dpoll head different
poll and dpoll head different
poll and dpoll head different
poll and dpoll head different
poll and dpoll head different
poll and dpoll head different
poll and dpoll head different
poll and dpoll head different
poll and dpoll head different
poll and dpoll head different
poll and dpoll head different
poll and dpoll head different
poll and dpoll head different
poll and dpoll head different
poll and dpoll head different
poll and dpoll head different
poll and dpoll head different
poll and dpoll head different
poll and dpoll head different
poll and dpoll head different
poll and dpoll head different
poll and dpoll head different
poll and dpoll head different
poll and dpoll head different
poll and dpoll head different
poll and dpoll head different
poll and dpoll head different
poll and dpoll head different
poll and dpoll head different
poll and dpoll head different
poll and dpoll head different
poll and dpoll head different
poll and dpoll head different
poll and dpoll head different
poll and dpoll head different
poll and dpoll head different
poll and dpoll head different
poll and dpoll head different
poll and dpoll head different
poll and dpoll head different
poll and dpoll head different
poll and dpoll head different
poll and dpoll head different
poll and dpoll head different
poll and dpoll head different
poll and dpoll head different
poll and dpoll head different
poll and dpoll head different
poll and dpoll head different
poll and dpoll head different
poll and dpoll head different
poll and dpoll head different
poll and dpoll head different
poll and dpoll head different
poll and dpoll head different
poll and dpoll head different
poll and dpoll head different
poll and dpoll head different
poll and dpoll head different


Tested on:

commit:         44a23ff1 io_uring: debug messages
git tree:       git://git.kernel.dk/linux-block syzbot-test
console output: https://syzkaller.appspot.com/x/log.txt?x=1790cb92d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa0e4e0c3e0cf6e0
dashboard link: https://syzkaller.appspot.com/bug?extid=28abd693db9e92c160d8
compiler:       

