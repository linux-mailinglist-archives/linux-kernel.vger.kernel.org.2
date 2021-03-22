Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD46344950
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 16:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbhCVPdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 11:33:38 -0400
Received: from outbound-smtp21.blacknight.com ([81.17.249.41]:56298 "EHLO
        outbound-smtp21.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230374AbhCVPdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 11:33:24 -0400
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp21.blacknight.com (Postfix) with ESMTPS id 62152CCCD7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 15:33:22 +0000 (GMT)
Received: (qmail 30621 invoked from network); 22 Mar 2021 15:33:22 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 22 Mar 2021 15:33:22 -0000
Date:   Mon, 22 Mar 2021 15:33:20 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: Re: [PATCH v2] sched/fair: bring back select_idle_smt, but
 differently
Message-ID: <20210322153320.GG3697@techsingularity.net>
References: <20210321150358.71ef52b1@imladris.surriel.com>
 <20210322110306.GE3697@techsingularity.net>
 <982f027e3a91b74cfa93e6fa91e2883d6c2f5dfd.camel@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <982f027e3a91b74cfa93e6fa91e2883d6c2f5dfd.camel@surriel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 11:07:47AM -0400, Rik van Riel wrote:
> > >     The flip side of this is that we see more task migrations
> > > (about
> > >     30% more), higher cache misses, higher memory bandwidth
> > > utilization,
> > >     and higher CPU use, for the same number of requests/second.
> > >     
> > 
> > I am having difficulty with this part and whether this patch affects
> > task
> > migrations in particular.
> 
> Sorry, I should be more clear in the changelog for the
> next version. Task migrations continue to be high with
> this patch applied, but memory bandwidth and L2 cache
> misses go back down, due to better cache locality.
> 

That's completely fine and matches what I expected.

> > >     This is most pronounced on a memcache type workload, which saw

> > >     a consistent 1-3% increase in total CPU use on the system, due
> > >     to those increased task migrations leading to higher L2 cache
> > >     miss numbers, and higher memory utilization. The exclusive L3
> > >     cache on Skylake does us no favors there.
> > >     
> > 
> > Out of curiousity, what is the load generator for memcache or is this
> > based on analysis of a production workload? I ask because mutilate
> > (https://github.com/leverich/mutilate) is allegedly a load generator
> > that can simulate FaceBook patterns but it is old. I would be
> > interested
> > in hearing if mutilate is used and if so, what parameters the load
> > generator is given.
> 
> I had never heard of mutilate, I'll take a look at that.
> 
> I am running systems that get real production queries, but
> at a higher average load than regular production systems.
> Also, the same queries get replicated out to 3 systems on
> the A and B side each, which seems to be enough to factor
> out random noise for this workload.
> 

If you do look into mutilate and can give it a distribution that
approximates the production test then then I'd love to hear the
configuration details so I can put it into mmtests. If that is not feasible
or it's excessively time consuming, don't worry about it.

> > > <SNIP>
> > > +	if (!smt && cpus_share_cache(prev, target)) {
> > > +		/* No idle core. Check if prev has an idle sibling. */
> > > +		i = select_idle_smt(p, sd, prev);
> > > +		if ((unsigned int)i < nr_cpumask_bits)
> > > +			return i;
> > > +	}
> > > +
> > >  	for_each_cpu_wrap(cpu, cpus, target) {
> > >  		if (smt) {
> > >  			i = select_idle_core(p, cpu, cpus, &idle_cpu);
> > 
> > Please consider moving this block within the SIS_PROP && !smt check
> > above. It could become something like
> 
> I'll try that right now. That is a nice cleanup, and
> potential optimization.
> 

Great.

> > Second, select_idle_smt() does not use the cpus mask so consider
> > moving
> > the cpus initialisation after select_idle_smt() has been called.
> > Specifically this initialisation
> > 
> > 	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
> > 
> > Alternatively, clear the bits in the SMT sibling scan to avoid
> > checking
> > the siblings twice. It's a tradeoff because initialising and clearing
> > bits is not free and the cost is wasted if a sibling is free.
> 
> If we're doing that, should we also clear "target" and "prev"
> from the mask?  After all, we might scan those twice with
> the current code...
> 

If trying that, I would put that in a separate patch. At one point
I did play with clearing prev, target and recent but hit problems.
Initialising the mask and clearing them in select_idle_sibling() hurt
the fast path and doing it later was not much better. IIRC, the problem
I hit was that the cost of clearing multiple CPUs before the search was
not offset by gains from a more efficient search.

If I had to guess, simply initialising cpumask after calling
select_idle_smt() will be faster for your particular case because you
have a reasonable expectation that prev's SMT sibling is idle when there
are no idle cores. Checking if prev's sibling is free when there are no
idle cores is fairly cheap in comparison to a cpumask initialisation and
partial clearing.

If you have the testing capacity and time, test both.

> > A third concern, although it is mild, is that the SMT scan ignores
> > the
> > SIS_PROP limits on the depth search. This patch may increase the scan
> > depth as a result. It's only a mild concern as limiting the depth of
> > a
> > search is a magic number anyway. 
> 
> Agreed, placing the search inside the SIS_PROP block is
> going to clip the search differently than placing it
> outside, too.
> 
> Probably no big deal, but I'll push a kernel with
> that change into the tests, anyway :)
> 

Best plan because select_idle_sibling is always surprising :)

-- 
Mel Gorman
SUSE Labs
