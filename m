Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA1A356837
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 11:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234803AbhDGJlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 05:41:21 -0400
Received: from outbound-smtp21.blacknight.com ([81.17.249.41]:56139 "EHLO
        outbound-smtp21.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234442AbhDGJlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 05:41:18 -0400
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp21.blacknight.com (Postfix) with ESMTPS id C911218E007
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 10:41:08 +0100 (IST)
Received: (qmail 15390 invoked from network); 7 Apr 2021 09:41:08 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 7 Apr 2021 09:41:08 -0000
Date:   Wed, 7 Apr 2021 10:41:06 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Rik van Riel <riel@surriel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: Re: [PATCH v3] sched/fair: bring back select_idle_smt, but
 differently
Message-ID: <20210407094106.GC3697@techsingularity.net>
References: <20210321150358.71ef52b1@imladris.surriel.com>
 <20210322110306.GE3697@techsingularity.net>
 <20210326151932.2c187840@imladris.surriel.com>
 <CAKfTPtBvy3Wv=-d5tjrirO3ukBgqV5vM709+_ee+H8LWJsnoLw@mail.gmail.com>
 <1e21aa6ea7de3eae32b29559926d4f0ba5fea130.camel@surriel.com>
 <YG1cfgTH2gj9hxAx@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <YG1cfgTH2gj9hxAx@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 09:17:18AM +0200, Peter Zijlstra wrote:
> Subject: sched/fair: Bring back select_idle_smt(), but differently
> From: Rik van Riel <riel@surriel.com>
> Date: Fri, 26 Mar 2021 15:19:32 -0400
> 
> From: Rik van Riel <riel@surriel.com>
> 
> Mel Gorman did some nice work in 9fe1f127b913 ("sched/fair: Merge
> select_idle_core/cpu()"), resulting in the kernel being more efficient
> at finding an idle CPU, and in tasks spending less time waiting to be
> run, both according to the schedstats run_delay numbers, and according
> to measured application latencies. Yay.
> 
> The flip side of this is that we see more task migrations (about 30%
> more), higher cache misses, higher memory bandwidth utilization, and
> higher CPU use, for the same number of requests/second.
> 
> This is most pronounced on a memcache type workload, which saw a
> consistent 1-3% increase in total CPU use on the system, due to those
> increased task migrations leading to higher L2 cache miss numbers, and
> higher memory utilization. The exclusive L3 cache on Skylake does us
> no favors there.
> 
> On our web serving workload, that effect is usually negligible.
> 
> It appears that the increased number of CPU migrations is generally a
> good thing, since it leads to lower cpu_delay numbers, reflecting the
> fact that tasks get to run faster. However, the reduced locality and
> the corresponding increase in L2 cache misses hurts a little.
> 
> The patch below appears to fix the regression, while keeping the
> benefit of the lower cpu_delay numbers, by reintroducing
> select_idle_smt with a twist: when a socket has no idle cores, check
> to see if the sibling of "prev" is idle, before searching all the
> other CPUs.
> 
> This fixes both the occasional 9% regression on the web serving
> workload, and the continuous 2% CPU use regression on the memcache
> type workload.
> 
> With Mel's patches and this patch together, task migrations are still
> high, but L2 cache misses, memory bandwidth, and CPU time used are
> back down to what they were before. The p95 and p99 response times for
> the memcache type application improve by about 10% over what they were
> before Mel's patches got merged.
> 
> Signed-off-by: Rik van Riel <riel@surriel.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Link: https://lkml.kernel.org/r/20210326151932.2c187840@imladris.surriel.com

I think this is still ok and should not invalidate the previous tests on
v3. While test_idle_cores() was checked on target, as long as target/prev
share cache, the test should be equivalent other than there is a minor
race so

Reviewed-by: Mel Gorman <mgorman@techsingularity.net>

One minor question below though which previously confused me.

> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6112,6 +6112,27 @@ static int select_idle_core(struct task_
>  	return -1;
>  }
>  
> +/*
> + * Scan the local SMT mask for idle CPUs.
> + */
> +static int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int target)
> +{
> +	int cpu;
> +
> +	if (!static_branch_likely(&sched_smt_present))
> +		return -1;
> +
> +	for_each_cpu(cpu, cpu_smt_mask(target)) {
> +		if (!cpumask_test_cpu(cpu, p->cpus_ptr) ||
> +		    !cpumask_test_cpu(cpu, sched_domain_span(sd)))
> +			continue;

While I know that !cpumask_test_cpu(cpu, sched_domain_span(sd)) was
done previously, I found it hard to believe that the test matters. If
target/prev share a the LLC domain, why would the SMT siblings *not*
share a LLC?

-- 
Mel Gorman
SUSE Labs
