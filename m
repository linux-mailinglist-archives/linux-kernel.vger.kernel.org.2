Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3F35389BB3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 05:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbhETDSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 23:18:18 -0400
Received: from mga05.intel.com ([192.55.52.43]:58828 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230308AbhETDSO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 23:18:14 -0400
IronPort-SDR: dgRrY1dvRYvZumvvELm+jIVgzawe/1KUhXh5yK4SufmQu+2ePfOlxsOEYw3HG1euyUkAvCgbTO
 CWhEUAvJ0Ctw==
X-IronPort-AV: E=McAfee;i="6200,9189,9989"; a="286659617"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="286659617"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 20:16:53 -0700
IronPort-SDR: NPa2D7soFTkX5/qo7Tp1qlOFLatUC/X8xjK7eajtF5Xyj92IWI8I91Hb+6r3/FpX9hnH7BNQ+h
 Qk/1c79smocA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="395527220"
Received: from allen-box.sh.intel.com ([10.239.159.128])
  by orsmga006.jf.intel.com with ESMTP; 19 May 2021 20:16:51 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     ashok.raj@intel.com, kevin.tian@intel.com, jacob.jun.pan@intel.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 04/11] iommu/vt-d: Refactor prq_event_thread()
Date:   Thu, 20 May 2021 11:15:24 +0800
Message-Id: <20210520031531.712333-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210520031531.712333-1-baolu.lu@linux.intel.com>
References: <20210520031531.712333-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor prq_event_thread() by moving handling single prq event out of
the main loop.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/svm.c | 239 ++++++++++++++++++++++----------------
 1 file changed, 136 insertions(+), 103 deletions(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 57867ff97bc2..d51ddece4259 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -866,141 +866,174 @@ intel_svm_prq_report(struct device *dev, struct page_req_dsc *desc)
 	return iommu_report_device_fault(dev, &event);
 }
 
