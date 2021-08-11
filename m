Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0FA13E8F09
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 12:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237220AbhHKKvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 06:51:43 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:8009 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237180AbhHKKvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 06:51:42 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Gl6784w4WzYlHf;
        Wed, 11 Aug 2021 18:51:00 +0800 (CST)
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 11 Aug 2021 18:51:14 +0800
Received: from SWX921481.china.huawei.com (10.126.200.84) by
 dggemi761-chm.china.huawei.com (10.1.198.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 11 Aug 2021 18:51:09 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <rafael@kernel.org>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <robin.murphy@arm.com>, <will@kernel.org>, <linuxarm@huawei.com>,
        "Barry Song" <song.bao.hua@hisilicon.com>,
        Zhou Wang <wangzhou1@hisilicon.com>
Subject: [PATCH] platform-msi: Add ABI to show msi_irqs of platform devices
Date:   Wed, 11 Aug 2021 22:50:20 +1200
Message-ID: <20210811105020.12980-1-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.200.84]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggemi761-chm.china.huawei.com (10.1.198.147)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just like pci devices have msi_irqs which can be used by userspace irq affinity
tools or applications to bind irqs, platform devices also widely support msi
irqs. For platform devices, for example ARM SMMU, userspaces also care about
its msi irqs as applications can know the mapping between devices and irqs
and then make smarter decision on handling irq affinity. For example, for
SVA mode, it is better to pin io page fault to the numa node applications
are running on. Otherwise, io page fault will get a remote page from the
node iopf happens.
With this patch, a system with multiple arm SMMUs in multiple different numa
node can get the mapping between devices and irqs now:
root@ubuntu:/sys/devices/platform# ls -l arm-smmu-v3.*/msi_irqs/*
-r--r--r-- 1 root root 4096 Aug 11 10:29 arm-smmu-v3.0.auto/msi_irqs/25
-r--r--r-- 1 root root 4096 Aug 11 10:29 arm-smmu-v3.0.auto/msi_irqs/26
-r--r--r-- 1 root root 4096 Aug 11 10:28 arm-smmu-v3.1.auto/msi_irqs/27
-r--r--r-- 1 root root 4096 Aug 11 10:28 arm-smmu-v3.1.auto/msi_irqs/28
-r--r--r-- 1 root root 4096 Aug 11 10:29 arm-smmu-v3.2.auto/msi_irqs/29
-r--r--r-- 1 root root 4096 Aug 11 10:29 arm-smmu-v3.2.auto/msi_irqs/30
-r--r--r-- 1 root root 4096 Aug 11 10:29 arm-smmu-v3.3.auto/msi_irqs/31
-r--r--r-- 1 root root 4096 Aug 11 10:29 arm-smmu-v3.3.auto/msi_irqs/32
-r--r--r-- 1 root root 4096 Aug 11 10:29 arm-smmu-v3.4.auto/msi_irqs/33
-r--r--r-- 1 root root 4096 Aug 11 10:29 arm-smmu-v3.4.auto/msi_irqs/34
-r--r--r-- 1 root root 4096 Aug 11 10:29 arm-smmu-v3.5.auto/msi_irqs/35
-r--r--r-- 1 root root 4096 Aug 11 10:29 arm-smmu-v3.5.auto/msi_irqs/36
-r--r--r-- 1 root root 4096 Aug 11 10:29 arm-smmu-v3.6.auto/msi_irqs/37
-r--r--r-- 1 root root 4096 Aug 11 10:29 arm-smmu-v3.6.auto/msi_irqs/38
-r--r--r-- 1 root root 4096 Aug 11 10:29 arm-smmu-v3.7.auto/msi_irqs/39
-r--r--r-- 1 root root 4096 Aug 11 10:29 arm-smmu-v3.7.auto/msi_irqs/40

Applications can use the mapping and the numa node information to pin
irqs by leveraging the numa information which has also been exported:
root@ubuntu:/sys/devices/platform# cat arm-smmu-v3.0.auto/numa_node
0
root@ubuntu:/sys/devices/platform# cat arm-smmu-v3.4.auto/numa_node
2

Cc: Zhou Wang <wangzhou1@hisilicon.com>
Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 Documentation/ABI/testing/sysfs-bus-platform |  14 +++
 drivers/base/platform-msi.c                  | 122 +++++++++++++++++++++++++++
 2 files changed, 136 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-platform b/Documentation/ABI/testing/sysfs-bus-platform
index 194ca70..4498f89 100644
--- a/Documentation/ABI/testing/sysfs-bus-platform
+++ b/Documentation/ABI/testing/sysfs-bus-platform
@@ -28,3 +28,17 @@ Description:
 		value comes from an ACPI _PXM method or a similar firmware
 		source. Initial users for this file would be devices like
 		arm smmu which are populated by arm64 acpi_iort.
+
+What:		/sys/bus/platform/devices/.../msi_irqs/
+Date:		August 2021
+Contact:	Barry Song <song.bao.hua@hisilicon.com>
+Description:
+		The /sys/devices/.../msi_irqs directory contains a variable set
+		of files, with each file being named after a corresponding msi
+		irq vector allocated to that device.
+
+What:		/sys/bus/platform/devices/.../msi_irqs/<N>
+Date:		August 2021
+Contact:	Barry Song <song.bao.hua@hisilicon.com>
+Description:
+		This attribute will show "msi" if <N> is a valid msi irq
diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
index 0b72b13..6a72ebc 100644
--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -23,6 +23,7 @@
 struct platform_msi_priv_data {
 	struct device		*dev;
 	void 			*host_data;
+	const struct attribute_group    **msi_irq_groups;
 	msi_alloc_info_t	arg;
 	irq_write_msi_msg_t	write_msg;
 	int			devid;
@@ -245,6 +246,120 @@ static void platform_msi_free_priv_data(struct platform_msi_priv_data *data)
 	kfree(data);
 }
 
