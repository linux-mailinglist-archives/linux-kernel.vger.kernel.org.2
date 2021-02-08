Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EEEC313F19
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 20:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbhBHTfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 14:35:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235376AbhBHSDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 13:03:24 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F3BC061794
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 10:01:48 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id w18so10196719pfu.9
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 10:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Axjgr30iSBj/jYLiUjQfNQM9hvuQRpjGLmsQRdX6JxI=;
        b=seYS+I6SK2b5fNaK8u1KNHAVzvc05cGZ8+oaRMHTwOFXr7ORGxoXfBrSxn0gjVc/l5
         ci3MPRnxW+CwLMBJHIEFeHmRYcW9DYojrPZb1TgCwDFUd0ubZa0Hl0gI7DwKLC24tjLU
         Do+0bAurjeK2AssZjKEkBZcRzg5s30+of8gi9fvRIoKOwudif9zAUY/h5wVAa4URYR6r
         CgWrDTDNI73ue5d0lSOhMb7zYO+wgd0tO6WjCCqPSs2q2GOxoLsS7aNh1HYgdxlhpLnS
         HIt0aJrse+IkCNd1jFIGr4Pf0Poyk36v2hpt6ubcXOBIOhI6rNtuMlWE3okniFpxgOHD
         2ffA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=Axjgr30iSBj/jYLiUjQfNQM9hvuQRpjGLmsQRdX6JxI=;
        b=iKnlMbD/lzulTo+l6+luq4qxj0vh/hgbY/Gv6OJ9/YP+1Uf1LQ2uW1Ld4zeKbuGfXQ
         YY7yg1ize/Wkfi22QnU4+XrYwp9QgaPP7YhEyeJXLz8Wm5nJTzZSPfiIt8GcIHwlCurA
         K2Feg/441RS1+l5c+W5hz6tzI/rjG/QfLeNofGNMKG1eqmr/+yyChGhMdH0gA1UoZITZ
         4oEb7a+4NgzAwxpnrchX3j7b7eCuWEchGdf0wSrYrDSEIJG3QwzNJZxwyncGBcT0CT2k
         52tRf4FW9ruzkrS+wK+hy00s+wV2Htof+ith5C7y+er4v+QhWOiH+LxzPcHB6YsSqYxb
         Pptg==
X-Gm-Message-State: AOAM532PLQHMdq35LJ9/rKg31J14CmUQNbqDK71azdLdmBNLQrzdkwng
        VB9ECA0blldd+QLC4Bn/8NA=
X-Google-Smtp-Source: ABdhPJyQbBS/HSt882T8RyMS/L/LlMa/zs6yXhnHWkk6j8xXk4XRmlUS3EUr6qKX0Ccxx42mkN2nzQ==
X-Received: by 2002:a63:d506:: with SMTP id c6mr18002404pgg.77.1612807307722;
        Mon, 08 Feb 2021 10:01:47 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:201:1557:50ce:fb7a:a325])
        by smtp.gmail.com with ESMTPSA id 25sm3820539pfj.120.2021.02.08.10.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 10:01:46 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        gregkh@linuxfoundation.org, surenb@google.com, joaodias@google.com,
        jhubbard@nvidia.com, willy@infradead.org,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH v2] mm: cma: support sysfs
Date:   Mon,  8 Feb 2021 10:01:42 -0800
Message-Id: <20210208180142.2765456-1-minchan@kernel.org>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
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

 * the number of CMA page allocation attempts
 * the number of CMA page allocation failures

With those per-CMA statistics, we could know how CMA allocadtion
failure rate for each usecases.

e.g.)
  /sys/kernel/mm/cma/WIFI/cma_alloc_pages_[attempt|fail]
  /sys/kernel/mm/cma/SENSOR/cma_alloc_pages_[attempt|fail]
  /sys/kernel/mm/cma/BLUETOOTH/cma_alloc_pages_[attempt|fail]

