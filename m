Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5667D307E14
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 19:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbhA1SfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 13:35:08 -0500
Received: from foss.arm.com ([217.140.110.172]:37346 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232138AbhA1Sc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 13:32:56 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C3E101474;
        Thu, 28 Jan 2021 10:32:10 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 58F2F3F719;
        Thu, 28 Jan 2021 10:32:09 -0800 (PST)
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
Subject: [PATCH 3/8] sched/fair: Tweak misfit-related capacity checks
Date:   Thu, 28 Jan 2021 18:31:36 +0000
Message-Id: <20210128183141.28097-4-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210128183141.28097-1-valentin.schneider@arm.com>
References: <20210128183141.28097-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During load-balance, groups classified as group_misfit_task are filtered
out if they do not pass

  group_smaller_max_cpu_capacity(<candidate group>, <local group>);

which itself employs fits_capacity() to compare the sgc->max_capacity of
both groups.

Due to the underlying margin, fits_capacity(X, 1024) will return false for
any X > 819. Tough luck, the capacity_orig's on e.g. the Pixel 4 are
{261, 871, 1024}. If a CPU-bound task ends up on one of those "medium"
CPUs, misfit migration will never intentionally upmigrate it to a CPU of
higher capacity due to the aforementioned margin.

One may argue the 20% margin of fits_capacity() is excessive in the advent
of counter-enhanced load tracking (APERF/MPERF, AMUs), but one point here
is that fits_capacity() is meant to compare a utilization value to a
capacity value, whereas here it is being used to compare two capacity
values. As CPU capacity and task utilization have different dynamics, a
sensible approach here would be to add a new helper dedicated to comparing
CPU capacities.

Introduce capacity_greater(), which uses a 5% margin. Use it to replace the
existing capacity checks. Note that check_cpu_capacity() uses yet another
margin (sd->imbalance_pct), and is left alone for now.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/fair.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7d01fa0bfc7e..58ce0b22fcb0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -113,6 +113,13 @@ int __weak arch_asym_cpu_priority(int cpu)
  */
 #define fits_capacity(cap, max)	((cap) * 1280 < (max) * 1024)
 
+/*
+ * The margin used when comparing CPU capacities.
+ * is 'cap' noticeably greater than 'ref'
+ *
+ * (default: ~5%)
+ */
+#define capacity_greater(cap, ref) ((ref) * 1078 < (cap) * 1024)
 #endif
 
 #ifdef CONFIG_CFS_BANDWIDTH
@@ -8253,7 +8260,7 @@ check_cpu_capacity(struct rq *rq, struct sched_domain *sd)
 static inline int check_misfit_status(struct rq *rq, struct sched_domain *sd)
 {
 	return rq->misfit_task_load &&
-		(rq->cpu_capacity_orig < rq->rd->max_cpu_capacity ||
+		(capacity_greater(rq->rd->max_cpu_capacity, rq->cpu_capacity_orig) ||
 		 check_cpu_capacity(rq, sd));
 }
 
@@ -8352,7 +8359,7 @@ group_is_overloaded(unsigned int imbalance_pct, struct sg_lb_stats *sgs)
 static inline bool
 group_smaller_min_cpu_capacity(struct sched_group *sg, struct sched_group *ref)
 {
-	return fits_capacity(sg->sgc->min_capacity, ref->sgc->min_capacity);
+	return capacity_greater(ref->sgc->min_capacity, sg->sgc->min_capacity);
 }
 
 /*
@@ -8362,7 +8369,7 @@ group_smaller_min_cpu_capacity(struct sched_group *sg, struct sched_group *ref)
 static inline bool
 group_smaller_max_cpu_capacity(struct sched_group *sg, struct sched_group *ref)
 {
-	return fits_capacity(sg->sgc->max_capacity, ref->sgc->max_capacity);
+	return capacity_greater(ref->sgc->max_capacity, sg->sgc->max_capacity);
 }
 
 static inline enum
@@ -9421,7 +9428,7 @@ static struct rq *find_busiest_queue(struct lb_env *env,
 		 * average load.
 		 */
 		if (sd_has_asym_cpucapacity(env->sd) &&
-		    capacity_of(env->dst_cpu) < capacity &&
+		    !capacity_greater(capacity_of(env->dst_cpu), capacity) &&
 		    nr_running == 1)
 			continue;
 
-- 
2.27.0

