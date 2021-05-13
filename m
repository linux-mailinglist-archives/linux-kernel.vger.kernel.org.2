Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E67937FB06
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 17:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232715AbhEMPvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 11:51:23 -0400
Received: from mga12.intel.com ([192.55.52.136]:24114 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232251AbhEMPvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 11:51:11 -0400
IronPort-SDR: pA0RfI9oYmD96i1ki5OSGxIXZkf1qJLLIfR7Ttfhy7AxI63EKYqzjaCc4mIY00OrSSLWLNjpif
 0y0wOtkwakSA==
X-IronPort-AV: E=McAfee;i="6200,9189,9982"; a="179568914"
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="179568914"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 08:50:01 -0700
IronPort-SDR: 1ErMER6DLCHMrUgCb4bJieZtrTH2Euy5/xsd9q3R9mHPH0QbehGbwvbxM3aYCvBqxWFsOzlZ6H
 z5AeVh+TrIOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="610418843"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga005.jf.intel.com with ESMTP; 13 May 2021 08:50:00 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
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
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Aubrey Li <aubrey.li@intel.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH v3 5/6] sched/fair: Consider SMT in ASYM_PACKING load balance
Date:   Thu, 13 May 2021 08:49:08 -0700
Message-Id: <20210513154909.6385-6-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210513154909.6385-1-ricardo.neri-calderon@linux.intel.com>
References: <20210513154909.6385-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When deciding to pull tasks in ASYM_PACKING, it is necessary not only to
check for the idle state of the destination CPU, dst_cpu, but also of
its SMT siblings.

If dst_cpu is idle but its SMT siblings are busy, performance suffers
if it pulls tasks from a medium priority CPU that does not have SMT
siblings.

Implement asym_can_pull_tasks() to inspect the state of the SMT siblings
of both dst_cpu and the CPUs in the candidate busiest group.

To keep the legacy behavior, add an arch_asym_check_smt_siblings() to
skip these new checks by default. Individual architectures must override
the mentioned function to use asym_can_pull_tasks().

Cc: Aubrey Li <aubrey.li@intel.com>
Cc: Ben Segall <bsegall@google.com>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Quentin Perret <qperret@google.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
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
 include/linux/sched/topology.h |   1 +
 kernel/sched/fair.c            | 101 +++++++++++++++++++++++++++++++++
 2 files changed, 102 insertions(+)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 8f0f778b7c91..43bdb8b1e1df 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -57,6 +57,7 @@ static inline int cpu_numa_flags(void)
 #endif
 
 extern int arch_asym_cpu_priority(int cpu);
+extern bool arch_asym_check_smt_siblings(void);
 
 struct sched_domain_attr {
 	int relax_domain_level;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c8b66a5d593e..3d6cc027e6e6 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -106,6 +106,15 @@ int __weak arch_asym_cpu_priority(int cpu)
 	return -cpu;
 }
 
+/*
+ * For asym packing, first check the state of SMT siblings before deciding to
+ * pull tasks.
+ */
+bool __weak arch_asym_check_smt_siblings(void)
+{
+	return false;
+}
+
 /*
  * The margin used when comparing utilization with CPU capacity.
  *
@@ -8447,6 +8456,89 @@ group_type group_classify(unsigned int imbalance_pct,
 	return group_has_spare;
 }
 
+/**
+ * asym_can_pull_tasks - Check whether the load balancing CPU can pull tasks
+ * @dst_cpu:	Destination CPU of the load balancing
+ * @sds:	Load-balancing data with statistics of the local group
+ * @sgs:	Load-balancing statistics of the candidate busiest group
+ * @sg:		The candidate busiet group
+ *
+ * Check the state of the SMT siblings of both @sds::local and @sg and decide
+ * if @dst_cpu can pull tasks. If @dst_cpu does not have SMT siblings, it can
+ * pull tasks if two or more of the SMT siblings of @sg are busy. If only one
+ * CPU in @sg is busy, pull tasks only if @dst_cpu has higher priority.
+ *
+ * If both @dst_cpu and @sg have SMT siblings. Even the number of idle CPUs
+ * between @sds::local and @sg. Thus, pull tasks from @sg if the difference
+ * between the number of busy CPUs is 2 or more. If the difference is of 1,
+ * only pull if @dst_cpu has higher priority. If @sg does not have SMT siblings
+ * only pull tasks if all of the SMT siblings of @dst_cpu are idle and @sg
+ * has lower priority.
+ */
+static bool asym_can_pull_tasks(int dst_cpu, struct sd_lb_stats *sds,
+				struct sg_lb_stats *sgs, struct sched_group *sg)
+{
+#ifdef CONFIG_SCHED_SMT
+	int cpu, local_busy_cpus, sg_busy_cpus;
+	bool local_is_smt, sg_is_smt;
+
+	cpu = group_first_cpu(sg);
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
+		 * can help if it has higher priority and is idle.
+		 */
+		return !sds->local_stat.group_util &&
+		       sched_asym_prefer(dst_cpu, sg->asym_prefer_cpu);
+	}
+
+	/* @dst_cpu has SMT siblings. */
+
+	local_busy_cpus = sds->local->group_weight - sds->local_stat.idle_cpus;
+
+	if (sg_is_smt) {
+		int busy_cpus_delta = sg_busy_cpus - local_busy_cpus;
+
+		/* Local can always help to even the number busy CPUs. */
+		if (busy_cpus_delta >= 2)
+			return true;
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
+	 * are not busy CPUs. As CPUs move in and out of idle state frequently,
+	 * also check the group utilization to smoother the decision.
+	 */
+	if (!local_busy_cpus && !sds->local_stat.group_util)
+		return sched_asym_prefer(dst_cpu, sg->asym_prefer_cpu);
+
+	return false;
+#else
+	return true;
+#endif
+}
+
 static inline bool
 sched_asym(struct lb_env *env, struct sd_lb_stats *sds,  struct sg_lb_stats *sgs,
 	   struct sched_group *group)
@@ -8458,6 +8550,9 @@ sched_asym(struct lb_env *env, struct sd_lb_stats *sds,  struct sg_lb_stats *sgs
 	if (group == sds->local)
 		return false;
 
+	if (arch_asym_check_smt_siblings())
+		return asym_can_pull_tasks(env->dst_cpu, sds, sgs, group);
+
 	return sched_asym_prefer(env->dst_cpu, group->asym_prefer_cpu);
 }
 
@@ -9463,6 +9558,12 @@ static struct rq *find_busiest_queue(struct lb_env *env,
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

