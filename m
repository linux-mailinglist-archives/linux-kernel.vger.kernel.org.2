Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2268234833D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 21:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238234AbhCXU4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 16:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238239AbhCXUzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 16:55:09 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E05C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 13:55:09 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id r17so15574531pgi.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 13:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vhkEm/SHJKStJUM0tBoJZDo4DIEM68CcqFjzc0CMZVs=;
        b=GJSVohAgu/dyUFIqGQSzfZBFwM1stJN1/k4oOq1co35d4SV1TzkE1+W9O10ouBUKFa
         RFwgFyhnhQPZNaLoJ3NIhZfYwBNgBV9m3/QbwSwGroA2/EDLMZGY5juUb6hjtKA/USE5
         pqGmgO2mH13oTFHQYPSSi9v+tZbAn+qZ2hdIO5ifAXDJeYlvg65oKV72XOPV3c0KjeNN
         kHHsQtMHp71f6oR7TSoix7O5ZXuumO1TcdX1J/Vn4siWTP7wDLY0DeiRLs0M+44BQfIE
         42JjegQt4jwlSxpgNii0zhRYbtnGN+h7CqBC6CjPTqdj8PdsmY8QC9w3CqKldcvk7/6j
         h0JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=vhkEm/SHJKStJUM0tBoJZDo4DIEM68CcqFjzc0CMZVs=;
        b=ZBphWjrpxRhyFhulRJCcRV8+yIlRNyjHwowHWO09FM8dOJkmKeKYKrVZY9IWt6qLyI
         cKEkDXUXD+wcjLxuJ9suHUetNSWFp/THMAWnsVYH6uF5iYEmy9FcVxd5fkLZw7vFs7g1
         U8r2X2DVJLUXj8XcXQOlD6TGR/ilDsaLYSS7rlx69lYD9j28jib8H3V/KllMdLm8fm3h
         th+qkzXN9u8wPAae86leRHGUHEH2GHDB7uXqlYF0yoZzZZY8YctOGlMFBkNUodcMOBSr
         M7CTSFoF52WsE56KVjDETsx0K0sGVsuQp/cUl3g9Jh6+GhzxMhmXOUbV+uxmzASlfC8L
         layg==
X-Gm-Message-State: AOAM532x/ON7x5hgBOaEq0PvWH81+CLCnB0D+AEraWzcLoDhynvk224g
        cQaA7ot8yFvPhKh8igwinzA=
X-Google-Smtp-Source: ABdhPJyBO6pJIX9i425oyFhuwkuOh1xaqhVprtIprTyMQJGUqpvZYOWTuPYWyVzPn3uQlb9XxC2cDg==
X-Received: by 2002:a65:5289:: with SMTP id y9mr3851683pgp.447.1616619308674;
        Wed, 24 Mar 2021 13:55:08 -0700 (PDT)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:201:7dfa:1e53:536:7976])
        by smtp.gmail.com with ESMTPSA id z4sm3212448pgv.73.2021.03.24.13.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 13:55:07 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        gregkh@linuxfoundation.org, surenb@google.com, joaodias@google.com,
        jhubbard@nvidia.com, willy@infradead.org, digetx@gmail.com,
        Minchan Kim <minchan@kernel.org>,
        Colin Ian King <colin.king@canonical.com>
Subject: [PATCH v7] mm: cma: support sysfs
Date:   Wed, 24 Mar 2021 13:55:03 -0700
Message-Id: <20210324205503.2132082-1-minchan@kernel.org>
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

Reported-by: Dmitry Osipenko <digetx@gmail.com>
Tested-by: Dmitry Osipenko <digetx@gmail.com>
Suggested-by: Dmitry Osipenko <digetx@gmail.com>
Suggested-by: John Hubbard <jhubbard@nvidia.com>
Suggested-by: Matthew Wilcox <willy@infradead.org>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Addresses-Coverity: ("Dereference after null check")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
Andrew, you could apply this patch after revering these patches:

mm: cma: fix potential null dereference on pointer cma
mm: cma: support sysfs

From v6 - https://lore.kernel.org/linux-mm/20210324010547.4134370-1-minchan@kernel.org/
From v5 - https://lore.kernel.org/linux-mm/20210323195050.2577017-1-minchan@kernel.org/
From v4 - https://lore.kernel.org/linux-mm/20210309062333.3216138-1-minchan@kernel.org/
 * fix corruption - digetx@
 * refactoring - digetx@, jhubbard@, willy@

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
 mm/cma_sysfs.c                                | 116 ++++++++++++++++++
 6 files changed, 178 insertions(+), 2 deletions(-)
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
index 42ae082cb067..37b9b7858c8e 100644
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
index 000000000000..73463be08df7
--- /dev/null
+++ b/mm/cma_sysfs.c
@@ -0,0 +1,116 @@
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
+#define CMA_ATTR_RO(_name) \
+	static struct kobj_attribute _name##_attr = __ATTR_RO(_name)
+
+static inline struct cma *cma_from_kobj(struct kobject *kobj)
+{
+	struct cma_kobject *cma_kobj = container_of(kobj, struct cma_kobject,
+						    kobj);
+	struct cma *cma = cma_kobj->cma;
+
+	return cma;
+}
+
+static ssize_t alloc_pages_success_show(struct kobject *kobj,
+					struct kobj_attribute *attr, char *buf)
+{
+	struct cma *cma = cma_from_kobj(kobj);
+
+	return sysfs_emit(buf, "%llu\n",
+			atomic64_read(&cma->nr_pages_succeeded));
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
+				cma_kobj_root, "%s", cma->name);
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

