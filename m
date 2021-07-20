Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD1D3CF197
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 03:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244160AbhGTBFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 21:05:42 -0400
Received: from mga03.intel.com ([134.134.136.65]:17245 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240688AbhGTBAx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 21:00:53 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10050"; a="211219378"
X-IronPort-AV: E=Sophos;i="5.84,253,1620716400"; 
   d="scan'208";a="211219378"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2021 18:41:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,253,1620716400"; 
   d="scan'208";a="453887573"
Received: from allen-box.sh.intel.com ([10.239.159.118])
  by orsmga007.jf.intel.com with ESMTP; 19 Jul 2021 18:41:30 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Sanjay Kumar <sanjay.k.kumar@intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Liu Yi L <yi.l.liu@intel.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 5/5] iommu/vt-d: Allow devices to have more than 32 outstanding PRs
Date:   Tue, 20 Jul 2021 09:38:56 +0800
Message-Id: <20210720013856.4143880-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210720013856.4143880-1-baolu.lu@linux.intel.com>
References: <20210720013856.4143880-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The minimum per-IOMMU PRQ queue size is one 4K page, this is more entries
than the hardcoded limit of 32 in the current VT-d code. Some devices can
support up to 512 outstanding PRQs but underutilized by this limit of 32.
Although, 32 gives some rough fairness when multiple devices share the same
IOMMU PRQ queue, but far from optimal for customized use case. This extends
the per-IOMMU PRQ queue size to four 4K pages and let the devices have as
many outstanding page requests as they can.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/intel-svm.h   | 5 +++++
 drivers/iommu/intel/iommu.c | 3 ++-
 drivers/iommu/intel/svm.c   | 4 ----
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/linux/intel-svm.h b/include/linux/intel-svm.h
index 10fa80eef13a..57cceecbe37f 100644
--- a/include/linux/intel-svm.h
+++ b/include/linux/intel-svm.h
@@ -14,6 +14,11 @@
 #define SVM_REQ_EXEC	(1<<1)
 #define SVM_REQ_PRIV	(1<<0)
 
+/* Page Request Queue depth */
+#define PRQ_ORDER	2
+#define PRQ_RING_MASK	((0x1000 << PRQ_ORDER) - 0x20)
+#define PRQ_DEPTH	((0x1000 << PRQ_ORDER) >> 5)
+
 /*
  * The SVM_FLAG_SUPERVISOR_MODE flag requests a PASID which can be used only
  * for access to kernel addresses. No IOTLB flushes are automatically done
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index f3cca1dd384d..97d65839236c 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -33,6 +33,7 @@
 #include <linux/iommu.h>
 #include <linux/dma-iommu.h>
 #include <linux/intel-iommu.h>
+#include <linux/intel-svm.h>
 #include <linux/syscore_ops.h>
 #include <linux/tboot.h>
 #include <linux/dmi.h>
@@ -1542,7 +1543,7 @@ static void iommu_enable_dev_iotlb(struct device_domain_info *info)
 
 	if (info->pri_supported &&
 	    (info->pasid_enabled ? pci_prg_resp_pasid_required(pdev) : 1)  &&
-	    !pci_reset_pri(pdev) && !pci_enable_pri(pdev, 32))
+	    !pci_reset_pri(pdev) && !pci_enable_pri(pdev, PRQ_DEPTH))
 		info->pri_enabled = 1;
 #endif
 	if (info->ats_supported && pci_ats_page_aligned(pdev) &&
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 9b0f22bc0514..813438a07b62 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -31,8 +31,6 @@ static irqreturn_t prq_event_thread(int irq, void *d);
 static void intel_svm_drain_prq(struct device *dev, u32 pasid);
 #define to_intel_svm_dev(handle) container_of(handle, struct intel_svm_dev, sva)
 
-#define PRQ_ORDER 0
-
 static DEFINE_XARRAY_ALLOC(pasid_private_array);
 static int pasid_private_add(ioasid_t pasid, void *priv)
 {
@@ -724,8 +722,6 @@ struct page_req_dsc {
 	u64 priv_data[2];
 };
 
-#define PRQ_RING_MASK	((0x1000 << PRQ_ORDER) - 0x20)
-
 static bool is_canonical_address(u64 addr)
 {
 	int shift = 64 - (__VIRTUAL_MASK_SHIFT + 1);
-- 
2.25.1

