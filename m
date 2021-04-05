Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87AAB354949
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 01:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241854AbhDEXiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 19:38:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:55252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237964AbhDEXiO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 19:38:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B794361184;
        Mon,  5 Apr 2021 23:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617665887;
        bh=e3GvBCFcPscVgvvAhuU2SFj92Bt4g9vqi446452GWBk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=mx8q5l6ah5ssEw+b0hMuoAAob3Urk6boQE/EkMwlauuY6BJlsUZgoHvyRoKhG4ywq
         oNK3KiVYnubXcwMkNFAroYYsWyVY51OcSO8jeNgM/b3m3H36qt3xm62MwMq8wFcVHv
         gt3dpN/Q86MD2S2WssEhqJTwuFuRAPaEWf1HjATmMKHXoAHfOBddFyBODuDFmnJo76
         tdzvQJuZ4OpboBpbYynUsk4MKAHL+sOPOeY184oCFGD4IYdr0xA2CDOHmQj2kRjOte
         gxoUxLXMgG0KJh/XjpWqJpIqJzzeB9mL4utoxVwAYYJDTGysGVSbq9KYFq4Prtt+H2
         3dnUYB2MyS6zg==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 5617A3522A62; Mon,  5 Apr 2021 16:38:07 -0700 (PDT)
Date:   Mon, 5 Apr 2021 16:38:07 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        syzbot <syzbot+88e4f02896967fe1ab0d@syzkaller.appspotmail.com>,
        john.stultz@linaro.org, linux-kernel@vger.kernel.org,
        sboyd@kernel.org, syzkaller-bugs@googlegroups.com,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [syzbot] WARNING: suspicious RCU usage in get_timespec64
Message-ID: <20210405233807.GO2696@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <0000000000000e025b05bf2a430b@google.com>
 <87mtud4wfi.ffs@nanos.tec.linutronix.de>
 <20210404214030.GB2696@paulmck-ThinkPad-P72>
 <20210405030855.GG2531743@casper.infradead.org>
 <20210405040125.GF2696@paulmck-ThinkPad-P72>
 <20210405043038.GA31091@paulmck-ThinkPad-P72>
 <YGqe0tRRpibv3/Bd@boqun-archlinux>
 <20210405172752.GK2696@paulmck-ThinkPad-P72>
 <YGuceETAscvhhnqT@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGuceETAscvhhnqT@boqun-archlinux>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2021 at 07:25:44AM +0800, Boqun Feng wrote:
