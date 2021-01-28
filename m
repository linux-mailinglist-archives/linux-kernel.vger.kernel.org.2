Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C77FD307E15
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 19:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbhA1Sfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 13:35:36 -0500
Received: from foss.arm.com ([217.140.110.172]:37358 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231446AbhA1Sc6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 13:32:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 72C541478;
        Thu, 28 Jan 2021 10:32:12 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 045203F719;
        Thu, 28 Jan 2021 10:32:10 -0800 (PST)
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
Subject: [PATCH 4/8] sched/fair: Use dst_cpu's capacity rather than group {min, max} capacity
Date:   Thu, 28 Jan 2021 18:31:37 +0000
Message-Id: <20210128183141.28097-5-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210128183141.28097-1-valentin.schneider@arm.com>
References: <20210128183141.28097-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Comparing capacity extrema of local and source sched_group's doesn't make
much sense when at the day of the day the imbalance will be pulled by a
known env->dst_cpu, whose capacity can be anywhere within the local group's
capacity extrema.

Replace group_smaller_{min, max}_cpu_capacity() with comparisons of the
source group's min/max capacity and the destination CPU's capacity.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/fair.c | 31 +++----------------------------
 1 file changed, 3 insertions(+), 28 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 58ce0b22fcb0..0959a770ecc0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8352,26 +8352,6 @@ group_is_overloaded(unsigned int imbalance_pct, struct sg_lb_stats *sgs)
 	return false;
 }
 
-/*
- * group_smaller_min_cpu_capacity: Returns true if sched_group sg has smaller
- * per-CPU capacity than sched_group ref.
- */
-static inline bool
-group_smaller_min_cpu_capacity(struct sched_group *sg, struct sched_group *ref)
-{
-	return capacity_greater(ref->sgc->min_capacity, sg->sgc->min_capacity);
-}
-
-/*
- * group_smaller_max_cpu_capacity: Returns true if sched_group sg has smaller
- * per-CPU capacity_orig than sched_group ref.
- */
-static inline bool
-group_smaller_max_cpu_capacity(struct sched_group *sg, struct sched_group *ref)
-{
-	return capacity_greater(ref->sgc->max_capacity, sg->sgc->max_capacity);
-}
-
 static inline enum
 group_type group_classify(unsigned int imbalance_pct,
 			  struct sched_group *group,
@@ -8523,15 +8503,10 @@ static bool update_sd_pick_busiest(struct lb_env *env,
 	if (!sgs->sum_h_nr_running)
 		return false;
 
-	/*
-	 * Don't try to pull misfit tasks we can't help.
-	 * We can use max_capacity here as reduction in capacity on some
-	 * CPUs in the group should either be possible to resolve
-	 * internally or be covered by avg_load imbalance (eventually).
-	 */
+	/* Don't try to pull misfit tasks we can't help */
 	if (static_branch_unlikely(&sched_asym_cpucapacity) &&
 	    sgs->group_type == group_misfit_task &&
-	    (!group_smaller_max_cpu_capacity(sg, sds->local) ||
+	    (!capacity_greater(capacity_of(env->dst_cpu), sg->sgc->max_capacity) ||
 	     sds->local_stat.group_type != group_has_spare))
 		return false;
 
@@ -8615,7 +8590,7 @@ static bool update_sd_pick_busiest(struct lb_env *env,
 	 */
 	if (sd_has_asym_cpucapacity(env->sd) &&
 	    (sgs->group_type <= group_fully_busy) &&
-	    (group_smaller_min_cpu_capacity(sds->local, sg)))
+	    (capacity_greater(sg->sgc->min_capacity, capacity_of(env->dst_cpu))))
 		return false;
 
 	return true;
-- 
2.27.0

