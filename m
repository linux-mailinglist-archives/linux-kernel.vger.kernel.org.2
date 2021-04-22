Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD32367E8B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 12:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235841AbhDVKYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 06:24:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42144 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235097AbhDVKYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 06:24:47 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13MA4nND089648;
        Thu, 22 Apr 2021 06:23:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=gkFtMqKi2aEYemt9CKXS7Yh64Vz+DgUGgBkE+O3HXgo=;
 b=rmTlQn8ZEWMgALmmSBJtyMXoRr7V+1SUzMntDudj/Je2bDtDRxo1NInkJMwYok5O9iPw
 lYus5fVD/cqFxex7Bc8r2FrZdqLQET1Pyn8IFzWnn8NqV5/HJJ9oUMBZUDcJ6TOEwh8t
 NRH0//rnuCTGbwfflX4nyQ9TAyEChL8fJYktZpC62BPZuuVOZ4Z0IjC1kfSc4Rjx3HTf
 vpC7L+euGEiF8Ik2FqIIRtMKXYnucaThAAAfr8nI5GKGhB7BqnkiOSGxI+knq3JioWgl
 8FB0rUt9rnvJ6mmilyP/L5Wnp4GU09wTXvwrwQuN8oS2oDm+/CgXJO678Iimj5s4kmAP Wg== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3836gy9ju2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Apr 2021 06:23:47 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13MALrNn013067;
        Thu, 22 Apr 2021 10:23:45 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06fra.de.ibm.com with ESMTP id 37ypxh9j0f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Apr 2021 10:23:44 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13MANgSp24052128
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Apr 2021 10:23:42 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9900BAE051;
        Thu, 22 Apr 2021 10:23:42 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7D3CDAE045;
        Thu, 22 Apr 2021 10:23:39 +0000 (GMT)
Received: from saptagiri.in.ibm.com (unknown [9.199.63.107])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 22 Apr 2021 10:23:39 +0000 (GMT)
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
Subject: [PATCH 01/10] sched/fair: Update affine statistics when needed
Date:   Thu, 22 Apr 2021 15:53:17 +0530
Message-Id: <20210422102326.35889-2-srikar@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210422102326.35889-1-srikar@linux.vnet.ibm.com>
References: <20210422102326.35889-1-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: FlELXYSdsq62faEzySQO9UCnEJy82BSz
X-Proofpoint-GUID: FlELXYSdsq62faEzySQO9UCnEJy82BSz
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-22_04:2021-04-21,2021-04-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 adultscore=0 suspectscore=0
 mlxlogscore=948 spamscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104220084
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wake_affine_idle() can return prev_cpu. Even in such a scenario,
scheduler was going ahead and updating schedstats related to wake
affine. i.e even if the task is not moved across LLC domains,
schedstats would have accounted.

Hence add a check before updating schedstats.

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
 kernel/sched/fair.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 794c2cb945f8..a258a84cfdfd 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5884,8 +5884,10 @@ static int wake_affine(struct sched_domain *sd, struct task_struct *p,
 	if (target == nr_cpumask_bits)
 		return prev_cpu;
 
-	schedstat_inc(sd->ttwu_move_affine);
-	schedstat_inc(p->se.statistics.nr_wakeups_affine);
+	if (!cpus_share_cache(prev_cpu, target)) {
+		schedstat_inc(sd->ttwu_move_affine);
+		schedstat_inc(p->se.statistics.nr_wakeups_affine);
+	}
 	return target;
 }
 
-- 
2.18.2

