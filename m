Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B18E45DD41
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 16:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356064AbhKYPZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 10:25:29 -0500
Received: from outbound-smtp48.blacknight.com ([46.22.136.219]:40293 "EHLO
        outbound-smtp48.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1355993AbhKYPX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 10:23:27 -0500
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp48.blacknight.com (Postfix) with ESMTPS id C33BFFB864
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 15:20:13 +0000 (GMT)
Received: (qmail 26695 invoked from network); 25 Nov 2021 15:20:13 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPA; 25 Nov 2021 15:20:13 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Mike Galbraith <efault@gmx.de>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 2/2] sched/fair: Adjust the allowed NUMA imbalance when SD_NUMA spans multiple LLCs
Date:   Thu, 25 Nov 2021 15:19:41 +0000
Message-Id: <20211125151941.8710-3-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211125151941.8710-1-mgorman@techsingularity.net>
References: <20211125151941.8710-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 7d2b5dd0bcc4 ("sched/numa: Allow a floating imbalance between NUMA
nodes") allowed an imbalance between NUMA nodes such that communicating
tasks would not be pulled apart by the load balancer. This works fine when
there is a 1:1 relationship between LLC and node but can be suboptimal
for multiple LLCs if independent tasks prematurely use CPUs sharing cache.

Zen* has multiple LLCs per node with local memory channels and due to
the allowed imbalance, it's far harder to tune some workloads to run
optimally than it is on hardware that has 1 LLC per node. This patch
adjusts the imbalance on multi-LLC machines to allow an imbalance up to
the point where LLCs should be balanced between nodes.

On a Zen3 machine running STREAM parallelised with OMP to have on instance
per LLC the results and without binding, the results are

                               vanilla     sched-numaimb-v2r4
MB/sec copy-16    164279.50 (   0.00%)   702962.88 ( 327.91%)
MB/sec scale-16   137487.08 (   0.00%)   397132.98 ( 188.85%)
MB/sec add-16     157561.68 (   0.00%)   638006.32 ( 304.92%)
MB/sec triad-16   154562.04 (   0.00%)   641408.02 ( 314.98%)

STREAM can use directives to force the spread if the OpenMP is new
enough but that doesn't help if an application uses threads and
it's not known in advance how many threads will be created.

                                  vanilla     sched-numaimb-v1r2
Min       Score-16   366090.84 (   0.00%)   401505.65 (   9.67%)
Hmean     Score-16   391416.56 (   0.00%)   452546.28 *  15.62%*
Stddev    Score-16    16452.12 (   0.00%)    31480.31 ( -91.35%)
CoeffVar  Score-16        4.20 (   0.00%)        6.92 ( -64.99%)
Max       Score-16   416666.67 (   0.00%)   483529.77 (  16.05%)

It can also make a big difference for semi-realistic workloads
like specjbb which can execute arbitrary numbers of threads without
advance knowledge of how they should be placed

                                  vanilla     sched-numaimb-v2r5
Hmean     tput-1      73743.05 (   0.00%)    72517.86 (  -1.66%)
Hmean     tput-8     563036.51 (   0.00%)   619505.85 *  10.03%*
Hmean     tput-16   1016590.61 (   0.00%)  1084022.36 (   6.63%)
Hmean     tput-24   1418558.41 (   0.00%)  1443296.06 (   1.74%)
Hmean     tput-32   1608794.22 (   0.00%)  1869822.05 *  16.23%*
Hmean     tput-40   1761338.13 (   0.00%)  2154415.40 *  22.32%*
Hmean     tput-48   2290646.54 (   0.00%)  2561031.20 *  11.80%*
Hmean     tput-56   2463345.12 (   0.00%)  2731874.84 *  10.90%*
Hmean     tput-64   2650213.53 (   0.00%)  2867054.47 (   8.18%)
Hmean     tput-72   2497253.28 (   0.00%)  3017637.28 *  20.84%*
Hmean     tput-80   2820786.72 (   0.00%)  3018947.39 (   7.03%)
Hmean     tput-88   2813541.68 (   0.00%)  3008805.43 *   6.94%*
Hmean     tput-96   2604158.67 (   0.00%)  2948056.40 *  13.21%*
Hmean     tput-104  2713810.62 (   0.00%)  2952327.00 (   8.79%)
Hmean     tput-112  2558425.37 (   0.00%)  2909089.90 *  13.71%*
Hmean     tput-120  2611434.93 (   0.00%)  2773024.11 *   6.19%*
Hmean     tput-128  2706103.22 (   0.00%)  2765678.84 (   2.20%)

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 include/linux/sched/topology.h |  1 +
 kernel/sched/fair.c            | 26 +++++++++++++++-----------
 kernel/sched/topology.c        | 24 ++++++++++++++++++++++++
 3 files changed, 40 insertions(+), 11 deletions(-)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index c07bfa2d80f2..54f5207154d3 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -93,6 +93,7 @@ struct sched_domain {
 	unsigned int busy_factor;	/* less balancing by factor if busy */
 	unsigned int imbalance_pct;	/* No balance until over watermark */
 	unsigned int cache_nice_tries;	/* Leave cache hot tasks for # tries */
+	unsigned int imb_numa_nr;	/* Nr imbalanced tasks allowed between nodes */
 
 	int nohz_idle;			/* NOHZ IDLE status */
 	int flags;			/* See SD_* */
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0a969affca76..64f211879e43 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1489,6 +1489,7 @@ struct task_numa_env {
 
 	int src_cpu, src_nid;
 	int dst_cpu, dst_nid;
+	int imb_numa_nr;
 
 	struct numa_stats src_stats, dst_stats;
 
@@ -1885,7 +1886,7 @@ static void task_numa_find_cpu(struct task_numa_env *env,
 		dst_running = env->dst_stats.nr_running + 1;
 		imbalance = max(0, dst_running - src_running);
 		imbalance = adjust_numa_imbalance(imbalance, dst_running,
-							env->dst_stats.weight);
+						  env->imb_numa_nr);
 
 		/* Use idle CPU if there is no imbalance */
 		if (!imbalance) {
@@ -1950,8 +1951,10 @@ static int task_numa_migrate(struct task_struct *p)
 	 */
 	rcu_read_lock();
 	sd = rcu_dereference(per_cpu(sd_numa, env.src_cpu));
-	if (sd)
+	if (sd) {
 		env.imbalance_pct = 100 + (sd->imbalance_pct - 100) / 2;
+		env.imb_numa_nr = sd->imb_numa_nr;
+	}
 	rcu_read_unlock();
 
 	/*
@@ -9046,13 +9049,14 @@ static bool update_pick_idlest(struct sched_group *idlest,
 }
 
 /*
- * Allow a NUMA imbalance if busy CPUs is less than 25% of the domain.
- * This is an approximation as the number of running tasks may not be
- * related to the number of busy CPUs due to sched_setaffinity.
+ * Allow a NUMA imbalance if busy CPUs is less than the allowed
+ * imbalance. This is an approximation as the number of running
+ * tasks may not be related to the number of busy CPUs due to
+ * sched_setaffinity.
  */
-static inline bool allow_numa_imbalance(int dst_running, int dst_weight)
+static inline bool allow_numa_imbalance(int dst_running, int imb_numa_nr)
 {
-	return (dst_running < (dst_weight >> 2));
+	return dst_running < imb_numa_nr;
 }
 
 /*
@@ -9191,7 +9195,7 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
 			 * a real need of migration, periodic load balance will
 			 * take care of it.
 			 */
-			if (allow_numa_imbalance(local_sgs.sum_nr_running, sd->span_weight))
+			if (allow_numa_imbalance(local_sgs.sum_nr_running, sd->imb_numa_nr))
 				return NULL;
 		}
 
@@ -9283,9 +9287,9 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 #define NUMA_IMBALANCE_MIN 2
 
 static inline long adjust_numa_imbalance(int imbalance,
-				int dst_running, int dst_weight)
+				int dst_running, int imb_numa_nr)
 {
-	if (!allow_numa_imbalance(dst_running, dst_weight))
+	if (!allow_numa_imbalance(dst_running, imb_numa_nr))
 		return imbalance;
 
 	/*
@@ -9397,7 +9401,7 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 		/* Consider allowing a small imbalance between NUMA groups */
 		if (env->sd->flags & SD_NUMA) {
 			env->imbalance = adjust_numa_imbalance(env->imbalance,
-				busiest->sum_nr_running, env->sd->span_weight);
+				busiest->sum_nr_running, env->sd->imb_numa_nr);
 		}
 
 		return;
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index d201a7052a29..9adeaa89ccb4 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2242,6 +2242,30 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 		}
 	}
 
+	/* Calculate allowed NUMA imbalance */
+	for_each_cpu(i, cpu_map) {
+		for (sd = *per_cpu_ptr(d.sd, i); sd; sd = sd->parent) {
+			struct sched_domain *child = sd->child;
+
+			if (!(sd->flags & SD_SHARE_PKG_RESOURCES) &&
+			    (child->flags & SD_SHARE_PKG_RESOURCES)) {
+				struct sched_domain *sd_numa = sd;
+				int imb_numa_nr, nr_groups;
+
+				nr_groups = sd->span_weight / child->span_weight;
+				imb_numa_nr = nr_groups / num_online_nodes();
+
+				while (sd_numa) {
+					if (sd_numa->flags & SD_NUMA) {
+						sd_numa->imb_numa_nr = imb_numa_nr;
+						break;
+					}
+					sd_numa = sd_numa->parent;
+				}
+			}
+		}
+	}
+
 	/* Calculate CPU capacity for physical packages and nodes */
 	for (i = nr_cpumask_bits-1; i >= 0; i--) {
 		if (!cpumask_test_cpu(i, cpu_map))
-- 
2.31.1

