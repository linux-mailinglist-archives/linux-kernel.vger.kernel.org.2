Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E33F8331F3D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 07:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbhCIGYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 01:24:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbhCIGXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 01:23:39 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E1BC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 22:23:39 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id y13so5335374pfr.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 22:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tJzIOcFBu4yonwIwsIyQXifzObwXNjdAETzu8HpriMc=;
        b=Ja6CHlr6flviktEKD/C6O05x729Pz8BwiLV6E2XQHOQJwZWQ2DAhM9tCtZLXSszGs4
         kG2VUe1Y4aUOMBbjPFbWvZF3yAYPsei2QNx60DeOkb091uSGbaHg2poukLjXBmBwcFhT
         8g0EIrzRJ7+6yx8jwswSdleGtXCMYpdbHIUlsQP/kcvxHDjfrbGpph0O/QvhgUrpYFuL
         6FTG5lGh3mDzdyD45usJffB2AfvY8iLmsVVZlzt0CbB5InWc50rU/80pkJ6/QcPbxGWF
         TPY5461pYVaxsFFPyOAArwPaQKgh6//03B29jrCLpalA/99MjQ8a1WTGbRRmcigrujne
         da7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=tJzIOcFBu4yonwIwsIyQXifzObwXNjdAETzu8HpriMc=;
        b=J+s+Yfb97gEmIqVH1fgUGT1QO2FW4oDEg99jJa/9hfklN4DQepqrl/SiAey4cxLj3I
         BpOL8CTzYdsrP9rF3sweQCcgrJ+pW5EJ1BvTufW79RVPVzcAGjnQRgiscdCUPshMEti5
         rZxRnCVOY946hSEgebUQPTFyUY2FZI3c6HuEu0neCEBUhrmfIM2UJBVaekNWoGtLdkq9
         2a3yXUpoYOgGaSP7N7+ZfBYMoSz4Hgb2qH1nVx0n3C53IWl/CKUWJnqJo5CLWzIUzWii
         BUTY4bZZvsxlHBIiRuvnYN9N2wvLvMe99Sq7U/oyw1uTgJd3AanHtLHZIX9qKcpraOcK
         epLw==
X-Gm-Message-State: AOAM5320Wv3mZp/ZrpVoBlTR4g9+NTOP98oXGY5/7FPz5NLxnhnMf+sz
        H9XlCYKNbVqWltEtIEj8TOg=
X-Google-Smtp-Source: ABdhPJwZMOpehLXPSaus0vHRfCnz6cXHmvmh3jW0zfWXWhx3I8Fnp9vUFEssAaOVvN2m6stFbJyjvw==
X-Received: by 2002:a65:44c5:: with SMTP id g5mr24015616pgs.295.1615271018216;
        Mon, 08 Mar 2021 22:23:38 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:201:4ccc:acdd:25da:14d1])
        by smtp.gmail.com with ESMTPSA id u7sm11583223pfh.150.2021.03.08.22.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 22:23:37 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        joaodias@google.com, willy@infradead.org, david@redhat.com,
        surenb@google.com, Minchan Kim <minchan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v4] mm: cma: support sysfs
Date:   Mon,  8 Mar 2021 22:23:33 -0800
Message-Id: <20210309062333.3216138-1-minchan@kernel.org>
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

 * the number of CMA page successful allocations
 * the number of CMA page allocation failures

These two values allow the user to calcuate the allocation
failure rate for each CMA area.

e.g.)
  /sys/kernel/mm/cma/WIFI/alloc_pages_[success|fail]
  /sys/kernel/mm/cma/SENSOR/alloc_pages_[success|fail]
  /sys/kernel/mm/cma/BLUETOOTH/alloc_pages_[success|fail]

The cma_stat was intentionally allocated by dynamic allocation
to harmonize with kobject lifetime management.
https://lore.kernel.org/linux-mm/YCOAmXqt6dZkCQYs@kroah.com/

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
From v3 - https://lore.kernel.org/linux-mm/20210303205053.2906924-1-minchan@kernel.org/
 * fix ZERO_OR_NULL_PTR - kernel test robot
 * remove prefix cma - david@
 * resolve conflict with vmstat cma in mmotm - akpm@
 * rename stat name with success|fail

From v2 - https://lore.kernel.org/linux-mm/20210208180142.2765456-1-minchan@kernel.org/
 * sysfs doc and description modification - jhubbard

