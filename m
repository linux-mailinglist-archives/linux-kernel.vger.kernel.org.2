Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78A2E333844
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 10:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232724AbhCJJHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 04:07:22 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:13876 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232666AbhCJJGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 04:06:53 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DwR400JMQz8vtf;
        Wed, 10 Mar 2021 17:05:04 +0800 (CST)
Received: from DESKTOP-5IS4806.china.huawei.com (10.174.184.42) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.498.0; Wed, 10 Mar 2021 17:06:27 +0800
From:   Keqian Zhu <zhukeqian1@huawei.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Yi Sun <yi.y.sun@linux.intel.com>,
        Will Deacon <will@kernel.org>
CC:     Kirti Wankhede <kwankhede@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        <wanghaibin.wang@huawei.com>, <jiangkunkun@huawei.com>,
        <yuzenghui@huawei.com>, <lushenming@huawei.com>
Subject: [PATCH v2 10/11] vfio/iommu_type1: Optimize dirty bitmap population based on iommu HWDBM
Date:   Wed, 10 Mar 2021 17:06:13 +0800
Message-ID: <20210310090614.26668-11-zhukeqian1@huawei.com>
X-Mailer: git-send-email 2.8.4.windows.1
In-Reply-To: <20210310090614.26668-1-zhukeqian1@huawei.com>
References: <20210310090614.26668-1-zhukeqian1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.184.42]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: jiangkunkun <jiangkunkun@huawei.com>

In the past if vfio_iommu is not of pinned_page_dirty_scope and
vfio_dma is iommu_mapped, we populate full dirty bitmap for this
vfio_dma. Now we can try to get dirty log from iommu before make
the lousy decision.

In detail, if all vfio_group are of pinned_page_dirty_scope, the
dirty bitmap population is not affected. If there are vfio_groups
not of pinned_page_dirty_scope and their domains support HWDBM,
then we can try to get dirty log from IOMMU. Otherwise, lead to
full dirty bitmap.

We should start dirty log for newly added dma range and domain.

Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Kunkun Jiang <jiangkunkun@huawei.com>
---

changelog:

v2:
 - Use new interface to start|stop dirty log. As split_block|merge_page are related to ARM SMMU. (Sun Yi)
 - Bugfix: Start dirty log for newly added dma range and domain.
 
---
 drivers/vfio/vfio_iommu_type1.c | 136 +++++++++++++++++++++++++++++++-
 1 file changed, 132 insertions(+), 4 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 876351c061e4..a7ab0279eda0 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -1207,6 +1207,25 @@ static bool vfio_group_supports_hwdbm(struct vfio_group *group)
 					 vfio_dev_enable_feature);
 }
 
