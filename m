Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3787353B5B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 06:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbhDEEap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 00:30:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:45758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229660AbhDEEan (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 00:30:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 572F261393;
        Mon,  5 Apr 2021 04:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617597038;
        bh=0xcu041+pNVfsXt37gczboJnpf3deKpSCK/hNzFh9f8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=gYhmkwOwZvxciONeQ+q1u9m15qXHT1IQfSglYHVmfHjLnJANocU02m0A0ZmcTIC71
         GRQwwbXYj/DZT97reXF0ot5ZLVqMGcbrlOAYvzZJY5q42QkIx3oGUlH0/0rwoeBYmW
         72NrC6cQ1YQINNHd+z3jC/MoTOLJBPdZw4TflJHJwxUb2Kt/Sy1pUNJBkICEYpYs2q
         KVa6EEYUZvqP//2brqm6qwE9ABv1PfNQvmQkNRV2Eas+0k/ArkclSR1BgVa8QPvAQZ
         OsvubOpOYs7zXIVZ0A+ho9IAabi4xqjbylMIBfwMApW415IC6FdD05Ui8MeeBlU+OQ
         SDP5fFkXDp3cQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 1D0513522A4E; Sun,  4 Apr 2021 21:30:38 -0700 (PDT)
Date:   Sun, 4 Apr 2021 21:30:38 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        syzbot <syzbot+88e4f02896967fe1ab0d@syzkaller.appspotmail.com>,
        john.stultz@linaro.org, linux-kernel@vger.kernel.org,
        sboyd@kernel.org, syzkaller-bugs@googlegroups.com,
        Peter Zijlstra <peterz@infradead.org>, boqun.feng@gmail.com
Subject: Re: [syzbot] WARNING: suspicious RCU usage in get_timespec64
Message-ID: <20210405043038.GA31091@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <0000000000000e025b05bf2a430b@google.com>
 <87mtud4wfi.ffs@nanos.tec.linutronix.de>
 <20210404214030.GB2696@paulmck-ThinkPad-P72>
 <20210405030855.GG2531743@casper.infradead.org>
 <20210405040125.GF2696@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210405040125.GF2696@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 04, 2021 at 09:01:25PM -0700, Paul E. McKenney wrote:
> On Mon, Apr 05, 2021 at 04:08:55AM +0100, Matthew Wilcox wrote:
> > On Sun, Apr 04, 2021 at 02:40:30PM -0700, Paul E. McKenney wrote:
> > > On Sun, Apr 04, 2021 at 10:38:41PM +0200, Thomas Gleixner wrote:
> > > > On Sun, Apr 04 2021 at 12:05, syzbot wrote:
> > > > 
> > > > Cc + ...
> > > 
> > > And a couple more...
> > > 
> > > > > Hello,
> > > > >
> > > > > syzbot found the following issue on:
> > > > >
> > > > > HEAD commit:    5e46d1b7 reiserfs: update reiserfs_xattrs_initialized() co..
> > > > > git tree:       upstream
> > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=1125f831d00000
> > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=78ef1d159159890
> > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=88e4f02896967fe1ab0d
> > > > >
> > > > > Unfortunately, I don't have any reproducer for this issue yet.
> > > > >
> > > > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > > > Reported-by: syzbot+88e4f02896967fe1ab0d@syzkaller.appspotmail.com
> > > > >
> > > > > =============================
> > > > > WARNING: suspicious RCU usage
> > > > > 5.12.0-rc5-syzkaller #0 Not tainted
> > > > > -----------------------------
> > > > > kernel/sched/core.c:8294 Illegal context switch in RCU-sched read-side critical section!
> > > > >
> > > > > other info that might help us debug this:
> > > > >
> > > > >
> > > > > rcu_scheduler_active = 2, debug_locks = 0
> > > > > 3 locks held by syz-executor.4/8418:
> > > > >  #0: 
> > > > > ffff8880751d2b28
> > > > >  (
> > > > > &p->pi_lock
> > > > > ){-.-.}-{2:2}
> > > > > , at: try_to_wake_up+0x98/0x14a0 kernel/sched/core.c:3345
> > > > >  #1: 
> > > > > ffff8880b9d35258
> > > > >  (
> > > > > &rq->lock
> > > > > ){-.-.}-{2:2}
> > > > > , at: rq_lock kernel/sched/sched.h:1321 [inline]
> > > > > , at: ttwu_queue kernel/sched/core.c:3184 [inline]
> > > > > , at: try_to_wake_up+0x5e6/0x14a0 kernel/sched/core.c:3464
> > > > >  #2: ffff8880b9d1f948 (&per_cpu_ptr(group->pcpu, cpu)->seq){-.-.}-{0:0}, at: psi_task_change+0x142/0x220 kernel/sched/psi.c:807
> > > 
> > > This looks similar to syzbot+dde0cc33951735441301@syzkaller.appspotmail.com
> > > in that rcu_sleep_check() sees an RCU lock held, but the later call to
> > > lockdep_print_held_locks() does not.  Did something change recently that
> > > could let the ->lockdep_depth counter get out of sync with the actual
> > > number of locks held?
> > 
> > Dmitri had a different theory here:
> > 
> > https://groups.google.com/g/syzkaller-bugs/c/FmYvfZCZzqA/m/nc2CXUgsAgAJ
> 
> There is always room for more than one bug.  ;-)
> 
> He says "one-off false positives".  I was afraid of that...

And both the examples I have been copied on today are consistent with
debug_locks getting zeroed (e.g., via a call to __debug_locks_off())
in the midst of a call to rcu_sleep_check().  But I would expect to see
a panic or another splat if that were to happen.

Dmitry's example did have an additional splat, but I would expect the
RCU-related one to come second.  Again, there is always room for more
than one bug.

On the other hand, there are a lot more callers to debug_locks_off()
than there were last I looked into this.  And both of these splats
are consistent with an interrupt in the middle of rcu_sleep_check(),
and that interrupt's handler invoking debug_locks_off(), but without
printing anything to the console.  Does that sequence of events ring a
bell for anyone?

If this is the new normal, I could make RCU_LOCKDEP_WARN() recheck
debug_lockdep_rcu_enabled() after evaluating the condition, but with
a memory barrier immediately before the recheck.  But I am not at all
excited by doing this on speculation.  Especially given that doing
so might be covering up some other bug.

							Thanx, Paul
