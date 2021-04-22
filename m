Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74A00367E91
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 12:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235932AbhDVKZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 06:25:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34176 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235877AbhDVKY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 06:24:58 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13MA3VtN121664;
        Thu, 22 Apr 2021 06:24:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=0lfonzMjgGuLsMfJSIbTjpzf9KIbUe0NIUMFOewiXpY=;
 b=pAdpfbW88RJX2QEPt/oQRdOEPsNd1POYepwv3cWLEeqhh7+iUwd3dzgn3QcAMvVW7Dmr
 tjP/QdF9xm8DAuTeIk+RdNhedCeg+43LAcDoIO59e1nEYTxbQRGxsotdF+hFGwYvNOdH
 ce/mTxnaZtlMo2Eu4O0UZYj0i+9h94tX0rXRjaz5WJ0dnKmb4rQUvAuoaIOIlcPBvBT0
 SIcrUEmMvLVE9moFGM0410FlZLukTioXB4gQlOzaLRIxOuOVfuFUZzPz6xob/9QWgoKt
 Dpd311j2a04flrkjPG6uVxRQU0oixs2CMMFg941XJyerOnGvEDD3LQqA42w6xVFgytO1 oQ== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3835n0365t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Apr 2021 06:24:03 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13MALsev013071;
        Thu, 22 Apr 2021 10:24:02 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06fra.de.ibm.com with ESMTP id 37ypxh9j0q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Apr 2021 10:24:01 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13MANabh18022744
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Apr 2021 10:23:36 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 86C03AE05D;
        Thu, 22 Apr 2021 10:23:59 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B7964AE053;
        Thu, 22 Apr 2021 10:23:56 +0000 (GMT)
Received: from saptagiri.in.ibm.com (unknown [9.199.63.107])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 22 Apr 2021 10:23:56 +0000 (GMT)
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
Subject: [PATCH 06/10] sched/idle: Move busy_cpu accounting to idle callback
Date:   Thu, 22 Apr 2021 15:53:22 +0530
Message-Id: <20210422102326.35889-7-srikar@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210422102326.35889-1-srikar@linux.vnet.ibm.com>
References: <20210422102326.35889-1-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JCV6EUUr67Eb_yScyaYIorG4ZUZU3Ueo
X-Proofpoint-GUID: JCV6EUUr67Eb_yScyaYIorG4ZUZU3Ueo
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-22_04:2021-04-21,2021-04-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 mlxscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104220084
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we account nr_busy_cpus in no_hz idle functions.
There is no reason why nr_busy_cpus should updated be in NO_HZ_COMMON
configs only. Also scheduler can mark a CPU as non-busy as soon as an
idle class task starts to run. Scheduler can then mark a CPU as busy
as soon as its woken up from idle or a new task is placed on it's
runqueue.

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
 kernel/sched/fair.c     |  6 ++++--
 kernel/sched/idle.c     | 29 +++++++++++++++++++++++++++--
 kernel/sched/sched.h    |  1 +
 kernel/sched/topology.c |  2 ++
 4 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f8c98e544418..00bcf1d861b5 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10384,7 +10384,10 @@ static void set_cpu_sd_state_busy(int cpu)
 		goto unlock;
 	sd->nohz_idle = 0;
 
-	atomic_inc(&sd->shared->nr_busy_cpus);
+	if (sd && per_cpu(is_idle, cpu)) {
+		atomic_add_unless(&sd->shared->nr_busy_cpus, 1, per_cpu(sd_llc_size, cpu));
+		per_cpu(is_idle, cpu) = 0;
+	}
 unlock:
 	rcu_read_unlock();
 }
@@ -10414,7 +10417,6 @@ static void set_cpu_sd_state_idle(int cpu)
 		goto unlock;
 	sd->nohz_idle = 1;
 
-	atomic_dec(&sd->shared->nr_busy_cpus);
 unlock:
 	rcu_read_unlock();
 }
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index cc828f3efe71..e624a05e48bd 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -425,12 +425,25 @@ static void check_preempt_curr_idle(struct rq *rq, struct task_struct *p, int fl
 
 static void put_prev_task_idle(struct rq *rq, struct task_struct *prev)
 {
-#ifdef CONFIG_SCHED_SMT
+#ifdef CONFIG_SMP
+	struct sched_domain_shared *sds;
 	int cpu = rq->cpu;
 
+#ifdef CONFIG_SCHED_SMT
 	if (static_branch_likely(&sched_smt_present))
 		set_core_busy(cpu);
 #endif
+
+	rcu_read_lock();
+	sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
+	if (sds) {
+		if (per_cpu(is_idle, cpu)) {
+			atomic_inc(&sds->nr_busy_cpus);
+			per_cpu(is_idle, cpu) = 0;
+		}
+	}
+	rcu_read_unlock();
+#endif
 }
 
 static void set_next_task_idle(struct rq *rq, struct task_struct *next, bool first)
@@ -442,9 +455,21 @@ static void set_next_task_idle(struct rq *rq, struct task_struct *next, bool fir
 struct task_struct *pick_next_task_idle(struct rq *rq)
 {
 	struct task_struct *next = rq->idle;
+#ifdef CONFIG_SMP
+	struct sched_domain_shared *sds;
+	int cpu = rq->cpu;
 
-	set_next_task_idle(rq, next, true);
+	rcu_read_lock();
+	sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
+	if (sds) {
+		atomic_add_unless(&sds->nr_busy_cpus, -1, 0);
+		per_cpu(is_idle, cpu) = 1;
+	}
 
+	rcu_read_unlock();
+#endif
+
+	set_next_task_idle(rq, next, true);
 	return next;
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 5c0bd4b0e73a..baf8d9a4cb26 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1483,6 +1483,7 @@ DECLARE_PER_CPU(int, sd_llc_id);
 #ifdef CONFIG_SCHED_SMT
 DECLARE_PER_CPU(int, smt_id);
 #endif
+DECLARE_PER_CPU(int, is_idle);
 DECLARE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
 DECLARE_PER_CPU(struct sched_domain __rcu *, sd_numa);
 DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 8db40c8a6ad0..00e4669bb241 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -647,6 +647,7 @@ DEFINE_PER_CPU(int, sd_llc_id);
 #ifdef CONFIG_SCHED_SMT
 DEFINE_PER_CPU(int, smt_id);
 #endif
+DEFINE_PER_CPU(int, is_idle);
 DEFINE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
 DEFINE_PER_CPU(struct sched_domain __rcu *, sd_numa);
 DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
@@ -673,6 +674,7 @@ static void update_top_cache_domain(int cpu)
 #ifdef CONFIG_SCHED_SMT
 	per_cpu(smt_id, cpu) = cpumask_first(cpu_smt_mask(cpu));
 #endif
+	per_cpu(is_idle, cpu) = 1;
 	rcu_assign_pointer(per_cpu(sd_llc_shared, cpu), sds);
 
 	sd = lowest_flag_domain(cpu, SD_NUMA);
-- 
2.18.2

