Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84DB43E9076
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 14:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237712AbhHKMWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 08:22:30 -0400
Received: from foss.arm.com ([217.140.110.172]:48634 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237611AbhHKMWX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 08:22:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB72E106F;
        Wed, 11 Aug 2021 05:21:59 -0700 (PDT)
Received: from 010265703453.arm.com (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1C5DD3F718;
        Wed, 11 Aug 2021 05:21:57 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will@kernel.org
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        suravee.suthikulpanit@amd.com, baolu.lu@linux.intel.com,
        john.garry@huawei.com, dianders@chromium.org, rajatja@google.com,
        chenxiang66@hisilicon.com,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v4 05/24] iommu/exynos: Drop IOVA cookie management
Date:   Wed, 11 Aug 2021 13:21:19 +0100
Message-Id: <12d88cbf44e57faa4f0512760e7ed3a9cba05ca8.1628682048.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1628682048.git.robin.murphy@arm.com>
References: <cover.1628682048.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The core code bakes its own cookies now.

Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>

---

v3: Also remove unneeded include
---
 drivers/iommu/exynos-iommu.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index d0fbf1d10e18..939ffa768986 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -21,7 +21,6 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
-#include <linux/dma-iommu.h>
 
 typedef u32 sysmmu_iova_t;
 typedef u32 sysmmu_pte_t;
@@ -735,20 +734,16 @@ static struct iommu_domain *exynos_iommu_domain_alloc(unsigned type)
 	/* Check if correct PTE offsets are initialized */
 	BUG_ON(PG_ENT_SHIFT < 0 || !dma_dev);
 
+	if (type != IOMMU_DOMAIN_DMA && type != IOMMU_DOMAIN_UNMANAGED)
+		return NULL;
+
 	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
 	if (!domain)
 		return NULL;
 
-	if (type == IOMMU_DOMAIN_DMA) {
-		if (iommu_get_dma_cookie(&domain->domain) != 0)
-			goto err_pgtable;
-	} else if (type != IOMMU_DOMAIN_UNMANAGED) {
-		goto err_pgtable;
-	}
-
 	domain->pgtable = (sysmmu_pte_t *)__get_free_pages(GFP_KERNEL, 2);
 	if (!domain->pgtable)
-		goto err_dma_cookie;
+		goto err_pgtable;
 
 	domain->lv2entcnt = (short *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, 1);
 	if (!domain->lv2entcnt)
@@ -779,9 +774,6 @@ static struct iommu_domain *exynos_iommu_domain_alloc(unsigned type)
 	free_pages((unsigned long)domain->lv2entcnt, 1);
 err_counter:
 	free_pages((unsigned long)domain->pgtable, 2);
-err_dma_cookie:
-	if (type == IOMMU_DOMAIN_DMA)
-		iommu_put_dma_cookie(&domain->domain);
 err_pgtable:
 	kfree(domain);
 	return NULL;
@@ -809,9 +801,6 @@ static void exynos_iommu_domain_free(struct iommu_domain *iommu_domain)
 
 	spin_unlock_irqrestore(&domain->lock, flags);
 
-	if (iommu_domain->type == IOMMU_DOMAIN_DMA)
-		iommu_put_dma_cookie(iommu_domain);
-
 	dma_unmap_single(dma_dev, virt_to_phys(domain->pgtable), LV1TABLE_SIZE,
 			 DMA_TO_DEVICE);
 
-- 
2.25.1

