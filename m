Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 463C441BFD5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 09:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244641AbhI2H01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 03:26:27 -0400
Received: from mga01.intel.com ([192.55.52.88]:14864 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244638AbhI2H0W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 03:26:22 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10121"; a="247401403"
X-IronPort-AV: E=Sophos;i="5.85,331,1624345200"; 
   d="scan'208";a="247401403"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2021 00:24:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,331,1624345200"; 
   d="scan'208";a="476553453"
Received: from allen-box.sh.intel.com ([10.239.159.118])
  by orsmga007.jf.intel.com with ESMTP; 29 Sep 2021 00:24:07 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Will Deacon <will@kernel.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/1] iommu/vt-d: Delete dev_has_feat callback
Date:   Wed, 29 Sep 2021 15:20:30 +0800
Message-Id: <20210929072030.1330225-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 262948f8ba573 ("iommu: Delete iommu_dev_has_feature()") has
deleted the iommu_dev_has_feature() interface. Remove the dev_has_feat
callback to avoid dead code.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 59 ++++---------------------------------
 1 file changed, 5 insertions(+), 54 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 01162b0b9712..dc733de9eea5 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -5516,62 +5516,14 @@ static int intel_iommu_disable_sva(struct device *dev)
 	return ret;
 }
 
-/*
- * A PCI express designated vendor specific extended capability is defined
- * in the section 3.7 of Intel scalable I/O virtualization technical spec
- * for system software and tools to detect endpoint devices supporting the
- * Intel scalable IO virtualization without host driver dependency.
- *
- * Returns the address of the matching extended capability structure within
- * the device's PCI configuration space or 0 if the device does not support
- * it.
- */
-static int siov_find_pci_dvsec(struct pci_dev *pdev)
-{
-	int pos;
-	u16 vendor, id;
-
-	pos = pci_find_next_ext_capability(pdev, 0, 0x23);
-	while (pos) {
-		pci_read_config_word(pdev, pos + 4, &vendor);
-		pci_read_config_word(pdev, pos + 8, &id);
-		if (vendor == PCI_VENDOR_ID_INTEL && id == 5)
-			return pos;
-
-		pos = pci_find_next_ext_capability(pdev, pos, 0x23);
-	}
-
-	return 0;
-}
-
-static bool
-intel_iommu_dev_has_feat(struct device *dev, enum iommu_dev_features feat)
+static int intel_iommu_enable_iopf(struct device *dev)
 {
 	struct device_domain_info *info = get_domain_info(dev);
 
-	if (feat == IOMMU_DEV_FEAT_AUX) {
-		int ret;
-
-		if (!dev_is_pci(dev) || dmar_disabled ||
-		    !scalable_mode_support() || !pasid_mode_support())
-			return false;
-
-		ret = pci_pasid_features(to_pci_dev(dev));
-		if (ret < 0)
-			return false;
-
-		return !!siov_find_pci_dvsec(to_pci_dev(dev));
-	}
-
-	if (feat == IOMMU_DEV_FEAT_IOPF)
-		return info && info->pri_supported;
-
-	if (feat == IOMMU_DEV_FEAT_SVA)
-		return info && (info->iommu->flags & VTD_FLAG_SVM_CAPABLE) &&
-			info->pasid_supported && info->pri_supported &&
-			info->ats_supported;
+	if (info && info->pri_supported)
+		return 0;
 
-	return false;
+	return -ENODEV;
 }
 
 static int
@@ -5582,7 +5534,7 @@ intel_iommu_dev_enable_feat(struct device *dev, enum iommu_dev_features feat)
 		return intel_iommu_enable_auxd(dev);
 
 	case IOMMU_DEV_FEAT_IOPF:
-		return intel_iommu_dev_has_feat(dev, feat) ? 0 : -ENODEV;
+		return intel_iommu_enable_iopf(dev);
 
 	case IOMMU_DEV_FEAT_SVA:
 		return intel_iommu_enable_sva(dev);
@@ -5708,7 +5660,6 @@ const struct iommu_ops intel_iommu_ops = {
 	.get_resv_regions	= intel_iommu_get_resv_regions,
 	.put_resv_regions	= generic_iommu_put_resv_regions,
 	.device_group		= intel_iommu_device_group,
-	.dev_has_feat		= intel_iommu_dev_has_feat,
 	.dev_feat_enabled	= intel_iommu_dev_feat_enabled,
 	.dev_enable_feat	= intel_iommu_dev_enable_feat,
 	.dev_disable_feat	= intel_iommu_dev_disable_feat,
-- 
2.25.1

