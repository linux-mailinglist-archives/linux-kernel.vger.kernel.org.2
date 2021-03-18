Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9367833FC88
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 02:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbhCRBDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 21:03:11 -0400
Received: from mga06.intel.com ([134.134.136.31]:29441 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230431AbhCRBDA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 21:03:00 -0400
IronPort-SDR: 6s1N2Xd6AksQVQW8ZA/pA5NwtN2vr8xkHjeQTQvtghfsXVUaTCy69DfhEngkFc1aX+/5asZsb5
 IV1+XpLQnc4w==
X-IronPort-AV: E=McAfee;i="6000,8403,9926"; a="250933585"
X-IronPort-AV: E=Sophos;i="5.81,257,1610438400"; 
   d="scan'208";a="250933585"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2021 18:03:00 -0700
IronPort-SDR: y4Z6Tm6N5tJ/EywPAX9K3WS0oeqz/xnz6cDJ3oijPsrc+n5o4cJ4Qdlx8+0zcGHkXQ6TtqGdxE
 /UXzSnoCniDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,257,1610438400"; 
   d="scan'208";a="411680283"
Received: from allen-box.sh.intel.com ([10.239.159.128])
  by orsmga007.jf.intel.com with ESMTP; 17 Mar 2021 18:02:58 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     Ashok Raj <ashok.raj@intel.com>, Guo Kaijie <Kaijie.Guo@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/1] iommu/vt-d: Report more information about invalidation errors
Date:   Thu, 18 Mar 2021 08:53:40 +0800
Message-Id: <20210318005340.187311-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the invalidation queue errors are encountered, dump the information
logged by the VT-d hardware together with the pending queue invalidation
descriptors.

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Tested-by: Guo Kaijie <Kaijie.Guo@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/dmar.c  | 68 ++++++++++++++++++++++++++++++++++---
 include/linux/intel-iommu.h |  6 ++++
 2 files changed, 70 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index d5c51b5c20af..6971397805f3 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1205,6 +1205,63 @@ static inline void reclaim_free_desc(struct q_inval *qi)
 	}
 }
 
+static const char *qi_type_string(u8 type)
+{
+	switch (type) {
+	case QI_CC_TYPE:
+		return "Context-cache Invalidation";
+	case QI_IOTLB_TYPE:
+		return "IOTLB Invalidation";
+	case QI_DIOTLB_TYPE:
+		return "Device-TLB Invalidation";
+	case QI_IEC_TYPE:
+		return "Interrupt Entry Cache Invalidation";
+	case QI_IWD_TYPE:
+		return "Invalidation Wait";
+	case QI_EIOTLB_TYPE:
+		return "PASID-based IOTLB Invalidation";
+	case QI_PC_TYPE:
+		return "PASID-cache Invalidation";
+	case QI_DEIOTLB_TYPE:
+		return "PASID-based Device-TLB Invalidation";
+	case QI_PGRP_RESP_TYPE:
+		return "Page Group Response";
+	default:
+		return "UNKNOWN";
+	}
+}
+
+static void qi_dump_fault(struct intel_iommu *iommu, u32 fault)
+{
+	unsigned int head = dmar_readl(iommu->reg + DMAR_IQH_REG);
+	u64 iqe_err = dmar_readq(iommu->reg + DMAR_IQER_REG);
+	struct qi_desc *desc = iommu->qi->desc + head;
+
+	if (fault & DMA_FSTS_IQE)
+		pr_err("VT-d detected Invalidation Queue Error: Reason %llx",
+		       DMAR_IQER_REG_IQEI(iqe_err));
+	if (fault & DMA_FSTS_ITE)
+		pr_err("VT-d detected Invalidation Time-out Error: SID %llx",
+		       DMAR_IQER_REG_ITESID(iqe_err));
+	if (fault & DMA_FSTS_ICE)
+		pr_err("VT-d detected Invalidation Completion Error: SID %llx",
+		       DMAR_IQER_REG_ICESID(iqe_err));
+
+	pr_err("QI HEAD: %s qw0 = 0x%llx, qw1 = 0x%llx\n",
+	       qi_type_string(desc->qw0 & 0xf),
+	       (unsigned long long)desc->qw0,
+	       (unsigned long long)desc->qw1);
+
+	head = ((head >> qi_shift(iommu)) + QI_LENGTH - 1) % QI_LENGTH;
+	head <<= qi_shift(iommu);
+	desc = iommu->qi->desc + head;
+
+	pr_err("QI PRIOR: %s qw0 = 0x%llx, qw1 = 0x%llx\n",
+	       qi_type_string(desc->qw0 & 0xf),
+	       (unsigned long long)desc->qw0,
+	       (unsigned long long)desc->qw1);
+}
+
 static int qi_check_fault(struct intel_iommu *iommu, int index, int wait_index)
 {
 	u32 fault;
@@ -1216,6 +1273,8 @@ static int qi_check_fault(struct intel_iommu *iommu, int index, int wait_index)
 		return -EAGAIN;
 
 	fault = readl(iommu->reg + DMAR_FSTS_REG);
+	if (fault & (DMA_FSTS_IQE | DMA_FSTS_ITE | DMA_FSTS_ICE))
+		qi_dump_fault(iommu, fault);
 
 	/*
 	 * If IQE happens, the head points to the descriptor associated
@@ -1232,12 +1291,10 @@ static int qi_check_fault(struct intel_iommu *iommu, int index, int wait_index)
 			 * used by software as private data. We won't print
 			 * out these two qw's for security consideration.
 			 */
-			pr_err("VT-d detected invalid descriptor: qw0 = %llx, qw1 = %llx\n",
-			       (unsigned long long)desc->qw0,
-			       (unsigned long long)desc->qw1);
 			memcpy(desc, qi->desc + (wait_index << shift),
 			       1 << shift);
 			writel(DMA_FSTS_IQE, iommu->reg + DMAR_FSTS_REG);
+			pr_info("Invalidation Queue Error (IQE) cleared\n");
 			return -EINVAL;
 		}
 	}
