Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 428B032C2CC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353859AbhCDAGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 19:06:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388065AbhCCUvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 15:51:38 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE0BC061756
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 12:50:58 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id u11so14714406plg.13
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 12:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E5l2Kiq7RxtUIhSoToDUXks5wKj0nCUy8zX15I4c+84=;
        b=N3Oa6Z8jJA3+U3fltdKWqLRpE92dpWN0XPe01dL8vi2ofT2bwX9YQvSx3/CpoD9G3l
         zGeYlzFTb3f0O6E1wUpkdYwL7U0bkdLTFJvTudu1ORE2IdCkXnLbZDtTXJlW7pTr2e1c
         6IDqhBLNdFvzA2WUoJ4vdbGGOzhmilNM7NCGBCLI4FYw2xxuImTuQClX/cQ+Gxw0X0ih
         LYc6w6R4zYY3w9qOWZ51U17Py25IcAzHurlJS4M75ku1y/vx16z0GDgOJnvkGukqohbS
         aKUh+e0L5Ajlaa31iL5iA6kUFsOZZXmRWeAQjoYVE63B9YupmLFwDHyMB9kJSVm4YDRm
         i4lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=E5l2Kiq7RxtUIhSoToDUXks5wKj0nCUy8zX15I4c+84=;
        b=udqLZ5Jl/T1qr7njCFCNVAMhQ/YBNqWkeJBffCI3WgaR5QainvYPQeH2hFwNIMt3IY
         YpHDifbm4w+XoQ4jJKKXiqWj/1S9KKN0ns+g2WAiRR0cgVfxaXwR81Ill5q0TeQjTdcy
         h3F06m7ACVcy8vwvIATIAaejRmcXcIRSy9VCi65F0+4Z7G1YM3JysBbcH1pbUFx5cuMa
         ITIEBZ4BqyBEqujptJH6yFqLRzRHIZPURL6mx6mTzDH6C7Q3vI8LAtZz0TWrB2WowRoO
         STXxhdPGbJe/27+LHV4WMcTUylzLRdyaxB32Zn0VAhc/K+nIWnWw2f9SvG4R1dgXF0ZW
         tlMQ==
X-Gm-Message-State: AOAM530GfcnJZ/klROidtsZqWRKFMauFtkBbixk7dxNiaWQT+HIOifE/
        FjOO1oJMOmrSaqy4cEAVymM=
X-Google-Smtp-Source: ABdhPJyTIMkiSeEP4k5vvdMpCHGR3ePPpWHGXxjpBE8LjcBR4RGFTvj+2hgVpMCs5Q7a1t1K6XcJSQ==
X-Received: by 2002:a17:90a:1b24:: with SMTP id q33mr982825pjq.86.1614804657991;
        Wed, 03 Mar 2021 12:50:57 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:201:c87:c34:99dc:ba23])
        by smtp.gmail.com with ESMTPSA id cp22sm7087024pjb.15.2021.03.03.12.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 12:50:56 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        joaodias@google.com, willy@infradead.org, surenb@google.com,
        Minchan Kim <minchan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v3] mm: cma: support sysfs
Date:   Wed,  3 Mar 2021 12:50:53 -0800
Message-Id: <20210303205053.2906924-1-minchan@kernel.org>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since CMA is getting used more widely, it's more important to
keep monitoring CMA statistics for system health since it's
directly related to user experience.

This patch introduces sysfs statistics for CMA, in order to provide
some basic monitoring of the CMA allocator.

 * the number of CMA page allocation attempts
 * the number of CMA page allocation failures

These two values allow the user to calcuate the allocation
failure rate for each CMA area.

e.g.)
  /sys/kernel/mm/cma/WIFI/cma_alloc_pages_[attempts|fails]
  /sys/kernel/mm/cma/SENSOR/cma_alloc_pages_[attempts|fails]
  /sys/kernel/mm/cma/BLUETOOTH/cma_alloc_pages_[attempts|fails]

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
From v2 - https://lore.kernel.org/linux-mm/20210208180142.2765456-1-minchan@kernel.org/
 * sysfs doc and description modification - jhubbard

