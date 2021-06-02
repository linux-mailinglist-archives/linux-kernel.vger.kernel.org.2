Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD8AC398B03
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 15:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbhFBNu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 09:50:57 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:4287 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbhFBNuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 09:50:54 -0400
Received: from dggeme759-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Fw9HX303Dz1BHDr;
        Wed,  2 Jun 2021 21:44:24 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggeme759-chm.china.huawei.com (10.3.19.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 2 Jun 2021 21:49:06 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <andriy.shevchenko@linux.intel.com>, <akpm@linux-foundation.org>
CC:     <jonathan.cameron@huawei.com>, <song.bao.hua@hisilicon.com>,
        <linux-kernel@vger.kernel.org>, Tian Tao <tiantao6@hisilicon.com>
Subject: [PATCH v2 3/3] drivers/base/node.c: use bin_attribute to avoid buff overflow
Date:   Wed, 2 Jun 2021 21:48:54 +0800
Message-ID: <1622641734-22538-4-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1622641734-22538-1-git-send-email-tiantao6@hisilicon.com>
References: <1622641734-22538-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggeme759-chm.china.huawei.com (10.3.19.105)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reading sys/devices/system/cpu/cpuX/nodeX/ returns cpumap and cpulist.
However, the size of this file is limited to PAGE_SIZE because of the
limitation for sysfs attribute. so we use bin_attribute instead of
attribute to avoid NR_CPUS too big to cause buff overflow.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/base/node.c | 52 ++++++++++++++++++++++++++++++++++------------------
 1 file changed, 34 insertions(+), 18 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index f449dbb..2659bb44 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -27,42 +27,45 @@ static struct bus_type node_subsys = {
 };
 
 
-static ssize_t node_read_cpumap(struct device *dev, bool list, char *buf)
+static ssize_t node_read_cpumap(struct device *dev, bool list,
+				char *buf, loff_t off, size_t count)
 {
 	ssize_t n;
 	cpumask_var_t mask;
 	struct node *node_dev = to_node(dev);
 
-	/* 2008/04/07: buf currently PAGE_SIZE, need 9 chars per 32 bits. */
-	BUILD_BUG_ON((NR_CPUS/32 * 9) > (PAGE_SIZE-1));
-
 	if (!alloc_cpumask_var(&mask, GFP_KERNEL))
 		return 0;
 
 	cpumask_and(mask, cpumask_of_node(node_dev->dev.id), cpu_online_mask);
-	n = cpumap_print_to_pagebuf(list, buf, mask);
+	n = cpumap_print_to_buf(list, buf, mask, off, count);
 	free_cpumask_var(mask);
 
 	return n;
 }
 
-static inline ssize_t cpumap_show(struct device *dev,
-				  struct device_attribute *attr,
-				  char *buf)
+static inline ssize_t cpumap_read(struct file *file, struct kobject *kobj,
+				  struct bin_attribute *attr, char *buf,
+				  loff_t off, size_t count)
 {
-	return node_read_cpumap(dev, false, buf);
+	struct device *dev = kobj_to_dev(kobj);
+
+	return node_read_cpumap(dev, false, buf, off, count);
 }
 
-static DEVICE_ATTR_RO(cpumap);
 
-static inline ssize_t cpulist_show(struct device *dev,
-				   struct device_attribute *attr,
-				   char *buf)
+static BIN_ATTR_RO(cpumap, 0);
+
+static inline ssize_t cpulist_read(struct file *file, struct kobject *kobj,
+				   struct bin_attribute *attr, char *buf,
+				   loff_t off, size_t count)
 {
-	return node_read_cpumap(dev, true, buf);
+	struct device *dev = kobj_to_dev(kobj);
+
+	return node_read_cpumap(dev, true, buf, off, count);
 }
 
-static DEVICE_ATTR_RO(cpulist);
+static BIN_ATTR_RO(cpulist, 0);
 
 /**
  * struct node_access_nodes - Access class device to hold user visible
@@ -557,15 +560,28 @@ static ssize_t node_read_distance(struct device *dev,
 static DEVICE_ATTR(distance, 0444, node_read_distance, NULL);
 
 static struct attribute *node_dev_attrs[] = {
-	&dev_attr_cpumap.attr,
-	&dev_attr_cpulist.attr,
 	&dev_attr_meminfo.attr,
 	&dev_attr_numastat.attr,
 	&dev_attr_distance.attr,
 	&dev_attr_vmstat.attr,
 	NULL
 };
-ATTRIBUTE_GROUPS(node_dev);
+
+static struct bin_attribute *node_dev_bin_attrs[] = {
+	&bin_attr_cpumap,
+	&bin_attr_cpulist,
+	NULL,
+};
+
+static const struct attribute_group node_dev_group = {
+	.attrs = node_dev_attrs,
+	.bin_attrs = node_dev_bin_attrs
+};
+
+static const struct attribute_group *node_dev_groups[] = {
+	&node_dev_group,
+	NULL,
+};
 
 #ifdef CONFIG_HUGETLBFS
 /*
-- 
2.7.4

