Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A89DA3EADD4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 02:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234477AbhHMAVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 20:21:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:34538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235688AbhHMAVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 20:21:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D2E756101E;
        Fri, 13 Aug 2021 00:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628814045;
        bh=AhxEQkvh3j/yrIJT4nLVABFILcymRNR0YRvhLKiYo3c=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=LegxafWChg3WBP0UI7ETwM58tYyh1Yjl2Qn/KCeV7+W52HIV1+dQPtujbn6nP79Fv
         AnDCGzXM0xjJWceNctU+K75P0k4PJKL1k90mZmcCIbWEBBG5HWK2zm4I6U0w5axCCt
         j6YA1uQqxOr8+/GbPHBypXeNEjQNT1at3rmN5DIHgDPAEutTNx6gvwJEjTwkxYffrw
         eah/879/R32F1HU2ynYMgj5MQcCGjoBUtLwKCq2ghu51pv4XhWLrpaTjBHMiyrShvd
         y4wWAgPgsbZyLsDxFYFJ7vTusaabfSYFDkLrwKOL+/XsbG/FtMLIueBT/6u3QmhpxY
         GGDuh6PKfOATw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A57945C0531; Thu, 12 Aug 2021 17:20:45 -0700 (PDT)
Date:   Thu, 12 Aug 2021 17:20:45 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        rcu@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Steven Price <steven.price@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH v3 3/4] rcu/nocb: Protect NOCB state via local_lock()
 under PREEMPT_RT
Message-ID: <20210813002045.GZ4126399@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210811201354.1976839-1-valentin.schneider@arm.com>
 <20210811201354.1976839-4-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811201354.1976839-4-valentin.schneider@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2021 at 09:13:53PM +0100, Valentin Schneider wrote:
