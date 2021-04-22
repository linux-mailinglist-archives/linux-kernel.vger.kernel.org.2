Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A455367E95
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 12:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235931AbhDVKZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 06:25:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48132 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235906AbhDVKZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 06:25:05 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13MA42c1032649;
        Thu, 22 Apr 2021 06:24:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=fJ9TjVWCyOxpcyioWbiBTZ91SlMHjIjT46uJCacDjxk=;
 b=d5ssH/mPdZX6hMN3eQoitebuzUUHDBTkFQC4U7BQH7qj3PEEufwH0GFux5I9oeaCdVkZ
 JXx3XQUuAoS9Hm/gD5Y64jwIs0IxbIgrqdcIU/12FjcIz80ducxgbT1dhjfkVR6F+wyx
 HFKhONiuOhxx2b7yLe7qQ1R7Ck9Xd3GnQ0YPj+p1onceBBKqEn6xdLOhQwo8rSf09D8m
 C2m2PAIB0mqEhGvsMIJ17qfbnH6YjjTRjv975HtTaLf6nCsWIfyg9+9/pBwxfwHk7OYb
 VrV02umiAHPIqPlJpoalpZ+N0sER3TfEaU0TIiA3VGPVJnNjKxWwg0yFBt5nt7KSv9XU ng== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38347rnv04-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Apr 2021 06:24:18 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13MALxXw020437;
        Thu, 22 Apr 2021 10:24:16 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 37yt2rtrhv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Apr 2021 10:24:15 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13MANolZ30540132
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Apr 2021 10:23:50 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 84224AE053;
        Thu, 22 Apr 2021 10:24:13 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 49D95AE055;
        Thu, 22 Apr 2021 10:24:10 +0000 (GMT)
Received: from saptagiri.in.ibm.com (unknown [9.199.63.107])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 22 Apr 2021 10:24:10 +0000 (GMT)
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
        Michael Ellerman <mpe@ellerman.id.au>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Parth Shah <parth@linux.ibm.com>
Subject: [PATCH 10/10] powerpc/smp: Add fallback flag to powerpc MC domain
Date:   Thu, 22 Apr 2021 15:53:26 +0530
Message-Id: <20210422102326.35889-11-srikar@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210422102326.35889-1-srikar@linux.vnet.ibm.com>
References: <20210422102326.35889-1-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Ywdy0kJRbLxX37bcS-uefQHxleg7Lo4i
X-Proofpoint-ORIG-GUID: Ywdy0kJRbLxX37bcS-uefQHxleg7Lo4i
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-22_04:2021-04-21,2021-04-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 mlxscore=0 malwarescore=0 spamscore=0
 adultscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 mlxlogscore=767 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104060000 definitions=main-2104220084
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Power 10 supports MC domain. Cores within the MC domain
aka hemisphere have lesser cache access latency compared to cache access
latency for cores across the neighbouring MC. Last level of cache for a
Power 10 is at Core (4 threads).
Now that scheduler supports fallback LLC domain, mark MC domain with
SD_FALLBACK_LLC flag. With this each SMT 4 core forms a pair (as
fallback LLC) with another SMT 4 core within the MC domain.

Cc: LKML <linux-kernel@vger.kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
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
 arch/powerpc/kernel/smp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 5a4d59a1070d..bc6386055cbe 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -950,6 +950,11 @@ static int powerpc_shared_cache_flags(void)
 	return SD_SHARE_PKG_RESOURCES;
 }
 
+static int powerpc_mc_flags(void)
+{
+	return SD_FALLBACK_LLC;
+}
+
 /*
  * We can't just pass cpu_l2_cache_mask() directly because
  * returns a non-const pointer and the compiler barfs on that.
@@ -986,7 +991,7 @@ static struct sched_domain_topology_level powerpc_topology[] = {
 	{ cpu_smt_mask, powerpc_smt_flags, SD_INIT_NAME(SMT) },
 #endif
 	{ shared_cache_mask, powerpc_shared_cache_flags, SD_INIT_NAME(CACHE) },
-	{ cpu_mc_mask, SD_INIT_NAME(MC) },
+	{ cpu_mc_mask, powerpc_mc_flags, SD_INIT_NAME(MC) },
 	{ cpu_cpu_mask, SD_INIT_NAME(DIE) },
 	{ NULL, },
 };
-- 
2.18.2

