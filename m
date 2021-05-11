Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 183C137A615
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 13:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbhEKLxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 07:53:03 -0400
Received: from foss.arm.com ([217.140.110.172]:45994 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230400AbhEKLxC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 07:53:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 53100D6E;
        Tue, 11 May 2021 04:51:56 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB66B3F719;
        Tue, 11 May 2021 04:51:54 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Parth Shah <parth@linux.ibm.com>
Subject: Re: [PATCH v2 1/8] sched/fair: Update affine statistics when needed
In-Reply-To: <20210507170542.GQ2633526@linux.vnet.ibm.com>
References: <20210506164543.90688-1-srikar@linux.vnet.ibm.com> <20210506164543.90688-2-srikar@linux.vnet.ibm.com> <87sg2yil1q.mognet@arm.com> <20210507170542.GQ2633526@linux.vnet.ibm.com>
Date:   Tue, 11 May 2021 12:51:52 +0100
Message-ID: <87sg2t1o9z.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/05/21 22:35, Srikar Dronamraju wrote:
> * Valentin Schneider <valentin.schneider@arm.com> [2021-05-07 17:08:17]:
>
>> On 06/05/21 22:15, Srikar Dronamraju wrote:
>> > wake_affine_idle() can return prev_cpu. Even in such a scenario,
>> > scheduler was going ahead and updating schedstats related to wake
>> > affine. i.e even if the task is not moved across LLC domains,
>> > schedstats would have accounted.
>> >
>> > Hence add a check before updating schedstats.
>> >
>
> Thanks Valentin for taking a look at the patch.
>
>>
>> I briefly glanced at the git history but didn't find any proper description
>> of that stat. As it stands, it counts the number of times wake_affine()
>> purposedly steered a task towards a particular CPU (waker or wakee's prev),
>> so nr_wakeups_affine / nr_wakeups_affine_attempts is your wake_affine()
>> "success rate" - how often could it make a choice with the available data.
>>
>> I could see a point in only incrementing the count if wake_affine() steers
>> towards the waker rather than the wakee (i.e. don't increment if choice is
>> prev), but then that has no link with LLC spans
>
> Lets say if prev CPU and this CPU were part of the same LLC, and the prev
> CPU was busy (or busier than this CPU), should consider this as a wake
> affine? If prev was idle, we would have surely consider prev CPU. Also since
> both are part of same LLC, we cant say this CPU is more affine than prev
> CPU. Or may be I am confusing wake_affine with cache_affine.
>

SD_WAKE_AFFINE says: "Consider waking task on waking CPU.", with that I
read wake_affine() as: "should I place the wakee close to the waker or
close to its previous CPU?". This can be yes or no even if both are in the
same LLC.

>>
>> > Cc: LKML <linux-kernel@vger.kernel.org>
>> > Cc: Gautham R Shenoy <ego@linux.vnet.ibm.com>
>> > Cc: Parth Shah <parth@linux.ibm.com>
>> > Cc: Ingo Molnar <mingo@kernel.org>
>> > Cc: Peter Zijlstra <peterz@infradead.org>
>> > Cc: Valentin Schneider <valentin.schneider@arm.com>
>> > Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
>> > Cc: Mel Gorman <mgorman@techsingularity.net>
>> > Cc: Vincent Guittot <vincent.guittot@linaro.org>
>> > Cc: Rik van Riel <riel@surriel.com>
>> > Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
>> > ---
>> >  kernel/sched/fair.c | 6 ++++--
>> >  1 file changed, 4 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> > index 794c2cb945f8..a258a84cfdfd 100644
>> > --- a/kernel/sched/fair.c
>> > +++ b/kernel/sched/fair.c
>> > @@ -5884,8 +5884,10 @@ static int wake_affine(struct sched_domain *sd, struct task_struct *p,
>> >       if (target == nr_cpumask_bits)
>> >               return prev_cpu;
>> >
>> > -	schedstat_inc(sd->ttwu_move_affine);
>> > -	schedstat_inc(p->se.statistics.nr_wakeups_affine);
>> > +	if (!cpus_share_cache(prev_cpu, target)) {
>>
>> Per the above, why? Why not just if(target == this_cpu) ?
>
> We could use target == this_cpu. However if prev CPU and this CPU share the
> same LLC, then should we consider moving to this_cpu as an affine wakeup?
>

It would make sense if it's a sync wakeup, which wake_affine() does try to
do ATM (regardless of LLC actually, if I'm reading it correctly).
