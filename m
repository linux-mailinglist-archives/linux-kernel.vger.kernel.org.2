Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63EDA3758A6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 18:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236020AbhEFQrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 12:47:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:24060 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235933AbhEFQrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 12:47:15 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 146GXqAF169737;
        Thu, 6 May 2021 12:46:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Gmq3ucWbDb5L1KtuNknaXtseJTWMAZmmE9sJMi17hkY=;
 b=PWT7dgd8kBio2ANOICglJwzfMQ0dMl9U9ydh6k9QqZ3Dq7IncqhU+q0l5fQjKtGOocHy
 ce1h0AGaQKAP9roKo+TNGhy+hzwPV/UQLWonJF9wqXdt9w9QMkCprfX/as4bEyIIQ3Yi
 dKE7pxWhTSmSw7y8sa/74EYnBYQSfHJtMi2G0EFTHGbcW+r2vgawwX2dCRpjDHhNZ0Zr
 vqjv/AAz6h26r++y615KBY58bBMXiLS6xQ+SmhnG/19tvlaGwVnyGBZNRpXfq+48kgTv
 3UzV006LiI4FXDbu9YJCq0UIF/Td+iYWlrc6GMcks/UlJvFUm5JY67ZvwSE7GwshiXkq sw== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38cjb9ky65-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 May 2021 12:46:02 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 146GgPg1025973;
        Thu, 6 May 2021 16:46:00 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 38cfrqr81c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 May 2021 16:46:00 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 146Gjwug45875602
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 May 2021 16:45:58 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 64F49A4051;
        Thu,  6 May 2021 16:45:58 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0DBF3A4040;
        Thu,  6 May 2021 16:45:56 +0000 (GMT)
Received: from saptagiri.in.ibm.com (unknown [9.77.204.81])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  6 May 2021 16:45:55 +0000 (GMT)
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
Subject: [PATCH v2 3/8] sched/fair: Update idle-core more often
Date:   Thu,  6 May 2021 22:15:38 +0530
Message-Id: <20210506164543.90688-4-srikar@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210506164543.90688-1-srikar@linux.vnet.ibm.com>
References: <20210506164543.90688-1-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: BC_Qhse4c4SdhBimv8fc8m8L-_yrW5z6
X-Proofpoint-GUID: BC_Qhse4c4SdhBimv8fc8m8L-_yrW5z6
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-06_10:2021-05-06,2021-05-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 spamscore=0 clxscore=1015 mlxscore=0 malwarescore=0
 adultscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105060114
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
Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
 kernel/sched/fair.c  | 54 +++++++++++++++++++++++++++++++++++++++++---
 kernel/sched/idle.c  |  6 +++++
 kernel/sched/sched.h |  2 ++
 3 files changed, 59 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8c9d1a210820..50da2363317d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6015,6 +6015,13 @@ static inline int __select_idle_cpu(int cpu)
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
@@ -6037,6 +6044,40 @@ static inline int get_idle_core(int cpu, int def)
 	return def;
 }
 
+static void set_next_idle_core(struct sched_domain *sd, int target)
+{
+	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
+	int core, cpu;
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
@@ -6046,11 +6087,13 @@ static inline int get_idle_core(int cpu, int def)
  */
 void __update_idle_core(struct rq *rq)
 {
+	struct sched_domain *sd;
 	int core = cpu_of(rq);
 	int cpu;
 
 	rcu_read_lock();
-	if (get_idle_core(core, 0) >= 0)
+	sd = rcu_dereference(per_cpu(sd_llc, core));
+	if (!sd || get_idle_core(core, 0) >= 0)
 		goto unlock;
 
 	for_each_cpu(cpu, cpu_smt_mask(core)) {
@@ -6058,10 +6101,15 @@ void __update_idle_core(struct rq *rq)
 			continue;
 
 		if (!available_idle_cpu(cpu))
-			goto unlock;
+			goto try_next;
 	}
 
 	set_idle_core(core, per_cpu(smt_id, core));
+	goto unlock;
+
+try_next:
+	set_next_idle_core(sd, core);
+
 unlock:
 	rcu_read_unlock();
 }
@@ -6130,7 +6178,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
 	int i, cpu, idle_cpu = -1, nr = INT_MAX;
 	int idle_core = get_idle_core(target, -1);
-	bool smt = (idle_core != -1);
+	bool smt = (idle_core != -2);
 	int this = smp_processor_id();
 	struct sched_domain *this_sd;
 	u64 time;
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 7199e6f23789..cc828f3efe71 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -425,6 +425,12 @@ static void check_preempt_curr_idle(struct rq *rq, struct task_struct *p, int fl
 
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
index 46d40a281724..5c0bd4b0e73a 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1102,6 +1102,7 @@ static inline bool is_migration_disabled(struct task_struct *p)
 
 #ifdef CONFIG_SCHED_SMT
 extern void __update_idle_core(struct rq *rq);
+extern void set_core_busy(int cpu);
 
 static inline void update_idle_core(struct rq *rq)
 {
@@ -1111,6 +1112,7 @@ static inline void update_idle_core(struct rq *rq)
 
 #else
 static inline void update_idle_core(struct rq *rq) { }
+static inline void set_core_busy(int cpu) { }
 #endif
 
 DECLARE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
-- 
2.18.2

