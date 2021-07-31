Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 219B63DC415
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 08:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237548AbhGaGjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Jul 2021 02:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237430AbhGaGjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Jul 2021 02:39:52 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C844DC06175F
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 23:39:46 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id k2-20020ac847820000b029024ea3acef5bso5590212qtq.12
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 23:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+MG7KO18FjRhg16Po5bX500FIuiDvVXfmihsBqeNPd4=;
        b=P8UbmNylYr5Sj7rFQJyfHVoeATceJcM9Y3LBhLLzjMS852Qe3H6SWfkt2O49fY3w64
         SAs+YU79iJfg9I8SDTDk0mYD8I5uRxmUqM4e85Y5rvAfVddKAex0mEhQ5nOzEV0FvMzn
         wNS764jptVkqnrta+p2pHUNy37vYmIaU0nnL7UKVVe5faH8fjZwnnMI0wqNC7WOU08Cy
         mjkfygihnZwJ/1LdDtkQlr7bz67nznmfP4tQGNz+mOhlMzAdmL7TDx+/bl8WEZEmduKl
         RxtY2tp4N9pttsT0R7aj5O4VfDJPBOXvd9PCb7oIGtzZelh0HgNdo4uNkf+cLGlpr+q6
         mUDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+MG7KO18FjRhg16Po5bX500FIuiDvVXfmihsBqeNPd4=;
        b=hIlhMIgqGVhtuAmXC9e5VKdrLzX7VDWhJv6EsWqk3srM8tJUacADWDmznwYiWrJT81
         F4BlgG55jAMTPM//ueZvGPzKsNcyWo9wAAPPVZKzyyiw+UJKgH1wg6xys72WgJ7GDjR/
         sCD6rsE0UHu7RsnFCO4y4s61tqlhaSDuaAHNPGyFQw+tK8dD8ZIsH64YSACJhdPNu1jF
         U4Z4al/5QVzDslmDqTst5W4gVHjVTAFDmrigjjE78Hqe5XVKASQjtX617HwbLhP0nAyh
         czMG7rBYdupKvC3OBsEoGPU/nEPtNaEwyoXI1TdmydIBuGNktB9jfXkV9zPo8+4lWGDo
         b1Yw==
X-Gm-Message-State: AOAM532dsEFhkSXYPIjF8wNqw3gbuXaW/Gw7fCAt/nHOBBx1Yz8U9+9K
        SMX1Na3cbKIk12Pb9Oj5PPahMA6X4dE=
X-Google-Smtp-Source: ABdhPJyfLw+JGHTDtkurgYLTls9LSts2YZqcj8OoZnlbt/VPXwZmBRMFEnJJe1sPVvCKW+sKmgcQEMx43eg=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:2b92:c131:b08a:84c7])
 (user=yuzhao job=sendgmr) by 2002:ad4:59c6:: with SMTP id el6mr6675401qvb.61.1627713585980;
 Fri, 30 Jul 2021 23:39:45 -0700 (PDT)
Date:   Sat, 31 Jul 2021 00:39:38 -0600
In-Reply-To: <20210731063938.1391602-1-yuzhao@google.com>
Message-Id: <20210731063938.1391602-4-yuzhao@google.com>
Mime-Version: 1.0
References: <20210731063938.1391602-1-yuzhao@google.com>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [PATCH 3/3] mm: don't remap clean subpages when splitting isolated thp
From:   Yu Zhao <yuzhao@google.com>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        linux-kernel@vger.kernel.org, Yu Zhao <yuzhao@google.com>,
        Shuang Zhai <zhais@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here being clean means containing only zeros and inaccessible to
userspace. When splitting an isolated thp under reclaim or migration,
there is no need to remap its clean subpages because they can be
faulted in anew. Not remapping them avoids writeback or copying during
reclaim or migration. This is particularly helpful when the internal
fragmentation of a thp is high, i.e., it has many untouched subpages.

