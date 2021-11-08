Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D491447F31
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 12:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239357AbhKHMCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 07:02:36 -0500
Received: from outbound-smtp50.blacknight.com ([46.22.136.234]:33745 "EHLO
        outbound-smtp50.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231401AbhKHMCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 07:02:35 -0500
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp50.blacknight.com (Postfix) with ESMTPS id 548EEFBDFB
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 11:59:50 +0000 (GMT)
Received: (qmail 14838 invoked from network); 8 Nov 2021 11:59:50 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 8 Nov 2021 11:59:50 -0000
Date:   Mon, 8 Nov 2021 11:59:48 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Srinivasan, Sadagopan" <Sadagopan.Srinivasan@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched/fair: Adjust the allowed NUMA imbalance when
 SD_NUMA spans multiple LLCs
Message-ID: <20211108115948.GH3959@techsingularity.net>
References: <20211028130305.GS3959@techsingularity.net>
 <YYkGkx+Wq6Ol2N9i@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <YYkGkx+Wq6Ol2N9i@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2021 at 12:14:27PM +0100, Peter Zijlstra wrote:
> On Thu, Oct 28, 2021 at 02:03:05PM +0100, Mel Gorman wrote:
> 
> > @@ -1926,8 +1926,8 @@ static void task_numa_find_cpu(struct task_numa_env *env,
> >  		src_running = env->src_stats.nr_running - 1;
> >  		dst_running = env->dst_stats.nr_running + 1;
> >  		imbalance = max(0, dst_running - src_running);
> > -		imbalance = adjust_numa_imbalance(imbalance, dst_running,
> > -							env->dst_stats.weight);
> > +		imbalance = adjust_numa_imbalance(imbalance, env->dst_cpu,
> > +					dst_running, env->dst_stats.weight);
> 
> Can we please align at (0 ?
> 

i.e.
		imbalance = adjust_numa_imbalance(imbalance, env->dst_cpu,
						  dst_running,
						  env->dst_stats.weight);

?

> >  
> >  		/* Use idle CPU if there is no imbalance */
> >  		if (!imbalance) {
> 
> > diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> > index 4e8698e62f07..08fb02510967 100644
> > --- a/kernel/sched/topology.c
> > +++ b/kernel/sched/topology.c
> > @@ -644,6 +644,7 @@ static void destroy_sched_domains(struct sched_domain *sd)
> >  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_llc);
> >  DEFINE_PER_CPU(int, sd_llc_size);
> >  DEFINE_PER_CPU(int, sd_llc_id);
> > +DEFINE_PER_CPU(int, sd_numaimb_shift);
> 
> Why does it make sense for this to be a per-cpu variable? Yes, I suppose
> people can get creative with cpusets, but what you're trying to capture
> seems like a global system propery, no?
> 

I thought things might get weird around CPU hotplug and as llc_size was
tracked per-cpu, I thought it made sense to also do it for
sd_numaimb_shift.

> At most this seems to want to be a sched_domain value.
> 
> >  DEFINE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
> >  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_numa);
> >  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
> > @@ -672,6 +673,20 @@ static void update_top_cache_domain(int cpu)
> >  	sd = lowest_flag_domain(cpu, SD_NUMA);
> >  	rcu_assign_pointer(per_cpu(sd_numa, cpu), sd);
> >  
> > +	/*
> > +	 * Save the threshold where an imbalance is allowed between SD_NUMA
> > +	 * domains. If LLC spans the entire node, then imbalances are allowed
> > +	 * until 25% of the domain is active. Otherwise, allow an imbalance
> > +	 * up to the point where LLCs between NUMA nodes should be balanced
> > +	 * to maximise cache and memory bandwidth utilisation.
> > +	 */
> > +	if (sd) {
> > +		if (sd->span_weight == size)
> > +			per_cpu(sd_numaimb_shift, cpu) = 2;
> > +		else
> > +			per_cpu(sd_numaimb_shift, cpu) = max(2, ilog2(sd->span_weight / size * num_online_nodes()));
> > +	}
> > +
> >  	sd = highest_flag_domain(cpu, SD_ASYM_PACKING);
> >  	rcu_assign_pointer(per_cpu(sd_asym_packing, cpu), sd);
> 
> I think I'm with Valentin here, this seems like something that wants to
> use the sd/sd->child relation.
> 
> That also makes this the wrong place to do things since this is after
> the degenerate code.
> 
> Perhaps this can be done in sd_init(), after all, we build the thing
> bottom-up, so by the time we initialize the NODE, the MC level should
> already be present.
> 
> I'm thinking you can perhaps use something like:
> 
> 	if (!(sd->flags & SD_SHARE_PKG_RESROUCES) &&
> 	    (child->flags & SD_SHARE_PKG_RESOURCES)) {
> 
> 		/* this is the first domain not sharing LLC */
> 		sd->new_magic_imb = /*  magic incantation goes here */
> 	}

Thanks, I'll give it a shot and see what I come up with, it'll probably
take me a few days to clear my table of other crud to focus on it.

-- 
Mel Gorman
SUSE Labs
