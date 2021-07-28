Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89F6D3D929E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 17:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237542AbhG1P7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 11:59:51 -0400
Received: from foss.arm.com ([217.140.110.172]:59444 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237463AbhG1P7c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 11:59:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD7C511B3;
        Wed, 28 Jul 2021 08:59:30 -0700 (PDT)
Received: from 010265703453.arm.com (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 693083F70D;
        Wed, 28 Jul 2021 08:59:29 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will@kernel.org
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        suravee.suthikulpanit@amd.com, baolu.lu@linux.intel.com,
        john.garry@huawei.com, dianders@chromium.org
Subject: [PATCH v2 14/24] iommu: Introduce explicit type for non-strict DMA domains
Date:   Wed, 28 Jul 2021 16:58:35 +0100
Message-Id: <59a4d350c32a83e21de5dcfe6f041f38b0c35b82.1627468309.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1627468308.git.robin.murphy@arm.com>
References: <cover.1627468308.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Promote the difference between strict and non-strict DMA domains from an
internal detail to a distinct domain feature and type, to pave the road
for exposing it through the sysfs default domain interface.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/dma-iommu.c |  2 +-
 drivers/iommu/iommu.c     |  8 ++++++--
 include/linux/iommu.h     | 11 +++++++++++
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index e28396cea6eb..8b3545c01077 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1311,7 +1311,7 @@ void iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 dma_limit)
 	 * The IOMMU core code allocates the default DMA domain, which the
 	 * underlying IOMMU driver needs to support via the dma-iommu layer.
 	 */
-	if (domain->type == IOMMU_DOMAIN_DMA) {
+	if (iommu_is_dma_domain(domain)) {
 		if (iommu_dma_init_domain(domain, dma_base, dma_limit, dev))
 			goto out_err;
 		dev->dma_ops = &iommu_dma_ops;
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index fa8109369f74..982545234cf3 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -115,6 +115,7 @@ static const char *iommu_domain_type_str(unsigned int t)
 	case IOMMU_DOMAIN_UNMANAGED:
 		return "Unmanaged";
 	case IOMMU_DOMAIN_DMA:
+	case IOMMU_DOMAIN_DMA_FQ:
 		return "Translated";
 	default:
 		return "Unknown";
@@ -552,6 +553,9 @@ static ssize_t iommu_group_show_type(struct iommu_group *group,
 		case IOMMU_DOMAIN_DMA:
 			type = "DMA\n";
 			break;
+		case IOMMU_DOMAIN_DMA_FQ:
+			type = "DMA-FQ\n";
+			break;
 		}
 	}
 	mutex_unlock(&group->mutex);
@@ -765,7 +769,7 @@ static int iommu_create_device_direct_mappings(struct iommu_group *group,
 	unsigned long pg_size;
 	int ret = 0;
 
-	if (!domain || domain->type != IOMMU_DOMAIN_DMA)
+	if (!domain || !iommu_is_dma_domain(domain))
 		return 0;
 
 	BUG_ON(!domain->pgsize_bitmap);
@@ -1947,7 +1951,7 @@ static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
 	/* Assume all sizes by default; the driver may override this later */
 	domain->pgsize_bitmap  = bus->iommu_ops->pgsize_bitmap;
 
-	if (type == IOMMU_DOMAIN_DMA && iommu_get_dma_cookie(domain)) {
+	if (iommu_is_dma_domain(domain) && iommu_get_dma_cookie(domain)) {
 		iommu_domain_free(domain);
 		domain = NULL;
 	}
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 141779d76035..046ba4d54cd2 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -61,6 +61,7 @@ struct iommu_domain_geometry {
 #define __IOMMU_DOMAIN_DMA_API	(1U << 1)  /* Domain for use in DMA-API
 					      implementation              */
 #define __IOMMU_DOMAIN_PT	(1U << 2)  /* Domain is identity mapped   */
+#define __IOMMU_DOMAIN_DMA_FQ	(1U << 3)  /* DMA-API uses flush queue    */
 
 /*
  * This are the possible domain-types
@@ -73,12 +74,17 @@ struct iommu_domain_geometry {
  *	IOMMU_DOMAIN_DMA	- Internally used for DMA-API implementations.
  *				  This flag allows IOMMU drivers to implement
  *				  certain optimizations for these domains
+ *	IOMMU_DOMAIN_DMA_FQ	- As above, but definitely using batched TLB
+ *				  invalidation.
  */
 #define IOMMU_DOMAIN_BLOCKED	(0U)
 #define IOMMU_DOMAIN_IDENTITY	(__IOMMU_DOMAIN_PT)
 #define IOMMU_DOMAIN_UNMANAGED	(__IOMMU_DOMAIN_PAGING)
 #define IOMMU_DOMAIN_DMA	(__IOMMU_DOMAIN_PAGING |	\
 				 __IOMMU_DOMAIN_DMA_API)
+#define IOMMU_DOMAIN_DMA_FQ	(__IOMMU_DOMAIN_PAGING |	\
+				 __IOMMU_DOMAIN_DMA_API |	\
+				 __IOMMU_DOMAIN_DMA_FQ)
 
 struct iommu_domain {
 	unsigned type;
@@ -90,6 +96,11 @@ struct iommu_domain {
 	struct iommu_dma_cookie *iova_cookie;
 };
 
+static inline bool iommu_is_dma_domain(struct iommu_domain *domain)
+{
+	return domain->type & __IOMMU_DOMAIN_DMA_API;
+}
+
 enum iommu_cap {
 	IOMMU_CAP_CACHE_COHERENCY,	/* IOMMU can enforce cache coherent DMA
 					   transactions */
-- 
2.25.1

