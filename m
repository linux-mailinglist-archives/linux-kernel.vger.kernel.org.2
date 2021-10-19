Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D615943324D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 11:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235051AbhJSJgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 05:36:01 -0400
Received: from out1.migadu.com ([91.121.223.63]:51523 "EHLO out1.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235031AbhJSJf6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 05:35:58 -0400
Date:   Tue, 19 Oct 2021 17:34:25 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1634636024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SAh7CIdBjJndJFfSXyQW9oOTL6+56lqvnPcsMgOihRI=;
        b=wmuYmz+lHHeU0jKgkwlaclvCLT539krdujvlmHVNPGt1LdJOuveG8HrHsEAR0+OXOwCatu
        yITk1gSGoPIO6YYPpctl2Jf0hsFD4qezmopkPEfY7OgGCAcWMp2I2kjJvot3XbxKWX5W47
        doSOxMxci1Xuc+/KAeIVWp7mqQI+NYc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Tao Zhou <tao.zhou@linux.dev>
To:     Josh Don <joshdon@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Vineeth Pillai <vineethrp@gmail.com>,
        Hao Luo <haoluo@google.com>, linux-kernel@vger.kernel.org,
        Tao Zhou <tao.zhou@linux.dev>
Subject: Re: [PATCH v2] sched/core: forced idle accounting
Message-ID: <YW6RIXTIOaGQxY/6@geo.homenetwork>
References: <20211018203428.2025792-1-joshdon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211018203428.2025792-1-joshdon@google.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: tao.zhou@linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Josh,

On Mon, Oct 18, 2021 at 01:34:28PM -0700, Josh Don wrote:
> Adds accounting for "forced idle" time, which is time where a cookie'd
> task forces its SMT sibling to idle, despite the presence of runnable
> tasks.
> 
> Forced idle time is one means to measure the cost of enabling core
> scheduling (ie. the capacity lost due to the need to force idle).
> 
> Forced idle time is attributed to the thread responsible for causing the
> forced idle. A few details:
> - Forced idle time is displayed via /proc/PID/sched. It also requires
>   that schedstats is enabled.
> - Forced idle is only accounted when a sibling hyperthread is held
>   idle despite the presence of runnable tasks. No time is charged if
>   a sibling is idle but has no runnable tasks.

This is clear to me now. Last time I am not get this. Thanks.

> - Tasks with 0 cookie are never charged forced idle.
> - For SMT > 2, we scale the amount of forced idle charged based on the
>   number of forced idle siblings. Additionally, we split the time up and
>   evenly charge it to all running tasks, as each is equally responsible
>   for the forced idle.
> 
> Signed-off-by: Josh Don <joshdon@google.com>
> ---
> v2:
> - simplify the SMT>2 case by tracking the forced idle count in pick()
> - added an accounting edge for sched_core_flip()
> 
>  include/linux/sched.h     |  4 ++
>  kernel/sched/core.c       | 82 +++++++++++++++++++++++++++++----------
>  kernel/sched/core_sched.c | 71 ++++++++++++++++++++++++++++++++-
>  kernel/sched/debug.c      |  4 ++
>  kernel/sched/fair.c       |  2 +-
>  kernel/sched/sched.h      | 20 +++++++++-
>  6 files changed, 159 insertions(+), 24 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 96abf9bd3864..ab6d401f367e 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -523,7 +523,11 @@ struct sched_statistics {
>  	u64				nr_wakeups_affine_attempts;
>  	u64				nr_wakeups_passive;
>  	u64				nr_wakeups_idle;
> +
> +#ifdef CONFIG_SCHED_CORE
> +	u64				core_forceidle_sum;
>  #endif
> +#endif /* CONFIG_SCHEDSTATS */
>  } ____cacheline_aligned;
>  
>  struct sched_entity {
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index ada028e579b0..ff49d259bf92 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -144,7 +144,7 @@ static inline bool __sched_core_less(struct task_struct *a, struct task_struct *
>  		return false;
>  
>  	/* flip prio, so high prio is leftmost */
> -	if (prio_less(b, a, task_rq(a)->core->core_forceidle))
> +	if (prio_less(b, a, !!task_rq(a)->core->core_forceidle_count))
>  		return true;
>  
>  	return false;
> @@ -181,15 +181,23 @@ void sched_core_enqueue(struct rq *rq, struct task_struct *p)
>  	rb_add(&p->core_node, &rq->core_tree, rb_sched_core_less);
>  }
>  
> -void sched_core_dequeue(struct rq *rq, struct task_struct *p)
> +void sched_core_dequeue(struct rq *rq, struct task_struct *p, int flags)
>  {
>  	rq->core->core_task_seq++;
>  
> -	if (!sched_core_enqueued(p))
> -		return;
> +	if (sched_core_enqueued(p)) {
> +		rb_erase(&p->core_node, &rq->core_tree);
> +		RB_CLEAR_NODE(&p->core_node);
> +	}
>  
> -	rb_erase(&p->core_node, &rq->core_tree);
> -	RB_CLEAR_NODE(&p->core_node);
> +	/*
> +	 * Migrating the last task off the cpu, with the cpu in forced idle
> +	 * state. Reschedule to create an accounting edge for forced idle,
> +	 * and re-examine whether the core is still in forced idle state.
> +	 */
> +	if (!(flags & DEQUEUE_SAVE) && rq->nr_running == 1 &&
> +	    rq->core->core_forceidle_count && rq->curr == rq->idle)
> +		resched_curr(rq);
>  }
>  
>  /*
> @@ -280,6 +288,8 @@ static void __sched_core_flip(bool enabled)
>  		for_each_cpu(t, smt_mask)
>  			cpu_rq(t)->core_enabled = enabled;
>  
> +		cpu_rq(cpu)->core->core_forceidle_start = 0;
> +
>  		sched_core_unlock(cpu, &flags);
>  
>  		cpumask_andnot(&sched_core_mask, &sched_core_mask, smt_mask);
> @@ -364,7 +374,8 @@ void sched_core_put(void)
>  #else /* !CONFIG_SCHED_CORE */
>  
>  static inline void sched_core_enqueue(struct rq *rq, struct task_struct *p) { }
> -static inline void sched_core_dequeue(struct rq *rq, struct task_struct *p) { }
> +static inline void
> +sched_core_dequeue(struct rq *rq, struct task_struct *p, int flags) { }
>  
>  #endif /* CONFIG_SCHED_CORE */
>  
> @@ -2020,7 +2031,7 @@ static inline void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
>  static inline void dequeue_task(struct rq *rq, struct task_struct *p, int flags)
>  {
>  	if (sched_core_enabled(rq))
> -		sched_core_dequeue(rq, p);
> +		sched_core_dequeue(rq, p, flags);
>  
>  	if (!(flags & DEQUEUE_NOCLOCK))
>  		update_rq_clock(rq);
> @@ -5256,6 +5267,7 @@ void scheduler_tick(void)
>  	if (sched_feat(LATENCY_WARN))
>  		resched_latency = cpu_resched_latency(rq);
>  	calc_global_load_tick(rq);
> +	sched_core_tick(rq);
>  
>  	rq_unlock(rq, &rf);
>  
> @@ -5668,6 +5680,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>  	struct task_struct *next, *p, *max = NULL;
>  	const struct cpumask *smt_mask;
>  	bool fi_before = false;
> +	bool core_clock_updated = (rq == rq->core);
>  	unsigned long cookie;
>  	int i, cpu, occ = 0;
>  	struct rq *rq_i;
> @@ -5720,10 +5733,18 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>  
>  	/* reset state */
>  	rq->core->core_cookie = 0UL;
> -	if (rq->core->core_forceidle) {
> +	if (rq->core->core_forceidle_count) {
> +		if (!core_clock_updated) {
> +			update_rq_clock(rq->core);
> +			core_clock_updated = true;
> +		}
> +		sched_core_account_forceidle(rq);
> +		/* reset after accounting force idle */
> +		rq->core->core_forceidle_start = 0;
> +		rq->core->core_forceidle_count = 0;
> +		rq->core->core_forceidle_occupation = 0;
>  		need_sync = true;
>  		fi_before = true;
> -		rq->core->core_forceidle = false;
>  	}
>  
>  	/*
> @@ -5765,7 +5786,12 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>  	for_each_cpu_wrap(i, smt_mask, cpu) {
>  		rq_i = cpu_rq(i);
>  
> -		if (i != cpu)
> +		/*
> +		 * Current cpu always has its clock updated on entrance to
> +		 * pick_next_task(). If the current cpu is not the core,
> +		 * the core may also have been updated above.
> +		 */

I intercept one sentence from last version's input to make this comment
comprehensive. Hope it will.

  /*
   * Current cpu always has its clock updated on entrance to
   * pick_next_task(). If the current cpu is not the core,
   * the core may also have been updated above. We have to be
   * careful to avoid double update of core rq's clock.
   */

> +		if (i != cpu && (rq_i != rq->core || !core_clock_updated))
>  			update_rq_clock(rq_i);
>  
>  		p = rq_i->core_pick = pick_task(rq_i);
> @@ -5795,7 +5821,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>  
>  		if (p == rq_i->idle) {
>  			if (rq_i->nr_running) {
> -				rq->core->core_forceidle = true;
> +				rq->core->core_forceidle_count++;
>  				if (!fi_before)
>  					rq->core->core_forceidle_seq++;
>  			}
> @@ -5804,6 +5830,12 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>  		}
>  	}
>  
> +	if (rq->core->core_forceidle_count) {
> +		if (cookie)
> +			rq->core->core_forceidle_start = rq_clock(rq->core);
> +		rq->core->core_forceidle_occupation = occ;
> +	}
> +
>  	rq->core->core_pick_seq = rq->core->core_task_seq;
>  	next = rq->core_pick;
>  	rq->core_sched_seq = rq->core->core_pick_seq;
> @@ -5840,8 +5872,8 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>  		 *  1            0       1
>  		 *  1            1       0
>  		 */
> -		if (!(fi_before && rq->core->core_forceidle))
> -			task_vruntime_update(rq_i, rq_i->core_pick, rq->core->core_forceidle);
> +		if (!(fi_before && rq->core->core_forceidle_count))
> +			task_vruntime_update(rq_i, rq_i->core_pick, !!rq->core->core_forceidle_count);
>  
>  		rq_i->core_pick->core_occupation = occ;
>  
> @@ -6045,11 +6077,19 @@ static void sched_core_cpu_deactivate(unsigned int cpu)
>  		goto unlock;
>  
>  	/* copy the shared state to the new leader */
> -	core_rq->core_task_seq      = rq->core_task_seq;
> -	core_rq->core_pick_seq      = rq->core_pick_seq;
> -	core_rq->core_cookie        = rq->core_cookie;
> -	core_rq->core_forceidle     = rq->core_forceidle;
> -	core_rq->core_forceidle_seq = rq->core_forceidle_seq;
> +	core_rq->core_task_seq             = rq->core_task_seq;
> +	core_rq->core_pick_seq             = rq->core_pick_seq;
> +	core_rq->core_cookie               = rq->core_cookie;
> +	core_rq->core_forceidle_count      = rq->core_forceidle_count;
> +	core_rq->core_forceidle_seq        = rq->core_forceidle_seq;
> +	core_rq->core_forceidle_occupation = rq->core_forceidle_occupation;
> +
> +	/*
> +	 * Accounting edge for forced idle is handled in pick_next_task().
> +	 * Don't need another one here, since the hotplug thread shouldn't
> +	 * have a cookie.
> +	 */
> +	core_rq->core_forceidle_start = 0;
>  
>  	/* install new leader */
>  	for_each_cpu(t, smt_mask) {
> @@ -9423,7 +9463,9 @@ void __init sched_init(void)
>  		rq->core_pick = NULL;
>  		rq->core_enabled = 0;
>  		rq->core_tree = RB_ROOT;
> -		rq->core_forceidle = false;
> +		rq->core_forceidle_count = 0;
> +		rq->core_forceidle_occupation = 0;
> +		rq->core_forceidle_start = 0;
>  
>  		rq->core_cookie = 0UL;
>  #endif
> diff --git a/kernel/sched/core_sched.c b/kernel/sched/core_sched.c
> index 48ac72696012..6587c4c409d2 100644
> --- a/kernel/sched/core_sched.c
> +++ b/kernel/sched/core_sched.c
> @@ -73,7 +73,7 @@ static unsigned long sched_core_update_cookie(struct task_struct *p,
>  
>  	enqueued = sched_core_enqueued(p);
>  	if (enqueued)
> -		sched_core_dequeue(rq, p);
> +		sched_core_dequeue(rq, p, DEQUEUE_SAVE);
>  
>  	old_cookie = p->core_cookie;
>  	p->core_cookie = cookie;
> @@ -85,6 +85,10 @@ static unsigned long sched_core_update_cookie(struct task_struct *p,
>  	 * If task is currently running, it may not be compatible anymore after
>  	 * the cookie change, so enter the scheduler on its CPU to schedule it
>  	 * away.
> +	 *
> +	 * Note that it is possible that as a result of this cookie change, the
> +	 * core has now entered/left forced idle state. Defer accounting to the
> +	 * next scheduling edge, rather than always forcing a reschedule here.
>  	 */
>  	if (task_running(rq, p))
>  		resched_curr(rq);
> @@ -228,3 +232,68 @@ int sched_core_share_pid(unsigned int cmd, pid_t pid, enum pid_type type,
>  	return err;
>  }
>  
> +#ifdef CONFIG_SCHEDSTATS
> +
> +/* REQUIRES: rq->core's clock recently updated. */
> +void sched_core_account_forceidle(struct rq *rq)
> +{
> +	const struct cpumask *smt_mask = cpu_smt_mask(cpu_of(rq));
> +	u64 delta, now = rq_clock(rq->core);
> +	struct rq *rq_i;
> +	struct task_struct *p;
> +	int i;
> +
> +	lockdep_assert_rq_held(rq);
> +
> +	WARN_ON_ONCE(!rq->core->core_forceidle_count);
> +
> +	if (rq->core->core_forceidle_start == 0)
> +		return;
> +
> +	delta = now - rq->core->core_forceidle_start;
> +	if (unlikely((s64)delta <= 0))
> +		return;
> +
> +	rq->core->core_forceidle_start = now;
> +
> +	if (!schedstat_enabled())
> +		return;
> +
> +	if (WARN_ON_ONCE(!rq->core->core_forceidle_occupation)) {
> +		/* can't be forced idle without a running task */
> +	} else if (rq->core->core_forceidle_count > 1 ||
> +		   rq->core->core_forceidle_occupation > 1) {

This also except that smt count in last version.

> +		/*
> +		 * For larger SMT configurations, we need to scale the charged
> +		 * forced idle amount since there can be more than one forced
> +		 * idle sibling and more than one running cookied task.
> +		 */
> +		delta *= rq->core->core_forceidle_count;
> +		delta = div_u64(delta, rq->core->core_forceidle_occupation);
> +	}
> +
> +	for_each_cpu(i, smt_mask) {
> +		rq_i = cpu_rq(i);
> +		p = rq_i->core_pick ?: rq_i->curr;
> +
> +		if (!p->core_cookie)
> +			continue;
> +
> +		__schedstat_add(p->stats.core_forceidle_sum, delta);
> +	}
> +}
> +
> +void sched_core_tick(struct rq *rq)
> +{
> +	if (!sched_core_enabled(rq))
> +		return;
> +
> +	if (!rq->core->core_forceidle_count)
> +		return;
> +
> +	if (rq != rq->core)
> +		update_rq_clock(rq->core);
> +	sched_core_account_forceidle(rq);
> +}
> +
> +#endif /* CONFIG_SCHEDSTATS */
> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> index 7dcbaa31c5d9..aa29211de1bf 100644
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -1023,6 +1023,10 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
>  
>  		__PN(avg_atom);
>  		__PN(avg_per_cpu);
> +
> +#ifdef CONFIG_SCHED_CORE
> +		PN_SCHEDSTAT(core_forceidle_sum);
> +#endif
>  	}
>  
>  	__P(nr_switches);
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 87db481e8a56..da3a6732ddac 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -11047,7 +11047,7 @@ static inline void task_tick_core(struct rq *rq, struct task_struct *curr)
>  	 * MIN_NR_TASKS_DURING_FORCEIDLE - 1 tasks and use that to check
>  	 * if we need to give up the CPU.
>  	 */
> -	if (rq->core->core_forceidle && rq->cfs.nr_running == 1 &&
> +	if (rq->core->core_forceidle_count && rq->cfs.nr_running == 1 &&
>  	    __entity_slice_used(&curr->se, MIN_NR_TASKS_DURING_FORCEIDLE))
>  		resched_curr(rq);
>  }
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index a00fc7057d97..fb7c9e3f2787 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1111,8 +1111,10 @@ struct rq {
>  	unsigned int		core_task_seq;
>  	unsigned int		core_pick_seq;
>  	unsigned long		core_cookie;
> -	unsigned char		core_forceidle;
> +	unsigned int		core_forceidle_count;
>  	unsigned int		core_forceidle_seq;
> +	unsigned int		core_forceidle_occupation;
> +	u64			core_forceidle_start;
>  #endif
>  };
>  
> @@ -1253,7 +1255,7 @@ static inline bool sched_core_enqueued(struct task_struct *p)
>  }
>  
>  extern void sched_core_enqueue(struct rq *rq, struct task_struct *p);
> -extern void sched_core_dequeue(struct rq *rq, struct task_struct *p);
> +extern void sched_core_dequeue(struct rq *rq, struct task_struct *p, int flags);
>  
>  extern void sched_core_get(void);
>  extern void sched_core_put(void);
> @@ -1302,6 +1304,20 @@ static inline bool sched_group_cookie_match(struct rq *rq,
>  }
>  #endif /* CONFIG_SCHED_CORE */
>  
> +#if defined(CONFIG_SCHED_CORE) && defined(CONFIG_SCHEDSTATS)
> +
> +extern void sched_core_account_forceidle(struct rq *rq);
> +
> +extern void sched_core_tick(struct rq *rq);
> +
> +#else
> +
> +static inline void sched_core_account_forceidle(struct rq *rq) {}
> +
> +static inline void sched_core_tick(struct rq *rq) {}
> +
> +#endif /* CONFIG_SCHED_CORE && CONFIG_SCHEDSTATS */
> +
>  static inline void lockdep_assert_rq_held(struct rq *rq)
>  {
>  	lockdep_assert_held(__rq_lockp(rq));
> -- 
> 2.33.0.1079.g6e70778dc9-goog
> 


Thanks,
Tao
