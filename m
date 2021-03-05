Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0652F32F021
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 17:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbhCEQcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 11:32:45 -0500
Received: from foss.arm.com ([217.140.110.172]:56648 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229631AbhCEQcl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 11:32:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7C82A11FB;
        Fri,  5 Mar 2021 08:32:40 -0800 (PST)
Received: from DESKTOP-VLO843J.arm.com (unknown [10.57.48.219])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 07BCE3F73B;
        Fri,  5 Mar 2021 08:32:38 -0800 (PST)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org
Cc:     iommu@lists.linux-foundation.org, dwmw2@infradead.org,
        baolu.lu@linux.intel.com, murphyt7@tcd.ie, john.garry@huawei.com,
        thunder.leizhen@huawei.com, will@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/dma: Resurrect the "forcedac" option
Date:   Fri,  5 Mar 2021 16:32:34 +0000
Message-Id: <7eece8e0ea7bfbe2cd0e30789e0d46df573af9b0.1614961776.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In converting intel-iommu over to the common IOMMU DMA ops, it quietly
lost the functionality of its "forcedac" option. Since this is a handy
thing both for testing and for performance optimisation on certain
platforms, reimplement it under the common IOMMU parameter namespace.

For the sake of fixing the inadvertent breakage of the Intel-specific
parameter, remove the dmar_forcedac remnants and hook it up as an alias
while documenting the transition to the new common parameter.

Fixes: c588072bba6b ("iommu/vt-d: Convert intel iommu driver to the iommu ops")
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 15 ++++++++-------
 drivers/iommu/dma-iommu.c                       | 13 ++++++++++++-
 drivers/iommu/intel/iommu.c                     |  5 ++---
 include/linux/dma-iommu.h                       |  2 ++
 4 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 04545725f187..835f810f2f26 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1869,13 +1869,6 @@
 			bypassed by not enabling DMAR with this option. In
 			this case, gfx device will use physical address for
 			DMA.
-		forcedac [X86-64]
-			With this option iommu will not optimize to look
-			for io virtual address below 32-bit forcing dual
-			address cycle on pci bus for cards supporting greater
-			than 32-bit addressing. The default is to look
-			for translation below 32-bit and if not available
-			then look in the higher range.
 		strict [Default Off]
 			With this option on every unmap_single operation will
 			result in a hardware IOTLB flush operation as opposed
@@ -1964,6 +1957,14 @@
 		nobypass	[PPC/POWERNV]
 			Disable IOMMU bypass, using IOMMU for PCI devices.
 
+	iommu.forcedac=	[ARM64, X86] Control IOVA allocation for PCI devices.
+			Format: { "0" | "1" }
+			0 - Try to allocate a 32-bit DMA address first, before
+			  falling back to the full range if needed.
+			1 - Allocate directly from the full usable range,
+			  forcing Dual Address Cycle for PCI cards supporting
+			  greater than 32-bit addressing.
+
 	iommu.strict=	[ARM64] Configure TLB invalidation behaviour
 			Format: { "0" | "1" }
 			0 - Lazy mode.
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 9ab6ee22c110..260bf3de1992 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -52,6 +52,17 @@ struct iommu_dma_cookie {
 };
 
 static DEFINE_STATIC_KEY_FALSE(iommu_deferred_attach_enabled);
+bool iommu_dma_forcedac __read_mostly;
+
+static int __init iommu_dma_forcedac_setup(char *str)
+{
+	int ret = kstrtobool(str, &iommu_dma_forcedac);
+
+	if (!ret && iommu_dma_forcedac)
+		pr_info("Forcing DAC for PCI devices\n");
+	return ret;
+}
+early_param("iommu.forcedac", iommu_dma_forcedac_setup);
 
 void iommu_dma_free_cpu_cached_iovas(unsigned int cpu,
 		struct iommu_domain *domain)
@@ -438,7 +449,7 @@ static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
 		dma_limit = min(dma_limit, (u64)domain->geometry.aperture_end);
 
 	/* Try to get PCI devices a SAC address */
-	if (dma_limit > DMA_BIT_MASK(32) && dev_is_pci(dev))
+	if (dma_limit > DMA_BIT_MASK(32) && !iommu_dma_forcedac && dev_is_pci(dev))
 		iova = alloc_iova_fast(iovad, iova_len,
 				       DMA_BIT_MASK(32) >> shift, false);
 
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index ee0932307d64..1c32522220bc 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -360,7 +360,6 @@ int intel_iommu_enabled = 0;
 EXPORT_SYMBOL_GPL(intel_iommu_enabled);
 
 static int dmar_map_gfx = 1;
-static int dmar_forcedac;
 static int intel_iommu_strict;
 static int intel_iommu_superpage = 1;
 static int iommu_identity_mapping;
@@ -451,8 +450,8 @@ static int __init intel_iommu_setup(char *str)
 			dmar_map_gfx = 0;
 			pr_info("Disable GFX device mapping\n");
 		} else if (!strncmp(str, "forcedac", 8)) {
-			pr_info("Forcing DAC for PCI devices\n");
-			dmar_forcedac = 1;
+			pr_warn("intel_iommu=forcedac deprecated; use iommu.forcedac instead\n");
+			iommu_dma_forcedac = true;
 		} else if (!strncmp(str, "strict", 6)) {
 			pr_info("Disable batched IOTLB flush\n");
 			intel_iommu_strict = 1;
diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
index 706b68d1359b..13d1f4c14d7b 100644
--- a/include/linux/dma-iommu.h
+++ b/include/linux/dma-iommu.h
@@ -40,6 +40,8 @@ void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list);
 void iommu_dma_free_cpu_cached_iovas(unsigned int cpu,
 		struct iommu_domain *domain);
 
+extern bool iommu_dma_forcedac;
+
 #else /* CONFIG_IOMMU_DMA */
 
 struct iommu_domain;
-- 
2.17.1

