Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4A83758AD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 18:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236163AbhEFQrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 12:47:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60686 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236102AbhEFQrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 12:47:23 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 146GWaIW026055;
        Thu, 6 May 2021 12:46:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=EUZGDn8+u3uGUx8Do1UAFYhHIbS1OGyP4igPMlS8OEM=;
 b=A1mbvO8QjzM9c+ckx5t3LTtiw7SZXvkiPd27gFFuQIFjOBa70vYUNfbVR2MKxOCZzAxs
 +MGF6B9HH1NVnR39p+MBKRdajPHkRMJ0IDEb9yz3AfHAxta9hjc9dh5aS2jVV8osazfn
 pQf5ayylYPR16tryn1dXK8EYj4piFEj1JIE4cxj6PSMhgNU0IoXXcPKRP00xgEeYxfPv
 6y8lu4JINw+89ylCKgsviiLCF31rd93dbVRgu2YyCzmzGeIzxfHT719yDObgqOuvGTop
 r8IrXLdXl3BL9VulvtH7ZdjyzX9S6WSiC7tS4YUw6cpIJmyEwqvMx3CZ+O68k/g2Xjgr Ew== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38ckx8rjud-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 May 2021 12:46:14 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 146GggfR026019;
        Thu, 6 May 2021 16:46:12 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 38cfrqr81m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 May 2021 16:46:11 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 146Gk98w27263244
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 May 2021 16:46:09 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7CDF1A4051;
        Thu,  6 May 2021 16:46:09 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 257E5A404D;
        Thu,  6 May 2021 16:46:07 +0000 (GMT)
Received: from saptagiri.in.ibm.com (unknown [9.77.204.81])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  6 May 2021 16:46:06 +0000 (GMT)
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
Subject: [PATCH v2 7/8] sched/fair: Remove ifdefs in waker_affine_idler_llc
Date:   Thu,  6 May 2021 22:15:42 +0530
Message-Id: <20210506164543.90688-8-srikar@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210506164543.90688-1-srikar@linux.vnet.ibm.com>
References: <20210506164543.90688-1-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: p8O2GJ6mWdafYLNnIVHaKlrGFK-b2i0l
X-Proofpoint-ORIG-GUID: p8O2GJ6mWdafYLNnIVHaKlrGFK-b2i0l
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-06_10:2021-05-06,2021-05-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 mlxlogscore=841 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105060114
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
Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
 kernel/sched/fair.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 4d3b0928fe98..c70f0889258f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5872,9 +5872,7 @@ static inline bool test_reset_idle_core(struct sched_domain_shared *sds, int val
 
 static int wake_affine_idler_llc(struct task_struct *p, int pref_cpu, int try_cpu, int sync)
 {
-#ifdef CONFIG_NO_HZ_COMMON
 	int tnr_busy, tllc_size, pnr_busy, pllc_size;
-#endif
 	struct sched_domain_shared *pref_sds, *try_sds;
 	int diff, idle_core;
 
@@ -5902,7 +5900,6 @@ static int wake_affine_idler_llc(struct task_struct *p, int pref_cpu, int try_cp
 				test_reset_idle_core(try_sds, idle_core))
 		return idle_core;
 
-#ifdef CONFIG_NO_HZ_COMMON
 	pnr_busy = atomic_read(&pref_sds->nr_busy_cpus);
 	tnr_busy = atomic_read(&try_sds->nr_busy_cpus);
 	pllc_size = per_cpu(sd_llc_size, pref_cpu);
@@ -5916,7 +5913,6 @@ static int wake_affine_idler_llc(struct task_struct *p, int pref_cpu, int try_cp
 		return pref_cpu;
 	if (diff < 0)
 		return try_cpu;
-#endif /* CONFIG_NO_HZ_COMMON */
 
 	return nr_cpumask_bits;
 }
-- 
2.18.2

