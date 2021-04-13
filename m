Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6306D35DA7B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 10:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244029AbhDMIzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 04:55:40 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:16580 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbhDMIze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 04:55:34 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FKKBK28X6z1BGYr;
        Tue, 13 Apr 2021 16:52:57 +0800 (CST)
Received: from DESKTOP-5IS4806.china.huawei.com (10.174.187.224) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Tue, 13 Apr 2021 16:55:06 +0800
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
Subject: [PATCH v3 01/12] iommu: Introduce dirty log tracking framework
Date:   Tue, 13 Apr 2021 16:54:46 +0800
Message-ID: <20210413085457.25400-2-zhukeqian1@huawei.com>
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

Some types of IOMMU are capable of tracking DMA dirty log, such as
ARM SMMU with HTTU or Intel IOMMU with SLADE. This introduces the
dirty log tracking framework in the IOMMU base layer.

Three new essential interfaces are added, and we maintaince the status
of dirty log tracking in iommu_domain.
1. iommu_switch_dirty_log: Perform actions to start|stop dirty log tracking
2. iommu_sync_dirty_log: Sync dirty log from IOMMU into a dirty bitmap
3. iommu_clear_dirty_log: Clear dirty log of IOMMU by a mask bitmap

A new dev feature are added to indicate whether a specific type of
iommu hardware supports and its driver realizes them.

Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Kunkun Jiang <jiangkunkun@huawei.com>
---
 drivers/iommu/iommu.c | 150 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/iommu.h |  53 +++++++++++++++
 2 files changed, 203 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index d0b0a15dba84..667b2d6d2fc0 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1922,6 +1922,7 @@ static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
 	domain->type = type;
 	/* Assume all sizes by default; the driver may override this later */
 	domain->pgsize_bitmap  = bus->iommu_ops->pgsize_bitmap;
+	mutex_init(&domain->switch_log_lock);
 
 	return domain;
 }
@@ -2720,6 +2721,155 @@ int iommu_domain_set_attr(struct iommu_domain *domain,
 }
 EXPORT_SYMBOL_GPL(iommu_domain_set_attr);
 