> On Mon, Apr 05, 2021 at 10:27:52AM -0700, Paul E. McKenney wrote:
> > On Mon, Apr 05, 2021 at 01:23:30PM +0800, Boqun Feng wrote:
> > > On Sun, Apr 04, 2021 at 09:30:38PM -0700, Paul E. McKenney wrote:
> > > > On Sun, Apr 04, 2021 at 09:01:25PM -0700, Paul E. McKenney wrote:
> > > > > On Mon, Apr 05, 2021 at 04:08:55AM +0100, Matthew Wilcox wrote:
> > > > > > On Sun, Apr 04, 2021 at 02:40:30PM -0700, Paul E. McKenney wrote:
> > > > > > > On Sun, Apr 04, 2021 at 10:38:41PM +0200, Thomas Gleixner wrote:
> > > > > > > > On Sun, Apr 04 2021 at 12:05, syzbot wrote:
> > > > > > > > 
> > > > > > > > Cc + ...
> > > > > > > 
> > > > > > > And a couple more...
> > > > > > > 
> > > > > > > > > Hello,
> > > > > > > > >
> > > > > > > > > syzbot found the following issue on:
> > > > > > > > >
> > > > > > > > > HEAD commit:    5e46d1b7 reiserfs: update reiserfs_xattrs_initialized() co..
> > > > > > > > > git tree:       upstream
> > > > > > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=1125f831d00000
> > > > > > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=78ef1d159159890
> > > > > > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=88e4f02896967fe1ab0d
> > > > > > > > >
> > > > > > > > > Unfortunately, I don't have any reproducer for this issue yet.
> > > > > > > > >
> > > > > > > > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > > > > > > > Reported-by: syzbot+88e4f02896967fe1ab0d@syzkaller.appspotmail.com
> > > > > > > > >
> > > > > > > > > =============================
> > > > > > > > > WARNING: suspicious RCU usage
> > > > > > > > > 5.12.0-rc5-syzkaller #0 Not tainted
> > > > > > > > > -----------------------------
> > > > > > > > > kernel/sched/core.c:8294 Illegal context switch in RCU-sched read-side critical section!
> > > > > > > > >
> > > > > > > > > other info that might help us debug this:
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > rcu_scheduler_active = 2, debug_locks = 0
> > > > > > > > > 3 locks held by syz-executor.4/8418:
> > > > > > > > >  #0: 
> > > > > > > > > ffff8880751d2b28
> > > > > > > > >  (
> > > > > > > > > &p->pi_lock
> > > > > > > > > ){-.-.}-{2:2}
> > > > > > > > > , at: try_to_wake_up+0x98/0x14a0 kernel/sched/core.c:3345
> > > > > > > > >  #1: 
> > > > > > > > > ffff8880b9d35258
> > > > > > > > >  (
> > > > > > > > > &rq->lock
> > > > > > > > > ){-.-.}-{2:2}
> > > > > > > > > , at: rq_lock kernel/sched/sched.h:1321 [inline]
> > > > > > > > > , at: ttwu_queue kernel/sched/core.c:3184 [inline]
> > > > > > > > > , at: try_to_wake_up+0x5e6/0x14a0 kernel/sched/core.c:3464
> > > > > > > > >  #2: ffff8880b9d1f948 (&per_cpu_ptr(group->pcpu, cpu)->seq){-.-.}-{0:0}, at: psi_task_change+0x142/0x220 kernel/sched/psi.c:807
> > > > > > > 
> > > > > > > This looks similar to syzbot+dde0cc33951735441301@syzkaller.appspotmail.com
> > > > > > > in that rcu_sleep_check() sees an RCU lock held, but the later call to
> > > > > > > lockdep_print_held_locks() does not.  Did something change recently that
> > > > > > > could let the ->lockdep_depth counter get out of sync with the actual
> > > > > > > number of locks held?
> > > > > > 
> > > > > > Dmitri had a different theory here:
> > > > > > 
> > > > > > https://groups.google.com/g/syzkaller-bugs/c/FmYvfZCZzqA/m/nc2CXUgsAgAJ
> > > > > 
> > > > > There is always room for more than one bug.  ;-)
> > > > > 
> > > > > He says "one-off false positives".  I was afraid of that...
> > > > 
> > > > And both the examples I have been copied on today are consistent with
> > > > debug_locks getting zeroed (e.g., via a call to __debug_locks_off())
> > > > in the midst of a call to rcu_sleep_check().  But I would expect to see
> > > > a panic or another splat if that were to happen.
> > > > 
> > > > Dmitry's example did have an additional splat, but I would expect the
> > > > RCU-related one to come second.  Again, there is always room for more
> > > > than one bug.
> > > > 
> > > > On the other hand, there are a lot more callers to debug_locks_off()
> > > > than there were last I looked into this.  And both of these splats
> > > > are consistent with an interrupt in the middle of rcu_sleep_check(),
> > > > and that interrupt's handler invoking debug_locks_off(), but without
> > > > printing anything to the console.  Does that sequence of events ring a
> > > > bell for anyone?
> > > > 
> > > > If this is the new normal, I could make RCU_LOCKDEP_WARN() recheck
> > > > debug_lockdep_rcu_enabled() after evaluating the condition, but with
> > > > a memory barrier immediately before the recheck.  But I am not at all
> > > > excited by doing this on speculation.  Especially given that doing
> > > > so might be covering up some other bug.
> > > > 
> > > 
> > > Just check the original console log and find:
> > > 
> > > [  356.696686][ T8418] =============================
> > > [  356.696692][ T8418] WARNING: suspicious RCU usage
> > > [  356.700193][T14782] ====================================
> > > [  356.704548][ T8418] 5.12.0-rc5-syzkaller #0 Not tainted
> > > [  356.729981][ T8418] -----------------------------
> > > [  356.732473][T14782] WARNING: iou-sqp-14780/14782 still has locks held!
> > > 
> > > , so there are two warnnings here, one is from lockdep_rcu_suspisous()
> > > and the other is from print_held_locks_bug(). I think this is what
> > > happened:
> > > 
> > > in RCU_LOCKDEP_WARN():
> > > 
> > > 	if (debug_lockdep_rcu_enabled() // this is true and at this time debug_locks = 1
> > > 	<interrupted>
> > > 	// lockdep detects a lock bug, set debug_locks = 0
> > > 	<swicth back>
> > > 	    && !__warned // true
> > > 	    && (c))      // "c" is a lock_is_held(), which will always returns true if debug_locks == 0!
> > > 
> > > the cause of the problem is that RCU_LOCKDEP_WARN() in fact read
> > > debug_locks twice and get different values.
> > > 
> > > But if you change the ordering of two reads, probably can avoid the
> > > problem:
> > > 	
> > > First read:
> > > 	lock_is_held(); // true if 1) lock is really held or 2) lockdep is off
> > > 
> > > Second read:
> > > 	debug_lockdep_rcu_enabled(); // if lockdep is not off, we know
> > > 				     // that the first read got correct
> > > 				     // value, otherwise we just ignore
> > > 				     // the first read, because either
> > > 				     // there is a bug reported between
> > > 				     // two reads, or lockdep is already
> > > 				     // off when the first read happens.
> > > 
> > > So maybe something below:
> > > 
> > > Regards,
> > > Boqun
> > > 
> > > diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> > > index bd04f722714f..d11bee5d9347 100644
> > > --- a/include/linux/rcupdate.h
> > > +++ b/include/linux/rcupdate.h
> > > @@ -315,7 +315,7 @@ static inline int rcu_read_lock_any_held(void)
> > >  #define RCU_LOCKDEP_WARN(c, s)						\
> > >  	do {								\
> > >  		static bool __section(".data.unlikely") __warned;	\
> > > -		if (debug_lockdep_rcu_enabled() && !__warned && (c)) {	\
> > > +		if ((c) && debug_lockdep_rcu_enabled() && !__warned) {	\
> > >  			__warned = true;				\
> > >  			lockdep_rcu_suspicious(__FILE__, __LINE__, s);	\
> > >  		}							\
> > 
> > Good point -- if we check debug_lockdep_rcu_enabled() after the condition,
> > then we will reject false positives in cases where debug_locks was switched
> > to zero out from under us.
> > 
> > However, we do need ordering.  The "c" usually contains lock_is_held(),
> > which also checks debug_locks, but from some other translation unit.
> > Back in the day, the translation-unit boundaries would provide the needed
> > ordering, but LTO...
> > 
> > In addition, the "debug_locks = 0" was originally supposed to be a hint
> > that the report might be a false positive.  It is clear that this needs
> > to be made explicit.
> > 
> > Taking all this together, how about the following?  (The intent is
> > that the changes to lockdep_rcu_suspicious() will be in a separate
> > commit.)
> 
> Looks good to me ;-)

Whew!  May I add your Reviewed-by?

							Thanx, Paul

> Regards,
> Boqun
> 
> > 							Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> > index 9455476..1199ffd 100644
> > --- a/include/linux/rcupdate.h
> > +++ b/include/linux/rcupdate.h
> > @@ -315,7 +315,7 @@ static inline int rcu_read_lock_any_held(void)
> >  #define RCU_LOCKDEP_WARN(c, s)						\
> >  	do {								\
> >  		static bool __section(".data.unlikely") __warned;	\
> > -		if (debug_lockdep_rcu_enabled() && !__warned && (c)) {	\
> > +		if ((c) && debug_lockdep_rcu_enabled() && !__warned) {	\
> >  			__warned = true;				\
> >  			lockdep_rcu_suspicious(__FILE__, __LINE__, s);	\
> >  		}							\
> > diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> > index c6d0c1dc..80065cd 100644
> > --- a/kernel/locking/lockdep.c
> > +++ b/kernel/locking/lockdep.c
> > @@ -6387,6 +6387,7 @@ asmlinkage __visible void lockdep_sys_exit(void)
> >  void lockdep_rcu_suspicious(const char *file, const int line, const char *s)
> >  {
> >  	struct task_struct *curr = current;
> > +	int dl = READ_ONCE(debug_locks);
> >  
> >  	/* Note: the following can be executed concurrently, so be careful. */
> >  	pr_warn("\n");
> > @@ -6396,11 +6397,12 @@ void lockdep_rcu_suspicious(const char *file, const int line, const char *s)
> >  	pr_warn("-----------------------------\n");
> >  	pr_warn("%s:%d %s!\n", file, line, s);
> >  	pr_warn("\nother info that might help us debug this:\n\n");
> > -	pr_warn("\n%srcu_scheduler_active = %d, debug_locks = %d\n",
> > +	pr_warn("\n%srcu_scheduler_active = %d, debug_locks = %d\n%s",
> >  	       !rcu_lockdep_current_cpu_online()
> >  			? "RCU used illegally from offline CPU!\n"
> >  			: "",
> > -	       rcu_scheduler_active, debug_locks);
> > +	       rcu_scheduler_active, dl,
> > +	       dl ? "" : "Possible false positive due to lockdep disabling via debug_locks = 0\n");
> >  
> >  	/*
> >  	 * If a CPU is in the RCU-free window in idle (ie: in the section
> > diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
> > index b95ae86..dd94a60 100644
> > --- a/kernel/rcu/update.c
> > +++ b/kernel/rcu/update.c
> > @@ -277,7 +277,7 @@ EXPORT_SYMBOL_GPL(rcu_callback_map);
> >  
> >  noinstr int notrace debug_lockdep_rcu_enabled(void)
> >  {
> > -	return rcu_scheduler_active != RCU_SCHEDULER_INACTIVE && debug_locks &&
> > +	return rcu_scheduler_active != RCU_SCHEDULER_INACTIVE && READ_ONCE(debug_locks) &&
> >  	       current->lockdep_recursion == 0;
> >  }
> >  EXPORT_SYMBOL_GPL(debug_lockdep_rcu_enabled);
