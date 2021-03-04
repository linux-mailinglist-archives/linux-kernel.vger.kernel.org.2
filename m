Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A99C32D8A3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 18:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236739AbhCDRcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 12:32:04 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53826 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233080AbhCDRbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 12:31:44 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 124H2Wls016659;
        Thu, 4 Mar 2021 12:29:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=MWR8I6ikhjPMuCiKf5YLMXJLnTKtXt9+iOJnJ15RFKQ=;
 b=VyLadUfv2PBeBeKDTtLltqhntl/ZWk2L9CjKR7HFy7/OoIH2FqkN/Fdi59r5DvNI0Cwd
 0h7q4G8YKy2x11y6E4lM9cnhlrBzxTY0/aMUgAn1rY71ydeE4Zr47Z0K4hsTfMYiHYQz
 dKg9M30LarXTS8N0ylhUrNLSG7s6CS+7Uz3uidXK8PxtUSALZ4GvJHHtdNvbDHysbg5l
 waxT7WTbnUXW0Hh2hIaPBAcwyZ/3LT6KV83G4AIZOP6k8LWvScB3Q6iioEMN/lTOIsA/
 LMSQhHdir2s57wQGu7kfvGCY1EFocmUQkQ1LnLt2AqSHGzwo+x7vM/4e5MKGAR431VnP KA== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3733542f4f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Mar 2021 12:29:23 -0500
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 124HTKCx020980;
        Thu, 4 Mar 2021 17:29:20 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma02fra.de.ibm.com with ESMTP id 36yj532hm4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Mar 2021 17:29:20 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 124HTIuV30277924
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 4 Mar 2021 17:29:18 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DF02D52052;
        Thu,  4 Mar 2021 17:29:17 +0000 (GMT)
Received: from saptagiri.in.ibm.com (unknown [9.199.33.177])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 860985205A;
        Thu,  4 Mar 2021 17:29:14 +0000 (GMT)
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
        Michael Neuling <mikey@neuling.org>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Parth Shah <parth@linux.ibm.com>
Subject: [PATCH v2] sched/fair: Prefer idle CPU to cache affinity
Date:   Thu,  4 Mar 2021 22:59:11 +0530
Message-Id: <20210304172911.101751-1-srikar@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-04_05:2021-03-03,2021-03-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 impostorscore=0 mlxscore=0
 spamscore=0 phishscore=0 mlxlogscore=999 clxscore=1015 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103040079
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On POWER8 and POWER9, the last level cache (L2) has been at the level of
a group of 8 threads (SMT8 on POWER8, a big-core comprising of a pair of
SMT4 cores on POWER9). However, on POWER10, the LLC domain is at the
level of a group of SMT4 threads within the SMT8 core. Due to the
shrinking in the size of the LLC domain, the probability of finding an
idle CPU in the LLC domain of the target is lesser on POWER10 compared
to the previous generation processors.

