Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3EA38C8DA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 16:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236434AbhEUOCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 10:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236425AbhEUOCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 10:02:18 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C3EC061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 07:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+CVyZpQMPN6Hk4QivD6RL3Xe++o0/nWICgxY4LUU7Mk=; b=atuB6TY/KUab7LK/oXfPINJMer
        rFdj8QSs7f4ETtyrdtXf6YhPa8AifJ0x1zQ1FaxzBdk03MMqyNAMA1KrXfXawWji+2+b9yuddmZVw
        Nty8tPZDc3FCOFwUorbP75vOTeZp5auGHNDufO1YAftuL8mYRr1mU3NeOoBSuTqi0JOPP16n9HgCE
        +LNNaQHRlkz+/CHIhjjruaktdgBa/b8uzWVsDEd69iu7OQuC+Vbd/+XulJx+w4G7Qn8qGwHd84rDw
        Homw788AhLEvbskhyxuwy7CigC39wsbLBKrkNGrDBwdOxIAb12Uh2MPUQSWFd44vbcygNYss8xjL0
        TO9211tg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lk5hY-005hPh-Ho; Fri, 21 May 2021 14:00:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EC4993001D0;
        Fri, 21 May 2021 16:00:21 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C27D930D63CA2; Fri, 21 May 2021 16:00:21 +0200 (CEST)
Date:   Fri, 21 May 2021 16:00:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Huaixin Chang <changhuaixin@linux.alibaba.com>
Cc:     bsegall@google.com, dietmar.eggemann@arm.com,
        dtcccc@linux.alibaba.com, juri.lelli@redhat.com,
        khlebnikov@yandex-team.ru, linux-kernel@vger.kernel.org,
        mgorman@suse.de, mingo@redhat.com, odin@uged.al, odin@ugedal.com,
        pauld@redhead.com, pjt@google.com, rostedt@goodmis.org,
        shanpeic@linux.alibaba.com, tj@kernel.org,
        vincent.guittot@linaro.org, xiyou.wangcong@gmail.com
Subject: Re: [PATCH v5 1/3] sched/fair: Introduce the burstable CFS controller
Message-ID: <YKe89Uda+uJdx4X0@hirez.programming.kicks-ass.net>
References: <20210520123419.8039-1-changhuaixin@linux.alibaba.com>
 <20210520123419.8039-2-changhuaixin@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210520123419.8039-2-changhuaixin@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 08:34:17PM +0800, Huaixin Chang wrote:
> The CFS bandwidth controller limits CPU requests of a task group to
> quota during each period. However, parallel workloads might be bursty
> so that they get throttled even when their average utilization is under
> quota. And they are latency sensitive at the same time so that
> throttling them is undesired.
> 
> Scaling up period and quota allows greater burst capacity. But it might
> cause longer stuck till next refill. Introduce "burst" to allow
> accumulating unused quota from previous periods, and to be assigned when
> a task group requests more CPU than quota during a specific period.
> 
> Introducing burst buffer might also cause interference to other groups.
> Thus limit the maximum accumulated buffer by "burst", and limit
> the maximum allowed burst by quota, too.

Overall, *much* better than before.

However I would like a little bit better discussion of how exactly
people are supposed to reason about this. That will also help with the
question from Odin on how people are supposed to set/compute this burst
value.

So traditional (UP-EDF) bandwidth control is something like:

  (U = \Sum u_i) <= 1

This guaranteeds both that every deadline is met and that the system is
stable. After all, if U were > 1, then for every second of walltime,
we'd have to run more than a second of program time, and obviously miss
our deadline, but the next deadline will be further out still, there is
never time to catch up, unbounded fail.

This work observes that a workload doesn't always executes the full
quota; this enables one to describe u_i as a statistical distribution.

For example, have u_i = {x,e}_i, where x is the p(95) and x+e p(100)
(the traditional WCET). This effectively allows u to be smaller,
increasing the efficiency (we can pack more tasks in the system), but at
the cost of missing deadlines when all the odds line up. However, it
does maintain stability, since every overrun must be paired with an
underrun as long as our x is above the average.

That is, suppose we have 2 tasks, both specify a p(95) value, then we
have a p(95)*p(95) = 90.25% chance both tasks are within their quota and
everything is good. At the same time we have a p(5)p(5) = 0.25% chance
both tasks will exceed their quota at the same time (guaranteed deadline
fail). Somewhere in between there's a threshold where one exceeds and
the other doesn't underrun enough to compensate; this depends on the
specific CDFs.

At the same time, we can say that the worst case deadline miss, will be
\Sum e_i; that is, there is a bounded tardiness (under the assumption
that x+e is indeed WCET).

And I think you can compute more fun properties.

Now, CFS bandwidth control is not EDF, and the above doesn't fully
translate, but much does I think.

We borrow time now against our future underrun, at the cost of increased
interference against the other system users. All nicely bounded etc..



