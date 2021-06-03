Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D30B6399DAA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 11:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbhFCJYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 05:24:47 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3406 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbhFCJYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 05:24:41 -0400
Received: from dggeme759-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4FwgM14J1mz66YF;
        Thu,  3 Jun 2021 17:19:09 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggeme759-chm.china.huawei.com (10.3.19.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 3 Jun 2021 17:22:54 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <andriy.shevchenko@linux.intel.com>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>, <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <jonathan.cameron@huawei.com>,
        <song.bao.hua@hisilicon.com>, Tian Tao <tiantao6@hisilicon.com>
Subject: [PATCH v3 2/3] topology: use bin_attribute to avoid buff overflow
Date:   Thu, 3 Jun 2021 17:22:41 +0800
Message-ID: <1622712162-7028-3-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1622712162-7028-1-git-send-email-tiantao6@hisilicon.com>
References: <1622712162-7028-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggeme759-chm.china.huawei.com (10.3.19.105)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reading sys/devices/system/cpu/cpuX/topology/ returns cpu topology.
However, the size of this file is limited to PAGE_SIZE because of the
limitation for sysfs attribute. so we use bin_attribute instead of
attribute to avoid NR_CPUS too big to cause buff overflow.

Link: https://lore.kernel.org/lkml/20210319041618.14316-2-song.bao.hua@hisilicon.com/
Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
---
 drivers/base/topology.c | 115 ++++++++++++++++++++++++++----------------------
 1 file changed, 63 insertions(+), 52 deletions(-)

diff --git a/drivers/base/topology.c b/drivers/base/topology.c
index 4d254fc..dd39801 100644
--- a/drivers/base/topology.c
+++ b/drivers/base/topology.c
@@ -21,25 +21,27 @@ static ssize_t name##_show(struct device *dev,				\
 	return sysfs_emit(buf, "%d\n", topology_##name(dev->id));	\
 }
 
-#define define_siblings_show_map(name, mask)				\
-static ssize_t name##_show(struct device *dev,				\
-			   struct device_attribute *attr, char *buf)	\
-{									\
-	return cpumap_print_to_pagebuf(false, buf, topology_##mask(dev->id));\
+#define define_siblings_read_func(name, mask)					\
+static ssize_t name##_read(struct file *file, struct kobject *kobj,		\
+				  struct bin_attribute *attr, char *buf,	\
+				  loff_t off, size_t count)			\
+{										\
+	struct device *dev = kobj_to_dev(kobj);                                 \
+										\
+	return cpumap_print_to_buf(false, buf, topology_##mask(dev->id),	\
+				   off, count);                                 \
+}										\
+										\
+static ssize_t name##_list_read(struct file *file, struct kobject *kobj,	\
+				  struct bin_attribute *attr, char *buf,	\
+				  loff_t off, size_t count)			\
+{										\
+	struct device *dev = kobj_to_dev(kobj);					\
+										\
+	return cpumap_print_to_buf(true, buf, topology_##mask(dev->id),		\
+				   off, count);					\
 }
 
