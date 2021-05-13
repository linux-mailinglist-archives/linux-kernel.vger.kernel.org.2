Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC3137F3A0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 09:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbhEMHmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 03:42:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42154 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231682AbhEMHmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 03:42:05 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14D7YavS134748;
        Thu, 13 May 2021 03:40:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=raGOMbbhzP40YBKjzkugKEsfPjmzKiKvBUnOzfZ5kTs=;
 b=XiBeT7zzuEebwXbJDNlSdLRs+3q15+MVAdssB/5AKU6wETcLeJDXw3pf6DM7M2xz0fR5
 XwahysEgeLF9e85ebL7MFRYTqQjr77GxSFqP61j7TtZXaJs+IX7WKQ49tKMsrkj8XU/B
 cPjh0xwQ/S7CegjrjMJhIul6o9rptI7b9No1bP3324DwStRhTyjRHMcRTaswSyNkJ68i
 WxmspBxq7H99k0yo6sgJ6QX0j7TAdcmc83nQTlrwLydxg+obz5syAr9JjnDulwrZ7sNO
 8ETa3A40ur4Vi71cwfijlBo+B/C3w7efVeGGYouVVkY9sMnbH7Y5M26EgE//a5wdyAaO xA== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38gy6798ef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 May 2021 03:40:44 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14D7bOH2021301;
        Thu, 13 May 2021 07:40:42 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06fra.de.ibm.com with ESMTP id 38dhwh1e7j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 May 2021 07:40:42 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14D7ed5c37224822
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 May 2021 07:40:40 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D0F3FAE051;
        Thu, 13 May 2021 07:40:39 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 77DA4AE045;
        Thu, 13 May 2021 07:40:37 +0000 (GMT)
Received: from saptagiri.in.ibm.com (unknown [9.79.222.102])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 13 May 2021 07:40:37 +0000 (GMT)
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Parth Shah <parth@linux.ibm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>
Subject: [PATCH v3 2/8] sched/fair: Maintain the identity of idle-core
Date:   Thu, 13 May 2021 13:10:21 +0530
Message-Id: <20210513074027.543926-3-srikar@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210513074027.543926-1-srikar@linux.vnet.ibm.com>
References: <20210513074027.543926-1-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ok-0l5FbmnqvtPUs_yDQHviGgwx2VCO7
X-Proofpoint-ORIG-GUID: ok-0l5FbmnqvtPUs_yDQHviGgwx2VCO7
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-13_03:2021-05-12,2021-05-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999
 bulkscore=0 spamscore=0 mlxscore=0 clxscore=1015 suspectscore=0
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2105130056
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Scheduler maintains a per LLC info which tells if there is any idle core
in that LLC. However this information doesn't provide which core is idle.

So when iterating for idle-cores, if select_idle_core() finds an
idle-core, then it doesn't try to reset this information.

So if there was only one idle core in the LLC and select_idle_core()
selected the idle-core, the LLC will maintain that it still has a
idle-core.

On the converse, if a task is pinned, and has a restricted
cpus_allowed_list and LLC has multiple idle-cores, but select_idle_core
cannot find a idle-core, LLC will no more maintain that it has an
idle-core.

As a first step to solve this problem, LLC will maintain the identity of
the idle core instead of just the information that LLC has an idle core

Along with maintaining, this change will solve both the problems listed
above. However there are other problems that exist with the current
infrastructure and those will continue to exist with this change and
would be handled in subsequent patches.

