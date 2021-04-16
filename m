Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80D88362A2A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 23:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344281AbhDPVWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 17:22:23 -0400
Received: from mga06.intel.com ([134.134.136.31]:46717 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344257AbhDPVV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 17:21:56 -0400
IronPort-SDR: /7mtY/WEAx+PV3X0u2Ez6UmKNhZUKV+6Ys/Mi1ZZREc4cWdHtmGVRns413wYuJKRkYJeE3Cutu
 kAsf38FShQtQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9956"; a="256427950"
X-IronPort-AV: E=Sophos;i="5.82,228,1613462400"; 
   d="scan'208";a="256427950"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 14:19:35 -0700
IronPort-SDR: y51IxGM5PKWIdM6DMCfYKDV1MQes4pzEpu4+fSBftExL3uABjdXm2my8CxtC9plVQnarGh9qut
 VuHDzJGKo+3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,228,1613462400"; 
   d="scan'208";a="522825414"
Received: from otc-wp-03.jf.intel.com ([10.54.39.79])
  by fmsmga001.fm.intel.com with ESMTP; 16 Apr 2021 14:19:35 -0700
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
Subject: [PATCH v3 2/2] iommu/sva: Remove mm parameter from SVA bind API
Date:   Fri, 16 Apr 2021 05:45:14 -0700
Message-Id: <1618577114-30156-3-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1618577114-30156-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1618577114-30156-1-git-send-email-jacob.jun.pan@linux.intel.com>
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
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h     |  3 +--
 drivers/iommu/intel/svm.c                       | 17 +++++++++++------
 drivers/iommu/iommu-sva-lib.c                   | 11 ++++++-----
 drivers/iommu/iommu-sva-lib.h                   |  2 +-
 drivers/iommu/iommu.c                           | 14 +++++---------
 drivers/misc/uacce/uacce.c                      |  2 +-
 include/linux/intel-iommu.h                     |  3 +--
 include/linux/iommu.h                           |  8 +++-----
 11 files changed, 36 insertions(+), 37 deletions(-)

diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index 21ec82bc47b6..8c3347c8930c 100644
--- a/drivers/dma/idxd/cdev.c
+++ b/drivers/dma/idxd/cdev.c
@@ -103,7 +103,7 @@ static int idxd_cdev_open(struct inode *inode, struct file *filp)
 	filp->private_data = ctx;
 
 	if (device_pasid_enabled(idxd)) {
-		sva = iommu_sva_bind_device(dev, current->mm, 0);
+		sva = iommu_sva_bind_device(dev, 0);
 		if (IS_ERR(sva)) {
 			rc = PTR_ERR(sva);
 			dev_err(dev, "pasid allocation failed: %d\n", rc);
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 7b2290b19787..f64a19b5e513 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -302,7 +302,7 @@ static int idxd_enable_system_pasid(struct idxd_device *idxd)
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
index b971d4dcf090..306fa59a9db5 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -710,8 +710,7 @@ bool arm_smmu_master_sva_supported(struct arm_smmu_master *master);
 bool arm_smmu_master_sva_enabled(struct arm_smmu_master *master);
 int arm_smmu_master_enable_sva(struct arm_smmu_master *master);
 int arm_smmu_master_disable_sva(struct arm_smmu_master *master);
-struct iommu_sva *arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm,
-				    unsigned int flags);
+struct iommu_sva *arm_smmu_sva_bind(struct device *dev, unsigned int flags);
 void arm_smmu_sva_unbind(struct iommu_sva *handle);
 u32 arm_smmu_sva_get_pasid(struct iommu_sva *handle);
 void arm_smmu_sva_notifier_synchronize(void);
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index d4840821f7b5..fa1aa482063e 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -463,10 +463,11 @@ static void load_pasid(struct mm_struct *mm, u32 pasid)
 static int
 intel_svm_bind_mm(struct device *dev, unsigned int flags,
 		  struct svm_dev_ops *ops,
-		  struct mm_struct *mm, struct intel_svm_dev **sd)
+		  struct intel_svm_dev **sd)
 {
 	struct intel_iommu *iommu = device_to_iommu(dev, NULL, NULL);
 	struct device_domain_info *info;
+	struct mm_struct *mm = NULL;
 	struct intel_svm_dev *sdev;
 	struct intel_svm *svm = NULL;
 	unsigned long iflags;
@@ -486,9 +487,13 @@ intel_svm_bind_mm(struct device *dev, unsigned int flags,
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
 
 	if (!(flags & SVM_FLAG_PRIVATE_PASID)) {
@@ -1056,7 +1061,7 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 
 #define to_intel_svm_dev(handle) container_of(handle, struct intel_svm_dev, sva)
 struct iommu_sva *
-intel_svm_bind(struct device *dev, struct mm_struct *mm, unsigned int flags)
+intel_svm_bind(struct device *dev, unsigned int flags)
 {
 	struct iommu_sva *sva = ERR_PTR(-EINVAL);
 	struct intel_svm_dev *sdev = NULL;
@@ -1068,7 +1073,7 @@ intel_svm_bind(struct device *dev, struct mm_struct *mm, unsigned int flags)
 	 * and intel_svm etc.
 	 */
 	mutex_lock(&pasid_mutex);
-	ret = intel_svm_bind_mm(dev, flags, NULL, mm, &sdev);
+	ret = intel_svm_bind_mm(dev, flags, NULL, &sdev);
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
index b40990aef3fd..17276f5b2903 100644
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
index eefa541d8674..92e9dff98c88 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2959,15 +2959,14 @@ int iommu_aux_get_pasid(struct iommu_domain *domain, struct device *dev)
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
@@ -2975,7 +2974,7 @@ EXPORT_SYMBOL_GPL(iommu_aux_get_pasid);
  * On error, returns an ERR_PTR value.
  */
 struct iommu_sva *
-iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, unsigned int flags)
+iommu_sva_bind_device(struct device *dev, unsigned int flags)
 {
 	struct iommu_group *group;
 	struct iommu_sva *handle = ERR_PTR(-EINVAL);
@@ -2988,9 +2987,6 @@ iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, unsigned int fla
 	if (!group)
 		return ERR_PTR(-ENODEV);
 
-	/* Supervisor SVA does not need the current mm */
-	if ((flags & IOMMU_SVA_BIND_SUPERVISOR) && mm)
-		return ERR_PTR(-EINVAL);
 	/* Ensure device count and domain don't change while we're binding */
 	mutex_lock(&group->mutex);
 
@@ -3003,7 +2999,7 @@ iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, unsigned int fla
 	if (iommu_group_device_count(group) != 1)
 		goto out_unlock;
 
-	handle = ops->sva_bind(dev, mm, flags);
+	handle = ops->sva_bind(dev, flags);
 out_unlock:
 	mutex_unlock(&group->mutex);
 	iommu_group_put(group);
diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
index 27e0e04dfcab..da4401a3d8f5 100644
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
index cdff752aacdd..2de34d0baf0a 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -756,8 +756,7 @@ extern int intel_svm_finish_prq(struct intel_iommu *iommu);
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
index ba81cec0b086..5e4cb0c9ebc0 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -231,7 +231,7 @@ struct iommu_iotlb_gather {
  * @dev_feat_enabled: check enabled feature
  * @aux_attach/detach_dev: aux-domain specific attach/detach entries.
  * @aux_get_pasid: get the pasid given an aux-domain
- * @sva_bind: Bind process address space to device
+ * @sva_bind: Bind the current process address space to device
  * @sva_unbind: Unbind process address space from device
  * @sva_get_pasid: Get PASID associated to a SVA handle
  * @page_response: handle page request response
@@ -299,8 +299,7 @@ struct iommu_ops {
 	void (*aux_detach_dev)(struct iommu_domain *domain, struct device *dev);
 	int (*aux_get_pasid)(struct iommu_domain *domain, struct device *dev);
 
-	struct iommu_sva *(*sva_bind)(struct device *dev, struct mm_struct *mm,
-				      unsigned int flags);
+	struct iommu_sva *(*sva_bind)(struct device *dev, unsigned int flags);
 	void (*sva_unbind)(struct iommu_sva *handle);
 	u32 (*sva_get_pasid)(struct iommu_sva *handle);
 
@@ -652,7 +651,6 @@ void iommu_aux_detach_device(struct iommu_domain *domain, struct device *dev);
 int iommu_aux_get_pasid(struct iommu_domain *domain, struct device *dev);
 
 struct iommu_sva *iommu_sva_bind_device(struct device *dev,
-					struct mm_struct *mm,
 					unsigned int flags);
 void iommu_sva_unbind_device(struct iommu_sva *handle);
 u32 iommu_sva_get_pasid(struct iommu_sva *handle);
@@ -1028,7 +1026,7 @@ iommu_aux_get_pasid(struct iommu_domain *domain, struct device *dev)
 }
 
 static inline struct iommu_sva *
-iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, unsigned int flags)
+iommu_sva_bind_device(struct device *dev, unsigned int flags)
 {
 	return NULL;
 }
-- 
2.25.1

