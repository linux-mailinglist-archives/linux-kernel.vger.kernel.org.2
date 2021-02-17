Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C13B31DBB6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 15:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233532AbhBQOvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 09:51:17 -0500
Received: from foss.arm.com ([217.140.110.172]:60032 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233016AbhBQOvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 09:51:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 46994ED1;
        Wed, 17 Feb 2021 06:50:30 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E4A993F694;
        Wed, 17 Feb 2021 06:50:28 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Lingutla Chandrasekhar <clingutla@codeaurora.org>,
        linux-kernel@vger.kernel.org
Cc:     juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org,
        pkondeti@codeaurora.org, peterz@infradead.org, mingo@kernel.org,
        Lingutla Chandrasekhar <clingutla@codeaurora.org>
Subject: Re: [PATCH] sched/fair: Ignore percpu threads for imbalance pulls
In-Reply-To: <20210217120854.1280-1-clingutla@codeaurora.org>
References: <20210217120854.1280-1-clingutla@codeaurora.org>
User-Agent: Notmuch/0.21 (http://notmuchmail.org) Emacs/26.3 (x86_64-pc-linux-gnu)
Date:   Wed, 17 Feb 2021 14:50:23 +0000
Message-ID: <jhjim6qsq8g.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/02/21 17:38, Lingutla Chandrasekhar wrote:
> In load balancing, when balancing group is unable to pull task
> due to ->cpus_ptr constraints from busy group, then it sets
> LBF_SOME_PINNED to lb env flags, as a consequence, sgc->imbalance
> is set for its parent domain level. which makes the group
> classified as imbalance to get help from another balancing cpu.
>
> Consider a 4-CPU big.LITTLE system with CPUs 0-1 as LITTLEs and
> CPUs 2-3 as Bigs with below scenario:
> - CPU0 doing newly_idle balancing
> - CPU1 running percpu kworker and RT task (small tasks)
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
>

Sounds like you've stumbled on the same thing I'm trying to fix in

  http://lore.kernel.org/r/20210128183141.28097-8-valentin.schneider@arm.com

(I'm currently working on a v2)

Now, I'd tend to agree that if we could prevent pcpu kworkers from
interfering with load-balance altogether, that would indeed be much
better than trying to deal with the group_imbalanced faff further down the
line (which is what I've been doing).

> Signed-off-by: Lingutla Chandrasekhar <clingutla@codeaurora.org>
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 04a3ce20da67..44a05ad8c96b 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7560,7 +7560,9 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
>  
>  		schedstat_inc(p->se.statistics.nr_failed_migrations_affine);
>  
> -		env->flags |= LBF_SOME_PINNED;
> +		/* Ignore percpu threads for imbalance pulls. */
> +		if (p->nr_cpus_allowed > 1)
> +			env->flags |= LBF_SOME_PINNED;
>  
>  		/*
>  		 * Remember if this task can be migrated to any other CPU in

Unlike user tasks, pcpu kworkers have a stable affinity (with some hotplug
quirks), so perhaps we could do this instead:

---
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8a8bd7b13634..84fca350b9ae 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7539,6 +7539,9 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 	if (throttled_lb_pair(task_group(p), env->src_cpu, env->dst_cpu))
 		return 0;
 
+	if (kthread_is_per_cpu(p))
+		return 0;
+
 	if (!cpumask_test_cpu(env->dst_cpu, p->cpus_ptr)) {
 		int cpu;
 
---

> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
>  a Linux Foundation Collaborative Project.