From v1 - https://lore.kernel.org/linux-mm/20210203155001.4121868-1-minchan@kernel.org/
 * fix sysfs build and refactoring - willy
 * rename and drop some attributes - jhubbard

 Documentation/ABI/testing/sysfs-kernel-mm-cma |  25 ++++
 mm/Kconfig                                    |   7 ++
 mm/Makefile                                   |   1 +
 mm/cma.c                                      |   7 +-
 mm/cma.h                                      |  20 ++++
 mm/cma_sysfs.c                                | 110 ++++++++++++++++++
 6 files changed, 168 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-kernel-mm-cma
 create mode 100644 mm/cma_sysfs.c

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-cma b/Documentation/ABI/testing/sysfs-kernel-mm-cma
new file mode 100644
index 000000000000..02b2bb60c296
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
+			alloc_pages_success
+			alloc_pages_fail
+
+What:		/sys/kernel/mm/cma/<cma-heap-name>/alloc_pages_success
+Date:		Feb 2021
+Contact:	Minchan Kim <minchan@kernel.org>
+Description:
+		the number of pages CMA API succeeded to allocate
+
+What:		/sys/kernel/mm/cma/<cma-heap-name>/alloc_pages_fail
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
index 908f04775686..ac050359faae 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -507,10 +507,13 @@ struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
 
 	pr_debug("%s(): returned %p\n", __func__, page);
 out:
-	if (page)
+	if (page) {
 		count_vm_event(CMA_ALLOC_SUCCESS);
-	else
+		cma_sysfs_alloc_pages_count(cma, count);
+	} else {
 		count_vm_event(CMA_ALLOC_FAIL);
+		cma_sysfs_fail_pages_count(cma, count);
+	}
 
 	return page;
 }
diff --git a/mm/cma.h b/mm/cma.h
index 42ae082cb067..95d1aa2d808a 100644
--- a/mm/cma.h
+++ b/mm/cma.h
@@ -3,6 +3,16 @@
 #define __MM_CMA_H__
 
 #include <linux/debugfs.h>
+#include <linux/kobject.h>
+
+struct cma_stat {
+	spinlock_t lock;
+	/* the number of CMA page successful allocations */
+	unsigned long nr_pages_succeeded;
+	/* the number of CMA page allocation failures */
+	unsigned long nr_pages_failed;
+	struct kobject kobj;
+};
 
 struct cma {
 	unsigned long   base_pfn;
@@ -16,6 +26,9 @@ struct cma {
 	struct debugfs_u32_array dfs_bitmap;
 #endif
 	char name[CMA_MAX_NAME];
+#ifdef CONFIG_CMA_SYSFS
+	struct cma_stat	*stat;
+#endif
 };
 
 extern struct cma cma_areas[MAX_CMA_AREAS];
@@ -26,4 +39,11 @@ static inline unsigned long cma_bitmap_maxno(struct cma *cma)
 	return cma->count >> cma->order_per_bit;
 }
 
+#ifdef CONFIG_CMA_SYSFS
+void cma_sysfs_alloc_pages_count(struct cma *cma, size_t count);
+void cma_sysfs_fail_pages_count(struct cma *cma, size_t count);
+#else
+static inline void cma_sysfs_alloc_pages_count(struct cma *cma, size_t count) {};
+static inline void cma_sysfs_fail_pages_count(struct cma *cma, size_t count) {};
+#endif
 #endif
diff --git a/mm/cma_sysfs.c b/mm/cma_sysfs.c
new file mode 100644
index 000000000000..3134b2b3a96d
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
+void cma_sysfs_alloc_pages_count(struct cma *cma, size_t count)
+{
+	spin_lock(&cma->stat->lock);
+	cma->stat->nr_pages_succeeded += count;
+	spin_unlock(&cma->stat->lock);
+}
+
+void cma_sysfs_fail_pages_count(struct cma *cma, size_t count)
+{
+	spin_lock(&cma->stat->lock);
+	cma->stat->nr_pages_failed += count;
+	spin_unlock(&cma->stat->lock);
+}
+
+#define CMA_ATTR_RO(_name) \
+	static struct kobj_attribute _name##_attr = __ATTR_RO(_name)
+
+static struct kobject *cma_kobj;
+
+static ssize_t alloc_pages_success_show(struct kobject *kobj,
+			struct kobj_attribute *attr, char *buf)
+{
+	struct cma_stat *stat = container_of(kobj, struct cma_stat, kobj);
+
+	return sysfs_emit(buf, "%lu\n", stat->nr_pages_succeeded);
+}
+CMA_ATTR_RO(alloc_pages_success);
+
+static ssize_t alloc_pages_fail_show(struct kobject *kobj,
+			struct kobj_attribute *attr, char *buf)
+{
+	struct cma_stat *stat = container_of(kobj, struct cma_stat, kobj);
+
+	return sysfs_emit(buf, "%lu\n", stat->nr_pages_failed);
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
+	&alloc_pages_success_attr.attr,
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
+	int i = 0;
+	struct cma *cma;
+
+	cma_kobj = kobject_create_and_add("cma", mm_kobj);
+	if (!cma_kobj)
+		return -ENOMEM;
+
+	cma_stats = kmalloc_array(cma_area_count, sizeof(struct cma_stat),
+				GFP_KERNEL|__GFP_ZERO);
+	if (ZERO_OR_NULL_PTR(cma_stats))
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

