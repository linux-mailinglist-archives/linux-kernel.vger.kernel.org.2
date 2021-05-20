Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 401FB389BBD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 05:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbhETDSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 23:18:22 -0400
Received: from mga05.intel.com ([192.55.52.43]:58828 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230333AbhETDSQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 23:18:16 -0400
IronPort-SDR: Rq9D1xcbLYMla7yNeuVnaFLLOVjfXi63KtGmyH8BD8xte2cuKBHAd8ZL5MoxEgdyTTmCs/eT8E
 T2KVOKX6XAvA==
X-IronPort-AV: E=McAfee;i="6200,9189,9989"; a="286659626"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="286659626"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 20:16:56 -0700
IronPort-SDR: WIYM2hrrsz9UraNzP4DFMZMlwRz/0dyGlkckC7/a5j3o8moJnBsx2EFm0Pk+ExQPwsyVy+64J2
 6yhwjw2fAZMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="395527236"
Received: from allen-box.sh.intel.com ([10.239.159.128])
  by orsmga006.jf.intel.com with ESMTP; 19 May 2021 20:16:53 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     ashok.raj@intel.com, kevin.tian@intel.com, jacob.jun.pan@intel.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 05/11] iommu/vt-d: Allocate/register iopf queue for sva devices
Date:   Thu, 20 May 2021 11:15:25 +0800
Message-Id: <20210520031531.712333-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210520031531.712333-1-baolu.lu@linux.intel.com>
References: <20210520031531.712333-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allocates and registers the iopf queue infrastructure for devices
which want to support IO page fault for SVA.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/intel-iommu.h |  2 ++
 drivers/iommu/intel/iommu.c | 66 ++++++++++++++++++++++++++-----------
 drivers/iommu/intel/svm.c   | 37 +++++++++++++++++----
 3 files changed, 79 insertions(+), 26 deletions(-)

diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 4e8bb186daa7..222520d149c1 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -606,6 +606,8 @@ struct intel_iommu {
 	struct completion prq_complete;
 	struct ioasid_allocator_ops pasid_allocator; /* Custom allocator for PASIDs */
 #endif
+	struct iopf_queue *iopf_queue;
+	unsigned char iopfq_name[16];
 	struct q_inval  *qi;            /* Queued invalidation info */
 	u32 *iommu_state; /* Store iommu states between suspend and resume.*/
 
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index fa6223bf1e7b..e72d8b10b2a1 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -46,6 +46,7 @@
 #include <asm/iommu.h>
 
 #include "../irq_remapping.h"
+#include "../iommu-sva-lib.h"
 #include "pasid.h"
 #include "cap_audit.h"
 
@@ -5338,6 +5339,34 @@ static int intel_iommu_disable_auxd(struct device *dev)
 	return 0;
 }
 
