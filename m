Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 897D5389BB2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 05:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbhETDSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 23:18:15 -0400
Received: from mga05.intel.com ([192.55.52.43]:58824 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230262AbhETDSM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 23:18:12 -0400
IronPort-SDR: dUq6yXSGCQRhhVpaicKMTd9lxrzNbdiScNfceYzXkPra3Xjt2SPhH2fECEzhp7UlYEKDJArB7n
 R9GWCguxmMwg==
X-IronPort-AV: E=McAfee;i="6200,9189,9989"; a="286659613"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="286659613"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 20:16:51 -0700
IronPort-SDR: /OV9waVq8p7mlGyfB7Xba89tra03SeVTQ4CF9I94BLatG+4JGy7a6+taVbourpabpBv+L5wV32
 qaLjmwyGMIeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="395527201"
Received: from allen-box.sh.intel.com ([10.239.159.128])
  by orsmga006.jf.intel.com with ESMTP; 19 May 2021 20:16:49 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     ashok.raj@intel.com, kevin.tian@intel.com, jacob.jun.pan@intel.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 03/11] iommu/vt-d: Use common helper to lookup svm devices
Date:   Thu, 20 May 2021 11:15:23 +0800
Message-Id: <20210520031531.712333-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210520031531.712333-1-baolu.lu@linux.intel.com>
References: <20210520031531.712333-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's common to iterate the svm device list and find a matched device. Add
common helpers to do this and consolidate the code.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/svm.c | 68 +++++++++++++++++++++++----------------
 1 file changed, 40 insertions(+), 28 deletions(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index da4310686ed3..57867ff97bc2 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -48,6 +48,40 @@ static void *pasid_private_find(ioasid_t pasid)
 	return xa_load(&pasid_private_array, pasid);
 }
 
+static struct intel_svm_dev *
+svm_lookup_device_by_sid(struct intel_svm *svm, u16 sid)
+{
+	struct intel_svm_dev *sdev = NULL, *t;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(t, &svm->devs, list) {
+		if (t->sid == sid) {
+			sdev = t;
+			break;
+		}
+	}
+	rcu_read_unlock();
+
+	return sdev;
+}
+
+static struct intel_svm_dev *
+svm_lookup_device_by_dev(struct intel_svm *svm, struct device *dev)
+{
+	struct intel_svm_dev *sdev = NULL, *t;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(t, &svm->devs, list) {
+		if (t->dev == dev) {
+			sdev = t;
+			break;
+		}
+	}
+	rcu_read_unlock();
+
+	return sdev;
+}
+
 int intel_svm_enable_prq(struct intel_iommu *iommu)
 {
 	struct page *pages;
@@ -225,15 +259,11 @@ static const struct mmu_notifier_ops intel_mmuops = {
 
 static DEFINE_MUTEX(pasid_mutex);
 
-#define for_each_svm_dev(sdev, svm, d)			\
-	list_for_each_entry((sdev), &(svm)->devs, list)	\
-		if ((d) != (sdev)->dev) {} else
-
 static int pasid_to_svm_sdev(struct device *dev, unsigned int pasid,
 			     struct intel_svm **rsvm,
 			     struct intel_svm_dev **rsdev)
 {
-	struct intel_svm_dev *d, *sdev = NULL;
+	struct intel_svm_dev *sdev = NULL;
 	struct intel_svm *svm;
 
 	/* The caller should hold the pasid_mutex lock */
@@ -256,15 +286,7 @@ static int pasid_to_svm_sdev(struct device *dev, unsigned int pasid,
 	 */
 	if (WARN_ON(list_empty(&svm->devs)))
 		return -EINVAL;
-
-	rcu_read_lock();
-	list_for_each_entry_rcu(d, &svm->devs, list) {
-		if (d->dev == dev) {
-			sdev = d;
-			break;
-		}
-	}
-	rcu_read_unlock();
+	sdev = svm_lookup_device_by_dev(svm, dev);
 
 out:
 	*rsvm = svm;
@@ -533,7 +555,8 @@ static struct iommu_sva *intel_svm_bind_mm(struct intel_iommu *iommu,
 	}
 
 	/* Find the matching device in svm list */
-	for_each_svm_dev(sdev, svm, dev) {
+	sdev = svm_lookup_device_by_dev(svm, dev);
+	if (sdev) {
 		sdev->users++;
 		goto success;
 	}
@@ -901,19 +924,8 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 			}
 		}
 
-		if (!sdev || sdev->sid != req->rid) {
-			struct intel_svm_dev *t;
-
-			sdev = NULL;
-			rcu_read_lock();
-			list_for_each_entry_rcu(t, &svm->devs, list) {
-				if (t->sid == req->rid) {
-					sdev = t;
-					break;
-				}
-			}
-			rcu_read_unlock();
-		}
+		if (!sdev || sdev->sid != req->rid)
+			sdev = svm_lookup_device_by_sid(svm, req->rid);
 
 		/* Since we're using init_mm.pgd directly, we should never take
 		 * any faults on kernel addresses. */
-- 
2.25.1

