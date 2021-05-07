Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92792376397
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 12:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236653AbhEGKYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 06:24:30 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:17150 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236005AbhEGKYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 06:24:17 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Fc5z30gzhzqTB5;
        Fri,  7 May 2021 18:19:27 +0800 (CST)
Received: from DESKTOP-5IS4806.china.huawei.com (10.174.187.224) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Fri, 7 May 2021 18:22:36 +0800
From:   Keqian Zhu <zhukeqian1@huawei.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Will Deacon" <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        "Jean-Philippe Brucker" <jean-philippe@linaro.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "Yi Sun" <yi.y.sun@linux.intel.com>,
        Tian Kevin <kevin.tian@intel.com>
CC:     Alex Williamson <alex.williamson@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <wanghaibin.wang@huawei.com>, <jiangkunkun@huawei.com>,
        <yuzenghui@huawei.com>, <lushenming@huawei.com>
Subject: [RFC PATCH v4 06/13] iommu/io-pgtable-arm: Add and realize clear_dirty_log ops
Date:   Fri, 7 May 2021 18:22:04 +0800
Message-ID: <20210507102211.8836-7-zhukeqian1@huawei.com>
X-Mailer: git-send-email 2.8.4.windows.1
In-Reply-To: <20210507102211.8836-1-zhukeqian1@huawei.com>
References: <20210507102211.8836-1-zhukeqian1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.187.224]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kunkun Jiang <jiangkunkun@huawei.com>

After dirty log is retrieved, user should clear dirty log to re-enable
dirty log tracking for these dirtied pages. This clears the dirty state
(As we just set DBM bit for stage1 mapping, so should set the AP[2] bit)
of these leaf TTDs that are specified by the user provided bitmap.

Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Kunkun Jiang <jiangkunkun@huawei.com>
---
 drivers/iommu/io-pgtable-arm.c | 93 ++++++++++++++++++++++++++++++++++
 include/linux/io-pgtable.h     |  4 ++
 2 files changed, 97 insertions(+)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 155d440099ab..2b41b9d0faa3 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -965,6 +965,98 @@ static int arm_lpae_sync_dirty_log(struct io_pgtable_ops *ops,
 					 bitmap, base_iova, bitmap_pgshift);
 }
 
+static int __arm_lpae_clear_dirty_log(struct arm_lpae_io_pgtable *data,
+				      unsigned long iova, size_t size,
+				      int lvl, arm_lpae_iopte *ptep,
+				      unsigned long *bitmap,
+				      unsigned long base_iova,
+				      unsigned long bitmap_pgshift)
+{
+	arm_lpae_iopte pte;
+	struct io_pgtable *iop = &data->iop;
+	unsigned long offset;
+	size_t base, next_size;
+	int nbits, ret, i;
+
+	if (WARN_ON(lvl == ARM_LPAE_MAX_LEVELS))
+		return -EINVAL;
+
+	ptep += ARM_LPAE_LVL_IDX(iova, lvl, data);
+	pte = READ_ONCE(*ptep);
+	if (WARN_ON(!pte))
+		return -EINVAL;
+
+	if (size == ARM_LPAE_BLOCK_SIZE(lvl, data)) {
+		if (iopte_leaf(pte, lvl, iop->fmt)) {
+			if (pte & ARM_LPAE_PTE_AP_RDONLY)
+				return 0;
+
+			/* Ensure all corresponding bits are set */
+			nbits = size >> bitmap_pgshift;
+			offset = (iova - base_iova) >> bitmap_pgshift;
+			for (i = offset; i < offset + nbits; i++) {
+				if (!test_bit(i, bitmap))
+					return 0;
+			}
+
+			/* Race does not exist */
+			pte |= ARM_LPAE_PTE_AP_RDONLY;
+			__arm_lpae_set_pte(ptep, pte, &iop->cfg);
+			return 0;
+		}
+		/* Current level is table, traverse next level */
+		next_size = ARM_LPAE_BLOCK_SIZE(lvl + 1, data);
+		ptep = iopte_deref(pte, data);
+		for (base = 0; base < size; base += next_size) {
+			ret = __arm_lpae_clear_dirty_log(data, iova + base,
+					next_size, lvl + 1, ptep, bitmap,
+					base_iova, bitmap_pgshift);
+			if (ret)
+				return ret;
+		}
+		return 0;
+	} else if (iopte_leaf(pte, lvl, iop->fmt)) {
+		/* Though the size is too small, it is already clean */
+		if (pte & ARM_LPAE_PTE_AP_RDONLY)
+			return 0;
+
+		return -EINVAL;
+	}
+
+	/* Keep on walkin */
+	ptep = iopte_deref(pte, data);
+	return __arm_lpae_clear_dirty_log(data, iova, size, lvl + 1, ptep,
+			bitmap, base_iova, bitmap_pgshift);
+}
+
+static int arm_lpae_clear_dirty_log(struct io_pgtable_ops *ops,
+				    unsigned long iova, size_t size,
+				    unsigned long *bitmap,
+				    unsigned long base_iova,
+				    unsigned long bitmap_pgshift)
+{
+	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
+	struct io_pgtable_cfg *cfg = &data->iop.cfg;
+	arm_lpae_iopte *ptep = data->pgd;
+	int lvl = data->start_level;
+	long iaext = (s64)iova >> cfg->ias;
+
+	if (WARN_ON(!size || (size & cfg->pgsize_bitmap) != size))
+		return -EINVAL;
+
+	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_TTBR1)
+		iaext = ~iaext;
+	if (WARN_ON(iaext))
+		return -EINVAL;
+
+	if (data->iop.fmt != ARM_64_LPAE_S1 &&
+	    data->iop.fmt != ARM_32_LPAE_S1)
+		return -EINVAL;
+
+	return __arm_lpae_clear_dirty_log(data, iova, size, lvl, ptep,
+			bitmap, base_iova, bitmap_pgshift);
+}
+
 static void arm_lpae_restrict_pgsizes(struct io_pgtable_cfg *cfg)
 {
 	unsigned long granule, page_sizes;
@@ -1046,6 +1138,7 @@ arm_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg)
 		.split_block	= arm_lpae_split_block,
 		.merge_page	= arm_lpae_merge_page,
 		.sync_dirty_log	= arm_lpae_sync_dirty_log,
+		.clear_dirty_log = arm_lpae_clear_dirty_log,
 	};
 
 	return data;
diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
index 329fa99d9d96..4781407d5e2d 100644
--- a/include/linux/io-pgtable.h
+++ b/include/linux/io-pgtable.h
@@ -175,6 +175,10 @@ struct io_pgtable_ops {
 			      unsigned long iova, size_t size,
 			      unsigned long *bitmap, unsigned long base_iova,
 			      unsigned long bitmap_pgshift);
+	int (*clear_dirty_log)(struct io_pgtable_ops *ops,
+			       unsigned long iova, size_t size,
+			       unsigned long *bitmap, unsigned long base_iova,
+			       unsigned long bitmap_pgshift);
 };
 
 /**
-- 
2.19.1

