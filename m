Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27F4D37686E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 18:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238063AbhEGQJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 12:09:31 -0400
Received: from foss.arm.com ([217.140.110.172]:35078 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236176AbhEGQJ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 12:09:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B0B811B3;
        Fri,  7 May 2021 09:08:26 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 757BF3F73B;
        Fri,  7 May 2021 09:08:24 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Parth Shah <parth@linux.ibm.com>
Subject: Re: [PATCH v2 1/8] sched/fair: Update affine statistics when needed
In-Reply-To: <20210506164543.90688-2-srikar@linux.vnet.ibm.com>
References: <20210506164543.90688-1-srikar@linux.vnet.ibm.com> <20210506164543.90688-2-srikar@linux.vnet.ibm.com>
Date:   Fri, 07 May 2021 17:08:17 +0100
Message-ID: <87sg2yil1q.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/05/21 22:15, Srikar Dronamraju wrote:
> wake_affine_idle() can return prev_cpu. Even in such a scenario,
> scheduler was going ahead and updating schedstats related to wake
> affine. i.e even if the task is not moved across LLC domains,
> schedstats would have accounted.
>
> Hence add a check before updating schedstats.
>

I briefly glanced at the git history but didn't find any proper description
of that stat. As it stands, it counts the number of times wake_affine()
purposedly steered a task towards a particular CPU (waker or wakee's prev),
so nr_wakeups_affine / nr_wakeups_affine_attempts is your wake_affine()
"success rate" - how often could it make a choice with the available data.

I could see a point in only incrementing the count if wake_affine() steers
towards the waker rather than the wakee (i.e. don't increment if choice is
prev), but then that has no link with LLC spans

> Cc: LKML <linux-kernel@vger.kernel.org>
> Cc: Gautham R Shenoy <ego@linux.vnet.ibm.com>
> Cc: Parth Shah <parth@linux.ibm.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Valentin Schneider <valentin.schneider@arm.com>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Rik van Riel <riel@surriel.com>
> Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> ---
>  kernel/sched/fair.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 794c2cb945f8..a258a84cfdfd 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5884,8 +5884,10 @@ static int wake_affine(struct sched_domain *sd, struct task_struct *p,
>       if (target == nr_cpumask_bits)
>               return prev_cpu;
>
> -	schedstat_inc(sd->ttwu_move_affine);
> -	schedstat_inc(p->se.statistics.nr_wakeups_affine);
> +	if (!cpus_share_cache(prev_cpu, target)) {

Per the above, why? Why not just if(target == this_cpu) ?

> +		schedstat_inc(sd->ttwu_move_affine);
> +		schedstat_inc(p->se.statistics.nr_wakeups_affine);
> +	}
>       return target;
>  }
>
> --
> 2.18.2