@@ -1254,6 +1311,7 @@ static int qi_check_fault(struct intel_iommu *iommu, int index, int wait_index)
 		tail = ((tail >> shift) - 1 + QI_LENGTH) % QI_LENGTH;
 
 		writel(DMA_FSTS_ITE, iommu->reg + DMAR_FSTS_REG);
+		pr_info("Invalidation Time-out Error (ITE) cleared\n");
 
 		do {
 			if (qi->desc_status[head] == QI_IN_USE)
@@ -1265,8 +1323,10 @@ static int qi_check_fault(struct intel_iommu *iommu, int index, int wait_index)
 			return -EAGAIN;
 	}
 
-	if (fault & DMA_FSTS_ICE)
+	if (fault & DMA_FSTS_ICE) {
 		writel(DMA_FSTS_ICE, iommu->reg + DMAR_FSTS_REG);
+		pr_info("Invalidation Completion Error (ICE) cleared\n");
+	}
 
 	return 0;
 }
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index d1f32b33415a..76f974da8ca4 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -20,6 +20,7 @@
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/dmar.h>
 #include <linux/ioasid.h>
+#include <linux/bitfield.h>
 
 #include <asm/cacheflush.h>
 #include <asm/iommu.h>
@@ -80,6 +81,7 @@
 #define DMAR_IQ_SHIFT	4	/* Invalidation queue head/tail shift */
 #define DMAR_IQA_REG	0x90	/* Invalidation queue addr register */
 #define DMAR_ICS_REG	0x9c	/* Invalidation complete status register */
+#define DMAR_IQER_REG	0xb0	/* Invalidation queue error record register */
 #define DMAR_IRTA_REG	0xb8    /* Interrupt remapping table addr register */
 #define DMAR_PQH_REG	0xc0	/* Page request queue head register */
 #define DMAR_PQT_REG	0xc8	/* Page request queue tail register */
@@ -126,6 +128,10 @@
 #define DMAR_VCMD_REG		0xe10 /* Virtual command register */
 #define DMAR_VCRSP_REG		0xe20 /* Virtual command response register */
 
+#define DMAR_IQER_REG_IQEI(reg)		FIELD_GET(GENMASK_ULL(3, 0), reg)
+#define DMAR_IQER_REG_ITESID(reg)	FIELD_GET(GENMASK_ULL(47, 32), reg)
+#define DMAR_IQER_REG_ICESID(reg)	FIELD_GET(GENMASK_ULL(63, 48), reg)
+
 #define OFFSET_STRIDE		(9)
 
 #define dmar_readq(a) readq(a)
-- 
2.25.1

