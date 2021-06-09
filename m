Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 181133A0B14
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 06:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbhFIEWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 00:22:22 -0400
Received: from mail-qk1-f174.google.com ([209.85.222.174]:37674 "EHLO
        mail-qk1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbhFIEWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 00:22:21 -0400
Received: by mail-qk1-f174.google.com with SMTP id i67so22495467qkc.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 21:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=dknf+euzTRr7r2/S3iUZMemdIlHi8vRKB9Z0yM9o6l4=;
        b=dmE24KgHI1vI7hqZhadp/Dl4mNPzK8uiw5dc1UT6rxcJ7JbNXkm4YqQe82Q7XBmUUg
         3ctA4xIrVPDDVKacv9E2bbfbdoD2EFrZqGj6J4l8a55RWuJO3yNVXxPJXc1+1PbUhIio
         rBo/4hYlgglNK09Tq7s+Mw0ppXNXhu56PAbSP9kLfdAm7sZMt3BLQng3tdITCwaDqCHn
         SjJdTr5D781wdhdgjKZUxMQdHMy6kmgxSioKJ06y0lg4X/7R8eSvx9KcW3KqH/eEth6x
         mNHzB3cQ+xVPUyAEjAyCtpp/l/I/sN1s5VrWV50Z9Xfa20dh7hCpsvZi3FCqgfBoVKK0
         sVug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=dknf+euzTRr7r2/S3iUZMemdIlHi8vRKB9Z0yM9o6l4=;
        b=uEyNCotpxAkeKHS4Qg85EwfGOgyA5nR3jDC2NFVHAsWsYvkFNnqKu2CTu+Wf7F1mCG
         8krby2TDDr2HUHvYUy5kl9aJ4RDk/yNX1Jmb9ul0iQAsbNwp0NAKfZWV9cob2Ther/CM
         39zEFUwk21R8s9F8yyLwUCCpozaUfNsB0+xC6OMlCXCXwAYdz44PmLVjp77+YFhSKDHs
         PFU4ebhvxgUX+c4siXmdUZg3Rm07TE+7zuoWPCJ2FkscNwlSkQZVoCtptta9ZoHO3w0E
         OF7az6YMzp9R68qDBEpP9vpjlmK51mMFr20PZx39FgMSX0NhZEJpX/K2oHlzRR9VQKCf
         Sf3w==
X-Gm-Message-State: AOAM531VLSZe+CSDSwS6I4aBjg7dsvO4rfYxQUX4qXZz4WgnrYaa9CDZ
        pckPn2mGh5RC2Kosf5+juYfNHQ==
X-Google-Smtp-Source: ABdhPJxHnL+j9u0hHoWnMWzYVWec9zXzU9aWEUinZ4dRlvqjZbcerPeNMUrtkbB0koAeSOQKJq4XtA==
X-Received: by 2002:a37:94e:: with SMTP id 75mr24733985qkj.127.1623212366868;
        Tue, 08 Jun 2021 21:19:26 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id m68sm6182941qkb.75.2021.06.08.21.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 21:19:26 -0700 (PDT)
Date:   Tue, 8 Jun 2021 21:19:24 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
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
        Shakeel Butt <shakeelb@google.com>,
        Oscar Salvador <osalvador@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/10] mm/thp: unmap_mapping_page() to fix THP
 truncate_cleanup_page()
In-Reply-To: <af88612-1473-2eaa-903-8d1a448b26@google.com>
Message-ID: <f1f68716-5a53-20ff-7ac0-d82fc3978d4e@google.com>
References: <af88612-1473-2eaa-903-8d1a448b26@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
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
index f3ffab9b9e39..ee1163df3a53 100644
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
@@ -3236,6 +3246,36 @@ static inline void unmap_mapping_range_tree(struct rb_root_cached *root,
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
2.26.2

