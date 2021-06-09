Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAC0B3A0B0C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 06:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbhFIEQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 00:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbhFIEQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 00:16:35 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8FCC061574
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 21:14:28 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id p21so5288867qtw.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 21:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=1Gkk68Yxejem3jDpMBjjD+FSUwRvlNAzk5ZsMSk3bl4=;
        b=SUk2w4ANTGja8rZm6+4s+f9cLvedGQIJ1TDwCVl7K54PNMaQLvEsBrnRh74k/N6Yao
         3ySxMaxnwSpxVAcv9QpNIpaxEDji6dxCw1Wz0c/RXWgJNPVRAXzAvWBC8kU8W71fUZVH
         SO6ECspRznhqvOCfwFfyTZHCN2bj+zOd6soYsoOM4MN/K03QqSvbR6cQC1nQbFRnZSE1
         o/Twg6VOJJp0u/ZEn1rEcDF3TdgkjJMgw7LHBIoLO4UO3xI8cPx8i7qz7Ei305NbJhYl
         JdgFEntRrJemB7mhU03dCHtTcP75XZiyWYX+3KGr8TmLiZpkHEn97YTRxXMvwm7HP/eZ
         vrUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=1Gkk68Yxejem3jDpMBjjD+FSUwRvlNAzk5ZsMSk3bl4=;
        b=AH/xS4UB7sYntQS+sMIHuz9/C3gRAEyf4XglEwv3dVg4kQVSOy5iMHiJFC9BXv+kzh
         vhqw4TFaGKztQusSLD+StvzaOI8rW2nmOBBTClHD+H9aj/FFZ9vrwGi0UkfrFNyKoyoI
         NnaRj93ck1MCXtNtHI1A0C5O/L1I4yzUP8JZXNAjeWMoEZYJlCPXO/4c5wXGNV1kmTqQ
         GDHmjVs81TGeeHaeF2gXBHH/EzPSfL9bMAQxXfnHLfnAgRixNoaEi1MAE1kGbWX27uqz
         Xpv03y3W4c1CLNs0FEzsypJXwHscgla54Z/hRGNp2j1CR3Gc7Rih57g7YyUzutCca89s
         5Y6w==
X-Gm-Message-State: AOAM532/j5myiXCHFtgU2AQQhOGKl4vktmqnbEv1SeeVd1HtoPACehyf
        x93HZHwSeZka7QTCbeZJM/6Z5g==
X-Google-Smtp-Source: ABdhPJxGgqmVmMkDl98m/O1+owdzkmD+beSmerlJdgmElyg9g3SjKMF4520vQEWZAHWRzwB08bp2KA==
X-Received: by 2002:ac8:70d2:: with SMTP id g18mr5926577qtp.344.1623212067659;
        Tue, 08 Jun 2021 21:14:27 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id h12sm3355847qtn.44.2021.06.08.21.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 21:14:27 -0700 (PDT)
Date:   Tue, 8 Jun 2021 21:14:24 -0700 (PDT)
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
Subject: [PATCH v2 04/10] mm/thp: fix vma_address() if virtual address below
 file offset
In-Reply-To: <af88612-1473-2eaa-903-8d1a448b26@google.com>
Message-ID: <caf1c1a3-7cfb-7f8f-1beb-ba816e932825@google.com>
References: <af88612-1473-2eaa-903-8d1a448b26@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Running certain tests with a DEBUG_VM kernel would crash within hours,
on the total_mapcount BUG() in split_huge_page_to_list(), while trying
to free up some memory by punching a hole in a shmem huge page: split's
try_to_unmap() was unable to find all the mappings of the page (which,
on a !DEBUG_VM kernel, would then keep the huge page pinned in memory).

When that BUG() was changed to a WARN(), it would later crash on the
VM_BUG_ON_VMA(end < vma->vm_start || start >= vma->vm_end, vma) in
mm/internal.h:vma_address(), used by rmap_walk_file() for try_to_unmap().

vma_address() is usually correct, but there's a wraparound case when the
vm_start address is unusually low, but vm_pgoff not so low: vma_address()
chooses max(start, vma->vm_start), but that decides on the wrong address,
because start has become almost ULONG_MAX.

Rewrite vma_address() to be more careful about vm_pgoff; move the
VM_BUG_ON_VMA() out of it, returning -EFAULT for errors, so that it can
be safely used from page_mapped_in_vma() and page_address_in_vma() too.

