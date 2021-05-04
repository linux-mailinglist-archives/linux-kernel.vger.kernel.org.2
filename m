Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41A9B3724A7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 05:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbhEDDLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 23:11:22 -0400
Received: from mga03.intel.com ([134.134.136.65]:39234 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229687AbhEDDLP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 23:11:15 -0400
IronPort-SDR: JDvIkcBzSQO6/L+4rTfSayiqWO1XFb7mk6iPINohyOct5bBBVd0UCCjZCr/WhjUzoT6gQDfrmN
 P8GtH4B822Iw==
X-IronPort-AV: E=McAfee;i="6200,9189,9973"; a="197938990"
X-IronPort-AV: E=Sophos;i="5.82,271,1613462400"; 
   d="scan'208";a="197938990"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2021 20:10:20 -0700
IronPort-SDR: ALtm3+A0RtaglugRZfgZOm4P0mLekawNEf6/ItzfA/ii55j4QY6W2tEfj7BXOsodqgNXrKYEYd
 js7BiFrdrVdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,271,1613462400"; 
   d="scan'208";a="450762432"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga004.fm.intel.com with ESMTP; 03 May 2021 20:10:20 -0700
Date:   Mon, 3 May 2021 20:09:37 -0700
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
Message-ID: <20210504030937.GB31635@ranerica-svr.sc.intel.com>
References: <20210414020436.12980-1-ricardo.neri-calderon@linux.intel.com>
 <20210414020436.12980-4-ricardo.neri-calderon@linux.intel.com>
 <YI/KSfWuGLhPnilr@hirez.programming.kicks-ass.net>
 <YI/PKAkjLeaKEXrn@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YI/PKAkjLeaKEXrn@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 03, 2021 at 12:23:36PM +0200, Peter Zijlstra wrote:
> On Mon, May 03, 2021 at 12:02:49PM +0200, Peter Zijlstra wrote:
> > On Tue, Apr 13, 2021 at 07:04:35PM -0700, Ricardo Neri wrote:
> > > @@ -8507,6 +8616,18 @@ static bool update_sd_pick_busiest(struct lb_env *env,
> > >  	if (!sgs->sum_h_nr_running)
> > >  		return false;
> > >  
> > > +	/*
> > > +	 * @sg may have been tentatively classified as group_asym_packing.
> > > +	 * Now that we have sufficient information about @sds.local, reassess
> > > +	 * if asym packing migration can be done. Reclassify @sg. The only
> > > +	 * possible results are group_has_spare and group_fully_busy.
> > > +	 */
> > > +	if (sgs->group_type == group_asym_packing &&
> > > +	    !asym_can_pull_tasks(env->dst_cpu, sds, sgs, sg)) {
> > > +		sgs->group_asym_packing = 0;
> > > +		sgs->group_type = group_classify(env->sd->imbalance_pct, sg, sgs);
> > > +	}
> > 
> > So if this really is all about not having sds.local in
> > update_sd_lb_stats(), then that seems fixable. Let me haz a try.
> 
> How's this then?
> 
> ---
>  kernel/sched/fair.c | 25 ++++++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 3bdc41f22909..e9dcbee5b3d9 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8437,6 +8437,21 @@ group_type group_classify(unsigned int imbalance_pct,
>  	return group_has_spare;
>  }
>  
> +static inline bool
> +sched_asym(struct lb_env *env, struct sd_lb_stats *sds, struct sched_group *group)
> +{
> +	/*
> +	 * Because sd->groups starts with the local group, anything that isn't
> +	 * the local group will have access to the local state.
> +	 */
> +	if (group == sds->local)
> +		return false;
> +
> +	/* XXX do magic here */
> +
> +	return sched_asym_prefer(env->dst_cpu, group->asym_prefer_cpu);
> +}
> +
>  /**
>   * update_sg_lb_stats - Update sched_group's statistics for load balancing.
>   * @env: The load balancing environment.
> @@ -8445,6 +8460,7 @@ group_type group_classify(unsigned int imbalance_pct,
>   * @sg_status: Holds flag indicating the status of the sched_group
>   */
>  static inline void update_sg_lb_stats(struct lb_env *env,
> +				      struct sd_lb_stats *sds,
>  				      struct sched_group *group,
>  				      struct sg_lb_stats *sgs,
>  				      int *sg_status)
> @@ -8453,7 +8469,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>  
>  	memset(sgs, 0, sizeof(*sgs));
>  
> -	local_group = cpumask_test_cpu(env->dst_cpu, sched_group_span(group));
> +	local_group = group == sds->local;
>  
>  	for_each_cpu_and(i, sched_group_span(group), env->cpus) {
>  		struct rq *rq = cpu_rq(i);
> @@ -8498,9 +8514,8 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>  
>  	/* Check if dst CPU is idle and preferred to this group */
>  	if (env->sd->flags & SD_ASYM_PACKING &&
> -	    env->idle != CPU_NOT_IDLE &&
> -	    sgs->sum_h_nr_running &&
> -	    sched_asym_prefer(env->dst_cpu, group->asym_prefer_cpu)) {
> +	    env->idle != CPU_NOT_IDLE && sgs->sum_h_nr_running &&
> +	    sched_asym(env, sds, group)) {
>  		sgs->group_asym_packing = 1;
>  	}
>  
> @@ -9016,7 +9031,7 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
>  				update_group_capacity(env->sd, env->dst_cpu);
>  		}
>  
> -		update_sg_lb_stats(env, sg, sgs, &sg_status);
> +		update_sg_lb_stats(env, sds, sg, sgs, &sg_status);
>  
>  		if (local_group)
>  			goto next_group;

Thanks for the code Peter! Let me give this a try and I will report back
to you.

BR,
Ricardo
