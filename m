Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFBED379992
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 00:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbhEJWDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 18:03:48 -0400
Received: from mga18.intel.com ([134.134.136.126]:44024 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231591AbhEJWDo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 18:03:44 -0400
IronPort-SDR: +GIFzuGV1Lm4Iy2JKjkFt87Yzedf6uB0V9XpsZJLb+Z7JpE0LVeKu9m8+kLhAQqYvos/1k17Qn
 cGTGxxKUaeQA==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="186742745"
X-IronPort-AV: E=Sophos;i="5.82,288,1613462400"; 
   d="scan'208";a="186742745"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 15:02:38 -0700
IronPort-SDR: p8UUeFuxgmIJb9OjSsJpeEAU5G/ov/EdaOZsm4e21RUucRfXIBvFJvOucBg3+9Yx8OCFjOampo
 0B1el8kKfpNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,288,1613462400"; 
   d="scan'208";a="470919267"
Received: from otc-wp-03.jf.intel.com ([10.54.39.79])
  by orsmga001.jf.intel.com with ESMTP; 10 May 2021 15:02:05 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
Cc:     "Christoph Hellwig" <hch@infradead.org>,
        Yi Liu <yi.l.liu@intel.com>, Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Dave Jiang <dave.jiang@intel.com>, wangzhou1@hisilicon.com,
        zhangfei.gao@linaro.org, vkoul@kernel.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v4 2/2] iommu/sva: Remove mm parameter from SVA bind API
Date:   Mon, 10 May 2021 06:25:08 -0700
Message-Id: <1620653108-44901-3-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1620653108-44901-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1620653108-44901-1-git-send-email-jacob.jun.pan@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mm parameter in iommu_sva_bind_device() is intended for privileged
process perform bind() on behalf of other processes. This use case has
yet to be materialized, let alone potential security implications of
adding kernel hooks without explicit user consent.
In addition, with the agreement that IOASID allocation shall be subject
cgroup limit. It will be inline with misc cgroup proposal if IOASID
allocation as part of the SVA bind is limited to the current task.

Link: https://lore.kernel.org/linux-iommu/20210303160205.151d114e@jacob-builder/
Link: https://lore.kernel.org/linux-iommu/YFhiMLR35WWMW%2FHu@myrica/
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/dma/idxd/cdev.c                         |  2 +-
 drivers/dma/idxd/init.c                         |  2 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c |  9 +++++----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h     |  5 ++---
 drivers/iommu/intel/svm.c                       | 17 +++++++++++------
 drivers/iommu/iommu-sva-lib.c                   | 11 ++++++-----
 drivers/iommu/iommu-sva-lib.h                   |  2 +-
 drivers/iommu/iommu.c                           | 14 +++++---------
 drivers/misc/uacce/uacce.c                      |  2 +-
 include/linux/intel-iommu.h                     |  3 +--
 include/linux/iommu.h                           |  8 +++-----
 11 files changed, 37 insertions(+), 38 deletions(-)

diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index 04e3813b613c..875864c832fc 100644
--- a/drivers/dma/idxd/cdev.c
+++ b/drivers/dma/idxd/cdev.c
@@ -100,7 +100,7 @@ static int idxd_cdev_open(struct inode *inode, struct file *filp)
 	filp->private_data = ctx;
 
 	if (device_pasid_enabled(idxd)) {
-		sva = iommu_sva_bind_device(dev, current->mm, 0);
+		sva = iommu_sva_bind_device(dev, 0);
 		if (IS_ERR(sva)) {
 			rc = PTR_ERR(sva);
 			dev_err(dev, "pasid allocation failed: %d\n", rc);
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 6f75c29d3616..f7c43d03ad79 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -459,7 +459,7 @@ static int idxd_enable_system_pasid(struct idxd_device *idxd)
 	unsigned int pasid;
 	struct iommu_sva *sva;
 
-	sva = iommu_sva_bind_device(&idxd->pdev->dev, NULL,
+	sva = iommu_sva_bind_device(&idxd->pdev->dev,
 				    IOMMU_SVA_BIND_SUPERVISOR);
 	if (IS_ERR(sva)) {
 		dev_warn(&idxd->pdev->dev,
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 145ceb2fc5da..0c3014e64c77 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -305,10 +305,11 @@ static void arm_smmu_mmu_notifier_put(struct arm_smmu_mmu_notifier *smmu_mn)
 }
 
 static struct iommu_sva *
-__arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm)
+__arm_smmu_sva_bind(struct device *dev)
 {
 	int ret;
 	struct arm_smmu_bond *bond;
+	struct mm_struct *mm = current->mm;
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
 	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
@@ -329,7 +330,7 @@ __arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm)
 		return ERR_PTR(-ENOMEM);
 
 	/* Allocate a PASID for this mm if necessary */
-	ret = iommu_sva_alloc_pasid(mm, 1, (1U << master->ssid_bits) - 1);
+	ret = iommu_sva_alloc_pasid(1, (1U << master->ssid_bits) - 1);
 	if (ret)
 		goto err_free_bond;
 
@@ -354,7 +355,7 @@ __arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm)
 }
 
 struct iommu_sva *
-arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm, unsigned int flags)
+arm_smmu_sva_bind(struct device *dev, unsigned int flags)
 {
 	struct iommu_sva *handle;
 	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
@@ -367,7 +368,7 @@ arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm, unsigned int flags)
 		return ERR_PTR(-EINVAL);
 
 	mutex_lock(&sva_lock);