Add vma_address_end() to apply similar care to end address calculation,
in page_vma_mapped_walk() and page_mkclean_one() and try_to_unmap_one();
though it raises a question of whether callers would do better to supply
pvmw->end to page_vma_mapped_walk() - I chose not, for a smaller patch.

An irritation is that their apparent generality breaks down on KSM pages,
which cannot be located by the page->index that page_to_pgoff() uses: as
4b0ece6fa016 ("mm: migrate: fix remove_migration_pte() for ksm pages")
once discovered.  I dithered over the best thing to do about that, and
have ended up with a VM_BUG_ON_PAGE(PageKsm) in both vma_address() and
vma_address_end(); though the only place in danger of using it on them
was try_to_unmap_one().

Sidenote: vma_address() and vma_address_end() now use compound_nr() on
a head page, instead of thp_size(): to make the right calculation on a
hugetlbfs page, whether or not THPs are configured.  try_to_unmap() is
used on hugetlbfs pages, but perhaps the wrong calculation never mattered.

Fixes: a8fa41ad2f6f ("mm, rmap: check all VMAs that PTE-mapped THP can be part of")
Signed-off-by: Hugh Dickins <hughd@google.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: <stable@vger.kernel.org>
---
v2 series: adjust vma_address() to avoid 32-bit wrap, per Matthew
v2: use compound_nr() as Matthew suggested

 mm/internal.h        | 53 ++++++++++++++++++++++++++++++++++------------
 mm/page_vma_mapped.c | 16 ++++++--------
 mm/rmap.c            | 16 +++++++-------
 3 files changed, 53 insertions(+), 32 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 2f1182948aa6..e8fdb531f887 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -384,27 +384,52 @@ static inline void mlock_migrate_page(struct page *newpage, struct page *page)
 extern pmd_t maybe_pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma);
 
 /*
- * At what user virtual address is page expected in @vma?
+ * At what user virtual address is page expected in vma?
+ * Returns -EFAULT if all of the page is outside the range of vma.
+ * If page is a compound head, the entire compound page is considered.
  */
 static inline unsigned long
-__vma_address(struct page *page, struct vm_area_struct *vma)
+vma_address(struct page *page, struct vm_area_struct *vma)
 {
-	pgoff_t pgoff = page_to_pgoff(page);
-	return vma->vm_start + ((pgoff - vma->vm_pgoff) << PAGE_SHIFT);
+	pgoff_t pgoff;
+	unsigned long address;
+
+	VM_BUG_ON_PAGE(PageKsm(page), page);	/* KSM page->index unusable */
+	pgoff = page_to_pgoff(page);
+	if (pgoff >= vma->vm_pgoff) {
+		address = vma->vm_start +
+			((pgoff - vma->vm_pgoff) << PAGE_SHIFT);
+		/* Check for address beyond vma (or wrapped through 0?) */
+		if (address < vma->vm_start || address >= vma->vm_end)
+			address = -EFAULT;
+	} else if (PageHead(page) &&
+		   pgoff + compound_nr(page) - 1 >= vma->vm_pgoff) {
+		/* Test above avoids possibility of wrap to 0 on 32-bit */
+		address = vma->vm_start;
+	} else {
+		address = -EFAULT;
+	}
+	return address;
 }
 
+/*
+ * Then at what user virtual address will none of the page be found in vma?
+ * Assumes that vma_address() already returned a good starting address.
+ * If page is a compound head, the entire compound page is considered.
+ */
 static inline unsigned long
