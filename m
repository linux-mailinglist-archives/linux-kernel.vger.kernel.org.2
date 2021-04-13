Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93A5C35DA81
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 10:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244689AbhDMI4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 04:56:10 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:16541 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243989AbhDMIzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 04:55:39 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FKK9k0VVxzPqkd;
        Tue, 13 Apr 2021 16:52:26 +0800 (CST)
Received: from DESKTOP-5IS4806.china.huawei.com (10.174.187.224) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Tue, 13 Apr 2021 16:55:08 +0800
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
Subject: [PATCH v3 03/12] iommu: Add iommu_merge_page interface
Date:   Tue, 13 Apr 2021 16:54:48 +0800
Message-ID: <20210413085457.25400-4-zhukeqian1@huawei.com>
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

If block(largepage) mappings are split during start dirty log, then
when stop dirty log, we need to recover them for better DMA performance.

This adds a new interface named iommu_merge_page in IOMMU base layer.
A specific IOMMU driver can invoke it during stop dirty log. If so, the
driver also need to realize the merge_page iommu ops.

We flush all iotlbs after the whole procedure is completed to ease the
pressure of iommu, as we will hanle a huge range of mapping in general.

Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Kunkun Jiang <jiangkunkun@huawei.com>
---
 drivers/iommu/iommu.c | 75 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/iommu.h | 12 +++++++
 2 files changed, 87 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index bb413a927870..8f0d71bafb3a 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2762,6 +2762,81 @@ int iommu_split_block(struct iommu_domain *domain, unsigned long iova,
 }
 EXPORT_SYMBOL_GPL(iommu_split_block);
 
+static int __iommu_merge_page(struct iommu_domain *domain,
+			      unsigned long iova, phys_addr_t paddr,
+			      size_t size, int prot)
+{
+	const struct iommu_ops *ops = domain->ops;
+	unsigned int min_pagesz;
+	size_t pgsize;
+	int ret = 0;
+
+	if (unlikely(!ops || !ops->merge_page))
+		return -ENODEV;
+
+	min_pagesz = 1 << __ffs(domain->pgsize_bitmap);
+	if (!IS_ALIGNED(iova | paddr | size, min_pagesz)) {
+		pr_err("unaligned: iova 0x%lx pa %pa size 0x%zx min_pagesz 0x%x\n",
+			iova, &paddr, size, min_pagesz);
+		return -EINVAL;
+	}
+
+	while (size) {
+		pgsize = iommu_pgsize(domain, iova | paddr, size);
+
+		ret = ops->merge_page(domain, iova, paddr, pgsize, prot);
+		if (ret)
+			break;
+
+		pr_debug("merge handled: iova 0x%lx pa %pa size 0x%zx\n",
+			 iova, &paddr, pgsize);
+
+		iova += pgsize;
+		paddr += pgsize;
+		size -= pgsize;
+	}
+
+	return ret;
+}
+
+int iommu_merge_page(struct iommu_domain *domain, unsigned long iova,
+		     size_t size, int prot)
+{
+	phys_addr_t phys;
+	dma_addr_t p, i;
+	size_t cont_size;
+	bool flush = false;
+	int ret = 0;
+
+	while (size) {
+		flush = true;
+
+		phys = iommu_iova_to_phys(domain, iova);
+		cont_size = PAGE_SIZE;
+		p = phys + cont_size;
+		i = iova + cont_size;
+
+		while (cont_size < size && p == iommu_iova_to_phys(domain, i)) {
+			p += PAGE_SIZE;
+			i += PAGE_SIZE;
+			cont_size += PAGE_SIZE;
+		}
+
+		ret = __iommu_merge_page(domain, iova, phys, cont_size, prot);
+		if (ret)
+			break;
+
+		iova += cont_size;
+		size -= cont_size;
+	}
+
+	if (flush)
+		iommu_flush_iotlb_all(domain);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_merge_page);
+
 int iommu_switch_dirty_log(struct iommu_domain *domain, bool enable,
 			   unsigned long iova, size_t size, int prot)
 {
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index c6c90ac069e3..fea3ecabff3d 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -209,6 +209,7 @@ struct iommu_iotlb_gather {
  * @domain_get_attr: Query domain attributes
  * @domain_set_attr: Change domain attributes
  * @split_block: Split block mapping into page mapping
+ * @merge_page: Merge page mapping into block mapping
  * @switch_dirty_log: Perform actions to start|stop dirty log tracking
  * @sync_dirty_log: Sync dirty log from IOMMU into a dirty bitmap
  * @clear_dirty_log: Clear dirty log of IOMMU by a mask bitmap
@@ -270,6 +271,8 @@ struct iommu_ops {
 	/* Track dirty log */
 	int (*split_block)(struct iommu_domain *domain, unsigned long iova,
 			   size_t size);
+	int (*merge_page)(struct iommu_domain *domain, unsigned long iova,
+			  phys_addr_t phys, size_t size, int prot);
 	int (*switch_dirty_log)(struct iommu_domain *domain, bool enable,
 				unsigned long iova, size_t size, int prot);
 	int (*sync_dirty_log)(struct iommu_domain *domain,
@@ -534,6 +537,8 @@ extern int iommu_domain_set_attr(struct iommu_domain *domain, enum iommu_attr,
 				 void *data);
 extern int iommu_split_block(struct iommu_domain *domain, unsigned long iova,
 			     size_t size);
+extern int iommu_merge_page(struct iommu_domain *domain, unsigned long iova,
+			    size_t size, int prot);
 extern int iommu_switch_dirty_log(struct iommu_domain *domain, bool enable,
 				  unsigned long iova, size_t size, int prot);
 extern int iommu_sync_dirty_log(struct iommu_domain *domain, unsigned long iova,
@@ -940,6 +945,13 @@ static inline int iommu_split_block(struct iommu_domain *domain,
 	return -EINVAL;
 }
 
+static inline int iommu_merge_page(struct iommu_domain *domain,
+				   unsigned long iova, size_t size,
+				   int prot)
+{
+	return -EINVAL;
+}
+
 static inline int iommu_switch_dirty_log(struct iommu_domain *domain,
 					 bool enable, unsigned long iova,
 					 size_t size, int prot)
-- 
2.19.1