+static ssize_t platform_msi_show(struct device *dev, struct device_attribute *attr,
+			     char *buf)
+{
+	struct msi_desc *entry;
+	unsigned long irq;
+	int retval;
+
+	retval = kstrtoul(attr->attr.name, 10, &irq);
+	if (retval)
+		return retval;
+
+	entry = irq_get_msi_desc(irq);
+	if (entry)
+		return sprintf(buf, "msi\n");
+
+	return -ENODEV;
+}
+
+static int platform_msi_populate_sysfs(struct device *dev,
+				       int nvec,
+				       struct platform_msi_priv_data *data)
+{
+	struct attribute **msi_attrs;
+	struct attribute *msi_attr;
+	struct device_attribute *msi_dev_attr;
+	struct attribute_group *msi_irq_group;
+	const struct attribute_group **msi_irq_groups;
+	struct msi_desc *entry;
+	int ret = -ENOMEM;
+	int count = 0;
+	int i;
+
+	/* Dynamically create the MSI attributes for the device */
+	msi_attrs = kcalloc(nvec + 1, sizeof(void *), GFP_KERNEL);
+	if (!msi_attrs)
+		return -ENOMEM;
+	for_each_msi_entry(entry, dev) {
+		for (i = 0; i < entry->nvec_used; i++) {
+			msi_dev_attr = kzalloc(sizeof(*msi_dev_attr), GFP_KERNEL);
+			if (!msi_dev_attr)
+				goto error_attrs;
+			msi_attrs[count] = &msi_dev_attr->attr;
+
+			sysfs_attr_init(&msi_dev_attr->attr);
+			msi_dev_attr->attr.name = kasprintf(GFP_KERNEL, "%d",
+							    entry->irq + i);
+			if (!msi_dev_attr->attr.name)
+				goto error_attrs;
+			msi_dev_attr->attr.mode = S_IRUGO;
+			msi_dev_attr->show = platform_msi_show;
+			++count;
+		}
+	}
+
+	msi_irq_group = kzalloc(sizeof(*msi_irq_group), GFP_KERNEL);
+	if (!msi_irq_group)
+		goto error_attrs;
+	msi_irq_group->name = "msi_irqs";
+	msi_irq_group->attrs = msi_attrs;
+
+	msi_irq_groups = kcalloc(2, sizeof(void *), GFP_KERNEL);
+	if (!msi_irq_groups)
+		goto error_irq_group;
+	msi_irq_groups[0] = msi_irq_group;
+
+	ret = sysfs_create_groups(&dev->kobj, msi_irq_groups);
+	if (ret)
+		goto error_irq_groups;
+	data->msi_irq_groups = msi_irq_groups;
+
+	return 0;
+
+error_irq_groups:
+	kfree(msi_irq_groups);
+error_irq_group:
+	kfree(msi_irq_group);
+error_attrs:
+	count = 0;
+	msi_attr = msi_attrs[count];
+	while (msi_attr) {
+		msi_dev_attr = container_of(msi_attr, struct device_attribute, attr);
+		kfree(msi_attr->name);
+		kfree(msi_dev_attr);
+		++count;
+		msi_attr = msi_attrs[count];
+	}
+	kfree(msi_attrs);
+	return ret;
+}
+
+static void platform_msi_destroy_sysfs(struct device *dev,
+				      struct platform_msi_priv_data *data)
+{
+	struct attribute **msi_attrs;
+	struct device_attribute *dev_attr;
+	int count = 0;
+
+	if (data->msi_irq_groups) {
+		sysfs_remove_groups(&dev->kobj, data->msi_irq_groups);
+		msi_attrs = data->msi_irq_groups[0]->attrs;
+		while (msi_attrs[count]) {
+			dev_attr = container_of(msi_attrs[count],
+					struct device_attribute, attr);
+			kfree(dev_attr->attr.name);
+			kfree(dev_attr);
+			++count;
+		}
+		kfree(msi_attrs);
+		kfree(data->msi_irq_groups[0]);
+		kfree(data->msi_irq_groups);
+		data->msi_irq_groups = NULL;
+	}
+}
+
 /**
  * platform_msi_domain_alloc_irqs - Allocate MSI interrupts for @dev
  * @dev:		The device for which to allocate interrupts
@@ -272,8 +387,14 @@ int platform_msi_domain_alloc_irqs(struct device *dev, unsigned int nvec,
 	if (err)
 		goto out_free_desc;
 
+	err = platform_msi_populate_sysfs(dev, nvec, priv_data);
+	if (err)
+		goto out_free_irqs;
+
 	return 0;
 
+out_free_irqs:
+	msi_domain_free_irqs(dev->msi_domain, dev);
 out_free_desc:
 	platform_msi_free_descs(dev, 0, nvec);
 out_free_priv_data:
@@ -293,6 +414,7 @@ void platform_msi_domain_free_irqs(struct device *dev)
 		struct msi_desc *desc;
 
 		desc = first_msi_entry(dev);
+		platform_msi_destroy_sysfs(dev, desc->platform.msi_priv_data);
 		platform_msi_free_priv_data(desc->platform.msi_priv_data);
 	}
 
-- 
1.8.3.1

