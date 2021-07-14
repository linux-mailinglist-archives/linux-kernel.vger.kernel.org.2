Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD503C8313
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 12:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239141AbhGNKot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 06:44:49 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3394 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239128AbhGNKos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 06:44:48 -0400
Received: from fraeml738-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GPtwx3VHcz6D90K;
        Wed, 14 Jul 2021 18:27:29 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml738-chm.china.huawei.com (10.206.15.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 14 Jul 2021 12:41:55 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 14 Jul 2021 11:41:51 +0100
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
Subject: [PATCH v4 1/6] iommu: Refactor iommu_group_store_type()
Date:   Wed, 14 Jul 2021 18:36:38 +0800
Message-ID: <1626259003-201303-2-git-send-email-john.garry@huawei.com>
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

Function iommu_group_store_type() supports changing the default domain
of an IOMMU group.

Many conditions need to be satisfied and steps taken for this action to be
successful.

Satisfying these conditions and steps will be required for setting other
IOMMU group attributes, so factor into a common part and a part specific
to update the IOMMU group attribute.

No functional change intended.

Some code comments are tidied up also.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/iommu/iommu.c | 73 +++++++++++++++++++++++++++----------------
 1 file changed, 46 insertions(+), 27 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 5419c4b9f27a..8a815ac261f0 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3166,20 +3166,23 @@ static int iommu_change_dev_def_domain(struct iommu_group *group,
 }
 
 /*
- * Changing the default domain through sysfs requires the users to ubind the
- * drivers from the devices in the iommu group. Return failure if this doesn't
- * meet.
+ * Changing the default domain or any other IOMMU group attribute through sysfs
+ * requires the users to unbind the drivers from the devices in the IOMMU group.
+ * Return failure if this precondition is not met.
  *
  * We need to consider the race between this and the device release path.
  * device_lock(dev) is used here to guarantee that the device release path
  * will not be entered at the same time.
  */
-static ssize_t iommu_group_store_type(struct iommu_group *group,
-				      const char *buf, size_t count)
+static ssize_t iommu_group_store_common(struct iommu_group *group,
+					const char *buf, size_t count,
+					int (*cb)(const char *buf,
+						  struct iommu_group *group,
+						  struct device *dev))
 {
 	struct group_device *grp_dev;
 	struct device *dev;
-	int ret, req_type;
+	int ret;
 
 	if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
 		return -EACCES;
@@ -3187,25 +3190,16 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
 	if (WARN_ON(!group))
 		return -EINVAL;
 
-	if (sysfs_streq(buf, "identity"))
-		req_type = IOMMU_DOMAIN_IDENTITY;
-	else if (sysfs_streq(buf, "DMA"))
-		req_type = IOMMU_DOMAIN_DMA;
-	else if (sysfs_streq(buf, "auto"))
-		req_type = 0;
-	else
-		return -EINVAL;
-
 	/*
 	 * Lock/Unlock the group mutex here before device lock to
-	 * 1. Make sure that the iommu group has only one device (this is a
+	 * 1. Make sure that the IOMMU group has only one device (this is a
 	 *    prerequisite for step 2)
 	 * 2. Get struct *dev which is needed to lock device
 	 */
 	mutex_lock(&group->mutex);
 	if (iommu_group_device_count(group) != 1) {
 		mutex_unlock(&group->mutex);
-		pr_err_ratelimited("Cannot change default domain: Group has more than one device\n");
+		pr_err_ratelimited("Cannot change IOMMU group default domain attribute: Group has more than one device\n");
 		return -EINVAL;
 	}
 
@@ -3217,16 +3211,16 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
 	/*
 	 * Don't hold the group mutex because taking group mutex first and then
 	 * the device lock could potentially cause a deadlock as below. Assume
-	 * two threads T1 and T2. T1 is trying to change default domain of an
-	 * iommu group and T2 is trying to hot unplug a device or release [1] VF
-	 * of a PCIe device which is in the same iommu group. T1 takes group
-	 * mutex and before it could take device lock assume T2 has taken device
-	 * lock and is yet to take group mutex. Now, both the threads will be
-	 * waiting for the other thread to release lock. Below, lock order was
-	 * suggested.
+	 * two threads, T1 and T2. T1 is trying to change default domain
+	 * attribute of an IOMMU group and T2 is trying to hot unplug a device
+	 * or release [1] VF of a PCIe device which is in the same IOMMU group.
+	 * T1 takes the group mutex and before it could take device lock T2 may
+	 * have taken device lock and is yet to take group mutex. Now, both the
+	 * threads will be waiting for the other thread to release lock. Below,
+	 * lock order was suggested.
 	 * device_lock(dev);
 	 *	mutex_lock(&group->mutex);
-	 *		iommu_change_dev_def_domain();
+	 *		cb->iommu_change_dev_def_domain(); [example cb]
 	 *	mutex_unlock(&group->mutex);
 	 * device_unlock(dev);
 	 *
@@ -3240,7 +3234,7 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
 	 */
 	mutex_unlock(&group->mutex);
 
-	/* Check if the device in the group still has a driver bound to it */
+	/* Check if the only device in the group still has a driver bound */
 	device_lock(dev);
 	if (device_is_bound(dev)) {
 		pr_err_ratelimited("Device is still bound to driver\n");
@@ -3248,7 +3242,7 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
 		goto out;
 	}
 
-	ret = iommu_change_dev_def_domain(group, dev, req_type);
+	ret = (cb)(buf, group, dev);
 	ret = ret ?: count;
 
 out:
@@ -3257,3 +3251,28 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
 
 	return ret;
 }
+
+static int iommu_group_store_type_cb(const char *buf,
+				     struct iommu_group *group,
+				     struct device *dev)
+{
+	int type;
+
+	if (sysfs_streq(buf, "identity"))
+		type = IOMMU_DOMAIN_IDENTITY;
+	else if (sysfs_streq(buf, "DMA"))
+		type = IOMMU_DOMAIN_DMA;
+	else if (sysfs_streq(buf, "auto"))
+		type = 0;
+	else
+		return -EINVAL;
+
+	return iommu_change_dev_def_domain(group, dev, type);
+}
+
+static ssize_t iommu_group_store_type(struct iommu_group *group,
+				      const char *buf, size_t count)
+{
+	return iommu_group_store_common(group, buf, count,
+					iommu_group_store_type_cb);
+}
-- 
2.26.2

