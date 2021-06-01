Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 037F1397B9D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 23:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234837AbhFAVRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 17:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234707AbhFAVRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 17:17:21 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF7EC061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 14:15:39 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id c31-20020a056830349fb02903a5bfa6138bso607206otu.7
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 14:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=KS1YPkHQ/TuwZUBOUUc09sdHAPmJA1pFeqFuIXJ9Fug=;
        b=SPUSIU7ZhWh/wxRFrVWYLpgBpW0WKa1zhqylauHhOgLEbwtZ1/R34mGKihuY5ObQy0
         ntMCde9IMcatgI74yPc/3DX+zrrtkm3EkPUidLn7Au5a1JqUh+h6dal/kOh5yeBkrH3F
         fkPRRnxngbJ5nxn6lYfTm8DjiZy9RHv35yIfe11DK+Y/PkNcK7kVSYl9yMadS4pMq4nJ
         uJpLTT5NtkVc3gLwO8qrlnM2CssKl8zWUogkNb5SDiOotGeAt63wJVqhY7RmD3OEcPzA
         mULS1pE20kS2USUm0iR2/8+8PhYuDuuQWYl5laCYxzAAElcOIoxjH4F/PyoKFUvLANS1
         Rq0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=KS1YPkHQ/TuwZUBOUUc09sdHAPmJA1pFeqFuIXJ9Fug=;
        b=hBmQxRiWPJxCvz3zMOVv4w2F/JI4CeizV88me+EHg+9t0/LO99/gPS6ULYA5G9D0W/
         CPaozREVxlq0ZtPzmsCj2Oozro02mxQCBWXlJyl3+ETu6G831IX47R3dsfYWY2LoFO4M
         O35Vlq7DMlNsnrwnreIMpkC1mMfIeP2LWHYgkaLD/XMeBzxG05AKeyH2li6hQZ+Vhtbd
         sNK3XiwGNiDAmLXrDEIR+ubhtENiDp06bLB0kVCg3G1Qaa43oKKwHZofduy1qvOE2lOS
         Ibje4rDYKrwv0ldfSXQ6688z8OJiZ+bPENy1bI1HDp+If5uMFKy6K+hduIhZ6NKA9uYW
         yLvw==
X-Gm-Message-State: AOAM5300vzR6r+/FcEPlV0k3SsxJ3IroWMND53JLnwaBgOBxOOe0N1Xt
        pjlJLdgNk1KShJtRqXxEeQ4CfQ==
X-Google-Smtp-Source: ABdhPJzeTZoTjflH1rTyUR5kL5ZS8yXRcuGGOOFlMqZOgkdaR6M9Q6yc+0Vrjq8MXS/Nv/yqPVtw/w==
X-Received: by 2002:a05:6830:1e15:: with SMTP id s21mr22610019otr.144.1622582138213;
        Tue, 01 Jun 2021 14:15:38 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id m1sm4056655otq.12.2021.06.01.14.15.36
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 01 Jun 2021 14:15:37 -0700 (PDT)
Date:   Tue, 1 Jun 2021 14:15:35 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Matthew Wilcox <willy@infradead.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>, Jue Wang <juew@google.com>,
        Peter Xu <peterx@redhat.com>, Jan Kara <jack@suse.cz>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] mm/thp: unmap_mapping_page() to fix THP
 truncate_cleanup_page()
In-Reply-To: <alpine.LSU.2.11.2106011353270.2148@eggly.anvils>
Message-ID: <alpine.LSU.2.11.2106011413280.2148@eggly.anvils>
References: <alpine.LSU.2.11.2106011353270.2148@eggly.anvils>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a race between THP unmapping and truncation, when truncate sees
pmd_none() and skips the entry, after munmap's zap_huge_pmd() cleared it,
but before its page_remove_rmap() gets to decrement compound_mapcount:
generating false "BUG: Bad page cache" reports that the page is still
mapped when deleted.  This commit fixes that, but not in the way I hoped.

The first attempt used try_to_unmap(page, TTU_SYNC|TTU_IGNORE_MLOCK)
instead of unmap_mapping_range() in truncate_cleanup_page(): it has often
been an annoyance that we usually call unmap_mapping_range() with no pages
locked, but there apply it to a single locked page.  try_to_unmap() looks
more suitable for a single locked page.

However, try_to_unmap_one() contains a VM_BUG_ON_PAGE(!pvmw.pte,page):
it is used to insert THP migration entries, but not used to unmap THPs.
Copy zap_huge_pmd() and add THP handling now?  Perhaps, but their TLB
needs are different, I'm too ignorant of the DAX cases, and couldn't
decide how far to go for anon+swap.  Set that aside.

