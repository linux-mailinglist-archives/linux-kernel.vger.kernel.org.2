Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56141357753
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 00:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbhDGWGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 18:06:51 -0400
Received: from foss.arm.com ([217.140.110.172]:35752 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229793AbhDGWGu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 18:06:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CAD3C1435;
        Wed,  7 Apr 2021 15:06:39 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 44E8F3F792;
        Wed,  7 Apr 2021 15:06:38 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lingutla Chandrasekhar <clingutla@codeaurora.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Quentin Perret <qperret@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Rik van Riel <riel@surriel.com>
Subject: [PATCH v5 1/3] sched/fair: Ignore percpu threads for imbalance pulls
Date:   Wed,  7 Apr 2021 23:06:26 +0100
Message-Id: <20210407220628.3798191-2-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210407220628.3798191-1-valentin.schneider@arm.com>
References: <20210407220628.3798191-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lingutla Chandrasekhar <clingutla@codeaurora.org>

During load balance, LBF_SOME_PINNED will be set if any candidate task
cannot be detached due to CPU affinity constraints. This can result in
setting env->sd->parent->sgc->group_imbalance, which can lead to a group
being classified as group_imbalanced (rather than any of the other, lower
group_type) when balancing at a higher level.

In workloads involving a single task per CPU, LBF_SOME_PINNED can often be
set due to per-CPU kthreads being the only other runnable tasks on any
given rq. This results in changing the group classification during
load-balance at higher levels when in reality there is nothing that can be
done for this affinity constraint: per-CPU kthreads, as the name implies,
don't get to move around (modulo hotplug shenanigans).

It's not as clear for userspace tasks - a task could be in an N-CPU cpuset
with N-1 offline CPUs, making it an "accidental" per-CPU task rather than
an intended one. KTHREAD_IS_PER_CPU gives us an indisputable signal which
we can leverage here to not set LBF_SOME_PINNED.

Note that the aforementioned classification to group_imbalance (when
nothing can be done) is especially problematic on big.LITTLE systems, which
have a topology the likes of:

  DIE [          ]
  MC  [    ][    ]
       0  1  2  3
       L  L  B  B

  arch_scale_cpu_capacity(L) < arch_scale_cpu_capacity(B)

Here, setting LBF_SOME_PINNED due to a per-CPU kthread when balancing at MC
level on CPUs [0-1] will subsequently prevent CPUs [2-3] from classifying
the [0-1] group as group_misfit_task when balancing at DIE level. Thus, if
CPUs [0-1] are running CPU-bound (misfit) tasks, ill-timed per-CPU kthreads
can significantly delay the upgmigration of said misfit tasks. Systems
relying on ASYM_PACKING are likely to face similar issues.

Signed-off-by: Lingutla Chandrasekhar <clingutla@codeaurora.org>
[Use kthread_is_per_cpu() rather than p->nr_cpus_allowed]
[Reword changelog]
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 kernel/sched/fair.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6d73bdbb2d40..04d5e14fa261 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7567,6 +7567,10 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 	if (throttled_lb_pair(task_group(p), env->src_cpu, env->dst_cpu))
 		return 0;
 
+	/* Disregard pcpu kthreads; they are where they need to be. */
+	if ((p->flags & PF_KTHREAD) && kthread_is_per_cpu(p))
+		return 0;
+
 	if (!cpumask_test_cpu(env->dst_cpu, p->cpus_ptr)) {
 		int cpu;
 
-- 
2.25.1

