Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 676A137F3A8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 09:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbhEMHpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 03:45:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:16750 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231824AbhEMHnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 03:43:20 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14D7Y4S1010756;
        Thu, 13 May 2021 03:41:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=BoHyO0Pj0fdqyarnbzhkwlaRQ+dz5+JpV6en/4KxnbI=;
 b=lFK2dodRGQOWP3KhXUkI/1ybuTdk9xLV1FOCPQ8QuGLH+jF2ifyZ9uo01LPU0X+/bn7c
 N0kipXSKUz6jcQ0lGE0rG/K95f+8R7LOM1SoEtUxrIf6iunghuHzjV7xPaDwR8xKE0cX
 Guqaet+NSkjK3fhZ8mfNG6dGKzfy6+Sc1C68EMTXDlzygrHbrfJ27ICI/C5V1xSP4dHh
 QNnen0Oz3xCb8YbCebLcu28TqiocBuXZAVcVpwIn0uEgpqNWObhuU/RJQfC9rbY/Iboh
 LE4oI964zS/wHsAKG5mDdUR0NeLYSph+OsxuRGRMl0Si7h1h1gj/jCk6uarmDmPB0K7i xg== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38gwbr3kqr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 May 2021 03:41:00 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14D7ciKV000655;
        Thu, 13 May 2021 07:40:58 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 38dhwhakrk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 May 2021 07:40:58 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14D7eT2P19857674
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 May 2021 07:40:29 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 79E5BAE045;
        Thu, 13 May 2021 07:40:56 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 29D83AE04D;
        Thu, 13 May 2021 07:40:54 +0000 (GMT)
Received: from saptagiri.in.ibm.com (unknown [9.79.222.102])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 13 May 2021 07:40:53 +0000 (GMT)
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
        Parth Shah <parth@linux.ibm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>
Subject: [PATCH v3 8/8] sched/fair: Dont iterate if no idle CPUs
Date:   Thu, 13 May 2021 13:10:27 +0530
Message-Id: <20210513074027.543926-9-srikar@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210513074027.543926-1-srikar@linux.vnet.ibm.com>
References: <20210513074027.543926-1-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vwvXRF_C0wxLEfs6TKvAJTQm-gG1zFDS
X-Proofpoint-ORIG-GUID: vwvXRF_C0wxLEfs6TKvAJTQm-gG1zFDS
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-13_03:2021-05-12,2021-05-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 phishscore=0 mlxlogscore=999 suspectscore=0 spamscore=0 mlxscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105130056
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
Cc: Aubrey Li <aubrey.li@linux.intel.com>
Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
 kernel/sched/fair.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1ca05176ad18..4e6e2571537a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -730,7 +730,7 @@ static u64 sched_vslice(struct cfs_rq *cfs_rq, struct sched_entity *se)
 #include "pelt.h"
 #ifdef CONFIG_SMP
 
-static int select_idle_sibling(struct task_struct *p, int prev_cpu, int cpu);
+static int select_idle_sibling(struct task_struct *p, int prev_cpu, int cpu, bool idle);
 static unsigned long task_h_load(struct task_struct *p);
 static unsigned long capacity_of(int cpu);
 
@@ -5894,7 +5894,8 @@ wake_affine_weight(struct sched_domain *sd, struct task_struct *p,
 
 static inline bool test_reset_idle_core(struct sched_domain_shared *sds, int val);
 
-static int wake_affine_idler_llc(struct task_struct *p, int pref_cpu, int try_cpu, int sync)
+static int wake_affine_idler_llc(struct task_struct *p, int pref_cpu, int try_cpu,
+				int sync, bool *idle)
 {
 	int tnr_busy, tllc_size, pnr_busy, pllc_size;
 	struct sched_domain_shared *pref_sds, *try_sds;
@@ -5929,8 +5930,10 @@ static int wake_affine_idler_llc(struct task_struct *p, int pref_cpu, int try_cp
 	pllc_size = per_cpu(sd_llc_size, pref_cpu);
 	tllc_size = per_cpu(sd_llc_size, try_cpu);
 
-	if (tnr_busy == tllc_size && pnr_busy == pllc_size)
+	if (tnr_busy == tllc_size && pnr_busy == pllc_size) {
+		*idle = false;
 		return nr_cpumask_bits;
+	}
 
 	diff = tnr_busy * pllc_size - pnr_busy * tllc_size;
 	if (diff > 0)
@@ -5942,7 +5945,7 @@ static int wake_affine_idler_llc(struct task_struct *p, int pref_cpu, int try_cp
 }
 
 static int wake_affine(struct sched_domain *sd, struct task_struct *p,
-		       int this_cpu, int prev_cpu, int sync)
+		       int this_cpu, int prev_cpu, int sync, bool *idle)
 {
 	bool share_caches = cpus_share_cache(prev_cpu, this_cpu);
 	int target = nr_cpumask_bits;
@@ -5951,7 +5954,7 @@ static int wake_affine(struct sched_domain *sd, struct task_struct *p,
 		target = wake_affine_idle(this_cpu, prev_cpu);
 
 	else if (sched_feat(WA_IDLER_LLC) && !share_caches)
-		target = wake_affine_idler_llc(p, this_cpu, prev_cpu, sync);
+		target = wake_affine_idler_llc(p, this_cpu, prev_cpu, sync, idle);
 
 	if (sched_feat(WA_WEIGHT) && target == nr_cpumask_bits)
 		target = wake_affine_weight(sd, p, this_cpu, prev_cpu, sync);
@@ -6390,7 +6393,7 @@ static inline bool asym_fits_capacity(int task_util, int cpu)
 /*
  * Try and locate an idle core/thread in the LLC cache domain.
  */
-static int select_idle_sibling(struct task_struct *p, int prev, int target)
+static int select_idle_sibling(struct task_struct *p, int prev, int target, bool idle)
 {
 	int i, recent_used_cpu, idle_core = -1;
 	struct sched_domain *sd;
@@ -6467,6 +6470,9 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 		}
 	}
 
+	if (!idle)
+		return target;
+
 	sd = rcu_dereference(per_cpu(sd_llc, target));
 	if (!sd)
 		return target;
@@ -6901,6 +6907,7 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
 	int want_affine = 0;
 	/* SD_flags and WF_flags share the first nibble */
 	int sd_flag = wake_flags & 0xF;
+	bool idle = true;
 
 	if (wake_flags & WF_TTWU) {
 		record_wakee(p);
@@ -6924,7 +6931,7 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
 		if (want_affine && (tmp->flags & SD_WAKE_AFFINE) &&
 		    cpumask_test_cpu(prev_cpu, sched_domain_span(tmp))) {
 			if (cpu != prev_cpu)
-				new_cpu = wake_affine(tmp, p, cpu, prev_cpu, sync);
+				new_cpu = wake_affine(tmp, p, cpu, prev_cpu, sync, &idle);
 
 			sd = NULL; /* Prefer wake_affine over balance flags */
 			break;
@@ -6941,7 +6948,7 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
 		new_cpu = find_idlest_cpu(sd, p, cpu, prev_cpu, sd_flag);
 	} else if (wake_flags & WF_TTWU) { /* XXX always ? */
 		/* Fast path */
-		new_cpu = select_idle_sibling(p, prev_cpu, new_cpu);
+		new_cpu = select_idle_sibling(p, prev_cpu, new_cpu, idle);
 
 		if (want_affine)
 			current->recent_used_cpu = cpu;
-- 
2.18.2

