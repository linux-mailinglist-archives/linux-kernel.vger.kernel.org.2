Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 097C734850F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 00:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238946AbhCXXIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 19:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238942AbhCXXIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 19:08:12 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DADAC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 16:08:12 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id m11so14136pfc.11
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 16:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LhJhGY7Q5ru7P/G4ZIy6MS5lulzSiDOAC2gYoWDjKkI=;
        b=JtjxGuZTnRN8SsbC+reXyjYrtvOWHSfxDZe8oC3b6FiLfH1J+fzhbhoz9WXg7+OgzL
         4PdyVffKyhw8+sNjNHobOu8dM3wQd4tGm85U9o+RXK4hHG7qgHhlt/q2SrU1feQ3ay9w
         BGEFv/uErKAQzrrs0E5pQKGkAhdulz5Pddza4BoRD3P87/H54BZQNCfgOpTi4oo9Q7mo
         nGrPM3jrO/TBW9K+Zo005e7NFpUMZ7U4DAeEI4kuw6McajVSnHlzOywGaEf13blHOLVL
         SUu4fksu1rBtHcNa4RTXTIiH8ICdzlrhn3LecQbekz3VPysagDZSezRwchGWqoewkGFk
         yARg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=LhJhGY7Q5ru7P/G4ZIy6MS5lulzSiDOAC2gYoWDjKkI=;
        b=qm1evNMNo7Pm26Mnjb6/rSqM47GEP2uXEBF8qBfXMdsH7TRW4EcEYSATacMwipVY99
         4vSaAVlBNu0wb0wHh1uq998l66hQKINB48lV5UjrrlFJteYlH/dtQ1f5FQxZWLiq6fdt
         UYp+Rs83Ye0IDndbvCzVddXsOjw6ggClwIUkrgDrIaEiz2LAiMH8rubFgG1VXLnWvnCg
         5WzQHO0lXEQi3lDjlahlEAgXThj+qvyi1kcF8iuNm0GWcJg+SpcYV7N9I6QohaWSrdM9
         dwLZ+/qLFGS7HagJsnexK7/EF8f9uEzf2e1nl6A3TlTWgSH+d5GP8ohibeiY7F25uONq
         kcnA==
X-Gm-Message-State: AOAM531FIREEnO+5EKJnyPfj/qv+8D1UO/jid9v0fY/E4/dRQgvs3hgA
        Wp/r6dYroQwmb0P3vvf+OahIevLJxCw=
X-Google-Smtp-Source: ABdhPJxPQIzgu9G1dflapKvbnLoi6DZuHnQq3AKrHxYW5e038JpboEU+vJE+x2DREaN0i6Ta36FXHg==
X-Received: by 2002:a63:531e:: with SMTP id h30mr4995363pgb.158.1616627291717;
        Wed, 24 Mar 2021 16:08:11 -0700 (PDT)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:201:7dfa:1e53:536:7976])
        by smtp.gmail.com with ESMTPSA id u1sm3385122pgg.11.2021.03.24.16.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 16:08:10 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        gregkh@linuxfoundation.org, surenb@google.com, joaodias@google.com,
        jhubbard@nvidia.com, willy@infradead.org, digetx@gmail.com,
        Minchan Kim <minchan@kernel.org>,
        Colin Ian King <colin.king@canonical.com>
Subject: [PATCH v8] mm: cma: support sysfs
Date:   Wed, 24 Mar 2021 16:07:59 -0700
Message-Id: <20210324230759.2213957-1-minchan@kernel.org>
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

Tested-by: Dmitry Osipenko <digetx@gmail.com>
Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Link: https://lore.kernel.org/linux-mm/20210316100433.17665-1-colin.king@canonical.com/
Addresses-Coverity: ("Dereference after null check")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
Andrew, you could apply this patch after revering these patches:

mm: cma: fix potential null dereference on pointer cma
mm: cma: support sysfs

From v7 - https://lore.kernel.org/linux-mm/20210324205503.2132082-1-minchan@kernel.org/
From v6 - https://lore.kernel.org/linux-mm/20210324010547.4134370-1-minchan@kernel.org/
From v5 - https://lore.kernel.org/linux-mm/20210323195050.2577017-1-minchan@kernel.org/
From v4 - https://lore.kernel.org/linux-mm/20210309062333.3216138-1-minchan@kernel.org/
 * fix corruption - digetx@
 * refactoring - digetx@, jhubbard@, willy@

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
 mm/cma.c                                      |   8 +-
 mm/cma.h                                      |  23 ++++
 mm/cma_sysfs.c                                | 112 ++++++++++++++++++
 6 files changed, 174 insertions(+), 2 deletions(-)
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
index 23a0e3c98ff0..3823a2314256 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -524,6 +524,13 @@ config CMA_DEBUGFS
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
index 9e284dba50ef..788c5ce5c0ef 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -112,6 +112,7 @@ obj-$(CONFIG_CMA)	+= cma.o
 obj-$(CONFIG_MEMORY_BALLOON) += balloon_compaction.o
 obj-$(CONFIG_PAGE_EXTENSION) += page_ext.o
 obj-$(CONFIG_CMA_DEBUGFS) += cma_debug.o
+obj-$(CONFIG_CMA_SYSFS) += cma_sysfs.o
 obj-$(CONFIG_USERFAULTFD) += userfaultfd.o
 obj-$(CONFIG_IDLE_PAGE_TRACKING) += page_idle.o
 obj-$(CONFIG_DEBUG_PAGE_REF) += debug_page_ref.o
