Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B247C359194
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 03:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233212AbhDIBnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 21:43:11 -0400
Received: from mga11.intel.com ([192.55.52.93]:10333 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232426AbhDIBnJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 21:43:09 -0400
IronPort-SDR: VLV/D6P94gFEZ4831zhyGOAgyQir5wbQfvaSkODAE7eCsKyTItRLZR7mJZTw49RO8Z1aMm7srJ
 I2BRn7G5YDKw==
X-IronPort-AV: E=McAfee;i="6000,8403,9948"; a="190468008"
X-IronPort-AV: E=Sophos;i="5.82,208,1613462400"; 
   d="scan'208";a="190468008"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2021 18:42:57 -0700
IronPort-SDR: 3+z3CksxB4cyIymg39minkYhDkpjm61WBz4ZKbimYeM8gVxcggRBnYWK4+PdsDJepT64aVFpZl
 Y0QtnGgLYKkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,208,1613462400"; 
   d="scan'208";a="459050870"
Received: from otc-wp-03.jf.intel.com ([10.54.39.79])
  by orsmga001.jf.intel.com with ESMTP; 08 Apr 2021 18:42:56 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
Cc:     Yi Liu <yi.l.liu@intel.com>, Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Dave Jiang <dave.jiang@intel.com>, wangzhou1@hisilicon.com,
        zhangfei.gao@linaro.org, vkoul@kernel.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 1/2] iommu/sva: Tighten SVA bind API with explicit flags
Date:   Thu,  8 Apr 2021 10:08:55 -0700
Message-Id: <1617901736-24788-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The void* drvdata parameter isn't really used in iommu_sva_bind_device()
API, the current IDXD code "borrows" the drvdata for a VT-d private flag
for supervisor SVA usage.

Supervisor/Privileged mode request is a generic feature. It should be
promoted from the VT-d vendor driver to the generic code.

This patch replaces void* drvdata with a unsigned int flags parameter
and adjusts callers accordingly.

Link: https://lore.kernel.org/linux-iommu/YFhiMLR35WWMW%2FHu@myrica/
Suggested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/dma/idxd/cdev.c                         |  2 +-
 drivers/dma/idxd/init.c                         |  6 +++---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c |  2 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h     |  4 ++--
 drivers/iommu/intel/Kconfig                     |  1 +
 drivers/iommu/intel/svm.c                       | 18 ++++++------------
 drivers/iommu/iommu.c                           |  9 ++++++---
 drivers/misc/uacce/uacce.c                      |  2 +-
 include/linux/intel-iommu.h                     |  2 +-
 include/linux/intel-svm.h                       | 17 ++---------------
 include/linux/iommu.h                           | 19 ++++++++++++++++---
 11 files changed, 40 insertions(+), 42 deletions(-)

diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index 0db9b82..21ec82b 100644
--- a/drivers/dma/idxd/cdev.c
+++ b/drivers/dma/idxd/cdev.c
@@ -103,7 +103,7 @@ static int idxd_cdev_open(struct inode *inode, struct file *filp)
 	filp->private_data = ctx;
 
 	if (device_pasid_enabled(idxd)) {
-		sva = iommu_sva_bind_device(dev, current->mm, NULL);
+		sva = iommu_sva_bind_device(dev, current->mm, 0);
 		if (IS_ERR(sva)) {
 			rc = PTR_ERR(sva);
 			dev_err(dev, "pasid allocation failed: %d\n", rc);
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 085a0c3..cdc85f1 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -300,13 +300,13 @@ static struct idxd_device *idxd_alloc(struct pci_dev *pdev)
 
 static int idxd_enable_system_pasid(struct idxd_device *idxd)
 {
-	int flags;
+	unsigned int flags;
 	unsigned int pasid;
 	struct iommu_sva *sva;
 
-	flags = SVM_FLAG_SUPERVISOR_MODE;
+	flags = IOMMU_SVA_BIND_SUPERVISOR;
 
-	sva = iommu_sva_bind_device(&idxd->pdev->dev, NULL, &flags);
+	sva = iommu_sva_bind_device(&idxd->pdev->dev, NULL, flags);
 	if (IS_ERR(sva)) {
 		dev_warn(&idxd->pdev->dev,
 			 "iommu sva bind failed: %ld\n", PTR_ERR(sva));
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index bb251ca..23e287e 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -354,7 +354,7 @@ __arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm)
 }
 
 struct iommu_sva *
-arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm, void *drvdata)
+arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm, unsigned int flags)
 {
 	struct iommu_sva *handle;
 	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index f985817..b971d4d 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -711,7 +711,7 @@ bool arm_smmu_master_sva_enabled(struct arm_smmu_master *master);
 int arm_smmu_master_enable_sva(struct arm_smmu_master *master);
 int arm_smmu_master_disable_sva(struct arm_smmu_master *master);
 struct iommu_sva *arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm,
-				    void *drvdata);
+				    unsigned int flags);
 void arm_smmu_sva_unbind(struct iommu_sva *handle);
 u32 arm_smmu_sva_get_pasid(struct iommu_sva *handle);
 void arm_smmu_sva_notifier_synchronize(void);