+static int intel_iommu_enable_sva(struct device *dev)
+{
+	struct device_domain_info *info = get_domain_info(dev);
+	struct intel_iommu *iommu = info->iommu;
+
+	if (!info || !iommu || dmar_disabled)
+		return -EINVAL;
+
+	if (!info->pasid_enabled || !info->pri_enabled || !info->ats_enabled)
+		return -EINVAL;
+
+	if (!(iommu->flags & VTD_FLAG_SVM_CAPABLE))
+		return -ENODEV;
+
+	if (intel_iommu_enable_pasid(iommu, dev))
+		return -ENODEV;
+
+	return iopf_queue_add_device(iommu->iopf_queue, dev);
+}
+
+static int intel_iommu_disable_sva(struct device *dev)
+{
+	struct device_domain_info *info = get_domain_info(dev);
+	struct intel_iommu *iommu = info->iommu;
+
+	return iopf_queue_remove_device(iommu->iopf_queue, dev);
+}
+
 /*
  * A PCI express designated vendor specific extended capability is defined
  * in the section 3.7 of Intel scalable I/O virtualization technical spec
@@ -5399,38 +5428,37 @@ intel_iommu_dev_has_feat(struct device *dev, enum iommu_dev_features feat)
 static int
 intel_iommu_dev_enable_feat(struct device *dev, enum iommu_dev_features feat)
 {
-	if (feat == IOMMU_DEV_FEAT_AUX)
+	switch (feat) {
+	case IOMMU_DEV_FEAT_AUX:
 		return intel_iommu_enable_auxd(dev);
 
-	if (feat == IOMMU_DEV_FEAT_IOPF)
+	case IOMMU_DEV_FEAT_IOPF:
 		return intel_iommu_dev_has_feat(dev, feat) ? 0 : -ENODEV;
 
-	if (feat == IOMMU_DEV_FEAT_SVA) {
-		struct device_domain_info *info = get_domain_info(dev);
-
-		if (!info)
-			return -EINVAL;
-
-		if (intel_iommu_enable_pasid(info->iommu, dev))
-			return -ENODEV;
+	case IOMMU_DEV_FEAT_SVA:
+		return intel_iommu_enable_sva(dev);
 
-		if (!info->pasid_enabled || !info->pri_enabled || !info->ats_enabled)
-			return -EINVAL;
-
-		if (info->iommu->flags & VTD_FLAG_SVM_CAPABLE)
-			return 0;
+	default:
+		return -ENODEV;
 	}
-
-	return -ENODEV;
 }
 
 static int
 intel_iommu_dev_disable_feat(struct device *dev, enum iommu_dev_features feat)
 {
-	if (feat == IOMMU_DEV_FEAT_AUX)
+	switch (feat) {
+	case IOMMU_DEV_FEAT_AUX:
 		return intel_iommu_disable_auxd(dev);
 
-	return -ENODEV;
+	case IOMMU_DEV_FEAT_IOPF:
+		return 0;
+
+	case IOMMU_DEV_FEAT_SVA:
+		return intel_iommu_disable_sva(dev);
+
+	default:
+		return -ENODEV;
+	}
 }
 
 static bool
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index d51ddece4259..4dc3ab36e9ae 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -84,6 +84,7 @@ svm_lookup_device_by_dev(struct intel_svm *svm, struct device *dev)
 
 int intel_svm_enable_prq(struct intel_iommu *iommu)
 {
+	struct iopf_queue *iopfq;
 	struct page *pages;
 	int irq, ret;
 
@@ -100,13 +101,20 @@ int intel_svm_enable_prq(struct intel_iommu *iommu)
 		pr_err("IOMMU: %s: Failed to create IRQ vector for page request queue\n",
 		       iommu->name);
 		ret = -EINVAL;
-	err:
-		free_pages((unsigned long)iommu->prq, PRQ_ORDER);
-		iommu->prq = NULL;
-		return ret;
+		goto free_prq;
 	}
 	iommu->pr_irq = irq;
 
+	snprintf(iommu->iopfq_name, sizeof(iommu->iopfq_name),
+		 "dmar%d-iopfq", iommu->seq_id);
+	iopfq = iopf_queue_alloc(iommu->iopfq_name);
+	if (!iopfq) {
+		pr_err("IOMMU: %s: Failed to allocate iopf queue\n", iommu->name);
+		ret = -ENOMEM;
+		goto free_hwirq;
+	}
+	iommu->iopf_queue = iopfq;
+
 	snprintf(iommu->prq_name, sizeof(iommu->prq_name), "dmar%d-prq", iommu->seq_id);
 
 	ret = request_threaded_irq(irq, NULL, prq_event_thread, IRQF_ONESHOT,
@@ -114,9 +122,7 @@ int intel_svm_enable_prq(struct intel_iommu *iommu)
 	if (ret) {
 		pr_err("IOMMU: %s: Failed to request IRQ for page request queue\n",
 		       iommu->name);
-		dmar_free_hwirq(irq);
-		iommu->pr_irq = 0;
-		goto err;
+		goto free_iopfq;
 	}
 	dmar_writeq(iommu->reg + DMAR_PQH_REG, 0ULL);
 	dmar_writeq(iommu->reg + DMAR_PQT_REG, 0ULL);
@@ -125,6 +131,18 @@ int intel_svm_enable_prq(struct intel_iommu *iommu)
 	init_completion(&iommu->prq_complete);
 
 	return 0;
+
+free_iopfq:
+	iopf_queue_free(iommu->iopf_queue);
+	iommu->iopf_queue = NULL;
+free_hwirq:
+	dmar_free_hwirq(irq);
+	iommu->pr_irq = 0;
+free_prq:
+	free_pages((unsigned long)iommu->prq, PRQ_ORDER);
+	iommu->prq = NULL;
+
+	return ret;
 }
 
 int intel_svm_finish_prq(struct intel_iommu *iommu)
@@ -139,6 +157,11 @@ int intel_svm_finish_prq(struct intel_iommu *iommu)
 		iommu->pr_irq = 0;
 	}
 
+	if (iommu->iopf_queue) {
+		iopf_queue_free(iommu->iopf_queue);
+		iommu->iopf_queue = NULL;
+	}
+
 	free_pages((unsigned long)iommu->prq, PRQ_ORDER);
 	iommu->prq = NULL;
 
-- 
2.25.1

