Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53E6C3758AE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 18:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236177AbhEFQrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 12:47:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:27622 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236110AbhEFQrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 12:47:24 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 146GWccB174236;
        Thu, 6 May 2021 12:46:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=F/2E+5td5q5Cb1WYsOl+KFsjsQFN9RPx6wanByN2vK8=;
 b=mJiEvNMFCJU4q1snLtRAP7B0nKVWvOquGZQHx3sKX/w8m6m6q8xlTjTFFaPpgPKq+2U2
 /z3zt0Jr5NoZORSay6icwU/qOxw0ZWArzUo49qF+94aHE7IhMmjfIhXIF6gU85coH6I7
 UgBavEqzfpnzeeXDB4Z0oIt37bqWRYx9ItUpi3zfBx5TrntPUc8L5sniND7xFx8VzCRS
 6Kj+GuHv+1IeEmNHaQ67RA7zoO2qsZsvje37so/54sn9LMxfdXHulVnk2tacdmrIviXM
 2od9PomlJipBoe7DdR7DRfScw/a7mi53qDhvFy4lHeniDcA8u3wAZ/ejsiZE3gqkfWwn vQ== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38chabegjf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 May 2021 12:46:16 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 146GiPWE031245;
        Thu, 6 May 2021 16:46:14 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06fra.de.ibm.com with ESMTP id 38bedrrke6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 May 2021 16:46:14 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 146GkC8h57016730
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 May 2021 16:46:12 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1DE22A4055;
        Thu,  6 May 2021 16:46:12 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CBC0FA404D;
        Thu,  6 May 2021 16:46:09 +0000 (GMT)
Received: from saptagiri.in.ibm.com (unknown [9.77.204.81])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  6 May 2021 16:46:09 +0000 (GMT)
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
Subject: [PATCH v2 8/8] sched/fair: Dont iterate if no idle CPUs
Date:   Thu,  6 May 2021 22:15:43 +0530
Message-Id: <20210506164543.90688-9-srikar@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210506164543.90688-1-srikar@linux.vnet.ibm.com>
References: <20210506164543.90688-1-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zw_Tu0EQT7sk5gCM3dEXV4Uikpw_5xXj
X-Proofpoint-GUID: zw_Tu0EQT7sk5gCM3dEXV4Uikpw_5xXj
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-06_10:2021-05-06,2021-05-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 spamscore=0 suspectscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2105060114
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the nr_busy_cpus for a LLC are updated in idle callbacks,
scheduler can detect if all threads of a LLC are busy. In such cases, it
can avoid searching for idle CPUs in the LLC that can run the wakee
thread.

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
 kernel/sched/fair.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c70f0889258f..83104d3bd0f9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -715,7 +715,7 @@ static u64 sched_vslice(struct cfs_rq *cfs_rq, struct sched_entity *se)
 #include "pelt.h"
 #ifdef CONFIG_SMP
 
-static int select_idle_sibling(struct task_struct *p, int prev_cpu, int cpu);
+static int select_idle_sibling(struct task_struct *p, int prev_cpu, int cpu, bool idle);
 static unsigned long task_h_load(struct task_struct *p);
 static unsigned long capacity_of(int cpu);
 
@@ -5870,7 +5870,8 @@ wake_affine_weight(struct sched_domain *sd, struct task_struct *p,
 
 static inline bool test_reset_idle_core(struct sched_domain_shared *sds, int val);
 
-static int wake_affine_idler_llc(struct task_struct *p, int pref_cpu, int try_cpu, int sync)
+static int wake_affine_idler_llc(struct task_struct *p, int pref_cpu, int try_cpu,
+				int sync, bool *idle)
 {
 	int tnr_busy, tllc_size, pnr_busy, pllc_size;
 	struct sched_domain_shared *pref_sds, *try_sds;
@@ -5905,8 +5906,10 @@ static int wake_affine_idler_llc(struct task_struct *p, int pref_cpu, int try_cp
 	pllc_size = per_cpu(sd_llc_size, pref_cpu);
 	tllc_size = per_cpu(sd_llc_size, try_cpu);
 
-	if (tnr_busy == tllc_size && pnr_busy == pllc_size)
+	if (tnr_busy == tllc_size && pnr_busy == pllc_size) {
+		*idle = false;
 		return nr_cpumask_bits;
+	}
 
 	diff = tnr_busy * pllc_size - pnr_busy * tllc_size;
 	if (diff > 0)
@@ -5918,7 +5921,7 @@ static int wake_affine_idler_llc(struct task_struct *p, int pref_cpu, int try_cp
 }
 
 static int wake_affine(struct sched_domain *sd, struct task_struct *p,
-		       int this_cpu, int prev_cpu, int sync)
+		       int this_cpu, int prev_cpu, int sync, bool *idle)
 {
 	bool share_caches = cpus_share_cache(prev_cpu, this_cpu);
 	int target = nr_cpumask_bits;
@@ -5927,7 +5930,7 @@ static int wake_affine(struct sched_domain *sd, struct task_struct *p,
 		target = wake_affine_idle(this_cpu, prev_cpu);
 
 	else if (sched_feat(WA_IDLER_LLC) && !share_caches)
-		target = wake_affine_idler_llc(p, this_cpu, prev_cpu, sync);
+		target = wake_affine_idler_llc(p, this_cpu, prev_cpu, sync, idle);
 
 	if (sched_feat(WA_WEIGHT) && target == nr_cpumask_bits)
 		target = wake_affine_weight(sd, p, this_cpu, prev_cpu, sync);
@@ -6343,7 +6346,7 @@ static inline bool asym_fits_capacity(int task_util, int cpu)
 /*
  * Try and locate an idle core/thread in the LLC cache domain.
  */
-static int select_idle_sibling(struct task_struct *p, int prev, int target)
+static int select_idle_sibling(struct task_struct *p, int prev, int target, bool idle)
 {
 	struct sched_domain *sd;
 	unsigned long task_util;
@@ -6420,6 +6423,9 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 		}
 	}
 
+	if (!idle)
+		return target;
+
 	sd = rcu_dereference(per_cpu(sd_llc, target));
 	if (!sd)
 		return target;
@@ -6828,6 +6834,7 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
 	int want_affine = 0;
 	/* SD_flags and WF_flags share the first nibble */
 	int sd_flag = wake_flags & 0xF;
+	bool idle = true;
 
 	if (wake_flags & WF_TTWU) {
 		record_wakee(p);
@@ -6851,7 +6858,7 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
 		if (want_affine && (tmp->flags & SD_WAKE_AFFINE) &&
 		    cpumask_test_cpu(prev_cpu, sched_domain_span(tmp))) {
 			if (cpu != prev_cpu)
-				new_cpu = wake_affine(tmp, p, cpu, prev_cpu, sync);
+				new_cpu = wake_affine(tmp, p, cpu, prev_cpu, sync, &idle);
 
 			sd = NULL; /* Prefer wake_affine over balance flags */
 			break;
@@ -6868,7 +6875,7 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
 		new_cpu = find_idlest_cpu(sd, p, cpu, prev_cpu, sd_flag);
 	} else if (wake_flags & WF_TTWU) { /* XXX always ? */
 		/* Fast path */
-		new_cpu = select_idle_sibling(p, prev_cpu, new_cpu);
+		new_cpu = select_idle_sibling(p, prev_cpu, new_cpu, idle);
 
 		if (want_affine)
 			current->recent_used_cpu = cpu;
-- 
2.18.2

