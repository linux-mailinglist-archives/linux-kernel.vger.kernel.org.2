Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D56A3C831C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 12:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239203AbhGNKpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 06:45:04 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3397 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239182AbhGNKpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 06:45:01 -0400
Received: from fraeml735-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GPv103r7Pz6L7yn;
        Wed, 14 Jul 2021 18:31:00 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml735-chm.china.huawei.com (10.206.15.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 14 Jul 2021 12:42:08 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 14 Jul 2021 11:42:04 +0100
From:   John Garry <john.garry@huawei.com>
To:     <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
        <baolu.lu@linux.intel.com>
CC:     <iommu@lists.linux-foundation.org>, <linuxarm@huawei.com>,
        <thierry.reding@gmail.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <jonathanh@nvidia.com>, <sakari.ailus@linux.intel.com>,
        <bingbu.cao@intel.com>, <tian.shu.qiu@intel.com>,
        <mchehab@kernel.org>, <gregkh@linuxfoundation.org>,
        <digetx@gmail.com>, <mst@redhat.com>, <jasowang@redhat.com>,
        <linux-kernel@vger.kernel.org>, <chenxiang66@hisilicon.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v4 4/6] iommu: Allow max opt DMA len be set for a group via sysfs
Date:   Wed, 14 Jul 2021 18:36:41 +0800
Message-ID: <1626259003-201303-5-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1626259003-201303-1-git-send-email-john.garry@huawei.com>
References: <1626259003-201303-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to allow the maximum optimised DMA len be set for an IOMMU
group via sysfs.

This much the same with the method to change the default domain type for a
group.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 .../ABI/testing/sysfs-kernel-iommu_groups     | 16 ++++++
 drivers/iommu/iommu.c                         | 51 ++++++++++++++++++-
 include/linux/iommu.h                         |  6 +++
 3 files changed, 71 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-kernel-iommu_groups b/Documentation/ABI/testing/sysfs-kernel-iommu_groups
index eae2f1c1e11e..c5a15b768dcc 100644
--- a/Documentation/ABI/testing/sysfs-kernel-iommu_groups
+++ b/Documentation/ABI/testing/sysfs-kernel-iommu_groups
@@ -59,3 +59,19 @@ Description:	/sys/kernel/iommu_groups/<grp_id>/type shows the type of default
 		system could lead to catastrophic effects (the users might
 		need to reboot the machine to get it to normal state). So, it's
 		expected that the users understand what they're doing.
