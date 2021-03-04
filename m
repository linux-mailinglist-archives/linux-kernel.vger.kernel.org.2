Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3FFD32D784
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 17:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236688AbhCDQR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 11:17:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233357AbhCDQRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 11:17:50 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5639AC061756
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 08:17:09 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id g20so16424529plo.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 08:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4bU201KxWfqQ15lKl2kMS9tQImpqVi5LEoxcAsPKje0=;
        b=kSAjUABOQyvFann9gRlmEkiSQPay+2bS9rZsgmnbOAVWfA5FH8pMfZkoVnoNJ1sk3j
         wUmUEk6vXOeVWJnFabPk2QpDBW16T6fyvMmW+fQ0Ul2rvHR+sP/ca9+o4FzdntjIhZpa
         bLTN5rf9U/BEFlL5dKFnAGUNNlTS4T7osb2BtMutk5Zelgg6QJrErx1oTxY5C9M9QcXP
         4IF8ujoqsXQc64m5rrmPzQ+PE7yhmZN6AzY3pMzA/2m50DxensfiDfh0TAFBJ66S1Ix4
         6cbfzCgQqfSekdgwI1axxXC7yJIeZ9pw9XzYlH2VIV1LT6XHvZHNsFUcjJyPPmEHvXD/
         J+zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=4bU201KxWfqQ15lKl2kMS9tQImpqVi5LEoxcAsPKje0=;
        b=reNYfI31B0n/LAcWTQ+1e0nzw5vXtnDyIBfxuaumE/1zxealc3nqy0/n33DusLdYRX
         W1sgYO4aIGUg9YO/zPtmefiNM/sxs2Sh+b4wKVgt3ZRzdQKvbqjP1JIQcjNoNEoB/a7X
         DR0BDR2mUIAlVBPBC/x9H/dn5RXOdc1gOuLWM+JnN+MMBHVkMDw5gXSs6q6Eel3PD9Q6
         2WuhbbIPp46OrRFNjBQ7Y8LkcdNg6d1qY9Fl/BP2KTwIEJi86Ral0EC8EzNgbliD2cyj
         j71Nl79NRPjPfI/J8o/yqLx2CtpSNzxPZZIaCVSo4RD6AjNBcRDNyTnJrNHuPpv4O38Z
         SVWQ==
X-Gm-Message-State: AOAM533dEx08k3tSDJSSokCdVZad5uW3iLzHh0aKfwiKXiUVJ5nJRogK
        qkcBx/7tUf4S8Df+ut6ZCuw=
X-Google-Smtp-Source: ABdhPJyc6ThqEQzdhT1OZqPdA4AU1pPtUSShF2d3WiRkj7wNdwFjrrI4UIfYQzr8P6i8tF3VNygdYg==
X-Received: by 2002:a17:902:d30c:b029:e3:f95:6da5 with SMTP id b12-20020a170902d30cb02900e30f956da5mr4864871plc.6.1614874628868;
        Thu, 04 Mar 2021 08:17:08 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:201:edb1:8010:5c27:a8cc])
        by smtp.gmail.com with ESMTPSA id b14sm27647838pfi.74.2021.03.04.08.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 08:17:08 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        gregkh@linuxfoundation.org, surenb@google.com, joaodias@google.com,
        jhubbard@nvidia.com, willy@infradead.org,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH v4] mm: cma: support sysfs
Date:   Thu,  4 Mar 2021 08:17:04 -0800
Message-Id: <20210304161704.3056806-1-minchan@kernel.org>
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

The cma_stat was intentionally allocated by dynamic allocation
to harmonize with kobject lifetime management.
https://lore.kernel.org/linux-mm/YCOAmXqt6dZkCQYs@kroah.com/

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
From v3 - https://lore.kernel.org/linux-mm/20210303205053.2906924-1-minchan@kernel.org/
 * kmalloc_array - akpm
 * add why cma_stat was implemented by dynamic allocation - akpm
 * use !__GFP_NOWARN facility to print error - akpm

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
 mm/cma_sysfs.c                                | 110 ++++++++++++++++++
 6 files changed, 166 insertions(+), 1 deletion(-)
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
index 000000000000..67b63167eaf5
--- /dev/null
+++ b/mm/cma_sysfs.c
@@ -0,0 +1,110 @@
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
+	if (!cma_kobj)
+		return -ENOMEM;
+
+	cma_stats = kmalloc_array(cma_area_count, sizeof(struct cma_stat),
+				GFP_KERNEL|__GFP_ZERO);
+	if (!cma_stats)
+		goto out;
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

