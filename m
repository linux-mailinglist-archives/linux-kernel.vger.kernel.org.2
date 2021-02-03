Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E256030DEB2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 16:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234603AbhBCPwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 10:52:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234589AbhBCPu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 10:50:57 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129DDC061573
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 07:50:17 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d13so107194plg.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 07:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AA4WsNr/vJqoJohizHJT6F56GEXlyS334FyQjy/hD88=;
        b=Mqjr4f7KulOkUcN0mhsoUSU9j0ls2dF6E4U6BeKR2Lxo6riSwlMf4dllZing9COCLE
         Pkt0994cCGh16YNggJHcnHWSCNhbPX14MIWdMA8Mw1WNFKsN8EH5zIobo3wGKL7wC0Zf
         DIry+wzeAq57KdtEiVn7QCl9Sfc49gLcg6PRR0bvKSoTSfcO7OnC5gmi5KtoSd68/8LO
         pxRPASy70e9M+aEL+c+OY6IakGw/+Ojpo/dqH4QW5FG8Sw2vNeH7ljZp742jsfK0SPY4
         Erx+tfeXQyz2iiAV1yAKsN0/XMXpa1gjOP2J2W1hcDcQAoegGFah/zXcZpoDgeMlbk/z
         in9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=AA4WsNr/vJqoJohizHJT6F56GEXlyS334FyQjy/hD88=;
        b=Muy8DnCIHKVkCbOatwFtjCCw1assSp+HzzNDbBmqEkO02bVnEmAlNk4x8uN9FSlwZr
         nApqK0tNU9RhS5BxxTjoiDYtNSg0DkuVwaY7+WQn63oFS8ETvWPmHq31alsMqNhQkmzG
         OoctXl/s5RVdydTO2zaq6/yb98YiGlDRkAurR8O+2XsIdtE+05s5yakaS3VYHVtrEV3l
         qscFIBRdVYcQhq7Ka6+bAQ2/Mc27gWk9yB/w6hizD28hl6Y5Jg77kvTMzZISCQRRVbxE
         Y0NMNZ+H1KQsIlemd9wTLKkln/mXt13h4ilGiKU87ENpinxnfS59yjo+xQf28nsz7Tcw
         rjYA==
X-Gm-Message-State: AOAM530ABc+C5B1H5ULu6iDqZxPvy1TPn587+DwPk/kuC7Ulva2hxGJY
        xR2nUFjqE0QdZUld8l8+YC4=
X-Google-Smtp-Source: ABdhPJwexbewZbtkXxsN4WEBKBfvrXrJa7iwpz+pVovrXRBBGtMXCuRHNRh4afokzD8YM6pvN8jDIA==
X-Received: by 2002:a17:90a:65c4:: with SMTP id i4mr3627921pjs.132.1612367416495;
        Wed, 03 Feb 2021 07:50:16 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:201:1502:84f8:ffc3:45b])
        by smtp.gmail.com with ESMTPSA id p7sm2692227pfn.52.2021.02.03.07.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 07:50:15 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     gregkh@linuxfoundation.org, surenb@google.com, joaodias@google.com,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Minchan Kim <minchan@kernel.org>
Subject: [PATCH] mm: cma: support sysfs
Date:   Wed,  3 Feb 2021 07:50:01 -0800
Message-Id: <20210203155001.4121868-1-minchan@kernel.org>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since CMA is getting used more widely, it's more important to
keep monitoring CMA statistics for system health since it's
directly related to user experience.