+
+What:		/sys/kernel/iommu_groups/<grp_id>/max_opt_dma_size
+Date:		July 2021
+KernelVersion:	v5.15
+Contact:	John Garry <john.garry@huawei.com>
+Description:	/sys/kernel/iommu_groups/<grp_id>/max_opt_dma_size shows the
+		max optimised DMA size for the default IOMMU domain associated
+		with the group.
+		Each IOMMU domain has an IOVA domain. The IOVA domain caches
+		IOVAs upto a certain size as a performance optimisation.
+		This sysfs file allows the range of the IOVA domain caching be
+		set, such that larger than default IOVAs may be cached.
+		A value of 0 means that the default caching range is chosen.
+		A privileged user could request the kernel the change the range
+		by writing to this file. For this to happen, the same rules
+		and procedure applies as in changing the default domain type.
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index d8198a9aff4e..38ec1c56e00b 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -45,6 +45,7 @@ struct iommu_group {
 	struct iommu_domain *default_domain;
 	struct iommu_domain *domain;
 	struct list_head entry;
+	size_t max_opt_dma_size;
 };
 
 struct group_device {
@@ -86,6 +87,9 @@ static int iommu_create_device_direct_mappings(struct iommu_group *group,
 static struct iommu_group *iommu_group_get_for_dev(struct device *dev);
 static ssize_t iommu_group_store_type(struct iommu_group *group,
 				      const char *buf, size_t count);
+static ssize_t iommu_group_store_max_opt_dma_size(struct iommu_group *group,
+						  const char *buf,
+						  size_t count);
 
 #define IOMMU_GROUP_ATTR(_name, _mode, _show, _store)		\
 struct iommu_group_attribute iommu_group_attr_##_name =		\
@@ -554,6 +558,12 @@ static ssize_t iommu_group_show_type(struct iommu_group *group,
 	return strlen(type);
 }
 
+static ssize_t iommu_group_show_max_opt_dma_size(struct iommu_group *group,
+				     char *buf)
+{
+	return sprintf(buf, "%zu\n", group->max_opt_dma_size);
+}
+
 static IOMMU_GROUP_ATTR(name, S_IRUGO, iommu_group_show_name, NULL);
 
 static IOMMU_GROUP_ATTR(reserved_regions, 0444,
@@ -562,6 +572,9 @@ static IOMMU_GROUP_ATTR(reserved_regions, 0444,
 static IOMMU_GROUP_ATTR(type, 0644, iommu_group_show_type,
 			iommu_group_store_type);
 
+static IOMMU_GROUP_ATTR(max_opt_dma_size, 0644, iommu_group_show_max_opt_dma_size,
+			iommu_group_store_max_opt_dma_size);
+
 static void iommu_group_release(struct kobject *kobj)
 {
 	struct iommu_group *group = to_iommu_group(kobj);
@@ -648,6 +661,10 @@ struct iommu_group *iommu_group_alloc(void)
 	if (ret)
 		return ERR_PTR(ret);
 
+	ret = iommu_group_create_file(group, &iommu_group_attr_max_opt_dma_size);
+	if (ret)
+		return ERR_PTR(ret);
+
 	pr_debug("Allocated group %d\n", group->id);
 
 	return group;
@@ -2279,6 +2296,11 @@ struct iommu_domain *iommu_get_dma_domain(struct device *dev)
 	return dev->iommu_group->default_domain;
 }
 
+size_t iommu_group_get_max_opt_dma_size(struct iommu_group *group)
+{
+	return group->max_opt_dma_size;
+}
+
 /*
  * IOMMU groups are really the natural working unit of the IOMMU, but
  * the IOMMU API works on domains and devices.  Bridge that gap by
@@ -3045,12 +3067,14 @@ EXPORT_SYMBOL_GPL(iommu_sva_get_pasid);
  *	 hasn't changed after the caller has called this function)
  * @type: The type of the new default domain that gets associated with the group
  * @new: Allocate new default domain, keeping same type when no type passed
+ * @max_opt_dma_size: If set, set the IOMMU group max_opt_dma_size when success
  *
  * Returns 0 on success and error code on failure
  *
  */
 static int iommu_change_dev_def_domain(struct iommu_group *group,
-				       struct device *prev_dev, int type, bool new)
+				       struct device *prev_dev, int type, bool new,
+				       unsigned long max_opt_dma_size)
 {
 	struct iommu_domain *prev_dom;
 	struct group_device *grp_dev;
@@ -3143,6 +3167,9 @@ static int iommu_change_dev_def_domain(struct iommu_group *group,
 
 	group->domain = group->default_domain;
 
+	if (max_opt_dma_size)
+		group->max_opt_dma_size = max_opt_dma_size;
+
 	/*
 	 * Release the mutex here because ops->probe_finalize() call-back of
 	 * some vendor IOMMU drivers calls arm_iommu_attach_device() which
@@ -3269,7 +3296,7 @@ static int iommu_group_store_type_cb(const char *buf,
 	else
 		return -EINVAL;
 
-	return iommu_change_dev_def_domain(group, dev, type, false);
+	return iommu_change_dev_def_domain(group, dev, type, false, 0);
 }
 
 static ssize_t iommu_group_store_type(struct iommu_group *group,
@@ -3278,3 +3305,23 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
 	return iommu_group_store_common(group, buf, count,
 					iommu_group_store_type_cb);
 }
+
+static int iommu_group_store_max_opt_dma_size_cb(const char *buf,
+						 struct iommu_group *group,
+						 struct device *dev)
+{
+	unsigned long val;
+
+	if (kstrtoul(buf, 0, &val) || !val)
+		return -EINVAL;
+
+	return iommu_change_dev_def_domain(group, dev, 0, true, val);
+}
+
+static ssize_t iommu_group_store_max_opt_dma_size(struct iommu_group *group,
+						  const char *buf,
+						  size_t count)
+{
+	return iommu_group_store_common(group, buf, count,
+					iommu_group_store_max_opt_dma_size_cb);
+}
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 32d448050bf7..e26abda94792 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -405,6 +405,7 @@ extern int iommu_sva_unbind_gpasid(struct iommu_domain *domain,
 				   struct device *dev, ioasid_t pasid);
 extern struct iommu_domain *iommu_get_domain_for_dev(struct device *dev);
 extern struct iommu_domain *iommu_get_dma_domain(struct device *dev);
+extern size_t iommu_group_get_max_opt_dma_size(struct iommu_group *group);
 extern int iommu_map(struct iommu_domain *domain, unsigned long iova,
 		     phys_addr_t paddr, size_t size, int prot);
 extern int iommu_map_atomic(struct iommu_domain *domain, unsigned long iova,
@@ -653,6 +654,11 @@ static inline struct iommu_domain *iommu_get_domain_for_dev(struct device *dev)
 	return NULL;
 }
 
+static inline size_t iommu_group_get_max_opt_dma_size(struct iommu_group *group)
+{
+	return 0;
+}
+
 static inline int iommu_map(struct iommu_domain *domain, unsigned long iova,
 			    phys_addr_t paddr, size_t size, int prot)
 {
-- 
2.26.2

