Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFB6E35DA87
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 10:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245094AbhDMI4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 04:56:21 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:16548 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244170AbhDMIzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 04:55:43 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FKK9q0tRVzPqkg;
        Tue, 13 Apr 2021 16:52:31 +0800 (CST)
Received: from DESKTOP-5IS4806.china.huawei.com (10.174.187.224) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Tue, 13 Apr 2021 16:55:13 +0800
From:   Keqian Zhu <zhukeqian1@huawei.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Will Deacon" <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Yi Sun <yi.y.sun@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Tian Kevin <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>
CC:     Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        <wanghaibin.wang@huawei.com>, <jiangkunkun@huawei.com>,
        <yuzenghui@huawei.com>, <lushenming@huawei.com>
Subject: [PATCH v3 08/12] iommu/arm-smmu-v3: Realize merge_page iommu ops
Date:   Tue, 13 Apr 2021 16:54:53 +0800
Message-ID: <20210413085457.25400-9-zhukeqian1@huawei.com>
X-Mailer: git-send-email 2.8.4.windows.1
In-Reply-To: <20210413085457.25400-1-zhukeqian1@huawei.com>
References: <20210413085457.25400-1-zhukeqian1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.187.224]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kunkun Jiang <jiangkunkun@huawei.com>

This reinstalls block mappings and unmap the span of page mappings.
BBML1 or BBML2 feature is required.

Merging page does not simultaneously work with other pgtable ops,
as the only designed user is vfio, which always hold a lock, so race
condition is not considered in the pgtable ops.

Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Kunkun Jiang <jiangkunkun@huawei.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 28 ++++++++
 drivers/iommu/io-pgtable-arm.c              | 78 +++++++++++++++++++++
 include/linux/io-pgtable.h                  |  2 +
 3 files changed, 108 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index cfa83fa03c89..4d8495d88be2 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2563,6 +2563,33 @@ static int arm_smmu_split_block(struct iommu_domain *domain,
 	return 0;
 }
 
+static int arm_smmu_merge_page(struct iommu_domain *domain,
+			       unsigned long iova, phys_addr_t paddr,
+			       size_t size, int prot)
+{
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	struct io_pgtable_ops *ops = smmu_domain->pgtbl_ops;
+	size_t handled_size;
+
+	if (!(smmu->features & (ARM_SMMU_FEAT_BBML1 | ARM_SMMU_FEAT_BBML2))) {
+		dev_err(smmu->dev, "don't support BBML1/2, can't merge page\n");
+		return -ENODEV;
+	}
+	if (!ops || !ops->merge_page) {
+		pr_err("io-pgtable don't realize merge page\n");
+		return -ENODEV;
+	}
+
+	handled_size = ops->merge_page(ops, iova, paddr, size, prot);
+	if (handled_size != size) {
+		pr_err("merge page failed\n");
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
 static int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args *args)
 {
 	return iommu_fwspec_add_ids(dev, args->args, 1);
@@ -2663,6 +2690,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.domain_get_attr	= arm_smmu_domain_get_attr,
 	.domain_set_attr	= arm_smmu_domain_set_attr,
 	.split_block		= arm_smmu_split_block,
+	.merge_page		= arm_smmu_merge_page,
 	.of_xlate		= arm_smmu_of_xlate,
 	.get_resv_regions	= arm_smmu_get_resv_regions,
 	.put_resv_regions	= generic_iommu_put_resv_regions,
diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 4c4eec3c0698..9028328b99b0 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -800,6 +800,83 @@ static size_t arm_lpae_split_block(struct io_pgtable_ops *ops,
 	return __arm_lpae_split_block(data, iova, size, lvl, ptep);
 }
 
+static size_t __arm_lpae_merge_page(struct arm_lpae_io_pgtable *data,
+				    unsigned long iova, phys_addr_t paddr,
+				    size_t size, int lvl, arm_lpae_iopte *ptep,
+				    arm_lpae_iopte prot)
+{
+	arm_lpae_iopte pte, *tablep;
+	struct io_pgtable *iop = &data->iop;
+	struct io_pgtable_cfg *cfg = &data->iop.cfg;
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
+		if (iopte_leaf(pte, lvl, iop->fmt))
+			return size;
+
+		/* Race does not exist */
+		if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_BBML1) {
+			prot |= ARM_LPAE_PTE_NT;
+			__arm_lpae_init_pte(data, paddr, prot, lvl, ptep);
+			io_pgtable_tlb_flush_walk(iop, iova, size,
+						  ARM_LPAE_GRANULE(data));
+
+			prot &= ~(ARM_LPAE_PTE_NT);
+			__arm_lpae_init_pte(data, paddr, prot, lvl, ptep);
+		} else {
+			__arm_lpae_init_pte(data, paddr, prot, lvl, ptep);
+		}
+
+		tablep = iopte_deref(pte, data);
+		__arm_lpae_free_pgtable(data, lvl + 1, tablep);
+		return size;
+	} else if (iopte_leaf(pte, lvl, iop->fmt)) {
+		/* The size is too small, already merged */
+		return size;
+	}
+
+	/* Keep on walkin */
+	ptep = iopte_deref(pte, data);
+	return __arm_lpae_merge_page(data, iova, paddr, size, lvl + 1, ptep, prot);
+}
+
+static size_t arm_lpae_merge_page(struct io_pgtable_ops *ops, unsigned long iova,
+				  phys_addr_t paddr, size_t size, int iommu_prot)
+{
+	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
+	struct io_pgtable_cfg *cfg = &data->iop.cfg;
+	arm_lpae_iopte *ptep = data->pgd;
+	int lvl = data->start_level;
+	arm_lpae_iopte prot;
+	long iaext = (s64)iova >> cfg->ias;
+
+	/* If no access, then nothing to do */
+	if (!(iommu_prot & (IOMMU_READ | IOMMU_WRITE)))
+		return size;
+
+	if (WARN_ON(!size || (size & cfg->pgsize_bitmap) != size))
+		return 0;
+
+	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_TTBR1)
+		iaext = ~iaext;
+	if (WARN_ON(iaext || paddr >> cfg->oas))
+		return 0;
+
+	/* If it is smallest granule, then nothing to do */
+	if (size == ARM_LPAE_BLOCK_SIZE(ARM_LPAE_MAX_LEVELS - 1, data))
+		return size;
+
+	prot = arm_lpae_prot_to_pte(data, iommu_prot);
+	return __arm_lpae_merge_page(data, iova, paddr, size, lvl, ptep, prot);
+}
+
 static void arm_lpae_restrict_pgsizes(struct io_pgtable_cfg *cfg)
 {
 	unsigned long granule, page_sizes;
@@ -879,6 +956,7 @@ arm_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg)
 		.unmap		= arm_lpae_unmap,
 		.iova_to_phys	= arm_lpae_iova_to_phys,
 		.split_block	= arm_lpae_split_block,
+		.merge_page	= arm_lpae_merge_page,
 	};
 
 	return data;
diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
index 47aa8f20849b..dbee6170de7f 100644
--- a/include/linux/io-pgtable.h
+++ b/include/linux/io-pgtable.h
@@ -169,6 +169,8 @@ struct io_pgtable_ops {
 				    unsigned long iova);
 	size_t (*split_block)(struct io_pgtable_ops *ops, unsigned long iova,
 			      size_t size);
+	size_t (*merge_page)(struct io_pgtable_ops *ops, unsigned long iova,
+			     phys_addr_t phys, size_t size, int prot);
 };
 
 /**
-- 
2.19.1

