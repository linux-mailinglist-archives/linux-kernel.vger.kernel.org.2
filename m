Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6BA42125F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 17:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235617AbhJDPNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 11:13:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18682 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235599AbhJDPNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 11:13:48 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 194Evrmv013923;
        Mon, 4 Oct 2021 11:11:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=fibT7HHFTwvu0NqZIVv4G2uAf84MMhdoMrDj5ujioAw=;
 b=Qv7zGvD0HpFvv2/UaM0Pj0Vv/KyVAKg01AL38OU+x85nETLmyUSNVnQ8GC1nzt2JkZVC
 cRBMaMuf9kEM3xvu9cDN/teGj6/sEm/DbPtFF5EWvnZ59qjHmS1WG6WRWvabvHVbW8nW
 t9bgDtrqmB9tAQOBHgsSYCvquaqI8ks//fI0l0yotlINxuXZnFSvK+gZDS5yDC4ZG3YQ
 HmH3vIkh+sXAAO2yVzaNERa6hhtyUeAirfmhK/ls17YjeH13s2ppMK5HYoiwwvxeujRF
 L0CcT0fMeyKLYXRnfxNX2QKiIH5SXxWb/p6gjZShEgeMMKKPPxIE9e8gE/wo6NJtLNdi oA== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bg3kn8r7j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Oct 2021 11:11:56 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 194F8Ve1028018;
        Mon, 4 Oct 2021 15:11:54 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 3beepj8u96-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Oct 2021 15:11:54 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 194FBpfM43516202
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 4 Oct 2021 15:11:51 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 06C7811C04C;
        Mon,  4 Oct 2021 15:11:51 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4EEB611C064;
        Mon,  4 Oct 2021 15:11:48 +0000 (GMT)
Received: from sjain014.ibmuc.com (unknown [9.43.74.5])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  4 Oct 2021 15:11:48 +0000 (GMT)
From:   Sourabh Jain <sourabhjain@linux.ibm.com>
To:     mpe@ellerman.id.au
Cc:     hbathini@linux.ibm.com, mahesh@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
        aneesh.kumar@linux.ibm.com,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Sourabh Jain <sourabhjain@linu.ibm.com>,
        Abdul haleem <abdhalee@linux.vnet.ibm.com>
Subject: [PATCH 2/3] Remove 256MB limit restriction for boot cpu paca allocation
Date:   Mon,  4 Oct 2021 20:41:41 +0530
Message-Id: <20211004151142.256251-3-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211004151142.256251-1-sourabhjain@linux.ibm.com>
References: <20211004151142.256251-1-sourabhjain@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hlHMaci4NrqcffsT1PBJDUdmCm1b1I0I
X-Proofpoint-GUID: hlHMaci4NrqcffsT1PBJDUdmCm1b1I0I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-04_04,2021-10-04_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 bulkscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 impostorscore=0
 adultscore=0 mlxscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110040104
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
Signed-off-by: Sourabh Jain <sourabhjain@linu.ibm.com>
Reported-and-tested-by: Abdul haleem <abdhalee@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/mmu.h | 1 +
 arch/powerpc/kernel/prom.c               | 4 ++++
 arch/powerpc/mm/book3s64/hash_utils.c    | 5 ++++-
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
index 69a89fa1330d..f43070581f11 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu.h
@@ -199,6 +199,7 @@ extern int mmu_io_psize;
 /* MMU initialization */
 void mmu_cpu_feature_fixup(void);
 void mmu_early_init_devtree(void);
+void hash__early_detect_seg_size(void);
 void hash__early_init_devtree(void);
 void radix__early_init_devtree(void);
 #ifdef CONFIG_PPC_PKEY
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 1727a3abe6c1..68397f335caf 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -384,6 +384,10 @@ static int __init early_init_dt_scan_cpus(unsigned long node,
 	identical_pvr_fixup(node);
 	init_mmu_slb_size(node);
 
+	/* Initialize segment sizes */
+	if (!early_radix_enabled())
+		hash__early_detect_seg_size();
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

