Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 934F637639C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 12:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236293AbhEGKYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 06:24:21 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:18345 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233241AbhEGKXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 06:23:40 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Fc5zk2zMMzCqxX;
        Fri,  7 May 2021 18:20:02 +0800 (CST)
Received: from DESKTOP-5IS4806.china.huawei.com (10.174.187.224) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Fri, 7 May 2021 18:22:31 +0800
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
Subject: [RFC PATCH v4 01/13] iommu: Introduce dirty log tracking framework
Date:   Fri, 7 May 2021 18:21:59 +0800
Message-ID: <20210507102211.8836-2-zhukeqian1@huawei.com>
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

Some types of IOMMU are capable of tracking DMA dirty log, such as
ARM SMMU with HTTU or Intel IOMMU with SLADE. This introduces the
dirty log tracking framework in the IOMMU base layer.

Four new essential interfaces are added, and we maintaince the status
of dirty log tracking in iommu_domain.
1. iommu_support_dirty_log: Check whether domain supports dirty log tracking
2. iommu_switch_dirty_log: Perform actions to start|stop dirty log tracking
3. iommu_sync_dirty_log: Sync dirty log from IOMMU into a dirty bitmap
4. iommu_clear_dirty_log: Clear dirty log of IOMMU by a mask bitmap

Note: Don't concurrently call these interfaces with other ops that
access underlying page table.

Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Kunkun Jiang <jiangkunkun@huawei.com>
---
 drivers/iommu/iommu.c        | 201 +++++++++++++++++++++++++++++++++++
 include/linux/iommu.h        |  63 +++++++++++
 include/trace/events/iommu.h |  63 +++++++++++
 3 files changed, 327 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 808ab70d5df5..0d15620d1e90 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1940,6 +1940,7 @@ static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
 	domain->type = type;
 	/* Assume all sizes by default; the driver may override this later */
 	domain->pgsize_bitmap  = bus->iommu_ops->pgsize_bitmap;
+	mutex_init(&domain->switch_log_lock);
 
 	return domain;
 }
@@ -2703,6 +2704,206 @@ int iommu_set_pgtable_quirks(struct iommu_domain *domain,
 }
 EXPORT_SYMBOL_GPL(iommu_set_pgtable_quirks);
 
