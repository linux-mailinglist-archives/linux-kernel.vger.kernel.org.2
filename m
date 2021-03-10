Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6857D333847
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 10:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbhCJJH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 04:07:26 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:13494 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbhCJJGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 04:06:54 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DwR3z2v4vzrTLG;
        Wed, 10 Mar 2021 17:05:03 +0800 (CST)
Received: from DESKTOP-5IS4806.china.huawei.com (10.174.184.42) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.498.0; Wed, 10 Mar 2021 17:06:21 +0800
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
Subject: [PATCH v2 04/11] iommu/arm-smmu-v3: Split block descriptor when start dirty log
Date:   Wed, 10 Mar 2021 17:06:07 +0800
Message-ID: <20210310090614.26668-5-zhukeqian1@huawei.com>
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

Block descriptor is not a proper granule for dirty log tracking.
Take an extreme example, if DMA writes one byte, under 1G mapping,
the dirty amount reported to userspace is 1G, but under 4K mapping,
the dirty amount is just 4K.

This adds a new interface named start_dirty_log in iommu layer and
arm smmuv3 implements it, which splits block descriptor to an span
of page descriptors. Other types of IOMMU will perform architecture
specific actions to start dirty log.

To allow code reuse, the split_block operation is realized as an
iommu_ops too. We flush all iotlbs after the whole procedure is
completed to ease the pressure of iommu, as we will hanle a huge
range of mapping in general.

Spliting block does not simultaneously work with other pgtable ops,
as the only designed user is vfio, which always hold a lock, so race
condition is not considered in the pgtable ops.

Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Kunkun Jiang <jiangkunkun@huawei.com>
---

changelog:

v2:
 - Change the return type of split_block(). size_t -> int.
 - Change commit message to properly describe race condition. (Robin)
 - Change commit message to properly describe the need of split block.
 - Add a new interface named start_dirty_log(). (Sun Yi)
 - Change commit message to explain the realtionship of split_block() and start_dirty_log().

---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  52 +++++++++
 drivers/iommu/io-pgtable-arm.c              | 122 ++++++++++++++++++++
 drivers/iommu/iommu.c                       |  48 ++++++++
 include/linux/io-pgtable.h                  |   2 +
 include/linux/iommu.h                       |  24 ++++
 5 files changed, 248 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 443ac19c6da9..5d2fb926a08e 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2537,6 +2537,56 @@ static int arm_smmu_domain_set_attr(struct iommu_domain *domain,
 	return ret;
 }
 
