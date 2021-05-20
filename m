Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADD60389BBE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 05:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbhETDSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 23:18:24 -0400
Received: from mga05.intel.com ([192.55.52.43]:58836 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230308AbhETDST (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 23:18:19 -0400
IronPort-SDR: GbHPSNbL9RHV71II5viPZMC/9SqYWxK8mkwwg6ZyCKIqB9+iNv4OTcPiFp3xrL6AEuG2ufbNsL
 T8z1w8j7sBaw==
X-IronPort-AV: E=McAfee;i="6200,9189,9989"; a="286659632"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="286659632"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 20:16:58 -0700
IronPort-SDR: 8yj/D8DMDMOYIGGBnAc5O+Vb0WKDM/27+tXw2CfRtq09FCLli8QAzvhYTXcFRHIojCLvubFFC2
 fhzxxJAqjmGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="395527254"
Received: from allen-box.sh.intel.com ([10.239.159.128])
  by orsmga006.jf.intel.com with ESMTP; 19 May 2021 20:16:56 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     ashok.raj@intel.com, kevin.tian@intel.com, jacob.jun.pan@intel.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 06/11] iommu/vt-d: Report prq to io-pgfault framework
Date:   Thu, 20 May 2021 11:15:26 +0800
Message-Id: <20210520031531.712333-7-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210520031531.712333-1-baolu.lu@linux.intel.com>
References: <20210520031531.712333-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let the IO page fault requests get handled through the io-pgfault
framework.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 14 ++++++-
 drivers/iommu/intel/svm.c   | 84 +++----------------------------------
 2 files changed, 17 insertions(+), 81 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index e72d8b10b2a1..f1c2287a3646 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -5343,6 +5343,7 @@ static int intel_iommu_enable_sva(struct device *dev)
 {
 	struct device_domain_info *info = get_domain_info(dev);
 	struct intel_iommu *iommu = info->iommu;
+	int ret;
 
 	if (!info || !iommu || dmar_disabled)
 		return -EINVAL;
@@ -5356,15 +5357,24 @@ static int intel_iommu_enable_sva(struct device *dev)
 	if (intel_iommu_enable_pasid(iommu, dev))
 		return -ENODEV;
 
-	return iopf_queue_add_device(iommu->iopf_queue, dev);
+	ret = iopf_queue_add_device(iommu->iopf_queue, dev);
+	if (!ret)
+		ret = iommu_register_device_fault_handler(dev, iommu_queue_iopf, dev);
+
+	return ret;
 }
 
 static int intel_iommu_disable_sva(struct device *dev)
 {
 	struct device_domain_info *info = get_domain_info(dev);
 	struct intel_iommu *iommu = info->iommu;
+	int ret;
+
+	ret = iommu_unregister_device_fault_handler(dev);
+	if (!ret)
+		ret = iopf_queue_remove_device(iommu->iopf_queue, dev);
 
-	return iopf_queue_remove_device(iommu->iopf_queue, dev);
+	return ret;
 }
 
 /*
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 4dc3ab36e9ae..ade157b64ce7 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -724,22 +724,6 @@ struct page_req_dsc {
 
 #define PRQ_RING_MASK	((0x1000 << PRQ_ORDER) - 0x20)
 
-static bool access_error(struct vm_area_struct *vma, struct page_req_dsc *req)
-{
-	unsigned long requested = 0;
-
-	if (req->exe_req)
-		requested |= VM_EXEC;
-
-	if (req->rd_req)
-		requested |= VM_READ;
-
-	if (req->wr_req)
-		requested |= VM_WRITE;
-
-	return (requested & ~vma->vm_flags) != 0;
-}
-
 static bool is_canonical_address(u64 addr)
 {
 	int shift = 64 - (__VIRTUAL_MASK_SHIFT + 1);
@@ -809,6 +793,8 @@ static void intel_svm_drain_prq(struct device *dev, u32 pasid)
 		goto prq_retry;
 	}
 
+	iopf_queue_flush_dev(dev);
+
 	/*
 	 * Perform steps described in VT-d spec CH7.10 to drain page
 	 * requests and responses in hardware.
@@ -924,61 +910,6 @@ static void handle_bad_prq_event(struct intel_iommu *iommu,
 	qi_submit_sync(iommu, &desc, 1, 0);
 }
 
-static void handle_single_prq_event(struct intel_iommu *iommu,
-				    struct mm_struct *mm,
-				    struct page_req_dsc *req)
-{
-	u64 address = (u64)req->addr << VTD_PAGE_SHIFT;
-	int result = QI_RESP_INVALID;
-	struct vm_area_struct *vma;
-	struct qi_desc desc;
-	unsigned int flags;
-	vm_fault_t ret;
-
-	/* If the mm is already defunct, don't handle faults. */
-	if (!mmget_not_zero(mm))
-		goto response;
-
-	mmap_read_lock(mm);
-	vma = find_extend_vma(mm, address);
-	if (!vma || address < vma->vm_start)
-		goto invalid;
-
-	if (access_error(vma, req))
-		goto invalid;
-
-	flags = FAULT_FLAG_USER | FAULT_FLAG_REMOTE;
-	if (req->wr_req)
-		flags |= FAULT_FLAG_WRITE;
-
-	ret = handle_mm_fault(vma, address, flags, NULL);
-	if (!(ret & VM_FAULT_ERROR))
-		result = QI_RESP_SUCCESS;
-invalid:
-	mmap_read_unlock(mm);
-	mmput(mm);
-
-response:
-	if (!(req->lpig || req->priv_data_present))
-		return;
-
-	desc.qw0 = QI_PGRP_PASID(req->pasid) |
-			QI_PGRP_DID(req->rid) |
-			QI_PGRP_PASID_P(req->pasid_present) |
-			QI_PGRP_PDP(req->priv_data_present) |
-			QI_PGRP_RESP_CODE(result) |
-			QI_PGRP_RESP_TYPE;
-	desc.qw1 = QI_PGRP_IDX(req->prg_index) |
-			QI_PGRP_LPIG(req->lpig);
-	desc.qw2 = 0;
-	desc.qw3 = 0;
-
-	if (req->priv_data_present)
-		memcpy(&desc.qw2, req->priv_data, sizeof(req->priv_data));
-
-	qi_submit_sync(iommu, &desc, 1, 0);
-}
-
 static irqreturn_t prq_event_thread(int irq, void *d)
 {
 	struct intel_svm_dev *sdev = NULL;
@@ -1049,14 +980,8 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 		 * If prq is to be handled outside iommu driver via receiver of
 		 * the fault notifiers, we skip the page response here.
 		 */
-		if (svm->flags & SVM_FLAG_GUEST_MODE) {
-			if (!intel_svm_prq_report(sdev->dev, req))
-				goto prq_advance;
-			else
-				goto bad_req;
-		}
-
-		handle_single_prq_event(iommu, svm->mm, req);
+		if (intel_svm_prq_report(sdev->dev, req))
+			handle_bad_prq_event(iommu, req, QI_RESP_INVALID);
 prq_advance:
 		head = (head + sizeof(*req)) & PRQ_RING_MASK;
 	}
@@ -1073,6 +998,7 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 		head = dmar_readq(iommu->reg + DMAR_PQH_REG) & PRQ_RING_MASK;
 		tail = dmar_readq(iommu->reg + DMAR_PQT_REG) & PRQ_RING_MASK;
 		if (head == tail) {
+			iopf_queue_discard_partial(iommu->iopf_queue);
 			writel(DMA_PRS_PRO, iommu->reg + DMAR_PRS_REG);
 			pr_info_ratelimited("IOMMU: %s: PRQ overflow cleared",
 					    iommu->name);
-- 
2.25.1

