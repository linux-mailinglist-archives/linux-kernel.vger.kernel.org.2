Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1CA2333843
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 10:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232711AbhCJJHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 04:07:19 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:13492 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232670AbhCJJGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 04:06:53 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DwR3z1svGzrTKL;
        Wed, 10 Mar 2021 17:05:03 +0800 (CST)
Received: from DESKTOP-5IS4806.china.huawei.com (10.174.184.42) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.498.0; Wed, 10 Mar 2021 17:06:23 +0800
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
Subject: [PATCH v2 06/11] iommu/arm-smmu-v3: Scan leaf TTD to sync hardware dirty log
Date:   Wed, 10 Mar 2021 17:06:09 +0800
Message-ID: <20210310090614.26668-7-zhukeqian1@huawei.com>
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

During dirty log tracking, user will try to retrieve dirty log from
iommu if it supports hardware dirty log.

This adds a new interface named sync_dirty_log in iommu layer and
arm smmuv3 implements it, which scans leaf TTD and treats it's dirty
if it's writable (As we just enable HTTU for stage1, so check whether
AP[2] is not set).

Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Kunkun Jiang <jiangkunkun@huawei.com>
---

changelog:

v2:
 - Add new sanity check in arm_smmu_sync_dirty_log(). (smmu_domain->stage != ARM_SMMU_DOMAIN_S1)
 - Document the purpose of flush_iotlb in arm_smmu_sync_dirty_log(). (Robin)
 
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 30 +++++++
 drivers/iommu/io-pgtable-arm.c              | 90 +++++++++++++++++++++
 drivers/iommu/iommu.c                       | 38 +++++++++
 include/linux/io-pgtable.h                  |  4 +
 include/linux/iommu.h                       | 18 +++++
 5 files changed, 180 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index ac0d881c77b8..7407896a710e 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2637,6 +2637,35 @@ static int arm_smmu_stop_dirty_log(struct iommu_domain *domain,
 	return 0;
 }
 
