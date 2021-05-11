Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9F637A612
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 13:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbhEKLwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 07:52:41 -0400
Received: from foss.arm.com ([217.140.110.172]:45948 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230519AbhEKLwj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 07:52:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AFDA4D6E;
        Tue, 11 May 2021 04:51:32 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 23E3D3F719;
        Tue, 11 May 2021 04:51:31 -0700 (PDT)
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
Subject: Re: [PATCH v2 2/8] sched/fair: Maintain the identity of idle-core
In-Reply-To: <20210506164543.90688-3-srikar@linux.vnet.ibm.com>
References: <20210506164543.90688-1-srikar@linux.vnet.ibm.com> <20210506164543.90688-3-srikar@linux.vnet.ibm.com>
Date:   Tue, 11 May 2021 12:51:26 +0100
Message-ID: <87v97p1oap.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/05/21 22:15, Srikar Dronamraju wrote:
> Scheduler maintains a per LLC info which tells if there is any idle core
> in that LLC. However this information doesn't provide which core is idle.
>
> So when iterating for idle-cores, if select_idle_core() finds an
> idle-core, then it doesn't try to reset this information.
>
> So if there was only one idle core in the LLC and select_idle_core()
> selected the idle-core, the LLC will maintain that it still has a
> idle-core.
>

That would be rectified at the next select_idle_cpu() call, so that would
be a fight between extra instrumentation overhead vs extra work at next
wakeup.

> On the converse, if a task is pinned, and has a restricted
> cpus_allowed_list and LLC has multiple idle-cores, but select_idle_core
> cannot find a idle-core, LLC will no more maintain that it has an
> idle-core.
>

This however does sound icky.

> As a first step to solve this problem, LLC will maintain the identity of
> the idle core instead of just the information that LLC has an idle core
>
> Along with maintaining, this change will solve both the problems listed
> above. However there are other problems that exist with the current
> infrastructure and those will continue to exist with this change and
> would be handled in subsequent patches.
>
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
> @@ -6127,7 +6129,8 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
>  {
>       struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
>       int i, cpu, idle_cpu = -1, nr = INT_MAX;
> -	bool smt = test_idle_cores(target, false);
> +	int idle_core = get_idle_core(target, -1);
> +	bool smt = (idle_core != -1);

test_idle_cores() tells you if there's at least one idle core in the
target's LLC. AFAICT get_idle_core() only tells you whether the target's
core is idle, which is not the same thing.

Note that this code has recently been changed by Rik in

  c722f35b513f ("sched/fair: Bring back select_idle_smt(), but differently")

so as annoying as it is you should probably go try this out / rebase your
series on top of it (as a rule of thumb for core scheduler stuff you should
use https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git -b
tip/sched/core as a base).