Cc: LKML <linux-kernel@vger.kernel.org>
Cc: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Cc: Parth Shah <parth@linux.ibm.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Aubrey Li <aubrey.li@linux.intel.com>
Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
Changelog v2->v3:
 -  Rebase to tip/sched/core
		(Valentin)

 include/linux/sched/topology.h |  2 +-
 kernel/sched/fair.c            | 52 ++++++++++++++++++----------------
 kernel/sched/sched.h           |  3 ++
 kernel/sched/topology.c        |  7 +++++
 4 files changed, 39 insertions(+), 25 deletions(-)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 8f0f778b7c91..285165a35f21 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -73,7 +73,7 @@ struct sched_group;
 struct sched_domain_shared {
 	atomic_t	ref;
 	atomic_t	nr_busy_cpus;
-	int		has_idle_cores;
+	int		idle_core;
 };
 
 struct sched_domain {
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7920f2a4d257..c42b2b3cd08f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1578,11 +1578,11 @@ numa_type numa_classify(unsigned int imbalance_pct,
 
 #ifdef CONFIG_SCHED_SMT
 /* Forward declarations of select_idle_sibling helpers */
-static inline bool test_idle_cores(int cpu, bool def);
+static inline int get_idle_core(int cpu, int def);
 static inline int numa_idle_core(int idle_core, int cpu)
 {
 	if (!static_branch_likely(&sched_smt_present) ||
-	    idle_core >= 0 || !test_idle_cores(cpu, false))
+	    idle_core >= 0 || get_idle_core(cpu, -1) < 0)
 		return idle_core;
 
 	/*
@@ -6039,29 +6039,31 @@ static inline int __select_idle_cpu(int cpu)
 DEFINE_STATIC_KEY_FALSE(sched_smt_present);
 EXPORT_SYMBOL_GPL(sched_smt_present);
 
-static inline void set_idle_cores(int cpu, int val)
+static inline void set_idle_core(int cpu, int val)
 {
 	struct sched_domain_shared *sds;
 
 	sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
 	if (sds)
-		WRITE_ONCE(sds->has_idle_cores, val);
+		WRITE_ONCE(sds->idle_core, val);
 }
 
-static inline bool test_idle_cores(int cpu, bool def)
+static inline int get_idle_core(int cpu, int def)
 {
 	struct sched_domain_shared *sds;
 
-	sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
-	if (sds)
-		return READ_ONCE(sds->has_idle_cores);
+	if (static_branch_likely(&sched_smt_present)) {
+		sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
+		if (sds)
+			return READ_ONCE(sds->idle_core);
+	}
 
 	return def;
 }
 
 /*
  * Scans the local SMT mask to see if the entire core is idle, and records this
- * information in sd_llc_shared->has_idle_cores.
+ * information in sd_llc_shared->idle_core.
  *
  * Since SMT siblings share all cache levels, inspecting this limited remote
  * state should be fairly cheap.
@@ -6072,7 +6074,7 @@ void __update_idle_core(struct rq *rq)
 	int cpu;
 
 	rcu_read_lock();
-	if (test_idle_cores(core, true))
+	if (get_idle_core(core, 0) >= 0)
 		goto unlock;
 
 	for_each_cpu(cpu, cpu_smt_mask(core)) {
@@ -6083,7 +6085,7 @@ void __update_idle_core(struct rq *rq)
 			goto unlock;
 	}
 
-	set_idle_cores(core, 1);
+	set_idle_core(core, per_cpu(smt_id, core));
 unlock:
 	rcu_read_unlock();
 }
@@ -6091,7 +6093,7 @@ void __update_idle_core(struct rq *rq)
 /*
  * Scan the entire LLC domain for idle cores; this dynamically switches off if
  * there are no idle cores left in the system; tracked through
- * sd_llc->shared->has_idle_cores and enabled through update_idle_core() above.
+ * sd_llc->shared->idle_core and enabled through update_idle_core() above.
  */
 static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpus, int *idle_cpu)
 {
@@ -6144,11 +6146,11 @@ static int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int t
 
 #else /* CONFIG_SCHED_SMT */
 
-static inline void set_idle_cores(int cpu, int val)
+static inline void set_idle_core(int cpu, int val)
 {
 }
 
-static inline bool test_idle_cores(int cpu, bool def)
+static inline bool get_idle_core(int cpu, int def)
 {
 	return def;
 }
@@ -6170,10 +6172,11 @@ static inline int select_idle_smt(struct task_struct *p, struct sched_domain *sd
  * comparing the average scan cost (tracked in sd->avg_scan_cost) against the
  * average idle time for this rq (as found in rq->avg_idle).
  */
-static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool has_idle_core, int target)
+static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int idle_core, int target)
 {
 	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
 	int i, cpu, idle_cpu = -1, nr = INT_MAX;
+	bool has_idle_core = (idle_core != -1);
 	int this = smp_processor_id();
 	struct sched_domain *this_sd;
 	u64 time;
@@ -6206,8 +6209,13 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
 	for_each_cpu_wrap(cpu, cpus, target) {
 		if (has_idle_core) {
 			i = select_idle_core(p, cpu, cpus, &idle_cpu);
-			if ((unsigned int)i < nr_cpumask_bits)
+			if ((unsigned int)i < nr_cpumask_bits) {
+#ifdef CONFIG_SCHED_SMT
+				if ((per_cpu(smt_id, i)) == idle_core)
+					set_idle_core(i, -1);
+#endif
 				return i;
+			}
 
 		} else {
 			if (!--nr)
@@ -6218,9 +6226,6 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
 		}
 	}
 
-	if (has_idle_core)
-		set_idle_cores(this, false);
-
 	if (sched_feat(SIS_PROP) && !has_idle_core) {
 		time = cpu_clock(this) - time;
 		update_avg(&this_sd->avg_scan_cost, time);
@@ -6276,10 +6281,9 @@ static inline bool asym_fits_capacity(int task_util, int cpu)
  */
 static int select_idle_sibling(struct task_struct *p, int prev, int target)
 {
-	bool has_idle_core = false;
+	int i, recent_used_cpu, idle_core = -1;
 	struct sched_domain *sd;
 	unsigned long task_util;
-	int i, recent_used_cpu;
 
 	/*
 	 * On asymmetric system, update task utilization because we will check
@@ -6357,16 +6361,16 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 		return target;
 
 	if (sched_smt_active()) {
-		has_idle_core = test_idle_cores(target, false);
+		idle_core = get_idle_core(target, -1);
 
-		if (!has_idle_core && cpus_share_cache(prev, target)) {
+		if (idle_core < 0 && cpus_share_cache(prev, target)) {
 			i = select_idle_smt(p, sd, prev);
 			if ((unsigned int)i < nr_cpumask_bits)
 				return i;
 		}
 	}
 
-	i = select_idle_cpu(p, sd, has_idle_core, target);
+	i = select_idle_cpu(p, sd, idle_core, target);
 	if ((unsigned)i < nr_cpumask_bits)
 		return i;
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index a189bec13729..22fbb50b036e 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1491,6 +1491,9 @@ static inline struct sched_domain *lowest_flag_domain(int cpu, int flag)
 DECLARE_PER_CPU(struct sched_domain __rcu *, sd_llc);
 DECLARE_PER_CPU(int, sd_llc_size);
 DECLARE_PER_CPU(int, sd_llc_id);
+#ifdef CONFIG_SCHED_SMT
+DECLARE_PER_CPU(int, smt_id);
+#endif
 DECLARE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
 DECLARE_PER_CPU(struct sched_domain __rcu *, sd_numa);
 DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 55a0a243e871..232fb261dfc2 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -644,6 +644,9 @@ static void destroy_sched_domains(struct sched_domain *sd)
 DEFINE_PER_CPU(struct sched_domain __rcu *, sd_llc);
 DEFINE_PER_CPU(int, sd_llc_size);
 DEFINE_PER_CPU(int, sd_llc_id);
+#ifdef CONFIG_SCHED_SMT
+DEFINE_PER_CPU(int, smt_id);
+#endif
 DEFINE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
 DEFINE_PER_CPU(struct sched_domain __rcu *, sd_numa);
 DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
@@ -667,6 +670,9 @@ static void update_top_cache_domain(int cpu)
 	rcu_assign_pointer(per_cpu(sd_llc, cpu), sd);
 	per_cpu(sd_llc_size, cpu) = size;
 	per_cpu(sd_llc_id, cpu) = id;
+#ifdef CONFIG_SCHED_SMT
+	per_cpu(smt_id, cpu) = cpumask_first(cpu_smt_mask(cpu));
+#endif
 	rcu_assign_pointer(per_cpu(sd_llc_shared, cpu), sds);
 
 	sd = lowest_flag_domain(cpu, SD_NUMA);
@@ -1497,6 +1503,7 @@ sd_init(struct sched_domain_topology_level *tl,
 		sd->shared = *per_cpu_ptr(sdd->sds, sd_id);
 		atomic_inc(&sd->shared->ref);
 		atomic_set(&sd->shared->nr_busy_cpus, sd_weight);
+		sd->shared->idle_core = -1;
 	}
 
 	sd->private = sdd;
-- 
2.18.2

