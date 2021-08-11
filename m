Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8020E3E9098
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 14:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237960AbhHKMXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 08:23:17 -0400
Received: from foss.arm.com ([217.140.110.172]:48758 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237577AbhHKMWz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 08:22:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5DBF2106F;
        Wed, 11 Aug 2021 05:22:31 -0700 (PDT)
Received: from 010265703453.arm.com (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9FF3F3F718;
        Wed, 11 Aug 2021 05:22:29 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will@kernel.org
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        suravee.suthikulpanit@amd.com, baolu.lu@linux.intel.com,
        john.garry@huawei.com, dianders@chromium.org, rajatja@google.com,
        chenxiang66@hisilicon.com
Subject: [PATCH v4 20/24] iommu: Express DMA strictness via the domain type
Date:   Wed, 11 Aug 2021 13:21:34 +0100
Message-Id: <47083d69155577f1367877b1594921948c366eb3.1628682049.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1628682048.git.robin.murphy@arm.com>
References: <cover.1628682048.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate the iommu_get_dma_strict() indirection and pipe the
information through the domain type from the beginning. Besides
the flow simplification this also has several nice side-effects:

 - Automatically implies strict mode for untrusted devices by
   virtue of their IOMMU_DOMAIN_DMA override.
 - Ensures that we only end up using flush queues for drivers
   which are aware of them and can actually benefit.
 - Allows us to handle flush queue init failure by falling back
   to strict mode instead of leaving it to possibly blow up later.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>

---

v3: Remember to update iommu_def_domain_type accordingly from
    iommu_set_dma_strict() too
---
 drivers/iommu/dma-iommu.c | 10 ++++++----
 drivers/iommu/iommu.c     | 14 +++++---------
 include/linux/iommu.h     |  1 -
 3 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 207c8febdac9..01fa83229118 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -363,13 +363,15 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 
 	init_iova_domain(iovad, 1UL << order, base_pfn);
 
-	if (!cookie->fq_domain && !dev_is_untrusted(dev) &&
-	    domain->ops->flush_iotlb_all && !iommu_get_dma_strict(domain)) {
+	/* If the FQ fails we can simply fall back to strict mode */
+	if (domain->type == IOMMU_DOMAIN_DMA_FQ && !cookie->fq_domain) {
 		if (init_iova_flush_queue(iovad, iommu_dma_flush_iotlb_all,
-					  iommu_dma_entry_dtor))
+					  iommu_dma_entry_dtor)) {
 			pr_warn("iova flush queue initialization failed\n");
-		else
+			domain->type = IOMMU_DOMAIN_DMA;
+		} else {
 			cookie->fq_domain = domain;
+		}
 	}
 
 	return iova_reserve_iommu_regions(dev, domain);
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 982545234cf3..55ca5bf3cafc 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -136,6 +136,9 @@ static int __init iommu_subsys_init(void)
 		}
 	}
 
+	if (!iommu_default_passthrough() && !iommu_dma_strict)
+		iommu_def_domain_type = IOMMU_DOMAIN_DMA_FQ;
+
 	pr_info("Default domain type: %s %s\n",
 		iommu_domain_type_str(iommu_def_domain_type),
 		(iommu_cmd_line & IOMMU_CMD_LINE_DMA_API) ?
@@ -355,17 +358,10 @@ early_param("iommu.strict", iommu_dma_setup);
 void iommu_set_dma_strict(void)
 {
 	iommu_dma_strict = true;
+	if (iommu_def_domain_type == IOMMU_DOMAIN_DMA_FQ)
+		iommu_def_domain_type = IOMMU_DOMAIN_DMA;
 }
 
-bool iommu_get_dma_strict(struct iommu_domain *domain)
-{
-	/* only allow lazy flushing for DMA domains */
-	if (domain->type == IOMMU_DOMAIN_DMA)
-		return iommu_dma_strict;
-	return true;
-}
-EXPORT_SYMBOL_GPL(iommu_get_dma_strict);
-
 static ssize_t iommu_group_attr_show(struct kobject *kobj,
 				     struct attribute *__attr, char *buf)
 {
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 5629ae42951f..923a8d1c5e39 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -504,7 +504,6 @@ int iommu_set_pgtable_quirks(struct iommu_domain *domain,
 		unsigned long quirks);
 
 void iommu_set_dma_strict(void);
-bool iommu_get_dma_strict(struct iommu_domain *domain);
 
 extern int report_iommu_fault(struct iommu_domain *domain, struct device *dev,
 			      unsigned long iova, int flags);
-- 
2.25.1