The second attempt took a different tack: make no change in truncate.c,
but modify zap_huge_pmd() to insert an invalidated huge pmd instead of
clearing it initially, then pmd_clear() between page_remove_rmap() and
unlocking at the end.  Nice.  But powerpc blows that approach out of the
water, with its serialize_against_pte_lookup(), and interesting pgtable
usage.  It would need serious help to get working on powerpc (with a
minor optimization issue on s390 too).  Set that aside.

Just add an "if (page_mapped(page)) synchronize_rcu();" or other such
delay, after unmapping in truncate_cleanup_page()?  Perhaps, but though
that's likely to reduce or eliminate the number of incidents, it would
give less assurance of whether we had identified the problem correctly.

This successful iteration introduces "unmap_mapping_page(page)" instead
of try_to_unmap(), and goes the usual unmap_mapping_range_tree() route,
with an addition to details.  Then zap_pmd_range() watches for this case,
and does spin_unlock(pmd_lock) if so - just like page_vma_mapped_walk()
now does in the PVMW_SYNC case.  Not pretty, but safe.

Note that unmap_mapping_page() is doing a VM_BUG_ON(!PageLocked) to
assert its interface; but currently that's only used to make sure that
page->mapping is stable, and zap_pmd_range() doesn't care if the page is
locked or not.  Along these lines, in invalidate_inode_pages2_range()
move the initial unmap_mapping_range() out from under page lock, before
then calling unmap_mapping_page() under page lock if still mapped.

Fixes: fc127da085c2 ("truncate: handle file thp")
Signed-off-by: Hugh Dickins <hughd@google.com>
Cc: <stable@vger.kernel.org>
---
 include/linux/mm.h |  3 +++
 mm/memory.c        | 40 ++++++++++++++++++++++++++++++++++++++++
 mm/truncate.c      | 43 +++++++++++++++++++------------------------
 3 files changed, 62 insertions(+), 24 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index c274f75efcf9..8ae31622deef 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1719,6 +1719,7 @@ struct zap_details {
 	struct address_space *check_mapping;	/* Check page->mapping if set */
 	pgoff_t	first_index;			/* Lowest page->index to unmap */
 	pgoff_t last_index;			/* Highest page->index to unmap */
+	struct page *single_page;		/* Locked page to be unmapped */
 };
 
 struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
