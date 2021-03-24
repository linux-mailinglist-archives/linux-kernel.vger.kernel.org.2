Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBBB3481D2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 20:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237956AbhCXTVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 15:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237893AbhCXTUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 15:20:49 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADCDC061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 12:20:49 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id x26so18087577pfn.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 12:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lvb7hlibIPwzR60x/yUMbLm1jxf0Ps+EL44ahkPgqgk=;
        b=sP+UjYtD0EYGlXpp6dl2cOxcX20AueElPepb+bh68mFOcQQWIC9ArIpI/5bWe3KZaq
         rnVfmYjeeRC9tXa59+w6AU80c0EfhHcteOZvRxe/NE4p4jWGIMxIjrleJZ5juPW4AH9q
         lUW+aHzbPPJuLrHwkIiJB3Q2qfJs64IPmGDD1Hr3oEPUro7bGS95HN8tnQw7b5GO58Ey
         QtaR16tnU9yKP907tmHy3mK7ofnbaGyWSdQ7vZfg+AA3PCTHThFIFKug8EmfFVnow5aB
         zgZFQpZho2QmU2rHa5Q2krToeM7iSI6andvc+nPJBNbvzs2dGyeN7x3mq9FcvPLQhayH
         eybA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=lvb7hlibIPwzR60x/yUMbLm1jxf0Ps+EL44ahkPgqgk=;
        b=qTF3w3oqt8nuPus1m4V9I3+2XiPJ08ndvvopbEMFhnlzUOCkMu4pSen1Mz4tFCtzJr
         LG7qygU+KN6sfB7XhpIYWb/7YaJiMJvMlZPH1welvdSCMGxUClt1eIDVau8m8686LCJE
         vekC7gTZWGDjQWUQZ3fs0JZHzn/WpYhoghj5vFAv5QDaCjvuK8Vm5TyKgEtaZUdcNEBp
         rUKqpQ8gZBrZ3hhlsJ4eq2cXlLtmkcMUzJ0ayMYCazRR3qiC4IeNQbAiyswp78s812hZ
         JXcUoxj+F5aaJloP+fGs1MLyblFKS/QSO1yjb0OhK1ANpDR2cU9shhdvA+Jyk5h2R0+M
         mq5A==
X-Gm-Message-State: AOAM533Vwbij1Gluzd3HVmHjCVjHukNdSvkIyOKvcwIoZGxAOzPOu8rL
        22gffYBbqFQVXmdUg4wXcbo=
X-Google-Smtp-Source: ABdhPJyl7WMk3WqPOcoEn2Z9BfcptKKY4nyp60428xzj+BuWTbxRuruwfPWC380+G8Rid0RvvyUZ4Q==
X-Received: by 2002:a63:5343:: with SMTP id t3mr4354311pgl.136.1616613649042;
        Wed, 24 Mar 2021 12:20:49 -0700 (PDT)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:201:7dfa:1e53:536:7976])
        by smtp.gmail.com with ESMTPSA id e20sm3337210pgm.1.2021.03.24.12.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 12:20:48 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        gregkh@linuxfoundation.org, surenb@google.com, joaodias@google.com,
        jhubbard@nvidia.com, willy@infradead.org, digetx@gmail.com,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH] mm: cma: fix corruption cma_sysfs_alloc_pages_count
Date:   Wed, 24 Mar 2021 12:20:44 -0700
Message-Id: <20210324192044.1505747-1-minchan@kernel.org>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct cma_stat's lifespan for cma_sysfs is different with
struct cma because kobject for sysfs requires dynamic object
while CMA is static object[1]. When CMA is initialized,
it couldn't use slab to allocate cma_stat since slab was not
initialized yet. Thus, it allocates the dynamic object
in subsys_initcall.

However, the cma allocation can happens before subsys_initcall
then, it goes crash.

Dmitry reported[2]:

..
[    1.226190] [<c027762f>] (cma_sysfs_alloc_pages_count) from [<c027706f>] (cma_alloc+0x153/0x274)
[    1.226720] [<c027706f>] (cma_alloc) from [<c01112ab>] (__alloc_from_contiguous+0x37/0x8c)
[    1.227272] [<c01112ab>] (__alloc_from_contiguous) from [<c1104af9>] (atomic_pool_init+0x7b/0x126)
[    1.233596] [<c1104af9>] (atomic_pool_init) from [<c0101d69>] (do_one_initcall+0x45/0x1e4)
[    1.234188] [<c0101d69>] (do_one_initcall) from [<c1101141>] (kernel_init_freeable+0x157/0x1a6)
[    1.234741] [<c1101141>] (kernel_init_freeable) from [<c0a27fd1>] (kernel_init+0xd/0xe0)
[    1.235289] [<c0a27fd1>] (kernel_init) from [<c0100155>] (ret_from_fork+0x11/0x1c)

This patch moves those statistic fields of cma_stat into struct cma
and introduces cma_kobject wrapper to follow kobject's rule.

At the same time, it fixes other routines based on suggestions[3][4].

