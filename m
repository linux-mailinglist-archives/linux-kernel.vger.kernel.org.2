Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC88D40745E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 03:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235221AbhIKBVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 21:21:12 -0400
Received: from mga18.intel.com ([134.134.136.126]:21358 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235062AbhIKBUV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 21:20:21 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10103"; a="208325820"
X-IronPort-AV: E=Sophos;i="5.85,284,1624345200"; 
   d="scan'208";a="208325820"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2021 18:19:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,284,1624345200"; 
   d="scan'208";a="695261645"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga006.fm.intel.com with ESMTP; 10 Sep 2021 18:19:08 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Quentin Perret <qperret@google.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Aubrey Li <aubrey.li@intel.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v5 6/6] sched/fair: Consider SMT in ASYM_PACKING load balance
Date:   Fri, 10 Sep 2021 18:18:19 -0700
Message-Id: <20210911011819.12184-7-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210911011819.12184-1-ricardo.neri-calderon@linux.intel.com>
References: <20210911011819.12184-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When deciding to pull tasks in ASYM_PACKING, it is necessary not only to
check for the idle state of the destination CPU, dst_cpu, but also of
its SMT siblings.

If dst_cpu is idle but its SMT siblings are busy, performance suffers
if it pulls tasks from a medium priority CPU that does not have SMT
siblings.

Implement asym_smt_can_pull_tasks() to inspect the state of the SMT
siblings of both dst_cpu and the CPUs in the candidate busiest group.

Cc: Aubrey Li <aubrey.li@intel.com>
Cc: Ben Segall <bsegall@google.com>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Quentin Perret <qperret@google.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Reviewed-by: Len Brown <len.brown@intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v4:
  * Use sg_lb_stats::sum_nr_running the idle state of a scheduling group.
    (Vincent, Peter)
  * Do not even idle CPUs in asym_smt_can_pull_tasks(). (Vincent)
  * Updated function documentation and corrected a typo.

Changes since v3:
  * Removed the arch_asym_check_smt_siblings() hook. Discussions with the
    powerpc folks showed that this patch should not impact them. Also, more
    recent powerpc processor no longer use asym_packing. (PeterZ)
  * Removed unnecessary local variable in asym_can_pull_tasks(). (Dietmar)
  * Removed unnecessary check for local CPUs when the local group has zero
    utilization. (Joel)
  * Renamed asym_can_pull_tasks() as asym_smt_can_pull_tasks() to reflect
    the fact that it deals with SMT cases.
  * Made asym_smt_can_pull_tasks() return false for !CONFIG_SCHED_SMT so
    that callers can deal with non-SMT cases.

Changes since v2:
  * Reworded the commit message to reflect updates in code.
  * Corrected misrepresentation of dst_cpu as the CPU doing the load
    balancing. (PeterZ)
  * Removed call to arch_asym_check_smt_siblings() as it is now called in
    sched_asym().

Changes since v1:
  * Don't bailout in update_sd_pick_busiest() if dst_cpu cannot pull
    tasks. Instead, reclassify the candidate busiest group, as it
    may still be selected. (PeterZ)
  * Avoid an expensive and unnecessary call to cpumask_weight() when
    determining if a sched_group is comprised of SMT siblings.
    (PeterZ).
---
 kernel/sched/fair.c | 94 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 26db017c14a3..8d763dd0174b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8597,10 +8597,98 @@ group_type group_classify(unsigned int imbalance_pct,
 	return group_has_spare;
 }
 
