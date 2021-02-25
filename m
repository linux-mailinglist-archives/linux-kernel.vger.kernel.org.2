Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66BE6324A84
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 07:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbhBYGZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 01:25:41 -0500
Received: from mga02.intel.com ([134.134.136.20]:38276 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232263AbhBYGZj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 01:25:39 -0500
IronPort-SDR: h23PeGMIkXk087DYNOlKSKN4UDPEuT7x1sPPC8gz+rMxPnMiRVcZ1HYS+PiOXjRLph+ux0mRAR
 X4uOOp4huSTw==
X-IronPort-AV: E=McAfee;i="6000,8403,9905"; a="172557266"
X-IronPort-AV: E=Sophos;i="5.81,205,1610438400"; 
   d="scan'208";a="172557266"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2021 22:23:52 -0800
IronPort-SDR: MMjmLK3QQqS05RHZUjV4/VLMAf3Nz7v/F6myV0KgGZGsLZeK76vcucy6yWy4fe+Bknn1oNBT/V
 5KB5rdLM/QZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,205,1610438400"; 
   d="scan'208";a="499960144"
Received: from allen-box.sh.intel.com ([10.239.159.128])
  by fmsmga001.fm.intel.com with ESMTP; 24 Feb 2021 22:23:50 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/1] iommu: Don't use lazy flush for untrusted device
Date:   Thu, 25 Feb 2021 14:14:54 +0800
Message-Id: <20210225061454.2864009-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lazy IOTLB flushing setup leaves a time window, in which the device
can still access some system memory, which has already been unmapped by
the device driver. It's not suitable for untrusted devices. A malicious
device might use this to attack the system by obtaining data that it
shouldn't obtain.

Fixes: c588072bba6b5 ("iommu/vt-d: Convert intel iommu driver to the iommu ops")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/dma-iommu.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index f659395e7959..65234e383d6b 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -311,6 +311,11 @@ static void iommu_dma_flush_iotlb_all(struct iova_domain *iovad)
 	domain->ops->flush_iotlb_all(domain);
 }
 
+static bool dev_is_untrusted(struct device *dev)
+{
+	return dev_is_pci(dev) && to_pci_dev(dev)->untrusted;
+}
+
 /**
  * iommu_dma_init_domain - Initialise a DMA mapping domain
  * @domain: IOMMU domain previously prepared by iommu_get_dma_cookie()
@@ -365,8 +370,9 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 
 	init_iova_domain(iovad, 1UL << order, base_pfn);
 
-	if (!cookie->fq_domain && !iommu_domain_get_attr(domain,
-			DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE, &attr) && attr) {
+	if (!cookie->fq_domain && (!dev || !dev_is_untrusted(dev)) &&
+	    !iommu_domain_get_attr(domain, DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE, &attr) &&
+	    attr) {
 		if (init_iova_flush_queue(iovad, iommu_dma_flush_iotlb_all,
 					  iommu_dma_entry_dtor))
 			pr_warn("iova flush queue initialization failed\n");
@@ -508,11 +514,6 @@ static void __iommu_dma_unmap_swiotlb(struct device *dev, dma_addr_t dma_addr,
 				iova_align(iovad, size), dir, attrs);
 }
 
-static bool dev_is_untrusted(struct device *dev)
-{
-	return dev_is_pci(dev) && to_pci_dev(dev)->untrusted;
-}
-
 static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
 		size_t size, int prot, u64 dma_mask)
 {
-- 
2.25.1

