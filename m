Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC332399DA8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 11:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbhFCJYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 05:24:44 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3405 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbhFCJYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 05:24:41 -0400
Received: from dggeme759-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4FwgM135Q0z662R;
        Thu,  3 Jun 2021 17:19:09 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggeme759-chm.china.huawei.com (10.3.19.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 3 Jun 2021 17:22:54 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <andriy.shevchenko@linux.intel.com>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>, <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <jonathan.cameron@huawei.com>,
        <song.bao.hua@hisilicon.com>, Tian Tao <tiantao6@hisilicon.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stefano Brivio <sbrivio@redhat.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        "Ma, Jianpeng" <jianpeng.ma@intel.com>,
        Yury Norov <yury.norov@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH v3 1/3] lib: bitmap: introduce bitmap_print_to_buf
Date:   Thu, 3 Jun 2021 17:22:40 +0800
Message-ID: <1622712162-7028-2-git-send-email-tiantao6@hisilicon.com>
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

New API bitmap_print_to_buf() with bin_attribute to avoid maskp
exceeding PAGE_SIZE. bitmap_print_to_pagebuf() is a special case
of bitmap_print_to_buf(), so in bitmap_print_to_pagebuf() call
bitmap_print_to_buf().

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
---
 include/linux/bitmap.h  |  2 ++
 include/linux/cpumask.h | 21 +++++++++++++++++++++
 lib/bitmap.c            | 37 +++++++++++++++++++++++++++++++++++--
 3 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index a36cfce..0de6eff 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -226,6 +226,8 @@ void bitmap_copy_le(unsigned long *dst, const unsigned long *src, unsigned int n
 unsigned int bitmap_ord_to_pos(const unsigned long *bitmap, unsigned int ord, unsigned int nbits);
 int bitmap_print_to_pagebuf(bool list, char *buf,
 				   const unsigned long *maskp, int nmaskbits);
+int bitmap_print_to_buf(bool list, char *buf, const unsigned long *maskp,
+			int nmaskbits, loff_t off, size_t count);
 
 #define BITMAP_FIRST_WORD_MASK(start) (~0UL << ((start) & (BITS_PER_LONG - 1)))
 #define BITMAP_LAST_WORD_MASK(nbits) (~0UL >> (-(nbits) & (BITS_PER_LONG - 1)))
diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index bfc4690..1bef69e 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -983,6 +983,27 @@ cpumap_print_to_pagebuf(bool list, char *buf, const struct cpumask *mask)
 				      nr_cpu_ids);
 }
 
+/**
+ * cpumap_print_to_buf  - copies the cpumask into the buffer either
+ *      as comma-separated list of cpus or hex values of cpumask
+ * @list: indicates whether the cpumap must be list
+ * @mask: the cpumask to copy
+ * @buf: the buffer to copy into
+ * @off: in the string from which we are copying, We copy to @buf + off
+ * @count: the maximum number of bytes to print
+ *
+ * The role of cpumap_print_to_buf() and cpumap_print_to_pagebuf() is
+ * the same, the difference is that buf of bitmap_print_to_buf()
+ * can be more than one pagesize.
+ */
+static inline ssize_t
+cpumap_print_to_buf(bool list, char *buf, const struct cpumask *mask,
+		    loff_t off, size_t count)
+{
+	return bitmap_print_to_buf(list, buf, cpumask_bits(mask),
+				   nr_cpu_ids, off, count);
+}
+
 #if NR_CPUS <= BITS_PER_LONG
 #define CPU_MASK_ALL							\
 (cpumask_t) { {								\
diff --git a/lib/bitmap.c b/lib/bitmap.c
index 9401d39..c64407e 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -462,6 +462,40 @@ int bitmap_parse_user(const char __user *ubuf,
 EXPORT_SYMBOL(bitmap_parse_user);
 
 /**
+ * bitmap_print_to_buf - convert bitmap to list or hex format ASCII string
+ * @list: indicates whether the bitmap must be list
+ * @buf: the kernel space buffer to read to
+ * @maskp: pointer to bitmap to convert
+ * @nmaskbits: size of bitmap, in bits
+ * @off: offset in data buffer below
+ * @count: the maximum number of bytes to print
+ *
+ * The role of bitmap_print_to_buf() and bitmap_print_to_pagebuf() is
+ * the same, the difference is that buf of bitmap_print_to_buf()
+ * can be more than one pagesize.
+ */
+int bitmap_print_to_buf(bool list, char *buf, const unsigned long *maskp,
+			int nmaskbits, loff_t off, size_t count)
+{
+	const char *fmt = list ? "%*pbl\n" : "%*pb\n";
+	ssize_t size;
+	void *data;
+
+	if (off == LLONG_MAX && count == PAGE_SIZE - offset_in_page(buf))
+		return scnprintf(buf, count, fmt, nmaskbits, maskp);
+
+	data = kasprintf(GFP_KERNEL, fmt, nmaskbits, maskp);
+	if (!data)
+		return -ENOMEM;
+
+	size = memory_read_from_buffer(buf, count, &off, data, strlen(data) + 1);
+	kfree(data);
+
+	return size;
+}
+EXPORT_SYMBOL(bitmap_print_to_buf);
+
+/**
  * bitmap_print_to_pagebuf - convert bitmap to list or hex format ASCII string
  * @list: indicates whether the bitmap must be list
  * @buf: page aligned buffer into which string is placed
@@ -482,8 +516,7 @@ int bitmap_print_to_pagebuf(bool list, char *buf, const unsigned long *maskp,
 {
 	ptrdiff_t len = PAGE_SIZE - offset_in_page(buf);
 
-	return list ? scnprintf(buf, len, "%*pbl\n", nmaskbits, maskp) :
-		      scnprintf(buf, len, "%*pb\n", nmaskbits, maskp);
+	return bitmap_print_to_buf(list, buf, maskp, nmaskbits, LLONG_MAX, len);
 }
 EXPORT_SYMBOL(bitmap_print_to_pagebuf);
 
-- 
2.7.4

