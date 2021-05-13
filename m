Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6B737F3A4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 09:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbhEMHnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 03:43:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44102 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231728AbhEMHmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 03:42:17 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14D7YBrh011106;
        Thu, 13 May 2021 03:40:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=xd4au2QLNCbm4S16UhVGjFBWHFHYsbum/Htay7UnbQw=;
 b=CToljsCNCxmynF1a4TSYhNtIADpqcWRoWS6P3Q5fmG2nBndh0SdxtTJ9UgsFvCr8ixZl
 4kTTQxelGcDWTJHg4eeaGQXwAVA0LrXg+PgsG8rJoxF6ecRXKTsa4CXrO/Y/WmdMT6mn
 Jl3eudjlHnq334pTlrYhQ4GRJU0yoraXKO5YBCL88Qd7hkkPseP7TB23gzXP7oRo11T+
 2coEJWei59KGzj8zOR1ZfwmgiMvieHuz8wA0oVf/4/SHdz1wJrxWBofdUxvYgp23zSzP
 jlsq8OIqSlPwVpAUrVnXzP9O3e4LKxkF48ClvC1ewgNbueOE9PWrp9wGpul8hDMT4g1T SQ== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38gwbqkm9c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 May 2021 03:40:53 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14D7bEdx007902;
        Thu, 13 May 2021 07:40:50 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma02fra.de.ibm.com with ESMTP id 38dj989dvb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 May 2021 07:40:50 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14D7em7531064500
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 May 2021 07:40:48 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4A6BCAE056;
        Thu, 13 May 2021 07:40:48 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C5C50AE04D;
        Thu, 13 May 2021 07:40:45 +0000 (GMT)
Received: from saptagiri.in.ibm.com (unknown [9.79.222.102])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 13 May 2021 07:40:45 +0000 (GMT)
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
        Parth Shah <parth@linux.ibm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>
Subject: [PATCH v3 5/8] sched/fair: Use affine_idler_llc for wakeups across LLC
Date:   Thu, 13 May 2021 13:10:24 +0530
Message-Id: <20210513074027.543926-6-srikar@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210513074027.543926-1-srikar@linux.vnet.ibm.com>
References: <20210513074027.543926-1-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tKe0dfKyZqiV1TJjy2IEkV1rY8uE6-a4
X-Proofpoint-ORIG-GUID: tKe0dfKyZqiV1TJjy2IEkV1rY8uE6-a4
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-13_03:2021-05-12,2021-05-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 impostorscore=0 spamscore=0 suspectscore=0 clxscore=1015 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105130056
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently if a waker is the only running thread of the CPU, and waking a
wakee (both of them interacting over a pipe aka sync wakeups) with the
wakee previously running on a different LLC), then wakee is pulled and
queued on the CPU that is running the waker.

This is true even if the previous CPU was completely idle. The rationale
being waker would soon relinquish the CPU and wakee would benefit from
the cache access. However if the previous CPU is idle, then wakee thread
will incur latency cost of migration to the waker CPU + latency cost of
the waker context switching.

Before the waker switches out, load balancer could also kick in and pull
the wakee out resulting in another migration cost. This will mostly hurt
systems where LLC have just one core. For example:- Hackbench. Both the
threads of hackbench would then end up running on the same core
resulting in CPUs running in higher SMT modes, more load balances and
non optimal performance.

It would be beneficial to run the wakee thread on the same CPU as waker
only if other CPUs are busy. To achieve this move this part of the code
that check if waker is the only running thread to early part of
wake_affine_weight().

Also post this change, wake_affine_idle() will only look at wakeups
within the LLC.  For wakeups within LLC, there should be no difference
between sync and no-sync. For wakeups across LLC boundaries, lets use
wake_affine_idler_llc.

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
Cc: Aubrey Li <aubrey.li@linux.intel.com>
Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
Changelog
v1->v2:
 - Update the patch subject line.

Changelog v1->v2:
- Update the patch subject line.

 kernel/sched/fair.c     | 22 +++++++++++-----------
 kernel/sched/features.h |  2 +-
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d95a2c9c8797..0dfe01de22d6 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5823,8 +5823,7 @@ static int wake_wide(struct task_struct *p)
  *			  scheduling latency of the CPUs. This seems to work
  *			  for the overloaded case.
  */
-static int
-wake_affine_idle(int this_cpu, int prev_cpu, int sync)
+static int wake_affine_idle(int this_cpu, int prev_cpu)
 {
 	/*
 	 * If this_cpu is idle, it implies the wakeup is from interrupt
@@ -5838,15 +5837,12 @@ wake_affine_idle(int this_cpu, int prev_cpu, int sync)
 	 * a cpufreq perspective, it's better to have higher utilisation
 	 * on one CPU.
 	 */
-	if (available_idle_cpu(this_cpu) && cpus_share_cache(this_cpu, prev_cpu))
-		return available_idle_cpu(prev_cpu) ? prev_cpu : this_cpu;
+	if (available_idle_cpu(prev_cpu) || sched_idle_cpu(prev_cpu))
+		return prev_cpu;
 
-	if (sync && cpu_rq(this_cpu)->nr_running == 1)
+	if (available_idle_cpu(this_cpu) || sched_idle_cpu(this_cpu))
 		return this_cpu;
 
-	if (available_idle_cpu(prev_cpu))
-		return prev_cpu;
-
 	return nr_cpumask_bits;
 }
 
@@ -5862,6 +5858,9 @@ wake_affine_weight(struct sched_domain *sd, struct task_struct *p,
 	if (sync) {
 		unsigned long current_load = task_h_load(current);
 
+		if (cpu_rq(this_cpu)->nr_running <= 1)
+			return this_cpu;
+
 		if (current_load > this_eff_load)
 			return this_cpu;
 
@@ -5949,12 +5948,13 @@ static int wake_affine_idler_llc(struct task_struct *p, int pref_cpu, int try_cp
 static int wake_affine(struct sched_domain *sd, struct task_struct *p,
 		       int this_cpu, int prev_cpu, int sync)
 {
+	bool share_caches = cpus_share_cache(prev_cpu, this_cpu);
 	int target = nr_cpumask_bits;
 
-	if (sched_feat(WA_IDLE))
-		target = wake_affine_idle(this_cpu, prev_cpu, sync);
+	if (sched_feat(WA_IDLE) && share_caches)
+		target = wake_affine_idle(this_cpu, prev_cpu);
 
-	if (sched_feat(WA_IDLER_LLC) && target == nr_cpumask_bits)
+	else if (sched_feat(WA_IDLER_LLC) && !share_caches)
 		target = wake_affine_idler_llc(p, this_cpu, prev_cpu, sync);
 
 	if (sched_feat(WA_WEIGHT) && target == nr_cpumask_bits)
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 77e0b2c4e02c..049e3f33f36a 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -83,7 +83,7 @@ SCHED_FEAT(ATTACH_AGE_LOAD, true)
 
 SCHED_FEAT(WA_IDLE, true)
 SCHED_FEAT(WA_WEIGHT, true)
-SCHED_FEAT(WA_IDLER_LLC, false)
+SCHED_FEAT(WA_IDLER_LLC, true)
 SCHED_FEAT(WA_BIAS, true)
 
 /*
-- 
2.18.2

