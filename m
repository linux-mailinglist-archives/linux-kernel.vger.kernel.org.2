Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5D46374E94
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 06:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbhEFEa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 00:30:28 -0400
Received: from mga11.intel.com ([192.55.52.93]:58974 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229748AbhEFEa1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 00:30:27 -0400
IronPort-SDR: ahkqBt97W945wynfONz7ZxHGbY4QrTWcn5JtQL5Y6POyn/m+bWQYlasfOG/079sa31FXABYHQZ
 17zRQZBcqtuQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9975"; a="195254725"
X-IronPort-AV: E=Sophos;i="5.82,276,1613462400"; 
   d="scan'208";a="195254725"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2021 21:29:28 -0700
IronPort-SDR: zKc8VwUEo+XZEcRZFCHamf+Ff8talyddBJo0FUhf5BMVgKiXH79m6bMOxkH7DLaC1DRHL3TlJW
 GosgI/4MHdbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,276,1613462400"; 
   d="scan'208";a="464531318"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga002.fm.intel.com with ESMTP; 05 May 2021 21:29:28 -0700
Date:   Wed, 5 May 2021 21:28:44 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.comi>, Mel Gorman <mgorman@suse.de>,
        Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Quentin Perret <qperret@google.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, Aubrey Li <aubrey.li@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH v2 3/4] sched/fair: Consider SMT in ASYM_PACKING load
 balance
Message-ID: <20210506042844.GB3388@ranerica-svr.sc.intel.com>
References: <20210414020436.12980-1-ricardo.neri-calderon@linux.intel.com>
 <20210414020436.12980-4-ricardo.neri-calderon@linux.intel.com>
 <YI/H2dBB5M5da6ba@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YI/H2dBB5M5da6ba@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 03, 2021 at 11:52:25AM +0200, Peter Zijlstra wrote:
> On Tue, Apr 13, 2021 at 07:04:35PM -0700, Ricardo Neri wrote:
> > +static bool cpu_group_is_smt(int cpu, struct sched_group *sg)
> > +{
> > +#ifdef CONFIG_SCHED_SMT
> > +	if (!static_branch_likely(&sched_smt_present))
> > +		return false;
> > +
> > +	if (sg->group_weight == 1)
> > +		return false;
> > +
> > +	return cpumask_equal(sched_group_span(sg), cpu_smt_mask(cpu));
> > +#else
> > +	return false;
> > +#endif
> > +}
> > +
> > +/**
> > + * asym_can_pull_tasks - Check whether the load balancing CPU can pull tasks
> > + * @dst_cpu:	CPU doing the load balancing
> > + * @sds:	Load-balancing data with statistics of the local group
> > + * @sgs:	Load-balancing statistics of the candidate busiest group
> > + * @sg:		The candidate busiet group
> > + *
> > + * Check the state of the SMT siblings of both @sds::local and @sg and decide
> > + * if @dst_cpu can pull tasks. If @dst_cpu does not have SMT siblings, it can
> > + * pull tasks if two or more of the SMT siblings of @sg are busy. If only one
> > + * CPU in @sg is busy, pull tasks only if @dst_cpu has higher priority.
> > + *
> > + * If both @dst_cpu and @sg have SMT siblings. Even the number of idle CPUs
> > + * between @sds::local and @sg. Thus, pull tasks from @sg if the difference
> > + * between the number of busy CPUs is 2 or more. If the difference is of 1,
> > + * only pull if @dst_cpu has higher priority. If @sg does not have SMT siblings
> > + * only pull tasks if all of the SMT siblings of @dst_cpu are idle and @sg
> > + * has lower priority.
> > + */
> > +static bool asym_can_pull_tasks(int dst_cpu, struct sd_lb_stats *sds,
> > +				struct sg_lb_stats *sgs, struct sched_group *sg)
> > +{
> > +#ifdef CONFIG_SCHED_SMT
> > +	int cpu, local_busy_cpus, sg_busy_cpus;
> > +	bool local_is_smt, sg_is_smt;
> > +
> > +	if (!arch_asym_check_smt_siblings())
> > +		return true;
> > +
> > +	cpu = group_first_cpu(sg);
> > +	local_is_smt = cpu_group_is_smt(dst_cpu, sds->local);
> > +	sg_is_smt = cpu_group_is_smt(cpu, sg);
> 
> Would something like this make sense?
> 
> ---
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8533,21 +8533,6 @@ static inline void update_sg_lb_stats(st
>  				sgs->group_capacity;
>  }
>  
> -static bool cpu_group_is_smt(int cpu, struct sched_group *sg)
> -{
> -#ifdef CONFIG_SCHED_SMT
> -	if (!static_branch_likely(&sched_smt_present))
> -		return false;
> -
> -	if (sg->group_weight == 1)
> -		return false;
> -
> -	return cpumask_equal(sched_group_span(sg), cpu_smt_mask(cpu));
> -#else
> -	return false;
> -#endif
> -}
> -
>  /**
>   * asym_can_pull_tasks - Check whether the load balancing CPU can pull tasks
>   * @dst_cpu:	CPU doing the load balancing
> @@ -8578,8 +8563,8 @@ static bool asym_can_pull_tasks(int dst_
>  		return true;
>  
>  	cpu = group_first_cpu(sg);
> -	local_is_smt = cpu_group_is_smt(dst_cpu, sds->local);
> -	sg_is_smt = cpu_group_is_smt(cpu, sg);
> +	local_is_smt = sds->local->flags & SD_SHARE_CPUCAPACITY;
> +	sg_is_smt = sg->flags & SD_SHARE_CPUCAPACITY;
>  
>  	sg_busy_cpus = sgs->group_weight - sgs->idle_cpus;
>  
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1795,6 +1795,7 @@ struct sched_group {
>  	unsigned int		group_weight;
>  	struct sched_group_capacity *sgc;
>  	int			asym_prefer_cpu;	/* CPU of highest priority in group */
> +	int			flags;
>  
>  	/*
>  	 * The CPUs this group covers.
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -916,10 +916,12 @@ build_group_from_child_sched_domain(stru
>  		return NULL;
>  
>  	sg_span = sched_group_span(sg);
> -	if (sd->child)
> +	if (sd->child) {
>  		cpumask_copy(sg_span, sched_domain_span(sd->child));
> -	else
> +		sg->flags = sd->child->flags;
> +	} else {
>  		cpumask_copy(sg_span, sched_domain_span(sd));
> +	}
>  
>  	atomic_inc(&sg->ref);
>  	return sg;
> @@ -1169,6 +1171,7 @@ static struct sched_group *get_group(int
>  	if (child) {
>  		cpumask_copy(sched_group_span(sg), sched_domain_span(child));
>  		cpumask_copy(group_balance_mask(sg), sched_group_span(sg));
> +		sg->flags = child->flags;
>  	} else {
>  		cpumask_set_cpu(cpu, sched_group_span(sg));
>  		cpumask_set_cpu(cpu, group_balance_mask(sg));

Thank you Peter! This code worked well and it looks better than what I
proposed. May I add your Originally-by: and Signed-off-by: tags in a
patch when I post v3?

BR,
Ricardo