+static int vfio_iommu_dirty_log_clear(struct vfio_iommu *iommu,
+				      dma_addr_t start_iova, size_t size,
+				      unsigned long *bitmap_buffer,
+				      dma_addr_t base_iova, size_t pgsize)
+{
+	struct vfio_domain *d;
+	unsigned long pgshift = __ffs(pgsize);
+	int ret;
+
+	list_for_each_entry(d, &iommu->domain_list, next) {
+		ret = iommu_clear_dirty_log(d->domain, start_iova, size,
+					    bitmap_buffer, base_iova, pgshift);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int update_user_bitmap(u64 __user *bitmap, struct vfio_iommu *iommu,
 			      struct vfio_dma *dma, dma_addr_t base_iova,
 			      size_t pgsize)
@@ -1218,13 +1237,28 @@ static int update_user_bitmap(u64 __user *bitmap, struct vfio_iommu *iommu,
 	unsigned long shift = bit_offset % BITS_PER_LONG;
 	unsigned long leftover;
 
+	if (!iommu->num_non_pinned_groups || !dma->iommu_mapped)
+		goto bitmap_done;
+
+	/* try to get dirty log from IOMMU */
+	if (!iommu->num_non_hwdbm_groups) {
+		struct vfio_domain *d;
+
+		list_for_each_entry(d, &iommu->domain_list, next) {
+			if (iommu_sync_dirty_log(d->domain, dma->iova, dma->size,
+						dma->bitmap, dma->iova, pgshift))
+				return -EFAULT;
+		}
+		goto bitmap_done;
+	}
+
 	/*
 	 * mark all pages dirty if any IOMMU capable device is not able
 	 * to report dirty pages and all pages are pinned and mapped.
 	 */
-	if (iommu->num_non_pinned_groups && dma->iommu_mapped)
-		bitmap_set(dma->bitmap, 0, nbits);
+	bitmap_set(dma->bitmap, 0, nbits);
 
+bitmap_done:
 	if (shift) {
 		bitmap_shift_left(dma->bitmap, dma->bitmap, shift,
 				  nbits + shift);
@@ -1286,6 +1320,18 @@ static int vfio_iova_dirty_bitmap(u64 __user *bitmap, struct vfio_iommu *iommu,
 		 */
 		bitmap_clear(dma->bitmap, 0, dma->size >> pgshift);
 		vfio_dma_populate_bitmap(dma, pgsize);
+
+		/* Clear iommu dirty log to re-enable dirty log tracking */
+		if (!iommu->pinned_page_dirty_scope &&
+		    dma->iommu_mapped && !iommu->num_non_hwdbm_groups) {
+			ret = vfio_iommu_dirty_log_clear(iommu,	dma->iova,
+					dma->size, dma->bitmap, dma->iova,
+					pgsize);
+			if (ret) {
+				pr_warn("dma dirty log clear failed!\n");
+				return ret;
+			}
+		}
 	}
 	return 0;
 }
@@ -1561,6 +1607,9 @@ static bool vfio_iommu_iova_dma_valid(struct vfio_iommu *iommu,
 	return list_empty(iova);
 }
 
+static void vfio_dma_dirty_log_start(struct vfio_iommu *iommu,
+				     struct vfio_dma *dma);
+
 static int vfio_dma_do_map(struct vfio_iommu *iommu,
 			   struct vfio_iommu_type1_dma_map *map)
 {
@@ -1684,8 +1733,13 @@ static int vfio_dma_do_map(struct vfio_iommu *iommu,
 
 	if (!ret && iommu->dirty_page_tracking) {
 		ret = vfio_dma_bitmap_alloc(dma, pgsize);
-		if (ret)
+		if (ret) {
 			vfio_remove_dma(iommu, dma);
+			goto out_unlock;
+		}
+
+		/* Start dirty log for newly added dma */
+		vfio_dma_dirty_log_start(iommu, dma);
 	}
 
 out_unlock:
@@ -2262,6 +2316,9 @@ static void vfio_iommu_iova_insert_copy(struct vfio_iommu *iommu,
 	list_splice_tail(iova_copy, iova);
 }
 
+static void vfio_domain_dirty_log_start(struct vfio_iommu *iommu,
+					struct vfio_domain *d);
+
 static int vfio_iommu_type1_attach_group(void *iommu_data,
 					 struct iommu_group *iommu_group)
 {
@@ -2445,6 +2502,10 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 
 	list_add(&domain->next, &iommu->domain_list);
 	vfio_update_pgsize_bitmap(iommu);
+
+	/* Start dirty log for newly added vfio domain */
+	if (iommu->dirty_page_tracking)
+		vfio_domain_dirty_log_start(iommu, domain);
 done:
 	/* Delete the old one and insert new iova list */
 	vfio_iommu_iova_insert_copy(iommu, &iova_copy);
@@ -3022,6 +3083,70 @@ static int vfio_iommu_type1_unmap_dma(struct vfio_iommu *iommu,
 			-EFAULT : 0;
 }
 
+static void vfio_domain_dirty_log_start(struct vfio_iommu *iommu,
+					struct vfio_domain *d)
+{
+	struct rb_node *n;
+
+	/* Go through all dmas even if some dmas failed */
+	for (n = rb_first(&iommu->dma_list); n; n = rb_next(n)) {
+		struct vfio_dma *dma = rb_entry(n, struct vfio_dma, node);
+
+		if (!dma->iommu_mapped)
+			continue;
+
+		iommu_start_dirty_log(d->domain, dma->iova, dma->size);
+	}
+}
+
+static void vfio_dma_dirty_log_start(struct vfio_iommu *iommu,
+				     struct vfio_dma *dma)
+{
+	struct vfio_domain *d;
+
+	if (!dma->iommu_mapped)
+		return;
+
+	/* Go through all domains even if some domain failed */
+	list_for_each_entry(d, &iommu->domain_list, next) {
+		iommu_start_dirty_log(d->domain, dma->iova, dma->size);
+	}
+}
+
+static void vfio_dma_dirty_log_stop(struct vfio_iommu *iommu,
+				    struct vfio_dma *dma)
+{
+	struct vfio_domain *d;
+
+	if (!dma->iommu_mapped)
+		return;
+
+	/* Go through all domains even if some domain failed */
+	list_for_each_entry(d, &iommu->domain_list, next) {
+		iommu_stop_dirty_log(d->domain, dma->iova, dma->size,
+				     d->prot | dma->prot);
+	}
+}
+
+static void vfio_iommu_dirty_log_switch(struct vfio_iommu *iommu, bool start)
+{
+	struct rb_node *n;
+
+	/*
+	 * Go ahead even if all iommu domains don't support HWDBM for now, as
+	 * we can get dirty log from IOMMU when these domains without HWDBM
+	 * are detached.
+	 */
+	for (n = rb_first(&iommu->dma_list); n; n = rb_next(n)) {
+		struct vfio_dma *dma = rb_entry(n, struct vfio_dma, node);
+
+		if (start)
+			vfio_dma_dirty_log_start(iommu, dma);
+		else
+			vfio_dma_dirty_log_stop(iommu, dma);
+	}
+}
+
 static int vfio_iommu_type1_dirty_pages(struct vfio_iommu *iommu,
 					unsigned long arg)
 {
@@ -3054,8 +3179,10 @@ static int vfio_iommu_type1_dirty_pages(struct vfio_iommu *iommu,
 		pgsize = 1 << __ffs(iommu->pgsize_bitmap);
 		if (!iommu->dirty_page_tracking) {
 			ret = vfio_dma_bitmap_alloc_all(iommu, pgsize);
-			if (!ret)
+			if (!ret) {
 				iommu->dirty_page_tracking = true;
+				vfio_iommu_dirty_log_switch(iommu, true);
+			}
 		}
 		mutex_unlock(&iommu->lock);
 		return ret;
@@ -3064,6 +3191,7 @@ static int vfio_iommu_type1_dirty_pages(struct vfio_iommu *iommu,
 		if (iommu->dirty_page_tracking) {
 			iommu->dirty_page_tracking = false;
 			vfio_dma_bitmap_free_all(iommu);
+			vfio_iommu_dirty_log_switch(iommu, false);
 		}
 		mutex_unlock(&iommu->lock);
 		return 0;
-- 
2.19.1

