Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21D05414124
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 07:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbhIVFOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 01:14:46 -0400
Received: from mga12.intel.com ([192.55.52.136]:29328 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231993AbhIVFOm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 01:14:42 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10114"; a="203012042"
X-IronPort-AV: E=Sophos;i="5.85,312,1624345200"; 
   d="scan'208";a="203012042"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2021 22:13:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,312,1624345200"; 
   d="scan'208";a="550107679"
Received: from otc-wp-03.jf.intel.com ([10.54.39.79])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Sep 2021 22:13:12 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "Christoph Hellwig" <hch@infradead.org>
Cc:     "Lu Baolu" <baolu.lu@linux.intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>, mike.campin@intel.com,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>
Subject: [RFC 3/7] iommu/vt-d: Add DMA w/ PASID support for PA and IOVA
Date:   Tue, 21 Sep 2021 13:29:37 -0700
Message-Id: <1632256181-36071-4-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1632256181-36071-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1632256181-36071-1-git-send-email-jacob.jun.pan@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For physical address(PA) mode, PASID entry for the given supervisor
PASID will be set up for HW pass-through (PT). For IOVA mode, the
supervisor PASID entry will be configured the same as PASID 0, which is
a special PASID for DMA request w/o PASID, a.k.a.
RID2PASID. Additional IOTLB flush for the supervisor PASID is also
included.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 95 ++++++++++++++++++++++++++++++++++++-
 include/linux/intel-iommu.h |  7 ++-
 2 files changed, 100 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index be35284a2016..cbcfd178c16f 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1631,7 +1631,11 @@ static void domain_flush_piotlb(struct intel_iommu *iommu,
 	if (domain->default_pasid)
 		qi_flush_piotlb(iommu, did, domain->default_pasid,
 				addr, npages, ih);
-
+	if (domain->s_pasid) {
+		pr_alert_ratelimited("%s: pasid %u", __func__, domain->s_pasid);
+		qi_flush_piotlb(iommu, did, domain->s_pasid,
+				addr, npages, ih);
+	}
 	if (!list_empty(&domain->devices))
 		qi_flush_piotlb(iommu, did, PASID_RID2PASID, addr, npages, ih);
 }
@@ -5535,6 +5539,93 @@ static void intel_iommu_iotlb_sync_map(struct iommu_domain *domain,
 	}
 }
 
+static int intel_enable_pasid_dma(struct device *dev, u32 pasid, int mode)
+{
+	struct intel_iommu *iommu = device_to_iommu(dev, NULL, NULL);
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct device_domain_info *info;
+	unsigned long flags;
+	int ret = 0;
+
+	info = get_domain_info(dev);
+	if (!info)
+		return -ENODEV;
+
+	if (!dev_is_pci(dev) || !sm_supported(info->iommu))
+		return -EINVAL;
+
+	if (intel_iommu_enable_pasid(info->iommu, dev))
+		return -ENODEV;
+
+	spin_lock_irqsave(&iommu->lock, flags);
+	switch (mode) {
+	case IOMMU_DMA_PASID_BYPASS:
+		dev_dbg(dev, "%s PT mode", __func__);
+		/* As a precaution, translation request should be responded with
+		 * physical address.
+		 */
+		if (!hw_pass_through) {
+			ret = -ENODEV;
+			goto exit_unlock;
+		}
+		/* HW may use large page for ATS */
+		pci_disable_ats(pdev);
+		ret = intel_pasid_setup_pass_through(info->iommu, info->domain,
+						      dev, pasid);
+		if (ret)
+			dev_err(dev, "Failed SPASID %d BYPASS", pasid);
+		break;
+	case IOMMU_DMA_PASID_IOVA:
+		dev_dbg(dev, "%s IOVA mode", __func__);
+		/*
+		 * We could use SL but FL is preferred for consistency with VM
+		 * where vIOMMU exposes FL only cap
+		 */
+		if (!domain_use_first_level(info->domain))
+			return -EINVAL;
+		/* To be used for IOTLB flush at PASID granularity */
+		info->domain->s_pasid = pasid;
+		ret = domain_setup_first_level(info->iommu, info->domain, dev,
+						pasid);
+		break;
+	default:
+		dev_err(dev, "Invalid PASID DMA mode %d", mode);
+		ret = -EINVAL;
+		goto exit_unlock;
+	}
+	info->pasid_mode = mode;
+exit_unlock:
+	spin_unlock_irqrestore(&iommu->lock, flags);
+
+	return ret;
+}
+
+static int intel_disable_pasid_dma(struct device *dev)
+{
+	struct device_domain_info *info;
+	int ret = 0;
+
+	info = get_domain_info(dev);
+	if (!info)
+		return -ENODEV;
+
+	if (!dev_is_pci(dev) || !sm_supported(info->iommu))
+		return -EINVAL;
+
+	if (intel_iommu_enable_pasid(info->iommu, dev))
+		return -ENODEV;
+
+	if (!dev->iommu) {
+		dev_err(dev, "No IOMMU params");
+		return -ENODEV;
+	}
+	dev_info(dev, "Tearing down DMA PASID %d",  info->domain->s_pasid);
+	intel_pasid_tear_down_entry(info->iommu, info->dev, info->domain->s_pasid, false);
+
+	info->domain->s_pasid = 0;
+	return ret;
+}
+
 const struct iommu_ops intel_iommu_ops = {
 	.capable		= intel_iommu_capable,
 	.domain_alloc		= intel_iommu_domain_alloc,
@@ -5573,6 +5664,8 @@ const struct iommu_ops intel_iommu_ops = {
 	.sva_get_pasid		= intel_svm_get_pasid,
 	.page_response		= intel_svm_page_response,
 #endif
+	.enable_pasid_dma	= intel_enable_pasid_dma,
+	.disable_pasid_dma	= intel_disable_pasid_dma,
 };
 
 static void quirk_iommu_igfx(struct pci_dev *dev)
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 03faf20a6817..8940759f759e 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -21,6 +21,7 @@
 #include <linux/dmar.h>
 #include <linux/ioasid.h>
 #include <linux/bitfield.h>
+#include <linux/dma-iommu.h>
 
 #include <asm/cacheflush.h>
 #include <asm/iommu.h>
@@ -571,7 +572,10 @@ struct dmar_domain {
 					 * The default pasid used for non-SVM
 					 * traffic on mediated devices.
 					 */
-
+	u32		s_pasid;	/*
+					 * Supervisor PASID used for in-kernel
+					 * DMA request with PASID.
+					 */
 	struct iommu_domain domain;	/* generic domain data structure for
 					   iommu core */
 };
@@ -652,6 +656,7 @@ struct device_domain_info {
 	struct intel_iommu *iommu; /* IOMMU used by this device */
 	struct dmar_domain *domain; /* pointer to domain */
 	struct pasid_table *pasid_table; /* pasid table */
+	enum iommu_dma_pasid_mode pasid_mode; /* DMA PASID address mode */
 };
 
 static inline void __iommu_flush_cache(
-- 
2.25.1

