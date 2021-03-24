Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCA7346E75
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 02:07:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233584AbhCXBGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 21:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbhCXBF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 21:05:58 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED354C061763
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 18:05:53 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id h25so13518623pgm.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 18:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K3JFtJWQd/C0OfBSZS9XDc9/4lP74Coz9DMoEZYEllw=;
        b=XH5fOTSC9ye2rSMif7Z3pi9PTjcxrhN0TdouzDiC7xScVsn/U51eWb5IYcqa7C+5MU
         JRfOkd9Gwj5R2zR0Xp5IsYRsDzm89i2vhouCcw+llCkcKZWqEsofBw+uCh9IXYxezzF2
         WdXEkpqlR6GFTwSgJahyPJTbU8r4M7uqeDjewtxP4zFz5sf0PloXpm/O+v5GqwGV6NLl
         Jq4Ap1mrZ5GQ3mmQ1T0vBLB9Sjcq0pQCQ9LBr1l12d+CK6idqYAsX8W9F/jvGKqEwjif
         NBS7r89WiVfl+H5i9S/NF4vkjdUF1V4Ay/1bBL43uqrrdxFkMyIDmD1iM5wR6Qy4DeGT
         cXEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=K3JFtJWQd/C0OfBSZS9XDc9/4lP74Coz9DMoEZYEllw=;
        b=NyRNQRCHmUCJEiPgVDhGVlQ0enRI9bP8OPwAXzZ6/s8TvgjQyggxFCHm6UmZ3EaQ2y
         CXeC0HhG6NvESDtbOHpZHmu1jeEdUPY6POsU4jzX+bIMozYRbd3y8KS0U0eLQe6YgiaB
         JZnl441RyjrkAuvC7Cq94141RQepeKOq3yyr1IIKBGasGpRkwIYcjtvbY3wa41spMmm6
         plpHsmyFIxk/KWDhANaZT0pYqlvmZCHogZ3Ozd9PymBOFsckf+43tnunKcxwlMFoXEkH
         arJqs4v6F8HEQpkwrxUVIfe3dFB0AEmNs8oA+r3TfM16e47pNmq3unge9qFhXPIE8G4n
         J4Ng==
X-Gm-Message-State: AOAM532d5ofyAadHlg2nh18neXO1PT3/KwiHjCFTtuxuZed2Wub1TUSb
        WSpHCk8WT/rN9zUxdyfA1oU=
X-Google-Smtp-Source: ABdhPJwNdSME4Z4oHhB7gsGlkIEo46/HfwbLm8f6X2uJiw7w0B8GcEkhXYG5bNFq2rM1azlw87nCPA==
X-Received: by 2002:aa7:9a1a:0:b029:1ee:ea41:9a2b with SMTP id w26-20020aa79a1a0000b02901eeea419a2bmr570530pfj.42.1616547953301;
        Tue, 23 Mar 2021 18:05:53 -0700 (PDT)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:201:7dfa:1e53:536:7976])
        by smtp.gmail.com with ESMTPSA id g22sm332491pju.30.2021.03.23.18.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 18:05:52 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        gregkh@linuxfoundation.org, surenb@google.com, joaodias@google.com,
        jhubbard@nvidia.com, willy@infradead.org, digetx@gmail.com,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH v6] mm: cma: support sysfs
Date:   Tue, 23 Mar 2021 18:05:47 -0700
Message-Id: <20210324010547.4134370-1-minchan@kernel.org>
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

These two values allow the user to calculate the allocation
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
From v5 - https://lore.kernel.org/linux-mm/20210323195050.2577017-1-minchan@kernel.org/
 * refactoring and fix typo - digetx@

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

 Documentation/ABI/testing/sysfs-kernel-mm-cma |  25 ++++
 mm/Kconfig                                    |   7 ++
 mm/Makefile                                   |   1 +
 mm/cma.c                                      |   7 +-
 mm/cma.h                                      |  23 ++++
 mm/cma_sysfs.c                                | 107 ++++++++++++++++++
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
index 908f04775686..204e349a0c25 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -507,10 +507,13 @@ struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
 
 	pr_debug("%s(): returned %p\n", __func__, page);
 out:
