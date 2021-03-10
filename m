Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6A90333848
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 10:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232798AbhCJJH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 04:07:28 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:13877 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232672AbhCJJGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 04:06:54 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DwR400qkwz8vtv;
        Wed, 10 Mar 2021 17:05:04 +0800 (CST)
Received: from DESKTOP-5IS4806.china.huawei.com (10.174.184.42) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.498.0; Wed, 10 Mar 2021 17:06:26 +0800
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
Subject: [PATCH v2 09/11] vfio/iommu_type1: Add HWDBM status maintanance
Date:   Wed, 10 Mar 2021 17:06:12 +0800
Message-ID: <20210310090614.26668-10-zhukeqian1@huawei.com>
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

We are going to optimize dirty log tracking based on iommu
HWDBM feature, but the dirty log from iommu is useful only
when all iommu backed groups are connected to iommu with
HWDBM feature. This maintains a counter for this feature.

Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Kunkun Jiang <jiangkunkun@huawei.com>
---

changelog:

v2:
 - Simplify vfio_group_supports_hwdbm().
 - AS feature report of HWDBM has been changed, so change vfio_dev_has_feature() to
   vfio_dev_enable_feature().

---
 drivers/vfio/vfio_iommu_type1.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 4bb162c1d649..876351c061e4 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -79,6 +79,7 @@ struct vfio_iommu {
 	bool			dirty_page_tracking;
 	bool			pinned_page_dirty_scope;
 	bool			container_open;
+	uint64_t		num_non_hwdbm_groups;
 };
 
 struct vfio_domain {
@@ -116,6 +117,7 @@ struct vfio_group {
 	struct list_head	next;
 	bool			mdev_group;	/* An mdev group */
 	bool			pinned_page_dirty_scope;
+	bool			iommu_hwdbm;	/* For iommu-backed group */
 };
 
 struct vfio_iova {
@@ -1187,6 +1189,24 @@ static void vfio_update_pgsize_bitmap(struct vfio_iommu *iommu)
 	}
 }
 
+static int vfio_dev_enable_feature(struct device *dev, void *data)
+{
+	enum iommu_dev_features *feat = data;
+
+	if (iommu_dev_feature_enabled(dev, *feat))
+		return 0;
+
+	return iommu_dev_enable_feature(dev, *feat);
+}
+
+static bool vfio_group_supports_hwdbm(struct vfio_group *group)
+{
+	enum iommu_dev_features feat = IOMMU_DEV_FEAT_HWDBM;
+
+	return !iommu_group_for_each_dev(group->iommu_group, &feat,
+					 vfio_dev_enable_feature);
+}
+
 static int update_user_bitmap(u64 __user *bitmap, struct vfio_iommu *iommu,
 			      struct vfio_dma *dma, dma_addr_t base_iova,
 			      size_t pgsize)
@@ -2435,6 +2455,12 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 	 * capable via the page pinning interface.
 	 */
 	iommu->num_non_pinned_groups++;
+
+	/* Update the hwdbm status of group and iommu */
+	group->iommu_hwdbm = vfio_group_supports_hwdbm(group);
+	if (!group->iommu_hwdbm)
+		iommu->num_non_hwdbm_groups++;
+
 	mutex_unlock(&iommu->lock);
 	vfio_iommu_resv_free(&group_resv_regions);
 
@@ -2571,6 +2597,7 @@ static void vfio_iommu_type1_detach_group(void *iommu_data,
 	struct vfio_domain *domain;
 	struct vfio_group *group;
 	bool update_dirty_scope = false;
+	bool update_iommu_hwdbm = false;
 	LIST_HEAD(iova_copy);
 
 	mutex_lock(&iommu->lock);
@@ -2609,6 +2636,7 @@ static void vfio_iommu_type1_detach_group(void *iommu_data,
 
 		vfio_iommu_detach_group(domain, group);
 		update_dirty_scope = !group->pinned_page_dirty_scope;
+		update_iommu_hwdbm = !group->iommu_hwdbm;
 		list_del(&group->next);
 		kfree(group);
 		/*
@@ -2651,6 +2679,8 @@ static void vfio_iommu_type1_detach_group(void *iommu_data,
 		if (iommu->dirty_page_tracking)
 			vfio_iommu_populate_bitmap_full(iommu);
 	}
+	if (update_iommu_hwdbm)
+		iommu->num_non_hwdbm_groups--;
 	mutex_unlock(&iommu->lock);
 }
 
-- 
2.19.1