+static int arm_smmu_sync_dirty_log(struct iommu_domain *domain,
+				   unsigned long iova, size_t size,
+				   unsigned long *bitmap,
+				   unsigned long base_iova,
+				   unsigned long bitmap_pgshift)
+{
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+	struct io_pgtable_ops *ops = smmu_domain->pgtbl_ops;
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+
+	if (!(smmu->features & ARM_SMMU_FEAT_HD))
+		return -ENODEV;
+	if (smmu_domain->stage != ARM_SMMU_DOMAIN_S1)
+		return -EINVAL;
+
+	if (!ops || !ops->sync_dirty_log) {
+		pr_err("io-pgtable don't realize sync dirty log\n");
+		return -ENODEV;
+	}
+
+	/*
+	 * Flush iotlb to ensure all inflight transactions are completed.
+	 * See doc IHI0070Da 3.13.4 "HTTU behavior summary".
+	 */
+	arm_smmu_flush_iotlb_all(domain);
+	return ops->sync_dirty_log(ops, iova, size, bitmap, base_iova,
+				   bitmap_pgshift);
+}
+
 static int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args *args)
 {
 	return iommu_fwspec_add_ids(dev, args->args, 1);
@@ -2740,6 +2769,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.start_dirty_log	= arm_smmu_start_dirty_log,
 	.merge_page		= arm_smmu_merge_page,
 	.stop_dirty_log		= arm_smmu_stop_dirty_log,
+	.sync_dirty_log		= arm_smmu_sync_dirty_log,
 	.of_xlate		= arm_smmu_of_xlate,
 	.get_resv_regions	= arm_smmu_get_resv_regions,
 	.put_resv_regions	= generic_iommu_put_resv_regions,
diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 9028328b99b0..67a208a05ab2 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -877,6 +877,95 @@ static size_t arm_lpae_merge_page(struct io_pgtable_ops *ops, unsigned long iova
 	return __arm_lpae_merge_page(data, iova, paddr, size, lvl, ptep, prot);
 }
 
+static int __arm_lpae_sync_dirty_log(struct arm_lpae_io_pgtable *data,
+				     unsigned long iova, size_t size,
+				     int lvl, arm_lpae_iopte *ptep,
+				     unsigned long *bitmap,
+				     unsigned long base_iova,
+				     unsigned long bitmap_pgshift)
+{
+	arm_lpae_iopte pte;
+	struct io_pgtable *iop = &data->iop;
+	size_t base, next_size;
+	unsigned long offset;
+	int nbits, ret;
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
+			/* It is writable, set the bitmap */
+			nbits = size >> bitmap_pgshift;
+			offset = (iova - base_iova) >> bitmap_pgshift;
+			bitmap_set(bitmap, offset, nbits);
+			return 0;
+		} else {
+			/* To traverse next level */
+			next_size = ARM_LPAE_BLOCK_SIZE(lvl + 1, data);
+			ptep = iopte_deref(pte, data);
+			for (base = 0; base < size; base += next_size) {
+				ret = __arm_lpae_sync_dirty_log(data,
+						iova + base, next_size, lvl + 1,
+						ptep, bitmap, base_iova, bitmap_pgshift);
+				if (ret)
+					return ret;
+			}
+			return 0;
+		}
+	} else if (iopte_leaf(pte, lvl, iop->fmt)) {
+		if (pte & ARM_LPAE_PTE_AP_RDONLY)
+			return 0;
+
+		/* Though the size is too small, also set bitmap */
+		nbits = size >> bitmap_pgshift;
+		offset = (iova - base_iova) >> bitmap_pgshift;
+		bitmap_set(bitmap, offset, nbits);
+		return 0;
+	}
+
+	/* Keep on walkin */
+	ptep = iopte_deref(pte, data);
+	return __arm_lpae_sync_dirty_log(data, iova, size, lvl + 1, ptep,
+			bitmap, base_iova, bitmap_pgshift);
+}
+
+static int arm_lpae_sync_dirty_log(struct io_pgtable_ops *ops,
+				   unsigned long iova, size_t size,
+				   unsigned long *bitmap,
+				   unsigned long base_iova,
+				   unsigned long bitmap_pgshift)
+{
+	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
+	arm_lpae_iopte *ptep = data->pgd;
+	int lvl = data->start_level;
+	struct io_pgtable_cfg *cfg = &data->iop.cfg;
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
+	return __arm_lpae_sync_dirty_log(data, iova, size, lvl, ptep,
+					 bitmap, base_iova, bitmap_pgshift);
+}
+
 static void arm_lpae_restrict_pgsizes(struct io_pgtable_cfg *cfg)
 {
 	unsigned long granule, page_sizes;
@@ -957,6 +1046,7 @@ arm_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg)
 		.iova_to_phys	= arm_lpae_iova_to_phys,
 		.split_block	= arm_lpae_split_block,
 		.merge_page	= arm_lpae_merge_page,
+		.sync_dirty_log	= arm_lpae_sync_dirty_log,
 	};
 
 	return data;
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 2a10294b62a3..44dfb78f9050 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2850,6 +2850,44 @@ int iommu_stop_dirty_log(struct iommu_domain *domain, unsigned long iova,
 }
 EXPORT_SYMBOL_GPL(iommu_stop_dirty_log);
 
