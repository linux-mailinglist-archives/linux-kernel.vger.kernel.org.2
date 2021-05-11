Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 873CE37AA99
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 17:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbhEKPYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 11:24:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34788 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231782AbhEKPYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 11:24:39 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14BF3LaG120449;
        Tue, 11 May 2021 11:23:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id; s=pp1;
 bh=uSeapYegRI7NrNTYoCk09RlFwaXDyF/Z5vTLz/KRFFU=;
 b=MoehVSCJ6Jn4RiLoOCkn2nGl+mUp5R7b7iqvwu0aws1q9ckMBfabf5itNzuIBXL3G0T3
 3iFNdWVnREpiaLciO13pOXXH+2ibl8cZQ1tVqnEbyFvsoLsscLmcW052SUN4kHfugyUH
 9JEjFHiw8LhW2m7KXZfKLkzmdOzDxW0lAyVBm5q33Ylw+YsK0o2gh+UA6+Sz66jTvBh6
 drL9+BD3XFjHpEQZgUbLRhY3Jz+ov0+FW1hnaQ9XkWg3XgVjnbpMJYPm0CWsS54GMT8+
 NmPLiSXOyON8vu25XnYz26deYXPkAs8J+jqonOW0w7eRdNq7DLzzu4IhnMEvGUgHMkYP PQ== 
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38fv5b8t76-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 May 2021 11:23:26 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14BFHwUj005173;
        Tue, 11 May 2021 15:23:24 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma03wdc.us.ibm.com with ESMTP id 38dj98xr2a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 May 2021 15:23:24 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14BFNNio16843200
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 May 2021 15:23:23 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C7444BE053;
        Tue, 11 May 2021 15:23:23 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 71E21BE04F;
        Tue, 11 May 2021 15:23:23 +0000 (GMT)
Received: from sofia.ibm.com (unknown [9.199.39.172])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 11 May 2021 15:23:23 +0000 (GMT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
        id 3D8752E2D67; Tue, 11 May 2021 20:46:57 +0530 (IST)
From:   "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To:     Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     linux-kernel@vger.kernel.org,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [PATCH v2] sched/fair: Fix clearing of has_idle_cores flag
Date:   Tue, 11 May 2021 20:46:09 +0530
Message-Id: <1620746169-13996-1-git-send-email-ego@linux.vnet.ibm.com>
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UT7nmPzXghD8pNmBXKqaDnG0D1sH0VLb
X-Proofpoint-GUID: UT7nmPzXghD8pNmBXKqaDnG0D1sH0VLb
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-11_02:2021-05-11,2021-05-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 mlxscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 spamscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105110111
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

In commit 9fe1f127b913 ("sched/fair: Merge select_idle_core/cpu()"),
in select_idle_cpu(), we check if an idle core is present in the LLC
of the target CPU via the flag "has_idle_cores". We look for the idle
core in select_idle_cores(). If select_idle_cores() isn't able to find
an idle core/CPU, we need to unset the has_idle_cores flag in the LLC
of the target to prevent other CPUs from going down this route.

However, the current code is unsetting it in the LLC of the current
CPU instead of the target CPU. This patch fixes this issue.

Fixes: Commit 9fe1f127b913 ("sched/fair: Merge select_idle_core/cpu()")
Acked-by: Mel Gorman <mgorman@techsingularity.net>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
v1 --> v2 : Rebased against tip/sched/core

 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1d75af1..6de1101 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6217,7 +6217,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
 	}
 
 	if (has_idle_core)
-		set_idle_cores(this, false);
+		set_idle_cores(target, false);
 
 	if (sched_feat(SIS_PROP) && !has_idle_core) {
 		time = cpu_clock(this) - time;
-- 
1.9.4