@@ -1766,6 +1767,7 @@ extern vm_fault_t handle_mm_fault(struct vm_area_struct *vma,
 extern int fixup_user_fault(struct mm_struct *mm,
 			    unsigned long address, unsigned int fault_flags,
 			    bool *unlocked);
+void unmap_mapping_page(struct page *page);
 void unmap_mapping_pages(struct address_space *mapping,
 		pgoff_t start, pgoff_t nr, bool even_cows);
 void unmap_mapping_range(struct address_space *mapping,
@@ -1786,6 +1788,7 @@ static inline int fixup_user_fault(struct mm_struct *mm, unsigned long address,
 	BUG();
 	return -EFAULT;
 }
+static inline void unmap_mapping_page(struct page *page) { }
 static inline void unmap_mapping_pages(struct address_space *mapping,
 		pgoff_t start, pgoff_t nr, bool even_cows) { }
 static inline void unmap_mapping_range(struct address_space *mapping,
diff --git a/mm/memory.c b/mm/memory.c
index 730daa00952b..26d7f8e265a9 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1361,7 +1361,17 @@ static inline unsigned long zap_pmd_range(struct mmu_gather *tlb,
 			else if (zap_huge_pmd(tlb, vma, pmd, addr))
 				goto next;
 			/* fall through */
+		} else if (details && details->single_page &&
+			   PageTransCompound(details->single_page) &&
+			   next - addr == HPAGE_PMD_SIZE && pmd_none(*pmd)) {
+			/*
+			 * Take and drop THP pmd lock so that we cannot return
+			 * prematurely, while zap_huge_pmd() has cleared *pmd,
+			 * but not yet decremented compound_mapcount().
+			 */
+			spin_unlock(pmd_lock(tlb->mm, pmd));
 		}
+
 		/*
 		 * Here there can be other concurrent MADV_DONTNEED or
 		 * trans huge page faults running, and if the pmd is
@@ -3235,6 +3245,36 @@ static inline void unmap_mapping_range_tree(struct rb_root_cached *root,
 	}
 }
 
+/**
+ * unmap_mapping_page() - Unmap single page from processes.
+ * @page: The locked page to be unmapped.
+ *
+ * Unmap this page from any userspace process which still has it mmaped.
+ * Typically, for efficiency, the range of nearby pages has already been
+ * unmapped by unmap_mapping_pages() or unmap_mapping_range().  But once
+ * truncation or invalidation holds the lock on a page, it may find that
+ * the page has been remapped again: and then uses unmap_mapping_page()
+ * to unmap it finally.
+ */
+void unmap_mapping_page(struct page *page)
+{
+	struct address_space *mapping = page->mapping;
+	struct zap_details details = { };
+
+	VM_BUG_ON(!PageLocked(page));
+	VM_BUG_ON(PageTail(page));
+
+	details.check_mapping = mapping;
+	details.first_index = page->index;
+	details.last_index = page->index + thp_nr_pages(page) - 1;
+	details.single_page = page;
+
+	i_mmap_lock_write(mapping);
+	if (unlikely(!RB_EMPTY_ROOT(&mapping->i_mmap.rb_root)))
+		unmap_mapping_range_tree(&mapping->i_mmap, &details);
+	i_mmap_unlock_write(mapping);
+}
+
 /**
  * unmap_mapping_pages() - Unmap pages from processes.
  * @mapping: The address space containing pages to be unmapped.
diff --git a/mm/truncate.c b/mm/truncate.c
index 95af244b112a..234ddd879caa 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -167,13 +167,10 @@ void do_invalidatepage(struct page *page, unsigned int offset,
  * its lock, b) when a concurrent invalidate_mapping_pages got there first and
  * c) when tmpfs swizzles a page between a tmpfs inode and swapper_space.
  */
-static void
-truncate_cleanup_page(struct address_space *mapping, struct page *page)
+static void truncate_cleanup_page(struct page *page)
 {
-	if (page_mapped(page)) {
-		unsigned int nr = thp_nr_pages(page);
-		unmap_mapping_pages(mapping, page->index, nr, false);
-	}
+	if (page_mapped(page))
+		unmap_mapping_page(page);
 
 	if (page_has_private(page))
 		do_invalidatepage(page, 0, thp_size(page));
@@ -218,7 +215,7 @@ int truncate_inode_page(struct address_space *mapping, struct page *page)
 	if (page->mapping != mapping)
 		return -EIO;
 
-	truncate_cleanup_page(mapping, page);
+	truncate_cleanup_page(page);
 	delete_from_page_cache(page);
 	return 0;
 }
@@ -325,7 +322,7 @@ void truncate_inode_pages_range(struct address_space *mapping,
 		index = indices[pagevec_count(&pvec) - 1] + 1;
 		truncate_exceptional_pvec_entries(mapping, &pvec, indices);
 		for (i = 0; i < pagevec_count(&pvec); i++)
-			truncate_cleanup_page(mapping, pvec.pages[i]);
+			truncate_cleanup_page(pvec.pages[i]);
 		delete_from_page_cache_batch(mapping, &pvec);
 		for (i = 0; i < pagevec_count(&pvec); i++)
 			unlock_page(pvec.pages[i]);
@@ -639,6 +636,16 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
 				continue;
 			}
 
+			if (!did_range_unmap && page_mapped(page)) {
+				/*
+				 * If page is mapped, before taking its lock,
+				 * zap the rest of the file in one hit.
+				 */
+				unmap_mapping_pages(mapping, index,
+						(1 + end - index), false);
+				did_range_unmap = 1;
+			}
+
 			lock_page(page);
 			WARN_ON(page_to_index(page) != index);
 			if (page->mapping != mapping) {
@@ -646,23 +653,11 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
 				continue;
 			}
 			wait_on_page_writeback(page);
-			if (page_mapped(page)) {
-				if (!did_range_unmap) {
-					/*
-					 * Zap the rest of the file in one hit.
-					 */
-					unmap_mapping_pages(mapping, index,
-						(1 + end - index), false);
-					did_range_unmap = 1;
-				} else {
-					/*
-					 * Just zap this page
-					 */
-					unmap_mapping_pages(mapping, index,
-								1, false);
-				}
-			}
+
+			if (page_mapped(page))
+				unmap_mapping_page(page);
 			BUG_ON(page_mapped(page));
+
 			ret2 = do_launder_page(mapping, page);
 			if (ret2 == 0) {
 				if (!invalidate_complete_page2(mapping, page))
-- 
2.32.0.rc0.204.g9fa02ecfa5-goog

