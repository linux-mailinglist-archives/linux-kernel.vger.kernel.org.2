Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF4735FEB7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 02:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbhDOACk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 20:02:40 -0400
Received: from mga01.intel.com ([192.55.52.88]:63049 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230429AbhDOACd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 20:02:33 -0400
IronPort-SDR: /d+sh4qb7bdWu4iye/hGRXFYw2GUQBnlV1UxDfbdoR4u58ej8rY8JFMNtLD6QVaIcRkHN8qXH0
 6i+t6cCHkZ/A==
X-IronPort-AV: E=McAfee;i="6200,9189,9954"; a="215260305"
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; 
   d="scan'208";a="215260305"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2021 17:02:10 -0700
IronPort-SDR: f7FiFk0yD5IXI0t0iOY3dxvX7bZN5VVh0ueuQI8FqA/xdwRryRkB+B113TojbZSSUhDK+UIPn/
 gSBXp1mRvX2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; 
   d="scan'208";a="461415814"
Received: from otc-wp-03.jf.intel.com ([10.54.39.79])
  by orsmga001.jf.intel.com with ESMTP; 14 Apr 2021 17:02:10 -0700
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
Subject: [PATCH v2 2/2] iommu/sva: Remove mm parameter from SVA bind API
Date:   Wed, 14 Apr 2021 08:27:57 -0700
Message-Id: <1618414077-28808-3-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1618414077-28808-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1618414077-28808-1-git-send-email-jacob.jun.pan@linux.intel.com>
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
 drivers/dma/idxd/cdev.c       |  2 +-
 drivers/dma/idxd/init.c       |  2 +-
 drivers/iommu/iommu-sva-lib.c | 11 +++++++----
 drivers/iommu/iommu.c         | 20 +++++++++++++-------
 drivers/misc/uacce/uacce.c    |  2 +-
 include/linux/iommu.h         |  3 +--
 6 files changed, 24 insertions(+), 16 deletions(-)

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
index 82a0985ad6dc..a92fa625f3b5 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -305,7 +305,7 @@ static int idxd_enable_system_pasid(struct idxd_device *idxd)
 
 	flags = IOMMU_SVA_BIND_SUPERVISOR;
 
-	sva = iommu_sva_bind_device(&idxd->pdev->dev, NULL, flags);
+	sva = iommu_sva_bind_device(&idxd->pdev->dev, flags);
 	if (IS_ERR(sva)) {
 		dev_warn(&idxd->pdev->dev,
 			 "iommu sva bind failed: %ld\n", PTR_ERR(sva));
diff --git a/drivers/iommu/iommu-sva-lib.c b/drivers/iommu/iommu-sva-lib.c
index bd41405d34e9..6e3d1a010d47 100644
--- a/drivers/iommu/iommu-sva-lib.c
+++ b/drivers/iommu/iommu-sva-lib.c
@@ -12,13 +12,13 @@ static DECLARE_IOASID_SET(iommu_sva_pasid);
 
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
@@ -28,6 +28,9 @@ int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max)
 	int ret = 0;
 	ioasid_t pasid;
 
+	if (mm != current->mm)
+		return -EINVAL;
+
 	if (min == INVALID_IOASID || max == INVALID_IOASID ||
 	    min == 0 || max < min)
 		return -EINVAL;
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index eefa541d8674..5bbc35c395a6 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -23,6 +23,7 @@
 #include <linux/property.h>
 #include <linux/fsl/mc.h>
 #include <linux/module.h>
+#include <linux/sched/mm.h>
 #include <trace/events/iommu.h>
 
 static struct kset *iommu_group_kset;
@@ -2959,15 +2960,14 @@ int iommu_aux_get_pasid(struct iommu_domain *domain, struct device *dev)
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
@@ -2975,9 +2975,10 @@ EXPORT_SYMBOL_GPL(iommu_aux_get_pasid);
  * On error, returns an ERR_PTR value.
  */
 struct iommu_sva *
-iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, unsigned int flags)
+iommu_sva_bind_device(struct device *dev, unsigned int flags)
 {
 	struct iommu_group *group;
+	struct mm_struct *mm = NULL;
 	struct iommu_sva *handle = ERR_PTR(-EINVAL);
 	const struct iommu_ops *ops = dev->bus->iommu_ops;
 
@@ -2989,8 +2990,11 @@ iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, unsigned int fla
 		return ERR_PTR(-ENODEV);
 
 	/* Supervisor SVA does not need the current mm */
-	if ((flags & IOMMU_SVA_BIND_SUPERVISOR) && mm)
-		return ERR_PTR(-EINVAL);
+	if (!(flags & IOMMU_SVA_BIND_SUPERVISOR)) {
+		mm = get_task_mm(current);
+		if (!mm)
+			return ERR_PTR(-EINVAL);
+	}
 	/* Ensure device count and domain don't change while we're binding */
 	mutex_lock(&group->mutex);
 
@@ -3004,6 +3008,8 @@ iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, unsigned int fla
 		goto out_unlock;
 
 	handle = ops->sva_bind(dev, mm, flags);
+	if (mm)
+		mmput(mm);
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
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index ba81cec0b086..4e846950a6b9 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -652,7 +652,6 @@ void iommu_aux_detach_device(struct iommu_domain *domain, struct device *dev);
 int iommu_aux_get_pasid(struct iommu_domain *domain, struct device *dev);
 
 struct iommu_sva *iommu_sva_bind_device(struct device *dev,
-					struct mm_struct *mm,
 					unsigned int flags);
 void iommu_sva_unbind_device(struct iommu_sva *handle);
 u32 iommu_sva_get_pasid(struct iommu_sva *handle);
@@ -1028,7 +1027,7 @@ iommu_aux_get_pasid(struct iommu_domain *domain, struct device *dev)
 }
 
 static inline struct iommu_sva *
-iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, unsigned int flags)
+iommu_sva_bind_device(struct device *dev, unsigned int flags)
 {
 	return NULL;
 }
-- 
2.25.1