This patch introduces sysfs for the CMA and exposes stats below
to keep monitor for telemetric in the system.

 * the number of CMA allocation attempts
 * the number of CMA allocation failures
 * the number of CMA page allocation attempts
 * the number of CMA page allocation failures

Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 Documentation/ABI/testing/sysfs-kernel-mm-cma |  39 +++++
 include/linux/cma.h                           |   1 +
 mm/Makefile                                   |   1 +
 mm/cma.c                                      |   6 +-
 mm/cma.h                                      |  20 +++
 mm/cma_sysfs.c                                | 143 ++++++++++++++++++
 6 files changed, 209 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-kernel-mm-cma
 create mode 100644 mm/cma_sysfs.c

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-cma b/Documentation/ABI/testing/sysfs-kernel-mm-cma
new file mode 100644
index 000000000000..2a43c0aacc39
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-cma
@@ -0,0 +1,39 @@
+What:		/sys/kernel/mm/cma/
+Date:		Feb 2021
+Contact:	Minchan Kim <minchan@kernel.org>
+Description:
+		/sys/kernel/mm/cma/ contains a number of subdirectories by
+		cma-heap name. The subdirectory contains a number of files
+		to represent cma allocation statistics.
+
+		There are number of files under
+				/sys/kernel/mm/cma/<cma-heap-name> directory
+
+			- cma_alloc_attempt
+			- cma_alloc_fail
+			- alloc_pages_attempt
+			- alloc_pages_fail
+
+What:		/sys/kernel/mm/cma/<cma-heap-name>/cma_alloc_attempt
+Date:		Feb 2021
+Contact:	Minchan Kim <minchan@kernel.org>
+Description:
+		the number of cma_alloc API attempted
+
+What:		/sys/kernel/mm/cma/<cma-heap-name>/cma_alloc_fail
+Date:		Feb 2021
+Contact:	Minchan Kim <minchan@kernel.org>
+Description:
+		the number of CMA_alloc API failed
+
+What:		/sys/kernel/mm/cma/<cma-heap-name>/alloc_pages_attempt
+Date:		Feb 2021
+Contact:	Minchan Kim <minchan@kernel.org>
+Description:
+		the number of pages CMA API tried to allocate
+
+What:		/sys/kernel/mm/cma/<cma-heap-name>/alloc_pages_fail
+Date:		Feb 2021
+Contact:	Minchan Kim <minchan@kernel.org>
+Description:
+		the number of pages CMA API failed to allocate
diff --git a/include/linux/cma.h b/include/linux/cma.h
index 217999c8a762..71a28a5bb54e 100644
--- a/include/linux/cma.h
+++ b/include/linux/cma.h
@@ -49,4 +49,5 @@ extern struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
 extern bool cma_release(struct cma *cma, const struct page *pages, unsigned int count);
 
 extern int cma_for_each_area(int (*it)(struct cma *cma, void *data), void *data);
+
 #endif
diff --git a/mm/Makefile b/mm/Makefile
index b2a564eec27f..9c2c81ce3894 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -106,6 +106,7 @@ obj-$(CONFIG_ZSMALLOC)	+= zsmalloc.o
 obj-$(CONFIG_Z3FOLD)	+= z3fold.o
 obj-$(CONFIG_GENERIC_EARLY_IOREMAP) += early_ioremap.o
 obj-$(CONFIG_CMA)	+= cma.o
+obj-$(CONFIG_SYSFS)     += cma_sysfs.o
 obj-$(CONFIG_MEMORY_BALLOON) += balloon_compaction.o
 obj-$(CONFIG_PAGE_EXTENSION) += page_ext.o
 obj-$(CONFIG_CMA_DEBUGFS) += cma_debug.o
diff --git a/mm/cma.c b/mm/cma.c
index 0ba69cd16aeb..a25068b9d012 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -448,9 +448,10 @@ struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
 	offset = cma_bitmap_aligned_offset(cma, align);
 	bitmap_maxno = cma_bitmap_maxno(cma);
 	bitmap_count = cma_bitmap_pages_to_bits(cma, count);
+	cma_sysfs_alloc_count(cma, count);
 
 	if (bitmap_count > bitmap_maxno)
-		return NULL;
+		goto out;
 
 	for (;;) {
 		mutex_lock(&cma->lock);
@@ -505,6 +506,9 @@ struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
 			__func__, count, ret);
 		cma_debug_show_areas(cma);
 	}
+out:
+	if (!page)
+		cma_sysfs_fail(cma, count);
 
 	pr_debug("%s(): returned %p\n", __func__, page);
 	return page;
diff --git a/mm/cma.h b/mm/cma.h
index 42ae082cb067..e7e31012b44e 100644
--- a/mm/cma.h
+++ b/mm/cma.h
@@ -3,6 +3,16 @@
 #define __MM_CMA_H__
 
 #include <linux/debugfs.h>
+#include <linux/kobject.h>
+
+struct cma_stat {
+	spinlock_t lock;
+	unsigned long alloc_attempt;	/* the number of CMA allocation attempts */
+	unsigned long alloc_fail;	/* the number of CMA allocation failures */
+	unsigned long pages_attempt;	/* the number of CMA page allocation attempts */
+	unsigned long pages_fail;	/* the number of CMA page allocation failures */
+	struct kobject kobj;
+};
 
 struct cma {
 	unsigned long   base_pfn;
@@ -16,6 +26,9 @@ struct cma {
 	struct debugfs_u32_array dfs_bitmap;
 #endif
 	char name[CMA_MAX_NAME];
+#ifdef CONFIG_SYSFS
+	struct cma_stat	*stat;
+#endif
 };
 
 extern struct cma cma_areas[MAX_CMA_AREAS];
@@ -26,4 +39,11 @@ static inline unsigned long cma_bitmap_maxno(struct cma *cma)
 	return cma->count >> cma->order_per_bit;
 }
 
+#ifdef CONFIG_SYSFS
+void cma_sysfs_alloc_count(struct cma *cma, size_t count);
+void cma_sysfs_fail(struct cma *cma, size_t count);
+#else
+static void cma_sysfs_alloc_count(struct cma *cma, size_t count) {};
+static void cma_sysfs_fail(struct cma *cma, size_t count) {};
+#endif
 #endif
