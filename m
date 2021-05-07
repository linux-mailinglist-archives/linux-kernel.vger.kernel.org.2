Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E74A93763A2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 12:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236898AbhEGKZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 06:25:12 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:17149 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235988AbhEGKYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 06:24:17 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Fc5z30FQ5zqTB9;
        Fri,  7 May 2021 18:19:27 +0800 (CST)
Received: from DESKTOP-5IS4806.china.huawei.com (10.174.187.224) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Fri, 7 May 2021 18:22:34 +0800
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
Subject: [RFC PATCH v4 04/13] iommu/io-pgtable-arm: Add and realize merge_page ops
Date:   Fri, 7 May 2021 18:22:02 +0800
Message-ID: <20210507102211.8836-5-zhukeqian1@huawei.com>
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

If block(largepage) mappings are split during start dirty log, then
when stop dirty log, we need to recover them for better DMA performance.

This recovers block mappings and unmap the span of page mappings. BBML1
or BBML2 feature is required.

Merging page is designed to be only used by dirty log tracking, which
does not concurrently work with other pgtable ops that access underlying
page table, so race condition does not exist.

Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Kunkun Jiang <jiangkunkun@huawei.com>
---
 drivers/iommu/io-pgtable-arm.c | 78 ++++++++++++++++++++++++++++++++++
 include/linux/io-pgtable.h     |  2 +
 2 files changed, 80 insertions(+)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 664a9548b199..b9f6e3370032 100644
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
+	if (WARN_ON(!size || (size & cfg->pgsize_bitmap) != size))
+		return 0;
+
+	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_TTBR1)
+		iaext = ~iaext;
+	if (WARN_ON(iaext || paddr >> cfg->oas))
+		return 0;
+
+	/* If no access, then nothing to do */
+	if (!(iommu_prot & (IOMMU_READ | IOMMU_WRITE)))
+		return size;
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
index eba6c6ccbe49..e77576d946a2 100644
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