+static int arm_smmu_split_block(struct iommu_domain *domain,
+				unsigned long iova, size_t size)
+{
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	struct io_pgtable_ops *ops = smmu_domain->pgtbl_ops;
+	size_t handled_size;
+
+	if (!(smmu->features & (ARM_SMMU_FEAT_BBML1 | ARM_SMMU_FEAT_BBML2))) {
+		dev_err(smmu->dev, "don't support BBML1/2, can't split block\n");
+		return -ENODEV;
+	}
+	if (!ops || !ops->split_block) {
+		pr_err("io-pgtable don't realize split block\n");
+		return -ENODEV;
+	}
+
+	handled_size = ops->split_block(ops, iova, size);
+	if (handled_size != size) {
+		pr_err("split block failed\n");
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+/*
+ * For SMMU, the action to start dirty log is spliting block mapping. The
+ * hardware dirty management is always enabled if hardware supports HTTU HD.
+ */
+static int arm_smmu_start_dirty_log(struct iommu_domain *domain,
+				    unsigned long iova, size_t size)
+{
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+
+	if (!(smmu->features & ARM_SMMU_FEAT_HD))
+		return -ENODEV;
+	if (smmu_domain->stage != ARM_SMMU_DOMAIN_S1)
+		return -EINVAL;
+
+	/*
+	 * Even if the split operation fail, we can still track dirty at block
+	 * granule, which is still a much better choice compared to full dirty
+	 * policy.
+	 */
+	iommu_split_block(domain, iova, size);
+	return 0;
+}
+
 static int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args *args)
 {
 	return iommu_fwspec_add_ids(dev, args->args, 1);
@@ -2636,6 +2686,8 @@ static struct iommu_ops arm_smmu_ops = {
 	.device_group		= arm_smmu_device_group,
 	.domain_get_attr	= arm_smmu_domain_get_attr,
 	.domain_set_attr	= arm_smmu_domain_set_attr,
+	.split_block		= arm_smmu_split_block,
+	.start_dirty_log	= arm_smmu_start_dirty_log,
 	.of_xlate		= arm_smmu_of_xlate,
 	.get_resv_regions	= arm_smmu_get_resv_regions,
 	.put_resv_regions	= generic_iommu_put_resv_regions,
diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 94d790b8ed27..4c4eec3c0698 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -79,6 +79,8 @@
 #define ARM_LPAE_PTE_SH_IS		(((arm_lpae_iopte)3) << 8)
 #define ARM_LPAE_PTE_NS			(((arm_lpae_iopte)1) << 5)
 #define ARM_LPAE_PTE_VALID		(((arm_lpae_iopte)1) << 0)
+/* Block descriptor bits */
+#define ARM_LPAE_PTE_NT			(((arm_lpae_iopte)1) << 16)
 
 #define ARM_LPAE_PTE_ATTR_LO_MASK	(((arm_lpae_iopte)0x3ff) << 2)
 /* Ignore the contiguous bit for block splitting */
@@ -679,6 +681,125 @@ static phys_addr_t arm_lpae_iova_to_phys(struct io_pgtable_ops *ops,
 	return iopte_to_paddr(pte, data) | iova;
 }
 
+static size_t __arm_lpae_split_block(struct arm_lpae_io_pgtable *data,
+				     unsigned long iova, size_t size, int lvl,
+				     arm_lpae_iopte *ptep);
+
+static size_t arm_lpae_do_split_blk(struct arm_lpae_io_pgtable *data,
+				    unsigned long iova, size_t size,
+				    arm_lpae_iopte blk_pte, int lvl,
+				    arm_lpae_iopte *ptep)
+{
+	struct io_pgtable_cfg *cfg = &data->iop.cfg;
+	arm_lpae_iopte pte, *tablep;
+	phys_addr_t blk_paddr;
+	size_t tablesz = ARM_LPAE_GRANULE(data);
+	size_t split_sz = ARM_LPAE_BLOCK_SIZE(lvl, data);
+	int i;
+
+	if (WARN_ON(lvl == ARM_LPAE_MAX_LEVELS))
+		return 0;
+
+	tablep = __arm_lpae_alloc_pages(tablesz, GFP_ATOMIC, cfg);
+	if (!tablep)
+		return 0;
+
+	blk_paddr = iopte_to_paddr(blk_pte, data);
+	pte = iopte_prot(blk_pte);
+	for (i = 0; i < tablesz / sizeof(pte); i++, blk_paddr += split_sz)
+		__arm_lpae_init_pte(data, blk_paddr, pte, lvl, &tablep[i]);
+
+	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_BBML1) {
+		/* Race does not exist */
+		blk_pte |= ARM_LPAE_PTE_NT;
+		__arm_lpae_set_pte(ptep, blk_pte, cfg);
+		io_pgtable_tlb_flush_walk(&data->iop, iova, size, size);
+	}
+	/* Race does not exist */
+	pte = arm_lpae_install_table(tablep, ptep, blk_pte, cfg);
+
+	/* Have splited it into page? */
+	if (lvl == (ARM_LPAE_MAX_LEVELS - 1))
+		return size;
+
+	/* Go back to lvl - 1 */
+	ptep -= ARM_LPAE_LVL_IDX(iova, lvl - 1, data);
+	return __arm_lpae_split_block(data, iova, size, lvl - 1, ptep);
+}
+
+static size_t __arm_lpae_split_block(struct arm_lpae_io_pgtable *data,
+				     unsigned long iova, size_t size, int lvl,
+				     arm_lpae_iopte *ptep)
+{
+	arm_lpae_iopte pte;
+	struct io_pgtable *iop = &data->iop;
+	size_t base, next_size, total_size;
+
+	if (WARN_ON(lvl == ARM_LPAE_MAX_LEVELS))
+		return 0;
+
+	ptep += ARM_LPAE_LVL_IDX(iova, lvl, data);
+	pte = READ_ONCE(*ptep);
+	if (WARN_ON(!pte))
+		return 0;
+
+	if (size == ARM_LPAE_BLOCK_SIZE(lvl, data)) {
+		if (iopte_leaf(pte, lvl, iop->fmt)) {
+			if (lvl == (ARM_LPAE_MAX_LEVELS - 1) ||
+			    (pte & ARM_LPAE_PTE_AP_RDONLY))
+				return size;
+
+			/* We find a writable block, split it. */
+			return arm_lpae_do_split_blk(data, iova, size, pte,
+					lvl + 1, ptep);
+		} else {
+			/* If it is the last table level, then nothing to do */
+			if (lvl == (ARM_LPAE_MAX_LEVELS - 2))
+				return size;
+
+			total_size = 0;
+			next_size = ARM_LPAE_BLOCK_SIZE(lvl + 1, data);
+			ptep = iopte_deref(pte, data);
+			for (base = 0; base < size; base += next_size)
+				total_size += __arm_lpae_split_block(data,
+						iova + base, next_size, lvl + 1,
+						ptep);
+			return total_size;
+		}
+	} else if (iopte_leaf(pte, lvl, iop->fmt)) {
+		WARN(1, "Can't split behind a block.\n");
+		return 0;
+	}
+
+	/* Keep on walkin */
+	ptep = iopte_deref(pte, data);
+	return __arm_lpae_split_block(data, iova, size, lvl + 1, ptep);
+}
+
+static size_t arm_lpae_split_block(struct io_pgtable_ops *ops,
+				   unsigned long iova, size_t size)
+{
+	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
+	arm_lpae_iopte *ptep = data->pgd;
+	struct io_pgtable_cfg *cfg = &data->iop.cfg;
+	int lvl = data->start_level;
+	long iaext = (s64)iova >> cfg->ias;
+
+	if (WARN_ON(!size || (size & cfg->pgsize_bitmap) != size))
+		return 0;
+
+	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_TTBR1)
+		iaext = ~iaext;
+	if (WARN_ON(iaext))
+		return 0;
+
+	/* If it is smallest granule, then nothing to do */
+	if (size == ARM_LPAE_BLOCK_SIZE(ARM_LPAE_MAX_LEVELS - 1, data))
+		return size;
+
+	return __arm_lpae_split_block(data, iova, size, lvl, ptep);
+}
+
 static void arm_lpae_restrict_pgsizes(struct io_pgtable_cfg *cfg)
 {
 	unsigned long granule, page_sizes;
@@ -757,6 +878,7 @@ arm_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg)
 		.map		= arm_lpae_map,
 		.unmap		= arm_lpae_unmap,
 		.iova_to_phys	= arm_lpae_iova_to_phys,
+		.split_block	= arm_lpae_split_block,
 	};
 
 	return data;
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index d0b0a15dba84..f644e0b16843 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2720,6 +2720,54 @@ int iommu_domain_set_attr(struct iommu_domain *domain,
 }
 EXPORT_SYMBOL_GPL(iommu_domain_set_attr);
 
