Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27715367E8E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 12:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235874AbhDVKY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 06:24:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49832 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235803AbhDVKYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 06:24:49 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13MA35f8120623;
        Thu, 22 Apr 2021 06:23:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=OJXtzr10O9kIxuW4EFkY08fTBSSprXcPvM9+wWD3/D0=;
 b=P64qm5LsKahr5XM715o1Cv/Zh8zVbyxy3QtT7rcPBguLWS/m3TsfR8aNbTbadGM/IWeG
 3wnSsVQUK/WHUu4+bnRWtNRLZOdkuh+JoUS9wI33DgVAAyvO2Wqmmuo4thHWO7LKjuLD
 oGxro94C23t4+YPqjRb3AUW2gmgA7Yw34RBsA/O+5gryqfn6tSt3p/AXqZcqyLa2p3Fj
 0q73muf9AnMIWhUAkde+/PT1M6PzyKcHr9BU+LC6O9LClQVgXjP4moLEsKG6EM5N03YE
 bFpWonsiuYsESWfATkVTPNv8vN2jz7AvULVJglO8Ubel5MnjM5uAVKcCwwz8AfaVUyZO 0g== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3836u6s28d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Apr 2021 06:23:54 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13MAMtrb032208;
        Thu, 22 Apr 2021 10:23:52 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03fra.de.ibm.com with ESMTP id 37yqa89j3d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Apr 2021 10:23:51 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13MANnEb24052134
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Apr 2021 10:23:49 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A0416AE051;
        Thu, 22 Apr 2021 10:23:49 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A3952AE04D;
        Thu, 22 Apr 2021 10:23:46 +0000 (GMT)
Received: from saptagiri.in.ibm.com (unknown [9.199.63.107])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 22 Apr 2021 10:23:46 +0000 (GMT)
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
Subject: [PATCH 03/10] sched/fair: Update idle-core more often
Date:   Thu, 22 Apr 2021 15:53:19 +0530
Message-Id: <20210422102326.35889-4-srikar@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210422102326.35889-1-srikar@linux.vnet.ibm.com>
References: <20210422102326.35889-1-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: D9LNqGrQ9SqUjBe-Dfbl9uO--j1vw5a8
X-Proofpoint-ORIG-GUID: D9LNqGrQ9SqUjBe-Dfbl9uO--j1vw5a8
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-22_04:2021-04-21,2021-04-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 mlxlogscore=999 phishscore=0 bulkscore=0 impostorscore=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104220084
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
is set to -1 (i.e there are no idle-cores).

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
 kernel/sched/fair.c  | 44 ++++++++++++++++++++++++++++++++++++++++++--
 kernel/sched/idle.c  |  6 ++++++
 kernel/sched/sched.h |  2 ++
 3 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 03083eacdaf0..09c33cca0349 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6037,6 +6037,39 @@ static inline int get_idle_core(int cpu, int def)
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
@@ -6046,11 +6079,13 @@ static inline int get_idle_core(int cpu, int def)
  */
 void __update_idle_core(struct rq *rq)
 {
+	struct sched_domain *sd;
 	int core = cpu_of(rq);
 	int cpu;
 
 	rcu_read_lock();
-	if (get_idle_core(core, 0) != -1)
+	sd = rcu_dereference(per_cpu(sd_llc, core));
+	if (!sd || get_idle_core(core, 0) != -1)
 		goto unlock;
 
 	for_each_cpu(cpu, cpu_smt_mask(core)) {
@@ -6058,10 +6093,15 @@ void __update_idle_core(struct rq *rq)
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

