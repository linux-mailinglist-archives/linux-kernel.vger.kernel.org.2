Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46F23367E93
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 12:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235939AbhDVKZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 06:25:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52962 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235889AbhDVKZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 06:25:02 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13MAIs42060770;
        Thu, 22 Apr 2021 06:24:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=vaWvgRxJ8ccRkMEggWT3QDMmF0VkUhEZdHOBQAbh/sM=;
 b=L+Y25A3GnG84NwNZfGreMd14j9e2C0F3Ar1R4O4eZc8maWPGUPfgKdzEDaU5j8x4LeK/
 ov3EygNnZ1gFSNqZFrkI+9gXLxcHh1gTcfynJZV9/rTwelJEzTBhoksFB+wTnjfRw89N
 kbW6s8y9COBSr968I1t1PDOrfqIOwLMixSJYUPqrWJVPRjCHHAY7w4JxglSKioBEAXF1
 yO4A9b7pEAcoH1b+Zdjj0MSaQiKZbMDSxsqc8rB565gClLYmnT6MZqVbnPjlw4/DZfNz
 6adG8w6lVgup9tSx0B+4mwPMvYYpOexQIC97W0KZM15mgIstQjdi06sW9iJvFmnipQkv rw== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3836kbhfn0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Apr 2021 06:24:14 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13MAMtrc032208;
        Thu, 22 Apr 2021 10:24:12 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03fra.de.ibm.com with ESMTP id 37yqa89j3h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Apr 2021 10:24:12 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13MAOA8p31195558
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Apr 2021 10:24:10 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DB717AE05D;
        Thu, 22 Apr 2021 10:24:09 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BAEAFAE04D;
        Thu, 22 Apr 2021 10:24:06 +0000 (GMT)
Received: from saptagiri.in.ibm.com (unknown [9.199.63.107])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 22 Apr 2021 10:24:06 +0000 (GMT)
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
        Michael Ellerman <mpe@ellerman.id.au>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Parth Shah <parth@linux.ibm.com>
Subject: [PATCH 09/10] sched/topology: Introduce fallback LLC
Date:   Thu, 22 Apr 2021 15:53:25 +0530
Message-Id: <20210422102326.35889-10-srikar@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210422102326.35889-1-srikar@linux.vnet.ibm.com>
References: <20210422102326.35889-1-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Qk-cdOfGAp5_WR77O8XqnsdEGpg-wJ7f
X-Proofpoint-GUID: Qk-cdOfGAp5_WR77O8XqnsdEGpg-wJ7f
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-22_04:2021-04-21,2021-04-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 adultscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 impostorscore=0 spamscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104220084
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some systems, LLC sizes may be too small. Some of these systems may
also support multiple cache access latency levels i.e between the
previous LLC and waker LLC, there could be other LLCs that have a lesser
cache access latency to waker LLC. If the waker LLC is busy, then
scheduler could choose to scheduler a task on such LLC.

Here is one approach to identity a static fallback LLC for each LLC for
systems that support multiple cache access latency levels. In this
approach, the fallback LLCs are decided at boot/CPU bring up time. There
is a one-to-one mapping between the LLC and fallback LLC.  The fallback
LLC will only be used if wakeup is a sync wakeup and the current LLC is
more busy than the fallback LLC. Also scheduler will not choose fallback
LLC if the previous LLC has same cache access latency as fallback LLC.

It is expected that fallback LLC has to be part of parent domain of
LLC domain. Archs can choose to use fallback LLC by setting the
SD_FALLBACK_LLC flag.

Cc: LKML <linux-kernel@vger.kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
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
 include/linux/sched/sd_flags.h |  7 ++++++
 include/linux/sched/topology.h |  1 +
 kernel/sched/fair.c            | 43 +++++++++++++++++++++++++++++---
 kernel/sched/topology.c        | 45 ++++++++++++++++++++++++++++++++--
 4 files changed, 90 insertions(+), 6 deletions(-)