From v1 - https://lore.kernel.org/linux-mm/20210203155001.4121868-1-minchan@kernel.org/
 * fix sysfs build and refactoring - willy
 * rename and drop some attributes - jhubbard

 Documentation/ABI/testing/sysfs-kernel-mm-cma |  25 ++++
 mm/Kconfig                                    |   7 ++
 mm/Makefile                                   |   1 +
 mm/cma.c                                      |   6 +-
 mm/cma.h                                      |  18 +++
 mm/cma_sysfs.c                                | 114 ++++++++++++++++++
 6 files changed, 170 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-kernel-mm-cma
 create mode 100644 mm/cma_sysfs.c

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-cma b/Documentation/ABI/testing/sysfs-kernel-mm-cma
new file mode 100644
index 000000000000..f518af819cee
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-cma
@@ -0,0 +1,25 @@
+What:		/sys/kernel/mm/cma/
+Date:		Feb 2021
+Contact:	Minchan Kim <minchan@kernel.org>
+Description:
+		/sys/kernel/mm/cma/ contains a subdirectory for each CMA
+		heap name (also sometimes called CMA areas).
+
+		Each CMA heap subdirectory (that is, each
+		/sys/kernel/mm/cma/<cma-heap-name> directory) contains the
+		following items:
+
+			cma_alloc_pages_attempts
+			cma_alloc_pages_fails
+
+What:		/sys/kernel/mm/cma/<cma-heap-name>/cma_alloc_pages_attempts
+Date:		Feb 2021
+Contact:	Minchan Kim <minchan@kernel.org>
+Description:
+		the number of pages CMA API tried to allocate
+
+What:		/sys/kernel/mm/cma/<cma-heap-name>/cma_alloc_pages_fails
+Date:		Feb 2021
+Contact:	Minchan Kim <minchan@kernel.org>
+Description:
+		the number of pages CMA API failed to allocate
diff --git a/mm/Kconfig b/mm/Kconfig
index 24c045b24b95..febb7e8e24de 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -513,6 +513,13 @@ config CMA_DEBUGFS
 	help
 	  Turns on the DebugFS interface for CMA.
 
+config CMA_SYSFS
+	bool "CMA information through sysfs interface"
+	depends on CMA && SYSFS
+	help
+	  This option exposes some sysfs attributes to get information
+	  from CMA.
+
 config CMA_AREAS
 	int "Maximum count of the CMA areas"
 	depends on CMA
diff --git a/mm/Makefile b/mm/Makefile
index 72227b24a616..56968b23ed7a 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -109,6 +109,7 @@ obj-$(CONFIG_CMA)	+= cma.o
 obj-$(CONFIG_MEMORY_BALLOON) += balloon_compaction.o
 obj-$(CONFIG_PAGE_EXTENSION) += page_ext.o
 obj-$(CONFIG_CMA_DEBUGFS) += cma_debug.o
+obj-$(CONFIG_CMA_SYSFS) += cma_sysfs.o
 obj-$(CONFIG_USERFAULTFD) += userfaultfd.o
 obj-$(CONFIG_IDLE_PAGE_TRACKING) += page_idle.o
 obj-$(CONFIG_DEBUG_PAGE_REF) += debug_page_ref.o
diff --git a/mm/cma.c b/mm/cma.c
index 54eee2119822..551b704faeaf 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -447,9 +447,10 @@ struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
 	offset = cma_bitmap_aligned_offset(cma, align);
 	bitmap_maxno = cma_bitmap_maxno(cma);
 	bitmap_count = cma_bitmap_pages_to_bits(cma, count);
+	cma_sysfs_alloc_count(cma, count);
 
 	if (bitmap_count > bitmap_maxno)
-		return NULL;
+		goto out;
 
 	for (;;) {
 		mutex_lock(&cma->lock);
@@ -504,6 +505,9 @@ struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
 		       __func__, cma->name, count, ret);
 		cma_debug_show_areas(cma);
 	}
+out:
+	if (!page)
+		cma_sysfs_fail_count(cma, count);
 
 	pr_debug("%s(): returned %p\n", __func__, page);
 	return page;
diff --git a/mm/cma.h b/mm/cma.h
index 42ae082cb067..24a1d61eabc7 100644
--- a/mm/cma.h
+++ b/mm/cma.h
@@ -3,6 +3,14 @@
 #define __MM_CMA_H__
 
 #include <linux/debugfs.h>