With commit 9538abee18cc ("powerpc/smp: Add support detecting
thread-groups sharing L2 cache") benchmarks such as Daytrader
(https://github.com/WASdev/sample.daytrader7) show a drop in throughput
in a configuration consisting of 1 JVM spanning across 6-8 Bigcores on
POWER10.  Analysis showed that this was because more number of wakeups
were happening on busy CPUs when the utilization was 60-70%. This drop
in throughput also shows up as a drop in CPU utilization. However most
other benchmarks benefit with detecting the thread-groups that share L2
cache.

Current order of preference to pick a LLC while waking a wake-affine
task:
1. Between the waker CPU and previous CPU, prefer the LLC of the CPU
   that is idle.

2. Between the waker CPU and previous CPU, prefer the LLC of the CPU
   that is less lightly loaded.

In the current situation where waker and previous CPUs are busy, but
only one of its LLC has an idle CPU, Scheduler may end up picking a LLC
with no idle CPUs. To mitigate this, add a new step between 1 and 2
where Scheduler compares idle CPUs in waker and previous LLCs and picks
the appropriate one.

The other alternative is to search for an idle CPU in the other LLC, if
the current select_idle_sibling is unable to find an idle CPU in the
preferred LLC. But that may increase the time to select a CPU.

80USERS                     5.11-rc6     5.11-rc6+revert  5.11-rc6+patch
8CORE/1JVM   throughput     6651.6       6716.3 (0.97%)   6670 (0.27%)
             sys/user:time  59.75/23.86  61.77/24.55      56.34/22.65

8CORE/2JVM   throughput     6425.4       6446.8 (0.33%)   6627.9 (3.15%)
             sys/user:time  70.59/24.25  72.28/23.77      67.50/23.67

8CORE/4JVM   throughput     5355.3       5551.2 (3.66%)   5417.3 (1.58%)
             sys/user:time  76.74/21.79  76.54/22.73      74.77/21.86

8CORE/8JVM   throughput     4420.6       4553.3 (3.00%)   4486.2 (1.48%)
             sys/user:time  79.13/20.32  78.76/21.01      78.14/20.19

Cc: LKML <linux-kernel@vger.kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Michael Neuling <mikey@neuling.org>
Cc: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Cc: Parth Shah <parth@linux.ibm.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Rik van Riel <riel@surriel.com>
Co-developed-by: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Signed-off-by: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Co-developed-by: Parth Shah <parth@linux.ibm.com>
Signed-off-by: Parth Shah <parth@linux.ibm.com>
Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
Changelog v1->v2:
v1: http://lore.kernel.org/lkml/20210226164029.122432-1-srikar@linux.vnet.ibm.com/t/#u
- Make WA_WAKER default (Suggested by Rik)
- Make WA_WAKER check more conservative: (Suggested by Rik / Peter)
- s/pllc_size/tllc_size while checking for busy case: (Pointed by Dietmar)
- Add rcu_read_lock and check for validity of shared domains

 kernel/sched/fair.c     | 57 +++++++++++++++++++++++++++++++++++++++--
 kernel/sched/features.h |  2 ++
 kernel/sched/sched.h    |  1 +
 kernel/sched/topology.c |  2 ++
 4 files changed, 60 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8a8bd7b13634..492ba07e4f51 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5869,6 +5869,52 @@ wake_affine_weight(struct sched_domain *sd, struct task_struct *p,
 	return this_eff_load < prev_eff_load ? this_cpu : nr_cpumask_bits;
 }
 
+#ifdef CONFIG_NO_HZ_COMMON
+static int prefer_idler_llc(int this_cpu, int prev_cpu, int sync)
+{
+	struct sched_domain_shared *tsds, *psds;
+	int pnr_busy, pllc_size, tnr_busy, tllc_size;
+	unsigned int smt_size = per_cpu(smt_size, this_cpu);
+	int diff;
+
+	rcu_read_lock();
+	tsds = rcu_dereference(per_cpu(sd_llc_shared, this_cpu));
+	psds = rcu_dereference(per_cpu(sd_llc_shared, prev_cpu));
+	if (!tsds || !psds) {
+		rcu_read_unlock();
+		return nr_cpumask_bits;
+	}
+
+	tnr_busy = atomic_read(&tsds->nr_busy_cpus);
+	pnr_busy = atomic_read(&psds->nr_busy_cpus);
+	rcu_read_unlock();
+
+	tllc_size = per_cpu(sd_llc_size, this_cpu);
+	pllc_size = per_cpu(sd_llc_size, prev_cpu);
+
+	/* No need to compare, if both LLCs are fully loaded */
+	if (pnr_busy == pllc_size && tnr_busy == tllc_size)
+		return nr_cpumask_bits;
+
+	if (sched_feat(WA_WAKER) && tnr_busy < tllc_size / smt_size)
+		return this_cpu;
+
+	/* For better wakeup latency, prefer idler LLC to cache affinity */
+	diff = tnr_busy * pllc_size - sync - pnr_busy * tllc_size;
+	if (!diff)
+		return nr_cpumask_bits;
+	if (diff < 0)
+		return this_cpu;
+
+	return prev_cpu;
+}
+#else
+static int prefer_idler_llc(int this_cpu, int prev_cpu, int sync)
+{
+	return nr_cpumask_bits;
+}
+#endif /* CONFIG_NO_HZ_COMMON */
+
 static int wake_affine(struct sched_domain *sd, struct task_struct *p,
 		       int this_cpu, int prev_cpu, int sync)
 {
@@ -5877,6 +5923,10 @@ static int wake_affine(struct sched_domain *sd, struct task_struct *p,
 	if (sched_feat(WA_IDLE))
 		target = wake_affine_idle(this_cpu, prev_cpu, sync);
 
+	if (sched_feat(WA_IDLER_LLC) && target == nr_cpumask_bits &&
+				!cpus_share_cache(this_cpu, prev_cpu))
+		target = prefer_idler_llc(this_cpu, prev_cpu, sync);
+
 	if (sched_feat(WA_WEIGHT) && target == nr_cpumask_bits)
 		target = wake_affine_weight(sd, p, this_cpu, prev_cpu, sync);
 
@@ -5884,8 +5934,11 @@ static int wake_affine(struct sched_domain *sd, struct task_struct *p,
 	if (target == nr_cpumask_bits)
 		return prev_cpu;
 
-	schedstat_inc(sd->ttwu_move_affine);
-	schedstat_inc(p->se.statistics.nr_wakeups_affine);
+	if (target == this_cpu) {
+		schedstat_inc(sd->ttwu_move_affine);
+		schedstat_inc(p->se.statistics.nr_wakeups_affine);
+	}
+
 	return target;
 }
 
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 1bc2b158fc51..c7b565775fe7 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -83,6 +83,8 @@ SCHED_FEAT(ATTACH_AGE_LOAD, true)
 
 SCHED_FEAT(WA_IDLE, true)
 SCHED_FEAT(WA_WEIGHT, true)
+SCHED_FEAT(WA_IDLER_LLC, true)
+SCHED_FEAT(WA_WAKER, true)
 SCHED_FEAT(WA_BIAS, true)
 
 /*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 10a1522b1e30..85e7804c3a55 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1478,6 +1478,7 @@ static inline struct sched_domain *lowest_flag_domain(int cpu, int flag)
 DECLARE_PER_CPU(struct sched_domain __rcu *, sd_llc);
 DECLARE_PER_CPU(int, sd_llc_size);
 DECLARE_PER_CPU(int, sd_llc_id);
+DECLARE_PER_CPU(int, smt_size);
 DECLARE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
 DECLARE_PER_CPU(struct sched_domain __rcu *, sd_numa);
 DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 09d35044bd88..f2aaeed93f94 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -644,6 +644,7 @@ static void destroy_sched_domains(struct sched_domain *sd)
 DEFINE_PER_CPU(struct sched_domain __rcu *, sd_llc);
 DEFINE_PER_CPU(int, sd_llc_size);
 DEFINE_PER_CPU(int, sd_llc_id);
+DEFINE_PER_CPU(int, smt_size);
 DEFINE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
 DEFINE_PER_CPU(struct sched_domain __rcu *, sd_numa);
 DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
@@ -667,6 +668,7 @@ static void update_top_cache_domain(int cpu)
 	rcu_assign_pointer(per_cpu(sd_llc, cpu), sd);
 	per_cpu(sd_llc_size, cpu) = size;
 	per_cpu(sd_llc_id, cpu) = id;
+	per_cpu(smt_size) = cpumask_weight(cpu_smt_mask(cpu))
 	rcu_assign_pointer(per_cpu(sd_llc_shared, cpu), sds);
 
 	sd = lowest_flag_domain(cpu, SD_NUMA);
-- 
2.18.4