diff --git a/include/linux/sched/sd_flags.h b/include/linux/sched/sd_flags.h
index 34b21e971d77..3ca44dd421e4 100644
--- a/include/linux/sched/sd_flags.h
+++ b/include/linux/sched/sd_flags.h
@@ -129,6 +129,13 @@ SD_FLAG(SD_SERIALIZE, SDF_SHARED_PARENT | SDF_NEEDS_GROUPS)
  */
 SD_FLAG(SD_ASYM_PACKING, SDF_SHARED_CHILD | SDF_NEEDS_GROUPS)
 
+/*
+ * Consider waking task on near-by idle LLC.
+ *
+ * NEEDS_GROUPS: Load balancing flag.
+ */
+SD_FLAG(SD_FALLBACK_LLC, SDF_NEEDS_GROUPS)
+
 /*
  * Prefer to place tasks in a sibling domain
  *
diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 285165a35f21..b0446191319a 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -74,6 +74,7 @@ struct sched_domain_shared {
 	atomic_t	ref;
 	atomic_t	nr_busy_cpus;
 	int		idle_core;
+	int		fallback_llc_id;
 };
 
 struct sched_domain {
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index db5dc9875e4c..8ea6d0183fc8 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5873,7 +5873,8 @@ static int wake_affine_idler_llc(struct task_struct *p, int this_cpu, int prev_c
 {
 	int pnr_busy, pllc_size, tnr_busy, tllc_size;
 	struct sched_domain_shared *tsds, *psds;
-	int diff;
+	bool try_fallback = false;
+	int diff, fcpu = -1;
 
 	tsds = rcu_dereference(per_cpu(sd_llc_shared, this_cpu));
 	psds = rcu_dereference(per_cpu(sd_llc_shared, prev_cpu));
@@ -5890,6 +5891,43 @@ static int wake_affine_idler_llc(struct task_struct *p, int this_cpu, int prev_c
 		}
 	}
 
+	tnr_busy = atomic_read(&tsds->nr_busy_cpus);
+	tllc_size = per_cpu(sd_llc_size, this_cpu);
+
+	if (sync) {
+		struct sched_domain *sd = rcu_dereference(per_cpu(sd_llc, this_cpu));
+
+		/*
+		 * task is a target of *sync* wakeup. However there are no
+		 * idle cores in the waking CPU. Ignore fallback LLC if the
+		 * previous CPU is part of the LLC's parent domain.
+		 */
+		try_fallback = !cpumask_test_cpu(prev_cpu, sched_domain_span(sd->parent));
+		fcpu = tsds->fallback_llc_id;
+	}
+
+	if (try_fallback && fcpu != -1 && cpumask_test_cpu(fcpu, p->cpus_ptr)) {
+		struct sched_domain_shared *fsds;
+		int fnr_busy, fllc_size;
+
+		fsds = rcu_dereference(per_cpu(sd_llc_shared, fcpu));
+		if (fsds && fsds != psds) {
+			if (fsds->idle_core != -1) {
+				if (cpumask_test_cpu(fsds->idle_core, p->cpus_ptr))
+					return fsds->idle_core;
+				return fcpu;
+			}
+
+			fnr_busy = atomic_read(&fsds->nr_busy_cpus);
+			fllc_size = per_cpu(sd_llc_size, fcpu);
+			if (fnr_busy * tllc_size < tnr_busy * fllc_size) {
+				tnr_busy = fnr_busy;
+				tllc_size = fllc_size;
+				this_cpu = fcpu;
+			}
+		}
+	}
+
 	if (available_idle_cpu(prev_cpu) || sched_idle_cpu(prev_cpu))
 		return prev_cpu;
 	if (psds->idle_core != -1) {
@@ -5908,10 +5946,7 @@ static int wake_affine_idler_llc(struct task_struct *p, int this_cpu, int prev_c
 		}
 	}
 
-	tnr_busy = atomic_read(&tsds->nr_busy_cpus);
 	pnr_busy = atomic_read(&psds->nr_busy_cpus);