+int iommu_sync_dirty_log(struct iommu_domain *domain, unsigned long iova,
+			 size_t size, unsigned long *bitmap,
+			 unsigned long base_iova, unsigned long bitmap_pgshift)
+{
+	const struct iommu_ops *ops = domain->ops;
+	unsigned int min_pagesz;
+	size_t pgsize;
+	int ret = 0;
+
+	if (unlikely(!ops || !ops->sync_dirty_log))
+		return -ENODEV;
+
+	min_pagesz = 1 << __ffs(domain->pgsize_bitmap);
+	if (!IS_ALIGNED(iova | size, min_pagesz)) {
+		pr_err("unaligned: iova 0x%lx size 0x%zx min_pagesz 0x%x\n",
+		       iova, size, min_pagesz);
+		return -EINVAL;
+	}
+
+	while (size) {
+		pgsize = iommu_pgsize(domain, iova, size);
+
+		ret = ops->sync_dirty_log(domain, iova, pgsize,
+					  bitmap, base_iova, bitmap_pgshift);
+		if (ret)
+			break;
+
+		pr_debug("dirty_log_sync handle: iova 0x%lx pagesz 0x%zx\n",
+			 iova, pgsize);
+
+		iova += pgsize;
+		size -= pgsize;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_sync_dirty_log);
+
 void iommu_get_resv_regions(struct device *dev, struct list_head *list)
 {
 	const struct iommu_ops *ops = dev->bus->iommu_ops;
diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
index 38b4e17c70f0..5107a9d4ac79 100644
--- a/include/linux/io-pgtable.h
+++ b/include/linux/io-pgtable.h
@@ -171,6 +171,10 @@ struct io_pgtable_ops {
 			      size_t size);
 	size_t (*merge_page)(struct io_pgtable_ops *ops, unsigned long iova,
 			     phys_addr_t phys, size_t size, int prot);
+	int (*sync_dirty_log)(struct io_pgtable_ops *ops,
+			      unsigned long iova, size_t size,
+			      unsigned long *bitmap, unsigned long base_iova,
+			      unsigned long bitmap_pgshift);
 };
 
 /**
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 28111009cf6f..7d5777acfdb7 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -209,6 +209,7 @@ struct iommu_iotlb_gather {
  * @start_dirty_log: Perform actions to start dirty log tracking
  * @merge_page: Merge page mapping into block mapping
  * @stop_dirty_log: Perform actions to stop dirty log tracking
+ * @sync_dirty_log: Sync dirty log from IOMMU into a dirty bitmap
  * @get_resv_regions: Request list of reserved regions for a device
  * @put_resv_regions: Free list of reserved regions for a device
  * @apply_resv_region: Temporary helper call-back for iova reserved ranges
@@ -273,6 +274,10 @@ struct iommu_ops {
 			  phys_addr_t phys, size_t size, int prot);
 	int (*stop_dirty_log)(struct iommu_domain *domain, unsigned long iova,
 			      size_t size, int prot);
+	int (*sync_dirty_log)(struct iommu_domain *domain,
+			      unsigned long iova, size_t size,
+			      unsigned long *bitmap, unsigned long base_iova,
+			      unsigned long bitmap_pgshift);
 
 	/* Request/Free a list of reserved regions for a device */
 	void (*get_resv_regions)(struct device *dev, struct list_head *list);
@@ -533,6 +538,10 @@ extern int iommu_merge_page(struct iommu_domain *domain, unsigned long iova,
 			    size_t size, int prot);
 extern int iommu_stop_dirty_log(struct iommu_domain *domain,
 				unsigned long iova, size_t size, int prot);
+extern int iommu_sync_dirty_log(struct iommu_domain *domain, unsigned long iova,
+				size_t size, unsigned long *bitmap,
+				unsigned long base_iova,
+				unsigned long bitmap_pgshift);
 
 /* Window handling function prototypes */
 extern int iommu_domain_window_enable(struct iommu_domain *domain, u32 wnd_nr,
@@ -949,6 +958,15 @@ static inline int iommu_stop_dirty_log(struct iommu_domain *domain,
 	return -EINVAL;
 }
 
+static inline int iommu_sync_dirty_log(struct iommu_domain *domain,
+				       unsigned long iova, size_t size,
+				       unsigned long *bitmap,
+				       unsigned long base_iova,
+				       unsigned long pgshift)
+{
+	return -EINVAL;
+}
+
 static inline int  iommu_device_register(struct iommu_device *iommu)
 {
 	return -ENODEV;
-- 
2.19.1

