Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 304CA356A48
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 12:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233820AbhDGKsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 06:48:16 -0400
Received: from outbound-smtp17.blacknight.com ([46.22.139.234]:47551 "EHLO
        outbound-smtp17.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351434AbhDGKra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 06:47:30 -0400
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp17.blacknight.com (Postfix) with ESMTPS id EA2E21C3867
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 11:47:19 +0100 (IST)
Received: (qmail 13079 invoked from network); 7 Apr 2021 10:47:19 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 7 Apr 2021 10:47:19 -0000
Date:   Wed, 7 Apr 2021 11:47:17 +0100
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
Message-ID: <20210407104717.GD3697@techsingularity.net>
References: <20210321150358.71ef52b1@imladris.surriel.com>
 <20210322110306.GE3697@techsingularity.net>
 <20210326151932.2c187840@imladris.surriel.com>
 <CAKfTPtBvy3Wv=-d5tjrirO3ukBgqV5vM709+_ee+H8LWJsnoLw@mail.gmail.com>
 <1e21aa6ea7de3eae32b29559926d4f0ba5fea130.camel@surriel.com>
 <YG1cfgTH2gj9hxAx@hirez.programming.kicks-ass.net>
 <20210407094106.GC3697@techsingularity.net>
 <YG2GMW0EjsqqnET6@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <YG2GMW0EjsqqnET6@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 12:15:13PM +0200, Peter Zijlstra wrote:
> On Wed, Apr 07, 2021 at 10:41:06AM +0100, Mel Gorman wrote:
> 
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -6112,6 +6112,27 @@ static int select_idle_core(struct task_
> > >  	return -1;
> > >  }
> > >  
> > > +/*
> > > + * Scan the local SMT mask for idle CPUs.
> > > + */
> > > +static int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int target)
> > > +{
> > > +	int cpu;
> > > +
> > > +	if (!static_branch_likely(&sched_smt_present))
> > > +		return -1;
> > > +
> > > +	for_each_cpu(cpu, cpu_smt_mask(target)) {
> > > +		if (!cpumask_test_cpu(cpu, p->cpus_ptr) ||
> > > +		    !cpumask_test_cpu(cpu, sched_domain_span(sd)))
> > > +			continue;
> > 
> > While I know that !cpumask_test_cpu(cpu, sched_domain_span(sd)) was
> > done previously, I found it hard to believe that the test matters. If
> > target/prev share a the LLC domain, why would the SMT siblings *not*
> > share a LLC?
> 
> I think the reason for it is that a cpuset might have split the siblings
> apart and disabled load-balancing across them or something.
> 
> Then the affinity mask can still cross the partition, but we shouldn't
> ever move into it through balancing.

Ok, cpusets do split domains. I can't imagine the logic of splitting SMT
siblings across cpusets but if it's possible, it has to be checked and
protecting that with cpusets_enabled() would be a little overkill and
possibly miss some other corner case :(

Thanks.

-- 
Mel Gorman
SUSE Labs
