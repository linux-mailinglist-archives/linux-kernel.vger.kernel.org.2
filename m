Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC53E337209
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 13:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233073AbhCKMGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 07:06:08 -0500
Received: from foss.arm.com ([217.140.110.172]:34084 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233024AbhCKMFo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 07:05:44 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A04DED1;
        Thu, 11 Mar 2021 04:05:44 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B6F0E3F793;
        Thu, 11 Mar 2021 04:05:42 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Qais Yousef <qais.yousef@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Quentin Perret <qperret@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Rik van Riel <riel@surriel.com>,
        Lingutla Chandrasekhar <clingutla@codeaurora.org>
Subject: [PATCH v3 5/7] sched/fair: Employ capacity_greater() throughout load_balance()
Date:   Thu, 11 Mar 2021 12:05:25 +0000
Message-Id: <20210311120527.167870-6-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210311120527.167870-1-valentin.schneider@arm.com>
References: <20210311120527.167870-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While at it, replace group_smaller_{min, max}_cpu_capacity() with
comparisons of the source group's min/max capacity and the destination
CPU's capacity.

Reviewed-by: Qais Yousef <qais.yousef@arm.com>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/fair.c | 33 ++++-----------------------------
 1 file changed, 4 insertions(+), 29 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ddb2ab3edf6d..1e8a242cd1f7 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8350,26 +8350,6 @@ group_is_overloaded(unsigned int imbalance_pct, struct sg_lb_stats *sgs)
 	return false;
 }
 
-/*
- * group_smaller_min_cpu_capacity: Returns true if sched_group sg has smaller
- * per-CPU capacity than sched_group ref.
- */
-static inline bool
-group_smaller_min_cpu_capacity(struct sched_group *sg, struct sched_group *ref)
-{
-	return fits_capacity(sg->sgc->min_capacity, ref->sgc->min_capacity);
-}
-
-/*
- * group_smaller_max_cpu_capacity: Returns true if sched_group sg has smaller
- * per-CPU capacity_orig than sched_group ref.
- */
-static inline bool
-group_smaller_max_cpu_capacity(struct sched_group *sg, struct sched_group *ref)
-{
-	return fits_capacity(sg->sgc->max_capacity, ref->sgc->max_capacity);
-}
-
 static inline enum
 group_type group_classify(unsigned int imbalance_pct,
 			  struct sched_group *group,
@@ -8518,15 +8498,10 @@ static bool update_sd_pick_busiest(struct lb_env *env,
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
 
@@ -8610,7 +8585,7 @@ static bool update_sd_pick_busiest(struct lb_env *env,
 	 */
 	if (sd_has_asym_cpucapacity(env->sd) &&
 	    (sgs->group_type <= group_fully_busy) &&
-	    (group_smaller_min_cpu_capacity(sds->local, sg)))
+	    (capacity_greater(sg->sgc->min_capacity, capacity_of(env->dst_cpu))))
 		return false;
 
 	return true;
@@ -9410,7 +9385,7 @@ static struct rq *find_busiest_queue(struct lb_env *env,
 		 * average load.
 		 */
 		if (sd_has_asym_cpucapacity(env->sd) &&
-		    capacity_of(env->dst_cpu) < capacity &&
+		    !capacity_greater(capacity_of(env->dst_cpu), capacity) &&
 		    nr_running == 1)
 			continue;
 
-- 
2.25.1