+bool iommu_support_dirty_log(struct iommu_domain *domain)
+{
+	const struct iommu_ops *ops = domain->ops;
+
+	return ops->support_dirty_log && ops->support_dirty_log(domain);
+}
+EXPORT_SYMBOL_GPL(iommu_support_dirty_log);
+
+int iommu_switch_dirty_log(struct iommu_domain *domain, bool enable,
+			   unsigned long iova, size_t size, int prot)
+{
+	const struct iommu_ops *ops = domain->ops;
+	unsigned long orig_iova = iova;
+	unsigned int min_pagesz;
+	size_t orig_size = size;
+	bool flush = false;
+	int ret = 0;
+
+	if (unlikely(!ops->switch_dirty_log))
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
+	if (enable && domain->dirty_log_tracking) {
+		ret = -EBUSY;
+		goto out;
+	} else if (!enable && !domain->dirty_log_tracking) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	pr_debug("switch_dirty_log %s for: iova 0x%lx size 0x%zx\n",
+		 enable ? "enable" : "disable", iova, size);
+
+	while (size) {
+		size_t pgsize = iommu_pgsize(domain, iova, size);
+
+		flush = true;
+		ret = ops->switch_dirty_log(domain, enable, iova, pgsize, prot);
+		if (ret)
+			break;
+
+		pr_debug("switch_dirty_log handled: iova 0x%lx size 0x%zx\n",
+			 iova, pgsize);
+
+		iova += pgsize;
+		size -= pgsize;
+	}
+
+	if (flush)
+		iommu_flush_iotlb_all(domain);
+
+	if (!ret) {
+		domain->dirty_log_tracking = enable;
+		trace_switch_dirty_log(orig_iova, orig_size, enable);
+	}
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
+	unsigned long orig_iova = iova;
+	unsigned int min_pagesz;
+	size_t orig_size = size;
+	int ret = 0;
+
+	if (unlikely(!ops->sync_dirty_log))
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
+	pr_debug("sync_dirty_log for: iova 0x%lx size 0x%zx\n", iova, size);
+
+	while (size) {
+		size_t pgsize = iommu_pgsize(domain, iova, size);
+
+		ret = ops->sync_dirty_log(domain, iova, pgsize,
+					  bitmap, base_iova, bitmap_pgshift);
+		if (ret)
+			break;
+
+		pr_debug("sync_dirty_log handled: iova 0x%lx size 0x%zx\n",
+			 iova, pgsize);
+
+		iova += pgsize;
+		size -= pgsize;
+	}
+
+	if (!ret)
+		trace_sync_dirty_log(orig_iova, orig_size);
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
+	unsigned long orig_iova = iova;
+	size_t orig_size = size;
+	int ret = 0;
+
+	if (unlikely(!ops->clear_dirty_log))
+		return -ENODEV;
+
+	pr_debug("clear_dirty_log for: iova 0x%lx size 0x%zx\n", iova, size);
+
+	while (size) {
+		size_t pgsize = iommu_pgsize(domain, iova, size);
+
+		ret = ops->clear_dirty_log(domain, iova, pgsize, bitmap,
+					   base_iova, bitmap_pgshift);
+		if (ret)
+			break;
+
+		pr_debug("clear_dirty_log handled: iova 0x%lx size 0x%zx\n",
+			 iova, pgsize);
+
+		iova += pgsize;
+		size -= pgsize;
+	}
+
+	if (!ret)
+		trace_clear_dirty_log(orig_iova, orig_size);
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
+		riova = base_iova + (rs << bitmap_pgshift);
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
index 32d448050bf7..e0e40dda974d 100644
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
@@ -193,6 +195,10 @@ struct iommu_iotlb_gather {
  * @device_group: find iommu group for a particular device
  * @enable_nesting: Enable nesting
  * @set_pgtable_quirks: Set io page table quirks (IO_PGTABLE_QUIRK_*)
+ * @support_dirty_log: Check whether domain supports dirty log tracking
+ * @switch_dirty_log: Perform actions to start|stop dirty log tracking
+ * @sync_dirty_log: Sync dirty log from IOMMU into a dirty bitmap
+ * @clear_dirty_log: Clear dirty log of IOMMU by a mask bitmap
  * @get_resv_regions: Request list of reserved regions for a device
  * @put_resv_regions: Free list of reserved regions for a device
  * @apply_resv_region: Temporary helper call-back for iova reserved ranges
@@ -245,6 +251,22 @@ struct iommu_ops {
 	int (*set_pgtable_quirks)(struct iommu_domain *domain,
 				  unsigned long quirks);
 
+	/*
+	 * Track dirty log. Note: Don't concurrently call these interfaces with
+	 * other ops that access underlying page table.
+	 */
+	bool (*support_dirty_log)(struct iommu_domain *domain);
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
@@ -475,6 +497,17 @@ extern struct iommu_domain *iommu_group_default_domain(struct iommu_group *);
 int iommu_enable_nesting(struct iommu_domain *domain);
 int iommu_set_pgtable_quirks(struct iommu_domain *domain,
 		unsigned long quirks);
+extern bool iommu_support_dirty_log(struct iommu_domain *domain);
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
 
 void iommu_set_dma_strict(bool val);
 bool iommu_get_dma_strict(struct iommu_domain *domain);
@@ -848,6 +881,36 @@ static inline int iommu_set_pgtable_quirks(struct iommu_domain *domain,
 	return 0;
 }
 
+static inline bool iommu_support_dirty_log(struct iommu_domain *domain)
+{
+	return false;
+}
+
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
 static inline int iommu_device_register(struct iommu_device *iommu,
 					const struct iommu_ops *ops,
 					struct device *hwdev)
diff --git a/include/trace/events/iommu.h b/include/trace/events/iommu.h
index 72b4582322ff..6436d693d357 100644
--- a/include/trace/events/iommu.h
+++ b/include/trace/events/iommu.h
@@ -129,6 +129,69 @@ TRACE_EVENT(unmap,
 	)
 );
 
+TRACE_EVENT(switch_dirty_log,
+
+	TP_PROTO(unsigned long iova, size_t size, bool enable),
+
+	TP_ARGS(iova, size, enable),
+
+	TP_STRUCT__entry(
+		__field(u64, iova)
+		__field(size_t, size)
+		__field(bool, enable)
+	),
+
+	TP_fast_assign(
+		__entry->iova = iova;
+		__entry->size = size;
+		__entry->enable = enable;
+	),
+
+	TP_printk("IOMMU: iova=0x%016llx size=%zu enable=%u",
+			__entry->iova, __entry->size, __entry->enable
+	)
+);
+
+TRACE_EVENT(sync_dirty_log,
+
+	TP_PROTO(unsigned long iova, size_t size),
+
+	TP_ARGS(iova, size),
+
+	TP_STRUCT__entry(
+		__field(u64, iova)
+		__field(size_t, size)
+	),
+
+	TP_fast_assign(
+		__entry->iova = iova;
+		__entry->size = size;
+	),
+
+	TP_printk("IOMMU: iova=0x%016llx size=%zu", __entry->iova,
+			__entry->size)
+);
+
+TRACE_EVENT(clear_dirty_log,
+
+	TP_PROTO(unsigned long iova, size_t size),
+
+	TP_ARGS(iova, size),
+
+	TP_STRUCT__entry(
+		__field(u64, iova)
+		__field(size_t, size)
+	),
+
+	TP_fast_assign(
+		__entry->iova = iova;
+		__entry->size = size;
+	),
+
+	TP_printk("IOMMU: iova=0x%016llx size=%zu", __entry->iova,
+			__entry->size)
+);
+
 DECLARE_EVENT_CLASS(iommu_error,
 
 	TP_PROTO(struct device *dev, unsigned long iova, int flags),
-- 
2.19.1

