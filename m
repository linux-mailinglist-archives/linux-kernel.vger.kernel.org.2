Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3B49357754
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 00:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbhDGWGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 18:06:54 -0400
Received: from foss.arm.com ([217.140.110.172]:35766 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229869AbhDGWGv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 18:06:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 95F0A143B;
        Wed,  7 Apr 2021 15:06:41 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0A76F3F792;
        Wed,  7 Apr 2021 15:06:39 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Quentin Perret <qperret@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Rik van Riel <riel@surriel.com>,
        Lingutla Chandrasekhar <clingutla@codeaurora.org>
Subject: [PATCH v5 2/3] sched/fair: Clean up active balance nr_balance_failed trickery
Date:   Wed,  7 Apr 2021 23:06:27 +0100
Message-Id: <20210407220628.3798191-3-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210407220628.3798191-1-valentin.schneider@arm.com>
References: <20210407220628.3798191-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When triggering an active load balance, sd->nr_balance_failed is set to
such a value that any further can_migrate_task() using said sd will ignore
the output of task_hot().

This behaviour makes sense, as active load balance intentionally preempts a
rq's running task to migrate it right away, but this asynchronous write is
a bit shoddy, as the stopper thread might run active_load_balance_cpu_stop
before the sd->nr_balance_failed write either becomes visible to the
stopper's CPU or even happens on the CPU that appended the stopper work.

Add a struct lb_env flag to denote active balancing, and use it in
can_migrate_task(). Remove the sd->nr_balance_failed write that served the
same purpose. Cleanup the LBF_DST_PINNED active balance special case.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 kernel/sched/fair.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 04d5e14fa261..d8077f82a380 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7422,6 +7422,7 @@ enum migration_type {
 #define LBF_NEED_BREAK	0x02
 #define LBF_DST_PINNED  0x04
 #define LBF_SOME_PINNED	0x08
+#define LBF_ACTIVE_LB	0x10
 
 struct lb_env {
 	struct sched_domain	*sd;
@@ -7583,10 +7584,13 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 		 * our sched_group. We may want to revisit it if we couldn't
 		 * meet load balance goals by pulling other tasks on src_cpu.
 		 *
-		 * Avoid computing new_dst_cpu for NEWLY_IDLE or if we have
-		 * already computed one in current iteration.
+		 * Avoid computing new_dst_cpu
+		 * - for NEWLY_IDLE
+		 * - if we have already computed one in current iteration
+		 * - if it's an active balance
 		 */
-		if (env->idle == CPU_NEWLY_IDLE || (env->flags & LBF_DST_PINNED))
+		if (env->idle == CPU_NEWLY_IDLE ||
+		    env->flags & (LBF_DST_PINNED | LBF_ACTIVE_LB))
 			return 0;
 
 		/* Prevent to re-select dst_cpu via env's CPUs: */
@@ -7611,10 +7615,14 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 
 	/*
 	 * Aggressive migration if:
-	 * 1) destination numa is preferred
-	 * 2) task is cache cold, or
-	 * 3) too many balance attempts have failed.
+	 * 1) active balance
+	 * 2) destination numa is preferred
+	 * 3) task is cache cold, or
+	 * 4) too many balance attempts have failed.
 	 */
+	if (env->flags & LBF_ACTIVE_LB)
+		return 1;
+
 	tsk_cache_hot = migrate_degrades_locality(p, env);
 	if (tsk_cache_hot == -1)
 		tsk_cache_hot = task_hot(p, env);
@@ -9805,9 +9813,6 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 					active_load_balance_cpu_stop, busiest,
 					&busiest->active_balance_work);
 			}
-
-			/* We've kicked active balancing, force task migration. */
-			sd->nr_balance_failed = sd->cache_nice_tries+1;
 		}
 	} else {
 		sd->nr_balance_failed = 0;
@@ -9957,13 +9962,7 @@ static int active_load_balance_cpu_stop(void *data)
 			.src_cpu	= busiest_rq->cpu,
 			.src_rq		= busiest_rq,
 			.idle		= CPU_IDLE,
-			/*
-			 * can_migrate_task() doesn't need to compute new_dst_cpu
-			 * for active balancing. Since we have CPU_IDLE, but no
-			 * @dst_grpmask we need to make that test go away with lying
-			 * about DST_PINNED.
-			 */
-			.flags		= LBF_DST_PINNED,
+			.flags		= LBF_ACTIVE_LB,
 		};
 
 		schedstat_inc(sd->alb_count);
-- 
2.25.1