+#include <linux/kobject.h>
+
+struct cma_stat {
+	spinlock_t lock;
+	unsigned long pages_attempts;	/* the number of CMA page allocation attempts */
+	unsigned long pages_fails;	/* the number of CMA page allocation failures */
+	struct kobject kobj;
+};
 
 struct cma {
 	unsigned long   base_pfn;
@@ -16,6 +24,9 @@ struct cma {
 	struct debugfs_u32_array dfs_bitmap;
 #endif
 	char name[CMA_MAX_NAME];
+#ifdef CONFIG_CMA_SYSFS
+	struct cma_stat	*stat;
+#endif
 };
 
 extern struct cma cma_areas[MAX_CMA_AREAS];
@@ -26,4 +37,11 @@ static inline unsigned long cma_bitmap_maxno(struct cma *cma)
 	return cma->count >> cma->order_per_bit;
 }
 
+#ifdef CONFIG_CMA_SYSFS
+void cma_sysfs_alloc_count(struct cma *cma, size_t count);
+void cma_sysfs_fail_count(struct cma *cma, size_t count);
+#else
+static inline void cma_sysfs_alloc_count(struct cma *cma, size_t count) {};
+static inline void cma_sysfs_fail_count(struct cma *cma, size_t count) {};
+#endif
 #endif
diff --git a/mm/cma_sysfs.c b/mm/cma_sysfs.c
new file mode 100644
index 000000000000..d281bf95a614
--- /dev/null
+++ b/mm/cma_sysfs.c
@@ -0,0 +1,114 @@
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
+static struct cma_stat *cma_stats;
+
+void cma_sysfs_alloc_count(struct cma *cma, size_t count)
+{
+	spin_lock(&cma->stat->lock);
+	cma->stat->pages_attempts += count;
+	spin_unlock(&cma->stat->lock);
+}
+
+void cma_sysfs_fail_count(struct cma *cma, size_t count)
+{
+	spin_lock(&cma->stat->lock);
+	cma->stat->pages_fails += count;
+	spin_unlock(&cma->stat->lock);
+}
+
+#define CMA_ATTR_RO(_name) \
+	static struct kobj_attribute _name##_attr = __ATTR_RO(_name)
+
+static struct kobject *cma_kobj;
+
+static ssize_t cma_alloc_pages_attempts_show(struct kobject *kobj,
+			struct kobj_attribute *attr, char *buf)
+{
+	struct cma_stat *stat = container_of(kobj, struct cma_stat, kobj);
+
+	return sysfs_emit(buf, "%lu\n", stat->pages_attempts);
+}
+CMA_ATTR_RO(cma_alloc_pages_attempts);
+
+static ssize_t cma_alloc_pages_fails_show(struct kobject *kobj,
+			struct kobj_attribute *attr, char *buf)
+{
+	struct cma_stat *stat = container_of(kobj, struct cma_stat, kobj);
+
+	return sysfs_emit(buf, "%lu\n", stat->pages_fails);
+}
+CMA_ATTR_RO(cma_alloc_pages_fails);
+
+static void cma_kobj_release(struct kobject *kobj)
+{
+	struct cma_stat *stat = container_of(kobj, struct cma_stat, kobj);
+
+	kfree(stat);
+}
+
+static struct attribute *cma_attrs[] = {
+	&cma_alloc_pages_attempts_attr.attr,
+	&cma_alloc_pages_fails_attr.attr,
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
+	int i = 0;
+	struct cma *cma;
+
+	cma_kobj = kobject_create_and_add("cma", mm_kobj);
+	if (!cma_kobj) {
+		pr_err("failed to create cma kobject\n");
+		return -ENOMEM;
+	}
+
+	cma_stats = kzalloc(array_size(sizeof(struct cma_stat),
+				cma_area_count), GFP_KERNEL);
+	if (!cma_stats) {
+		pr_err("failed to create cma_stats\n");
+		goto out;
+	}
+
+	do {
+		cma = &cma_areas[i];
+		cma->stat = &cma_stats[i];
+		spin_lock_init(&cma->stat->lock);
+		if (kobject_init_and_add(&cma->stat->kobj, &cma_ktype,
+					cma_kobj, "%s", cma->name)) {
+			kobject_put(&cma->stat->kobj);
+			goto out;
+		}
+	} while (++i < cma_area_count);
+
+	return 0;
+out:
+	while (--i >= 0) {
+		cma = &cma_areas[i];
+		kobject_put(&cma->stat->kobj);
+	}
+
+	kfree(cma_stats);
+	kobject_put(cma_kobj);
+
+	return -ENOMEM;
+}
+subsys_initcall(cma_sysfs_init);
-- 
2.30.1.766.gb4fecdf3b7-goog

