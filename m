Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE89244F6BB
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Nov 2021 06:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbhKNFfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 00:35:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbhKNFfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 00:35:18 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91626C061570
        for <linux-kernel@vger.kernel.org>; Sat, 13 Nov 2021 21:32:25 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id y14-20020a17090a2b4e00b001a5824f4918so10427170pjc.4
        for <linux-kernel@vger.kernel.org>; Sat, 13 Nov 2021 21:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MgueYmJH6JhvtShTtSZFX55Y7uxOUTzh0Cdv1hy257w=;
        b=YImU697r3d45YCskg6YRjABmvBMUcw6zSMiW+AKzne7tSNV33B3SgPtbjPJfjVd0PG
         BKCNFqftEerP0mBbum/D03K+7yRpPkzoRnJxzGMQDh+5c3AVN6RiJ6oUDh4PL2NqaIe0
         FTUQLdk1H/jCNDXNQiRPW4EHdvH0MbjtbJf3zHlLLo4IrWJCYvD7pRzIfev7j6uESAQ3
         tB6sgvVEqOMXKoy4JCmdZRFn9JSwrorMiThjLowdAEoUxL5P6wNrSGku6W4OXrPpR/Sx
         TaeronMe+1dRhuCstoLGW0CSzxhu697kmT6e6LcXbZJAFQVGu1/lHIbloTCUhGCIz4xS
         yt7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MgueYmJH6JhvtShTtSZFX55Y7uxOUTzh0Cdv1hy257w=;
        b=rtOUpCCymwvql1LU+hRkAA5DJUXi+Pm99KLiGD7s3ELRnE8/Ek5Y7dhUqgc4HqZ72S
         EbaH8xpO9Nkdml1W18dnn1dvtnMImXLe3BFng+4Z6mO4wf6CcFIuFYAMK5Gw+06V9VJf
         6HRDemDzm7N6J+lfLNQYZV6jiwhdCb+aX24aIYe46nTx2BMT9iKwNaeqMmsOCqPgyr0u
         Rby01uz2H7IR0hnS1tHk/Igg/7sFlLNiPMDKTBySqhLfLGL1Qr4iZ7YU/DUlGkYoIKdN
         QLzvW4S27ZLkDHeEjp91HRnVjn2Vww0wd2t125ePXddKWOoFZMGoHKbwLds3nEifANXc
         wZKA==
X-Gm-Message-State: AOAM532jkCT/xaEyPfUW3p6Dsfdkwh270m91xqsE8OOtzfR3hzuYn9y7
        5gBf6fjE/ojZl8aFWsjuPQY=
X-Google-Smtp-Source: ABdhPJyCmB0DcIWWnYEVkmDrVH5tK6OHjCoTYYxdcOL97lF3KX/7H+0f9VHyZN+up2eaOQy4aiy/CA==
X-Received: by 2002:a17:90b:4f45:: with SMTP id pj5mr33891316pjb.70.1636867944937;
        Sat, 13 Nov 2021 21:32:24 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id v10sm11543437pfg.162.2021.11.13.21.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Nov 2021 21:32:23 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     torvalds@linux-foundation.org, arnd@arndb.de, hughd@google.com,
        kirill.shutemov@linux.intel.com, willy@infradead.org,
        naoya.horiguchi@nec.com, osalvador@suse.de, peterx@redhat.com,
        ajaygargnsit@gmail.com, songmuchun@bytedance.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [UPDATE PATCH] mm: shmem: don't truncate page if memory failure happens
Date:   Sat, 13 Nov 2021 21:32:21 -0800
Message-Id: <20211114053221.315753-1-shy828301@gmail.com>
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
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
Fixed pointer dereference oops reported by Ajay Garg and reworked the
error handling of shmem_write_begin() suggested by Linus.

 mm/memory-failure.c | 14 ++++++++++---
 mm/shmem.c          | 48 +++++++++++++++++++++++++++++++++++++++------
 mm/userfaultfd.c    |  5 +++++
 3 files changed, 58 insertions(+), 9 deletions(-)

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
index dc038ce78700..a50be6486509 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2456,6 +2456,7 @@ shmem_write_begin(struct file *file, struct address_space *mapping,
 	struct inode *inode = mapping->host;
 	struct shmem_inode_info *info = SHMEM_I(inode);
 	pgoff_t index = pos >> PAGE_SHIFT;
+	int ret = 0;
 
 	/* i_rwsem is held by caller */
 	if (unlikely(info->seals & (F_SEAL_GROW |
@@ -2466,7 +2467,18 @@ shmem_write_begin(struct file *file, struct address_space *mapping,
 			return -EPERM;
 	}
 
-	return shmem_getpage(inode, index, pagep, SGP_WRITE);
+	ret = shmem_getpage(inode, index, pagep, SGP_WRITE);
+
+	if (ret)
+		return ret;
+
+	if (*pagep && PageHWPoison(*pagep)) {
+		unlock_page(*pagep);
+		put_page(*pagep);
+		ret = -EIO;
+	}
+
+	return ret;
 }
 
 static int
@@ -2553,6 +2565,12 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
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
@@ -3092,7 +3110,8 @@ static const char *shmem_get_link(struct dentry *dentry,
 		page = find_get_page(inode->i_mapping, 0);
 		if (!page)
 			return ERR_PTR(-ECHILD);
-		if (!PageUptodate(page)) {
+		if (PageHWPoison(page) ||
+		    !PageUptodate(page)) {
 			put_page(page);
 			return ERR_PTR(-ECHILD);
 		}
@@ -3100,6 +3119,13 @@ static const char *shmem_get_link(struct dentry *dentry,
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
@@ -3750,6 +3776,13 @@ static void shmem_destroy_inodecache(void)
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
@@ -3760,7 +3793,7 @@ const struct address_space_operations shmem_aops = {
 #ifdef CONFIG_MIGRATION
 	.migratepage	= migrate_page,
 #endif
-	.error_remove_page = generic_error_remove_page,
+	.error_remove_page = shmem_error_remove_page,
 };
 EXPORT_SYMBOL(shmem_aops);
 
@@ -4168,9 +4201,12 @@ struct page *shmem_read_mapping_page_gfp(struct address_space *mapping,
 	error = shmem_getpage_gfp(inode, index, &page, SGP_CACHE,
 				  gfp, NULL, NULL, NULL);
 	if (error)
-		page = ERR_PTR(error);
-	else
-		unlock_page(page);
+		return ERR_PTR(error);
+
+	unlock_page(page);
+	if (PageHWPoison(page))
+		return ERR_PTR(-EIO);
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

