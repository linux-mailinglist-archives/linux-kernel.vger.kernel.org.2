Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 296A6453A39
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 20:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240037AbhKPTft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 14:35:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240016AbhKPTfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 14:35:48 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48189C061746
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 11:32:51 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id t21so69448plr.6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 11:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p6xWK3uwJDHO1zkDmUf7t/XAdhPbA12oaAOn1xUoYtE=;
        b=UPjx8xJpkUb3WUSPuravw6+s00KQq+VssZoQJRx6EVp2ycEnqZln/sdsmnqIN8Jnxu
         wJ4x0VEhuNaotGvfO8ByZMEYo6glrbE2Vnd1XBGXWYoXttQKhCkTXV0cxqdbfFaCTrAd
         T4xmvTOG6T1YkcnWJja1wMgHKteZJUQXAY/uRwkIH2xQbDAbkQ+qWEJTRcHVak1GKhEM
         2izp23DHKbVEwoRDRqfhDZevjMl/Fj3auw2Uw9smU3w1SqzGD/yxoSDlHFSpY4DkB9Nj
         ckzquhq3MGLUZjVbeHV7GagWDhoHWgLKdVrUqYsPPFS3yLrsnVVnDW4g8EG1lVT0BJo5
         kOjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p6xWK3uwJDHO1zkDmUf7t/XAdhPbA12oaAOn1xUoYtE=;
        b=hazqgkMN8KmtnJAoPLXwfYrggdLuuqmnzXb/VaY+JFtmn58/QNT3gINauVOhJsunyV
         RLNHgnvaDyk/rFW4L6YggUwcebBN1KWFOld5FTwGuTBWsQCzxQQjlnuzpWVE2ROGJy4n
         nLImx3nJMJrNrDbazPqIcIKBEOj4vFL0RIfQGAnpr8DKfre0yWB1a4Bhj3Np4MTXNASO
         DoYdRI62YNSpv0uXcv7W4HwXzjYd92nbbDXbWByIAVZnc/tK4l/FJB4WgjIitdByRrd4
         N2V4u4xrQyXFpRE+U9JTV8sRCN0lbqnfuuSK/jgfzeG3LBxLN34vH6z+zWDezGDQ335o
         2qqQ==
X-Gm-Message-State: AOAM533wlxrGHebSt8jv7vmB68OA9v63qVJ1XXn9DKS3r6EfTH+5S805
        ATClBKuhVwbOvbwtwFxLKas=
X-Google-Smtp-Source: ABdhPJxgxV8ZQnC59id/GTeiBdsrjOGGXQ9zilBQfIoAR53HpyOr/5/LuS0ZzJcyAOmbySDWTUwPiA==
X-Received: by 2002:a17:90a:5d8e:: with SMTP id t14mr1890719pji.95.1637091170771;
        Tue, 16 Nov 2021 11:32:50 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id g9sm20252942pfv.71.2021.11.16.11.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 11:32:49 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        arnd@arndb.de, willy@infradead.org, hughd@google.com,
        kirill.shutemov@linux.intel.com, naoya.horiguchi@nec.com,
        osalvador@suse.de, peterx@redhat.com, ajaygargnsit@gmail.com,
        songmuchun@bytedance.com
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [v2 UPDATE PATCH] mm: shmem: don't truncate page if memory failure happens
Date:   Tue, 16 Nov 2021 11:32:47 -0800
Message-Id: <20211116193247.21102-1-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current behavior of memory failure is to truncate the page cache
regardless of dirty or clean.  If the page is dirty the later access
will get the obsolete data from disk without any notification to the
users.  This may cause silent data loss.  It is even worse for shmem
since shmem is in-memory filesystem, truncating page cache means
discarding data blocks.  The later read would return all zero.

The right approach is to keep the corrupted page in page cache, any
later access would return error for syscalls or SIGBUS for page fault,
until the file is truncated, hole punched or removed.  The regular
storage backed filesystems would be more complicated so this patch is
focused on shmem.  This also unblock the support for soft offlining
shmem THP.

[arnd@arndb.de: fix uninitialized variable use in me_pagecache_clean()]
  Link: https://lkml.kernel.org/r/20211022064748.4173718-1-arnd@kernel.org
[Fix invalid pointer dereference in shmem_read_mapping_page_gfp() with a
 slight different implementation from what Ajay Garg <ajaygargnsit@gmail.com>
 and Muchun Song <songmuchun@bytedance.com> proposed and reworked the
 error handling of shmem_write_begin() suggested by Linus]
  Link: https://lore.kernel.org/linux-mm/20211111084617.6746-1-ajaygargnsit@gmail.com/

Link: https://lkml.kernel.org/r/20211020210755.23964-6-shy828301@gmail.com
Signed-off-by: Yang Shi <shy828301@gmail.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Hugh Dickins <hughd@google.com>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Naoya Horiguchi <naoya.horiguchi@nec.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Peter Xu <peterx@redhat.com>
Cc: Ajay Garg <ajaygargnsit@gmail.com>
Cc: Muchun Song <songmuchun@bytedance.com>
---
v2: Incorporated the suggestions from Willy.
v1: Fixed pointer dereference oops reported by Ajay Garg and reworked the
    error handling of shmem_write_begin() suggested by Linus.

 mm/memory-failure.c | 14 ++++++++++---
 mm/shmem.c          | 51 +++++++++++++++++++++++++++++++++++++++------
 mm/userfaultfd.c    |  5 +++++
 3 files changed, 61 insertions(+), 9 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 07c875fdeaf0..f64ebb6226cb 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -58,6 +58,7 @@
 #include <linux/ratelimit.h>
 #include <linux/page-isolation.h>
 #include <linux/pagewalk.h>