-vma_address(struct page *page, struct vm_area_struct *vma)
+vma_address_end(struct page *page, struct vm_area_struct *vma)
 {
-	unsigned long start, end;
-
-	start = __vma_address(page, vma);
-	end = start + thp_size(page) - PAGE_SIZE;
-
-	/* page should be within @vma mapping range */
-	VM_BUG_ON_VMA(end < vma->vm_start || start >= vma->vm_end, vma);
-
-	return max(start, vma->vm_start);
+	pgoff_t pgoff;
+	unsigned long address;
+
+	VM_BUG_ON_PAGE(PageKsm(page), page);	/* KSM page->index unusable */
+	pgoff = page_to_pgoff(page) + compound_nr(page);
+	address = vma->vm_start + ((pgoff - vma->vm_pgoff) << PAGE_SHIFT);
+	/* Check for address beyond vma (or wrapped through 0?) */
+	if (address < vma->vm_start || address > vma->vm_end)
+		address = vma->vm_end;
+	return address;
 }
 
 static inline struct file *maybe_unlock_mmap_for_io(struct vm_fault *vmf,
diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index 5b559967410e..e37bd43904af 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -228,18 +228,18 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 	if (!map_pte(pvmw))
 		goto next_pte;
 	while (1) {
+		unsigned long end;
+
 		if (check_pte(pvmw))
 			return true;
 next_pte:
 		/* Seek to next pte only makes sense for THP */
 		if (!PageTransHuge(pvmw->page) || PageHuge(pvmw->page))
 			return not_found(pvmw);
+		end = vma_address_end(pvmw->page, pvmw->vma);
 		do {
 			pvmw->address += PAGE_SIZE;
-			if (pvmw->address >= pvmw->vma->vm_end ||
-			    pvmw->address >=
-					__vma_address(pvmw->page, pvmw->vma) +
-					thp_size(pvmw->page))
+			if (pvmw->address >= end)
 				return not_found(pvmw);
 			/* Did we cross page table boundary? */
 			if (pvmw->address % PMD_SIZE == 0) {
@@ -277,14 +277,10 @@ int page_mapped_in_vma(struct page *page, struct vm_area_struct *vma)
 		.vma = vma,
 		.flags = PVMW_SYNC,
 	};
-	unsigned long start, end;
-
-	start = __vma_address(page, vma);
-	end = start + thp_size(page) - PAGE_SIZE;
 
-	if (unlikely(end < vma->vm_start || start >= vma->vm_end))
+	pvmw.address = vma_address(page, vma);
+	if (pvmw.address == -EFAULT)
 		return 0;
-	pvmw.address = max(start, vma->vm_start);
 	if (!page_vma_mapped_walk(&pvmw))
 		return 0;
 	page_vma_mapped_walk_done(&pvmw);
diff --git a/mm/rmap.c b/mm/rmap.c
index 07811b4ae793..144de54efc1c 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -707,7 +707,6 @@ static bool should_defer_flush(struct mm_struct *mm, enum ttu_flags flags)
  */
 unsigned long page_address_in_vma(struct page *page, struct vm_area_struct *vma)
 {
-	unsigned long address;
 	if (PageAnon(page)) {
 		struct anon_vma *page__anon_vma = page_anon_vma(page);
 		/*
@@ -722,10 +721,8 @@ unsigned long page_address_in_vma(struct page *page, struct vm_area_struct *vma)
 			return -EFAULT;
 	} else
 		return -EFAULT;
-	address = __vma_address(page, vma);
-	if (unlikely(address < vma->vm_start || address >= vma->vm_end))
-		return -EFAULT;
-	return address;
+
+	return vma_address(page, vma);
 }
 
 pmd_t *mm_find_pmd(struct mm_struct *mm, unsigned long address)
@@ -919,7 +916,7 @@ static bool page_mkclean_one(struct page *page, struct vm_area_struct *vma,
 	 */
 	mmu_notifier_range_init(&range, MMU_NOTIFY_PROTECTION_PAGE,
 				0, vma, vma->vm_mm, address,
-				min(vma->vm_end, address + page_size(page)));
+				vma_address_end(page, vma));
 	mmu_notifier_invalidate_range_start(&range);
 
 	while (page_vma_mapped_walk(&pvmw)) {
@@ -1435,9 +1432,10 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 	 * Note that the page can not be free in this function as call of
 	 * try_to_unmap() must hold a reference on the page.
 	 */
+	range.end = PageKsm(page) ?
+			address + PAGE_SIZE : vma_address_end(page, vma);
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, vma->vm_mm,
-				address,
-				min(vma->vm_end, address + page_size(page)));
+				address, range.end);
 	if (PageHuge(page)) {
 		/*
 		 * If sharing is possible, start and end will be adjusted
@@ -1889,6 +1887,7 @@ static void rmap_walk_anon(struct page *page, struct rmap_walk_control *rwc,
 		struct vm_area_struct *vma = avc->vma;
 		unsigned long address = vma_address(page, vma);
 
+		VM_BUG_ON_VMA(address == -EFAULT, vma);
 		cond_resched();
 
 		if (rwc->invalid_vma && rwc->invalid_vma(vma, rwc->arg))
@@ -1943,6 +1942,7 @@ static void rmap_walk_file(struct page *page, struct rmap_walk_control *rwc,
 			pgoff_start, pgoff_end) {
 		unsigned long address = vma_address(page, vma);
 
+		VM_BUG_ON_VMA(address == -EFAULT, vma);
 		cond_resched();
 
 		if (rwc->invalid_vma && rwc->invalid_vma(vma, rwc->arg))
-- 
2.26.2

