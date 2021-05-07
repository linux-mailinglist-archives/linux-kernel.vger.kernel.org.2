Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7766C37639E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 12:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236682AbhEGKYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 06:24:51 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:18351 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236043AbhEGKYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 06:24:18 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Fc5zw50PwzCr7b;
        Fri,  7 May 2021 18:20:12 +0800 (CST)
Received: from DESKTOP-5IS4806.china.huawei.com (10.174.187.224) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Fri, 7 May 2021 18:22:39 +0800
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
Subject: [RFC PATCH v4 10/13] iommu/arm-smmu-v3: Realize switch_dirty_log iommu ops
Date:   Fri, 7 May 2021 18:22:08 +0800
Message-ID: <20210507102211.8836-11-zhukeqian1@huawei.com>
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

This realizes switch_dirty_log. In order to get finer dirty
granule, it invokes arm_smmu_split_block when start dirty
log, and invokes arm_smmu_merge_page() to recover block
mapping when stop dirty log.

Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Kunkun Jiang <jiangkunkun@huawei.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 142 ++++++++++++++++++++
 drivers/iommu/iommu.c                       |   5 +-
 include/linux/iommu.h                       |   2 +
 3 files changed, 147 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 3a2dc3177180..6de81d6ab652 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2580,6 +2580,147 @@ static int arm_smmu_enable_nesting(struct iommu_domain *domain)
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
+static int __arm_smmu_merge_page(struct iommu_domain *domain,
+				 unsigned long iova, phys_addr_t paddr,
+				 size_t size, int prot)
+{
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+	struct io_pgtable_ops *ops = smmu_domain->pgtbl_ops;
+	size_t handled_size;
+
+	if (!ops || !ops->merge_page) {
+		pr_err("io-pgtable don't realize merge page\n");
+		return -ENODEV;
+	}
+
+	while (size) {
+		size_t pgsize = iommu_pgsize(domain, iova | paddr, size);
+
+		handled_size = ops->merge_page(ops, iova, paddr, pgsize, prot);
+		if (handled_size != pgsize) {
+			pr_err("merge page failed\n");
+			return -EFAULT;
+		}
+
+		pr_debug("merge handled: iova 0x%lx pa %pa size 0x%zx\n",
+			 iova, &paddr, pgsize);
+
+		iova += pgsize;
+		paddr += pgsize;
+		size -= pgsize;
+	}
+
+	return 0;
+}
+
+static int arm_smmu_merge_page(struct iommu_domain *domain, unsigned long iova,
+			       size_t size, int prot)
+{
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	struct io_pgtable_ops *ops = smmu_domain->pgtbl_ops;
+	phys_addr_t phys;
+	dma_addr_t p, i;
+	size_t cont_size;
+	int ret = 0;
+
+	if (!(smmu->features & (ARM_SMMU_FEAT_BBML1 | ARM_SMMU_FEAT_BBML2))) {
+		dev_err(smmu->dev, "don't support BBML1/2, can't merge page\n");
+		return -ENODEV;
+	}
+
+	if (!ops || !ops->iova_to_phys)
+		return -ENODEV;
+
+	while (size) {
+		phys = ops->iova_to_phys(ops, iova);
+		cont_size = PAGE_SIZE;
+		p = phys + cont_size;
+		i = iova + cont_size;
+
+		while (cont_size < size && p == ops->iova_to_phys(ops, i)) {
+			p += PAGE_SIZE;
+			i += PAGE_SIZE;
+			cont_size += PAGE_SIZE;
+		}
+
+		if (cont_size != PAGE_SIZE) {
+			ret = __arm_smmu_merge_page(domain, iova, phys,
+						    cont_size, prot);
+			if (ret)
+				break;
+		}
+
+		iova += cont_size;
+		size -= cont_size;
+	}
+
+	return ret;
+}
+
+static int arm_smmu_switch_dirty_log(struct iommu_domain *domain, bool enable,
+				     unsigned long iova, size_t size, int prot)
+{
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+
+	if (!(smmu->features & ARM_SMMU_FEAT_HD))
+		return -ENODEV;
+	if (smmu_domain->stage != ARM_SMMU_DOMAIN_S1)
+		return -EINVAL;
+
+	if (enable) {
+		/*
+		 * For SMMU, the hardware dirty management is always enabled if
+		 * hardware supports HTTU HD. The action to start dirty log is
+		 * spliting block mapping.
+		 *
+		 * We don't return error even if the split operation fail, as we
+		 * can still track dirty at block granule, which is still a much
+		 * better choice compared to full dirty policy.
+		 */
+		arm_smmu_split_block(domain, iova, size);
+	} else {
+		/*
+		 * For SMMU, the hardware dirty management is always enabled if
+		 * hardware supports HTTU HD. The action to stop dirty log is
+		 * merging page mapping.
+		 *
+		 * We don't return error even if the merge operation fail, as it
+		 * just effects performace of DMA transaction.
+		 */
+		arm_smmu_merge_page(domain, iova, size, prot);
+	}
+
+	return 0;
+}
+
 static int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args *args)
 {
 	return iommu_fwspec_add_ids(dev, args->args, 1);
@@ -2678,6 +2819,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.release_device		= arm_smmu_release_device,
 	.device_group		= arm_smmu_device_group,
 	.enable_nesting		= arm_smmu_enable_nesting,
+	.switch_dirty_log	= arm_smmu_switch_dirty_log,
 	.of_xlate		= arm_smmu_of_xlate,
 	.get_resv_regions	= arm_smmu_get_resv_regions,
 	.put_resv_regions	= generic_iommu_put_resv_regions,
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 0d15620d1e90..bb19df2317ed 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2375,8 +2375,8 @@ phys_addr_t iommu_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova)
 }
 EXPORT_SYMBOL_GPL(iommu_iova_to_phys);
 
-static size_t iommu_pgsize(struct iommu_domain *domain,
-			   unsigned long addr_merge, size_t size)
+size_t iommu_pgsize(struct iommu_domain *domain,
+		    unsigned long addr_merge, size_t size)
 {
 	unsigned int pgsize_idx;
 	size_t pgsize;
@@ -2406,6 +2406,7 @@ static size_t iommu_pgsize(struct iommu_domain *domain,
 
 	return pgsize;
 }
+EXPORT_SYMBOL_GPL(iommu_pgsize);
 
 static int __iommu_map(struct iommu_domain *domain, unsigned long iova,
 		       phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index e0e40dda974d..0a77db4f397f 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -427,6 +427,8 @@ extern int iommu_sva_unbind_gpasid(struct iommu_domain *domain,
 				   struct device *dev, ioasid_t pasid);
 extern struct iommu_domain *iommu_get_domain_for_dev(struct device *dev);
 extern struct iommu_domain *iommu_get_dma_domain(struct device *dev);
+extern size_t iommu_pgsize(struct iommu_domain *domain,
+			   unsigned long addr_merge, size_t size);
 extern int iommu_map(struct iommu_domain *domain, unsigned long iova,
 		     phys_addr_t paddr, size_t size, int prot);
 extern int iommu_map_atomic(struct iommu_domain *domain, unsigned long iova,
-- 
2.19.1

