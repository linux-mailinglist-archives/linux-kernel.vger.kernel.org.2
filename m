Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 579C135EA95
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 04:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346705AbhDNCGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 22:06:01 -0400
Received: from mga03.intel.com ([134.134.136.65]:7629 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233062AbhDNCFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 22:05:54 -0400
IronPort-SDR: IYBoyfi6Alz1KIqwyKvw1/DO7drl5uUC8SCkh5Dbr0+YyA3MwsY/hCzkZyFZKNpMicFt4XELTP
 OXDclNt71rXw==
X-IronPort-AV: E=McAfee;i="6200,9189,9953"; a="194571778"
X-IronPort-AV: E=Sophos;i="5.82,221,1613462400"; 
   d="scan'208";a="194571778"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2021 19:05:30 -0700
IronPort-SDR: /RPtlqi6X5kC582dg7xZpd4vYEUAD7Ed8l/6aDaLZMfWZwTCTYUdgF1Yi/26eLvjfBJNNVaIv6
 xOB06i3P+TDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,221,1613462400"; 
   d="scan'208";a="450625211"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Apr 2021 19:05:29 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.comi>, Mel Gorman <mgorman@suse.de>,
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
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH v2 3/4] sched/fair: Consider SMT in ASYM_PACKING load balance
Date:   Tue, 13 Apr 2021 19:04:35 -0700
Message-Id: <20210414020436.12980-4-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210414020436.12980-1-ricardo.neri-calderon@linux.intel.com>
References: <20210414020436.12980-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When deciding to pull tasks in ASYM_PACKING, it is necessary not only to
check for the idle state of the CPU doing the load balancing, but also of
its SMT siblings.

If the CPU doing the balancing is idle but its SMT siblings are not busy,
performance suffers if it pulls tasks from a medium priority CPU that does
not have SMT siblings. The decision to label a group for asymmetric packing
balancing is done in update_sg_lb_stats(). However, for SMT, that code does
not account for idle SMT siblings.

Implement asym_can_pull_tasks() to revisit the early decision on whether
the CPU doing the balance can pull tasks once the needed information is
available. arch_sched_asym_prefer_early() and
arch_asym_check_smt_siblings() are used to conserve the legacy behavior.

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
Changes since v1:
 * Don't bailout in update_sd_pick_busiest() if dst_cpu cannot pull
   tasks. Instead, reclassify the candidate busiest group, as it
   may still be selected. (PeterZ)
 * Avoid an expensive and unnecessary call to cpumask_weight() when
   determining if a sched_group is comprised of SMT siblings.
   (PeterZ).
---
 include/linux/sched/topology.h |   1 +
 kernel/sched/fair.c            | 127 +++++++++++++++++++++++++++++++++
 2 files changed, 128 insertions(+)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 663b98959305..6487953b24e8 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -58,6 +58,7 @@ static inline int cpu_numa_flags(void)
 
 extern int arch_asym_cpu_priority(int cpu);
 extern bool arch_sched_asym_prefer_early(int a, int b);
+extern bool arch_asym_check_smt_siblings(void);
 
 struct sched_domain_attr {
 	int relax_domain_level;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e74da853b046..2a33f93646b2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -115,6 +115,14 @@ bool __weak arch_sched_asym_prefer_early(int a, int b)
 	return sched_asym_prefer(a, b);
 }
 
+/*
+ * For asym packing, first check the state of SMT siblings before deciding to
+ * pull tasks.
+ */
+bool __weak arch_asym_check_smt_siblings(void)
+{
+	return false;
+}
 /*
  * The margin used when comparing utilization with CPU capacity.
  *
@@ -8483,6 +8491,107 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 				sgs->group_capacity;
 }
 
+static bool cpu_group_is_smt(int cpu, struct sched_group *sg)
+{
+#ifdef CONFIG_SCHED_SMT
+	if (!static_branch_likely(&sched_smt_present))
+		return false;
+
+	if (sg->group_weight == 1)
+		return false;
+
+	return cpumask_equal(sched_group_span(sg), cpu_smt_mask(cpu));
+#else
+	return false;
+#endif
+}
+
+/**
+ * asym_can_pull_tasks - Check whether the load balancing CPU can pull tasks
+ * @dst_cpu:	CPU doing the load balancing
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
+	if (!arch_asym_check_smt_siblings())
+		return true;
+
+	cpu = group_first_cpu(sg);
+	local_is_smt = cpu_group_is_smt(dst_cpu, sds->local);
+	sg_is_smt = cpu_group_is_smt(cpu, sg);
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
 /**
  * update_sd_pick_busiest - return 1 on busiest group
  * @env: The load balancing environment.
@@ -8507,6 +8616,18 @@ static bool update_sd_pick_busiest(struct lb_env *env,
 	if (!sgs->sum_h_nr_running)
 		return false;
 
+	/*
+	 * @sg may have been tentatively classified as group_asym_packing.
+	 * Now that we have sufficient information about @sds.local, reassess
+	 * if asym packing migration can be done. Reclassify @sg. The only
+	 * possible results are group_has_spare and group_fully_busy.
+	 */
+	if (sgs->group_type == group_asym_packing &&
+	    !asym_can_pull_tasks(env->dst_cpu, sds, sgs, sg)) {
+		sgs->group_asym_packing = 0;
+		sgs->group_type = group_classify(env->sd->imbalance_pct, sg, sgs);
+	}
+
 	/*
 	 * Don't try to pull misfit tasks we can't help.
 	 * We can use max_capacity here as reduction in capacity on some
@@ -9412,6 +9533,12 @@ static struct rq *find_busiest_queue(struct lb_env *env,
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

