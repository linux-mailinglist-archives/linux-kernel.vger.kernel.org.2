Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37DFD358B52
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 19:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbhDHR2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 13:28:13 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:58294 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232721AbhDHR2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 13:28:10 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 138HJs8s194274;
        Thu, 8 Apr 2021 17:27:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=+uSuBJozjQZeX6B+7TAVTJN03FozJQ5lZFV1D24SNrA=;
 b=CpDNNiyxzfuR4GFfLKKKGkG8K1qv6NDcZwFOcb7W37mVZGGlf11FfcdazC5eBL+5tR7J
 iCN9P8aDoejhfoyiFTrv0eJ205diTBb6oTr7RNHm4qWsLPLUXsrhTfgzUonDD7Ugp+px
 ur3bCVWcw8FDiViBqc4EHSRvKHdge4nip1KpwhO4sut5Nxi0cRleRY7x2HRTKHlwiVhi
 DGba915OClJX02oRV+Q0vg+cPTaq/VkgJB3crrwvVb3nSIhhABehrhncRx0apOT7CH6Z
 /yKDfMuesuEZJMO2D1wRbzMKGGGrT0ozXHI7XR4sX7Xm1Pv97VhEKcaFxZKmFxr7G4M7 4w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 37rva66qyn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Apr 2021 17:27:38 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 138HQBTX170830;
        Thu, 8 Apr 2021 17:27:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 37rvbgk32e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Apr 2021 17:27:37 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 138HQDtQ171304;
        Thu, 8 Apr 2021 17:27:37 GMT
Received: from brm-x62-20.us.oracle.com (brm-x62-20.us.oracle.com [10.80.150.35])
        by aserp3030.oracle.com with ESMTP id 37rvbgk31c-2;
        Thu, 08 Apr 2021 17:27:37 +0000
From:   Thomas Tai <thomas.tai@oracle.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org
Cc:     sean.j.christopherson@intel.com, luto@amacapital.net,
        jarkko@kernel.org, bp@suse.de, jethro@fortanix.com,
        alexandre.chartre@oracle.com, linux-kernel@vger.kernel.org,
        thomas.tai@oracle.com
Subject: [PATCH 2/2] arch/x86: arch/sparc: tools/perf: fix typos in comments
Date:   Thu,  8 Apr 2021 13:28:34 -0400
Message-Id: <1617902914-83245-2-git-send-email-thomas.tai@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1617902914-83245-1-git-send-email-thomas.tai@oracle.com>
References: <1617902914-83245-1-git-send-email-thomas.tai@oracle.com>
X-Proofpoint-GUID: ErBDBngxZG1N_pD_SInNL8vUYFTTc7F5
X-Proofpoint-ORIG-GUID: ErBDBngxZG1N_pD_SInNL8vUYFTTc7F5
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9948 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104080115
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/insted/instead/
s/maintaing/maintaining/

Signed-off-by: Thomas Tai <thomas.tai@oracle.com>
---
 arch/sparc/vdso/vdso2c.c             | 2 +-
 arch/x86/entry/vdso/vdso2c.c         | 2 +-
 arch/x86/kernel/cpu/intel.c          | 2 +-
 tools/perf/arch/x86/util/perf_regs.c | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/sparc/vdso/vdso2c.c b/arch/sparc/vdso/vdso2c.c
index ab75041..70df9a8 100644
--- a/arch/sparc/vdso/vdso2c.c
+++ b/arch/sparc/vdso/vdso2c.c
@@ -192,7 +192,7 @@ int main(int argc, char **argv)
 
 	/*
 	 * Figure out the struct name.  If we're writing to a .so file,
-	 * generate raw output insted.
+	 * generate raw output instead.
 	 */
 	name = strdup(argv[3]);
 	namelen = strlen(name);
diff --git a/arch/x86/entry/vdso/vdso2c.c b/arch/x86/entry/vdso/vdso2c.c
index 2d0f3d8..edfe978 100644
--- a/arch/x86/entry/vdso/vdso2c.c
+++ b/arch/x86/entry/vdso/vdso2c.c
@@ -218,7 +218,7 @@ int main(int argc, char **argv)
 
 	/*
 	 * Figure out the struct name.  If we're writing to a .so file,
-	 * generate raw output insted.
+	 * generate raw output instead.
 	 */
 	name = strdup(argv[3]);
 	namelen = strlen(name);
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 0e422a5..63e381a 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -301,7 +301,7 @@ static void early_init_intel(struct cpuinfo_x86 *c)
 	 *  The operating system must reload CR3 to cause the TLB to be flushed"
 	 *
 	 * As a result, boot_cpu_has(X86_FEATURE_PGE) in arch/x86/include/asm/tlbflush.h
-	 * should be false so that __flush_tlb_all() causes CR3 insted of CR4.PGE
+	 * should be false so that __flush_tlb_all() causes CR3 instead of CR4.PGE
 	 * to be modified.
 	 */
 	if (c->x86 == 5 && c->x86_model == 9) {
diff --git a/tools/perf/arch/x86/util/perf_regs.c b/tools/perf/arch/x86/util/perf_regs.c
index fca81b3..207c568 100644
--- a/tools/perf/arch/x86/util/perf_regs.c
+++ b/tools/perf/arch/x86/util/perf_regs.c
@@ -165,7 +165,7 @@ static int sdt_init_op_regex(void)
 /*
  * Max x86 register name length is 5(ex: %r15d). So, 6th char
  * should always contain NULL. This helps to find register name
- * length using strlen, insted of maintaing one more variable.
+ * length using strlen, instead of maintaining one more variable.
  */
 #define SDT_REG_NAME_SIZE  6
 
@@ -207,7 +207,7 @@ int arch_sdt_arg_parse_op(char *old_op, char **new_op)
 	 * and displacement 0 (Both sign and displacement 0 are
 	 * optional so it may be empty). Use one more character
 	 * to hold last NULL so that strlen can be used to find
-	 * prefix length, instead of maintaing one more variable.
+	 * prefix length, instead of maintaining one more variable.
 	 */
 	char prefix[3] = {0};
 
-- 
1.8.3.1

