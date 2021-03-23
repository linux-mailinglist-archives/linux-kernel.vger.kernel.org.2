Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA0F33454D2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 02:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbhCWBQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 21:16:33 -0400
Received: from mga01.intel.com ([192.55.52.88]:21999 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230465AbhCWBPn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 21:15:43 -0400
IronPort-SDR: qL3Zo+RqVuFGn/B5oawCxO2Y/2MlP/zRudKCm7d2hk3xrP74xWMgaIIHvO6sXGKh45GEYuy5gq
 bZ8XZ9b2Vz4Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="210455656"
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="210455656"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 18:15:43 -0700
IronPort-SDR: wBoLq5XsrZtSB4vGSmXLEyZehOlKMVSpPxjr4ryACUxOrZIFCT3gzPZLHo4deHbLRBm5sx67mr
 Gm28BRlFMyhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="435362463"
Received: from allen-box.sh.intel.com ([10.239.159.128])
  by fmsmga004.fm.intel.com with ESMTP; 22 Mar 2021 18:15:41 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     ashok.raj@intel.com, kevin.tian@intel.com, jacob.jun.pan@intel.com,
        yi.l.liu@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 3/5] iommu/vt-d: Remove SVM_FLAG_PRIVATE_PASID
Date:   Tue, 23 Mar 2021 09:05:58 +0800
Message-Id: <20210323010600.678627-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210323010600.678627-1-baolu.lu@linux.intel.com>
References: <20210323010600.678627-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SVM_FLAG_PRIVATE_PASID has never been referenced in the tree, and
there's no plan to have anything to use it. So cleanup it.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/svm.c | 40 ++++++++++++++++++---------------------
 include/linux/intel-svm.h | 16 +++-------------
 2 files changed, 21 insertions(+), 35 deletions(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 875ee74d8c41..5165cea90421 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -465,9 +465,9 @@ intel_svm_bind_mm(struct device *dev, unsigned int flags,
 		  struct mm_struct *mm, struct intel_svm_dev **sd)
 {
 	struct intel_iommu *iommu = device_to_iommu(dev, NULL, NULL);
+	struct intel_svm *svm = NULL, *t;
 	struct device_domain_info *info;
 	struct intel_svm_dev *sdev;
-	struct intel_svm *svm = NULL;
 	unsigned long iflags;
 	int pasid_max;
 	int ret;
@@ -493,30 +493,26 @@ intel_svm_bind_mm(struct device *dev, unsigned int flags,
 		}
 	}
 
-	if (!(flags & SVM_FLAG_PRIVATE_PASID)) {
-		struct intel_svm *t;
-
-		list_for_each_entry(t, &global_svm_list, list) {
-			if (t->mm != mm || (t->flags & SVM_FLAG_PRIVATE_PASID))
-				continue;
-
-			svm = t;
-			if (svm->pasid >= pasid_max) {
-				dev_warn(dev,
-					 "Limited PASID width. Cannot use existing PASID %d\n",
-					 svm->pasid);
-				ret = -ENOSPC;
-				goto out;
-			}
+	list_for_each_entry(t, &global_svm_list, list) {
+		if (t->mm != mm)
+			continue;
 
-			/* Find the matching device in svm list */
-			for_each_svm_dev(sdev, svm, dev) {
-				sdev->users++;
-				goto success;
-			}
+		svm = t;
+		if (svm->pasid >= pasid_max) {
+			dev_warn(dev,
+				 "Limited PASID width. Cannot use existing PASID %d\n",
+				 svm->pasid);
+			ret = -ENOSPC;
+			goto out;
+		}
 
-			break;
+		/* Find the matching device in svm list */
+		for_each_svm_dev(sdev, svm, dev) {
+			sdev->users++;
+			goto success;
 		}
+
+		break;
 	}
 
 	sdev = kzalloc(sizeof(*sdev), GFP_KERNEL);
diff --git a/include/linux/intel-svm.h b/include/linux/intel-svm.h
index 6c9d10c0fb1e..10fa80eef13a 100644
--- a/include/linux/intel-svm.h
+++ b/include/linux/intel-svm.h
@@ -14,16 +14,6 @@
 #define SVM_REQ_EXEC	(1<<1)
 #define SVM_REQ_PRIV	(1<<0)
 
-/*
- * The SVM_FLAG_PRIVATE_PASID flag requests a PASID which is *not* the "main"
- * PASID for the current process. Even if a PASID already exists, a new one
- * will be allocated. And the PASID allocated with SVM_FLAG_PRIVATE_PASID
- * will not be given to subsequent callers. This facility allows a driver to
- * disambiguate between multiple device contexts which access the same MM,
- * if there is no other way to do so. It should be used sparingly, if at all.
- */
-#define SVM_FLAG_PRIVATE_PASID		(1<<0)
-
 /*
  * The SVM_FLAG_SUPERVISOR_MODE flag requests a PASID which can be used only
  * for access to kernel addresses. No IOTLB flushes are automatically done
@@ -35,18 +25,18 @@
  * It is unlikely that we will ever hook into flush_tlb_kernel_range() to
  * do such IOTLB flushes automatically.
  */
-#define SVM_FLAG_SUPERVISOR_MODE	(1<<1)
+#define SVM_FLAG_SUPERVISOR_MODE	BIT(0)
 /*
  * The SVM_FLAG_GUEST_MODE flag is used when a PASID bind is for guest
  * processes. Compared to the host bind, the primary differences are:
  * 1. mm life cycle management
  * 2. fault reporting
  */
-#define SVM_FLAG_GUEST_MODE		(1<<2)
+#define SVM_FLAG_GUEST_MODE		BIT(1)
 /*
  * The SVM_FLAG_GUEST_PASID flag is used when a guest has its own PASID space,
  * which requires guest and host PASID translation at both directions.
  */
-#define SVM_FLAG_GUEST_PASID		(1<<3)
+#define SVM_FLAG_GUEST_PASID		BIT(2)
 
 #endif /* __INTEL_SVM_H__ */
-- 
2.25.1