[1] https://lore.kernel.org/linux-mm/YCOAmXqt6dZkCQYs@kroah.com/
[2] https://lore.kernel.org/linux-mm/fead70a2-4330-79ff-e79a-d8511eab1256@gmail.com/
[3] https://lore.kernel.org/linux-mm/20210323195050.2577017-1-minchan@kernel.org/
[4] https://lore.kernel.org/linux-mm/20210324010547.4134370-1-minchan@kernel.org/

Reported-by: Dmitry Osipenko <digetx@gmail.com>
Tested-by: Dmitry Osipenko <digetx@gmail.com>
Suggested-by: Dmitry Osipenko <digetx@gmail.com>
Suggested-by: John Hubbard <jhubbard@nvidia.com>
Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
I belive it's worth to have separate patch rather than replacing
original patch. It will also help to merge without conflict
since we already filed other patch based on it.
Strictly speaking, separating fix part and readbility part
in this patch would be better but it's gray to separate them
since most code in this patch was done while we were fixing
the bug. Since we don't release it yet, I hope it will work.
Otherwise, I can send a replacement patch inclucing all of
changes happend until now with gathering SoB.

 mm/cma.c       |  4 +--
 mm/cma.h       | 25 +++++++-------
 mm/cma_sysfs.c | 88 ++++++++++++++++++++++++++++----------------------
 3 files changed, 65 insertions(+), 52 deletions(-)

diff --git a/mm/cma.c b/mm/cma.c
index 90e27458ddb7..08c45157911a 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -509,11 +509,11 @@ struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
 out:
 	if (page) {
 		count_vm_event(CMA_ALLOC_SUCCESS);
-		cma_sysfs_alloc_pages_count(cma, count);
+		cma_sysfs_account_success_pages(cma, count);
 	} else {
 		count_vm_event(CMA_ALLOC_FAIL);
 		if (cma)
-			cma_sysfs_fail_pages_count(cma, count);
+			cma_sysfs_account_fail_pages(cma, count);
 	}
 
 	return page;
diff --git a/mm/cma.h b/mm/cma.h
index 95d1aa2d808a..37b9b7858c8e 100644
--- a/mm/cma.h
+++ b/mm/cma.h
@@ -5,12 +5,8 @@
 #include <linux/debugfs.h>
 #include <linux/kobject.h>
 
-struct cma_stat {
-	spinlock_t lock;
-	/* the number of CMA page successful allocations */
-	unsigned long nr_pages_succeeded;
-	/* the number of CMA page allocation failures */
-	unsigned long nr_pages_failed;
+struct cma_kobject {
+	struct cma *cma;
 	struct kobject kobj;
 };
 
@@ -27,7 +23,12 @@ struct cma {
 #endif
 	char name[CMA_MAX_NAME];
 #ifdef CONFIG_CMA_SYSFS
-	struct cma_stat	*stat;
+	/* the number of CMA page successful allocations */
+	atomic64_t nr_pages_succeeded;
+	/* the number of CMA page allocation failures */
+	atomic64_t nr_pages_failed;
+	/* kobject requires dynamic object */
+	struct cma_kobject *cma_kobj;
 #endif
 };
 
@@ -40,10 +41,12 @@ static inline unsigned long cma_bitmap_maxno(struct cma *cma)
 }
 
 #ifdef CONFIG_CMA_SYSFS
-void cma_sysfs_alloc_pages_count(struct cma *cma, size_t count);
-void cma_sysfs_fail_pages_count(struct cma *cma, size_t count);
+void cma_sysfs_account_success_pages(struct cma *cma, unsigned long nr_pages);
+void cma_sysfs_account_fail_pages(struct cma *cma, unsigned long nr_pages);
 #else
-static inline void cma_sysfs_alloc_pages_count(struct cma *cma, size_t count) {};
-static inline void cma_sysfs_fail_pages_count(struct cma *cma, size_t count) {};
+static inline void cma_sysfs_account_success_pages(struct cma *cma,
+						   unsigned long nr_pages) {};
+static inline void cma_sysfs_account_fail_pages(struct cma *cma,
+						unsigned long nr_pages) {};
 #endif
 #endif
diff --git a/mm/cma_sysfs.c b/mm/cma_sysfs.c
index 3134b2b3a96d..a670a80aad6f 100644
--- a/mm/cma_sysfs.c
+++ b/mm/cma_sysfs.c
@@ -11,50 +11,54 @@
 
 #include "cma.h"
 
-static struct cma_stat *cma_stats;
-
-void cma_sysfs_alloc_pages_count(struct cma *cma, size_t count)
+void cma_sysfs_account_success_pages(struct cma *cma, unsigned long nr_pages)
 {
-	spin_lock(&cma->stat->lock);
-	cma->stat->nr_pages_succeeded += count;
-	spin_unlock(&cma->stat->lock);
+	atomic64_add(nr_pages, &cma->nr_pages_succeeded);
 }
 