+#include <linux/shmem_fs.h>
 #include "internal.h"
 #include "ras/ras_event.h"
 
@@ -867,6 +868,7 @@ static int me_pagecache_clean(struct page_state *ps, struct page *p)
 {
 	int ret;
 	struct address_space *mapping;
+	bool extra_pins;
 
 	delete_from_lru_cache(p);
 
@@ -895,18 +897,24 @@ static int me_pagecache_clean(struct page_state *ps, struct page *p)
 		goto out;
 	}
 
+	/*
+	 * The shmem page is kept in page cache instead of truncating
+	 * so is expected to have an extra refcount after error-handling.
+	 */
+	extra_pins = shmem_mapping(mapping);
+
 	/*
 	 * Truncation is a bit tricky. Enable it per file system for now.
 	 *
 	 * Open: to take i_rwsem or not for this? Right now we don't.
 	 */
 	ret = truncate_error_page(p, page_to_pfn(p), mapping);
+	if (has_extra_refcount(ps, p, extra_pins))
+		ret = MF_FAILED;
+
 out:
 	unlock_page(p);
 
-	if (has_extra_refcount(ps, p, false))
-		ret = MF_FAILED;
-
 	return ret;
 }
 
diff --git a/mm/shmem.c b/mm/shmem.c
index dc038ce78700..2ba64918132b 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2456,6 +2456,7 @@ shmem_write_begin(struct file *file, struct address_space *mapping,
 	struct inode *inode = mapping->host;
 	struct shmem_inode_info *info = SHMEM_I(inode);
 	pgoff_t index = pos >> PAGE_SHIFT;
+	int ret = 0;
 
 	/* i_rwsem is held by caller */
 	if (unlikely(info->seals & (F_SEAL_GROW |
@@ -2466,7 +2467,19 @@ shmem_write_begin(struct file *file, struct address_space *mapping,
 			return -EPERM;
 	}
 
-	return shmem_getpage(inode, index, pagep, SGP_WRITE);
+	ret = shmem_getpage(inode, index, pagep, SGP_WRITE);
+
+	if (ret)
+		return ret;
+
+	if (PageHWPoison(*pagep)) {
+		unlock_page(*pagep);
+		put_page(*pagep);
+		*pagep = NULL;
+		return -EIO;
+	}
+
+	return 0;
 }
 
 static int
@@ -2553,6 +2566,12 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 			if (sgp == SGP_CACHE)
 				set_page_dirty(page);
 			unlock_page(page);
+
+			if (PageHWPoison(page)) {
+				put_page(page);
+				error = -EIO;
+				break;
+			}
 		}
 
 		/*
@@ -3092,7 +3111,8 @@ static const char *shmem_get_link(struct dentry *dentry,
 		page = find_get_page(inode->i_mapping, 0);
 		if (!page)
 			return ERR_PTR(-ECHILD);
-		if (!PageUptodate(page)) {
+		if (PageHWPoison(page) ||
+		    !PageUptodate(page)) {
 			put_page(page);
 			return ERR_PTR(-ECHILD);
 		}
@@ -3100,6 +3120,13 @@ static const char *shmem_get_link(struct dentry *dentry,
 		error = shmem_getpage(inode, 0, &page, SGP_READ);
 		if (error)
 			return ERR_PTR(error);
+		if (!page)
+		       return ERR_PTR(-ECHILD);
+		if (PageHWPoison(page)) {
+			unlock_page(page);
+			put_page(page);
+			return ERR_PTR(-ECHILD);
+		}
 		unlock_page(page);
 	}
 	set_delayed_call(done, shmem_put_link, page);
@@ -3750,6 +3777,13 @@ static void shmem_destroy_inodecache(void)
 	kmem_cache_destroy(shmem_inode_cachep);
 }
 
+/* Keep the page in page cache instead of truncating it */
+static int shmem_error_remove_page(struct address_space *mapping,
+				   struct page *page)
+{
+	return 0;
+}
+
 const struct address_space_operations shmem_aops = {
 	.writepage	= shmem_writepage,
 	.set_page_dirty	= __set_page_dirty_no_writeback,
@@ -3760,7 +3794,7 @@ const struct address_space_operations shmem_aops = {
 #ifdef CONFIG_MIGRATION
 	.migratepage	= migrate_page,
 #endif
-	.error_remove_page = generic_error_remove_page,
+	.error_remove_page = shmem_error_remove_page,
 };
 EXPORT_SYMBOL(shmem_aops);
 
@@ -4168,9 +4202,14 @@ struct page *shmem_read_mapping_page_gfp(struct address_space *mapping,
 	error = shmem_getpage_gfp(inode, index, &page, SGP_CACHE,
 				  gfp, NULL, NULL, NULL);
 	if (error)
-		page = ERR_PTR(error);
-	else
-		unlock_page(page);
+		return ERR_PTR(error);
+
+	unlock_page(page);
+	if (PageHWPoison(page)) {
+		put_page(page);
+		return ERR_PTR(-EIO);
+	}
+
 	return page;
 #else
 	/*
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index ac6f036298cd..0780c2a57ff1 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -232,6 +232,11 @@ static int mcontinue_atomic_pte(struct mm_struct *dst_mm,
 		goto out;
 	}
 
+	if (PageHWPoison(page)) {
+		ret = -EIO;
+		goto out_release;
+	}
+
 	ret = mfill_atomic_install_pte(dst_mm, dst_pmd, dst_vma, dst_addr,
 				       page, false, wp_copy);
 	if (ret)
-- 
2.26.2