Signed-off-by: Yu Zhao <yuzhao@google.com>
Tested-by: Shuang Zhai <zhais@google.com>
---
 include/linux/rmap.h          |  2 +-
 include/linux/vm_event_item.h |  1 +
 mm/huge_memory.c              | 10 +++---
 mm/migrate.c                  | 65 ++++++++++++++++++++++++++++++-----
 mm/vmstat.c                   |  1 +
 5 files changed, 64 insertions(+), 15 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index c976cc6de257..4c2789d3fafb 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -243,7 +243,7 @@ int page_mkclean(struct page *);
  */
 void page_mlock(struct page *page);
 
-void remove_migration_ptes(struct page *old, struct page *new, bool locked);
+void remove_migration_ptes(struct page *old, struct page *new, bool locked, bool unmap_clean);
 
 /*
  * Called by memory-failure.c to kill processes.
diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index 829eeac84094..a08fa70d8026 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -100,6 +100,7 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		THP_SPLIT_PUD,
 #endif
 		THP_SPLIT_FREE,
+		THP_SPLIT_UNMAP,
 		THP_ZERO_PAGE_ALLOC,
 		THP_ZERO_PAGE_ALLOC_FAILED,
 		THP_SWPOUT,
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 5120478bca41..1653b84dc800 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2327,7 +2327,7 @@ static void unmap_page(struct page *page)
 	VM_WARN_ON_ONCE_PAGE(page_mapped(page), page);
 }
 
-static void remap_page(struct page *page, unsigned int nr)
+static void remap_page(struct page *page, unsigned int nr, bool unmap_clean)
 {
 	int i;
 
@@ -2335,10 +2335,10 @@ static void remap_page(struct page *page, unsigned int nr)
 	if (!PageAnon(page))
 		return;
 	if (PageTransHuge(page)) {
-		remove_migration_ptes(page, page, true);
+		remove_migration_ptes(page, page, true, false);
 	} else {
 		for (i = 0; i < nr; i++)
-			remove_migration_ptes(page + i, page + i, true);
+			remove_migration_ptes(page + i, page + i, true, unmap_clean);
 	}
 }
 
@@ -2494,7 +2494,7 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 	}
 	local_irq_enable();
 
-	remap_page(head, nr);
+	remap_page(head, nr, !!list);
 
 	if (PageSwapCache(head)) {
 		swp_entry_t entry = { .val = page_private(head) };
@@ -2769,7 +2769,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 		if (mapping)
 			xa_unlock(&mapping->i_pages);
 		local_irq_enable();
-		remap_page(head, thp_nr_pages(head));
+		remap_page(head, thp_nr_pages(head), false);
 		ret = -EBUSY;
 	}
 
diff --git a/mm/migrate.c b/mm/migrate.c
index 7e240437e7d9..46c2a54c2ac1 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -168,14 +168,53 @@ void putback_movable_pages(struct list_head *l)
 	}
 }
 
+static bool try_to_unmap_clean(struct page_vma_mapped_walk *pvmw, struct page *page)
+{
+	void *addr;
+	bool dirty;
+
+	VM_BUG_ON_PAGE(PageLRU(page), page);
+	VM_BUG_ON_PAGE(PageCompound(page), page);
+	VM_BUG_ON_PAGE(!PageAnon(page), page);
+	VM_BUG_ON_PAGE(!PageLocked(page), page);
+	VM_BUG_ON_PAGE(pte_present(*pvmw->pte), page);
+
+	if (PageMlocked(page) || (pvmw->vma->vm_flags & VM_LOCKED))
+		return false;
+
+	/*
+	 * The pmd entry mapping the old thp was flushed and the pte mapping
+	 * this subpage has been non present. Therefore, this subpage is
+	 * inaccessible. We don't need to remap it if it contains only zeros.
+	 */
+	addr = kmap_atomic(page);
+	dirty = !!memchr_inv(addr, 0, PAGE_SIZE);
+	kunmap_atomic(addr);
+
+	if (dirty)
+		return false;
+
+	pte_clear_not_present_full(pvmw->vma->vm_mm, pvmw->address, pvmw->pte, false);
+	dec_mm_counter(pvmw->vma->vm_mm, mm_counter(page));
+	count_vm_event(THP_SPLIT_UNMAP);
+
+	return true;
+}
+
+struct rmap_walk_arg {
+	struct page *page;
+	bool unmap_clean;
+};
+
 /*
  * Restore a potential migration pte to a working pte entry
  */
 static bool remove_migration_pte(struct page *page, struct vm_area_struct *vma,
-				 unsigned long addr, void *old)
+				 unsigned long addr, void *arg)
 {
+	struct rmap_walk_arg *rmap_walk_arg = arg;
 	struct page_vma_mapped_walk pvmw = {
-		.page = old,
+		.page = rmap_walk_arg->page,
 		.vma = vma,
 		.address = addr,
 		.flags = PVMW_SYNC | PVMW_MIGRATION,
@@ -200,6 +239,8 @@ static bool remove_migration_pte(struct page *page, struct vm_area_struct *vma,
 			continue;
 		}
 #endif
+		if (rmap_walk_arg->unmap_clean && try_to_unmap_clean(&pvmw, new))
+			continue;
 
 		get_page(new);
 		pte = pte_mkold(mk_pte(new, READ_ONCE(vma->vm_page_prot)));
@@ -267,13 +308,19 @@ static bool remove_migration_pte(struct page *page, struct vm_area_struct *vma,
  * Get rid of all migration entries and replace them by
  * references to the indicated page.
  */
-void remove_migration_ptes(struct page *old, struct page *new, bool locked)
+void remove_migration_ptes(struct page *old, struct page *new, bool locked, bool unmap_clean)
 {
+	struct rmap_walk_arg rmap_walk_arg = {
+		.page = old,
+		.unmap_clean = unmap_clean,
+	};
 	struct rmap_walk_control rwc = {
 		.rmap_one = remove_migration_pte,
-		.arg = old,
+		.arg = &rmap_walk_arg,
 	};
 
+	VM_BUG_ON_PAGE(unmap_clean && old != new, old);
+
 	if (locked)
 		rmap_walk_locked(new, &rwc);
 	else
@@ -827,7 +874,7 @@ static int writeout(struct address_space *mapping, struct page *page)
 	 * At this point we know that the migration attempt cannot
 	 * be successful.
 	 */
-	remove_migration_ptes(page, page, false);
+	remove_migration_ptes(page, page, false, false);
 
 	rc = mapping->a_ops->writepage(page, &wbc);
 
@@ -1070,7 +1117,7 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
 
 	if (page_was_mapped)
 		remove_migration_ptes(page,
-			rc == MIGRATEPAGE_SUCCESS ? newpage : page, false);
+			rc == MIGRATEPAGE_SUCCESS ? newpage : page, false, false);
 
 out_unlock_both:
 	unlock_page(newpage);
@@ -1292,7 +1339,7 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
 
 	if (page_was_mapped)
 		remove_migration_ptes(hpage,
-			rc == MIGRATEPAGE_SUCCESS ? new_hpage : hpage, false);
+			rc == MIGRATEPAGE_SUCCESS ? new_hpage : hpage, false, false);
 
 unlock_put_anon:
 	unlock_page(new_hpage);
@@ -2585,7 +2632,7 @@ static void migrate_vma_unmap(struct migrate_vma *migrate)
 		if (!page || (migrate->src[i] & MIGRATE_PFN_MIGRATE))
 			continue;
 
-		remove_migration_ptes(page, page, false);
+		remove_migration_ptes(page, page, false, false);
 
 		migrate->src[i] = 0;
 		unlock_page(page);
@@ -2963,7 +3010,7 @@ void migrate_vma_finalize(struct migrate_vma *migrate)
 			newpage = page;
 		}
 
-		remove_migration_ptes(page, newpage, false);
+		remove_migration_ptes(page, newpage, false, false);
 		unlock_page(page);
 
 		if (is_zone_device_page(page))
diff --git a/mm/vmstat.c b/mm/vmstat.c
index f486e5d98d96..a83cbb6a4d70 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1301,6 +1301,7 @@ const char * const vmstat_text[] = {
 	"thp_split_pud",
 #endif
 	"thp_split_free",
+	"thp_split_unmap",
 	"thp_zero_page_alloc",
 	"thp_zero_page_alloc_failed",
 	"thp_swpout",
-- 
2.32.0.554.ge1b32706d8-goog