> Warning
> =======
> 
> Running v5.13-rt1 on my arm64 Juno board triggers:
> 
> [    0.156302] =============================
> [    0.160416] WARNING: suspicious RCU usage
> [    0.164529] 5.13.0-rt1 #20 Not tainted
> [    0.168300] -----------------------------
> [    0.172409] kernel/rcu/tree_plugin.h:69 Unsafe read of RCU_NOCB offloaded state!
> [    0.179920]
> [    0.179920] other info that might help us debug this:
> [    0.179920]
> [    0.188037]
> [    0.188037] rcu_scheduler_active = 1, debug_locks = 1
> [    0.194677] 3 locks held by rcuc/0/11:
> [    0.198448] #0: ffff00097ef10cf8 ((softirq_ctrl.lock).lock){+.+.}-{2:2}, at: __local_bh_disable_ip (./include/linux/rcupdate.h:662 kernel/softirq.c:171)
> [    0.208709] #1: ffff80001205e5f0 (rcu_read_lock){....}-{1:2}, at: rt_spin_lock (kernel/locking/spinlock_rt.c:43 (discriminator 4))
> [    0.217134] #2: ffff80001205e5f0 (rcu_read_lock){....}-{1:2}, at: __local_bh_disable_ip (kernel/softirq.c:169)
> [    0.226428]
> [    0.226428] stack backtrace:
> [    0.230889] CPU: 0 PID: 11 Comm: rcuc/0 Not tainted 5.13.0-rt1 #20
> [    0.237100] Hardware name: ARM Juno development board (r0) (DT)
> [    0.243041] Call trace:
> [    0.245497] dump_backtrace (arch/arm64/kernel/stacktrace.c:163)
> [    0.249185] show_stack (arch/arm64/kernel/stacktrace.c:219)
> [    0.252522] dump_stack (lib/dump_stack.c:122)
> [    0.255947] lockdep_rcu_suspicious (kernel/locking/lockdep.c:6439)
> [    0.260328] rcu_rdp_is_offloaded (kernel/rcu/tree_plugin.h:69 kernel/rcu/tree_plugin.h:58)
> [    0.264537] rcu_core (kernel/rcu/tree.c:2332 kernel/rcu/tree.c:2398 kernel/rcu/tree.c:2777)
> [    0.267786] rcu_cpu_kthread (./include/linux/bottom_half.h:32 kernel/rcu/tree.c:2876)
> [    0.271644] smpboot_thread_fn (kernel/smpboot.c:165 (discriminator 3))
> [    0.275767] kthread (kernel/kthread.c:321)
> [    0.279013] ret_from_fork (arch/arm64/kernel/entry.S:1005)
> 
> In this case, this is the RCU core kthread accessing the local CPU's
> rdp. Before that, rcu_cpu_kthread() invokes local_bh_disable().
> 
> Under !CONFIG_PREEMPT_RT (and rcutree.use_softirq=0), this ends up
> incrementing the preempt_count, which satisfies the "local non-preemptible
> read" of rcu_rdp_is_offloaded().
> 
> Under CONFIG_PREEMPT_RT however, this becomes
> 
>   local_lock(&softirq_ctrl.lock)
> 
> which, under the same config, is migrate_disable() + rt_spin_lock(). As
> pointed out by Frederic, this is not sufficient to safely access an rdp's
> offload state, as the RCU core kthread can be preempted by a kworker
> executing rcu_nocb_rdp_offload() [1].
> 
> Introduce a local_lock to serialize an rdp's offload state while the rdp's
> associated core kthread is executing rcu_core().
> 
> rcu_core() preemptability considerations
> ========================================
> 
> As pointed out by Paul [2], keeping rcu_check_quiescent_state() preemptible
> (which is the case under CONFIG_PREEMPT_RT) requires some consideration.
> 
> note_gp_changes() itself runs with irqs off, and enters
> __note_gp_changes() with rnp->lock held (raw_spinlock), thus is safe vs
> preemption.
> 
> rdp->core_needs_qs *could* change after being read by the RCU core
> kthread if it then gets preempted. Consider, with
> CONFIG_RCU_STRICT_GRACE_PERIOD:
> 
>   rcuc/x                                   task_foo
> 
>     rcu_check_quiescent_state()
>     `\
>       rdp->core_needs_qs == true
> 			     <PREEMPT>
> 					   rcu_read_unlock()
> 					   `\
> 					     rcu_preempt_deferred_qs_irqrestore()
> 					     `\
> 					       rcu_report_qs_rdp()
> 					       `\
> 						 rdp->core_needs_qs := false;
> 
> This would let rcuc/x's rcu_check_quiescent_state() proceed further down to
> rcu_report_qs_rdp(), but if task_foo's earlier rcu_report_qs_rdp()
> invocation would have cleared the rdp grpmask from the rnp mask, so
> rcuc/x's invocation would simply bail.
> 
> Since rcu_report_qs_rdp() can be safely invoked, even if rdp->core_needs_qs
> changed, it appears safe to keep rcu_check_quiescent_state() preemptible.

Another concern...

During the preemption of rcu_check_quiescent_state() someone might report
a quiescent state on behalf of CPU x (perhaps due to its having recently
been idle) and then the RCU grace-period kthread might start running on
CPU x, where it might initialize a new grace period in rcu_gp_init().
It can then invoke __note_gp_changes(), also on CPU x.

If preempted as shown above just after checking >core_needs_qs, the
->cpu_no_qs.b.norm field will be set by the grace-period kthread, which
will cause the rcu_check_quiescent_state() function's subsequent check
of ->cpu_no_qs.b.norm to take an early exit.  So OK here.

On the other hand, if preempted just after the rcu_check_quiescent_state()
function's check of ->cpu_no_qs.b.norm, the later invocation of
rcu_report_qs_rdp() should take an early exit due to ->gp_seq mismatch.
So OK here.

However, this should be added to the commit log.  Might be a big commit
log, but mass storage is cheap these days.  ;-)

This needs a review of each and every manipulation of ->core_needs_qs
and ->cpu_no_qs.b.norm.  For example, the preemptions will cause the
scheduler to invoke RCU's context-switch hooks, which also mess with
->cpu_no_qs.b.norm.  I can get to that some time next week (or tomorrow,
if things go better than expected), but it would be good for you (and
others) to check as well.

