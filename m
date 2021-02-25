Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A15BB324A9C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 07:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233938AbhBYGjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 01:39:12 -0500
Received: from mga06.intel.com ([134.134.136.31]:22393 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233293AbhBYGjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 01:39:01 -0500
IronPort-SDR: 28JYGaMDpXx3tr28Q1gyv3KNSVrNdvA34UmUl0iSMqyOQWSI4usyxRZt+NO/RQffn8nfhxK5ee
 wvYQPwDoa0Dw==
X-IronPort-AV: E=McAfee;i="6000,8403,9905"; a="246838662"
X-IronPort-AV: E=Sophos;i="5.81,205,1610438400"; 
   d="scan'208";a="246838662"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2021 22:36:02 -0800
IronPort-SDR: b77Wx7U87EoBv/R5GUKpFJyOs3wp1ax7LfGvkJOeaU3knlBXuh6aae18jRM+hM3611QefNyfeV
 1kO2D7znc7UA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,205,1610438400"; 
   d="scan'208";a="499965283"
Received: from allen-box.sh.intel.com ([10.239.159.128])
  by fmsmga001.fm.intel.com with ESMTP; 24 Feb 2021 22:36:00 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     ashok.raj@intel.com, kevin.tian@intel.com, jacob.jun.pan@intel.com,
        yi.l.liu@intel.com, sanjay.k.kumar@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 3/5] iommu/vt-d: Invalidate PASID cache when root/context entry changed
Date:   Thu, 25 Feb 2021 14:26:52 +0800
Message-Id: <20210225062654.2864322-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210225062654.2864322-1-baolu.lu@linux.intel.com>
References: <20210225062654.2864322-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the Intel IOMMU is operating in the scalable mode, some information
from the root and context table may be used to tag entries in the PASID
cache. Software should invalidate the PASID-cache when changing root or
context table entries.

Suggested-by: Ashok Raj <ashok.raj@intel.com>
Fixes: 7373a8cc38197 ("iommu/vt-d: Setup context and enable RID2PASID support")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 18 +++++++++---------
 include/linux/intel-iommu.h |  1 +
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 19b3fd0d035b..f41b184ce6eb 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1340,6 +1340,11 @@ static void iommu_set_root_entry(struct intel_iommu *iommu)
 		      readl, (sts & DMA_GSTS_RTPS), sts);
 
 	raw_spin_unlock_irqrestore(&iommu->register_lock, flag);
+
+	iommu->flush.flush_context(iommu, 0, 0, 0, DMA_CCMD_GLOBAL_INVL);
+	if (sm_supported(iommu))
+		qi_flush_pasid_cache(iommu, 0, QI_PC_GLOBAL, 0);
+	iommu->flush.flush_iotlb(iommu, 0, 0, 0, DMA_TLB_GLOBAL_FLUSH);
 }
 
 void iommu_flush_write_buffer(struct intel_iommu *iommu)
@@ -2423,6 +2428,10 @@ static void domain_context_clear_one(struct intel_iommu *iommu, u8 bus, u8 devfn
 				   (((u16)bus) << 8) | devfn,
 				   DMA_CCMD_MASK_NOBIT,
 				   DMA_CCMD_DEVICE_INVL);
+
+	if (sm_supported(iommu))
+		qi_flush_pasid_cache(iommu, did_old, QI_PC_ALL_PASIDS, 0);
+
 	iommu->flush.flush_iotlb(iommu,
 				 did_old,
 				 0,
@@ -3268,8 +3277,6 @@ static int __init init_dmars(void)
 		register_pasid_allocator(iommu);
 #endif
 		iommu_set_root_entry(iommu);
-		iommu->flush.flush_context(iommu, 0, 0, 0, DMA_CCMD_GLOBAL_INVL);
-		iommu->flush.flush_iotlb(iommu, 0, 0, 0, DMA_TLB_GLOBAL_FLUSH);
 	}
 
 #ifdef CONFIG_INTEL_IOMMU_BROKEN_GFX_WA
@@ -3459,12 +3466,7 @@ static int init_iommu_hw(void)
 		}
 
 		iommu_flush_write_buffer(iommu);
-
 		iommu_set_root_entry(iommu);
-
-		iommu->flush.flush_context(iommu, 0, 0, 0,
-					   DMA_CCMD_GLOBAL_INVL);
-		iommu->flush.flush_iotlb(iommu, 0, 0, 0, DMA_TLB_GLOBAL_FLUSH);
 		iommu_enable_translation(iommu);
 		iommu_disable_protect_mem_regions(iommu);
 	}
@@ -3847,8 +3849,6 @@ static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
 		goto disable_iommu;
 
 	iommu_set_root_entry(iommu);
-	iommu->flush.flush_context(iommu, 0, 0, 0, DMA_CCMD_GLOBAL_INVL);
-	iommu->flush.flush_iotlb(iommu, 0, 0, 0, DMA_TLB_GLOBAL_FLUSH);
 	iommu_enable_translation(iommu);
 
 	iommu_disable_protect_mem_regions(iommu);
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 1bc46b88711a..d1f32b33415a 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -372,6 +372,7 @@ enum {
 /* PASID cache invalidation granu */
 #define QI_PC_ALL_PASIDS	0
 #define QI_PC_PASID_SEL		1
+#define QI_PC_GLOBAL		3
 
 #define QI_EIOTLB_ADDR(addr)	((u64)(addr) & VTD_PAGE_MASK)
 #define QI_EIOTLB_IH(ih)	(((u64)ih) << 6)
-- 
2.25.1

