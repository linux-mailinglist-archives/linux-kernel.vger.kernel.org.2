Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5E9531F99E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 14:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbhBSNDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 08:03:24 -0500
Received: from foss.arm.com ([217.140.110.172]:35836 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229998AbhBSNDR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 08:03:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1CF70106F;
        Fri, 19 Feb 2021 05:02:32 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8A4253F73B;
        Fri, 19 Feb 2021 05:02:30 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lingutla Chandrasekhar <clingutla@codeaurora.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Quentin Perret <qperret@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Rik van Riel <riel@surriel.com>
Subject: [PATCH v2 1/7] sched/fair: Ignore percpu threads for imbalance pulls
Date:   Fri, 19 Feb 2021 12:59:57 +0000
Message-Id: <20210219130003.2890-2-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210219130003.2890-1-valentin.schneider@arm.com>
References: <20210219130003.2890-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lingutla Chandrasekhar <clingutla@codeaurora.org>

In load balancing, when balancing group is unable to pull task
due to ->cpus_ptr constraints from busy group, then it sets
LBF_SOME_PINNED to lb env flags, as a consequence, sgc->imbalance
is set for its parent domain level. which makes the group
classified as imbalance to get help from another balancing cpu.

Consider a 4-CPU big.LITTLE system with CPUs 0-1 as LITTLEs and
CPUs 2-3 as Bigs with below scenario:
- CPU0 doing newly_idle balancing
- CPU1 running percpu kworker and RT task (small tasks)
- CPU2 running 2 big tasks
- CPU3 running 1 medium task

While CPU0 is doing newly_idle load balance at MC level, it fails to
pull percpu kworker from CPU1 and sets LBF_SOME_PINNED to lb env flag
and set sgc->imbalance at DIE level domain. As LBF_ALL_PINNED not cleared,
it tries to redo the balancing by clearing CPU1 in env cpus, but it don't
find other busiest_group, so CPU0 stops balacing at MC level without
clearing 'sgc->imbalance' and restart the load balacing at DIE level.

And CPU0 (balancing cpu) finds LITTLE's group as busiest_group with group
type as imbalance, and Bigs that classified the level below imbalance type
would be ignored to pick as busiest, and the balancing would be aborted
without pulling any tasks (by the time, CPU1 might not have running tasks).

It is suboptimal decision to classify the group as imbalance due to
percpu threads. So don't use LBF_SOME_PINNED for per cpu threads.

Signed-off-by: Lingutla Chandrasekhar <clingutla@codeaurora.org>
[Use kthread_is_per_cpu() rather than p->nr_cpus_allowed]
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/fair.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8a8bd7b13634..2d4dcf1a3372 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7539,6 +7539,10 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 	if (throttled_lb_pair(task_group(p), env->src_cpu, env->dst_cpu))
 		return 0;
 
+	/* Disregard pcpu kthreads; they are where they need to be. */
+	if ((p->flags & PF_KTHREAD) && kthread_is_per_cpu(p))
+		return 0;
+
 	if (!cpumask_test_cpu(env->dst_cpu, p->cpus_ptr)) {
 		int cpu;
 
-- 
2.27.0

