Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC7B63758AA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 18:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236107AbhEFQrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 12:47:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:1796 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236073AbhEFQrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 12:47:20 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 146GXQL7118984;
        Thu, 6 May 2021 12:46:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=koD3SVbYf2BTRS2iRBFusve8abxTZjjlBjDjo1/VsEM=;
 b=bF4ss4jzXgcp9QuGcz5/BAoajxFDRyBVXmgIRsn7eHDXpep35xZ2PGpZte0DrM4naovk
 ZN821uuNi1RfmE22C1rEM9kw6IJGKaWLNIQ/iZJLyY6GfdrpDPVX1P8Pz/9U6AoHo0z7
 PmJ1CWfuOAh1FbKoaoHqfRnHQwq2xSSi6TKeTHH6BL5AcW3hlwdaDUJc5uUz4CM7kgfA
 Zl+oO2jw1RZBujQ8Cq1pL65cSKwK8Od9WWnxztsi7jQ/lomlk3mYrBnOU+RLjYXWuZwL
 bXDxiZ4TPYaP09NXzl/gXxdsZZcJG1jznusH+7EgJlpbbMuuIR31YrHrw1PetDd2lEEU 5w== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38cgf3reke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 May 2021 12:46:06 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 146GgXCW017950;
        Thu, 6 May 2021 16:46:04 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma02fra.de.ibm.com with ESMTP id 38bee2gkrn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 May 2021 16:46:04 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 146Gk1PV18219308
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 May 2021 16:46:01 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4714FA4059;
        Thu,  6 May 2021 16:46:01 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B34D8A4040;
        Thu,  6 May 2021 16:45:58 +0000 (GMT)
Received: from saptagiri.in.ibm.com (unknown [9.77.204.81])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  6 May 2021 16:45:58 +0000 (GMT)
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
Subject: [PATCH v2 4/8] sched/fair: Prefer idle CPU to cache affinity
Date:   Thu,  6 May 2021 22:15:39 +0530
Message-Id: <20210506164543.90688-5-srikar@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210506164543.90688-1-srikar@linux.vnet.ibm.com>
References: <20210506164543.90688-1-srikar@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: H5JNuf36Mzci_ptRcHpWI81-TIeXR1Vt
X-Proofpoint-ORIG-GUID: H5JNuf36Mzci_ptRcHpWI81-TIeXR1Vt
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-06_10:2021-05-06,2021-05-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 impostorscore=0 spamscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105060114
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current order of preference to pick a LLC while waking a wake-affine
task:
1. Between the waker CPU and previous CPU, prefer the LLC of the CPU
   that is idle.

2. Between the waker CPU and previous CPU, prefer the LLC of the CPU
   that is less lightly loaded.

In the current situation where waker and previous CPUs are busy, but
only one of its LLC has an idle CPU, Scheduler may end up picking a LLC
with no idle CPUs. To mitigate this, add a method where Scheduler
compares idle CPUs in waker and previous LLCs and picks the appropriate
one.

The new method looks at idle-core to figure out idle LLC. If there are
no idle LLCs, it compares the ratio of busy CPUs to the total number of
CPUs in the LLC. This method will only be useful to compare 2 LLCs. If
the previous CPU and the waking CPU are in the same LLC, this method
would not be useful. For now the new method is disabled by default.

sync flag decides which CPU/LLC to try first. If sync is set, choose
current LLC, else choose previous LLC.

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
Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
Changelog: v1->v2:
 - Swap the cpus, if the wakeup is not sync, so that a single order of
 code suffices for both sync and non-sync wakeups.

 - Mel reported a crash. Apparently two threads can race to find an
 idle-core. I now cache the idlecore. Also use compare-exchange, so
 that no 2 waking tasks contend on the same CPU.

Also Based on similar posting:
http://lore.kernel.org/lkml/20210226164029.122432-1-srikar@linux.vnet.ibm.com/t/#u
- Make WA_WAKER default (Suggested by Rik) : done in next patch
- Make WA_WAKER check more conservative: (Suggested by Rik / Peter)
- Rename WA_WAKER to WA_IDLER_LLC (Suggested by Vincent)
- s/pllc_size/tllc_size while checking for busy case: (Pointed by Dietmar)
- Add rcu_read_lock and check for validity of shared domains
- Add idle-core support

 kernel/sched/fair.c     | 66 +++++++++++++++++++++++++++++++++++++++++
 kernel/sched/features.h |  1 +
 2 files changed, 67 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 50da2363317d..72bf1996903d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5869,6 +5869,59 @@ wake_affine_weight(struct sched_domain *sd, struct task_struct *p,
 	return this_eff_load < prev_eff_load ? this_cpu : nr_cpumask_bits;
 }
 
