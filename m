Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F642389BB1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 05:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbhETDSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 23:18:14 -0400
Received: from mga05.intel.com ([192.55.52.43]:58818 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230192AbhETDSJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 23:18:09 -0400
IronPort-SDR: rVn47n+5W5l2Iv32e5v69hV7rAB0BMsC4fx7cCMLjJ06JUFJcws9X0S6uWnq957oKGinp8P/KJ
 q3nmer/R7qqA==
X-IronPort-AV: E=McAfee;i="6200,9189,9989"; a="286659608"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="286659608"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 20:16:49 -0700
IronPort-SDR: 0l7/QBZkTEagqaahg/9G5jtqfEyZnRgeufwU3C5+ciValW+iNcvBAwnnOdpumenkrnqgchJl+g
 FuR2IejGLNpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="395527185"
Received: from allen-box.sh.intel.com ([10.239.159.128])
  by orsmga006.jf.intel.com with ESMTP; 19 May 2021 20:16:46 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     ashok.raj@intel.com, kevin.tian@intel.com, jacob.jun.pan@intel.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 02/11] iommu/vt-d: Use iommu_sva_alloc(free)_pasid() helpers
Date:   Thu, 20 May 2021 11:15:22 +0800
Message-Id: <20210520031531.712333-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210520031531.712333-1-baolu.lu@linux.intel.com>
References: <20210520031531.712333-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Align the pasid alloc/free code with the generic helpers defined in the
iommu core. This also refactored the SVA binding code to improve the
readability.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/intel-iommu.h |   1 -
 drivers/iommu/intel/iommu.c |   3 +
 drivers/iommu/intel/svm.c   | 278 +++++++++++++++---------------------
 drivers/iommu/intel/Kconfig |   1 +
 4 files changed, 120 insertions(+), 163 deletions(-)

diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 03faf20a6817..4e8bb186daa7 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -791,7 +791,6 @@ struct intel_svm {
 	u32 pasid;
 	int gpasid; /* In case that guest PASID is different from host PASID */
 	struct list_head devs;
-	struct list_head list;
 };
 #else
 static inline void intel_svm_check(struct intel_iommu *iommu) {}
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index d760f587c229..fa6223bf1e7b 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -5411,6 +5411,9 @@ intel_iommu_dev_enable_feat(struct device *dev, enum iommu_dev_features feat)
 		if (!info)
 			return -EINVAL;
 
+		if (intel_iommu_enable_pasid(info->iommu, dev))
+			return -ENODEV;
+
 		if (!info->pasid_enabled || !info->pri_enabled || !info->ats_enabled)
 			return -EINVAL;
 
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 82b0627ad7e7..da4310686ed3 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -23,9 +23,11 @@
 #include <asm/fpu/api.h>
 
 #include "pasid.h"
+#include "../iommu-sva-lib.h"
 
 static irqreturn_t prq_event_thread(int irq, void *d);
 static void intel_svm_drain_prq(struct device *dev, u32 pasid);
+#define to_intel_svm_dev(handle) container_of(handle, struct intel_svm_dev, sva)
 
 #define PRQ_ORDER 0
 
@@ -222,7 +224,6 @@ static const struct mmu_notifier_ops intel_mmuops = {
 };
 
 static DEFINE_MUTEX(pasid_mutex);
-static LIST_HEAD(global_svm_list);
 
 #define for_each_svm_dev(sdev, svm, d)			\
 	list_for_each_entry((sdev), &(svm)->devs, list)	\
@@ -477,79 +478,80 @@ static void load_pasid(struct mm_struct *mm, u32 pasid)
 	mutex_unlock(&mm->context.lock);
 }
 
-/* Caller must hold pasid_mutex, mm reference */
-static int
-intel_svm_bind_mm(struct device *dev, unsigned int flags,
-		  struct mm_struct *mm, struct intel_svm_dev **sd)
+static int intel_svm_alloc_pasid(struct device *dev, struct mm_struct *mm,
+				 unsigned int flags)
 {
-	struct intel_iommu *iommu = device_to_iommu(dev, NULL, NULL);
-	struct intel_svm *svm = NULL, *t;
-	struct device_domain_info *info;
-	struct intel_svm_dev *sdev;
-	unsigned long iflags;
-	int pasid_max;
-	int ret;
+	ioasid_t max_pasid = dev_is_pci(dev) ?
+			pci_max_pasids(to_pci_dev(dev)) : intel_pasid_max_id;
 
-	if (!iommu || dmar_disabled)
-		return -EINVAL;
+	return iommu_sva_alloc_pasid(mm, PASID_MIN, max_pasid - 1);
+}
 