diff --git a/mm/cma.c b/mm/cma.c
index 0361e289c31a..08c45157911a 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -507,10 +507,14 @@ struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
 
 	pr_debug("%s(): returned %p\n", __func__, page);
 out:
-	if (page)
+	if (page) {
 		count_vm_event(CMA_ALLOC_SUCCESS);
-	else
+		cma_sysfs_account_success_pages(cma, count);
+	} else {
 		count_vm_event(CMA_ALLOC_FAIL);
+		if (cma)
+			cma_sysfs_account_fail_pages(cma, count);
+	}
 
 	return page;
 }
diff --git a/mm/cma.h b/mm/cma.h
index 42ae082cb067..68ffad4e430d 100644
--- a/mm/cma.h
+++ b/mm/cma.h
@@ -3,6 +3,12 @@
 #define __MM_CMA_H__
 
 #include <linux/debugfs.h>
+#include <linux/kobject.h>
+
+struct cma_kobject {
+	struct kobject kobj;
+	struct cma *cma;
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
+	/* kobject requires dynamic object */
+	struct cma_kobject *cma_kobj;
+#endif
 };
 
 extern struct cma cma_areas[MAX_CMA_AREAS];
@@ -26,4 +40,13 @@ static inline unsigned long cma_bitmap_maxno(struct cma *cma)
 	return cma->count >> cma->order_per_bit;
 }
 
+#ifdef CONFIG_CMA_SYSFS
+void cma_sysfs_account_success_pages(struct cma *cma, unsigned long nr_pages);
+void cma_sysfs_account_fail_pages(struct cma *cma, unsigned long nr_pages);
+#else
+static inline void cma_sysfs_account_success_pages(struct cma *cma,
+						   unsigned long nr_pages) {};
+static inline void cma_sysfs_account_fail_pages(struct cma *cma,
+						unsigned long nr_pages) {};
+#endif
 #endif
diff --git a/mm/cma_sysfs.c b/mm/cma_sysfs.c
new file mode 100644
index 000000000000..eb2f39caff59
--- /dev/null
+++ b/mm/cma_sysfs.c
@@ -0,0 +1,112 @@
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
+#define CMA_ATTR_RO(_name) \
+	static struct kobj_attribute _name##_attr = __ATTR_RO(_name)
+
+void cma_sysfs_account_success_pages(struct cma *cma, unsigned long nr_pages)
+{
+	atomic64_add(nr_pages, &cma->nr_pages_succeeded);
+}
+
+void cma_sysfs_account_fail_pages(struct cma *cma, unsigned long nr_pages)
+{
+	atomic64_add(nr_pages, &cma->nr_pages_failed);
+}
+
+static inline struct cma *cma_from_kobj(struct kobject *kobj)
+{
+	return container_of(kobj, struct cma_kobject, kobj)->cma;
+}
+
+static ssize_t alloc_pages_success_show(struct kobject *kobj,
+					struct kobj_attribute *attr, char *buf)
+{
+	struct cma *cma = cma_from_kobj(kobj);
+
+	return sysfs_emit(buf, "%llu\n",
+			  atomic64_read(&cma->nr_pages_succeeded));
+}
+CMA_ATTR_RO(alloc_pages_success);
+
+static ssize_t alloc_pages_fail_show(struct kobject *kobj,
+				     struct kobj_attribute *attr, char *buf)
+{
+	struct cma *cma = cma_from_kobj(kobj);
+
+	return sysfs_emit(buf, "%llu\n", atomic64_read(&cma->nr_pages_failed));
+}
+CMA_ATTR_RO(alloc_pages_fail);
+
+static void cma_kobj_release(struct kobject *kobj)
+{
+	struct cma *cma = cma_from_kobj(kobj);
+	struct cma_kobject *cma_kobj = cma->cma_kobj;
+
+	kfree(cma_kobj);
+	cma->cma_kobj = NULL;
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
+	.default_groups = cma_groups,
+};
+
+static int __init cma_sysfs_init(void)
+{
+	struct kobject *cma_kobj_root;
+	struct cma_kobject *cma_kobj;
+	struct cma *cma;
+	int i, err;
+
+	cma_kobj_root = kobject_create_and_add("cma", mm_kobj);
+	if (!cma_kobj_root)
+		return -ENOMEM;
+
+	for (i = 0; i < cma_area_count; i++) {
+		cma_kobj = kzalloc(sizeof(*cma_kobj), GFP_KERNEL);
+		if (!cma_kobj) {
+			err = -ENOMEM;
+			goto out;
+		}
+
+		cma = &cma_areas[i];
+		cma->cma_kobj = cma_kobj;
+		cma_kobj->cma = cma;
+		err = kobject_init_and_add(&cma_kobj->kobj, &cma_ktype,
+					   cma_kobj_root, "%s", cma->name);
+		if (err) {
+			kobject_put(&cma_kobj->kobj);
+			goto out;
+		}
+	}
+
+	return 0;
+out:
+	while (--i >= 0) {
+		cma = &cma_areas[i];
+		kobject_put(&cma->cma_kobj->kobj);
+	}
+	kobject_put(cma_kobj_root);
+
+	return err;
+}
+subsys_initcall(cma_sysfs_init);
-- 
2.31.0.291.g576ba9dcdaf-goog