-	if (page)
+	if (page) {
 		count_vm_event(CMA_ALLOC_SUCCESS);
-	else
+		cma_sysfs_account_success_pages(cma, count);
+	} else {
 		count_vm_event(CMA_ALLOC_FAIL);
+		cma_sysfs_account_fail_pages(cma, count);
+	}
 
 	return page;
 }
diff --git a/mm/cma.h b/mm/cma.h
index 42ae082cb067..2298a2e736a6 100644
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
+	struct cma_kobject *kobj;
+#endif
 };
 
 extern struct cma cma_areas[MAX_CMA_AREAS];
@@ -26,4 +40,13 @@ static inline unsigned long cma_bitmap_maxno(struct cma *cma)
 	return cma->count >> cma->order_per_bit;
 }
 
+#ifdef CONFIG_CMA_SYSFS
+void cma_sysfs_account_success_pages(struct cma *cma, size_t count);
+void cma_sysfs_account_fail_pages(struct cma *cma, size_t count);
+#else
+static inline void cma_sysfs_account_success_pages(struct cma *cma,
+						   size_t count) {};
+static inline void cma_sysfs_account_fail_pages(struct cma *cma,
+						size_t count) {};
+#endif
 #endif
diff --git a/mm/cma_sysfs.c b/mm/cma_sysfs.c
new file mode 100644
index 000000000000..c3791a032dc5
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
+void cma_sysfs_account_success_pages(struct cma *cma, size_t count)
+{
+	atomic64_add(count, &cma->nr_pages_succeeded);
+}
+
+void cma_sysfs_account_fail_pages(struct cma *cma, size_t count)
+{
+	atomic64_add(count, &cma->nr_pages_failed);
+}
+
+#define CMA_ATTR_RO(_name) \
+	static struct kobj_attribute _name##_attr = __ATTR_RO(_name)
+
+#define to_cma_kobject(x) container_of(x, struct cma_kobject, kobj)
+
+static ssize_t alloc_pages_success_show(struct kobject *kobj,
+					struct kobj_attribute *attr, char *buf)
+{
+	struct cma_kobject *cma_kobj = to_cma_kobject(kobj);
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
+	struct cma_kobject *cma_kobj = to_cma_kobject(kobj);
+	struct cma *cma = cma_kobj->cma;
+
+	return sysfs_emit(buf, "%llu\n", atomic64_read(&cma->nr_pages_failed));
+}
+CMA_ATTR_RO(alloc_pages_fail);
+
+static void cma_kobj_release(struct kobject *kobj)
+{
+	struct cma_kobject *cma_kobj = to_cma_kobject(kobj);
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
+	unsigned int i;
+
+	cma_kobj_root = kobject_create_and_add("cma", mm_kobj);
+	if (!cma_kobj_root)
+		return -ENOMEM;
+
+	for (i = 0; i < cma_area_count; i++) {
+		int err;
+		struct cma *cma;
+		struct cma_kobject *cma_kobj;
+
+		cma_kobj = kzalloc(sizeof(*cma_kobj), GFP_KERNEL);
+		if (!cma_kobj) {
+			kobject_put(cma_kobj_root);
+			return -ENOMEM;
+		}
+
+		cma = &cma_areas[i];
+		cma->kobj = cma_kobj;
+		cma_kobj->cma = cma;
+		err = kobject_init_and_add(&cma_kobj->kobj, &cma_ktype,
+					   cma_kobj_root, "%s", cma->name);
+		if (err) {
+			kobject_put(&cma_kobj->kobj);
+			kobject_put(cma_kobj_root);
+			return err;
+		}
+	}
+
+	return 0;
+}
+subsys_initcall(cma_sysfs_init);
-- 
2.31.0.291.g576ba9dcdaf-goog

