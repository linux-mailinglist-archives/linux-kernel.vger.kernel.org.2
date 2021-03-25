Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55C06349215
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 13:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbhCYMeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 08:34:25 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14539 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbhCYMeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 08:34:18 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F5kxW0PL9zPllv;
        Thu, 25 Mar 2021 20:31:43 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Thu, 25 Mar 2021 20:34:07 +0800
From:   John Garry <john.garry@huawei.com>
To:     <joro@8bytes.org>, <will@kernel.org>, <dwmw2@infradead.org>,
        <baolu.lu@linux.intel.com>, <robin.murphy@arm.com>
CC:     <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH v2 3/4] iommu: Delete iommu_dma_free_cpu_cached_iovas()
Date:   Thu, 25 Mar 2021 20:30:00 +0800
Message-ID: <1616675401-151997-4-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1616675401-151997-1-git-send-email-john.garry@huawei.com>
References: <1616675401-151997-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function iommu_dma_free_cpu_cached_iovas() no longer has any caller, so
delete it.

With that, function free_cpu_cached_iovas() may be made static.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/iommu/dma-iommu.c | 9 ---------
 drivers/iommu/iova.c      | 3 ++-
 include/linux/dma-iommu.h | 8 --------
 include/linux/iova.h      | 5 -----
 4 files changed, 2 insertions(+), 23 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index af765c813cc8..9da7e9901bec 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -53,15 +53,6 @@ struct iommu_dma_cookie {
 
 static DEFINE_STATIC_KEY_FALSE(iommu_deferred_attach_enabled);
 
-void iommu_dma_free_cpu_cached_iovas(unsigned int cpu,
-		struct iommu_domain *domain)
-{
-	struct iommu_dma_cookie *cookie = domain->iova_cookie;
-	struct iova_domain *iovad = &cookie->iovad;
-
-	free_cpu_cached_iovas(cpu, iovad);
-}
-
 static void iommu_dma_entry_dtor(unsigned long data)
 {
 	struct page *freelist = (struct page *)data;
diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index c78312560425..8a493ee92c79 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -22,6 +22,7 @@ static unsigned long iova_rcache_get(struct iova_domain *iovad,
 				     unsigned long size,
 				     unsigned long limit_pfn);
 static void init_iova_rcaches(struct iova_domain *iovad);
+static void free_cpu_cached_iovas(unsigned int cpu, struct iova_domain *iovad);
 static void free_iova_rcaches(struct iova_domain *iovad);
 static void fq_destroy_all_entries(struct iova_domain *iovad);
 static void fq_flush_timeout(struct timer_list *t);
@@ -998,7 +999,7 @@ static void free_iova_rcaches(struct iova_domain *iovad)
 /*
  * free all the IOVA ranges cached by a cpu (used when cpu is unplugged)
  */
-void free_cpu_cached_iovas(unsigned int cpu, struct iova_domain *iovad)
+static void free_cpu_cached_iovas(unsigned int cpu, struct iova_domain *iovad)
 {
 	struct iova_cpu_rcache *cpu_rcache;
 	struct iova_rcache *rcache;
diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
index 706b68d1359b..2112f21f73d8 100644
--- a/include/linux/dma-iommu.h
+++ b/include/linux/dma-iommu.h
@@ -37,9 +37,6 @@ void iommu_dma_compose_msi_msg(struct msi_desc *desc,
 
 void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list);
 
-void iommu_dma_free_cpu_cached_iovas(unsigned int cpu,
-		struct iommu_domain *domain);
-
 #else /* CONFIG_IOMMU_DMA */
 
 struct iommu_domain;
@@ -81,10 +78,5 @@ static inline void iommu_dma_get_resv_regions(struct device *dev, struct list_he
 {
 }
 
-static inline void iommu_dma_free_cpu_cached_iovas(unsigned int cpu,
-		struct iommu_domain *domain)
-{
-}
-
 #endif	/* CONFIG_IOMMU_DMA */
 #endif	/* __DMA_IOMMU_H */
diff --git a/include/linux/iova.h b/include/linux/iova.h
index 4be6c0ab4997..71d8a2de6635 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -157,7 +157,6 @@ int init_iova_flush_queue(struct iova_domain *iovad,
 			  iova_flush_cb flush_cb, iova_entry_dtor entry_dtor);
 struct iova *find_iova(struct iova_domain *iovad, unsigned long pfn);
 void put_iova_domain(struct iova_domain *iovad);
-void free_cpu_cached_iovas(unsigned int cpu, struct iova_domain *iovad);
 #else
 static inline int iova_cache_get(void)
 {
@@ -234,10 +233,6 @@ static inline void put_iova_domain(struct iova_domain *iovad)
 {
 }
 
-static inline void free_cpu_cached_iovas(unsigned int cpu,
-					 struct iova_domain *iovad)
-{
-}
 #endif
 
 #endif
-- 
2.26.2

