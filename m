Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10BB737F3A1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 09:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbhEMHmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 03:42:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41782 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231718AbhEMHmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 03:42:17 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14D7XkJY098435;
        Thu, 13 May 2021 03:40:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=4jWPjhIhDK59wxtdNJMTF2DFLIOrwLdcQVtyQiwUvdk=;
 b=WRF5YAK0ukFblv+er4FECWz4F4Bh0G0lmt8pbJmIPdAH197mrIpNMl6pVMzYBj/uWBh9
 xilV11poGgZ0c+HTUuaxzYxxHGiedLr0BeXWqaDgROXjscBcsSKLiBuNjrd/M7Xs5KJ9
 A1xhdNNaSjLT4XWfLMY59Var9rv48XCnjuIk2bAuvYSDyLhawcv0E8Lix7MRK0q28m57
 gaAgGXtr0GyKixzxqUDnMrIeBa9NlO/XFbCQPSc9jfb5Cx1Nw2+yz6c5zTjXiNaAVEVO
 29H4o1WLIiz2Jd9qgyFs/yVXXqaPRKT2quLCIE+H0f/jQ48X/7BUgHb/XAijRQLlY9Qz 8g== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38gysa084d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 May 2021 03:40:47 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14D7cL57018117;
        Thu, 13 May 2021 07:40:45 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04fra.de.ibm.com with ESMTP id 38ef37h7g9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 May 2021 07:40:44 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14D7eFjW36307212
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 May 2021 07:40:15 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 83434AE053;
        Thu, 13 May 2021 07:40:42 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2C2EAAE051;
        Thu, 13 May 2021 07:40:40 +0000 (GMT)
Received: from saptagiri.in.ibm.com (unknown [9.79.222.102])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 13 May 2021 07:40:39 +0000 (GMT)
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
Subject: [PATCH v3 3/8] sched/fair: Update idle-core more often
Date:   Thu, 13 May 2021 13:10:22 +0530
Message-Id: <20210513074027.543926-4-srikar@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210513074027.543926-1-srikar@linux.vnet.ibm.com>
References: <20210513074027.543926-1-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: u56jFaJtfKMOrtXjJKiOY7HRnHG1W2l9
X-Proofpoint-GUID: u56jFaJtfKMOrtXjJKiOY7HRnHG1W2l9
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-13_03:2021-05-12,2021-05-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 spamscore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105130056
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently when the scheduler does a load balance and pulls a task or
when a CPU picks up a task during wakeup without having to call
select_idle_cpu(), it never checks if the target CPU is part of the
idle-core. This makes idle-core less accurate.

Given that the identity of idle-core for LLC is maintained, its easy to
update the idle-core as soon as the CPU picks up a task.

This change will update the idle-core whenever a CPU from the idle-core
picks up a task. However if there are multiple idle-cores in the LLC,
and waking CPU happens to be part of the designated idle-core, idle-core
is set to -1. In cases where the scheduler is sure that there are no
more idle-cores, idle-core is set to -2.

To reduce this case, whenever a CPU updates idle-core, it will look for
other cores in the LLC for an idle-core, if the core to which it belongs
to is not idle.

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
 - Search for idle-cores in LLC only if idle-core is -1

 kernel/sched/fair.c  | 61 +++++++++++++++++++++++++++++++++++++++-----
 kernel/sched/idle.c  |  6 +++++
 kernel/sched/sched.h |  2 ++
 3 files changed, 63 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c42b2b3cd08f..d002bc95c0bc 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6039,6 +6039,13 @@ static inline int __select_idle_cpu(int cpu)
 DEFINE_STATIC_KEY_FALSE(sched_smt_present);
 EXPORT_SYMBOL_GPL(sched_smt_present);
 
