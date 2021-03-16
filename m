Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E22F33D829
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 16:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbhCPPup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 11:50:45 -0400
Received: from foss.arm.com ([217.140.110.172]:47624 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237468AbhCPPuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 11:50:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0AD1DD6E;
        Tue, 16 Mar 2021 08:50:19 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D41163F792;
        Tue, 16 Mar 2021 08:50:16 -0700 (PDT)
Subject: Re: [PATCH v3 1/7] sched/fair: Ignore percpu threads for imbalance
 pulls
To:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     Lingutla Chandrasekhar <clingutla@codeaurora.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Quentin Perret <qperret@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Rik van Riel <riel@surriel.com>
References: <20210311120527.167870-1-valentin.schneider@arm.com>
 <20210311120527.167870-2-valentin.schneider@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <bdea6c4f-262b-c3cb-637e-d4896e688dd3@arm.com>
Date:   Tue, 16 Mar 2021 16:49:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210311120527.167870-2-valentin.schneider@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/03/2021 13:05, Valentin Schneider wrote:
> From: Lingutla Chandrasekhar <clingutla@codeaurora.org>
> 
> In load balancing, when balancing group is unable to pull task
> due to ->cpus_ptr constraints from busy group, then it sets
> LBF_SOME_PINNED to lb env flags, as a consequence, sgc->imbalance
> is set for its parent domain level. which makes the group
> classified as imbalance to get help from another balancing cpu.
> 
> Consider a 4-CPU big.LITTLE system with CPUs 0-1 as LITTLEs and

Does it have to be a big.LITTLE system? I assume this issue also happens
on an SMP system.

> CPUs 2-3 as Bigs with below scenario:
> - CPU0 doing newly_idle balancing
> - CPU1 running percpu kworker and RT task (small tasks)

What's the role of the small RT task here in the story?

> - CPU2 running 2 big tasks
> - CPU3 running 1 medium task
> 
> While CPU0 is doing newly_idle load balance at MC level, it fails to
> pull percpu kworker from CPU1 and sets LBF_SOME_PINNED to lb env flag
> and set sgc->imbalance at DIE level domain. As LBF_ALL_PINNED not cleared,
> it tries to redo the balancing by clearing CPU1 in env cpus, but it don't
> find other busiest_group, so CPU0 stops balacing at MC level without
> clearing 'sgc->imbalance' and restart the load balacing at DIE level.
> 
> And CPU0 (balancing cpu) finds LITTLE's group as busiest_group with group
> type as imbalance, and Bigs that classified the level below imbalance type
> would be ignored to pick as busiest, and the balancing would be aborted
> without pulling any tasks (by the time, CPU1 might not have running tasks).
> 
> It is suboptimal decision to classify the group as imbalance due to
> percpu threads. So don't use LBF_SOME_PINNED for per cpu threads.

This sentence mentioned per-cpu threads (and so does the patch name) but
the implementation (only) deals with per-cpu kernel threads. IMHO, it
would be good to align this.

> 
> Signed-off-by: Lingutla Chandrasekhar <clingutla@codeaurora.org>
> [Use kthread_is_per_cpu() rather than p->nr_cpus_allowed]
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> ---
>  kernel/sched/fair.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 2e2ab1e00ef9..83aea97fbf22 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7565,6 +7565,10 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
>  	if (throttled_lb_pair(task_group(p), env->src_cpu, env->dst_cpu))
>  		return 0;
>  
> +	/* Disregard pcpu kthreads; they are where they need to be. */
> +	if ((p->flags & PF_KTHREAD) && kthread_is_per_cpu(p))
> +		return 0;
> +
>  	if (!cpumask_test_cpu(env->dst_cpu, p->cpus_ptr)) {
>  		int cpu;
>  
> 