+static void handle_bad_prq_event(struct intel_iommu *iommu,
+				 struct page_req_dsc *req, int result)
+{
+	struct qi_desc desc;
+
+	pr_err("%s: Invalid page request: %08llx %08llx\n",
+	       iommu->name, ((unsigned long long *)req)[0],
+	       ((unsigned long long *)req)[1]);
+
+	/*
+	 * Per VT-d spec. v3.0 ch7.7, system software must
+	 * respond with page group response if private data
+	 * is present (PDP) or last page in group (LPIG) bit
+	 * is set. This is an additional VT-d feature beyond
+	 * PCI ATS spec.
+	 */
+	if (!req->lpig && !req->priv_data_present)
+		return;
+
+	desc.qw0 = QI_PGRP_PASID(req->pasid) |
+			QI_PGRP_DID(req->rid) |
+			QI_PGRP_PASID_P(req->pasid_present) |
+			QI_PGRP_PDP(req->priv_data_present) |
+			QI_PGRP_RESP_CODE(result) |
+			QI_PGRP_RESP_TYPE;
+	desc.qw1 = QI_PGRP_IDX(req->prg_index) |
+			QI_PGRP_LPIG(req->lpig);
+	desc.qw2 = 0;
+	desc.qw3 = 0;
+
+	if (req->priv_data_present)
+		memcpy(&desc.qw2, req->priv_data, sizeof(req->priv_data));
+	qi_submit_sync(iommu, &desc, 1, 0);
+}
+
+static void handle_single_prq_event(struct intel_iommu *iommu,
+				    struct mm_struct *mm,
+				    struct page_req_dsc *req)
+{
+	u64 address = (u64)req->addr << VTD_PAGE_SHIFT;
+	int result = QI_RESP_INVALID;
+	struct vm_area_struct *vma;
+	struct qi_desc desc;
+	unsigned int flags;
+	vm_fault_t ret;
+
+	/* If the mm is already defunct, don't handle faults. */
+	if (!mmget_not_zero(mm))
+		goto response;
+
+	mmap_read_lock(mm);
+	vma = find_extend_vma(mm, address);
+	if (!vma || address < vma->vm_start)
+		goto invalid;
+
+	if (access_error(vma, req))
+		goto invalid;
+
+	flags = FAULT_FLAG_USER | FAULT_FLAG_REMOTE;
+	if (req->wr_req)
+		flags |= FAULT_FLAG_WRITE;
+
+	ret = handle_mm_fault(vma, address, flags, NULL);
+	if (!(ret & VM_FAULT_ERROR))
+		result = QI_RESP_SUCCESS;
+invalid:
+	mmap_read_unlock(mm);
+	mmput(mm);
+
+response:
+	if (!(req->lpig || req->priv_data_present))
+		return;
+
+	desc.qw0 = QI_PGRP_PASID(req->pasid) |
+			QI_PGRP_DID(req->rid) |
+			QI_PGRP_PASID_P(req->pasid_present) |
+			QI_PGRP_PDP(req->priv_data_present) |
+			QI_PGRP_RESP_CODE(result) |
+			QI_PGRP_RESP_TYPE;
+	desc.qw1 = QI_PGRP_IDX(req->prg_index) |
+			QI_PGRP_LPIG(req->lpig);
+	desc.qw2 = 0;
+	desc.qw3 = 0;
+
+	if (req->priv_data_present)
+		memcpy(&desc.qw2, req->priv_data, sizeof(req->priv_data));
+
+	qi_submit_sync(iommu, &desc, 1, 0);
+}
+
 static irqreturn_t prq_event_thread(int irq, void *d)
 {
 	struct intel_svm_dev *sdev = NULL;
 	struct intel_iommu *iommu = d;
 	struct intel_svm *svm = NULL;
-	int head, tail, handled = 0;
-	unsigned int flags = 0;
+	struct page_req_dsc *req;
+	int head, tail, handled;
+	u64 address;
 
-	/* Clear PPR bit before reading head/tail registers, to
-	 * ensure that we get a new interrupt if needed. */
+	/*
+	 * Clear PPR bit before reading head/tail registers, to ensure that
+	 * we get a new interrupt if needed.
+	 */
 	writel(DMA_PRS_PPR, iommu->reg + DMAR_PRS_REG);
 
 	tail = dmar_readq(iommu->reg + DMAR_PQT_REG) & PRQ_RING_MASK;
 	head = dmar_readq(iommu->reg + DMAR_PQH_REG) & PRQ_RING_MASK;
+	handled = (head != tail);
 	while (head != tail) {
-		struct vm_area_struct *vma;
-		struct page_req_dsc *req;
-		struct qi_desc resp;
-		int result;
-		vm_fault_t ret;
-		u64 address;
-
-		handled = 1;
 		req = &iommu->prq[head / sizeof(*req)];
-		result = QI_RESP_INVALID;
 		address = (u64)req->addr << VTD_PAGE_SHIFT;
-		if (!req->pasid_present) {
-			pr_err("%s: Page request without PASID: %08llx %08llx\n",
-			       iommu->name, ((unsigned long long *)req)[0],
-			       ((unsigned long long *)req)[1]);
-			goto no_pasid;
+
+		if (unlikely(!req->pasid_present)) {
+			pr_err("IOMMU: %s: Page request without PASID\n",
+			       iommu->name);
+bad_req:
+			svm = NULL;
+			sdev = NULL;
+			handle_bad_prq_event(iommu, req, QI_RESP_INVALID);
+			goto prq_advance;
 		}
-		/* We shall not receive page request for supervisor SVM */
-		if (req->pm_req && (req->rd_req | req->wr_req)) {
-			pr_err("Unexpected page request in Privilege Mode");
-			/* No need to find the matching sdev as for bad_req */
-			goto no_pasid;
+
+		if (unlikely(!is_canonical_address(address))) {
+			pr_err("IOMMU: %s: Address is not canonical\n",
+			       iommu->name);
+			goto bad_req;
+		}
+
+		if (unlikely(req->pm_req && (req->rd_req | req->wr_req))) {
+			pr_err("IOMMU: %s: Page request in Privilege Mode\n",
+			       iommu->name);
+			goto bad_req;
 		}
-		/* DMA read with exec requeset is not supported. */
-		if (req->exe_req && req->rd_req) {
-			pr_err("Execution request not supported\n");
-			goto no_pasid;
+
+		if (unlikely(req->exe_req && req->rd_req)) {
+			pr_err("IOMMU: %s: Execution request not supported\n",
+			       iommu->name);
+			goto bad_req;
 		}
+
 		if (!svm || svm->pasid != req->pasid) {
-			rcu_read_lock();
-			svm = pasid_private_find(req->pasid);
-			/* It *can't* go away, because the driver is not permitted
+			/*
+			 * It can't go away, because the driver is not permitted
 			 * to unbind the mm while any page faults are outstanding.
-			 * So we only need RCU to protect the internal idr code. */
-			rcu_read_unlock();
-			if (IS_ERR_OR_NULL(svm)) {
-				pr_err("%s: Page request for invalid PASID %d: %08llx %08llx\n",
-				       iommu->name, req->pasid, ((unsigned long long *)req)[0],
-				       ((unsigned long long *)req)[1]);
-				goto no_pasid;
-			}
+			 */
+			svm = pasid_private_find(req->pasid);
+			if (IS_ERR_OR_NULL(svm) || (svm->flags & SVM_FLAG_SUPERVISOR_MODE))
+				goto bad_req;
 		}
 
-		if (!sdev || sdev->sid != req->rid)
+		if (!sdev || sdev->sid != req->rid) {
 			sdev = svm_lookup_device_by_sid(svm, req->rid);
-
-		/* Since we're using init_mm.pgd directly, we should never take
-		 * any faults on kernel addresses. */
-		if (!svm->mm)
-			goto bad_req;
-
-		/* If address is not canonical, return invalid response */
-		if (!is_canonical_address(address))
-			goto bad_req;
+			if (!sdev)
+				goto bad_req;
+		}
 
 		/*
 		 * If prq is to be handled outside iommu driver via receiver of
 		 * the fault notifiers, we skip the page response here.
 		 */
 		if (svm->flags & SVM_FLAG_GUEST_MODE) {
-			if (sdev && !intel_svm_prq_report(sdev->dev, req))
+			if (!intel_svm_prq_report(sdev->dev, req))
 				goto prq_advance;
 			else
 				goto bad_req;
 		}
 
-		/* If the mm is already defunct, don't handle faults. */
-		if (!mmget_not_zero(svm->mm))
-			goto bad_req;
-
-		mmap_read_lock(svm->mm);
-		vma = find_extend_vma(svm->mm, address);
-		if (!vma || address < vma->vm_start)
-			goto invalid;
-
-		if (access_error(vma, req))
-			goto invalid;
-
-		flags = FAULT_FLAG_USER | FAULT_FLAG_REMOTE;
-		if (req->wr_req)
-			flags |= FAULT_FLAG_WRITE;
-
-		ret = handle_mm_fault(vma, address, flags, NULL);
-		if (ret & VM_FAULT_ERROR)
-			goto invalid;
-
-		result = QI_RESP_SUCCESS;
-invalid:
-		mmap_read_unlock(svm->mm);
-		mmput(svm->mm);
-bad_req:
-		/* We get here in the error case where the PASID lookup failed,
-		   and these can be NULL. Do not use them below this point! */
-		sdev = NULL;
-		svm = NULL;
-no_pasid:
-		if (req->lpig || req->priv_data_present) {
-			/*
-			 * Per VT-d spec. v3.0 ch7.7, system software must
-			 * respond with page group response if private data
-			 * is present (PDP) or last page in group (LPIG) bit
-			 * is set. This is an additional VT-d feature beyond
-			 * PCI ATS spec.
-			 */
-			resp.qw0 = QI_PGRP_PASID(req->pasid) |
-				QI_PGRP_DID(req->rid) |
-				QI_PGRP_PASID_P(req->pasid_present) |
-				QI_PGRP_PDP(req->priv_data_present) |
-				QI_PGRP_RESP_CODE(result) |
-				QI_PGRP_RESP_TYPE;
-			resp.qw1 = QI_PGRP_IDX(req->prg_index) |
-				QI_PGRP_LPIG(req->lpig);
-			resp.qw2 = 0;
-			resp.qw3 = 0;
-
-			if (req->priv_data_present)
-				memcpy(&resp.qw2, req->priv_data,
-				       sizeof(req->priv_data));
-			qi_submit_sync(iommu, &resp, 1, 0);
-		}
+		handle_single_prq_event(iommu, svm->mm, req);
 prq_advance:
 		head = (head + sizeof(*req)) & PRQ_RING_MASK;
 	}
-- 
2.25.1

