Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2015636B777
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 19:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235135AbhDZRFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 13:05:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:18975 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233736AbhDZRF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 13:05:28 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13QH2v6D072839;
        Mon, 26 Apr 2021 13:04:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id; s=pp1;
 bh=2lxnBKTv8qUxcCh6Rncpee29QLesE5HtfgCmpF3Yecw=;
 b=Lxsj+wXpp94qZY4gwsJOijs/IAumb+v1ncAXX141qSE1kdytjUBJLImIhegMKpfnBw3F
 rs2aLtUeAEPiG6Ys9MZQ2eC05vazpIoyAmze7V/b1pSC+YQ8I+4uNni6Ru2/k1qwBGb7
 vWOzWPA10x0CHpINMH9cPf1FJx/vRBz9Cuu0/Yn6xz2hq389lwCXpV786zEt9r5jaQS+
 Y/NzjV35UnNDW8LElr/gODg0iNU/lLgIFbTiRgVajyEl7vYWPEdffnGU9fACBhRb2olr
 Y2jKkEAwK7+ypic8wMi0ycYQczMj4mk+aurXkULAYSI4xQuUHxRJ8CT/f06QC8lwYiOh 2Q== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3860wqha5b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Apr 2021 13:04:35 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13QH3m9C017930;
        Mon, 26 Apr 2021 17:04:35 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma01dal.us.ibm.com with ESMTP id 384ay8ugpf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Apr 2021 17:04:35 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13QH4Y8D24183112
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Apr 2021 17:04:34 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 551426E04C;
        Mon, 26 Apr 2021 17:04:34 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ACCB46E054;
        Mon, 26 Apr 2021 17:04:33 +0000 (GMT)
Received: from sofia.ibm.com (unknown [9.102.29.119])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 26 Apr 2021 17:04:33 +0000 (GMT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
        id 5A5CF2E2EAC; Mon, 26 Apr 2021 22:34:28 +0530 (IST)
From:   "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To:     Mel Gorman <mgorman@techsingularity.net>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     linux-kernel@vger.kernel.org,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [PATCH] sched/fair: Fix unsetting of "has_idle_cores" flag
Date:   Mon, 26 Apr 2021 22:34:12 +0530
Message-Id: <1619456652-19143-1-git-send-email-ego@linux.vnet.ibm.com>
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MlufpIJ5bkZT5n1O0YrLDoZkQLcBDMKM
X-Proofpoint-ORIG-GUID: MlufpIJ5bkZT5n1O0YrLDoZkQLcBDMKM
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-26_09:2021-04-26,2021-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 impostorscore=0 suspectscore=0 bulkscore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104260131
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

In commit 9fe1f127b913 ("sched/fair: Merge select_idle_core/cpu()"), in
select_idle_cpu(), we check if an idle core is present in the LLC of the
target CPU via the flag "has_idle_cores". We look for the idle core in
select_idle_cores(). If select_idle_cores() isn't able to find an idle
core/CPU, we need to unset the has_idle_cores flag in the LLC of the
target to prevent other CPUs from going down this route.

However, the current code is unsetting it in the LLC of the current CPU
instead of the target CPU. This patch fixes this issue.

Fixes: Commit 9fe1f127b913 ("sched/fair: Merge select_idle_core/cpu()")
Cc: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 794c2cb..5fb5020 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6171,7 +6171,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 	}
 
 	if (smt)
-		set_idle_cores(this, false);
+		set_idle_cores(target, false);
 
 	if (sched_feat(SIS_PROP) && !smt) {
 		time = cpu_clock(this) - time;
-- 
1.9.4

