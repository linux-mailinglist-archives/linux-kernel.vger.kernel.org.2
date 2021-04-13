Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1013D35DA82
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 10:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244816AbhDMI4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 04:56:12 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:16543 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244032AbhDMIzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 04:55:41 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FKK9k0wc6zPqbY;
        Tue, 13 Apr 2021 16:52:26 +0800 (CST)
Received: from DESKTOP-5IS4806.china.huawei.com (10.174.187.224) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Tue, 13 Apr 2021 16:55:07 +0800
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
Subject: [PATCH v3 02/12] iommu: Add iommu_split_block interface
Date:   Tue, 13 Apr 2021 16:54:47 +0800
Message-ID: <20210413085457.25400-3-zhukeqian1@huawei.com>
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

Block(largepage) mapping is not a proper granule for dirty log tracking.
Take an extreme example, if DMA writes one byte, under 1G mapping, the
dirty amount reported is 1G, but under 4K mapping, the dirty amount is
just 4K.

This adds a new interface named iommu_split_block in IOMMU base layer.
A specific IOMMU driver can invoke it during start dirty log. If so, the
driver also need to realize the split_block iommu ops.

We flush all iotlbs after the whole procedure is completed to ease the
pressure of IOMMU, as we will hanle a huge range of mapping in general.

Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Kunkun Jiang <jiangkunkun@huawei.com>
---
 drivers/iommu/iommu.c | 41 +++++++++++++++++++++++++++++++++++++++++
 include/linux/iommu.h | 11 +++++++++++
 2 files changed, 52 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 667b2d6d2fc0..bb413a927870 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2721,6 +2721,47 @@ int iommu_domain_set_attr(struct iommu_domain *domain,
 }
 EXPORT_SYMBOL_GPL(iommu_domain_set_attr);
 
+int iommu_split_block(struct iommu_domain *domain, unsigned long iova,
+		      size_t size)
+{
+	const struct iommu_ops *ops = domain->ops;
+	unsigned int min_pagesz;
+	size_t pgsize;
+	bool flush = false;
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
+		flush = true;
+
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
+
+	if (flush)
+		iommu_flush_iotlb_all(domain);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_split_block);
+
 int iommu_switch_dirty_log(struct iommu_domain *domain, bool enable,
 			   unsigned long iova, size_t size, int prot)
 {
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 7f9ed9f520e2..c6c90ac069e3 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -208,6 +208,7 @@ struct iommu_iotlb_gather {
  * @device_group: find iommu group for a particular device
  * @domain_get_attr: Query domain attributes
  * @domain_set_attr: Change domain attributes
+ * @split_block: Split block mapping into page mapping
  * @switch_dirty_log: Perform actions to start|stop dirty log tracking
  * @sync_dirty_log: Sync dirty log from IOMMU into a dirty bitmap
  * @clear_dirty_log: Clear dirty log of IOMMU by a mask bitmap
@@ -267,6 +268,8 @@ struct iommu_ops {
 			       enum iommu_attr attr, void *data);
 
 	/* Track dirty log */
+	int (*split_block)(struct iommu_domain *domain, unsigned long iova,
+			   size_t size);
 	int (*switch_dirty_log)(struct iommu_domain *domain, bool enable,
 				unsigned long iova, size_t size, int prot);
 	int (*sync_dirty_log)(struct iommu_domain *domain,
@@ -529,6 +532,8 @@ extern int iommu_domain_get_attr(struct iommu_domain *domain, enum iommu_attr,
 				 void *data);
 extern int iommu_domain_set_attr(struct iommu_domain *domain, enum iommu_attr,
 				 void *data);
+extern int iommu_split_block(struct iommu_domain *domain, unsigned long iova,
+			     size_t size);
 extern int iommu_switch_dirty_log(struct iommu_domain *domain, bool enable,
 				  unsigned long iova, size_t size, int prot);
 extern int iommu_sync_dirty_log(struct iommu_domain *domain, unsigned long iova,
@@ -929,6 +934,12 @@ static inline int iommu_domain_set_attr(struct iommu_domain *domain,
 	return -EINVAL;
 }
 
+static inline int iommu_split_block(struct iommu_domain *domain,
+				    unsigned long iova, size_t size)
+{
+	return -EINVAL;
+}
+
 static inline int iommu_switch_dirty_log(struct iommu_domain *domain,
 					 bool enable, unsigned long iova,
 					 size_t size, int prot)
-- 
2.19.1

