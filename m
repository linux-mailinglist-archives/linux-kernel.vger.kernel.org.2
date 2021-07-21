Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88C613D1643
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 20:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238326AbhGURlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 13:41:13 -0400
Received: from foss.arm.com ([217.140.110.172]:33454 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238451AbhGURkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 13:40:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AEFC3113E;
        Wed, 21 Jul 2021 11:21:16 -0700 (PDT)
Received: from 010265703453.arm.com (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3CA4B3F694;
        Wed, 21 Jul 2021 11:21:15 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will@kernel.org
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        suravee.suthikulpanit@amd.com, baolu.lu@linux.intel.com,
        john.garry@huawei.com, dianders@chromium.org
Subject: [PATCH 18/23] iommu: Express DMA strictness via the domain type
Date:   Wed, 21 Jul 2021 19:20:29 +0100
Message-Id: <37708e21b55e17eb074ef145afc2157cd0192abe.1626888445.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1626888444.git.robin.murphy@arm.com>
References: <cover.1626888444.git.robin.murphy@arm.com>
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
 - Ensures that we only ends up using flush queues for drivers
   which are aware of them and can actually benefit.
 - Allows us to handle flush queue init failure by falling back
   to strict mode instead of leaving it to possibly blow up later.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  2 +-
 drivers/iommu/arm/arm-smmu/arm-smmu.c       |  2 +-
 drivers/iommu/dma-iommu.c                   | 10 ++++++----
 drivers/iommu/iommu.c                       | 14 ++++----------
 include/linux/iommu.h                       |  1 -
 5 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index fa41026d272e..260b560d0075 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2175,7 +2175,7 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain,
 		.iommu_dev	= smmu->dev,
 	};
 
-	if (!iommu_get_dma_strict(domain))
+	if (domain->type == IOMMU_DOMAIN_DMA_FQ)
 		pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_NON_STRICT;
 
 	pgtbl_ops = alloc_io_pgtable_ops(fmt, &pgtbl_cfg, smmu_domain);
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index dbc14c265b15..2c717f3be056 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -765,7 +765,7 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 		.iommu_dev	= smmu->dev,
 	};
 
-	if (!iommu_get_dma_strict(domain))
+	if (domain->type == IOMMU_DOMAIN_DMA_FQ)
 		pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_NON_STRICT;
 
 	if (smmu->impl && smmu->impl->init_context) {
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index b1af1ff324c5..a114a7ad88ec 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -363,13 +363,15 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 
 	init_iova_domain(iovad, 1UL << order, base_pfn);
 
-	if (!cookie->fq_domain && !dev_is_untrusted(dev) &&
-	    domain->ops->flush_iotlb_all && !iommu_get_dma_strict(domain)) {
+	if (domain->type == IOMMU_DOMAIN_DMA_FQ && !cookie->fq_domain &&
+	    domain->ops->flush_iotlb_all) {
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
index 8333c334891e..d7eaacae0944 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -135,6 +135,9 @@ static int __init iommu_subsys_init(void)
 		}
 	}
 
+	if (!iommu_default_passthrough() && !iommu_dma_strict)
+		iommu_def_domain_type = IOMMU_DOMAIN_DMA_FQ;
+
 	pr_info("Default domain type: %s %s\n",
 		iommu_domain_type_str(iommu_def_domain_type),
 		(iommu_cmd_line & IOMMU_CMD_LINE_DMA_API) ?
@@ -352,15 +355,6 @@ void iommu_set_dma_strict(bool strict)
 		iommu_dma_strict = strict;
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
@@ -764,7 +758,7 @@ static int iommu_create_device_direct_mappings(struct iommu_group *group,
 	unsigned long pg_size;
 	int ret = 0;
 
-	if (!domain || domain->type != IOMMU_DOMAIN_DMA)
+	if (!domain || !(domain->type & __IOMMU_DOMAIN_DMA_API))
 		return 0;
 
 	BUG_ON(!domain->pgsize_bitmap);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 56519110d43f..557c4c12e2cf 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -484,7 +484,6 @@ int iommu_set_pgtable_quirks(struct iommu_domain *domain,
 		unsigned long quirks);
 
 void iommu_set_dma_strict(bool val);
-bool iommu_get_dma_strict(struct iommu_domain *domain);
 
 extern int report_iommu_fault(struct iommu_domain *domain, struct device *dev,
 			      unsigned long iova, int flags);
-- 
2.25.1

