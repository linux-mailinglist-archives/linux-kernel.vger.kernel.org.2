Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B41ED3E068B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 19:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240002AbhHDRRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 13:17:07 -0400
Received: from foss.arm.com ([217.140.110.172]:35040 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239916AbhHDRQr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 13:16:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ECA6411FB;
        Wed,  4 Aug 2021 10:16:33 -0700 (PDT)
Received: from 010265703453.arm.com (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 174D23F66F;
        Wed,  4 Aug 2021 10:16:31 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will@kernel.org
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        suravee.suthikulpanit@amd.com, baolu.lu@linux.intel.com,
        john.garry@huawei.com, dianders@chromium.org, rajatja@google.com,
        chenxiang66@hisilicon.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v3 12/25] iommu/dma: Unexport IOVA cookie management
Date:   Wed,  4 Aug 2021 18:15:40 +0100
Message-Id: <9c989539c8465bdb34fd2f2eb49773b0b76655dd.1628094601.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1628094600.git.robin.murphy@arm.com>
References: <cover.1628094600.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IOVA cookies are now got and put by core code, so we no longer need to
export these to modular drivers. The export for getting MSI cookies
stays, since VFIO can still be a module, but it was already relying on
someone else putting them, so that aspect is unaffected.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/dma-iommu.c | 7 -------
 drivers/iommu/iommu.c     | 3 +--
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 98ba927aee1a..10067fbc4309 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -98,9 +98,6 @@ static struct iommu_dma_cookie *cookie_alloc(enum iommu_dma_cookie_type type)
 /**
  * iommu_get_dma_cookie - Acquire DMA-API resources for a domain
  * @domain: IOMMU domain to prepare for DMA-API usage
- *
- * IOMMU drivers should normally call this from their domain_alloc
- * callback when domain->type == IOMMU_DOMAIN_DMA.
  */
 int iommu_get_dma_cookie(struct iommu_domain *domain)
 {
@@ -113,7 +110,6 @@ int iommu_get_dma_cookie(struct iommu_domain *domain)
 
 	return 0;
 }
-EXPORT_SYMBOL(iommu_get_dma_cookie);
 
 /**
  * iommu_get_msi_cookie - Acquire just MSI remapping resources
@@ -151,8 +147,6 @@ EXPORT_SYMBOL(iommu_get_msi_cookie);
  * iommu_put_dma_cookie - Release a domain's DMA mapping resources
  * @domain: IOMMU domain previously prepared by iommu_get_dma_cookie() or
  *          iommu_get_msi_cookie()
- *
- * IOMMU drivers should normally call this from their domain_free callback.
  */
 void iommu_put_dma_cookie(struct iommu_domain *domain)
 {
@@ -172,7 +166,6 @@ void iommu_put_dma_cookie(struct iommu_domain *domain)
 	kfree(cookie);
 	domain->iova_cookie = NULL;
 }
-EXPORT_SYMBOL(iommu_put_dma_cookie);
 
 /**
  * iommu_dma_get_resv_regions - Reserved region driver helper
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index b65fcc66ffa4..fa8109369f74 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1947,8 +1947,7 @@ static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
 	/* Assume all sizes by default; the driver may override this later */
 	domain->pgsize_bitmap  = bus->iommu_ops->pgsize_bitmap;
 
-	/* Temporarily avoid -EEXIST while drivers still get their own cookies */
-	if (type == IOMMU_DOMAIN_DMA && !domain->iova_cookie && iommu_get_dma_cookie(domain)) {
+	if (type == IOMMU_DOMAIN_DMA && iommu_get_dma_cookie(domain)) {
 		iommu_domain_free(domain);
 		domain = NULL;
 	}
-- 
2.25.1

