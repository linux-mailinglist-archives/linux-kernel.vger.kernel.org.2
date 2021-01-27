Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7723063F0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 20:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344241AbhA0TTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 14:19:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:36156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231186AbhA0TTM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 14:19:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 918F064DC1;
        Wed, 27 Jan 2021 19:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611775111;
        bh=tha+PZnmBmjJVZeasnqwKvwWKJHoksQioV25bQ1mcOg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=WCdDhcgLvHmup5v4mUiDMukJ+satxT6wNFo1w+uN6p19TXjiNYRaKxDzB8r+SmGN0
         xWVnXu/z3f0e2C/8oXSM+5iBS02RO5o7NJmt6lfAMplKLS82ZNIBLjPzJr+OicLWv+
         dCgGZjDXJetCDS8pvvs+SoW0nhtZueg90IaIL/yzQvRUpuVdKj4Wgn0PEK+bidgyOB
         IXOEpq2QjGt1QwOqyvRM2mslVJ4FKf6sFflKStc61Mk/JzuFmwsLaAO+oK7MLbXuKV
         9VPlNXY8oInoULYhGEsaqA4+6kJTeFrstI2xt/+i8mUZtL30zlnxsr1mTeRSOuHdvT
         biO5n1ZPxpSEw==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 275D3352260C; Wed, 27 Jan 2021 11:18:31 -0800 (PST)
Date:   Wed, 27 Jan 2021 11:18:31 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Scott Wood <swood@redhat.com>
Subject: Re: [PATCH tip/core/rcu 1/4] rcu: Expedite deboost in case of
 deferred quiescent state
Message-ID: <20210127191831.GM2743@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210120043144.GA7045@paulmck-ThinkPad-P72>
 <20210120043236.7254-1-paulmck@kernel.org>
 <YBDTG5HEC6OLV8OQ@boqun-archlinux>
 <20210127044024.GI2743@paulmck-ThinkPad-P72>
 <YBEQtAeqMg5AX291@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YBEQtAeqMg5AX291@boqun-archlinux>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 03:05:24PM +0800, Boqun Feng wrote:
> On Tue, Jan 26, 2021 at 08:40:24PM -0800, Paul E. McKenney wrote:
> > On Wed, Jan 27, 2021 at 10:42:35AM +0800, Boqun Feng wrote:
> > > Hi Paul,
> > > 
> > > On Tue, Jan 19, 2021 at 08:32:33PM -0800, paulmck@kernel.org wrote:
> > > > From: "Paul E. McKenney" <paulmck@kernel.org>
> > > > 
> > > > Historically, a task that has been subjected to RCU priority boosting is
> > > > deboosted at rcu_read_unlock() time.  However, with the advent of deferred
> > > > quiescent states, if the outermost rcu_read_unlock() was invoked with
> > > > either bottom halves, interrupts, or preemption disabled, the deboosting
> > > > will be delayed for some time.  During this time, a low-priority process
> > > > might be incorrectly running at a high real-time priority level.
> > > > 
> > > > Fortunately, rcu_read_unlock_special() already provides mechanisms for
> > > > forcing a minimal deferral of quiescent states, at least for kernels
> > > > built with CONFIG_IRQ_WORK=y.  These mechanisms are currently used
> > > > when expedited grace periods are pending that might be blocked by the
> > > > current task.  This commit therefore causes those mechanisms to also be
> > > > used in cases where the current task has been or might soon be subjected
> > > > to RCU priority boosting.  Note that this applies to all kernels built
> > > > with CONFIG_RCU_BOOST=y, regardless of whether or not they are also
> > > > built with CONFIG_PREEMPT_RT=y.
> > > > 
> > > > This approach assumes that kernels build for use with aggressive real-time
> > > > applications are built with CONFIG_IRQ_WORK=y.  It is likely to be far
> > > > simpler to enable CONFIG_IRQ_WORK=y than to implement a fast-deboosting
> > > > scheme that works correctly in its absence.
> > > > 
> > > > While in the area, alphabetize the rcu_preempt_deferred_qs_handler()
> > > > function's local variables.
> > > > 
> > > > Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > > > Cc: Scott Wood <swood@redhat.com>
> > > > Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> > > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > > ---
> > > >  kernel/rcu/tree_plugin.h | 26 ++++++++++++++------------
> > > >  1 file changed, 14 insertions(+), 12 deletions(-)
> > > > 
> > > > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> > > > index 8b0feb2..fca31c6 100644
> > > > --- a/kernel/rcu/tree_plugin.h
> > > > +++ b/kernel/rcu/tree_plugin.h
> > > > @@ -660,9 +660,9 @@ static void rcu_preempt_deferred_qs_handler(struct irq_work *iwp)
> > > >  static void rcu_read_unlock_special(struct task_struct *t)
> > > >  {
> > > >  	unsigned long flags;
> > > > +	bool irqs_were_disabled;
> > > >  	bool preempt_bh_were_disabled =
> > > >  			!!(preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK));
> > > > -	bool irqs_were_disabled;
> > > >  
> > > >  	/* NMI handlers cannot block and cannot safely manipulate state. */
> > > >  	if (in_nmi())
> > > > @@ -671,30 +671,32 @@ static void rcu_read_unlock_special(struct task_struct *t)
> > > >  	local_irq_save(flags);
> > > >  	irqs_were_disabled = irqs_disabled_flags(flags);
> > > >  	if (preempt_bh_were_disabled || irqs_were_disabled) {
> > > > -		bool exp;
> > > > +		bool expboost; // Expedited GP in flight or possible boosting.
> > > >  		struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
> > > >  		struct rcu_node *rnp = rdp->mynode;
> > > >  
> > > > -		exp = (t->rcu_blocked_node &&
> > > > -		       READ_ONCE(t->rcu_blocked_node->exp_tasks)) ||
> > > > -		      (rdp->grpmask & READ_ONCE(rnp->expmask));
> > > > +		expboost = (t->rcu_blocked_node && READ_ONCE(t->rcu_blocked_node->exp_tasks)) ||
> > > > +			   (rdp->grpmask & READ_ONCE(rnp->expmask)) ||
> > > > +			   (IS_ENABLED(CONFIG_RCU_BOOST) && irqs_were_disabled &&
> > > > +			    t->rcu_blocked_node);
> > > 
> > > I take it that you check whether possible boosting is in progress via
> > > the last expression of "||", ie:
> > > 
> > > 	(IS_ENABLED(CONFIG_RCU_BOOST) && irqs_were_disabled &&
> > > 	t->rcu_blocked_node)
> > > 
> > > if so, I don't see the point of using the new "expboost" in the
> > > raise_softirq_irqoff() branch, because if in_irq() is false, we only
> > > raise softirq if irqs_were_disabled is false (otherwise, we may take the
> > > risk of doing a wakeup with a pi or rq lock held, IIRC), and the
> > > boosting part of the "expboost" above is only true if irqs_were_disabled
> > > is true, so using expboost makes no different here.
> > 
> > I started out with two local variables, one for each side of the ||,
> > but this looked nicer.
> > 
> > > >  		// Need to defer quiescent state until everything is enabled.
> > > > -		if (use_softirq && (in_irq() || (exp && !irqs_were_disabled))) {
> > > > +		if (use_softirq && (in_irq() || (expboost && !irqs_were_disabled))) {
> > > >  			// Using softirq, safe to awaken, and either the
> > > > -			// wakeup is free or there is an expedited GP.
> > > > +			// wakeup is free or there is either an expedited
> > > > +			// GP in flight or a potential need to deboost.
> > > 
> > > and this comment will be incorrect, we won't enter here solely because
> > > there is a potential need to deboost.
> > 
> > You are quite right, given the !irqs_were_disabled.
> > 
> > > That said, why the boosting condition has a "irqs_were_disabled" in it?
> > > What if a task gets boosted because of RCU boosting, and exit the RCU
> > > read-side c.s. with irq enabled and there is no expedited GP in flight,
> > > will the task get deboosted quickly enough?
> > 
> > Because if !irqs_were_disabled, there will be a local_bh_enable() or
> > a preempt_enable(), give or take preempt_enable_no_resched(), and those
> > will both get the scheduler involved because of the set_tsk_need_resched()
> > and set_preempt_need_resched().  There is thus no need for the irq_work
> > unless irqs_were_disabled.
> 
> But if so, shouldn't we check !preemp_bh_were_disabled instead of
> irqs_were_disabled? I.e. there is no need for the irq_work unless
> preemption and bottom halves are all enabled (IOW, we cannot expect the
> task to get into scheduler soon via *_enable()).
> 
> Current what we are doing is if irqs_were_disabled is true (along with
> other checks pass), we queue a irq work, but in this situation,
> preept_bh_were_disabled might be true as well, which means there may be
> a preempt_enable() not far away.

Except that the preempt_enable() might be executed before the
local_irq_enable(), in which case the scheduler would not be invoked.

> Consider the following simple example, if we have a in-flight gp or
> this task has been boosted:
> 
> 	preempt_disable();
> 	local_irq_disable();
> 	rcu_read_lock();
> 	...
> 	rcu_read_unlock();
> 	// current we will queue a irq work here.
> 	local_irq_enable();
> 	preempt_enable();
> 	// but we will enter scheduelr here./

And consider this variation:

	preempt_disable();
	local_irq_disable();
	rcu_read_lock();
	...
	rcu_read_unlock();
	// Currently, we will queue a irq work here...
	preempt_enable();
	// ...because we cannot yet enter the scheduler.
	local_irq_enable();
	// Now we can but we won't because no irq_work has been scheduled.

However, the expboost condition is missing one thing, namely strict
grace periods.  It should read as follows:

		expboost = (t->rcu_blocked_node && READ_ONCE(t->rcu_blocked_node->exp_tasks)) ||
			   (rdp->grpmask & READ_ONCE(rnp->expmask)) ||
			   IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD) ||
			   (IS_ENABLED(CONFIG_RCU_BOOST) && irqs_were_disabled &&
			    t->rcu_blocked_node);

Not that this has anything to do with RCU priority boosting, but while
in the area...

							Thanx, Paul

> > I am not all that worried about preempt_enable_no_resched() because
> > it is a problem for RT even in the absence of RCU priority boosting.
> > And the current uses appear to be in things that one would not use while
> > running an RT workload.
> > 
> > > Maybe I'm missing some subtle?
> > 
> > Or maybe I am.  Thoughts?
> > 
> > 							Thanx, Paul
> > 
> > > Regards,
> > > Boqun
> > > 
> > > >  			raise_softirq_irqoff(RCU_SOFTIRQ);
> > > >  		} else {
> > > >  			// Enabling BH or preempt does reschedule, so...
> > > > -			// Also if no expediting, slow is OK.
> > > > -			// Plus nohz_full CPUs eventually get tick enabled.
> > > > +			// Also if no expediting and no possible deboosting,
> > > > +			// slow is OK.  Plus nohz_full CPUs eventually get
> > > > +			// tick enabled.
> > > >  			set_tsk_need_resched(current);
> > > >  			set_preempt_need_resched();
> > > >  			if (IS_ENABLED(CONFIG_IRQ_WORK) && irqs_were_disabled &&
> 
> so the irqs_were_disabled here should be !preempt_bh_were_disabled?
> 
> Regards,
> Boqun
> 
> > > > -			    !rdp->defer_qs_iw_pending && exp && cpu_online(rdp->cpu)) {
> > > > +			    expboost && !rdp->defer_qs_iw_pending && cpu_online(rdp->cpu)) {
> > > >  				// Get scheduler to re-evaluate and call hooks.
> > > >  				// If !IRQ_WORK, FQS scan will eventually IPI.
> > > > -				init_irq_work(&rdp->defer_qs_iw,
> > > > -					      rcu_preempt_deferred_qs_handler);
> > > > +				init_irq_work(&rdp->defer_qs_iw, rcu_preempt_deferred_qs_handler);
> > > >  				rdp->defer_qs_iw_pending = true;
> > > >  				irq_work_queue_on(&rdp->defer_qs_iw, rdp->cpu);
> > > >  			}
> > > > -- 
> > > > 2.9.5
> > > > 
