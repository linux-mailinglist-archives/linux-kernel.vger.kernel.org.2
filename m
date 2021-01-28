Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0247307E45
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 19:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbhA1Sk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 13:40:59 -0500
Received: from foss.arm.com ([217.140.110.172]:37446 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232151AbhA1SfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 13:35:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D11814FF;
        Thu, 28 Jan 2021 10:32:17 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F37533F719;
        Thu, 28 Jan 2021 10:32:15 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Quentin Perret <qperret@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Rik van Riel <riel@surriel.com>
Subject: [PATCH 7/8] sched/fair: Attempt misfit active balance when migration_type != migrate_misfit
Date:   Thu, 28 Jan 2021 18:31:40 +0000
Message-Id: <20210128183141.28097-8-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210128183141.28097-1-valentin.schneider@arm.com>
References: <20210128183141.28097-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Consider a 4-CPU big.LITTLE system with CPUs 0-1 as LITTLEs and CPUs 2-3 as
bigs. The resulting sched_domain hierarchy is:

  DIE [          ]
  MC  [    ][    ]
       0  1  2  3

When running a multithreaded CPU-bound workload (i.e. 1 hog per CPU), the
expected behaviour is to have the about-to-idle big CPUs pull a hog from
the LITTLEs, since bigs will complete their work sooner than LITTLEs.

Further Consider a scenario where:
- CPU0 is idle (e.g. its hog got migrated to one of the big CPUs)
- CPU1 is currently executing a per-CPU kworker, preempting the CPU hog
- CPU2 and CPU3 are executing CPU-hogs

CPU0 goes through load_balance() at MC level, and tries to pick stuff from
CPU1, but:
- the hog can't be pulled, because it's task_hot()
- the kworker can't be pulled, because it's pinned to CPU1, which sets
  LBF_SOME_PINNED

This load balance attempts ends with no load pulled, LBF_SOME_PINNED set,
and as a consequence we set the imbalance flag of DIE's [0, 1]
sched_group_capacity.

Shortly after, CPU2 completes its work and is about to go idle. It goes
through the newidle_balance(), and we would really like it to active
balance the hog running on CPU1 (which is a misfit task). However,
sgc->imbalance is set for the LITTLE group at DIE level, so the group gets
classified as group_imbalanced rather than group_misfit_task.

Unlike group_misfit_task (via migrate_misfit), the active balance logic
doesn't have any specific case for group_imbalanced, so CPU2 ends up going
idle. We'll have to wait for a load balance on CPU0 or CPU1 to happen and
clear the imbalance flag, and then for another DIE-level load-balance on
CPU2 to happen to pull the task off of CPU1. That's several precious
milliseconds wasted down the drain.

Giving group_misfit_task a higher group_classify() priority than
group_imbalance doesn't seem like the right thing to do. Instead, make
need_active_balance() return true for any migration_type when the
destination CPU is idle and the source CPU has a misfit task.

While at it, add an sd_has_asym_cpucapacity() guard in
need_active_balance().

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/fair.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0ac2f876b86f..cba9f97d9beb 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9557,9 +9557,22 @@ static int need_active_balance(struct lb_env *env)
 			return 1;
 	}
 
+	if (!sd_has_asym_cpucapacity(sd))
+		return 0;
+
 	if (env->migration_type == migrate_misfit)
 		return 1;
 
+	/*
+	 * If we failed to pull anything and the src_rq has a misfit task, but
+	 * the busiest group_type was higher than group_misfit_task, try to
+	 * go for a misfit active balance anyway.
+	 */
+	if ((env->idle != CPU_NOT_IDLE) &&
+	    env->src_rq->misfit_task_load &&
+	    cpu_capacity_greater(env->dst_cpu, env->src_cpu))
+		return 1;
+
 	return 0;
 }
 
-- 
2.27.0