@@ -742,7 +742,7 @@ static inline int arm_smmu_master_disable_sva(struct arm_smmu_master *master)
 }
 
 static inline struct iommu_sva *
-arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm, void *drvdata)
+arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm, unsigned int flags)
 {
 	return ERR_PTR(-ENODEV);
 }
diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
index 28a3d15..5415052 100644
--- a/drivers/iommu/intel/Kconfig
+++ b/drivers/iommu/intel/Kconfig
@@ -41,6 +41,7 @@ config INTEL_IOMMU_SVM
 	select PCI_PRI
 	select MMU_NOTIFIER
 	select IOASID
+	select IOMMU_SVA_LIB
 	help
 	  Shared Virtual Memory (SVM) provides a facility for devices
 	  to access DMA resources through process address space by
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 574a7e6..4b5f8b0 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -486,12 +486,9 @@ intel_svm_bind_mm(struct device *dev, unsigned int flags,
 	} else
 		pasid_max = 1 << 20;
 
-	/* Bind supervisor PASID shuld have mm = NULL */
-	if (flags & SVM_FLAG_SUPERVISOR_MODE) {
-		if (!ecap_srs(iommu->ecap) || mm) {
-			pr_err("Supervisor PASID with user provided mm.\n");
-			return -EINVAL;
-		}
+	if ((flags & IOMMU_SVA_BIND_SUPERVISOR) && !ecap_srs(iommu->ecap)) {
+		pr_err("Supervisor PASID not supported.\n");
+		return -EINVAL;
 	}
 
 	if (!(flags & SVM_FLAG_PRIVATE_PASID)) {
@@ -593,7 +590,7 @@ intel_svm_bind_mm(struct device *dev, unsigned int flags,
 		ret = intel_pasid_setup_first_level(iommu, dev,
 				mm ? mm->pgd : init_mm.pgd,
 				svm->pasid, FLPT_DEFAULT_DID,
-				(mm ? 0 : PASID_FLAG_SUPERVISOR_MODE) |
+				(mm ? 0 : IOMMU_SVA_BIND_SUPERVISOR) |
 				(cpu_feature_enabled(X86_FEATURE_LA57) ?
 				 PASID_FLAG_FL5LP : 0));
 		spin_unlock_irqrestore(&iommu->lock, iflags);
@@ -620,7 +617,7 @@ intel_svm_bind_mm(struct device *dev, unsigned int flags,
 		ret = intel_pasid_setup_first_level(iommu, dev,
 						mm ? mm->pgd : init_mm.pgd,
 						svm->pasid, FLPT_DEFAULT_DID,
-						(mm ? 0 : PASID_FLAG_SUPERVISOR_MODE) |
+						(mm ? 0 : IOMMU_SVA_BIND_SUPERVISOR) |
 						(cpu_feature_enabled(X86_FEATURE_LA57) ?
 						PASID_FLAG_FL5LP : 0));
 		spin_unlock_irqrestore(&iommu->lock, iflags);
@@ -1059,11 +1056,10 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 
 #define to_intel_svm_dev(handle) container_of(handle, struct intel_svm_dev, sva)
 struct iommu_sva *
-intel_svm_bind(struct device *dev, struct mm_struct *mm, void *drvdata)
+intel_svm_bind(struct device *dev, struct mm_struct *mm, unsigned int flags)
 {
 	struct iommu_sva *sva = ERR_PTR(-EINVAL);
 	struct intel_svm_dev *sdev = NULL;
-	unsigned int flags = 0;
 	int ret;
 
 	/*
@@ -1071,8 +1067,6 @@ intel_svm_bind(struct device *dev, struct mm_struct *mm, void *drvdata)
 	 * It will require shared SVM data structures, i.e. combine io_mm
 	 * and intel_svm etc.
 	 */
-	if (drvdata)
-		flags = *(unsigned int *)drvdata;
 	mutex_lock(&pasid_mutex);
 	ret = intel_svm_bind_mm(dev, flags, NULL, mm, &sdev);
 	if (ret)
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index d0b0a15..bf0a20f 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2962,6 +2962,7 @@ EXPORT_SYMBOL_GPL(iommu_aux_get_pasid);
  * iommu_sva_bind_device() - Bind a process address space to a device
  * @dev: the device
  * @mm: the mm to bind, caller must hold a reference to it
+ * @flags: options for the bind operation
  *
  * Create a bond between device and address space, allowing the device to access
  * the mm using the returned PASID. If a bond already exists between @device and
@@ -2974,7 +2975,7 @@ EXPORT_SYMBOL_GPL(iommu_aux_get_pasid);
  * On error, returns an ERR_PTR value.
  */
 struct iommu_sva *
-iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, void *drvdata)
+iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, unsigned int flags)
 {
 	struct iommu_group *group;
 	struct iommu_sva *handle = ERR_PTR(-EINVAL);
@@ -2987,6 +2988,9 @@ iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, void *drvdata)
 	if (!group)
 		return ERR_PTR(-ENODEV);
 
+	/* Supervisor SVA does not need the current mm */
+	if ((flags & IOMMU_SVA_BIND_SUPERVISOR) && mm)
+		return ERR_PTR(-EINVAL);
 	/* Ensure device count and domain don't change while we're binding */
 	mutex_lock(&group->mutex);
 
@@ -2999,8 +3003,7 @@ iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, void *drvdata)
 	if (iommu_group_device_count(group) != 1)
 		goto out_unlock;
 
-	handle = ops->sva_bind(dev, mm, drvdata);
-
+	handle = ops->sva_bind(dev, mm, flags);
 out_unlock:
 	mutex_unlock(&group->mutex);
 	iommu_group_put(group);
diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
index d07af4e..27e0e04 100644
--- a/drivers/misc/uacce/uacce.c
+++ b/drivers/misc/uacce/uacce.c
@@ -99,7 +99,7 @@ static int uacce_bind_queue(struct uacce_device *uacce, struct uacce_queue *q)
 	if (!(uacce->flags & UACCE_DEV_SVA))
 		return 0;
 
-	handle = iommu_sva_bind_device(uacce->parent, current->mm, NULL);
+	handle = iommu_sva_bind_device(uacce->parent, current->mm, 0);
 	if (IS_ERR(handle))
 		return PTR_ERR(handle);
 
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 1bc46b8..cdff752 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -757,7 +757,7 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
 			  struct iommu_gpasid_bind_data *data);
 int intel_svm_unbind_gpasid(struct device *dev, u32 pasid);
 struct iommu_sva *intel_svm_bind(struct device *dev, struct mm_struct *mm,
-				 void *drvdata);
+				 unsigned int flags);
 void intel_svm_unbind(struct iommu_sva *handle);
 u32 intel_svm_get_pasid(struct iommu_sva *handle);
 int intel_svm_page_response(struct device *dev, struct iommu_fault_event *evt,
diff --git a/include/linux/intel-svm.h b/include/linux/intel-svm.h
index 39d368a..ef6b753 100644
--- a/include/linux/intel-svm.h
+++ b/include/linux/intel-svm.h
@@ -30,30 +30,17 @@ struct svm_dev_ops {
  * if there is no other way to do so. It should be used sparingly, if at all.
  */
 #define SVM_FLAG_PRIVATE_PASID		(1<<0)
-
-/*
- * The SVM_FLAG_SUPERVISOR_MODE flag requests a PASID which can be used only
- * for access to kernel addresses. No IOTLB flushes are automatically done
- * for kernel mappings; it is valid only for access to the kernel's static
- * 1:1 mapping of physical memory — not to vmalloc or even module mappings.
- * A future API addition may permit the use of such ranges, by means of an
- * explicit IOTLB flush call (akin to the DMA API's unmap method).
- *
- * It is unlikely that we will ever hook into flush_tlb_kernel_range() to
- * do such IOTLB flushes automatically.
- */
-#define SVM_FLAG_SUPERVISOR_MODE	(1<<1)
 /*
  * The SVM_FLAG_GUEST_MODE flag is used when a PASID bind is for guest
  * processes. Compared to the host bind, the primary differences are:
  * 1. mm life cycle management
  * 2. fault reporting
  */
-#define SVM_FLAG_GUEST_MODE		(1<<2)
+#define SVM_FLAG_GUEST_MODE		(1<<1)
 /*
  * The SVM_FLAG_GUEST_PASID flag is used when a guest has its own PASID space,
  * which requires guest and host PASID translation at both directions.
  */
-#define SVM_FLAG_GUEST_PASID		(1<<3)
+#define SVM_FLAG_GUEST_PASID		(1<<2)
 
 #endif /* __INTEL_SVM_H__ */
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 5e7fe51..a3fbaa2 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -166,6 +166,19 @@ enum iommu_dev_features {
 
 #ifdef CONFIG_IOMMU_API
 
+/*
+ * The IOMMU_SVA_BIND_SUPERVISOR flag requests a PASID which can be used only
+ * for access to kernel addresses. No IOTLB flushes are automatically done
+ * for kernel mappings; it is valid only for access to the kernel's static
+ * 1:1 mapping of physical memory — not to vmalloc or even module mappings.
+ * A future API addition may permit the use of such ranges, by means of an
+ * explicit IOTLB flush call (akin to the DMA API's unmap method).
+ *
+ * It is unlikely that we will ever hook into flush_tlb_kernel_range() to
+ * do such IOTLB flushes automatically.
+ */
+#define IOMMU_SVA_BIND_SUPERVISOR       BIT(0)
+
 /**
  * struct iommu_iotlb_gather - Range information for a pending IOTLB flush
  *
@@ -287,7 +300,7 @@ struct iommu_ops {
 	int (*aux_get_pasid)(struct iommu_domain *domain, struct device *dev);
 
 	struct iommu_sva *(*sva_bind)(struct device *dev, struct mm_struct *mm,
-				      void *drvdata);
+				      unsigned int flags);
 	void (*sva_unbind)(struct iommu_sva *handle);
 	u32 (*sva_get_pasid)(struct iommu_sva *handle);
 
@@ -640,7 +653,7 @@ int iommu_aux_get_pasid(struct iommu_domain *domain, struct device *dev);
 
 struct iommu_sva *iommu_sva_bind_device(struct device *dev,
 					struct mm_struct *mm,
-					void *drvdata);
+					unsigned int flags);
 void iommu_sva_unbind_device(struct iommu_sva *handle);
 u32 iommu_sva_get_pasid(struct iommu_sva *handle);
 
@@ -1015,7 +1028,7 @@ iommu_aux_get_pasid(struct iommu_domain *domain, struct device *dev)
 }
 
 static inline struct iommu_sva *
-iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, void *drvdata)
+iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, unsigned int flags)
 {
 	return NULL;
 }
-- 
2.7.4