diff --git a/mm/cma_sysfs.c b/mm/cma_sysfs.c
new file mode 100644
index 000000000000..66df292cd6ca
--- /dev/null
+++ b/mm/cma_sysfs.c
@@ -0,0 +1,143 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * CMA SysFS Interface
+ *
+ * Copyright (c) 2021 Minchan Kim <minchan@kernel.org>
+ */
+
+#include <linux/cma.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+
+#include "cma.h"
+
+void cma_sysfs_alloc_count(struct cma *cma, size_t count)
+{
+	spin_lock(&cma->stat->lock);
+	cma->stat->alloc_attempt++;
+	cma->stat->pages_attempt += count;
+	spin_unlock(&cma->stat->lock);
+}
+
+void cma_sysfs_fail(struct cma *cma, size_t count)
+{
+	spin_lock(&cma->stat->lock);
+	cma->stat->alloc_fail++;
+	cma->stat->pages_fail += count;
+	spin_unlock(&cma->stat->lock);
+}
+
+#define CMA_ATTR_RO(_name) \
+	static struct kobj_attribute _name##_attr = __ATTR_RO(_name)
+
+static struct kobject *cma_kobj;
+
+static ssize_t cma_alloc_attempt_show(struct kobject *kobj,
+			struct kobj_attribute *attr, char *buf)
+{
+	unsigned long val;
+	struct cma_stat *stat = container_of(kobj, struct cma_stat, kobj);
+
+	val = stat->alloc_attempt;
+
+	return sysfs_emit(buf, "%lu\n", val);
+}
+CMA_ATTR_RO(cma_alloc_attempt);
+
+static ssize_t cma_alloc_fail_show(struct kobject *kobj,
+			struct kobj_attribute *attr, char *buf)
+{
+	unsigned long val;
+	struct cma_stat *stat = container_of(kobj, struct cma_stat, kobj);
+
+	val = stat->alloc_fail;
+
+	return sysfs_emit(buf, "%lu\n", val);
+}
+CMA_ATTR_RO(cma_alloc_fail);
+
+static ssize_t alloc_pages_attempt_show(struct kobject *kobj,
+			struct kobj_attribute *attr, char *buf)
+{
+	unsigned long val;
+	struct cma_stat *stat = container_of(kobj, struct cma_stat, kobj);
+
+	val = stat->pages_attempt;
+
+	return sysfs_emit(buf, "%lu\n", val);
+}
+CMA_ATTR_RO(alloc_pages_attempt);
+
+static ssize_t alloc_pages_fail_show(struct kobject *kobj,
+			struct kobj_attribute *attr, char *buf)
+{
+	unsigned long val;
+	struct cma_stat *stat = container_of(kobj, struct cma_stat, kobj);
+
+	val = stat->pages_fail;
+
+	return sysfs_emit(buf, "%lu\n", val);
+}
+CMA_ATTR_RO(alloc_pages_fail);
+
+static void cma_kobj_release(struct kobject *kobj)
+{
+	struct cma_stat *stat = container_of(kobj, struct cma_stat, kobj);
+
+	kfree(stat);
+}
+
+static struct attribute *cma_attrs[] = {
+	&cma_alloc_attempt_attr.attr,
+	&cma_alloc_fail_attr.attr,
+	&alloc_pages_attempt_attr.attr,
+	&alloc_pages_fail_attr.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(cma);
+
+static struct kobj_type cma_ktype = {
+	.release = cma_kobj_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = cma_groups
+};
+
+static int __init cma_sysfs_init(void)
+{
+	int i;
+	struct cma *cma;
+	struct cma_stat *stat;
+
+	cma_kobj = kobject_create_and_add("cma", mm_kobj);
+	if (!cma_kobj) {
+		pr_err("failed to create cma kobject\n");
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < cma_area_count; i++) {
+		cma = &cma_areas[i];
+		stat = kzalloc(sizeof(*stat), GFP_KERNEL);
+		if (!stat)
+			goto out;
+
+		cma->stat = stat;
+		spin_lock_init(&stat->lock);
+		if (kobject_init_and_add(&stat->kobj, &cma_ktype,
+					cma_kobj, "%s", cma->name)) {
+			kobject_put(&stat->kobj);
+			goto out;
+		}
+	}
+
+	return 0;
+out:
+	while (--i >= 0) {
+		cma = &cma_areas[i];
+		kobject_put(&cma->stat->kobj);
+	}
+
+	kobject_put(cma_kobj);
+
+	return -ENOMEM;
+}
+subsys_initcall(cma_sysfs_init);
-- 
2.30.0.365.g02bc693789-goog

