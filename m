Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECE03454D0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 02:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbhCWBQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 21:16:30 -0400
Received: from mga01.intel.com ([192.55.52.88]:21999 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231284AbhCWBPl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 21:15:41 -0400
IronPort-SDR: 8jPLNZSXBXuB2lvrLX8YN0wxQ1eSdGkXO1B2F9f2PIq9jsB2Dsm307fzXX2BdbZZhTiobMNxpK
 M9hEfgPdSE7g==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="210455652"
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="210455652"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 18:15:41 -0700
IronPort-SDR: WQ+hfp8A/lt8gmAUT5NchneiysNRV8iaaXj3QDExXlWrNJDxW8Ld8PcL83mnTwzf9gV9ZS39bb
 MyTyg7m4m/Ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="435362452"
Received: from allen-box.sh.intel.com ([10.239.159.128])
  by fmsmga004.fm.intel.com with ESMTP; 22 Mar 2021 18:15:38 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     ashok.raj@intel.com, kevin.tian@intel.com, jacob.jun.pan@intel.com,
        yi.l.liu@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 2/5] iommu/vt-d: Remove svm_dev_ops
Date:   Tue, 23 Mar 2021 09:05:57 +0800
Message-Id: <20210323010600.678627-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210323010600.678627-1-baolu.lu@linux.intel.com>
References: <20210323010600.678627-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The svm_dev_ops has never been referenced in the tree, and there's no
plan to have anything to use it. Remove it to make the code neat.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/svm.c   | 15 +--------------
 include/linux/intel-iommu.h |  3 ---
 include/linux/intel-svm.h   |  7 -------
 3 files changed, 1 insertion(+), 24 deletions(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 5d590d63ab52..875ee74d8c41 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -462,7 +462,6 @@ static void load_pasid(struct mm_struct *mm, u32 pasid)
 /* Caller must hold pasid_mutex, mm reference */
 static int
 intel_svm_bind_mm(struct device *dev, unsigned int flags,
-		  struct svm_dev_ops *ops,
 		  struct mm_struct *mm, struct intel_svm_dev **sd)
 {
 	struct intel_iommu *iommu = device_to_iommu(dev, NULL, NULL);
@@ -512,10 +511,6 @@ intel_svm_bind_mm(struct device *dev, unsigned int flags,
 
 			/* Find the matching device in svm list */
 			for_each_svm_dev(sdev, svm, dev) {
-				if (sdev->ops != ops) {
-					ret = -EBUSY;
-					goto out;
-				}
 				sdev->users++;
 				goto success;
 			}
@@ -550,7 +545,6 @@ intel_svm_bind_mm(struct device *dev, unsigned int flags,
 
 	/* Finish the setup now we know we're keeping it */
 	sdev->users = 1;
-	sdev->ops = ops;
 	init_rcu_head(&sdev->rcu);
 
 	if (!svm) {
@@ -1006,13 +1000,6 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 		mmap_read_unlock(svm->mm);
 		mmput(svm->mm);
 bad_req:
-		WARN_ON(!sdev);
-		if (sdev && sdev->ops && sdev->ops->fault_cb) {
-			int rwxp = (req->rd_req << 3) | (req->wr_req << 2) |
-				(req->exe_req << 1) | (req->pm_req);
-			sdev->ops->fault_cb(sdev->dev, req->pasid, req->addr,
-					    req->priv_data, rwxp, result);
-		}
 		/* We get here in the error case where the PASID lookup failed,
 		   and these can be NULL. Do not use them below this point! */
 		sdev = NULL;
@@ -1087,7 +1074,7 @@ intel_svm_bind(struct device *dev, struct mm_struct *mm, void *drvdata)
 	if (drvdata)
 		flags = *(unsigned int *)drvdata;
 	mutex_lock(&pasid_mutex);
-	ret = intel_svm_bind_mm(dev, flags, NULL, mm, &sdev);
+	ret = intel_svm_bind_mm(dev, flags, mm, &sdev);
 	if (ret)
 		sva = ERR_PTR(ret);
 	else if (sdev)
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 76f974da8ca4..03faf20a6817 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -770,14 +770,11 @@ u32 intel_svm_get_pasid(struct iommu_sva *handle);
 int intel_svm_page_response(struct device *dev, struct iommu_fault_event *evt,
 			    struct iommu_page_response *msg);
 
-struct svm_dev_ops;
-
 struct intel_svm_dev {
 	struct list_head list;
 	struct rcu_head rcu;
 	struct device *dev;
 	struct intel_iommu *iommu;
-	struct svm_dev_ops *ops;
 	struct iommu_sva sva;
 	u32 pasid;
 	int users;
diff --git a/include/linux/intel-svm.h b/include/linux/intel-svm.h
index 39d368a810b8..6c9d10c0fb1e 100644
--- a/include/linux/intel-svm.h
+++ b/include/linux/intel-svm.h
@@ -8,13 +8,6 @@
 #ifndef __INTEL_SVM_H__
 #define __INTEL_SVM_H__
 
-struct device;
-
-struct svm_dev_ops {
-	void (*fault_cb)(struct device *dev, u32 pasid, u64 address,
-			 void *private, int rwxp, int response);
-};
-
 /* Values for rxwp in fault_cb callback */
 #define SVM_REQ_READ	(1<<3)
 #define SVM_REQ_WRITE	(1<<2)
-- 
2.25.1

