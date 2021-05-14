Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35F89380619
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 11:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbhENJXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 05:23:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43000 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232186AbhENJXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 05:23:14 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14E944BU024031
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 05:22:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=lbZr53siq2eJ0pWEl2WE+TYuzDaYDeRuOEAO3+9GJFI=;
 b=BPFd3s4EsomHGpL5CMiDJnfSK+ltuP0gWjc5If+e0ZP/yhIgpJmbjuHKpPweFgw4RsNk
 Uy0eWMNpoXwKSnKjJz2s5d5YIF6P2IdEvEKKUqYmwQ+HmIR70n9B53apd2BcOj0JJasA
 rV8SGIWxOMQywZNTJJWylojhidz/5+2ClvC+ZONptYoXcQZybVA0s4+RttnjB/cO91Pu
 9d8S1in2Mlso0KpA4p7XQs99Zq8ZlDX2Xope6n8iEivDQWvbB4tPNuvu3mxnyiGLLB0O
 59hsG3kYeauMVUtMq0kFGC4U/sp+x2kikgvFfQr/kvOEsef6mlseC+CHRGju/xAiisqv 2A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38hjet5fwy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 05:22:02 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14E9F083066936
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 05:22:02 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38hjet5fwg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 May 2021 05:22:02 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14E9DANR019510;
        Fri, 14 May 2021 09:22:00 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 38hc6cr6kw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 May 2021 09:22:00 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14E9LvCB31457662
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 May 2021 09:21:57 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 314564C044;
        Fri, 14 May 2021 09:21:57 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1F03D4C040;
        Fri, 14 May 2021 09:21:57 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 14 May 2021 09:21:57 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
        id CDC64E05BC; Fri, 14 May 2021 11:21:56 +0200 (CEST)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Marco Elver <elver@google.com>
Cc:     linux-kernel@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH 1/2] kfence: add function to mask address bits
Date:   Fri, 14 May 2021 11:21:38 +0200
Message-Id: <20210514092139.3225509-2-svens@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210514092139.3225509-1-svens@linux.ibm.com>
References: <20210514092139.3225509-1-svens@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: n6SPPaj3Hq7N9fw7olR1uiByW_K1Wn6Q
X-Proofpoint-ORIG-GUID: aMUHwFben5RzgrjC6cCUSYA_UU_pblVB
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-14_04:2021-05-12,2021-05-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 priorityscore=1501 mlxscore=0
 suspectscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105140070
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s390 only reports the page address during a translation fault.
To make the kfence unit tests pass, add a function that might
be implemented by architectures to mask out address bits.

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
---
 include/linux/kfence.h  | 1 +
 mm/kfence/core.c        | 5 +++++
 mm/kfence/kfence_test.c | 6 +++++-
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/linux/kfence.h b/include/linux/kfence.h
index a70d1ea03532..2e15f4c4ee95 100644
--- a/include/linux/kfence.h
+++ b/include/linux/kfence.h
@@ -199,6 +199,7 @@ static __always_inline __must_check bool kfence_free(void *addr)
  * present, so that the kernel can proceed.
  */
 bool __must_check kfence_handle_page_fault(unsigned long addr, bool is_write, struct pt_regs *regs);
+unsigned long kfence_arch_mask_addr(unsigned long addr);
 
 #else /* CONFIG_KFENCE */
 
diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index e18fbbd5d9b4..bc15e3cb71d5 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -50,6 +50,11 @@ static unsigned long kfence_sample_interval __read_mostly = CONFIG_KFENCE_SAMPLE
 #endif
 #define MODULE_PARAM_PREFIX "kfence."
 
+unsigned long __weak kfence_arch_mask_addr(unsigned long addr)
+{
+	return addr;
+}
+
 static int param_set_sample_interval(const char *val, const struct kernel_param *kp)
 {
 	unsigned long num;
diff --git a/mm/kfence/kfence_test.c b/mm/kfence/kfence_test.c
index 4acf4251ee04..9ec572991014 100644
--- a/mm/kfence/kfence_test.c
+++ b/mm/kfence/kfence_test.c
@@ -82,6 +82,7 @@ static const char *get_access_type(const struct expect_report *r)
 /* Check observed report matches information in @r. */
 static bool report_matches(const struct expect_report *r)
 {
+	unsigned long addr = (unsigned long)r->addr;
 	bool ret = false;
 	unsigned long flags;
 	typeof(observed.lines) expect;
@@ -131,22 +132,25 @@ static bool report_matches(const struct expect_report *r)
 	switch (r->type) {
 	case KFENCE_ERROR_OOB:
 		cur += scnprintf(cur, end - cur, "Out-of-bounds %s at", get_access_type(r));
+		addr = kfence_arch_mask_addr(addr);
 		break;
 	case KFENCE_ERROR_UAF:
 		cur += scnprintf(cur, end - cur, "Use-after-free %s at", get_access_type(r));
+		addr = kfence_arch_mask_addr(addr);
 		break;
 	case KFENCE_ERROR_CORRUPTION:
 		cur += scnprintf(cur, end - cur, "Corrupted memory at");
 		break;
 	case KFENCE_ERROR_INVALID:
 		cur += scnprintf(cur, end - cur, "Invalid %s at", get_access_type(r));
+		addr = kfence_arch_mask_addr(addr);
 		break;
 	case KFENCE_ERROR_INVALID_FREE:
 		cur += scnprintf(cur, end - cur, "Invalid free of");
 		break;
 	}
 
-	cur += scnprintf(cur, end - cur, " 0x%p", (void *)r->addr);
+	cur += scnprintf(cur, end - cur, " 0x%p", (void *)addr);
 
 	spin_lock_irqsave(&observed.lock, flags);
 	if (!report_available())
-- 
2.25.1