+static inline bool test_reset_idle_core(struct sched_domain_shared *sds, int val);
+
+static int wake_affine_idler_llc(struct task_struct *p, int pref_cpu, int try_cpu, int sync)
+{
+#ifdef CONFIG_NO_HZ_COMMON
+	int tnr_busy, tllc_size, pnr_busy, pllc_size;
+#endif
+	struct sched_domain_shared *pref_sds, *try_sds;
+	int diff, idle_core;
+
+	if (!sync)
+		swap(pref_cpu, try_cpu);
+
+	pref_sds = rcu_dereference(per_cpu(sd_llc_shared, pref_cpu));
+	try_sds = rcu_dereference(per_cpu(sd_llc_shared, try_cpu));
+	if (!pref_sds || !try_sds)
+		return nr_cpumask_bits;
+
+	if (available_idle_cpu(pref_cpu) || sched_idle_cpu(pref_cpu))
+		return pref_cpu;
+
+	idle_core = READ_ONCE(pref_sds->idle_core);
+	if (idle_core > -1 && cpumask_test_cpu(idle_core, p->cpus_ptr) &&
+				test_reset_idle_core(pref_sds, idle_core))
+		return idle_core;
+
+	if (available_idle_cpu(try_cpu) || sched_idle_cpu(try_cpu))
+		return try_cpu;
+
+	idle_core = READ_ONCE(try_sds->idle_core);
+	if (idle_core > -1 && cpumask_test_cpu(idle_core, p->cpus_ptr) &&
+				test_reset_idle_core(try_sds, idle_core))
+		return idle_core;
+
+#ifdef CONFIG_NO_HZ_COMMON
+	pnr_busy = atomic_read(&pref_sds->nr_busy_cpus);
+	tnr_busy = atomic_read(&try_sds->nr_busy_cpus);
+	pllc_size = per_cpu(sd_llc_size, pref_cpu);
+	tllc_size = per_cpu(sd_llc_size, try_cpu);
+
+	if (tnr_busy == tllc_size && pnr_busy == pllc_size)
+		return nr_cpumask_bits;
+
+	diff = tnr_busy * pllc_size - pnr_busy * tllc_size;
+	if (diff > 0)
+		return pref_cpu;
+	if (diff < 0)
+		return try_cpu;
+#endif /* CONFIG_NO_HZ_COMMON */
+
+	return nr_cpumask_bits;
+}
+
 static int wake_affine(struct sched_domain *sd, struct task_struct *p,
 		       int this_cpu, int prev_cpu, int sync)
 {
@@ -5877,6 +5930,9 @@ static int wake_affine(struct sched_domain *sd, struct task_struct *p,
 	if (sched_feat(WA_IDLE))
 		target = wake_affine_idle(this_cpu, prev_cpu, sync);
 
+	if (sched_feat(WA_IDLER_LLC) && target == nr_cpumask_bits)
+		target = wake_affine_idler_llc(p, this_cpu, prev_cpu, sync);
+
 	if (sched_feat(WA_WEIGHT) && target == nr_cpumask_bits)
 		target = wake_affine_weight(sd, p, this_cpu, prev_cpu, sync);
 
@@ -6044,6 +6100,11 @@ static inline int get_idle_core(int cpu, int def)
 	return def;
 }
 
+static inline bool test_reset_idle_core(struct sched_domain_shared *sds, int val)
+{
+	return cmpxchg(&sds->idle_core, val, -1) == val;
+}
+
 static void set_next_idle_core(struct sched_domain *sd, int target)
 {
 	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
@@ -6161,6 +6222,11 @@ static inline bool get_idle_core(int cpu, int def)
 	return def;
 }
 
+static inline bool test_reset_idle_core(struct sched_domain_shared *sds, int val)
+{
+	return false;
+}
+
 static inline int select_idle_core(struct task_struct *p, int core, struct cpumask *cpus, int *idle_cpu)
 {
 	return __select_idle_cpu(core);
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 1bc2b158fc51..c77349a47e01 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -83,6 +83,7 @@ SCHED_FEAT(ATTACH_AGE_LOAD, true)
 
 SCHED_FEAT(WA_IDLE, true)
 SCHED_FEAT(WA_WEIGHT, true)
+SCHED_FEAT(WA_IDLER_LLC, false)
 SCHED_FEAT(WA_BIAS, true)
 
 /*
-- 
2.18.2

