Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 395533E90AD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 14:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238162AbhHKMXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 08:23:53 -0400
Received: from foss.arm.com ([217.140.110.172]:48758 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237817AbhHKMXD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 08:23:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2BD2E13A1;
        Wed, 11 Aug 2021 05:22:40 -0700 (PDT)
Received: from 010265703453.arm.com (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E8C283F718;
        Wed, 11 Aug 2021 05:22:37 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will@kernel.org
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        suravee.suthikulpanit@amd.com, baolu.lu@linux.intel.com,
        john.garry@huawei.com, dianders@chromium.org, rajatja@google.com,
        chenxiang66@hisilicon.com
Subject: [PATCH v4 24/24] iommu: Allow enabling non-strict mode dynamically
Date:   Wed, 11 Aug 2021 13:21:38 +0100
Message-Id: <d652966348c78457c38bf18daf369272a4ebc2c9.1628682049.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1628682048.git.robin.murphy@arm.com>
References: <cover.1628682048.git.robin.murphy@arm.com>
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

Signed-off-by: Robin Murphy <robin.murphy@arm.com>

---

v3: Actually think about concurrency, rework most of the fq data
    accesses to be (hopefully) safe and comment it all

v4: Squash in simplified iommu_dma_init_fq() refactor, clean up previous
    barrier from init_iova_flush_queue(), drop rogue header change
    (turns out there's a whole other rabbit hole of iova_fq cleanup to
    venture down after this...)

---
 drivers/iommu/dma-iommu.c | 47 ++++++++++++++++++++++++++-------------
 drivers/iommu/iommu.c     | 17 ++++++++++----
 drivers/iommu/iova.c      | 11 ++++-----
 include/linux/dma-iommu.h |  6 +++++
 4 files changed, 57 insertions(+), 24 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 01fa83229118..27f98a29f49a 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -310,6 +310,30 @@ static bool dev_is_untrusted(struct device *dev)
 	return dev_is_pci(dev) && to_pci_dev(dev)->untrusted;
 }
 
+/* sysfs updates are serialised by the mutex of the group owning @domain */
+int iommu_dma_init_fq(struct iommu_domain *domain)
+{
+	struct iommu_dma_cookie *cookie = domain->iova_cookie;
+	int ret;
+
+	if (cookie->fq_domain)
+		return 0;
+
+	ret = init_iova_flush_queue(&cookie->iovad, iommu_dma_flush_iotlb_all,
+				    iommu_dma_entry_dtor);
+	if (ret) {
+		pr_warn("iova flush queue initialization failed\n");
+		return ret;
+	}
+	/*
+	 * Prevent incomplete iovad->fq being observable. Pairs with path from
+	 * __iommu_dma_unmap() through iommu_dma_free_iova() to queue_iova()
+	 */
+	smp_wmb();
+	WRITE_ONCE(cookie->fq_domain, domain);
+	return 0;
+}
+
 /**
  * iommu_dma_init_domain - Initialise a DMA mapping domain
  * @domain: IOMMU domain previously prepared by iommu_get_dma_cookie()
@@ -364,15 +388,8 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 	init_iova_domain(iovad, 1UL << order, base_pfn);
 
 	/* If the FQ fails we can simply fall back to strict mode */
-	if (domain->type == IOMMU_DOMAIN_DMA_FQ && !cookie->fq_domain) {
-		if (init_iova_flush_queue(iovad, iommu_dma_flush_iotlb_all,
-					  iommu_dma_entry_dtor)) {
-			pr_warn("iova flush queue initialization failed\n");
-			domain->type = IOMMU_DOMAIN_DMA;
-		} else {
-			cookie->fq_domain = domain;
-		}
-	}
+	if (domain->type == IOMMU_DOMAIN_DMA_FQ && iommu_dma_init_fq(domain))
+		domain->type = IOMMU_DOMAIN_DMA;
 
 	return iova_reserve_iommu_regions(dev, domain);
 }
@@ -447,17 +464,17 @@ static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
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
@@ -476,14 +493,14 @@ static void __iommu_dma_unmap(struct device *dev, dma_addr_t dma_addr,
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
index 480ad6a538a9..135d274d6d9f 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3203,6 +3203,14 @@ static int iommu_change_dev_def_domain(struct iommu_group *group,
 		goto out;
 	}
 
+	/* We can bring up a flush queue without tearing down the domain */
+	if (type == IOMMU_DOMAIN_DMA_FQ && prev_dom->type == IOMMU_DOMAIN_DMA) {
+		ret = iommu_dma_init_fq(prev_dom);
+		if (!ret)
+			prev_dom->type = IOMMU_DOMAIN_DMA_FQ;
+		goto out;
+	}
+
 	/* Sets group->default_domain to the newly allocated domain */
 	ret = iommu_group_alloc_default_domain(dev->bus, group, type);
 	if (ret)
@@ -3243,9 +3251,9 @@ static int iommu_change_dev_def_domain(struct iommu_group *group,
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
@@ -3321,7 +3329,8 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
 
 	/* Check if the device in the group still has a driver bound to it */
 	device_lock(dev);
-	if (device_is_bound(dev)) {
+	if (device_is_bound(dev) && !(req_type == IOMMU_DOMAIN_DMA_FQ &&
+	    group->default_domain->type == IOMMU_DOMAIN_DMA)) {
 		pr_err_ratelimited("Device is still bound to driver\n");
 		ret = -EBUSY;
 		goto out;
diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 2ad73fb2e94e..0af42fb93a49 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -121,8 +121,6 @@ int init_iova_flush_queue(struct iova_domain *iovad,
 		spin_lock_init(&fq->lock);
 	}
 
-	smp_wmb();
-
 	iovad->fq = queue;
 
 	timer_setup(&iovad->fq_timer, fq_flush_timeout, 0);
@@ -633,17 +631,20 @@ void queue_iova(struct iova_domain *iovad,
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
diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
index 758ca4694257..24607dc3c2ac 100644
--- a/include/linux/dma-iommu.h
+++ b/include/linux/dma-iommu.h
@@ -20,6 +20,7 @@ void iommu_put_dma_cookie(struct iommu_domain *domain);
 
 /* Setup call for arch DMA mapping code */
 void iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 dma_limit);
+int iommu_dma_init_fq(struct iommu_domain *domain);
 
 /* The DMA API isn't _quite_ the whole story, though... */
 /*
@@ -54,6 +55,11 @@ static inline void iommu_setup_dma_ops(struct device *dev, u64 dma_base,
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

