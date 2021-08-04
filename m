Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E68D3E069B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 19:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239819AbhHDRRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 13:17:44 -0400
Received: from foss.arm.com ([217.140.110.172]:35350 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240032AbhHDRRN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 13:17:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6166D14FF;
        Wed,  4 Aug 2021 10:17:00 -0700 (PDT)
Received: from 010265703453.arm.com (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 81E443F66F;
        Wed,  4 Aug 2021 10:16:58 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will@kernel.org
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        suravee.suthikulpanit@amd.com, baolu.lu@linux.intel.com,
        john.garry@huawei.com, dianders@chromium.org, rajatja@google.com,
        chenxiang66@hisilicon.com,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Subject: [PATCH v3 25/25] iommu: Allow enabling non-strict mode dynamically
Date:   Wed,  4 Aug 2021 18:15:53 +0100
Message-Id: <22b044263f69e2bfe404c4379a435005ea58b3e2.1628094601.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1628094600.git.robin.murphy@arm.com>
References: <cover.1628094600.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allocating and enabling a flush queue is in fact something we can
reasonably do while a DMA domain is active, without having to rebuild it
from scratch. Thus we can allow a strict -> non-strict transition from
sysfs without requiring to unbind the device's driver, which is of
particular interest to users who want to make selective relaxations to
critical devices like the one serving their root filesystem.

Disabling and draining a queue also seems technically possible to
achieve without rebuilding the whole domain, but would certainly be more
involved. Furthermore there's not such a clear use-case for tightening
up security *after* the device may already have done whatever it is that
you don't trust it not to do, so we only consider the relaxation case.

CC: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>

---

v3: Actually think about concurrency, rework most of the fq data
    accesses to be (hopefully) safe and comment it all
---
 drivers/iommu/dma-iommu.c | 25 ++++++++++++++++++-------
 drivers/iommu/iommu.c     | 16 ++++++++++++----
 drivers/iommu/iova.c      |  9 ++++++---
 3 files changed, 36 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index f51b8dc99ac6..6b04dc765d91 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -310,6 +310,12 @@ static bool dev_is_untrusted(struct device *dev)
 	return dev_is_pci(dev) && to_pci_dev(dev)->untrusted;
 }
 
+/*
+ * Protected from concurrent sysfs updates by the mutex of the group who owns
+ * this domain. At worst it might theoretically be able to allocate two queues
+ * and leak one if you poke sysfs to race just right with iommu_setup_dma_ops()
+ * running for the first device in the group. Don't do that.
+ */
 int iommu_dma_init_fq(struct iommu_domain *domain)
 {
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
@@ -325,7 +331,12 @@ int iommu_dma_init_fq(struct iommu_domain *domain)
 		domain->type = IOMMU_DOMAIN_DMA;
 		return -ENODEV;
 	}
-	cookie->fq_domain = domain;
+	/*
+	 * Prevent incomplete iovad->fq being observable. Pairs with path from
+	 * __iommu_dma_unmap() through iommu_dma_free_iova() to queue_iova()
+	 */
+	smp_wmb();
+	WRITE_ONCE(cookie->fq_domain, domain);
 	return 0;
 }
 
@@ -456,17 +467,17 @@ static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
 }
 
 static void iommu_dma_free_iova(struct iommu_dma_cookie *cookie,
-		dma_addr_t iova, size_t size, struct page *freelist)
+		dma_addr_t iova, size_t size, struct iommu_iotlb_gather *gather)
 {
 	struct iova_domain *iovad = &cookie->iovad;
 
 	/* The MSI case is only ever cleaning up its most recent allocation */
 	if (cookie->type == IOMMU_DMA_MSI_COOKIE)
 		cookie->msi_iova -= size;
-	else if (cookie->fq_domain)	/* non-strict mode */
+	else if (gather && gather->queued)
 		queue_iova(iovad, iova_pfn(iovad, iova),
 				size >> iova_shift(iovad),
-				(unsigned long)freelist);
+				(unsigned long)gather->freelist);
 	else
 		free_iova_fast(iovad, iova_pfn(iovad, iova),
 				size >> iova_shift(iovad));
