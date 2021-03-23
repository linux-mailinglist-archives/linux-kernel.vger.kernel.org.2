Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A949134694D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 20:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbhCWTvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 15:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbhCWTu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 15:50:57 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64173C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 12:50:56 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id y5so15429726pfn.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 12:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MhDwk/3XjbatWSWSk6OVuCgRfbT68ZT4CcEbmpJK2Y8=;
        b=LBxnInfPfplYuSvzx6z7MJkdq5uUf1fJfAY9hGHXMMrbqI5IQHtVVoBs0v84OUyWGU
         saw9VpwDebmTdotovh7E8VcHBR0SkmmX62CHsER1LmWAtGq3yqNnn/4nnWeEuPAXuNFf
         gEkaqOsLfVNxewqA4HE3+UGNyKNVCHD2WSHUsQboWWs3Yq9KURTgb04qE/whoU9fvXNx
         uWeqXRNt8WLXaG10ZMQNgX0O5g1X9TxzDDKKjouK3htONCSEqLgEBEQWxKA/pWMIJmLd
         zVLnCeec+vYCeuv9jUS2X3aSv5bnMoxnYO46TGmyGC/dVD3poDLdIeGrCnGojd0DIOf0
         TP1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=MhDwk/3XjbatWSWSk6OVuCgRfbT68ZT4CcEbmpJK2Y8=;
        b=c6aVv8fBTZT787dq90XzK6fzTMO3CU6xMfzrNytAa/qPYhox/5QQL9QFonS8tsYMko
         5M93ngHbmhtRdD7qsCYmVP69onjkEfmK3NAMD6V1iNh6ZgZWpEiut7LK/XBngblO1GAk
         81XkJkWi38Va9O+shLaWdPZBuex5O5SBHlYGZy33uAbrzw5Esg1YqvycXAzEm7rOr9HT
         q6l9Ni0rHEKDSvsveZJ7GM5d2QX29ljPhbgO+0Ll7jyur6/0xxHH1sMLuzt7LxLDjKr0
         DjBHh+EP1saoGvPUrRzmVuWdxik/eVN38p0X22PABpD04mS3oNves2ZYEhQcQAs6i4+m
         RkQg==
X-Gm-Message-State: AOAM5334qrjYIbLUZuEu5DLYdCgRueXnCUIUMnVe+wJk7UdCUmwyIPyY
        Qh8mjW9821HDjNfEjK+JZ4Q=
X-Google-Smtp-Source: ABdhPJx9tg1/Gdg1JOt8ceJm5FUG+pEYjbpkR7xA3ILSySG4ysrkGXKUiz847nsqEp+dsXzfvtnajg==
X-Received: by 2002:a05:6a00:2292:b029:1ff:bcb8:91f9 with SMTP id f18-20020a056a002292b02901ffbcb891f9mr6578511pfe.63.1616529055728;
        Tue, 23 Mar 2021 12:50:55 -0700 (PDT)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:201:7dfa:1e53:536:7976])
        by smtp.gmail.com with ESMTPSA id 35sm41547pgr.14.2021.03.23.12.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 12:50:54 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        gregkh@linuxfoundation.org, surenb@google.com, joaodias@google.com,
        jhubbard@nvidia.com, willy@infradead.org, digetx@gmail.com,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH v5] mm: cma: support sysfs
Date:   Tue, 23 Mar 2021 12:50:50 -0700
Message-Id: <20210323195050.2577017-1-minchan@kernel.org>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
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
Tested-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
From v4 - https://lore.kernel.org/linux-mm/20210309062333.3216138-1-minchan@kernel.org/
 * fix corruption - digetx@

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
 mm/cma.h                                      |  21 ++++
 mm/cma_sysfs.c                                | 107 ++++++++++++++++++
 6 files changed, 166 insertions(+), 2 deletions(-)
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
index 42ae082cb067..f3258791ac58 100644
--- a/mm/cma.h
+++ b/mm/cma.h
@@ -3,6 +3,12 @@
 #define __MM_CMA_H__
 
 #include <linux/debugfs.h>