+int iommu_split_block(struct iommu_domain *domain, unsigned long iova,
+		      size_t size)
+{
+	const struct iommu_ops *ops = domain->ops;
+	unsigned int min_pagesz;
+	size_t pgsize;
+	int ret = 0;
+
+	if (unlikely(!ops || !ops->split_block))
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
+		ret = ops->split_block(domain, iova, pgsize);
+		if (ret)
+			break;
+
+		pr_debug("split handled: iova 0x%lx size 0x%zx\n", iova, pgsize);
+
+		iova += pgsize;
+		size -= pgsize;
+	}
+	iommu_flush_iotlb_all(domain);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_split_block);
+
+int iommu_start_dirty_log(struct iommu_domain *domain, unsigned long iova,
+			  size_t size)
+{
+	const struct iommu_ops *ops = domain->ops;
+
+	if (unlikely(!ops || !ops->start_dirty_log))
+		return -ENODEV;
+
+	return ops->start_dirty_log(domain, iova, size);
+}
+EXPORT_SYMBOL_GPL(iommu_start_dirty_log);
+
 void iommu_get_resv_regions(struct device *dev, struct list_head *list)
 {
 	const struct iommu_ops *ops = dev->bus->iommu_ops;
diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
index 857932357f1d..d86dd2ade6ad 100644
--- a/include/linux/io-pgtable.h
+++ b/include/linux/io-pgtable.h
@@ -167,6 +167,8 @@ struct io_pgtable_ops {
 			size_t size, struct iommu_iotlb_gather *gather);
 	phys_addr_t (*iova_to_phys)(struct io_pgtable_ops *ops,
 				    unsigned long iova);
+	size_t (*split_block)(struct io_pgtable_ops *ops, unsigned long iova,
+			      size_t size);
 };
 
 /**
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 5e7fe519430a..85ffa451547d 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -205,6 +205,8 @@ struct iommu_iotlb_gather {
  * @device_group: find iommu group for a particular device
  * @domain_get_attr: Query domain attributes
  * @domain_set_attr: Change domain attributes
+ * @split_block: Split block mapping into page mapping
+ * @start_dirty_log: Perform actions to start dirty log tracking
  * @get_resv_regions: Request list of reserved regions for a device
  * @put_resv_regions: Free list of reserved regions for a device
  * @apply_resv_region: Temporary helper call-back for iova reserved ranges
@@ -260,6 +262,12 @@ struct iommu_ops {
 	int (*domain_set_attr)(struct iommu_domain *domain,
 			       enum iommu_attr attr, void *data);
 
+	/* Track dirty log */
+	int (*split_block)(struct iommu_domain *domain, unsigned long iova,
+			   size_t size);
+	int (*start_dirty_log)(struct iommu_domain *domain, unsigned long iova,
+			       size_t size);
+
 	/* Request/Free a list of reserved regions for a device */
 	void (*get_resv_regions)(struct device *dev, struct list_head *list);
 	void (*put_resv_regions)(struct device *dev, struct list_head *list);
@@ -511,6 +519,10 @@ extern int iommu_domain_get_attr(struct iommu_domain *domain, enum iommu_attr,
 				 void *data);
 extern int iommu_domain_set_attr(struct iommu_domain *domain, enum iommu_attr,
 				 void *data);
+extern int iommu_split_block(struct iommu_domain *domain, unsigned long iova,
+			     size_t size);
+extern int iommu_start_dirty_log(struct iommu_domain *domain,
+				 unsigned long iova, size_t size);
 
 /* Window handling function prototypes */
 extern int iommu_domain_window_enable(struct iommu_domain *domain, u32 wnd_nr,
@@ -901,6 +913,18 @@ static inline int iommu_domain_set_attr(struct iommu_domain *domain,
 	return -EINVAL;
 }
 
+static inline int iommu_split_block(struct iommu_domain *domain,
+				    unsigned long iova, size_t size)
+{
+	return -EINVAL;
+}
+
+static inline int iommu_start_dirty_log(struct iommu_domain *domain,
+					unsigned long iova, size_t size)
+{
+	return -EINVAL;
+}
+
 static inline int  iommu_device_register(struct iommu_device *iommu)
 {
 	return -ENODEV;
-- 
2.19.1

