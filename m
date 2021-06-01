Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40597396BB0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 04:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232789AbhFAC6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 22:58:51 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3361 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232516AbhFAC6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 22:58:46 -0400
Received: from dggeme759-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4FvGtl1579z65ll;
        Tue,  1 Jun 2021 10:53:19 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggeme759-chm.china.huawei.com (10.3.19.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 1 Jun 2021 10:57:02 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <akpm@linux-foundation.org>, <song.bao.hua@hisilicon.com>
CC:     Tian Tao <tiantao6@hisilicon.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 2/2] drivers/base/node.c: use bin_attribute to avoid buff overflow
Date:   Tue, 1 Jun 2021 10:56:50 +0800
Message-ID: <1622516210-10886-3-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1622516210-10886-1-git-send-email-tiantao6@hisilicon.com>
References: <1622516210-10886-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
---
 drivers/base/node.c | 49 +++++++++++++++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 18 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index f449dbb..a19be64 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -27,42 +27,42 @@ static struct bus_type node_subsys = {
 };
 
 
-static ssize_t node_read_cpumap(struct device *dev, bool list, char *buf)
+static ssize_t node_read_cpumap(struct kobject *kobj, bool list,
+				char *buf, loff_t off, size_t count)
 {
 	ssize_t n;
 	cpumask_var_t mask;
+	struct device *dev = kobj_to_dev(kobj);
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
+	return node_read_cpumap(kobj, false, buf, off, count);
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
+	return node_read_cpumap(kobj, true, buf, off, count);
 }
 
-static DEVICE_ATTR_RO(cpulist);
+static BIN_ATTR_RO(cpulist, 0);
 
 /**
  * struct node_access_nodes - Access class device to hold user visible
@@ -557,15 +557,28 @@ static ssize_t node_read_distance(struct device *dev,
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