+int iommu_switch_dirty_log(struct iommu_domain *domain, bool enable,
+			   unsigned long iova, size_t size, int prot)
+{
+	const struct iommu_ops *ops = domain->ops;
+	int ret;
+
+	if (unlikely(!ops || !ops->switch_dirty_log))
+		return -ENODEV;
+
+	mutex_lock(&domain->switch_log_lock);
+	if (enable && domain->dirty_log_tracking) {
+		ret = -EBUSY;
+		goto out;
+	} else if (!enable && !domain->dirty_log_tracking) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = ops->switch_dirty_log(domain, enable, iova, size, prot);
+	if (ret)
+		goto out;
+
+	domain->dirty_log_tracking = enable;
+out:
+	mutex_unlock(&domain->switch_log_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_switch_dirty_log);
+
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
+	mutex_lock(&domain->switch_log_lock);
+	if (!domain->dirty_log_tracking) {
+		ret = -EINVAL;
+		goto out;
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
+out:
+	mutex_unlock(&domain->switch_log_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_sync_dirty_log);
+
+static int __iommu_clear_dirty_log(struct iommu_domain *domain,
+				   unsigned long iova, size_t size,
+				   unsigned long *bitmap,
+				   unsigned long base_iova,
+				   unsigned long bitmap_pgshift)
+{
+	const struct iommu_ops *ops = domain->ops;
+	size_t pgsize;
+	int ret = 0;
+
+	if (unlikely(!ops || !ops->clear_dirty_log))
+		return -ENODEV;
+
+	while (size) {
+		pgsize = iommu_pgsize(domain, iova, size);
+
+		ret = ops->clear_dirty_log(domain, iova, pgsize, bitmap,
+					   base_iova, bitmap_pgshift);
+		if (ret)
+			break;
+
+		pr_debug("dirty_log_clear handled: iova 0x%lx pagesz 0x%zx\n",
+			 iova, pgsize);
+
+		iova += pgsize;
+		size -= pgsize;
+	}
+
+	return ret;
+}
+
+int iommu_clear_dirty_log(struct iommu_domain *domain,
+			  unsigned long iova, size_t size,
+			  unsigned long *bitmap, unsigned long base_iova,
+			  unsigned long bitmap_pgshift)
+{
+	unsigned long riova, rsize;
+	unsigned int min_pagesz;
+	bool flush = false;
+	int rs, re, start, end;
+	int ret = 0;
+
+	min_pagesz = 1 << __ffs(domain->pgsize_bitmap);
+	if (!IS_ALIGNED(iova | size, min_pagesz)) {
+		pr_err("unaligned: iova 0x%lx min_pagesz 0x%x\n",
+		       iova, min_pagesz);
+		return -EINVAL;
+	}
+
+	mutex_lock(&domain->switch_log_lock);
+	if (!domain->dirty_log_tracking) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	start = (iova - base_iova) >> bitmap_pgshift;
+	end = start + (size >> bitmap_pgshift);
+	bitmap_for_each_set_region(bitmap, rs, re, start, end) {
+		flush = true;
+		riova = iova + (rs << bitmap_pgshift);
+		rsize = (re - rs) << bitmap_pgshift;
+		ret = __iommu_clear_dirty_log(domain, riova, rsize, bitmap,
+					      base_iova, bitmap_pgshift);
+		if (ret)
+			break;
+	}
+
+	if (flush)
+		iommu_flush_iotlb_all(domain);
+out:
+	mutex_unlock(&domain->switch_log_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_clear_dirty_log);
+
 void iommu_get_resv_regions(struct device *dev, struct list_head *list)
 {
 	const struct iommu_ops *ops = dev->bus->iommu_ops;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 5e7fe519430a..7f9ed9f520e2 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -87,6 +87,8 @@ struct iommu_domain {
 	void *handler_token;
 	struct iommu_domain_geometry geometry;
 	void *iova_cookie;
+	bool dirty_log_tracking;
+	struct mutex switch_log_lock;
 };
 
 enum iommu_cap {
@@ -160,6 +162,7 @@ struct iommu_resv_region {
 enum iommu_dev_features {
 	IOMMU_DEV_FEAT_AUX,	/* Aux-domain feature */
 	IOMMU_DEV_FEAT_SVA,	/* Shared Virtual Addresses */
+	IOMMU_DEV_FEAT_HWDBM,	/* Hardware Dirty Bit Management */
 };
 
 #define IOMMU_PASID_INVALID	(-1U)
@@ -205,6 +208,9 @@ struct iommu_iotlb_gather {
  * @device_group: find iommu group for a particular device
  * @domain_get_attr: Query domain attributes
  * @domain_set_attr: Change domain attributes
+ * @switch_dirty_log: Perform actions to start|stop dirty log tracking
+ * @sync_dirty_log: Sync dirty log from IOMMU into a dirty bitmap
+ * @clear_dirty_log: Clear dirty log of IOMMU by a mask bitmap
  * @get_resv_regions: Request list of reserved regions for a device
  * @put_resv_regions: Free list of reserved regions for a device
  * @apply_resv_region: Temporary helper call-back for iova reserved ranges
@@ -260,6 +266,18 @@ struct iommu_ops {
 	int (*domain_set_attr)(struct iommu_domain *domain,
 			       enum iommu_attr attr, void *data);
 
+	/* Track dirty log */
+	int (*switch_dirty_log)(struct iommu_domain *domain, bool enable,
+				unsigned long iova, size_t size, int prot);
+	int (*sync_dirty_log)(struct iommu_domain *domain,
+			      unsigned long iova, size_t size,
+			      unsigned long *bitmap, unsigned long base_iova,
+			      unsigned long bitmap_pgshift);
+	int (*clear_dirty_log)(struct iommu_domain *domain,
+			       unsigned long iova, size_t size,
+			       unsigned long *bitmap, unsigned long base_iova,
+			       unsigned long bitmap_pgshift);
+
 	/* Request/Free a list of reserved regions for a device */
 	void (*get_resv_regions)(struct device *dev, struct list_head *list);
 	void (*put_resv_regions)(struct device *dev, struct list_head *list);
@@ -511,6 +529,16 @@ extern int iommu_domain_get_attr(struct iommu_domain *domain, enum iommu_attr,
 				 void *data);
 extern int iommu_domain_set_attr(struct iommu_domain *domain, enum iommu_attr,
 				 void *data);
+extern int iommu_switch_dirty_log(struct iommu_domain *domain, bool enable,
+				  unsigned long iova, size_t size, int prot);
+extern int iommu_sync_dirty_log(struct iommu_domain *domain, unsigned long iova,
+				size_t size, unsigned long *bitmap,
+				unsigned long base_iova,
+				unsigned long bitmap_pgshift);
+extern int iommu_clear_dirty_log(struct iommu_domain *domain, unsigned long iova,
+				 size_t dma_size, unsigned long *bitmap,
+				 unsigned long base_iova,
+				 unsigned long bitmap_pgshift);
 
 /* Window handling function prototypes */
 extern int iommu_domain_window_enable(struct iommu_domain *domain, u32 wnd_nr,
@@ -901,6 +929,31 @@ static inline int iommu_domain_set_attr(struct iommu_domain *domain,
 	return -EINVAL;
 }
 
+static inline int iommu_switch_dirty_log(struct iommu_domain *domain,
+					 bool enable, unsigned long iova,
+					 size_t size, int prot)
+{
+	return -EINVAL;
+}
+
+static inline int iommu_sync_dirty_log(struct iommu_domain *domain,
+				       unsigned long iova, size_t size,
+				       unsigned long *bitmap,
+				       unsigned long base_iova,
+				       unsigned long pgshift)
+{
+	return -EINVAL;
+}
+
+static inline int iommu_clear_dirty_log(struct iommu_domain *domain,
+					unsigned long iova, size_t size,
+					unsigned long *bitmap,
+					unsigned long base_iova,
+					unsigned long pgshift)
+{
+	return -EINVAL;
+}
+
 static inline int  iommu_device_register(struct iommu_device *iommu)
 {
 	return -ENODEV;
-- 
2.19.1

