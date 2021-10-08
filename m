Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 131B9426E7D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 18:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbhJHQSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 12:18:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:16780 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230081AbhJHQSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 12:18:09 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 198Ehg6i025714;
        Fri, 8 Oct 2021 12:16:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=npvkGEPGqKwEoUSC4SyInPdrQa1CL4fDAiEEVRVxIec=;
 b=s5I3jKTsbpZB6FNw7w6sfg5d8ETf69NJEudBpJ4uvopHr3xaEDr5+f6tuhBQejXJWJfT
 GD1I0Im5VwiXfJdUYxj+abDg7w71gGNPF60qSeny5DC7TXrAcBjqbMS7ceQRKFpNxtku
 9uXYYUIkAXHsmnnojHpcd0HG+Nt8jJmAisbevXS4EJKj2PvFP66cF8+wRwdYhl+xqBER
 wSJhjc8c/iLm3xNITuzkhtT6URL2gp1gr+W8ly/L1Y50F28D29DjoXUGmzRRZbXSm7UZ
 OgSv7IRDEcEfGYthHGRTN/QB3J5QVbF+vllfvBlvZ1BbiYm5vaHPN3GYjsdsuwyFLsW0 /Q== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bjr0ka6pt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Oct 2021 12:16:08 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 198GCFgq024891;
        Fri, 8 Oct 2021 16:16:06 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 3bhepdd1s2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Oct 2021 16:16:06 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 198GG29v41288108
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Oct 2021 16:16:02 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 994F0A405F;
        Fri,  8 Oct 2021 16:16:02 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 42A06A4064;
        Fri,  8 Oct 2021 16:16:00 +0000 (GMT)
Received: from sjain014.ibmuc.com (unknown [9.43.25.237])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  8 Oct 2021 16:15:59 +0000 (GMT)
From:   Sourabh Jain <sourabhjain@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     hbathini@linux.ibm.com, mahesh@linux.vnet.ibm.com,
        mpe@ellerman.id.au, linuxppc-dev@ozlabs.org,
        aneesh.kumar@linux.ibm.com,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Abdul haleem <abdhalee@linux.vnet.ibm.com>
Subject: [PATCH 2/3] Remove 256MB limit restriction for boot cpu paca allocation
Date:   Fri,  8 Oct 2021 21:45:51 +0530
Message-Id: <20211008161552.211262-3-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211008161552.211262-1-sourabhjain@linux.ibm.com>
References: <20211008161552.211262-1-sourabhjain@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9Ecs3A52HdQMsydqFbPnbcFvIt_CczOi
X-Proofpoint-GUID: 9Ecs3A52HdQMsydqFbPnbcFvIt_CczOi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-08_04,2021-10-07_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 adultscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110080092
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mahesh Salgaonkar <mahesh@linux.ibm.com>

At the time when we detect and allocate paca for boot cpu, we havn't yet
detected mmu feature of 1T segments support (not until
mmu_early_init_devtree() call). This causes ppc64_bolted_size() to return
256MB as limit forcing boot cpu paca allocation below 256MB always.

This works fine for kdump kernel boot as long as crashkernel reservation is
at offset below 256MB. But when we move kdump offset to 256MB or above,
kdump kernel fails to allocate paca for boot cpu below 256MB and crashes in
allocate_paca().

Moving the detection of segment sizes just before paca allocation for boot
cpu removes this restriction of 256MB limit. This allows kdump kernel to
successfully boot and capture vmcore.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.ibm.com>
Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Reported-and-tested-by: Abdul haleem <abdhalee@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/mmu.h | 1 +
 arch/powerpc/kernel/prom.c               | 6 ++++++
 arch/powerpc/mm/book3s64/hash_utils.c    | 5 ++++-
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
index d60be5051d60..9b05a84313bb 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu.h
@@ -199,6 +199,7 @@ extern int mmu_io_psize;
 /* MMU initialization */
 void update_cpu_features(void);
 void mmu_early_init_devtree(void);
+void hash__early_detect_seg_size(void);
 void hash__early_init_devtree(void);
 void radix__early_init_devtree(void);
 #ifdef CONFIG_PPC_PKEY
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 889c909e4ed4..5da2bfff4dea 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -385,6 +385,12 @@ static int __init early_init_dt_scan_cpus(unsigned long node,
 	identical_pvr_fixup(node);
 	init_mmu_slb_size(node);
 
+#ifdef CONFIG_PPC_BOOK3S_64
+	/* Initialize segment sizes */
+	if (!early_radix_enabled())
+		hash__early_detect_seg_size();
+#endif
+
 #ifdef CONFIG_PPC64
 	if (nthreads == 1)
 		cur_cpu_spec->cpu_features &= ~CPU_FTR_SMT;
diff --git a/arch/powerpc/mm/book3s64/hash_utils.c b/arch/powerpc/mm/book3s64/hash_utils.c
index c145776d3ae5..ef4fc6bb1b30 100644
--- a/arch/powerpc/mm/book3s64/hash_utils.c
+++ b/arch/powerpc/mm/book3s64/hash_utils.c
@@ -1020,11 +1020,14 @@ static void __init htab_initialize(void)
 #undef KB
 #undef MB
 
-void __init hash__early_init_devtree(void)
+void __init hash__early_detect_seg_size(void)
 {
 	/* Initialize segment sizes */
 	of_scan_flat_dt(htab_dt_scan_seg_sizes, NULL);
+}
 
+void __init hash__early_init_devtree(void)
+{
 	/* Initialize page sizes */
 	htab_scan_page_sizes();
 }
-- 
2.31.1

