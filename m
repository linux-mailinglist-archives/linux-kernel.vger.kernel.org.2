Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 731A1367E8F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 12:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235914AbhDVKZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 06:25:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44786 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235802AbhDVKYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 06:24:48 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13MA35fB120623;
        Thu, 22 Apr 2021 06:24:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=U98LMlpwR14S+Vh9leFQtX1GMVeGXkjlxMLnkPwLutI=;
 b=abgbSM2cvlkfA3bFaFYF+J8mhKSHu1wrRF6Gw6j66/GEY17htM0D4tProTOa22T/eRWw
 5C/L7e0rhLmB123TAnPXhlc4Dbcku5HlxbJrzK7ljsTKfmkDGOTkARPiLSo8QL8U4eSn
 ZFzemvOcq4Br1bPbVOF8JMrgdmNqrWn9BVGERqJgvvn7f/1sDTHXW2kbJU0pLhykKTjU
 /e2l0yqHQd55SiOQxuzX5cOOYXgMbIMEZts5H+HfyM+r7xO4vwYQybmFHG0TvGNslMI4
 wb3QOj7V86/Y0xQNmRCJ5gGYhfY2jqIrHqzqqIeeN5OmuXTB1X4pLBU/br6TPueUBqHE 1g== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3836u6s2b2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Apr 2021 06:24:01 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13MALseu013071;
        Thu, 22 Apr 2021 10:23:58 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06fra.de.ibm.com with ESMTP id 37ypxh9j0n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Apr 2021 10:23:58 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13MANuEV28049676
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Apr 2021 10:23:56 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 33B48AE055;
        Thu, 22 Apr 2021 10:23:56 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 64D35AE053;
        Thu, 22 Apr 2021 10:23:53 +0000 (GMT)
Received: from saptagiri.in.ibm.com (unknown [9.199.63.107])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 22 Apr 2021 10:23:53 +0000 (GMT)
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
Subject: [PATCH 05/10] sched/fair: Call wake_affine only if necessary
Date:   Thu, 22 Apr 2021 15:53:21 +0530
Message-Id: <20210422102326.35889-6-srikar@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210422102326.35889-1-srikar@linux.vnet.ibm.com>
References: <20210422102326.35889-1-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pwUEGXDVERRsrOU-OMO5NpOFFZaombXT
X-Proofpoint-ORIG-GUID: pwUEGXDVERRsrOU-OMO5NpOFFZaombXT
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-22_04:2021-04-21,2021-04-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 mlxlogscore=932 phishscore=0 bulkscore=0 impostorscore=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104220084
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
Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
 kernel/sched/fair.c     | 22 +++++++++++-----------
 kernel/sched/features.h |  2 +-
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 943621367a96..f8c98e544418 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5799,8 +5799,7 @@ static int wake_wide(struct task_struct *p)
  *			  scheduling latency of the CPUs. This seems to work
  *			  for the overloaded case.
  */
-static int
-wake_affine_idle(int this_cpu, int prev_cpu, int sync)
+static int wake_affine_idle(int this_cpu, int prev_cpu)
 {
 	/*
 	 * If this_cpu is idle, it implies the wakeup is from interrupt
@@ -5814,15 +5813,12 @@ wake_affine_idle(int this_cpu, int prev_cpu, int sync)
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
 
@@ -5838,6 +5834,9 @@ wake_affine_weight(struct sched_domain *sd, struct task_struct *p,
 	if (sync) {
 		unsigned long current_load = task_h_load(current);
 
+		if (cpu_rq(this_cpu)->nr_running <= 1)
+			return this_cpu;
+
 		if (current_load > this_eff_load)
 			return this_cpu;
 
@@ -5933,12 +5932,13 @@ static int wake_affine_idler_llc(struct task_struct *p, int this_cpu, int prev_c
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
index c77349a47e01..c60a6d2b2126 100644
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