-	if (!intel_svm_capable(iommu))
-		return -ENOTSUPP;
+static void intel_svm_free_pasid(struct mm_struct *mm)
+{
+	iommu_sva_free_pasid(mm);
+}
 
-	if (dev_is_pci(dev)) {
-		pasid_max = pci_max_pasids(to_pci_dev(dev));
-		if (pasid_max < 0)
-			return -EINVAL;
-	} else
-		pasid_max = 1 << 20;
+static struct iommu_sva *intel_svm_bind_mm(struct intel_iommu *iommu,
+					   struct device *dev,
+					   struct mm_struct *mm,
+					   unsigned int flags)
+{
+	struct device_domain_info *info = get_domain_info(dev);
+	unsigned long iflags, sflags;
+	struct intel_svm_dev *sdev;
+	struct intel_svm *svm;
+	int ret = 0;
 
-	/* Bind supervisor PASID shuld have mm = NULL */
-	if (flags & SVM_FLAG_SUPERVISOR_MODE) {
-		if (!ecap_srs(iommu->ecap) || mm) {
-			pr_err("Supervisor PASID with user provided mm.\n");
-			return -EINVAL;
-		}
-	}
+	svm = pasid_private_find(mm->pasid);
+	if (!svm) {
+		svm = kzalloc(sizeof(*svm), GFP_KERNEL);
+		if (!svm)
+			return ERR_PTR(-ENOMEM);
 
-	list_for_each_entry(t, &global_svm_list, list) {
-		if (t->mm != mm)
-			continue;
+		svm->pasid = mm->pasid;
+		svm->mm = mm;
+		svm->flags = flags;
+		INIT_LIST_HEAD_RCU(&svm->devs);
 
-		svm = t;
-		if (svm->pasid >= pasid_max) {
-			dev_warn(dev,
-				 "Limited PASID width. Cannot use existing PASID %d\n",
-				 svm->pasid);
-			ret = -ENOSPC;
-			goto out;
+		if (!(flags & SVM_FLAG_SUPERVISOR_MODE)) {
+			svm->notifier.ops = &intel_mmuops;
+			ret = mmu_notifier_register(&svm->notifier, mm);
+			if (ret) {
+				kfree(svm);
+				return ERR_PTR(ret);
+			}
 		}
 
-		/* Find the matching device in svm list */
-		for_each_svm_dev(sdev, svm, dev) {
-			sdev->users++;
-			goto success;
+		ret = pasid_private_add(svm->pasid, svm);
+		if (ret) {
+			if (svm->notifier.ops)
+				mmu_notifier_unregister(&svm->notifier, mm);
+			kfree(svm);
+			return ERR_PTR(ret);
 		}
+	}
 
-		break;
+	/* Find the matching device in svm list */
+	for_each_svm_dev(sdev, svm, dev) {
+		sdev->users++;
+		goto success;
 	}
 
 	sdev = kzalloc(sizeof(*sdev), GFP_KERNEL);
 	if (!sdev) {
 		ret = -ENOMEM;
-		goto out;
+		goto free_svm;
 	}
+
 	sdev->dev = dev;
 	sdev->iommu = iommu;
-
-	ret = intel_iommu_enable_pasid(iommu, dev);
-	if (ret) {
-		kfree(sdev);
-		goto out;
-	}
-
-	info = get_domain_info(dev);
 	sdev->did = FLPT_DEFAULT_DID;
 	sdev->sid = PCI_DEVID(info->bus, info->devfn);
+	sdev->users = 1;
+	sdev->pasid = svm->pasid;
+	sdev->sva.dev = dev;
+	init_rcu_head(&sdev->rcu);
 	if (info->ats_enabled) {
 		sdev->dev_iotlb = 1;
 		sdev->qdep = info->ats_qdep;
@@ -557,96 +559,37 @@ intel_svm_bind_mm(struct device *dev, unsigned int flags,
 			sdev->qdep = 0;
 	}
 
-	/* Finish the setup now we know we're keeping it */
-	sdev->users = 1;
-	init_rcu_head(&sdev->rcu);
-
-	if (!svm) {
-		svm = kzalloc(sizeof(*svm), GFP_KERNEL);
-		if (!svm) {
-			ret = -ENOMEM;
-			goto sdev_err;
-		}
-
-		if (pasid_max > intel_pasid_max_id)
-			pasid_max = intel_pasid_max_id;
-
-		/* Do not use PASID 0, reserved for RID to PASID */
-		svm->pasid = ioasid_alloc(NULL, PASID_MIN,
-					  pasid_max - 1, NULL);
-		if (svm->pasid == INVALID_IOASID) {
-			ret = -ENOSPC;
-			goto svm_err;
-		}
-
-		ret = pasid_private_add(svm->pasid, svm);
-		if (ret)
-			goto pasid_err;
+	/* Setup the pasid table: */
+	sflags = (flags & SVM_FLAG_SUPERVISOR_MODE) ?
+			PASID_FLAG_SUPERVISOR_MODE : 0;
+	sflags |= cpu_feature_enabled(X86_FEATURE_LA57) ? PASID_FLAG_FL5LP : 0;
+	spin_lock_irqsave(&iommu->lock, iflags);
+	ret = intel_pasid_setup_first_level(iommu, dev, mm->pgd, mm->pasid,
+					    FLPT_DEFAULT_DID, sflags);
+	spin_unlock_irqrestore(&iommu->lock, iflags);
 
-		svm->notifier.ops = &intel_mmuops;
-		svm->mm = mm;
-		svm->flags = flags;
-		INIT_LIST_HEAD_RCU(&svm->devs);
-		INIT_LIST_HEAD(&svm->list);
-		ret = -ENOMEM;
-		if (mm) {
-			ret = mmu_notifier_register(&svm->notifier, mm);
-			if (ret)
-				goto priv_err;
-		}
+	if (ret)
+		goto free_sdev;
 
-		spin_lock_irqsave(&iommu->lock, iflags);
-		ret = intel_pasid_setup_first_level(iommu, dev,
-				mm ? mm->pgd : init_mm.pgd,
-				svm->pasid, FLPT_DEFAULT_DID,
-				(mm ? 0 : PASID_FLAG_SUPERVISOR_MODE) |
-				(cpu_feature_enabled(X86_FEATURE_LA57) ?
-				 PASID_FLAG_FL5LP : 0));
-		spin_unlock_irqrestore(&iommu->lock, iflags);
-		if (ret) {
-			if (mm)
-				mmu_notifier_unregister(&svm->notifier, mm);
-priv_err:
-			pasid_private_remove(svm->pasid);
-pasid_err:
-			ioasid_put(svm->pasid);
-svm_err:
-			kfree(svm);
-sdev_err:
-			kfree(sdev);
-			goto out;
-		}
+	/* The newly allocated pasid is loaded to the mm. */
+	if (!(flags & SVM_FLAG_SUPERVISOR_MODE) && list_empty(&svm->devs))
+		load_pasid(mm, svm->pasid);
 
-		list_add_tail(&svm->list, &global_svm_list);
-		if (mm) {
-			/* The newly allocated pasid is loaded to the mm. */
-			load_pasid(mm, svm->pasid);
-		}
-	} else {
-		/*
-		 * Binding a new device with existing PASID, need to setup
-		 * the PASID entry.
-		 */
-		spin_lock_irqsave(&iommu->lock, iflags);
-		ret = intel_pasid_setup_first_level(iommu, dev,
-						mm ? mm->pgd : init_mm.pgd,
-						svm->pasid, FLPT_DEFAULT_DID,
-						(mm ? 0 : PASID_FLAG_SUPERVISOR_MODE) |
-						(cpu_feature_enabled(X86_FEATURE_LA57) ?
-						PASID_FLAG_FL5LP : 0));
-		spin_unlock_irqrestore(&iommu->lock, iflags);
-		if (ret)
-			goto sdev_err;
-	}
 	list_add_rcu(&sdev->list, &svm->devs);
 success:
-	sdev->pasid = svm->pasid;
-	sdev->sva.dev = dev;
-	if (sd)
-		*sd = sdev;
-	ret = 0;
-out:
-	return ret;
+	return &sdev->sva;
+
+free_sdev:
+	kfree(sdev);
+free_svm:
+	if (list_empty(&svm->devs)) {
+		if (svm->notifier.ops)
+			mmu_notifier_unregister(&svm->notifier, mm);
+		pasid_private_remove(mm->pasid);
+		kfree(svm);
+	}
+
+	return ERR_PTR(ret);
 }
 
 /* Caller must hold pasid_mutex */
@@ -655,6 +598,7 @@ static int intel_svm_unbind_mm(struct device *dev, u32 pasid)
 	struct intel_svm_dev *sdev;
 	struct intel_iommu *iommu;
 	struct intel_svm *svm;
+	struct mm_struct *mm;
 	int ret = -EINVAL;
 
 	iommu = device_to_iommu(dev, NULL, NULL);
@@ -664,6 +608,7 @@ static int intel_svm_unbind_mm(struct device *dev, u32 pasid)
 	ret = pasid_to_svm_sdev(dev, pasid, &svm, &sdev);
 	if (ret)
 		goto out;
+	mm = svm->mm;
 
 	if (sdev) {
 		sdev->users--;
@@ -682,13 +627,12 @@ static int intel_svm_unbind_mm(struct device *dev, u32 pasid)
 			kfree_rcu(sdev, rcu);
 
 			if (list_empty(&svm->devs)) {
-				ioasid_put(svm->pasid);
-				if (svm->mm) {
-					mmu_notifier_unregister(&svm->notifier, svm->mm);
+				intel_svm_free_pasid(mm);
+				if (svm->notifier.ops) {
+					mmu_notifier_unregister(&svm->notifier, mm);
 					/* Clear mm's pasid. */
-					load_pasid(svm->mm, PASID_DISABLED);
+					load_pasid(mm, PASID_DISABLED);
 				}
-				list_del(&svm->list);
 				pasid_private_remove(svm->pasid);
 				/* We mandate that no page faults may be outstanding
 				 * for the PASID when intel_svm_unbind_mm() is called.
@@ -1073,31 +1017,42 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 	return IRQ_RETVAL(handled);
 }
 
-#define to_intel_svm_dev(handle) container_of(handle, struct intel_svm_dev, sva)
-struct iommu_sva *
-intel_svm_bind(struct device *dev, struct mm_struct *mm, void *drvdata)
+struct iommu_sva *intel_svm_bind(struct device *dev, struct mm_struct *mm, void *drvdata)
 {
-	struct iommu_sva *sva = ERR_PTR(-EINVAL);
-	struct intel_svm_dev *sdev = NULL;
+	struct intel_iommu *iommu = device_to_iommu(dev, NULL, NULL);
 	unsigned int flags = 0;
+	struct iommu_sva *sva;
 	int ret;
 
-	/*
-	 * TODO: Consolidate with generic iommu-sva bind after it is merged.
-	 * It will require shared SVM data structures, i.e. combine io_mm
-	 * and intel_svm etc.
-	 */
 	if (drvdata)
 		flags = *(unsigned int *)drvdata;
+
+	if (flags & SVM_FLAG_SUPERVISOR_MODE) {
+		if (!ecap_srs(iommu->ecap)) {
+			dev_err(dev, "%s: Supervisor PASID not supported\n",
+				iommu->name);
+			return ERR_PTR(-EOPNOTSUPP);
+		}
+
+		if (mm) {
+			dev_err(dev, "%s: Supervisor PASID with user provided mm\n",
+				iommu->name);
+			return ERR_PTR(-EINVAL);
+		}
+
+		mm = &init_mm;
+	}
+
 	mutex_lock(&pasid_mutex);
-	ret = intel_svm_bind_mm(dev, flags, mm, &sdev);
-	if (ret)
-		sva = ERR_PTR(ret);
-	else if (sdev)
-		sva = &sdev->sva;
-	else
-		WARN(!sdev, "SVM bind succeeded with no sdev!\n");
+	ret = intel_svm_alloc_pasid(dev, mm, flags);
+	if (ret) {
+		mutex_unlock(&pasid_mutex);
+		return ERR_PTR(ret);
+	}
 
+	sva = intel_svm_bind_mm(iommu, dev, mm, flags);
+	if (IS_ERR_OR_NULL(sva))
+		intel_svm_free_pasid(mm);
 	mutex_unlock(&pasid_mutex);
 
 	return sva;
@@ -1105,10 +1060,9 @@ intel_svm_bind(struct device *dev, struct mm_struct *mm, void *drvdata)
 
 void intel_svm_unbind(struct iommu_sva *sva)
 {
-	struct intel_svm_dev *sdev;
+	struct intel_svm_dev *sdev = to_intel_svm_dev(sva);
 
 	mutex_lock(&pasid_mutex);
-	sdev = to_intel_svm_dev(sva);
 	intel_svm_unbind_mm(sdev->dev, sdev->pasid);
 	mutex_unlock(&pasid_mutex);
 }
diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
index 7e5b240b801d..a37bd54c5b90 100644
--- a/drivers/iommu/intel/Kconfig
+++ b/drivers/iommu/intel/Kconfig
@@ -42,6 +42,7 @@ config INTEL_IOMMU_SVM
 	select PCI_PRI
 	select MMU_NOTIFIER
 	select IOASID
+	select IOMMU_SVA_LIB
 	help
 	  Shared Virtual Memory (SVM) provides a facility for devices
 	  to access DMA resources through process address space by
-- 
2.25.1

