Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 869833F2897
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 10:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbhHTIj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 04:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbhHTIj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 04:39:26 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925FBC061575
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 01:38:48 -0700 (PDT)
Date:   Fri, 20 Aug 2021 16:39:34 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1629448724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AgiGf4p0QIHiCPsiPTvGS86g540gUET5shNXobg2xHQ=;
        b=WxriPGmrZzaZ8FJ0iuW+ow7s4NVCyNOPTW5BysfbHcWEOjXM3dksGx3xAaiLPi9rDyVXUe
        BWf8UKbpb7N8J083+Nn9HyDyibv9ZijMEIumzpK1taJes5yNOSpGx5COGtHJXXg9YNjd6v
        6KFgFMQpC5yP5S3tm6Oxf+SCAxu/Zco=
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
        Paul Turner <pjt@google.com>,
        Oleg Rombakh <olegrom@google.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Steve Sistare <steven.sistare@oracle.com>,
        Tejun Heo <tj@kernel.org>, Rik van Riel <riel@surriel.com>,
        linux-kernel@vger.kernel.org, tao.zhou@linux.dev
Subject: Re: [PATCH v3 1/4] sched: cgroup SCHED_IDLE support
Message-ID: <YR9qRta78uYXSva6@geo.homenetwork>
References: <20210820010403.946838-1-joshdon@google.com>
 <20210820010403.946838-2-joshdon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210820010403.946838-2-joshdon@google.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: tao.zhou@linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Josh,

