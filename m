Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 505AA37F39E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 09:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbhEMHmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 03:42:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52616 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231496AbhEMHmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 03:42:03 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14D7Wjo4077078;
        Thu, 13 May 2021 03:40:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=BsxOOtOCtmNvh6SqUhrqt6BgxyPJkVJt3IUi2xHbcU8=;
 b=Cf24DaMKvVUL2z62mhor6Bh2qsNXslKCYzgNeLbOWXLt2bay++Te90e6kbnIkLVelIxh
 ntrJfHukiwitDlcbFTklKG4E5ezc8XdtcMs+oruq/bfXabwvWou0AlpmyDxaOAERA+8i
 uExZ8bDemqtqhMUU5rRaXg92vtQ79ubp+7P6OXWQ+Kd841DDDsgUta4ITyUx1BIk8zxT
 bznCVOgUdEh5DjJyVV+eSR/bAg52yfIQJyfhWsFlsiAtxGZVXBNpJXWaMWfL/ZSeQ1Uw
 QnpuEsu6ZQaQo7OmE7222/WmFXw3ika7iPjCU0HOTM0uR8MtmPPhm4GGdL+62cSRLMO2 mw== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38gv83n09s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 May 2021 03:40:41 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14D7bdMO007301;
        Thu, 13 May 2021 07:40:39 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 38dj98ake4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 May 2021 07:40:39 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14D7ebRM46989772
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 May 2021 07:40:37 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 29B1AAE045;
        Thu, 13 May 2021 07:40:37 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CC95EAE04D;
        Thu, 13 May 2021 07:40:34 +0000 (GMT)
Received: from saptagiri.in.ibm.com (unknown [9.79.222.102])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 13 May 2021 07:40:34 +0000 (GMT)
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
Subject: [PATCH v3 1/8] sched/fair: Update affine statistics when needed
Date:   Thu, 13 May 2021 13:10:20 +0530
Message-Id: <20210513074027.543926-2-srikar@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210513074027.543926-1-srikar@linux.vnet.ibm.com>
References: <20210513074027.543926-1-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Ve8sBl9GeLpk3sYXCKBgvcK8lPRqq3IF
X-Proofpoint-ORIG-GUID: Ve8sBl9GeLpk3sYXCKBgvcK8lPRqq3IF
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-13_03:2021-05-12,2021-05-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=832 spamscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105130056
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wake_affine_idle() can return prev_cpu. Even in such a scenario,
scheduler was going ahead and updating schedstats related to wake
affine. i.e even if the task is not moved to current CPU,
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
Cc: Aubrey Li <aubrey.li@linux.intel.com>
Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
Changelog v2-v3:
 - Update schedstat if target is current CPU
				(Valentin)

 kernel/sched/fair.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1d75af1ecfb4..7920f2a4d257 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5908,8 +5908,10 @@ static int wake_affine(struct sched_domain *sd, struct task_struct *p,
 	if (target == nr_cpumask_bits)
 		return prev_cpu;
 
-	schedstat_inc(sd->ttwu_move_affine);
-	schedstat_inc(p->se.statistics.nr_wakeups_affine);
+	if (target == this_cpu) {
+		schedstat_inc(sd->ttwu_move_affine);
+		schedstat_inc(p->se.statistics.nr_wakeups_affine);
+	}
 	return target;
 }
 
-- 
2.18.2

