Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF1C7367E90
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 12:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235884AbhDVKZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 06:25:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58948 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235853AbhDVKYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 06:24:54 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13MA4nNK089663;
        Thu, 22 Apr 2021 06:23:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=7OrZzklTsF2blgmT5TayDbxMlfJaMqkMtUvgf6CO0/E=;
 b=g6hpjYLDd9fa7sclF/gmGiHKM4LJqQdAorfY/Vc3E7chJdEck2s/9RLCAyO4DKtUnMCL
 M+qDYvdr9P3ctJAYJxSg1bN81YQlLSPGHVB2YxKTzj62bSJBxyZ8YMS4tZxfCqPeV2/Z
 YIKsO86LGLudF+UbZ9lbW19DeYn7B0619WHnZrldt/hUZiE54KVPXNlMIjankqdTVJT5
 ok8jtMjyosnWyIXu81ow4Pf1G2DeDsBa+hBdiD0QwID4ba/MX1CVR/ITh/Y9g8yLRBhW
 6moD8nTEblK+Rn6OWGyLT54UtULLP2Q2Hnht4jfaeYOs9RfZX30UUlkfgAxLd2IBA49x Kw== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3836gy9k09-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Apr 2021 06:23:57 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13MAN91q032238;
        Thu, 22 Apr 2021 10:23:55 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03fra.de.ibm.com with ESMTP id 37yqa89j3e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Apr 2021 10:23:55 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13MANTtY28705024
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Apr 2021 10:23:29 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 07C15AE04D;
        Thu, 22 Apr 2021 10:23:53 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0DC4EAE057;
        Thu, 22 Apr 2021 10:23:50 +0000 (GMT)
Received: from saptagiri.in.ibm.com (unknown [9.199.63.107])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 22 Apr 2021 10:23:49 +0000 (GMT)
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
Subject: [PATCH 04/10] sched/fair: Prefer idle CPU to cache affinity
Date:   Thu, 22 Apr 2021 15:53:20 +0530
Message-Id: <20210422102326.35889-5-srikar@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210422102326.35889-1-srikar@linux.vnet.ibm.com>
References: <20210422102326.35889-1-srikar@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: r_Z9MyIWMvL4TW0v1vKS-tcDn-c1n1Te
X-Proofpoint-GUID: r_Z9MyIWMvL4TW0v1vKS-tcDn-c1n1Te
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-22_04:2021-04-21,2021-04-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 adultscore=0 suspectscore=0
 mlxlogscore=856 spamscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104220084
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
Based on similar posting:
http://lore.kernel.org/lkml/20210226164029.122432-1-srikar@linux.vnet.ibm.com/t/#u
Some comments in the next patch
- Make WA_WAKER default (Suggested by Rik) : done in next patch
- Make WA_WAKER check more conservative: (Suggested by Rik / Peter)
- Rename WA_WAKER to WA_IDLER_LLC (Suggested by Vincent)
- s/pllc_size/tllc_size while checking for busy case: (Pointed by Dietmar)
- Add rcu_read_lock and check for validity of shared domains
- Add idle-core support

 kernel/sched/fair.c     | 64 +++++++++++++++++++++++++++++++++++++++++
 kernel/sched/features.h |  1 +
 2 files changed, 65 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 09c33cca0349..943621367a96 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5869,6 +5869,67 @@ wake_affine_weight(struct sched_domain *sd, struct task_struct *p,
 	return this_eff_load < prev_eff_load ? this_cpu : nr_cpumask_bits;
 }
 
+static int wake_affine_idler_llc(struct task_struct *p, int this_cpu, int prev_cpu, int sync)
+{
+#ifdef CONFIG_NO_HZ_COMMON
+	int pnr_busy, pllc_size, tnr_busy, tllc_size;
+#endif
+	struct sched_domain_shared *tsds, *psds;
+	int diff;
+
+	tsds = rcu_dereference(per_cpu(sd_llc_shared, this_cpu));
+	psds = rcu_dereference(per_cpu(sd_llc_shared, prev_cpu));
+	if (!tsds || !psds)
+		return nr_cpumask_bits;
+
+	if (sync) {
+		if (available_idle_cpu(this_cpu) || sched_idle_cpu(this_cpu))
+			return this_cpu;
+		if (tsds->idle_core != -1) {
+			if (cpumask_test_cpu(tsds->idle_core, p->cpus_ptr))
+				return tsds->idle_core;
+			return this_cpu;
+		}
+	}
+
+	if (available_idle_cpu(prev_cpu) || sched_idle_cpu(prev_cpu))
+		return prev_cpu;
+	if (psds->idle_core != -1) {
+		if (cpumask_test_cpu(psds->idle_core, p->cpus_ptr))
+			return psds->idle_core;
+		return prev_cpu;
+	}
+
+	if (!sync) {
+		if (available_idle_cpu(this_cpu) || sched_idle_cpu(this_cpu))
+			return this_cpu;
+		if (tsds->idle_core != -1) {
+			if (cpumask_test_cpu(tsds->idle_core, p->cpus_ptr))
+				return tsds->idle_core;
+			return this_cpu;
+		}
+	}
+
+#ifdef CONFIG_NO_HZ_COMMON
+	tnr_busy = atomic_read(&tsds->nr_busy_cpus);
+	pnr_busy = atomic_read(&psds->nr_busy_cpus);
+
+	tllc_size = per_cpu(sd_llc_size, this_cpu);
+	pllc_size = per_cpu(sd_llc_size, prev_cpu);
+
+	if (pnr_busy == pllc_size && tnr_busy == tllc_size)
+		return nr_cpumask_bits;
+
+	diff = pnr_busy * tllc_size - tnr_busy * pllc_size;
+	if (diff > 0)
+		return this_cpu;
+	if (diff < 0)
+		return prev_cpu;
+#endif /* CONFIG_NO_HZ_COMMON */
+
+	return nr_cpumask_bits;
+}
+
 static int wake_affine(struct sched_domain *sd, struct task_struct *p,
 		       int this_cpu, int prev_cpu, int sync)
 {
@@ -5877,6 +5938,9 @@ static int wake_affine(struct sched_domain *sd, struct task_struct *p,
 	if (sched_feat(WA_IDLE))
 		target = wake_affine_idle(this_cpu, prev_cpu, sync);
 
+	if (sched_feat(WA_IDLER_LLC) && target == nr_cpumask_bits)
+		target = wake_affine_idler_llc(p, this_cpu, prev_cpu, sync);
+
 	if (sched_feat(WA_WEIGHT) && target == nr_cpumask_bits)
 		target = wake_affine_weight(sd, p, this_cpu, prev_cpu, sync);
 
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

