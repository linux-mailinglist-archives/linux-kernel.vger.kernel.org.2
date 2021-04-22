Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92AE7367E94
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 12:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235969AbhDVKZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 06:25:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:29094 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235894AbhDVKZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 06:25:03 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13MA2mG6058566;
        Thu, 22 Apr 2021 06:24:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=K3w+q/f9wEPlYJ8QDR9RzlNfkWtMBB1ZfgOy5zZGMQQ=;
 b=Pr8styM75fXaMYCrQwtAggKJj97ZgSJPjyS80PDC8x43/Cx65ZLELxh/KiahNXsYCA/n
 GfuEHSEf8iX09tdw6qOAbgh1k/975HGVWhi6gevl2xdZDCY4LjBVqIE3/IZ8EmHDtIOp
 hMxC8Gr57uktxPPCimNbbAwZD5X6aFvqNEzEQdjmHzrMiUWEy4NAstkeOOHDYOcP9kCs
 S0hZDWi9ua2JxLIQwvVroj33TfejcCxwrTpPjdU4imcE/FrANIGJd0NZvpXzX+rgFZ+n
 uYcZ6G+kJWug4+8XY4lF6Do42nAKV8IlsB2UEvuV4Gc73+e9YMehxuiYoJ3rCB3fYTdW pQ== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3835xxjs9n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Apr 2021 06:24:10 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13MAN4Zh025271;
        Thu, 22 Apr 2021 10:24:08 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04fra.de.ibm.com with ESMTP id 380hbf19py-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Apr 2021 10:24:08 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13MANhCd26870100
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Apr 2021 10:23:43 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 58CE6AE04D;
        Thu, 22 Apr 2021 10:24:06 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5C2F5AE045;
        Thu, 22 Apr 2021 10:24:03 +0000 (GMT)
Received: from saptagiri.in.ibm.com (unknown [9.199.63.107])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 22 Apr 2021 10:24:03 +0000 (GMT)
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
Subject: [PATCH 08/10] sched/fair: Dont iterate if no idle CPUs
Date:   Thu, 22 Apr 2021 15:53:24 +0530
Message-Id: <20210422102326.35889-9-srikar@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210422102326.35889-1-srikar@linux.vnet.ibm.com>
References: <20210422102326.35889-1-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: x3x5JBK00Z-v1h0AMdtUpcsLO3xqeMDr
X-Proofpoint-ORIG-GUID: x3x5JBK00Z-v1h0AMdtUpcsLO3xqeMDr
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-22_04:2021-04-21,2021-04-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 bulkscore=0 clxscore=1015 suspectscore=0 impostorscore=0 adultscore=0
 phishscore=0 spamscore=0 mlxlogscore=922 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104220080
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
index 8f752f77b76f..db5dc9875e4c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -715,7 +715,7 @@ static u64 sched_vslice(struct cfs_rq *cfs_rq, struct sched_entity *se)
 #include "pelt.h"
 #ifdef CONFIG_SMP
 
-static int select_idle_sibling(struct task_struct *p, int prev_cpu, int cpu);
+static int select_idle_sibling(struct task_struct *p, int prev_cpu, int cpu, bool idle);
 static unsigned long task_h_load(struct task_struct *p);
 static unsigned long capacity_of(int cpu);
 
@@ -5868,7 +5868,8 @@ wake_affine_weight(struct sched_domain *sd, struct task_struct *p,
 	return this_eff_load < prev_eff_load ? this_cpu : nr_cpumask_bits;
 }
 
-static int wake_affine_idler_llc(struct task_struct *p, int this_cpu, int prev_cpu, int sync)
+static int wake_affine_idler_llc(struct task_struct *p, int this_cpu, int prev_cpu,
+				int sync, bool *idle)
 {
 	int pnr_busy, pllc_size, tnr_busy, tllc_size;
 	struct sched_domain_shared *tsds, *psds;
@@ -5913,8 +5914,10 @@ static int wake_affine_idler_llc(struct task_struct *p, int this_cpu, int prev_c
 	tllc_size = per_cpu(sd_llc_size, this_cpu);
 	pllc_size = per_cpu(sd_llc_size, prev_cpu);
 
-	if (pnr_busy == pllc_size && tnr_busy == tllc_size)
+	if (pnr_busy == pllc_size && tnr_busy == tllc_size) {
+		*idle = false;
 		return nr_cpumask_bits;
+	}
 
 	diff = pnr_busy * tllc_size - tnr_busy * pllc_size;
 	if (diff > 0)
@@ -5926,7 +5929,7 @@ static int wake_affine_idler_llc(struct task_struct *p, int this_cpu, int prev_c
 }
 
 static int wake_affine(struct sched_domain *sd, struct task_struct *p,
-		       int this_cpu, int prev_cpu, int sync)
+		       int this_cpu, int prev_cpu, int sync, bool *idle)
 {
 	bool share_caches = cpus_share_cache(prev_cpu, this_cpu);
 	int target = nr_cpumask_bits;
@@ -5935,7 +5938,7 @@ static int wake_affine(struct sched_domain *sd, struct task_struct *p,
 		target = wake_affine_idle(this_cpu, prev_cpu);
 
 	else if (sched_feat(WA_IDLER_LLC) && !share_caches)
-		target = wake_affine_idler_llc(p, this_cpu, prev_cpu, sync);
+		target = wake_affine_idler_llc(p, this_cpu, prev_cpu, sync, idle);
 
 	if (sched_feat(WA_WEIGHT) && target == nr_cpumask_bits)
 		target = wake_affine_weight(sd, p, this_cpu, prev_cpu, sync);
@@ -6333,7 +6336,7 @@ static inline bool asym_fits_capacity(int task_util, int cpu)
 /*
  * Try and locate an idle core/thread in the LLC cache domain.
  */
-static int select_idle_sibling(struct task_struct *p, int prev, int target)
+static int select_idle_sibling(struct task_struct *p, int prev, int target, bool idle)
 {
 	struct sched_domain *sd;
 	unsigned long task_util;
@@ -6410,6 +6413,9 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 		}
 	}
 
+	if (!idle)
+		return target;
+
 	sd = rcu_dereference(per_cpu(sd_llc, target));
 	if (!sd)
 		return target;
@@ -6818,6 +6824,7 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
 	int want_affine = 0;
 	/* SD_flags and WF_flags share the first nibble */
 	int sd_flag = wake_flags & 0xF;
+	bool idle = true;
 
 	if (wake_flags & WF_TTWU) {
 		record_wakee(p);
@@ -6841,7 +6848,7 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
 		if (want_affine && (tmp->flags & SD_WAKE_AFFINE) &&
 		    cpumask_test_cpu(prev_cpu, sched_domain_span(tmp))) {
 			if (cpu != prev_cpu)
-				new_cpu = wake_affine(tmp, p, cpu, prev_cpu, sync);
+				new_cpu = wake_affine(tmp, p, cpu, prev_cpu, sync, &idle);
 
 			sd = NULL; /* Prefer wake_affine over balance flags */
 			break;
@@ -6858,7 +6865,7 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
 		new_cpu = find_idlest_cpu(sd, p, cpu, prev_cpu, sd_flag);
 	} else if (wake_flags & WF_TTWU) { /* XXX always ? */
 		/* Fast path */
-		new_cpu = select_idle_sibling(p, prev_cpu, new_cpu);
+		new_cpu = select_idle_sibling(p, prev_cpu, new_cpu, idle);
 
 		if (want_affine)
 			current->recent_used_cpu = cpu;
-- 
2.18.2