-void cma_sysfs_fail_pages_count(struct cma *cma, size_t count)
+void cma_sysfs_account_fail_pages(struct cma *cma, unsigned long nr_pages)
 {
-	spin_lock(&cma->stat->lock);
-	cma->stat->nr_pages_failed += count;
-	spin_unlock(&cma->stat->lock);
+	atomic64_add(nr_pages, &cma->nr_pages_failed);
 }
 
 #define CMA_ATTR_RO(_name) \
 	static struct kobj_attribute _name##_attr = __ATTR_RO(_name)
 
-static struct kobject *cma_kobj;
+static inline struct cma *cma_from_kobj(struct kobject *kobj)
+{
+	struct cma_kobject *cma_kobj = container_of(kobj, struct cma_kobject,
+						    kobj);
+	struct cma *cma = cma_kobj->cma;
+
+	return cma;
+}
 
 static ssize_t alloc_pages_success_show(struct kobject *kobj,
-			struct kobj_attribute *attr, char *buf)
+					struct kobj_attribute *attr, char *buf)
 {
-	struct cma_stat *stat = container_of(kobj, struct cma_stat, kobj);
+	struct cma *cma = cma_from_kobj(kobj);
 
-	return sysfs_emit(buf, "%lu\n", stat->nr_pages_succeeded);
+	return sysfs_emit(buf, "%llu\n",
+			atomic64_read(&cma->nr_pages_succeeded));
 }
 CMA_ATTR_RO(alloc_pages_success);
 
 static ssize_t alloc_pages_fail_show(struct kobject *kobj,
-			struct kobj_attribute *attr, char *buf)
+				     struct kobj_attribute *attr, char *buf)
 {
-	struct cma_stat *stat = container_of(kobj, struct cma_stat, kobj);
+	struct cma *cma = cma_from_kobj(kobj);
 
-	return sysfs_emit(buf, "%lu\n", stat->nr_pages_failed);
+	return sysfs_emit(buf, "%llu\n", atomic64_read(&cma->nr_pages_failed));
 }
 CMA_ATTR_RO(alloc_pages_fail);
 
 static void cma_kobj_release(struct kobject *kobj)
 {
-	struct cma_stat *stat = container_of(kobj, struct cma_stat, kobj);
+	struct cma *cma = cma_from_kobj(kobj);
+	struct cma_kobject *cma_kobj = cma->cma_kobj;
 
-	kfree(stat);
+	kfree(cma_kobj);
+	cma->cma_kobj = NULL;
 }
 
 static struct attribute *cma_attrs[] = {
@@ -67,44 +71,50 @@ ATTRIBUTE_GROUPS(cma);
 static struct kobj_type cma_ktype = {
 	.release = cma_kobj_release,
 	.sysfs_ops = &kobj_sysfs_ops,
-	.default_groups = cma_groups
+	.default_groups = cma_groups,
 };
 
 static int __init cma_sysfs_init(void)
 {
-	int i = 0;
+	struct kobject *cma_kobj_root;
+	struct cma_kobject *cma_kobj;
 	struct cma *cma;
+	unsigned int i;
+	int err;
 
-	cma_kobj = kobject_create_and_add("cma", mm_kobj);
-	if (!cma_kobj)
+	cma_kobj_root = kobject_create_and_add("cma", mm_kobj);
+	if (!cma_kobj_root)
 		return -ENOMEM;
 
-	cma_stats = kmalloc_array(cma_area_count, sizeof(struct cma_stat),
-				GFP_KERNEL|__GFP_ZERO);
-	if (ZERO_OR_NULL_PTR(cma_stats))
-		goto out;
+	for (i = 0; i < cma_area_count; i++) {
+		cma_kobj = kzalloc(sizeof(*cma_kobj), GFP_KERNEL);
+		if (!cma_kobj) {
+			err = -ENOMEM;
+			goto out;
+		}
 
-	do {
 		cma = &cma_areas[i];
-		cma->stat = &cma_stats[i];
-		spin_lock_init(&cma->stat->lock);
-		if (kobject_init_and_add(&cma->stat->kobj, &cma_ktype,
-					cma_kobj, "%s", cma->name)) {
-			kobject_put(&cma->stat->kobj);
+		cma->cma_kobj = cma_kobj;
+		cma_kobj->cma = cma;
+		err = kobject_init_and_add(&cma_kobj->kobj, &cma_ktype,
+				cma_kobj_root, "%s", cma->name);
+		if (err) {
+			kobject_put(&cma_kobj->kobj);
 			goto out;
 		}
-	} while (++i < cma_area_count);
+	}
 
 	return 0;
 out:
 	while (--i >= 0) {
 		cma = &cma_areas[i];
-		kobject_put(&cma->stat->kobj);
-	}
 
-	kfree(cma_stats);
-	kobject_put(cma_kobj);
+		kobject_put(&cma->cma_kobj->kobj);
+		kfree(cma->cma_kobj);
+		cma->cma_kobj = NULL;
+	}
+	kobject_put(cma_kobj_root);
 
-	return -ENOMEM;
+	return err;
 }
 subsys_initcall(cma_sysfs_init);
-- 
2.31.0.291.g576ba9dcdaf-goog

