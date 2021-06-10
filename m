Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 571AE3A2789
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 10:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbhFJI7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 04:59:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:31972 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229770AbhFJI7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 04:59:32 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15A8XOOl044266;
        Thu, 10 Jun 2021 04:56:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=W6VWdI30HLKXOSaCfPTYoCGDv8ZJferHezqeA+t7UhI=;
 b=sxij/tpIVtoEmaSmE9upafbR0f7A5KustQhQMY1Qz2ZVu/SS81P9FULQ0GfUwstblUrg
 fUQo15LCMcp0jmfbGkuKYFnVdochma3ycZ3/s1bZVv0qNEHURgCxDaQQW8j1hHdrDjIy
 a0UPmCLxCQcKiJDttgTsrq9EEuV7snG52I1r6vtTckrG8uytiLhJ/Ir4gW3wuyV5tH3c
 tFBaf/slQSuxtKImZx3ZtsLiYDGeHTknOF1aZOW/xfT1rLJLsq/alKAm6cb9idY5wanb
 x+gbd5uHx/i3FeD9tcoRwx+b3Np9juNdUuSmkrIEYn4J5HHX6D8OXnVWSYDFX2DizEqn AA== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 393ewd9ck6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Jun 2021 04:56:39 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15A8lhVo008497;
        Thu, 10 Jun 2021 08:56:37 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 3900hhtq0x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Jun 2021 08:56:37 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15A8uXsu31261018
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Jun 2021 08:56:34 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D64F6A4064;
        Thu, 10 Jun 2021 08:56:33 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 89BC0A4062;
        Thu, 10 Jun 2021 08:56:31 +0000 (GMT)
Received: from naverao1-tp.in.ibm.com (unknown [9.85.115.173])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 10 Jun 2021 08:56:31 +0000 (GMT)
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To:     <linux-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH] kprobes: Print an error if probe is rejected
Date:   Thu, 10 Jun 2021 14:26:17 +0530
Message-Id: <20210610085617.1590138-1-naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: X0Ps9k8WYOcYFWqNF0ypjEBleAujWFra
X-Proofpoint-GUID: X0Ps9k8WYOcYFWqNF0ypjEBleAujWFra
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-10_03:2021-06-10,2021-06-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 mlxscore=0 suspectscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 adultscore=0
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2106100055
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When probing at different locations in the kernel, it is not always
evident if the location can be probed or not. As an example:

    $ perf probe __radix__flush_tlb_range:35
    Failed to write event: Invalid argument
      Error: Failed to add events.

The probed line above is:
     35         if (!mmu_has_feature(MMU_FTR_GTSE) && type == FLUSH_TYPE_GLOBAL) {

This ends up trying to probe on BUILD_BUG_ON(), which is rejected.
However, the user receives no indication at all as to why the probe
failed. Print an error in such cases so that it is clear that the probe
was rejected.

Reported-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 kernel/kprobes.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index e41385afe79dc5..7c8929165924ed 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1542,8 +1542,10 @@ static int check_kprobe_address_safe(struct kprobe *p,
 	int ret;
 
 	ret = arch_check_ftrace_location(p);
-	if (ret)
+	if (ret) {
+		pr_err("kprobes: can't probe at the provided ftrace location\n");
 		return ret;
+	}
 	jump_label_lock();
 	preempt_disable();
 
@@ -1552,6 +1554,7 @@ static int check_kprobe_address_safe(struct kprobe *p,
 	    within_kprobe_blacklist((unsigned long) p->addr) ||
 	    jump_label_text_reserved(p->addr, p->addr) ||
 	    find_bug((unsigned long)p->addr)) {
+		pr_err("kprobes: can't probe at address in reject list\n");
 		ret = -EINVAL;
 		goto out;
 	}
@@ -1976,8 +1979,10 @@ int register_kretprobe(struct kretprobe *rp)
 	void *addr;
 
 	ret = kprobe_on_func_entry(rp->kp.addr, rp->kp.symbol_name, rp->kp.offset);
-	if (ret)
+	if (ret) {
+		pr_err("kretprobes: can't probe at address outside function entry\n");
 		return ret;
+	}
 
 	/* If only rp->kp.addr is specified, check reregistering kprobes */
 	if (rp->kp.addr && warn_kprobe_rereg(&rp->kp))
@@ -1989,8 +1994,10 @@ int register_kretprobe(struct kretprobe *rp)
 			return PTR_ERR(addr);
 
 		for (i = 0; kretprobe_blacklist[i].name != NULL; i++) {
-			if (kretprobe_blacklist[i].addr == addr)
+			if (kretprobe_blacklist[i].addr == addr) {
+				pr_err("kretprobes: can't probe at address in reject list\n");
 				return -EINVAL;
+			}
 		}
 	}
 

base-commit: 2e38eb04c95e5546b71bb86ee699a891c7d212b5
-- 
2.31.1

