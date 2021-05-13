Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1986637F3A5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 09:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbhEMHnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 03:43:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:61416 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231733AbhEMHmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 03:42:17 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14D7WjAP077091;
        Thu, 13 May 2021 03:40:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=sCXH94cW8XvD6PZF1kHWbY6uGqyyZ47VmXjmtSo0z/8=;
 b=pN9Mz1J3HeQhe+zMnryYOH10mugtLZY4bmQhAm53SdO1CvBoE3QgV3FtJ740RNm60mod
 /f/MsgpnKDcPkPGCCrP2JzkmRBH9LdLCqCXjptd83RyTVs5BpEZjHVRmPjjmWDPm2S5r
 5bwnw/OjA0peJ3Hud1BUOttoZX8DXgtpSkK2T127qnMZ0pA4b/W/bnOi6BJUPllLKRBy
 UMtELq2ctMY69+c8J85Agn6+1HTB3uZw3n4JPndes2q0mx30I1M51LjGfF5wmTzb1zin
 NB7k83BiLYdPYZv98bMvUrTCvluYQ+P9wkVBbIDbG/KEIRedsfroWb1v2eLnXU55p1/2 Aw== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38gv83n0gv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 May 2021 03:40:58 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14D7d2cY032556;
        Thu, 13 May 2021 07:40:56 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma05fra.de.ibm.com with ESMTP id 38dj98hduh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 May 2021 07:40:56 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14D7erhI34144576
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 May 2021 07:40:53 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CED98AE04D;
        Thu, 13 May 2021 07:40:53 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 74C9CAE045;
        Thu, 13 May 2021 07:40:51 +0000 (GMT)
Received: from saptagiri.in.ibm.com (unknown [9.79.222.102])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 13 May 2021 07:40:51 +0000 (GMT)
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
Subject: [PATCH v3 7/8] sched/fair: Remove ifdefs in waker_affine_idler_llc
Date:   Thu, 13 May 2021 13:10:26 +0530
Message-Id: <20210513074027.543926-8-srikar@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210513074027.543926-1-srikar@linux.vnet.ibm.com>
References: <20210513074027.543926-1-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Jtx6ISrNuZibVGwA0CQy-Ab6H6L0-9K1
X-Proofpoint-ORIG-GUID: Jtx6ISrNuZibVGwA0CQy-Ab6H6L0-9K1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-13_03:2021-05-12,2021-05-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=867 spamscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105130056
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that idle callbacks are updating nr_busy_cpus, remove ifdefs in
wake_affine_idler_llc

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
 kernel/sched/fair.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8f86359efdbd..1ca05176ad18 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5896,9 +5896,7 @@ static inline bool test_reset_idle_core(struct sched_domain_shared *sds, int val
 
 static int wake_affine_idler_llc(struct task_struct *p, int pref_cpu, int try_cpu, int sync)
 {
-#ifdef CONFIG_NO_HZ_COMMON
 	int tnr_busy, tllc_size, pnr_busy, pllc_size;
-#endif
 	struct sched_domain_shared *pref_sds, *try_sds;
 	int diff, idle_core;
 
@@ -5926,7 +5924,6 @@ static int wake_affine_idler_llc(struct task_struct *p, int pref_cpu, int try_cp
 				test_reset_idle_core(try_sds, idle_core))
 		return idle_core;
 
-#ifdef CONFIG_NO_HZ_COMMON
 	pnr_busy = atomic_read(&pref_sds->nr_busy_cpus);
 	tnr_busy = atomic_read(&try_sds->nr_busy_cpus);
 	pllc_size = per_cpu(sd_llc_size, pref_cpu);
@@ -5940,7 +5937,6 @@ static int wake_affine_idler_llc(struct task_struct *p, int pref_cpu, int try_cp
 		return pref_cpu;
 	if (diff < 0)
 		return try_cpu;
-#endif /* CONFIG_NO_HZ_COMMON */
 
 	return nr_cpumask_bits;
 }
-- 
2.18.2

