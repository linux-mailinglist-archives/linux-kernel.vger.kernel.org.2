Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C02773E0699
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 19:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239800AbhHDRRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 13:17:38 -0400
Received: from foss.arm.com ([217.140.110.172]:35322 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239965AbhHDRRL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 13:17:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 410FD1063;
        Wed,  4 Aug 2021 10:16:58 -0700 (PDT)
Received: from 010265703453.arm.com (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 83E653F66F;
        Wed,  4 Aug 2021 10:16:56 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will@kernel.org
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        suravee.suthikulpanit@amd.com, baolu.lu@linux.intel.com,
        john.garry@huawei.com, dianders@chromium.org, rajatja@google.com,
        chenxiang66@hisilicon.com
Subject: [PATCH v3 24/25] iommu/dma: Factor out flush queue init
Date:   Wed,  4 Aug 2021 18:15:52 +0100
Message-Id: <3b5284ee394f267ba966839173f874fc9a996bb2.1628094601.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1628094600.git.robin.murphy@arm.com>
References: <cover.1628094600.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Factor out flush queue setup from the initial domain init so that we
can potentially trigger it from sysfs later on in a domain's lifetime.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: John Garry <john.garry@huawei.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/dma-iommu.c | 30 ++++++++++++++++++++----------
 include/linux/dma-iommu.h |  9 ++++++---
 2 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 2e19505dddf9..f51b8dc99ac6 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -310,6 +310,25 @@ static bool dev_is_untrusted(struct device *dev)
 	return dev_is_pci(dev) && to_pci_dev(dev)->untrusted;
 }
 
+int iommu_dma_init_fq(struct iommu_domain *domain)
+{
+	struct iommu_dma_cookie *cookie = domain->iova_cookie;
+
+	if (domain->type != IOMMU_DOMAIN_DMA_FQ)
+		return -EINVAL;
+	if (cookie->fq_domain)
+		return 0;
+
+	if (init_iova_flush_queue(&cookie->iovad, iommu_dma_flush_iotlb_all,
+				  iommu_dma_entry_dtor)) {
+		pr_warn("iova flush queue initialization failed\n");
+		domain->type = IOMMU_DOMAIN_DMA;
+		return -ENODEV;
+	}
+	cookie->fq_domain = domain;
+	return 0;
+}
+
 /**
  * iommu_dma_init_domain - Initialise a DMA mapping domain
  * @domain: IOMMU domain previously prepared by iommu_get_dma_cookie()
@@ -362,16 +381,7 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 	}
 
 	init_iova_domain(iovad, 1UL << order, base_pfn);
-
-	if (domain->type == IOMMU_DOMAIN_DMA_FQ && !cookie->fq_domain) {
-		if (init_iova_flush_queue(iovad, iommu_dma_flush_iotlb_all,
-					  iommu_dma_entry_dtor)) {
-			pr_warn("iova flush queue initialization failed\n");
-			domain->type = IOMMU_DOMAIN_DMA;
-		} else {
-			cookie->fq_domain = domain;
-		}
-	}
+	iommu_dma_init_fq(domain);
 
 	return iova_reserve_iommu_regions(dev, domain);
 }
diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
index 758ca4694257..81ab647f1618 100644
--- a/include/linux/dma-iommu.h
+++ b/include/linux/dma-iommu.h
@@ -20,6 +20,7 @@ void iommu_put_dma_cookie(struct iommu_domain *domain);
 
 /* Setup call for arch DMA mapping code */
 void iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 dma_limit);
+int iommu_dma_init_fq(struct iommu_domain *domain);
 
 /* The DMA API isn't _quite_ the whole story, though... */
 /*
@@ -37,9 +38,6 @@ void iommu_dma_compose_msi_msg(struct msi_desc *desc,
 
 void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list);
 
-void iommu_dma_free_cpu_cached_iovas(unsigned int cpu,
-		struct iommu_domain *domain);
-
 extern bool iommu_dma_forcedac;
 
 #else /* CONFIG_IOMMU_DMA */
@@ -54,6 +52,11 @@ static inline void iommu_setup_dma_ops(struct device *dev, u64 dma_base,
 {
 }
 
+static inline int iommu_dma_init_fq(struct iommu_domain *domain)
+{
+	return -EINVAL;
+}
+
 static inline int iommu_get_dma_cookie(struct iommu_domain *domain)
 {
 	return -ENODEV;
-- 
2.25.1

