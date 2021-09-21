Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBB29414123
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 07:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbhIVFOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 01:14:45 -0400
Received: from mga12.intel.com ([192.55.52.136]:29325 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232014AbhIVFOl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 01:14:41 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10114"; a="203012040"
X-IronPort-AV: E=Sophos;i="5.85,312,1624345200"; 
   d="scan'208";a="203012040"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2021 22:13:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,312,1624345200"; 
   d="scan'208";a="550107674"
Received: from otc-wp-03.jf.intel.com ([10.54.39.79])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Sep 2021 22:13:11 -0700
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
Subject: [RFC 2/7] dma-iommu: Add API for DMA request with PASID
Date:   Tue, 21 Sep 2021 13:29:36 -0700
Message-Id: <1632256181-36071-3-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1632256181-36071-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1632256181-36071-1-git-send-email-jacob.jun.pan@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DMA-API is the standard way for device drivers to perform in-kernel
DMA requests. If security is on, isolation is enforced by the IOMMU at
requester ID (RID) granularity. With the introduction of process address
space ID (PASID), DMA security is enforced per RID+PASID
granularity. On some modern platforms, DMA request with PASID is the
only option available. e.g. The shared work queues in Intel Data
Streaming Accelerators (DSA).
To support DMA with PASID while maintaining the ubiquitous usage of DMA
API, this patch introduces a new IOMMU DMA API that supports two
addressing modes:
1. Physical address or bypass mode. This is similar to DMA direct mode,
where trusted devices can DMA passthrough IOMMU.
2. IOVA mode that abides DMA APIs. Once set up, callers can use DMA API
as-is. DMA requests w/ and w/o PASID will be mapped by the same page
tables.  i.e. the default DMA domain will be used by both RID and
RID+PASID.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/dma-iommu.c | 54 +++++++++++++++++++++++++++++++++++++++
 include/linux/dma-iommu.h | 12 +++++++++
 include/linux/iommu.h     |  2 ++
 3 files changed, 68 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 7bcdd1205535..490731659def 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -174,6 +174,60 @@ void iommu_put_dma_cookie(struct iommu_domain *domain)
 }
 EXPORT_SYMBOL(iommu_put_dma_cookie);
 
+/**
+ * iommu_dma_pasid_enable --Enable device DMA request with PASID
+ * @dev:	Device to be enabled
+ * @mode:	DMA addressing mode
+ *
+ * The following mutually exclusive DMA addressing modes are supported:
+ *
+ *  1. Physical address or bypass mode. This is similar to DMA direct where
+ *     trusted devices can DMA pass-through IOMMU.
+ *
+ *  2. IOVA mode. This abides DMA APIs. Once set up, callers can use DMA API
+ *     as-is. DMA request w/ and w/o PASID will be mapped by the same page
+ *     tables. PCI requester ID (RID) and RID+PASID will be pointed to the same
+ *     PGD. i.e. the default DMA domain will be used by both RID and RID+PASID.
+ *
+ * @return the supervisor PASID to be used for DMA. Or INVALID_IOASID upon
+ *     failure.
+ */
+int iommu_dma_pasid_enable(struct device *dev,
+			   enum iommu_dma_pasid_mode mode)
+{
+	int pasid = INVALID_IOASID;
+	struct iommu_domain *dom = NULL;
+
+	/* TODO: only allow a single mode each time, track PASID DMA enabling
+	 * status per device. Perhaps add a flag in struct device.dev_iommu.
+	 */
+
+	/* Call vendor drivers to handle IOVA, bypass mode */
+	dom = iommu_get_domain_for_dev(dev);
+	if (dom->ops->enable_pasid_dma(dev, IOASID_DMA_PASID, mode)) {
+		dev_dbg(dev, "Failed to enable DMA pasid in mode %d", mode);
+		goto exit;
+	}
+	pasid = IOASID_DMA_PASID;
+
+	dev_dbg(dev, "Enable DMA pasid %d in mode %d", pasid, mode);
+	goto exit;
+exit:
+	return pasid;
+}
+EXPORT_SYMBOL(iommu_dma_pasid_enable);
+
+int iommu_dma_pasid_disable(struct device *dev)
+{
+	struct iommu_domain *dom;
+
+	/* Call vendor iommu ops to clean up supervisor PASID context */
+	dom = iommu_get_domain_for_dev(dev);
+
+	return dom->ops->disable_pasid_dma(dev);
+}
+EXPORT_SYMBOL(iommu_dma_pasid_disable);
+
 /**
  * iommu_dma_get_resv_regions - Reserved region driver helper
  * @dev: Device from iommu_get_resv_regions()
diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
index 6e75a2d689b4..3c1555e0fd51 100644
--- a/include/linux/dma-iommu.h
+++ b/include/linux/dma-iommu.h
@@ -17,6 +17,18 @@
 int iommu_get_dma_cookie(struct iommu_domain *domain);
 int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base);
 void iommu_put_dma_cookie(struct iommu_domain *domain);
+enum iommu_dma_pasid_mode {
+	/* Pass-through mode, use physical address */
+	IOMMU_DMA_PASID_BYPASS = 1,
+	/* Compatible with DMA APIs, same mapping as DMA w/o PASID */
+	IOMMU_DMA_PASID_IOVA,
+};
+/* For devices that can do DMA request with PASID, setup the system
+ * based on the address mode selected.
+ */
+int iommu_dma_pasid_enable(struct device *dev,
+			   enum iommu_dma_pasid_mode mode);
+int iommu_dma_pasid_disable(struct device *dev);
 
 /* Setup call for arch DMA mapping code */
 void iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 size);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 32d448050bf7..610cbfd03e6b 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -283,6 +283,8 @@ struct iommu_ops {
 
 	int (*def_domain_type)(struct device *dev);
 
+	int (*enable_pasid_dma)(struct device *dev, u32 pasid, int mode);
+	int (*disable_pasid_dma)(struct device *dev);
 	unsigned long pgsize_bitmap;
 	struct module *owner;
 };
-- 
2.25.1