On Thu, Aug 19, 2021 at 06:04:00PM -0700, Josh Don wrote:
> This extends SCHED_IDLE to cgroups.
> 
> Interface: cgroup/cpu.idle.
>  0: default behavior
>  1: SCHED_IDLE
> 
> Extending SCHED_IDLE to cgroups means that we incorporate the existing
> aspects of SCHED_IDLE; a SCHED_IDLE cgroup will count all of its
> descendant threads towards the idle_h_nr_running count of all of its
> ancestor cgroups. Thus, sched_idle_rq() will work properly.
> Additionally, SCHED_IDLE cgroups are configured with minimum weight.
> 
> There are two key differences between the per-task and per-cgroup
> SCHED_IDLE interface:
> 
> - The cgroup interface allows tasks within a SCHED_IDLE hierarchy to
> maintain their relative weights. The entity that is "idle" is the
> cgroup, not the tasks themselves.
> 
> - Since the idle entity is the cgroup, our SCHED_IDLE wakeup preemption
> decision is not made by comparing the current task with the woken task,
> but rather by comparing their matching sched_entity.
> 
> A typical use-case for this is a user that creates an idle and a
> non-idle subtree. The non-idle subtree will dominate competition vs
> the idle subtree, but the idle subtree will still be high priority
> vs other users on the system. The latter is accomplished via comparing
> matching sched_entity in the waken preemption path (this could also be
> improved by making the sched_idle_rq() decision dependent on the
> perspective of a specific task).
> 
> For now, we maintain the existing SCHED_IDLE semantics. Future patches
> may make improvements that extend how we treat SCHED_IDLE entities.
> 
> The per-task_group idle field is an integer that currently only holds
> either a 0 or a 1. This is explicitly typed as an integer to allow for
> further extensions to this API. For example, a negative value may
> indicate a highly latency-sensitive cgroup that should be preferred for
> preemption/placement/etc.
> 
> Signed-off-by: Josh Don <joshdon@google.com>
> ---
> v3:
> - no change from v2
> v2:
> - Use WEIGHT_IDLEPRIO for the idle cgroup weight
> - Add cgroup-v1 support
> 
>  kernel/sched/core.c  |  25 ++++++
>  kernel/sched/debug.c |   3 +
>  kernel/sched/fair.c  | 197 +++++++++++++++++++++++++++++++++++++------
>  kernel/sched/sched.h |   8 ++
>  4 files changed, 208 insertions(+), 25 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 3431939699dc..c1d2227be7c1 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -10195,6 +10195,20 @@ static u64 cpu_rt_period_read_uint(struct cgroup_subsys_state *css,
>  }
>  #endif /* CONFIG_RT_GROUP_SCHED */
>  
> +#ifdef CONFIG_FAIR_GROUP_SCHED
> +static s64 cpu_idle_read_s64(struct cgroup_subsys_state *css,
> +			       struct cftype *cft)
> +{
> +	return css_tg(css)->idle;
> +}
> +
> +static int cpu_idle_write_s64(struct cgroup_subsys_state *css,
> +				struct cftype *cft, s64 idle)
> +{
> +	return sched_group_set_idle(css_tg(css), idle);

	return sched_group_set_idle(css_tg(css), (int)idle);

> +}
> +#endif
> +
>  static struct cftype cpu_legacy_files[] = {
>  #ifdef CONFIG_FAIR_GROUP_SCHED
>  	{
> @@ -10202,6 +10216,11 @@ static struct cftype cpu_legacy_files[] = {
>  		.read_u64 = cpu_shares_read_u64,
>  		.write_u64 = cpu_shares_write_u64,
>  	},
> +	{
> +		.name = "idle",
> +		.read_s64 = cpu_idle_read_s64,
> +		.write_s64 = cpu_idle_write_s64,
> +	},
>  #endif
>  #ifdef CONFIG_CFS_BANDWIDTH
>  	{
> @@ -10409,6 +10428,12 @@ static struct cftype cpu_files[] = {
>  		.read_s64 = cpu_weight_nice_read_s64,
>  		.write_s64 = cpu_weight_nice_write_s64,
>  	},
> +	{
> +		.name = "idle",
> +		.flags = CFTYPE_NOT_ON_ROOT,
> +		.read_s64 = cpu_idle_read_s64,
> +		.write_s64 = cpu_idle_write_s64,
> +	},
>  #endif
>  #ifdef CONFIG_CFS_BANDWIDTH
>  	{
> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> index 7e08e3d947c2..49716228efb4 100644
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -607,6 +607,9 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
>  	SEQ_printf(m, "  .%-30s: %d\n", "nr_spread_over",
>  			cfs_rq->nr_spread_over);
>  	SEQ_printf(m, "  .%-30s: %d\n", "nr_running", cfs_rq->nr_running);
> +	SEQ_printf(m, "  .%-30s: %d\n", "h_nr_running", cfs_rq->h_nr_running);
> +	SEQ_printf(m, "  .%-30s: %d\n", "idle_h_nr_running",
> +			cfs_rq->idle_h_nr_running);
>  	SEQ_printf(m, "  .%-30s: %ld\n", "load", cfs_rq->load.weight);
>  #ifdef CONFIG_SMP
>  	SEQ_printf(m, "  .%-30s: %lu\n", "load_avg",
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index d425d11aa2b8..5aa3cfd15a2e 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -431,6 +431,23 @@ find_matching_se(struct sched_entity **se, struct sched_entity **pse)
>  	}
>  }
>  
> +static int tg_is_idle(struct task_group *tg)
> +{
> +	return tg->idle > 0;
> +}
> +
> +static int cfs_rq_is_idle(struct cfs_rq *cfs_rq)
> +{
> +	return cfs_rq->idle > 0;
> +}
> +
> +static int se_is_idle(struct sched_entity *se)
> +{
> +	if (entity_is_task(se))
> +		return task_has_idle_policy(task_of(se));
> +	return cfs_rq_is_idle(group_cfs_rq(se));
> +}
> +
>  #else	/* !CONFIG_FAIR_GROUP_SCHED */
>  
>  #define for_each_sched_entity(se) \
> @@ -468,6 +485,21 @@ find_matching_se(struct sched_entity **se, struct sched_entity **pse)
>  {
>  }
>  
> +static int tg_is_idle(struct task_group *tg)
> +{
> +	return 0;
> +}
> +
> +static int cfs_rq_is_idle(struct cfs_rq *cfs_rq)
> +{
> +	return 0;
> +}
> +
> +static int se_is_idle(struct sched_entity *se)
> +{
> +	return 0;
> +}
> +
>  #endif	/* CONFIG_FAIR_GROUP_SCHED */
>  
>  static __always_inline
> @@ -4841,6 +4873,9 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
>  
>  		dequeue_entity(qcfs_rq, se, DEQUEUE_SLEEP);
>  
> +		if (cfs_rq_is_idle(group_cfs_rq(se)))
> +			idle_task_delta = cfs_rq->h_nr_running;
> +
>  		qcfs_rq->h_nr_running -= task_delta;
>  		qcfs_rq->idle_h_nr_running -= idle_task_delta;
>  
> @@ -4860,6 +4895,9 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
>  		update_load_avg(qcfs_rq, se, 0);
>  		se_update_runnable(se);
>  
> +		if (cfs_rq_is_idle(group_cfs_rq(se)))
> +			idle_task_delta = cfs_rq->h_nr_running;
> +
>  		qcfs_rq->h_nr_running -= task_delta;
>  		qcfs_rq->idle_h_nr_running -= idle_task_delta;
>  	}
> @@ -4904,39 +4942,45 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
>  	task_delta = cfs_rq->h_nr_running;
>  	idle_task_delta = cfs_rq->idle_h_nr_running;
>  	for_each_sched_entity(se) {
> +		struct cfs_rq *qcfs_rq = cfs_rq_of(se);
> +
>  		if (se->on_rq)
>  			break;
> -		cfs_rq = cfs_rq_of(se);
> -		enqueue_entity(cfs_rq, se, ENQUEUE_WAKEUP);
> +		enqueue_entity(qcfs_rq, se, ENQUEUE_WAKEUP);
> +
> +		if (cfs_rq_is_idle(group_cfs_rq(se)))
> +			idle_task_delta = cfs_rq->h_nr_running;
>  
> -		cfs_rq->h_nr_running += task_delta;
> -		cfs_rq->idle_h_nr_running += idle_task_delta;
> +		qcfs_rq->h_nr_running += task_delta;
> +		qcfs_rq->idle_h_nr_running += idle_task_delta;
>  
>  		/* end evaluation on encountering a throttled cfs_rq */
> -		if (cfs_rq_throttled(cfs_rq))
> +		if (cfs_rq_throttled(qcfs_rq))
>  			goto unthrottle_throttle;
>  	}
>  
>  	for_each_sched_entity(se) {
> -		cfs_rq = cfs_rq_of(se);
> +		struct cfs_rq *qcfs_rq = cfs_rq_of(se);
>  
> -		update_load_avg(cfs_rq, se, UPDATE_TG);
> +		update_load_avg(qcfs_rq, se, UPDATE_TG);
>  		se_update_runnable(se);
>  
> -		cfs_rq->h_nr_running += task_delta;
> -		cfs_rq->idle_h_nr_running += idle_task_delta;
> +		if (cfs_rq_is_idle(group_cfs_rq(se)))
> +			idle_task_delta = cfs_rq->h_nr_running;
>  
> +		qcfs_rq->h_nr_running += task_delta;
> +		qcfs_rq->idle_h_nr_running += idle_task_delta;
>  
>  		/* end evaluation on encountering a throttled cfs_rq */
> -		if (cfs_rq_throttled(cfs_rq))
> +		if (cfs_rq_throttled(qcfs_rq))
>  			goto unthrottle_throttle;
>  
>  		/*
>  		 * One parent has been throttled and cfs_rq removed from the
>  		 * list. Add it back to not break the leaf list.
>  		 */
> -		if (throttled_hierarchy(cfs_rq))
> -			list_add_leaf_cfs_rq(cfs_rq);
> +		if (throttled_hierarchy(qcfs_rq))
> +			list_add_leaf_cfs_rq(qcfs_rq);
>  	}
>  
>  	/* At this point se is NULL and we are at root level*/
> @@ -4949,9 +4993,9 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
>  	 * assertion below.
>  	 */
>  	for_each_sched_entity(se) {
> -		cfs_rq = cfs_rq_of(se);
> +		struct cfs_rq *qcfs_rq = cfs_rq_of(se);
>  
> -		if (list_add_leaf_cfs_rq(cfs_rq))
> +		if (list_add_leaf_cfs_rq(qcfs_rq))
>  			break;
>  	}
>  
> @@ -5574,6 +5618,9 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  		cfs_rq->h_nr_running++;
>  		cfs_rq->idle_h_nr_running += idle_h_nr_running;
>  
> +		if (cfs_rq_is_idle(cfs_rq))
> +			idle_h_nr_running = 1;
> +
>  		/* end evaluation on encountering a throttled cfs_rq */
>  		if (cfs_rq_throttled(cfs_rq))
>  			goto enqueue_throttle;
> @@ -5591,6 +5638,9 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  		cfs_rq->h_nr_running++;
>  		cfs_rq->idle_h_nr_running += idle_h_nr_running;
>  
> +		if (cfs_rq_is_idle(cfs_rq))
> +			idle_h_nr_running = 1;
> +
>  		/* end evaluation on encountering a throttled cfs_rq */
>  		if (cfs_rq_throttled(cfs_rq))
>  			goto enqueue_throttle;
> @@ -5668,6 +5718,9 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  		cfs_rq->h_nr_running--;
>  		cfs_rq->idle_h_nr_running -= idle_h_nr_running;
>  
> +		if (cfs_rq_is_idle(cfs_rq))
> +			idle_h_nr_running = 1;
> +
>  		/* end evaluation on encountering a throttled cfs_rq */
>  		if (cfs_rq_throttled(cfs_rq))
>  			goto dequeue_throttle;
> @@ -5697,6 +5750,9 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  		cfs_rq->h_nr_running--;
>  		cfs_rq->idle_h_nr_running -= idle_h_nr_running;
>  
> +		if (cfs_rq_is_idle(cfs_rq))
> +			idle_h_nr_running = 1;
> +
>  		/* end evaluation on encountering a throttled cfs_rq */
>  		if (cfs_rq_throttled(cfs_rq))
>  			goto dequeue_throttle;
> @@ -7039,24 +7095,22 @@ wakeup_preempt_entity(struct sched_entity *curr, struct sched_entity *se)
>  
>  static void set_last_buddy(struct sched_entity *se)
>  {
> -	if (entity_is_task(se) && unlikely(task_has_idle_policy(task_of(se))))
> -		return;
> -
>  	for_each_sched_entity(se) {
>  		if (SCHED_WARN_ON(!se->on_rq))
>  			return;
> +		if (se_is_idle(se))
> +			return;
>  		cfs_rq_of(se)->last = se;
>  	}
>  }
>  
>  static void set_next_buddy(struct sched_entity *se)
>  {
> -	if (entity_is_task(se) && unlikely(task_has_idle_policy(task_of(se))))
> -		return;
> -
>  	for_each_sched_entity(se) {
>  		if (SCHED_WARN_ON(!se->on_rq))
>  			return;
> +		if (se_is_idle(se))
> +			return;
>  		cfs_rq_of(se)->next = se;
>  	}
>  }
> @@ -7077,6 +7131,7 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
>  	struct cfs_rq *cfs_rq = task_cfs_rq(curr);
>  	int scale = cfs_rq->nr_running >= sched_nr_latency;
>  	int next_buddy_marked = 0;
> +	int cse_is_idle, pse_is_idle;
>  
>  	if (unlikely(se == pse))
>  		return;
> @@ -7121,8 +7176,21 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
>  		return;
>  
>  	find_matching_se(&se, &pse);
> -	update_curr(cfs_rq_of(se));
>  	BUG_ON(!pse);
> +
> +	cse_is_idle = se_is_idle(se);
> +	pse_is_idle = se_is_idle(pse);
> +
> +	/*
> +	 * Preempt an idle group in favor of a non-idle group (and don't preempt
> +	 * in the inverse case).
> +	 */
> +	if (cse_is_idle && !pse_is_idle)
> +		goto preempt;
> +	if (cse_is_idle != pse_is_idle)
> +		return;
> +
> +	update_curr(cfs_rq_of(se));
>  	if (wakeup_preempt_entity(se, pse) == 1) {
>  		/*
>  		 * Bias pick_next to pick the sched entity that is
> @@ -11416,10 +11484,12 @@ void init_tg_cfs_entry(struct task_group *tg, struct cfs_rq *cfs_rq,
>  
>  static DEFINE_MUTEX(shares_mutex);
>  
> -int sched_group_set_shares(struct task_group *tg, unsigned long shares)
> +static int __sched_group_set_shares(struct task_group *tg, unsigned long shares)
>  {
>  	int i;
>  
> +	lockdep_assert_held(&shares_mutex);
> +
>  	/*
>  	 * We can't change the weight of the root cgroup.
>  	 */
> @@ -11428,9 +11498,8 @@ int sched_group_set_shares(struct task_group *tg, unsigned long shares)
>  
>  	shares = clamp(shares, scale_load(MIN_SHARES), scale_load(MAX_SHARES));
>  
> -	mutex_lock(&shares_mutex);
>  	if (tg->shares == shares)
> -		goto done;
> +		return 0;
>  
>  	tg->shares = shares;
>  	for_each_possible_cpu(i) {
> @@ -11448,10 +11517,88 @@ int sched_group_set_shares(struct task_group *tg, unsigned long shares)
>  		rq_unlock_irqrestore(rq, &rf);
>  	}
>  
> -done:
> +	return 0;
> +}
> +
> +int sched_group_set_shares(struct task_group *tg, unsigned long shares)
> +{
> +	int ret;
> +
> +	mutex_lock(&shares_mutex);
> +	if (tg_is_idle(tg))
> +		ret = -EINVAL;
> +	else
> +		ret = __sched_group_set_shares(tg, shares);
> +	mutex_unlock(&shares_mutex);
> +
> +	return ret;
> +}
> +
> +int sched_group_set_idle(struct task_group *tg, long idle)

   int sched_group_set_idle(struct task_group *tg, int idle)

> +{
> +	int i;
> +
> +	if (tg == &root_task_group)
> +		return -EINVAL;
> +
> +	if (idle < 0 || idle > 1)
> +		return -EINVAL;
> +
> +	mutex_lock(&shares_mutex);
> +
> +	if (tg->idle == idle) {
> +		mutex_unlock(&shares_mutex);
> +		return 0;
> +	}
> +
> +	tg->idle = idle;
> +
> +	for_each_possible_cpu(i) {
> +		struct rq *rq = cpu_rq(i);
> +		struct sched_entity *se = tg->se[i];
> +		struct cfs_rq *grp_cfs_rq = tg->cfs_rq[i];
> +		bool was_idle = cfs_rq_is_idle(grp_cfs_rq);
> +		long idle_task_delta;
> +		struct rq_flags rf;
> +
> +		rq_lock_irqsave(rq, &rf);
> +
> +		grp_cfs_rq->idle = idle;
> +		if (WARN_ON_ONCE(was_idle == cfs_rq_is_idle(grp_cfs_rq)))
> +			goto next_cpu;
> +
> +		idle_task_delta = grp_cfs_rq->h_nr_running -
> +				  grp_cfs_rq->idle_h_nr_running;
> +		if (!cfs_rq_is_idle(grp_cfs_rq))
> +			idle_task_delta *= -1;
> +
> +		for_each_sched_entity(se) {
> +			struct cfs_rq *cfs_rq = cfs_rq_of(se);
> +
> +			if (!se->on_rq)
> +				break;
> +
> +			cfs_rq->idle_h_nr_running += idle_task_delta;
> +
> +			/* Already accounted at parent level and above. */
> +			if (cfs_rq_is_idle(cfs_rq))
> +				break;
> +		}
> +
> +next_cpu:
> +		rq_unlock_irqrestore(rq, &rf);
> +	}
> +
> +	/* Idle groups have minimum weight. */
> +	if (tg_is_idle(tg))
> +		__sched_group_set_shares(tg, scale_load(WEIGHT_IDLEPRIO));
> +	else
> +		__sched_group_set_shares(tg, NICE_0_LOAD);
> +
>  	mutex_unlock(&shares_mutex);
>  	return 0;
>  }
> +
>  #else /* CONFIG_FAIR_GROUP_SCHED */
>  
>  void free_fair_sched_group(struct task_group *tg) { }
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index d9f8d73a1d84..8dfad8fb756c 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -396,6 +396,9 @@ struct task_group {
>  	struct cfs_rq		**cfs_rq;
>  	unsigned long		shares;
>  
> +	/* A positive value indicates that this is a SCHED_IDLE group. */
> +	int			idle;
> +
>  #ifdef	CONFIG_SMP
>  	/*
>  	 * load_avg can be heavily contended at clock tick time, so put
> @@ -505,6 +508,8 @@ extern void sched_move_task(struct task_struct *tsk);
>  #ifdef CONFIG_FAIR_GROUP_SCHED
>  extern int sched_group_set_shares(struct task_group *tg, unsigned long shares);
>  
> +extern int sched_group_set_idle(struct task_group *tg, long idle);

   extern int sched_group_set_idle(struct task_group *tg, int idle);

> +
>  #ifdef CONFIG_SMP
>  extern void set_task_rq_fair(struct sched_entity *se,
>  			     struct cfs_rq *prev, struct cfs_rq *next);
> @@ -601,6 +606,9 @@ struct cfs_rq {
>  	struct list_head	leaf_cfs_rq_list;
>  	struct task_group	*tg;	/* group that "owns" this runqueue */
>  
> +	/* Locally cached copy of our task_group's idle value */
> +	int			idle;
> +
>  #ifdef CONFIG_CFS_BANDWIDTH
>  	int			runtime_enabled;
>  	s64			runtime_remaining;
> -- 
> 2.33.0.rc2.250.ged5fa647cd-goog
> 

Cfs_rq and tg define @idle with int type. 
In sched_group_set_idle(..., long idle), @idle is long type.
Use int instead.

But, you filter idle value:

    if (idle < 0 || idle > 1)
    	return -EINVAL;

So, no effect here.. Just @idle can use 4 bytes.



Thanks,
Tao