+#include <linux/kobject.h>
+
+struct cma_kobject {
+	struct cma *cma;
+	struct kobject kobj;
+};
 
 struct cma {
 	unsigned long   base_pfn;
@@ -16,6 +22,14 @@ struct cma {
 	struct debugfs_u32_array dfs_bitmap;
 #endif
 	char name[CMA_MAX_NAME];
+#ifdef CONFIG_CMA_SYSFS
+	/* the number of CMA page successful allocations */
+	atomic64_t nr_pages_succeeded;
+	/* the number of CMA page allocation failures */
+	atomic64_t nr_pages_failed;
+	/* kobject requires dynamic objecjt */
+	struct cma_kobject *kobj;
+#endif
 };
 
 extern struct cma cma_areas[MAX_CMA_AREAS];
@@ -26,4 +40,11 @@ static inline unsigned long cma_bitmap_maxno(struct cma *cma)
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
index 000000000000..6813635cef41
--- /dev/null
+++ b/mm/cma_sysfs.c
@@ -0,0 +1,107 @@
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
+void cma_sysfs_alloc_pages_count(struct cma *cma, size_t count)
+{
+	atomic64_add(count, &cma->nr_pages_succeeded);
+}
+
+void cma_sysfs_fail_pages_count(struct cma *cma, size_t count)
+{
+	atomic64_add(count, &cma->nr_pages_failed);
+}
+
+#define CMA_ATTR_RO(_name) \
+	static struct kobj_attribute _name##_attr = __ATTR_RO(_name)
+
+static ssize_t alloc_pages_success_show(struct kobject *kobj,
+					struct kobj_attribute *attr, char *buf)
+{
+	struct cma_kobject *cma_kobj = container_of(kobj,
+						    struct cma_kobject, kobj);
+	struct cma *cma = cma_kobj->cma;
+
+	return sysfs_emit(buf, "%llu\n",
+			  atomic64_read(&cma->nr_pages_succeeded));
+}
+CMA_ATTR_RO(alloc_pages_success);
+
+static ssize_t alloc_pages_fail_show(struct kobject *kobj,
+				     struct kobj_attribute *attr, char *buf)
+{
+	struct cma_kobject *cma_kobj = container_of(kobj,
+						    struct cma_kobject, kobj);
+	struct cma *cma = cma_kobj->cma;
+
+	return sysfs_emit(buf, "%llu\n", atomic64_read(&cma->nr_pages_failed));
+}
+CMA_ATTR_RO(alloc_pages_fail);
+
+static void cma_kobj_release(struct kobject *kobj)
+{
+	struct cma_kobject *cma_kobj =
+		container_of(kobj, struct cma_kobject, kobj);
+	struct cma *cma = cma_kobj->cma;
+
+	kfree(cma_kobj);
+	cma->kobj = NULL;
+}
+
+static struct attribute *cma_attrs[] = {
+	&alloc_pages_success_attr.attr,
+	&alloc_pages_fail_attr.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(cma);
+
+static struct kobject *cma_kobj_root;
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
+	cma_kobj_root = kobject_create_and_add("cma", mm_kobj);
+	if (!cma_kobj_root)
+		return -ENOMEM;
+
+	for (i = 0; i < cma_area_count; i++) {
+		struct cma_kobject *kobj;
+
+		cma = &cma_areas[i];
+		kobj = kzalloc(sizeof(struct cma_kobject), GFP_KERNEL);
+		if (!kobj)
+			goto out;
+
+		kobj->cma = cma;
+		cma->kobj = kobj;
+		if (kobject_init_and_add(&cma->kobj->kobj, &cma_ktype,
+					 cma_kobj_root, "%s", cma->name)) {
+			kobject_put(&cma->kobj->kobj);
+			goto out;
+		}
+	}
+
+	return 0;
+out:
+	kobject_put(cma_kobj_root);
+
+	return -ENOMEM;
+}
+subsys_initcall(cma_sysfs_init);
-- 
2.31.0.291.g576ba9dcdaf-goog

