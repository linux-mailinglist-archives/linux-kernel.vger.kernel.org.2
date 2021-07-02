Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4016A3B9E31
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 11:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbhGBJ3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 05:29:07 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:6036 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbhGBJ3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 05:29:06 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GGV1y712TzXlql;
        Fri,  2 Jul 2021 17:21:10 +0800 (CST)
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 2 Jul 2021 17:26:33 +0800
Received: from SWX921481.china.huawei.com (10.126.203.116) by
 dggemi761-chm.china.huawei.com (10.1.198.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 2 Jul 2021 17:26:28 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <gregkh@linuxfoundation.org>, <akpm@linux-foundation.org>,
        <andriy.shevchenko@linux.intel.com>, <linux-kernel@vger.kernel.org>
CC:     <dave.hansen@intel.com>, <yury.norov@gmail.com>,
        <linux@rasmusvillemoes.dk>, <rafael@kernel.org>,
        <rdunlap@infradead.org>, <agordeev@linux.ibm.com>,
        <sbrivio@redhat.com>, <jianpeng.ma@intel.com>,
        <valentin.schneider@arm.com>, <peterz@infradead.org>,
        <bristot@redhat.com>, <guodong.xu@linaro.org>,
        <tangchengchang@huawei.com>, <prime.zeng@hisilicon.com>,
        <yangyicong@huawei.com>, <tim.c.chen@linux.intel.com>,
        <linuxarm@huawei.com>, Tian Tao <tiantao6@hisilicon.com>,
        Barry Song <song.bao.hua@hisilicon.com>
Subject: [PATCH v5 1/3] cpumask: introduce cpumap_print_to_buf to support large bitmask and list
Date:   Fri, 2 Jul 2021 21:25:57 +1200
Message-ID: <20210702092559.8776-2-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20210702092559.8776-1-song.bao.hua@hisilicon.com>
References: <20210702092559.8776-1-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.203.116]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggemi761-chm.china.huawei.com (10.1.198.147)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tian Tao <tiantao6@hisilicon.com>

The existing cpumap_print_to_pagebuf() is used by cpu topology and other
drivers to export hexadecimal bitmask and decimal list to userspace by
sysfs ABI.

Right now, those drivers are using a normal attribute for this kind of
ABIs. A normal attribute typically has show entry as below:

static ssize_t example_dev_show(struct device *dev,
                struct device_attribute *attr, char *buf)
{
	...
        return cpumap_print_to_pagebuf(true, buf, &pmu_mmdc->cpu);
}
show entry of attribute has no offset and count parameters and this
means the file is limited to one page only.

cpumap_print_to_pagebuf() API works terribly well for this kind of
normal attribute with buf parameter and without offset, count:

static inline ssize_t
cpumap_print_to_pagebuf(bool list, char *buf, const struct cpumask *mask)
{
        return bitmap_print_to_pagebuf(list, buf, cpumask_bits(mask),
                                      nr_cpu_ids);
}

The problem is once we have many cpus, we have a chance to make bitmask
or list more than one page. Especially for list, it could be as complex
as 0,3,5,7,9,...... We have no simple way to know it exact size.

It turns out bin_attribute is a way to break this limit. bin_attribute
has show entry as below:
static ssize_t
example_bin_attribute_show(struct file *filp, struct kobject *kobj,
             struct bin_attribute *attr, char *buf,
             loff_t offset, size_t count)
{
        ...
}

With the new offset and count parameters, this makes sysfs ABI be able
to support file size more than one page. For example, offset could be
>= 4096.

This patch introduces cpumap_print_to_buf() so that those drivers can
move to bin_attribute to support large bitmask and list. In result,
we have to pass the corresponding parameters from bin_attribute to this
new API.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Stefano Brivio <sbrivio@redhat.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: "Ma, Jianpeng" <jianpeng.ma@intel.com>
Cc: Yury Norov <yury.norov@gmail.com>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 include/linux/cpumask.h | 19 +++++++++++++++++++
 lib/cpumask.c           | 18 ++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index bfc4690de4f4..24f410a2e793 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -983,6 +983,25 @@ cpumap_print_to_pagebuf(bool list, char *buf, const struct cpumask *mask)
 				      nr_cpu_ids);
 }
 
+/**
+ * cpumap_print_to_buf  - copies the cpumask into the buffer either
+ *      as comma-separated list of cpus or hex values of cpumask;
+ *      Typically used by bin_attribute to export cpumask bitmask and
+ *      list ABI.
+ * @list: indicates whether the cpumap must be list
+ *      true:  print in decimal list format
+ *      fasle: print in hexadecimal bitmask format
+ * @mask: the cpumask to copy
+ * @buf: the buffer to copy into
+ * @off: in the string from which we are copying, We copy to @buf
+ * @count: the maximum number of bytes to print
+ *
+ * Returns the length of how many bytes have been copied.
+ */
+extern ssize_t
+cpumap_print_to_buf(bool list, char *buf, const struct cpumask *mask,
+		    loff_t off, size_t count);
+
 #if NR_CPUS <= BITS_PER_LONG
 #define CPU_MASK_ALL							\
 (cpumask_t) { {								\
diff --git a/lib/cpumask.c b/lib/cpumask.c
index c3c76b833384..40421a6d31bc 100644
--- a/lib/cpumask.c
+++ b/lib/cpumask.c
@@ -279,3 +279,21 @@ int cpumask_any_distribute(const struct cpumask *srcp)
 	return next;
 }
 EXPORT_SYMBOL(cpumask_any_distribute);
+
+ssize_t cpumap_print_to_buf(bool list, char *buf, const struct cpumask *mask,
+		    loff_t off, size_t count)
+{
+	const char *fmt = list ? "%*pbl\n" : "%*pb\n";
+	ssize_t size;
+	void *data;
+
+	data = kasprintf(GFP_KERNEL, fmt, nr_cpu_ids, cpumask_bits(mask));
+	if (!data)
+		return -ENOMEM;
+
+	size = memory_read_from_buffer(buf, count, &off, data, strlen(data) + 1);
+	kfree(data);
+
+	return size;
+}
+EXPORT_SYMBOL(cpumap_print_to_buf);
-- 
2.25.1