-#define define_siblings_show_list(name, mask)				\
-static ssize_t name##_list_show(struct device *dev,			\
-				struct device_attribute *attr,		\
-				char *buf)				\
-{									\
-	return cpumap_print_to_pagebuf(true, buf, topology_##mask(dev->id));\
-}
-
-#define define_siblings_show_func(name, mask)	\
-	define_siblings_show_map(name, mask);	\
-	define_siblings_show_list(name, mask)
-
 define_id_show_func(physical_package_id);
 static DEVICE_ATTR_RO(physical_package_id);
 
@@ -49,71 +51,80 @@ static DEVICE_ATTR_RO(die_id);
 define_id_show_func(core_id);
 static DEVICE_ATTR_RO(core_id);
 
-define_siblings_show_func(thread_siblings, sibling_cpumask);
-static DEVICE_ATTR_RO(thread_siblings);
-static DEVICE_ATTR_RO(thread_siblings_list);
+define_siblings_read_func(thread_siblings, sibling_cpumask);
+static BIN_ATTR_RO(thread_siblings, 0);
+static BIN_ATTR_RO(thread_siblings_list, 0);
 
-define_siblings_show_func(core_cpus, sibling_cpumask);
-static DEVICE_ATTR_RO(core_cpus);
-static DEVICE_ATTR_RO(core_cpus_list);
+define_siblings_read_func(core_cpus, sibling_cpumask);
+static BIN_ATTR_RO(core_cpus, 0);
+static BIN_ATTR_RO(core_cpus_list, 0);
 
-define_siblings_show_func(core_siblings, core_cpumask);
-static DEVICE_ATTR_RO(core_siblings);
-static DEVICE_ATTR_RO(core_siblings_list);
+define_siblings_read_func(core_siblings, core_cpumask);
+static BIN_ATTR_RO(core_siblings, 0);
+static BIN_ATTR_RO(core_siblings_list, 0);
 
-define_siblings_show_func(die_cpus, die_cpumask);
-static DEVICE_ATTR_RO(die_cpus);
-static DEVICE_ATTR_RO(die_cpus_list);
+define_siblings_read_func(die_cpus, die_cpumask);
+static BIN_ATTR_RO(die_cpus, 0);
+static BIN_ATTR_RO(die_cpus_list, 0);
 
-define_siblings_show_func(package_cpus, core_cpumask);
-static DEVICE_ATTR_RO(package_cpus);
-static DEVICE_ATTR_RO(package_cpus_list);
+define_siblings_read_func(package_cpus, core_cpumask);
+static BIN_ATTR_RO(package_cpus, 0);
+static BIN_ATTR_RO(package_cpus_list, 0);
 
 #ifdef CONFIG_SCHED_BOOK
 define_id_show_func(book_id);
 static DEVICE_ATTR_RO(book_id);
-define_siblings_show_func(book_siblings, book_cpumask);
-static DEVICE_ATTR_RO(book_siblings);
-static DEVICE_ATTR_RO(book_siblings_list);
+define_siblings_read_func(book_siblings, book_cpumask);
+static BIN_ATTR_RO(book_siblings, 0);
+static BIN_ATTR_RO(book_siblings_list, 0);
 #endif
 
 #ifdef CONFIG_SCHED_DRAWER
 define_id_show_func(drawer_id);
 static DEVICE_ATTR_RO(drawer_id);
-define_siblings_show_func(drawer_siblings, drawer_cpumask);
-static DEVICE_ATTR_RO(drawer_siblings);
-static DEVICE_ATTR_RO(drawer_siblings_list);
+define_siblings_read_func(drawer_siblings, drawer_cpumask);
+static BIN_ATTR_RO(drawer_siblings, 0);
+static BIN_ATTR_RO(drawer_siblings_list, 0);
 #endif
 
+static struct bin_attribute *bin_attrs[] = {
+	&bin_attr_core_cpus,
+	&bin_attr_core_cpus_list,
+	&bin_attr_thread_siblings,
+	&bin_attr_thread_siblings_list,
+	&bin_attr_core_siblings,
+	&bin_attr_core_siblings_list,
+	&bin_attr_die_cpus,
+	&bin_attr_die_cpus_list,
+	&bin_attr_package_cpus,
+	&bin_attr_package_cpus_list,
+#ifdef CONFIG_SCHED_BOOK
+	&bin_attr_book_siblings,
+	&bin_attr_book_siblings_list,
+#endif
+#ifdef CONFIG_SCHED_DRAWER
+	&bin_attr_drawer_siblings,
+	&bin_attr_drawer_siblings_list,
+#endif
+	NULL
+};
+
 static struct attribute *default_attrs[] = {
 	&dev_attr_physical_package_id.attr,
 	&dev_attr_die_id.attr,
 	&dev_attr_core_id.attr,
-	&dev_attr_thread_siblings.attr,
-	&dev_attr_thread_siblings_list.attr,
-	&dev_attr_core_cpus.attr,
-	&dev_attr_core_cpus_list.attr,
-	&dev_attr_core_siblings.attr,
-	&dev_attr_core_siblings_list.attr,
-	&dev_attr_die_cpus.attr,
-	&dev_attr_die_cpus_list.attr,
-	&dev_attr_package_cpus.attr,
-	&dev_attr_package_cpus_list.attr,
 #ifdef CONFIG_SCHED_BOOK
 	&dev_attr_book_id.attr,
-	&dev_attr_book_siblings.attr,
-	&dev_attr_book_siblings_list.attr,
 #endif
 #ifdef CONFIG_SCHED_DRAWER
 	&dev_attr_drawer_id.attr,
-	&dev_attr_drawer_siblings.attr,
-	&dev_attr_drawer_siblings_list.attr,
 #endif
 	NULL
 };
 
 static const struct attribute_group topology_attr_group = {
 	.attrs = default_attrs,
+	.bin_attrs = bin_attrs,
 	.name = "topology"
 };
 
-- 
2.7.4