@@ -485,14 +496,14 @@ static void __iommu_dma_unmap(struct device *dev, dma_addr_t dma_addr,
 	dma_addr -= iova_off;
 	size = iova_align(iovad, size + iova_off);
 	iommu_iotlb_gather_init(&iotlb_gather);
-	iotlb_gather.queued = cookie->fq_domain;
+	iotlb_gather.queued = READ_ONCE(cookie->fq_domain);
 
 	unmapped = iommu_unmap_fast(domain, dma_addr, size, &iotlb_gather);
 	WARN_ON(unmapped != size);
 
-	if (!cookie->fq_domain)
+	if (!iotlb_gather.queued)
 		iommu_iotlb_sync(domain, &iotlb_gather);
-	iommu_dma_free_iova(cookie, dma_addr, size, iotlb_gather.freelist);
+	iommu_dma_free_iova(cookie, dma_addr, size, &iotlb_gather);
 }
 
 static void __iommu_dma_unmap_swiotlb(struct device *dev, dma_addr_t dma_addr,
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 480ad6a538a9..593d4555bc57 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3203,6 +3203,13 @@ static int iommu_change_dev_def_domain(struct iommu_group *group,
 		goto out;
 	}
 
+	/* We can bring up a flush queue without tearing down the domain */
+	if (type == IOMMU_DOMAIN_DMA_FQ && prev_dom->type == IOMMU_DOMAIN_DMA) {
+		prev_dom->type = IOMMU_DOMAIN_DMA_FQ;
+		ret = iommu_dma_init_fq(prev_dom);
+		goto out;
+	}
+
 	/* Sets group->default_domain to the newly allocated domain */
 	ret = iommu_group_alloc_default_domain(dev->bus, group, type);
 	if (ret)
@@ -3243,9 +3250,9 @@ static int iommu_change_dev_def_domain(struct iommu_group *group,
 }
 
 /*
- * Changing the default domain through sysfs requires the users to ubind the
- * drivers from the devices in the iommu group. Return failure if this doesn't
- * meet.
+ * Changing the default domain through sysfs requires the users to unbind the
+ * drivers from the devices in the iommu group, except for a DMA -> DMA-FQ
+ * transition. Return failure if this isn't met.
  *
  * We need to consider the race between this and the device release path.
  * device_lock(dev) is used here to guarantee that the device release path
@@ -3321,7 +3328,8 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
 
 	/* Check if the device in the group still has a driver bound to it */
 	device_lock(dev);
-	if (device_is_bound(dev)) {
+	if (device_is_bound(dev) && !(req_type == IOMMU_DOMAIN_DMA_FQ &&
+	    group->default_domain->type == IOMMU_DOMAIN_DMA)) {
 		pr_err_ratelimited("Device is still bound to driver\n");
 		ret = -EBUSY;
 		goto out;
diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 2ad73fb2e94e..547b6243de9b 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -633,17 +633,20 @@ void queue_iova(struct iova_domain *iovad,
 		unsigned long pfn, unsigned long pages,
 		unsigned long data)
 {
-	struct iova_fq *fq = raw_cpu_ptr(iovad->fq);
+	struct iova_fq *fq;
 	unsigned long flags;
 	unsigned idx;
 
 	/*
 	 * Order against the IOMMU driver's pagetable update from unmapping
 	 * @pte, to guarantee that iova_domain_flush() observes that if called
-	 * from a different CPU before we release the lock below.
+	 * from a different CPU before we release the lock below. Full barrier
+	 * so it also pairs with iommu_dma_init_fq() to avoid seeing partially
+	 * written fq state here.
 	 */
-	smp_wmb();
+	smp_mb();
 
+	fq = raw_cpu_ptr(iovad->fq);
 	spin_lock_irqsave(&fq->lock, flags);
 
 	/*
-- 
2.25.1