+/*
+ * Value of -2 indicates there are no idle-cores in LLC.
+ * Value of -1 indicates an idle-core turned to busy recently.
+ * However there could be other idle-cores in the system.
+ * Anyother value indicates core to which the CPU(value)
+ * belongs is idle.
+ */
 static inline void set_idle_core(int cpu, int val)
 {
 	struct sched_domain_shared *sds;
@@ -6061,6 +6068,44 @@ static inline int get_idle_core(int cpu, int def)
 	return def;
 }
 
+static void set_next_idle_core(int target)
+{
+	struct sched_domain *sd = rcu_dereference(per_cpu(sd_llc, target));
+	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
+	int core, cpu;
+
+	if (!sd)
+		return;
+
+	cpumask_andnot(cpus, sched_domain_span(sd), cpu_smt_mask(target));
+	for_each_cpu_wrap(core, cpus, target) {
+		bool idle = true;
+
+		for_each_cpu(cpu, cpu_smt_mask(core)) {
+			if (!available_idle_cpu(cpu)) {
+				idle = false;
+				break;
+			}
+		}
+
+		if (idle) {
+			set_idle_core(core, per_cpu(smt_id, core));
+			return;
+		}
+
+		cpumask_andnot(cpus, cpus, cpu_smt_mask(core));
+	}
+	set_idle_core(target, -2);
+}
+
+void set_core_busy(int core)
+{
+	rcu_read_lock();
+	if (get_idle_core(core, -1) == per_cpu(smt_id, core))
+		set_idle_core(core, -1);
+	rcu_read_unlock();
+}
+
 /*
  * Scans the local SMT mask to see if the entire core is idle, and records this
  * information in sd_llc_shared->idle_core.
@@ -6071,21 +6116,25 @@ static inline int get_idle_core(int cpu, int def)
 void __update_idle_core(struct rq *rq)
 {
 	int core = cpu_of(rq);
-	int cpu;
+	int cpu, idlecore;
 
 	rcu_read_lock();
-	if (get_idle_core(core, 0) >= 0)
+	idlecore = get_idle_core(core, 0);
+	if (idlecore >= 0)
 		goto unlock;
 
 	for_each_cpu(cpu, cpu_smt_mask(core)) {
-		if (cpu == core)
+		if (cpu == core || available_idle_cpu(cpu))
 			continue;
 
-		if (!available_idle_cpu(cpu))
-			goto unlock;
+		if (idlecore == -1)
+			set_next_idle_core(core);
+
+		goto unlock;
 	}
 
 	set_idle_core(core, per_cpu(smt_id, core));
+
 unlock:
 	rcu_read_unlock();
 }
@@ -6176,7 +6225,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int i
 {
 	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
 	int i, cpu, idle_cpu = -1, nr = INT_MAX;
-	bool has_idle_core = (idle_core != -1);
+	bool has_idle_core = (idle_core != -2);
 	int this = smp_processor_id();
 	struct sched_domain *this_sd;
 	u64 time;
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 7ca3d3d86c2a..a9f5a8ace59e 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -431,6 +431,12 @@ static void check_preempt_curr_idle(struct rq *rq, struct task_struct *p, int fl
 
 static void put_prev_task_idle(struct rq *rq, struct task_struct *prev)
 {
+#ifdef CONFIG_SCHED_SMT
+	int cpu = rq->cpu;
+
+	if (static_branch_likely(&sched_smt_present))
+		set_core_busy(cpu);
+#endif
 }
 
 static void set_next_task_idle(struct rq *rq, struct task_struct *next, bool first)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 22fbb50b036e..98c3cfbc5d26 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1115,6 +1115,7 @@ static inline bool is_migration_disabled(struct task_struct *p)
 
 #ifdef CONFIG_SCHED_SMT
 extern void __update_idle_core(struct rq *rq);
+extern void set_core_busy(int cpu);
 
 static inline void update_idle_core(struct rq *rq)
 {
@@ -1124,6 +1125,7 @@ static inline void update_idle_core(struct rq *rq)
 
 #else
 static inline void update_idle_core(struct rq *rq) { }
+static inline void set_core_busy(int cpu) { }
 #endif
 
 DECLARE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
-- 
2.18.2

