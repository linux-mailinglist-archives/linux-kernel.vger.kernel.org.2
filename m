Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E16E1367E8A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 12:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235815AbhDVKYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 06:24:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37266 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235704AbhDVKYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 06:24:47 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13MA3oI1146100;
        Thu, 22 Apr 2021 06:23:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=2aogaXZURXTogXb/qFzhVPLKAgpEhNENwdFFjMSRSLQ=;
 b=aZFCe9dxU/XBVL8CH3RQ0mMiNw5DuI5Wv/bSksKEvQG1ZdMw35kI/X4K6iBBNKDZKnDQ
 zeqJo2ei2wu7BwxEk16w9/CzXuDimO7VuHi6ezxqM2+mMD/1PEivEgiEJ79qPxmuoljR
 GRky9LtIJKFfd2O8+xkt9UbEAHAkR5WunsGRbBxMExgPHEKjiPzXEpMDeX7/IwHm20cv
 HCaNsJJ8gf5zjRxH5/Q/aCWPPD/4WgSBk1GIXLH5WUan5KsFAl9Z74ZN50tl06v7GzX2
 m5fl3i4+WbJz7iXLwL51ADaOainkOgKQj0w+7JeTKKbA8S+nzOmA3+h0lZB3ka+QgC3H 3g== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 383510vb2w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Apr 2021 06:23:51 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13MAMMsA031493;
        Thu, 22 Apr 2021 10:23:49 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 37yqa8jswj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Apr 2021 10:23:48 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13MANNGr20578756
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Apr 2021 10:23:23 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3F039AE053;
        Thu, 22 Apr 2021 10:23:46 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 02BC4AE055;
        Thu, 22 Apr 2021 10:23:43 +0000 (GMT)
Received: from saptagiri.in.ibm.com (unknown [9.199.63.107])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 22 Apr 2021 10:23:42 +0000 (GMT)
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
        Parth Shah <parth@linux.ibm.com>
Subject: [PATCH 02/10] sched/fair: Maintain the identity of idle-core
Date:   Thu, 22 Apr 2021 15:53:18 +0530
Message-Id: <20210422102326.35889-3-srikar@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210422102326.35889-1-srikar@linux.vnet.ibm.com>
References: <20210422102326.35889-1-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: dxtoljH9QkR8ZlsVrZg7p4t5SSItvMFj
X-Proofpoint-GUID: dxtoljH9QkR8ZlsVrZg7p4t5SSItvMFj
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-22_04:2021-04-21,2021-04-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 mlxlogscore=999 priorityscore=1501 mlxscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104220080
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
Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
 include/linux/sched/topology.h |  2 +-
 kernel/sched/fair.c            | 43 +++++++++++++++++++---------------
 kernel/sched/sched.h           |  3 +++
 kernel/sched/topology.c        |  7 ++++++
 4 files changed, 35 insertions(+), 20 deletions(-)

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
index a258a84cfdfd..03083eacdaf0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1563,11 +1563,11 @@ numa_type numa_classify(unsigned int imbalance_pct,
 
 #ifdef CONFIG_SCHED_SMT
 /* Forward declarations of select_idle_sibling helpers */
-static inline bool test_idle_cores(int cpu, bool def);
+static inline int get_idle_core(int cpu, int def);
 static inline int numa_idle_core(int idle_core, int cpu)
 {
 	if (!static_branch_likely(&sched_smt_present) ||
-	    idle_core >= 0 || !test_idle_cores(cpu, false))
+	    idle_core >= 0 || get_idle_core(cpu, -1) == -1)
 		return idle_core;
 
 	/*
@@ -6015,29 +6015,31 @@ static inline int __select_idle_cpu(int cpu)
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
@@ -6048,7 +6050,7 @@ void __update_idle_core(struct rq *rq)
 	int cpu;
 
 	rcu_read_lock();
-	if (test_idle_cores(core, true))
+	if (get_idle_core(core, 0) != -1)
 		goto unlock;
 
 	for_each_cpu(cpu, cpu_smt_mask(core)) {
@@ -6059,7 +6061,7 @@ void __update_idle_core(struct rq *rq)
 			goto unlock;
 	}
 
-	set_idle_cores(core, 1);
+	set_idle_core(core, per_cpu(smt_id, core));
 unlock:
 	rcu_read_unlock();
 }
@@ -6067,7 +6069,7 @@ void __update_idle_core(struct rq *rq)
 /*
  * Scan the entire LLC domain for idle cores; this dynamically switches off if
  * there are no idle cores left in the system; tracked through
- * sd_llc->shared->has_idle_cores and enabled through update_idle_core() above.
+ * sd_llc->shared->idle_core and enabled through update_idle_core() above.
  */
 static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpus, int *idle_cpu)
 {
@@ -6102,11 +6104,11 @@ static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpu
 
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
@@ -6127,7 +6129,8 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 {
 	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
 	int i, cpu, idle_cpu = -1, nr = INT_MAX;
-	bool smt = test_idle_cores(target, false);
+	int idle_core = get_idle_core(target, -1);
+	bool smt = (idle_core != -1);
 	int this = smp_processor_id();
 	struct sched_domain *this_sd;
 	u64 time;
@@ -6160,8 +6163,13 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 	for_each_cpu_wrap(cpu, cpus, target) {
 		if (smt) {
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
@@ -6172,9 +6180,6 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 		}
 	}
 
-	if (smt)
-		set_idle_cores(this, false);
-
 	if (sched_feat(SIS_PROP) && !smt) {
 		time = cpu_clock(this) - time;
 		update_avg(&this_sd->avg_scan_cost, time);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 10a1522b1e30..46d40a281724 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1478,6 +1478,9 @@ static inline struct sched_domain *lowest_flag_domain(int cpu, int flag)
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
index 09d35044bd88..8db40c8a6ad0 100644
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
@@ -1466,6 +1472,7 @@ sd_init(struct sched_domain_topology_level *tl,
 		sd->shared = *per_cpu_ptr(sdd->sds, sd_id);
 		atomic_inc(&sd->shared->ref);
 		atomic_set(&sd->shared->nr_busy_cpus, sd_weight);
+		sd->shared->idle_core = -1;
 	}
 
 	sd->private = sdd;
-- 
2.18.2

