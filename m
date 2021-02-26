Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05DEA3265BE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 17:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbhBZQmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 11:42:52 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27256 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230087AbhBZQmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 11:42:40 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11QGXEQk052748;
        Fri, 26 Feb 2021 11:41:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=K3DYIlWypkL55/JmMleuk0xOoXsZIayghxQ9QnsumB8=;
 b=WEHyJV7cFPhxqOMWX+IIavr4T/VAB+N/llxqS8BMOaPRvtQCcnCS1H60V1MIWen6xeva
 M9DfOp8lh9My5Q/frm2uqi0dJ536uoOQX991b+SQwYSzHZ6eD2O+Y5+Ur6pnR/36piBM
 q8qr19UJCJpKdhHUL14FvYZ4ZCxEo5zgsWImb9TjkkDwaNLWYUZaTVbyB4f7Cj5czViu
 7ZDrP5hnhePvjRMEx/+FEWxHCNnW9yU9CZdoZdsFzo64nvNqfFJOyJS7uzrb/T7CWpnl
 wlS7jXaKXv2tREnb1G0bqPIOfVZAXpf/t/l79u4XaePllMpZm3Qs9tKkMaajHAnLzLRB KA== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36xrf56mh9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Feb 2021 11:41:36 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11QGWDWp002115;
        Fri, 26 Feb 2021 16:41:34 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 36y223g45u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Feb 2021 16:41:34 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11QGfWF533685982
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Feb 2021 16:41:32 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EAE9442047;
        Fri, 26 Feb 2021 16:41:31 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F3B3242041;
        Fri, 26 Feb 2021 16:41:28 +0000 (GMT)
Received: from saptagiri.in.ibm.com (unknown [9.85.73.168])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 26 Feb 2021 16:41:28 +0000 (GMT)
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
Subject: [PATCH] sched/fair: Prefer idle CPU to cache affinity
Date:   Fri, 26 Feb 2021 22:10:29 +0530
Message-Id: <20210226164029.122432-1-srikar@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-26_05:2021-02-26,2021-02-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxscore=0 mlxlogscore=979 clxscore=1011 lowpriorityscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 adultscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102260123
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


                                     5.11-rc6      5.11-rc6+revert   5.11-rc6+patch
8CORE/1JVM  80USERS   throughput     6651.6        6716.3 (0.97%)    6940 (4.34%)
                      sys/user:time  59.75/23.86   61.77/24.55       60/24

8CORE/2JVM  80USERS   throughput     6425.4        6446.8 (0.33%)    6473.2 (0.74%)
                      sys/user:time  70.59/24.25   72.28/23.77       70/24

8CORE/4JVM  80USERS   throughput     5355.3        5551.2 (3.66%)    5586.6 (4.32%)
                      sys/user:time  76.74/21.79   76.54/22.73       76/22

8CORE/8JVM  80USERS   throughput     4420.6        4553.3 (3.00%)    4405.8 (-0.33%)
                      sys/user:time  79.13/20.32   78.76/21.01       79/20

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
Co-developed-by: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Signed-off-by: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Co-developed-by: Parth Shah <parth@linux.ibm.com>
Signed-off-by: Parth Shah <parth@linux.ibm.com>
Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
 kernel/sched/fair.c     | 41 +++++++++++++++++++++++++++++++++++++++--
 kernel/sched/features.h |  2 ++
 2 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8a8bd7b13634..d49bfcdc4a19 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5869,6 +5869,36 @@ wake_affine_weight(struct sched_domain *sd, struct task_struct *p,
 	return this_eff_load < prev_eff_load ? this_cpu : nr_cpumask_bits;
 }

+static int prefer_idler_llc(int this_cpu, int prev_cpu, int sync)
+{
+	struct sched_domain_shared *tsds, *psds;
+	int pnr_busy, pllc_size, tnr_busy, tllc_size, diff;
+
+	tsds = rcu_dereference(per_cpu(sd_llc_shared, this_cpu));
+	tnr_busy = atomic_read(&tsds->nr_busy_cpus);
+	tllc_size = per_cpu(sd_llc_size, this_cpu);
+
+	psds = rcu_dereference(per_cpu(sd_llc_shared, prev_cpu));
+	pnr_busy = atomic_read(&psds->nr_busy_cpus);
+	pllc_size = per_cpu(sd_llc_size, prev_cpu);
+
+	/* No need to compare, if both LLCs are fully loaded */
+	if (pnr_busy == pllc_size && tnr_busy == pllc_size)
+		return nr_cpumask_bits;
+
+	if (sched_feat(WA_WAKER) && tnr_busy < tllc_size)
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
+
 static int wake_affine(struct sched_domain *sd, struct task_struct *p,
 		       int this_cpu, int prev_cpu, int sync)
 {
@@ -5877,6 +5907,10 @@ static int wake_affine(struct sched_domain *sd, struct task_struct *p,
 	if (sched_feat(WA_IDLE))
 		target = wake_affine_idle(this_cpu, prev_cpu, sync);

+	if (sched_feat(WA_IDLER_LLC) && target == nr_cpumask_bits &&
+				!cpus_share_cache(this_cpu, prev_cpu))
+		target = prefer_idler_llc(this_cpu, prev_cpu, sync);
+
 	if (sched_feat(WA_WEIGHT) && target == nr_cpumask_bits)
 		target = wake_affine_weight(sd, p, this_cpu, prev_cpu, sync);

@@ -5884,8 +5918,11 @@ static int wake_affine(struct sched_domain *sd, struct task_struct *p,
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
index 1bc2b158fc51..e2de3ba8d5b1 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -83,6 +83,8 @@ SCHED_FEAT(ATTACH_AGE_LOAD, true)

 SCHED_FEAT(WA_IDLE, true)
 SCHED_FEAT(WA_WEIGHT, true)
+SCHED_FEAT(WA_IDLER_LLC, true)
+SCHED_FEAT(WA_WAKER, false)
 SCHED_FEAT(WA_BIAS, true)

 /*
--
2.18.4