-	handle = __arm_smmu_sva_bind(dev, mm);
+	handle = __arm_smmu_sva_bind(dev);
 	mutex_unlock(&sva_lock);
 	return handle;
 }
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 3a4f24da59d9..485ead85a841 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -716,8 +716,7 @@ bool arm_smmu_master_sva_supported(struct arm_smmu_master *master);
 bool arm_smmu_master_sva_enabled(struct arm_smmu_master *master);
 int arm_smmu_master_enable_sva(struct arm_smmu_master *master);
 int arm_smmu_master_disable_sva(struct arm_smmu_master *master);
-struct iommu_sva *arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm,
-				    unsigned int flags);
+struct iommu_sva *arm_smmu_sva_bind(struct device *dev, unsigned int flags);
 void arm_smmu_sva_unbind(struct iommu_sva *handle);
 u32 arm_smmu_sva_get_pasid(struct iommu_sva *handle);
 void arm_smmu_sva_notifier_synchronize(void);
@@ -748,7 +747,7 @@ static inline int arm_smmu_master_disable_sva(struct arm_smmu_master *master)
 }
 
 static inline struct iommu_sva *
-arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm, unsigned int flags)
+arm_smmu_sva_bind(struct device *dev, unsigned int flags)
 {
 	return ERR_PTR(-ENODEV);
 }
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 531f03d13bd5..47d748f79460 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -462,11 +462,12 @@ static void load_pasid(struct mm_struct *mm, u32 pasid)
 /* Caller must hold pasid_mutex, mm reference */
 static int
 intel_svm_bind_mm(struct device *dev, unsigned int flags,
-		  struct mm_struct *mm, struct intel_svm_dev **sd)
+		  struct intel_svm_dev **sd)
 {
 	struct intel_iommu *iommu = device_to_iommu(dev, NULL, NULL);
 	struct intel_svm *svm = NULL, *t;
 	struct device_domain_info *info;
+	struct mm_struct *mm = NULL;
 	struct intel_svm_dev *sdev;
 	unsigned long iflags;
 	int pasid_max;
@@ -485,9 +486,13 @@ intel_svm_bind_mm(struct device *dev, unsigned int flags,
 	} else
 		pasid_max = 1 << 20;
 
-	if ((flags & IOMMU_SVA_BIND_SUPERVISOR) && !ecap_srs(iommu->ecap)) {
-		pr_err("Supervisor PASID not supported.\n");
-		return -EINVAL;
+	if (flags & IOMMU_SVA_BIND_SUPERVISOR) {
+		if (!ecap_srs(iommu->ecap)) {
+			pr_err("Supervisor PASID not supported.\n");
+			return -EINVAL;
+		}
+	} else {
+		mm = current->mm;
 	}
 
 	list_for_each_entry(t, &global_svm_list, list) {
@@ -1052,7 +1057,7 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 
 #define to_intel_svm_dev(handle) container_of(handle, struct intel_svm_dev, sva)
 struct iommu_sva *
-intel_svm_bind(struct device *dev, struct mm_struct *mm, unsigned int flags)
+intel_svm_bind(struct device *dev, unsigned int flags)
 {
 	struct iommu_sva *sva = ERR_PTR(-EINVAL);
 	struct intel_svm_dev *sdev = NULL;
@@ -1064,7 +1069,7 @@ intel_svm_bind(struct device *dev, struct mm_struct *mm, unsigned int flags)
 	 * and intel_svm etc.
 	 */
 	mutex_lock(&pasid_mutex);
-	ret = intel_svm_bind_mm(dev, flags, mm, &sdev);
+	ret = intel_svm_bind_mm(dev, flags, &sdev);
 	if (ret)
 		sva = ERR_PTR(ret);
 	else if (sdev)
diff --git a/drivers/iommu/iommu-sva-lib.c b/drivers/iommu/iommu-sva-lib.c
index bd41405d34e9..5f7b486ba5b0 100644
--- a/drivers/iommu/iommu-sva-lib.c
+++ b/drivers/iommu/iommu-sva-lib.c
@@ -12,21 +12,22 @@ static DECLARE_IOASID_SET(iommu_sva_pasid);
 
 /**
  * iommu_sva_alloc_pasid - Allocate a PASID for the mm
- * @mm: the mm
  * @min: minimum PASID value (inclusive)
  * @max: maximum PASID value (inclusive)
  *
- * Try to allocate a PASID for this mm, or take a reference to the existing one
- * provided it fits within the [@min, @max] range. On success the PASID is
- * available in mm->pasid, and must be released with iommu_sva_free_pasid().
+ * Try to allocate a PASID for the current mm, or take a reference to the
+ * existing one provided it fits within the [@min, @max] range. On success
+ * the PASID is available in the current mm->pasid, and must be released with
+ * iommu_sva_free_pasid().
  * @min must be greater than 0, because 0 indicates an unused mm->pasid.
  *
  * Returns 0 on success and < 0 on error.
  */
-int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max)
+int iommu_sva_alloc_pasid(ioasid_t min, ioasid_t max)
 {
 	int ret = 0;
 	ioasid_t pasid;
+	struct mm_struct *mm = current->mm;
 
 	if (min == INVALID_IOASID || max == INVALID_IOASID ||
 	    min == 0 || max < min)
diff --git a/drivers/iommu/iommu-sva-lib.h b/drivers/iommu/iommu-sva-lib.h
index 031155010ca8..43d3b529c215 100644
--- a/drivers/iommu/iommu-sva-lib.h
+++ b/drivers/iommu/iommu-sva-lib.h
@@ -8,7 +8,7 @@
 #include <linux/ioasid.h>
 #include <linux/mm_types.h>
 
-int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max);
+int iommu_sva_alloc_pasid(ioasid_t min, ioasid_t max);
 void iommu_sva_free_pasid(struct mm_struct *mm);
 struct mm_struct *iommu_sva_find(ioasid_t pasid);
 
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 04e7ec640284..4327edb888c6 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2946,15 +2946,14 @@ int iommu_aux_get_pasid(struct iommu_domain *domain, struct device *dev)
 EXPORT_SYMBOL_GPL(iommu_aux_get_pasid);
 
 /**
- * iommu_sva_bind_device() - Bind a process address space to a device
+ * iommu_sva_bind_device() - Bind the current process address space to a device
  * @dev: the device
- * @mm: the mm to bind, caller must hold a reference to it
  * @flags: options for the bind operation defined as IOMMU_SVA_BIND_*
  *
  * Create a bond between device and address space, allowing the device to access
  * the mm using the returned PASID. If a bond already exists between @device and
- * @mm, it is returned and an additional reference is taken. Caller must call
- * iommu_sva_unbind_device() to release each reference.
+ * the current mm, it is returned and an additional reference is taken. Caller
+ * must call iommu_sva_unbind_device() to release each reference.
  *
  * iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA) must be called first, to
  * initialize the required SVA features.
@@ -2962,7 +2961,7 @@ EXPORT_SYMBOL_GPL(iommu_aux_get_pasid);
  * On error, returns an ERR_PTR value.
  */
 struct iommu_sva *
-iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, unsigned int flags)
+iommu_sva_bind_device(struct device *dev, unsigned int flags)
 {
 	struct iommu_group *group;
 	struct iommu_sva *handle = ERR_PTR(-EINVAL);
@@ -2975,9 +2974,6 @@ iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, unsigned int fla
 	if (!group)
 		return ERR_PTR(-ENODEV);
 
-	/* Supervisor SVA does not need the current mm */
-	if ((flags & IOMMU_SVA_BIND_SUPERVISOR) && mm)
-		return ERR_PTR(-EINVAL);
 	/* Ensure device count and domain don't change while we're binding */
 	mutex_lock(&group->mutex);
 
@@ -2990,7 +2986,7 @@ iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, unsigned int fla
 	if (iommu_group_device_count(group) != 1)
 		goto out_unlock;
 
-	handle = ops->sva_bind(dev, mm, flags);
+	handle = ops->sva_bind(dev, flags);
 out_unlock:
 	mutex_unlock(&group->mutex);
 	iommu_group_put(group);
diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
index 1357427d497a..c25ba907fe70 100644
--- a/drivers/misc/uacce/uacce.c
+++ b/drivers/misc/uacce/uacce.c
@@ -99,7 +99,7 @@ static int uacce_bind_queue(struct uacce_device *uacce, struct uacce_queue *q)
 	if (!(uacce->flags & UACCE_DEV_SVA))
 		return 0;
 
-	handle = iommu_sva_bind_device(uacce->parent, current->mm, 0);
+	handle = iommu_sva_bind_device(uacce->parent, 0);
 	if (IS_ERR(handle))
 		return PTR_ERR(handle);
 
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index a93966361754..b1febc05df54 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -763,8 +763,7 @@ extern int intel_svm_finish_prq(struct intel_iommu *iommu);
 int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
 			  struct iommu_gpasid_bind_data *data);
 int intel_svm_unbind_gpasid(struct device *dev, u32 pasid);
-struct iommu_sva *intel_svm_bind(struct device *dev, struct mm_struct *mm,
-				 unsigned int flags);
+struct iommu_sva *intel_svm_bind(struct device *dev, unsigned int flags);
 void intel_svm_unbind(struct iommu_sva *handle);
 u32 intel_svm_get_pasid(struct iommu_sva *handle);
 int intel_svm_page_response(struct device *dev, struct iommu_fault_event *evt,
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index fcc9d36b4b01..9b3ba9ab35dc 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -217,7 +217,7 @@ struct iommu_iotlb_gather {
  * @dev_feat_enabled: check enabled feature
  * @aux_attach/detach_dev: aux-domain specific attach/detach entries.
  * @aux_get_pasid: get the pasid given an aux-domain
- * @sva_bind: Bind process address space to device
+ * @sva_bind: Bind the current process address space to device
  * @sva_unbind: Unbind process address space from device
  * @sva_get_pasid: Get PASID associated to a SVA handle
  * @page_response: handle page request response
@@ -279,8 +279,7 @@ struct iommu_ops {
 	void (*aux_detach_dev)(struct iommu_domain *domain, struct device *dev);
 	int (*aux_get_pasid)(struct iommu_domain *domain, struct device *dev);
 
-	struct iommu_sva *(*sva_bind)(struct device *dev, struct mm_struct *mm,
-				      unsigned int flags);
+	struct iommu_sva *(*sva_bind)(struct device *dev, unsigned int flags);
 	void (*sva_unbind)(struct iommu_sva *handle);
 	u32 (*sva_get_pasid)(struct iommu_sva *handle);
 
@@ -612,7 +611,6 @@ void iommu_aux_detach_device(struct iommu_domain *domain, struct device *dev);
 int iommu_aux_get_pasid(struct iommu_domain *domain, struct device *dev);
 
 struct iommu_sva *iommu_sva_bind_device(struct device *dev,
-					struct mm_struct *mm,
 					unsigned int flags);
 void iommu_sva_unbind_device(struct iommu_sva *handle);
 u32 iommu_sva_get_pasid(struct iommu_sva *handle);
@@ -967,7 +965,7 @@ iommu_aux_get_pasid(struct iommu_domain *domain, struct device *dev)
 }
 
 static inline struct iommu_sva *
-iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, unsigned int flags)
+iommu_sva_bind_device(struct device *dev, unsigned int flags)
 {
 	return NULL;
 }
-- 
2.25.1

