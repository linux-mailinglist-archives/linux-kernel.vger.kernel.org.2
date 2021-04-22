Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C01E0367E92
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 12:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235945AbhDVKZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 06:25:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:13122 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235882AbhDVKY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 06:24:59 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13MA3WrQ121685;
        Thu, 22 Apr 2021 06:24:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=NwdiCSoWEIdzQJvlCZNtw8G55JGvITpjDvKPx4SiPzc=;
 b=sPWA8ZVCuWR4KIDJHv0HKH5knUlp30l6M18eO9lENd+M8FpWQVc+9GEj0cIGwli+Q+eA
 bGq7HuKK45rcJooq0WhM0TfS1gFraflJyyDd4PdGTmsq/mYQZ/MjtKr/8vZj+HiLRnHx
 eP1G265tM9j45YwTrV1pSvsDd7vO1eO8Yo+x3vc3/M4M/ICCEasxXrqW82MMZJpj4k+2
 TBTyXlPPl20x8bnLVV+Edi5axTSG3DLFgwHZdJM0819NgHdL05TiKj7BERRHI9/3HtVd
 l8qF67KDOLR0kvjF7tncVvBSQtLuTwqKdgsS+dFHgGQ0/cqpxHM2IAX82O+OfKxDXpzZ eQ== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3835n0367f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Apr 2021 06:24:07 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13MANsZ7003309;
        Thu, 22 Apr 2021 10:24:05 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma02fra.de.ibm.com with ESMTP id 37yqa89hrc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Apr 2021 10:24:05 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13MAO37n32113050
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Apr 2021 10:24:03 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F39E7AE055;
        Thu, 22 Apr 2021 10:24:02 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 18AF5AE053;
        Thu, 22 Apr 2021 10:24:00 +0000 (GMT)
Received: from saptagiri.in.ibm.com (unknown [9.199.63.107])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 22 Apr 2021 10:23:59 +0000 (GMT)
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
Subject: [PATCH 07/10] sched/fair: Remove ifdefs in waker_affine_idler_llc
Date:   Thu, 22 Apr 2021 15:53:23 +0530
Message-Id: <20210422102326.35889-8-srikar@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210422102326.35889-1-srikar@linux.vnet.ibm.com>
References: <20210422102326.35889-1-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: VArBeo0AGkIlGlzrzk5f6zHdjPCDQs3P
X-Proofpoint-GUID: VArBeo0AGkIlGlzrzk5f6zHdjPCDQs3P
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-22_04:2021-04-21,2021-04-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 mlxscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxlogscore=776 malwarescore=0 phishscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104220084
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
index 00bcf1d861b5..8f752f77b76f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5870,9 +5870,7 @@ wake_affine_weight(struct sched_domain *sd, struct task_struct *p,
 
 static int wake_affine_idler_llc(struct task_struct *p, int this_cpu, int prev_cpu, int sync)
 {
-#ifdef CONFIG_NO_HZ_COMMON
 	int pnr_busy, pllc_size, tnr_busy, tllc_size;
-#endif
 	struct sched_domain_shared *tsds, *psds;
 	int diff;
 
@@ -5909,7 +5907,6 @@ static int wake_affine_idler_llc(struct task_struct *p, int this_cpu, int prev_c
 		}
 	}
 
-#ifdef CONFIG_NO_HZ_COMMON
 	tnr_busy = atomic_read(&tsds->nr_busy_cpus);
 	pnr_busy = atomic_read(&psds->nr_busy_cpus);
 
@@ -5924,7 +5921,6 @@ static int wake_affine_idler_llc(struct task_struct *p, int this_cpu, int prev_c
 		return this_cpu;
 	if (diff < 0)
 		return prev_cpu;
-#endif /* CONFIG_NO_HZ_COMMON */
 
 	return nr_cpumask_bits;
 }
-- 
2.18.2

