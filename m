Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1649353A08
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Apr 2021 23:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbhDDVkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Apr 2021 17:40:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:32818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230169AbhDDVkf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Apr 2021 17:40:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E2F5A61369;
        Sun,  4 Apr 2021 21:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617572430;
        bh=pbbwnT8tLsRNCOwidX4Wub9TFkFe0anvKnMxl4TAop0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=TUKAQ0xCi3ix0puQ8299n1RVrv5TulEPj+P75La09OjHP3j8//MNFwsQm4v1soeGi
         fbIGI1F4FQg3+zlihYbIuMOUkEzx567wri0ci2GS5Tswtc7oWB1u8k4pss4f2t4LCx
         5w4k3aVLmQ2FpUYUcDS5i2WMcS8LpzD03DoW+WizU8uuCQkOyJgYyBBmPh59EfFhxz
         +BrjPVxV7MFC7i94Y2Iz+4dw94nPyUkzvp+0+8kKoQ/1ntU8oFiYWs/vdAQb6xvwhl
         rQ1eKXcDQGckyA/0ZOmtl6y5V+K44+r6+gctDg9dEigDQygQW7SaNdjwd0CnqJIs32
         sxGkKvQWAiFkA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id A70113522F84; Sun,  4 Apr 2021 14:40:30 -0700 (PDT)
Date:   Sun, 4 Apr 2021 14:40:30 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     syzbot <syzbot+88e4f02896967fe1ab0d@syzkaller.appspotmail.com>,
        john.stultz@linaro.org, linux-kernel@vger.kernel.org,
        sboyd@kernel.org, syzkaller-bugs@googlegroups.com,
        Peter Zijlstra <peterz@infradead.org>, boqun.feng@gmail.com,
        willy@infradead.org
Subject: Re: [syzbot] WARNING: suspicious RCU usage in get_timespec64
Message-ID: <20210404214030.GB2696@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <0000000000000e025b05bf2a430b@google.com>
 <87mtud4wfi.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mtud4wfi.ffs@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 04, 2021 at 10:38:41PM +0200, Thomas Gleixner wrote:
> On Sun, Apr 04 2021 at 12:05, syzbot wrote:
> 
> Cc + ...

And a couple more...

> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    5e46d1b7 reiserfs: update reiserfs_xattrs_initialized() co..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1125f831d00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=78ef1d159159890
> > dashboard link: https://syzkaller.appspot.com/bug?extid=88e4f02896967fe1ab0d
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+88e4f02896967fe1ab0d@syzkaller.appspotmail.com
> >
> > =============================
> > WARNING: suspicious RCU usage
> > 5.12.0-rc5-syzkaller #0 Not tainted
> > -----------------------------
> > kernel/sched/core.c:8294 Illegal context switch in RCU-sched read-side critical section!
> >
> > other info that might help us debug this:
> >
> >
> > rcu_scheduler_active = 2, debug_locks = 0
> > 3 locks held by syz-executor.4/8418:
> >  #0: 
> > ffff8880751d2b28
> >  (
> > &p->pi_lock
> > ){-.-.}-{2:2}
> > , at: try_to_wake_up+0x98/0x14a0 kernel/sched/core.c:3345
> >  #1: 
> > ffff8880b9d35258
> >  (
> > &rq->lock
> > ){-.-.}-{2:2}
> > , at: rq_lock kernel/sched/sched.h:1321 [inline]
> > , at: ttwu_queue kernel/sched/core.c:3184 [inline]
> > , at: try_to_wake_up+0x5e6/0x14a0 kernel/sched/core.c:3464
> >  #2: ffff8880b9d1f948 (&per_cpu_ptr(group->pcpu, cpu)->seq){-.-.}-{0:0}, at: psi_task_change+0x142/0x220 kernel/sched/psi.c:807

This looks similar to syzbot+dde0cc33951735441301@syzkaller.appspotmail.com
in that rcu_sleep_check() sees an RCU lock held, but the later call to
lockdep_print_held_locks() does not.  Did something change recently that
could let the ->lockdep_depth counter get out of sync with the actual
number of locks held?

							Thanx, Paul

> > stack backtrace:
> > CPU: 0 PID: 8418 Comm: syz-executor.4 Not tainted 5.12.0-rc5-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > Call Trace:
> >  __dump_stack lib/dump_stack.c:79 [inline]
> >  dump_stack+0x141/0x1d7 lib/dump_stack.c:120
> >  ___might_sleep+0x266/0x2c0 kernel/sched/core.c:8294
> >  __might_fault+0x6e/0x180 mm/memory.c:5018
> >  _copy_from_user+0x27/0x180 lib/usercopy.c:13
> >  copy_from_user include/linux/uaccess.h:192 [inline]
> >  get_timespec64+0x75/0x220 kernel/time/time.c:787
> >  __do_sys_clock_nanosleep kernel/time/posix-timers.c:1257 [inline]
> >  __se_sys_clock_nanosleep kernel/time/posix-timers.c:1245 [inline]
> >  __x64_sys_clock_nanosleep+0x1bb/0x430 kernel/time/posix-timers.c:1245
> >  do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
> >  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > RIP: 0033:0x48a621
> > Code: 24 0c 89 3c 24 48 89 4c 24 18 e8 aa e7 ff ff 4c 8b 54 24 18 48 8b 54 24 10 41 89 c0 8b 74 24 0c 8b 3c 24 b8 e6 00 00 00 0f 05 <44> 89 c7 48 89 04 24 e8 e3 e7 ff ff 48 8b 04 24 eb 97 66 2e 0f 1f
> > RSP: 002b:00007fffe59fbd50 EFLAGS: 00000293 ORIG_RAX: 00000000000000e6
> > RAX: ffffffffffffffda RBX: 0000000000000294 RCX: 000000000048a621
> > RDX: 00007fffe59fbd90 RSI: 0000000000000000 RDI: 0000000000000000
> > RBP: 00007fffe59fbe2c R08: 0000000000000000 R09: 00007fffe5b8a090
> > R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000032
> > R13: 000000000005717a R14: 0000000000000003 R15: 00007fffe59fbe90
> >
> >
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