-
-	tllc_size = per_cpu(sd_llc_size, this_cpu);
 	pllc_size = per_cpu(sd_llc_size, prev_cpu);
 
 	if (pnr_busy == pllc_size && tnr_busy == tllc_size) {
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 00e4669bb241..89aa8986c58b 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -603,6 +603,8 @@ static void free_sched_groups(struct sched_group *sg, int free_sgc)
 
 static void destroy_sched_domain(struct sched_domain *sd)
 {
+	struct sched_domain_shared *sds = sd->shared;
+
 	/*
 	 * A normal sched domain may have multiple group references, an
 	 * overlapping domain, having private groups, only one.  Iterate,
@@ -610,8 +612,18 @@ static void destroy_sched_domain(struct sched_domain *sd)
 	 */
 	free_sched_groups(sd->groups, 1);
 
-	if (sd->shared && atomic_dec_and_test(&sd->shared->ref))
-		kfree(sd->shared);
+	if (sds && atomic_dec_and_test(&sds->ref)) {
+		struct sched_domain_shared *next_sds;
+
+		if (sds->fallback_llc_id != -1) {
+			next_sds = rcu_dereference(per_cpu(sd_llc_shared, sds->fallback_llc_id));
+			if (next_sds && next_sds->fallback_llc_id != -1)
+				next_sds->fallback_llc_id = -1;
+
+			sds->fallback_llc_id = -1;
+		}
+		kfree(sds);
+	}
 	kfree(sd);
 }
 
@@ -663,9 +675,36 @@ static void update_top_cache_domain(int cpu)
 
 	sd = highest_flag_domain(cpu, SD_SHARE_PKG_RESOURCES);
 	if (sd) {
+		struct sched_domain *sd_parent = sd->parent;
+
 		id = cpumask_first(sched_domain_span(sd));
 		size = cpumask_weight(sched_domain_span(sd));
 		sds = sd->shared;
+
+		if (sds->fallback_llc_id == -1 && sd_parent &&
+				sd_parent->flags & SD_FALLBACK_LLC) {
+			const struct cpumask *parent_span = sched_domain_span(sd->parent);
+			struct cpumask *span = sched_domains_tmpmask;
+			int fcpu;
+
+			/*
+			 * If LLC's parent domain has SD_FALLBACK_LLC flag
+			 * set and this LLC's fallback_llc_id is not yet
+			 * set, then walk through the LLC parent's domain to
+			 * find a fallback_llc.
+			 */
+			cpumask_andnot(span, parent_span, sched_domain_span(sd));
+			for_each_cpu_wrap(fcpu, span, cpu) {
+				struct sched_domain_shared *next_sds;
+
+				next_sds = rcu_dereference(per_cpu(sd_llc_shared, fcpu));
+				if (next_sds && next_sds->fallback_llc_id == -1) {
+					sds->fallback_llc_id = fcpu;
+					next_sds->fallback_llc_id = cpu;
+					break;
+				}
+			}
+		}
 	}
 
 	rcu_assign_pointer(per_cpu(sd_llc, cpu), sd);
@@ -1370,6 +1409,7 @@ int __read_mostly		node_reclaim_distance = RECLAIM_DISTANCE;
 #define TOPOLOGY_SD_FLAGS		\
 	(SD_SHARE_CPUCAPACITY	|	\
 	 SD_SHARE_PKG_RESOURCES |	\
+	 SD_FALLBACK_LLC	|	\
 	 SD_NUMA		|	\
 	 SD_ASYM_PACKING)
 
@@ -1475,6 +1515,7 @@ sd_init(struct sched_domain_topology_level *tl,
 		atomic_inc(&sd->shared->ref);
 		atomic_set(&sd->shared->nr_busy_cpus, sd_weight);
 		sd->shared->idle_core = -1;
+		sd->shared->fallback_llc_id = -1;
 	}
 
 	sd->private = sdd;
-- 
2.18.2

