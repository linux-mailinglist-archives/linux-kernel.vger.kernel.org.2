Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20AC13AB142
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 12:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbhFQKWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 06:22:41 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:7466 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232093AbhFQKWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 06:22:38 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G5Hzr3qClzZhvq;
        Thu, 17 Jun 2021 18:17:28 +0800 (CST)
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Thu, 17 Jun 2021 18:20:24 +0800
Received: from SWX921481.china.huawei.com (10.126.201.234) by
 dggemi761-chm.china.huawei.com (10.1.198.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 17 Jun 2021 18:20:18 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <gregkh@linuxfoundation.org>, <andriy.shevchenko@linux.intel.com>,
        <linux-kernel@vger.kernel.org>
CC:     <linux@rasmusvillemoes.dk>, <rafael@kernel.org>,
        <akpm@linux-foundation.org>, <rdunlap@infradead.org>,
        <agordeev@linux.ibm.com>, <sbrivio@redhat.com>,
        <jianpeng.ma@intel.com>, <yury.norov@gmail.com>,
        <valentin.schneider@arm.com>, <peterz@infradead.org>,
        <bristot@redhat.com>, <guodong.xu@linaro.org>,
        <tangchengchang@huawei.com>, <prime.zeng@hisilicon.com>,
        <yangyicong@huawei.com>, <tim.c.chen@linux.intel.com>,
        <tiantao6@hisilicon.com>, <Jonathan.Cameron@huawei.com>,
        <linuxarm@huawei.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v4 3/4] drivers/base/node.c: use bin_attribute to avoid buff overflow
Date:   Thu, 17 Jun 2021 22:19:09 +1200
Message-ID: <20210617101910.13228-4-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20210617101910.13228-1-song.bao.hua@hisilicon.com>
References: <20210617101910.13228-1-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.201.234]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggemi761-chm.china.huawei.com (10.1.198.147)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tian Tao <tiantao6@hisilicon.com>

Reading sys/devices/system/cpu/cpuX/nodeX/ returns cpumap and cpulist.
However, the size of this file is limited to PAGE_SIZE because of the
limitation for sysfs attribute. so we use bin_attribute instead of
attribute to avoid NR_CPUS too big to cause buff overflow.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
---
 drivers/base/node.c | 52 +++++++++++++++++++++++++++++----------------
 1 file changed, 34 insertions(+), 18 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 2c36f61d30bc..7107e4784df1 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -27,42 +27,45 @@ static struct bus_type node_subsys = {
 };
 
 
-static ssize_t node_read_cpumap(struct device *dev, bool list, char *buf)
+static ssize_t node_read_cpumap(struct device *dev, bool list, char *buf,
+				loff_t off, size_t count)
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
@@ -555,15 +558,28 @@ static ssize_t node_read_distance(struct device *dev,
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
+	NULL
+};
+
+static const struct attribute_group node_dev_group = {
+	.attrs = node_dev_attrs,
+	.bin_attrs = node_dev_bin_attrs
+};
+
+static const struct attribute_group *node_dev_groups[] = {
+	&node_dev_group,
+	NULL
+};
 
 #ifdef CONFIG_HUGETLBFS
 /*
-- 
2.25.1