+/**
+ * asym_smt_can_pull_tasks - Check whether the load balancing CPU can pull tasks
+ * @dst_cpu:	Destination CPU of the load balancing
+ * @sds:	Load-balancing data with statistics of the local group
+ * @sgs:	Load-balancing statistics of the candidate busiest group
+ * @sg:		The candidate busiest group
+ *
+ * Check the state of the SMT siblings of both @sds::local and @sg and decide
+ * if @dst_cpu can pull tasks.
+ *
+ * If @dst_cpu does not have SMT siblings, it can pull tasks if two or more of
+ * the SMT siblings of @sg are busy. If only one CPU in @sg is busy, pull tasks
+ * only if @dst_cpu has higher priority.
+ *
+ * If both @dst_cpu and @sg have SMT siblings, and @sg has exactly one more
+ * busy CPU than @sds::local, let @dst_cpu pull tasks if it has higher priority.
+ * Bigger imbalances in the number of busy CPUs will be dealt with in
+ * update_sd_pick_busiest().
+ *
+ * If @sg does not have SMT siblings, only pull tasks if all of the SMT siblings
+ * of @dst_cpu are idle and @sg has lower priority.
+ */
+static bool asym_smt_can_pull_tasks(int dst_cpu, struct sd_lb_stats *sds,
+				    struct sg_lb_stats *sgs,
+				    struct sched_group *sg)
+{
+#ifdef CONFIG_SCHED_SMT
+	bool local_is_smt, sg_is_smt;
+	int sg_busy_cpus;
+
+	local_is_smt = sds->local->flags & SD_SHARE_CPUCAPACITY;
+	sg_is_smt = sg->flags & SD_SHARE_CPUCAPACITY;
+
+	sg_busy_cpus = sgs->group_weight - sgs->idle_cpus;
+
+	if (!local_is_smt) {
+		/*
+		 * If we are here, @dst_cpu is idle and does not have SMT
+		 * siblings. Pull tasks if candidate group has two or more
+		 * busy CPUs.
+		 */
+		if (sg_is_smt && sg_busy_cpus >= 2)
+			return true;
+
+		/*
+		 * @dst_cpu does not have SMT siblings. @sg may have SMT
+		 * siblings and only one is busy. In such case, @dst_cpu
+		 * can help if it has higher priority and is idle (i.e.,
+		 * it has no running tasks).
+		 */
+		return !sds->local_stat.sum_nr_running &&
+		       sched_asym_prefer(dst_cpu, sg->asym_prefer_cpu);
+	}
+
+	/* @dst_cpu has SMT siblings. */
+
+	if (sg_is_smt) {
+		int local_busy_cpus = sds->local->group_weight -
+				      sds->local_stat.idle_cpus;
+		int busy_cpus_delta = sg_busy_cpus - local_busy_cpus;
+
+		if (busy_cpus_delta == 1)
+			return sched_asym_prefer(dst_cpu,
+						 sg->asym_prefer_cpu);
+
+		return false;
+	}
+
+	/*
+	 * @sg does not have SMT siblings. Ensure that @sds::local does not end
+	 * up with more than one busy SMT sibling and only pull tasks if there
+	 * are not busy CPUs (i.e., no CPU has running tasks).
+	 */
+	if (!sds->local_stat.sum_nr_running)
+		return sched_asym_prefer(dst_cpu, sg->asym_prefer_cpu);
+
+	return false;
+#else
+	/* Always return false so that callers deal with non-SMT cases. */
+	return false;
+#endif
+}
+
 static inline bool
 sched_asym(struct lb_env *env, struct sd_lb_stats *sds,  struct sg_lb_stats *sgs,
 	   struct sched_group *group)
 {
+	/* Only do SMT checks if either local or candidate have SMT siblings */
+	if ((sds->local->flags & SD_SHARE_CPUCAPACITY) ||
+	    (group->flags & SD_SHARE_CPUCAPACITY))
+		return asym_smt_can_pull_tasks(env->dst_cpu, sds, sgs, group);
+
 	return sched_asym_prefer(env->dst_cpu, group->asym_prefer_cpu);
 }
 
@@ -9606,6 +9694,12 @@ static struct rq *find_busiest_queue(struct lb_env *env,
 		    nr_running == 1)
 			continue;
 
+		/* Make sure we only pull tasks from a CPU of lower priority */
+		if ((env->sd->flags & SD_ASYM_PACKING) &&
+		    sched_asym_prefer(i, env->dst_cpu) &&
+		    nr_running == 1)
+			continue;
+
 		switch (env->migration_type) {
 		case migrate_load:
 			/*
-- 
2.17.1