Frederic should look this over, but I am taking a quick pass in the
meantime.  Please see below.

							Thanx, Paul

> [1]: http://lore.kernel.org/r/20210727230814.GC283787@lothringen
> [2]: http://lore.kernel.org/r/20210729010445.GO4397@paulmck-ThinkPad-P17-Gen-1
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> ---
>  kernel/rcu/tree.c        |  4 ++
>  kernel/rcu/tree.h        |  4 ++
>  kernel/rcu/tree_plugin.h | 82 +++++++++++++++++++++++++++++++++++-----
>  3 files changed, 81 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 51f24ecd94b2..caadfec994f3 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -87,6 +87,7 @@ static DEFINE_PER_CPU_SHARED_ALIGNED(struct rcu_data, rcu_data) = {
>  	.dynticks = ATOMIC_INIT(RCU_DYNTICK_CTRL_CTR),
>  #ifdef CONFIG_RCU_NOCB_CPU
>  	.cblist.flags = SEGCBLIST_SOFTIRQ_ONLY,
> +	.nocb_local_lock =  INIT_LOCAL_LOCK(nocb_local_lock),
>  #endif
>  };
>  static struct rcu_state rcu_state = {
> @@ -2853,10 +2854,12 @@ static void rcu_cpu_kthread(unsigned int cpu)
>  {
>  	unsigned int *statusp = this_cpu_ptr(&rcu_data.rcu_cpu_kthread_status);
>  	char work, *workp = this_cpu_ptr(&rcu_data.rcu_cpu_has_work);
> +	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
>  	int spincnt;
>  
>  	trace_rcu_utilization(TPS("Start CPU kthread@rcu_run"));
>  	for (spincnt = 0; spincnt < 10; spincnt++) {
> +		rcu_nocb_local_lock(rdp);
>  		local_bh_disable();
>  		*statusp = RCU_KTHREAD_RUNNING;
>  		local_irq_disable();
> @@ -2866,6 +2869,7 @@ static void rcu_cpu_kthread(unsigned int cpu)
>  		if (work)
>  			rcu_core();
>  		local_bh_enable();
> +		rcu_nocb_local_unlock(rdp);
>  		if (*workp == 0) {
>  			trace_rcu_utilization(TPS("End CPU kthread@rcu_wait"));
>  			*statusp = RCU_KTHREAD_WAITING;
> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> index 305cf6aeb408..aa6831255fec 100644
> --- a/kernel/rcu/tree.h
> +++ b/kernel/rcu/tree.h
> @@ -210,6 +210,8 @@ struct rcu_data {
>  	struct timer_list nocb_timer;	/* Enforce finite deferral. */
>  	unsigned long nocb_gp_adv_time;	/* Last call_rcu() CB adv (jiffies). */
>  
> +	local_lock_t nocb_local_lock;

Should this go near the beginning of the structure, given that code
paths taking this lock tend to access ->cpu_no_qs, ->core_needs_qs,
and so on?

Given that it is used to protect core processing (not just offloaded
callbacks), might ->core_local_lock be a better name?

Please keep in mind that you can build kernels that offload callbacks
but that still use softirq for RCU core processing.  And vice versa,
that is, kernels that use rcuc kthreads but do not offload callbacks.

> +
>  	/* The following fields are used by call_rcu, hence own cacheline. */
>  	raw_spinlock_t nocb_bypass_lock ____cacheline_internodealigned_in_smp;
>  	struct rcu_cblist nocb_bypass;	/* Lock-contention-bypass CB list. */
> @@ -445,6 +447,8 @@ static void rcu_nocb_unlock(struct rcu_data *rdp);
>  static void rcu_nocb_unlock_irqrestore(struct rcu_data *rdp,
>  				       unsigned long flags);
>  static void rcu_lockdep_assert_cblist_protected(struct rcu_data *rdp);
> +static void rcu_nocb_local_lock(struct rcu_data *rdp);
> +static void rcu_nocb_local_unlock(struct rcu_data *rdp);
>  #ifdef CONFIG_RCU_NOCB_CPU
>  static void __init rcu_organize_nocb_kthreads(void);
>  #define rcu_nocb_lock_irqsave(rdp, flags)				\
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 0ff5e4fb933e..11c4ff00afde 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -21,6 +21,17 @@ static inline int rcu_lockdep_is_held_nocb(struct rcu_data *rdp)
>  	return lockdep_is_held(&rdp->nocb_lock);
>  }
>  
> +static inline int rcu_lockdep_is_held_nocb_local(struct rcu_data *rdp)
> +{
> +	return lockdep_is_held(
> +#ifdef CONFIG_PREEMPT_RT
> +		&rdp->nocb_local_lock.lock
> +#else
> +		&rdp->nocb_local_lock
> +#endif

It would be good if this was abstracted.  Or is this the only place
in the kernel that needs this #ifdef?  Maybe a lockdep_is_held_rt()
or lockdep_is_held_local(), as the case may be?

> +	);
> +}
> +
>  static inline bool rcu_current_is_nocb_kthread(struct rcu_data *rdp)
>  {
>  	/* Race on early boot between thread creation and assignment */
> @@ -38,7 +49,10 @@ static inline int rcu_lockdep_is_held_nocb(struct rcu_data *rdp)
>  {
>  	return 0;
>  }
> -
> +static inline int rcu_lockdep_is_held_nocb_local(struct rcu_data *rdp)
> +{
> +	return 0;

This is backwards of normal lockdep practice, which defaults to locks
always held.  And that will be what happens once lockdep has detected
its first deadlock, correct?  At which point, this function and its
earlier instance will be in conflict.

Or is there some subtle reason why this conflict would be OK?

> +}
>  static inline bool rcu_current_is_nocb_kthread(struct rcu_data *rdp)
>  {
>  	return false;
> @@ -46,23 +60,44 @@ static inline bool rcu_current_is_nocb_kthread(struct rcu_data *rdp)
>  
>  #endif /* #ifdef CONFIG_RCU_NOCB_CPU */
>  
> +/*
> + * Is a local read of the rdp's offloaded state safe and stable?
> + * See rcu_nocb_local_lock() & family.
> + */
> +static inline bool rcu_local_offload_access_safe(struct rcu_data *rdp)
> +{
> +	if (!preemptible())
> +		return true;
> +
> +	if (!migratable()) {
> +		if (!IS_ENABLED(CONFIG_RCU_NOCB))

Do we also need to consult the use_softirq module parameter that controls
whether or not there are rcuc kthreads?

Actually, if !IS_ENABLED(CONFIG_RCU_NOCB) then rcu_rdp_is_offloaded()
can simply return false without bothering with the RCU_LOCKDEP_WARN().
Might be worth getting that out of the way of the RCU_LOCKDEP_WARN()
condition.  ;-)

> +			return true;
> +
> +		return rcu_lockdep_is_held_nocb_local(rdp);
> +	}
> +
> +	return false;
> +}
> +
>  static bool rcu_rdp_is_offloaded(struct rcu_data *rdp)
>  {
>  	/*
> -	 * In order to read the offloaded state of an rdp is a safe
> -	 * and stable way and prevent from its value to be changed
> -	 * under us, we must either hold the barrier mutex, the cpu
> -	 * hotplug lock (read or write) or the nocb lock. Local
> -	 * non-preemptible reads are also safe. NOCB kthreads and
> -	 * timers have their own means of synchronization against the
> -	 * offloaded state updaters.
> +	 * In order to read the offloaded state of an rdp is a safe and stable
> +	 * way and prevent from its value to be changed under us, we must either...
>  	 */
>  	RCU_LOCKDEP_WARN(
> +		// ...hold the barrier mutex...
>  		!(lockdep_is_held(&rcu_state.barrier_mutex) ||
> +		  // ... the cpu hotplug lock (read or write)...
>  		  (IS_ENABLED(CONFIG_HOTPLUG_CPU) && lockdep_is_cpus_held()) ||
> +		  // ... or the NOCB lock.
>  		  rcu_lockdep_is_held_nocb(rdp) ||
> +		  // Local reads still require the local state to remain stable
> +		  // (preemption disabled / local lock held)
>  		  (rdp == this_cpu_ptr(&rcu_data) &&
> -		   !(IS_ENABLED(CONFIG_PREEMPT_COUNT) && preemptible())) ||
> +		   rcu_local_offload_access_safe(rdp)) ||
> +		  // NOCB kthreads and timers have their own means of synchronization
> +		  // against the offloaded state updaters.
>  		  rcu_current_is_nocb_kthread(rdp)),
>  		"Unsafe read of RCU_NOCB offloaded state"
>  	);
> @@ -1629,6 +1664,22 @@ static void rcu_nocb_unlock_irqrestore(struct rcu_data *rdp,
>  	}
>  }
>  
> +/*
> + * The invocation of rcu_core() within the RCU core kthreads remains preemptible
> + * under PREEMPT_RT, thus the offload state of a CPU could change while
> + * said kthreads are preempted. Prevent this from happening by protecting the
> + * offload state with a local_lock().
> + */
> +static void rcu_nocb_local_lock(struct rcu_data *rdp)
> +{
> +	local_lock(&rcu_data.nocb_local_lock);
> +}
> +
> +static void rcu_nocb_local_unlock(struct rcu_data *rdp)
> +{
> +	local_unlock(&rcu_data.nocb_local_lock);
> +}
> +
>  /* Lockdep check that ->cblist may be safely accessed. */
>  static void rcu_lockdep_assert_cblist_protected(struct rcu_data *rdp)
>  {
> @@ -2396,6 +2447,7 @@ static int rdp_offload_toggle(struct rcu_data *rdp,
>  	if (rdp->nocb_cb_sleep)
>  		rdp->nocb_cb_sleep = false;
>  	rcu_nocb_unlock_irqrestore(rdp, flags);
> +	rcu_nocb_local_unlock(rdp);
>  
>  	/*
>  	 * Ignore former value of nocb_cb_sleep and force wake up as it could
> @@ -2427,6 +2479,7 @@ static long rcu_nocb_rdp_deoffload(void *arg)
>  
>  	pr_info("De-offloading %d\n", rdp->cpu);
>  
> +	rcu_nocb_local_lock(rdp);
>  	rcu_nocb_lock_irqsave(rdp, flags);
>  	/*
>  	 * Flush once and for all now. This suffices because we are
> @@ -2509,6 +2562,7 @@ static long rcu_nocb_rdp_offload(void *arg)
>  	 * Can't use rcu_nocb_lock_irqsave() while we are in
>  	 * SEGCBLIST_SOFTIRQ_ONLY mode.
>  	 */
> +	rcu_nocb_local_lock(rdp);
>  	raw_spin_lock_irqsave(&rdp->nocb_lock, flags);

These look plausible at first glance, but it would be good for Frederic
to look at the exact placement of these rcu_nocb_local_lock() and
rcu_nocb_local_unlock() calls.

>  	/*
> @@ -2868,6 +2922,16 @@ static void rcu_nocb_unlock_irqrestore(struct rcu_data *rdp,
>  	local_irq_restore(flags);
>  }
>  
> +/* No ->nocb_local_lock to acquire. */
> +static void rcu_nocb_local_lock(struct rcu_data *rdp)
> +{
> +}
> +
> +/* No ->nocb_local_lock to release. */
> +static void rcu_nocb_local_unlock(struct rcu_data *rdp)
> +{
> +}
> +
>  /* Lockdep check that ->cblist may be safely accessed. */
>  static void rcu_lockdep_assert_cblist_protected(struct rcu_data *rdp)
>  {
> -- 
> 2.25.1
> 