> Co-developed-by: Shanpei Chen <shanpeic@linux.alibaba.com>
> Signed-off-by: Shanpei Chen <shanpeic@linux.alibaba.com>
> Co-developed-by: Tianchen Ding <dtcccc@linux.alibaba.com>
> Signed-off-by: Tianchen Ding <dtcccc@linux.alibaba.com>
> Signed-off-by: Huaixin Chang <changhuaixin@linux.alibaba.com>
> ---
>  include/linux/sched/sysctl.h |  1 +
>  kernel/sched/core.c          | 83 ++++++++++++++++++++++++++++++++++++--------
>  kernel/sched/fair.c          | 21 ++++++++++-
>  kernel/sched/sched.h         |  1 +
>  kernel/sysctl.c              |  9 +++++
>  5 files changed, 99 insertions(+), 16 deletions(-)
> 
> diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
> index db2c0f34aaaf..08432aeb742e 100644
> --- a/include/linux/sched/sysctl.h
> +++ b/include/linux/sched/sysctl.h
> @@ -73,6 +73,7 @@ extern unsigned int sysctl_sched_uclamp_util_min_rt_default;
>  
>  #ifdef CONFIG_CFS_BANDWIDTH
>  extern unsigned int sysctl_sched_cfs_bandwidth_slice;
> +extern unsigned int sysctl_sched_cfs_bw_burst_enabled;
>  #endif
>  
>  #ifdef CONFIG_SCHED_AUTOGROUP
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 5226cc26a095..7d34b08ee0e5 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -8962,7 +8962,8 @@ static const u64 max_cfs_runtime = MAX_BW * NSEC_PER_USEC;
>  
>  static int __cfs_schedulable(struct task_group *tg, u64 period, u64 runtime);
>  
> -static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota)
> +static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota,
> +				u64 burst)
>  {
>  	int i, ret = 0, runtime_enabled, runtime_was_enabled;
>  	struct cfs_bandwidth *cfs_b = &tg->cfs_bandwidth;
> @@ -8992,6 +8993,10 @@ static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota)
>  	if (quota != RUNTIME_INF && quota > max_cfs_runtime)
>  		return -EINVAL;
>  
> +	if (quota != RUNTIME_INF && (burst > quota ||
> +				     burst + quota > max_cfs_runtime))
> +		return -EINVAL;
> +
>  	/*
>  	 * Prevent race between setting of cfs_rq->runtime_enabled and
>  	 * unthrottle_offline_cfs_rqs().

<snip all API crud>

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 3248e24a90b0..48fad5cf0f7a 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -134,6 +134,13 @@ int __weak arch_asym_cpu_priority(int cpu)
>   * (default: 5 msec, units: microseconds)
>   */
>  unsigned int sysctl_sched_cfs_bandwidth_slice		= 5000UL;
> +
> +/*
> + * A switch for cfs bandwidth burst.
> + *
> + * (default: 1, enabled)
> + */
> +unsigned int sysctl_sched_cfs_bw_burst_enabled = 1;
>  #endif
>  
>  static inline void update_load_add(struct load_weight *lw, unsigned long inc)
> @@ -4628,8 +4635,16 @@ static inline u64 sched_cfs_bandwidth_slice(void)
>   */
>  void __refill_cfs_bandwidth_runtime(struct cfs_bandwidth *cfs_b)
>  {
> -	if (cfs_b->quota != RUNTIME_INF)
> +	if (unlikely(cfs_b->quota == RUNTIME_INF))
> +		return;
> +
> +	if (!sysctl_sched_cfs_bw_burst_enabled) {
>  		cfs_b->runtime = cfs_b->quota;
> +		return;
> +	}
> +
> +	cfs_b->runtime += cfs_b->quota;
> +	cfs_b->runtime = min(cfs_b->runtime, cfs_b->quota + cfs_b->burst);
>  }
>  
>  static inline struct cfs_bandwidth *tg_cfs_bandwidth(struct task_group *tg)
> @@ -4651,6 +4666,9 @@ static int __assign_cfs_rq_runtime(struct cfs_bandwidth *cfs_b,
>  	if (cfs_b->quota == RUNTIME_INF)
>  		amount = min_amount;
>  	else {
> +		if (!cfs_b->period_active)
> +			__refill_cfs_bandwidth_runtime(cfs_b);

Why this call?

>  		start_cfs_bandwidth(cfs_b);
>  
>  		if (cfs_b->runtime > 0) {
> @@ -5279,6 +5297,7 @@ void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
>  	cfs_b->runtime = 0;
>  	cfs_b->quota = RUNTIME_INF;
>  	cfs_b->period = ns_to_ktime(default_cfs_period());
> +	cfs_b->burst = 0;
>  
>  	INIT_LIST_HEAD(&cfs_b->throttled_cfs_rq);
>  	hrtimer_init(&cfs_b->period_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED);
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index a189bec13729..d317ca74a48c 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -366,6 +366,7 @@ struct cfs_bandwidth {
>  	ktime_t			period;
>  	u64			quota;
>  	u64			runtime;
> +	u64			burst;
>  	s64			hierarchical_quota;
>  
>  	u8			idle;
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 14edf84cc571..fb27bae7ace2 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -1816,6 +1816,15 @@ static struct ctl_table kern_table[] = {
>  		.proc_handler	= proc_dointvec_minmax,
>  		.extra1		= SYSCTL_ONE,
>  	},
> +	{
> +		.procname	= "sched_cfs_bw_burst_enabled",
> +		.data		= &sysctl_sched_cfs_bw_burst_enabled,
> +		.maxlen		= sizeof(unsigned int),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec_minmax,
> +		.extra1		= SYSCTL_ZERO,
> +		.extra2		= SYSCTL_ONE,
> +	},
>  #endif
>  #if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
>  	{

What's the purpose of this new sysctl? By default it is disabled because
burst==0, only if you set burst to some !0 value does this actually do
anything.