Signed-off-by: Minchan Kim <minchan@kernel.org>
---

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
index 000000000000..68bdcc8c7681
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-cma
@@ -0,0 +1,25 @@
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
+			- cma_alloc_pages_attempt
+			- cma_alloc_pages_fail
+
+What:		/sys/kernel/mm/cma/<cma-heap-name>/cma_alloc_pages_attempt
+Date:		Feb 2021
+Contact:	Minchan Kim <minchan@kernel.org>
+Description:
+		the number of pages CMA API tried to allocate
+
+What:		/sys/kernel/mm/cma/<cma-heap-name>/cma_alloc_pages_fail
+Date:		Feb 2021
+Contact:	Minchan Kim <minchan@kernel.org>
+Description:
+		the number of pages CMA API failed to allocate
diff --git a/mm/Kconfig b/mm/Kconfig
index ec35bf406439..ad7e9c065657 100644
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
index b2a564eec27f..0ae764e5b1a8 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -109,6 +109,7 @@ obj-$(CONFIG_CMA)	+= cma.o
 obj-$(CONFIG_MEMORY_BALLOON) += balloon_compaction.o
 obj-$(CONFIG_PAGE_EXTENSION) += page_ext.o
 obj-$(CONFIG_CMA_DEBUGFS) += cma_debug.o
+obj-$(CONFIG_CMA_SYSFS)	+= cma_sysfs.o
 obj-$(CONFIG_USERFAULTFD) += userfaultfd.o
 obj-$(CONFIG_IDLE_PAGE_TRACKING) += page_idle.o
 obj-$(CONFIG_DEBUG_PAGE_REF) += debug_page_ref.o
diff --git a/mm/cma.c b/mm/cma.c
index 23d4a97c834a..0611202d6e7d 100644
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
 			__func__, count, ret);
 		cma_debug_show_areas(cma);
 	}
+out:
+	if (!page)
+		cma_sysfs_fail(cma, count);
 
 	pr_debug("%s(): returned %p\n", __func__, page);
 	return page;
diff --git a/mm/cma.h b/mm/cma.h
index 42ae082cb067..49a8ceddd9e8 100644
--- a/mm/cma.h
+++ b/mm/cma.h
@@ -3,6 +3,14 @@
 #define __MM_CMA_H__
 
 #include <linux/debugfs.h>
+#include <linux/kobject.h>
+
+struct cma_stat {
+	spinlock_t lock;
+	unsigned long pages_attempt;	/* the number of CMA page allocation attempts */
+	unsigned long pages_fail;	/* the number of CMA page allocation failures */
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
+void cma_sysfs_fail(struct cma *cma, size_t count);
+#else
+static inline void cma_sysfs_alloc_count(struct cma *cma, size_t count) {};
+static inline void cma_sysfs_fail(struct cma *cma, size_t count) {};
+#endif
 #endif
diff --git a/mm/cma_sysfs.c b/mm/cma_sysfs.c
new file mode 100644
index 000000000000..1f6b9f785825
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
+	cma->stat->pages_attempt += count;
+	spin_unlock(&cma->stat->lock);
+}
+
+void cma_sysfs_fail(struct cma *cma, size_t count)
+{
+	spin_lock(&cma->stat->lock);
+	cma->stat->pages_fail += count;
+	spin_unlock(&cma->stat->lock);
+}
+
+#define CMA_ATTR_RO(_name) \
+	static struct kobj_attribute _name##_attr = __ATTR_RO(_name)
+
+static struct kobject *cma_kobj;
+
+static ssize_t cma_alloc_pages_attempt_show(struct kobject *kobj,
+			struct kobj_attribute *attr, char *buf)
+{
+	struct cma_stat *stat = container_of(kobj, struct cma_stat, kobj);
+
+	return sysfs_emit(buf, "%lu\n", stat->pages_attempt);
+}
+CMA_ATTR_RO(cma_alloc_pages_attempt);
+
+static ssize_t cma_alloc_pages_fail_show(struct kobject *kobj,
+			struct kobj_attribute *attr, char *buf)
+{
+	struct cma_stat *stat = container_of(kobj, struct cma_stat, kobj);
+
+	return sysfs_emit(buf, "%lu\n", stat->pages_fail);
+}
+CMA_ATTR_RO(cma_alloc_pages_fail);
+
+static void cma_kobj_release(struct kobject *kobj)
+{
+	struct cma_stat *stat = container_of(kobj, struct cma_stat, kobj);
+
+	kfree(stat);
+}
+
+static struct attribute *cma_attrs[] = {
+	&cma_alloc_pages_attempt_attr.attr,
+	&cma_alloc_pages_fail_attr.attr,
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
+	} while (++i < cma_area_count)
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
2.30.0.478.g8a0d178c01-goog

