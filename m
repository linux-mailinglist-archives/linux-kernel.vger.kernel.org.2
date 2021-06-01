Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3031F397B93
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 23:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234876AbhFAVLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 17:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234513AbhFAVLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 17:11:18 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E18FC061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 14:09:35 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id u13so202510qvt.7
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 14:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=UGAE1tU3sFBmQCEFypWhJDt5nNuef83Vqmn7+7MSi28=;
        b=LbcBieFP9gBphC6OVjni5VvMVZJhNkObwpdoAEfTC7Pns2bV6zPFiHT1UlzCFLGv8x
         D+WAoY6ybKSbdtloPdU94dqEPH3le0eENVojrpLLYu/IpkpcaoiEh+Wh7RwN+gjNoG+q
         yFZGKoSrncKM+ErzZAiyB6gyX4pNmBWkhPm0f/lNEWPEpwKcQAfbnh/9AjT3EzpvEqLl
         46hlFULs3XiMQ3gjAUH0mzzPksxZEqxFKahbUnhtnH2cAnnvpMGvnZ6JMTUOvuI7fhlh
         WskOmxJ6slJJs7Z8+ul4GEwHFf62Xsw9Na7QLmDQGF10T1C0TqGx5Ffr9HP9pMnq9u8g
         2+Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=UGAE1tU3sFBmQCEFypWhJDt5nNuef83Vqmn7+7MSi28=;
        b=bFaC5rMm04DSO6I6NHdndYw5tieL4WSDtmO6OgImtz1igKxWknclQChJphHswjrWEX
         wVAND8jlU5466UbDzVu0NP6fUOcHMEnJgs+ovVOlJN0cwKs7RyIpLK4JaPg0VzI+S7Bv
         J+aVckp5DHRfLs+v1/+4GGS8zVsuuIWB7san+xR76J3XgtR95zeiaWmei1VXlzCqqBlL
         +Vlqk+67PLlhO4Z3XKCrD6e0VcdopNezmLsyHAPeZ7MWdp/SJO7TFKtwTKxejaebAPz/
         1pw/Z8oMYB/C/JqlJRbGguhlU1J0NFrCNh9gX0/mp/cjtF+kPeD3R4RaDjTr23UHpm9A
         /dJg==
X-Gm-Message-State: AOAM5306kGrfLJNS4+1g/KAnLqVDN5UNG2gxMnS9vyRnitntAitqWv2B
        qIbssGX+oRF6dX0jelXMqOhVPA==
X-Google-Smtp-Source: ABdhPJwYliUjTR1hcERALaFi+FEUt3Fn9oPnV76WPE/jV9HFuBAjQZMT93Nf4aqJZN1HQXf/TL77iA==
X-Received: by 2002:ad4:5227:: with SMTP id r7mr24726914qvq.41.1622581774165;
        Tue, 01 Jun 2021 14:09:34 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id h12sm11811481qkj.52.2021.06.01.14.09.32
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 01 Jun 2021 14:09:33 -0700 (PDT)
Date:   Tue, 1 Jun 2021 14:09:31 -0700 (PDT)
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
Subject: [PATCH 3/7] mm/thp: fix vma_address() if virtual address below file
 offset
In-Reply-To: <alpine.LSU.2.11.2106011353270.2148@eggly.anvils>
Message-ID: <alpine.LSU.2.11.2106011408020.2148@eggly.anvils>
References: <alpine.LSU.2.11.2106011353270.2148@eggly.anvils>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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

Sidenote: vma_address() and vma_address_end() now use compound_order() on
a head page, instead of thp_size(): to make the right calculation on a
hugetlbfs page, whether or not THPs are configured.  try_to_unmap() is
used on hugetlbfs pages, but perhaps the wrong calculation never mattered.

Fixes: a8fa41ad2f6f ("mm, rmap: check all VMAs that PTE-mapped THP can be part of")
Signed-off-by: Hugh Dickins <hughd@google.com>
Cc: <stable@vger.kernel.org>
---
 mm/internal.h        | 56 +++++++++++++++++++++++++++++++++-----------
 mm/page_vma_mapped.c | 16 +++++--------
 mm/rmap.c            | 16 ++++++-------
 3 files changed, 56 insertions(+), 32 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 2f1182948aa6..00d2dfa534cf 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -384,27 +384,55 @@ static inline void mlock_migrate_page(struct page *newpage, struct page *page)
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
+		   pgoff + (1UL << compound_order(page)) > vma->vm_pgoff) {
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
+	pgoff = page_to_pgoff(page);
+	if (PageHead(page))
+		pgoff += 1UL << compound_order(page);
+	else
+		pgoff++;
+	address = vma->vm_start + ((pgoff - vma->vm_pgoff) << PAGE_SHIFT);
+	/* Check for address beyond vma (or wrapped through 0?) */
+	if (address < vma->vm_start || address > vma->vm_end)
+		address = vma->vm_end;
+	return address;
 }
 
 static inline struct file *maybe_unlock_mmap_for_io(struct vm_fault *vmf,
diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index b45d22738b45..92f0ecd50524 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -225,18 +225,18 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
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
@@ -274,14 +274,10 @@ int page_mapped_in_vma(struct page *page, struct vm_area_struct *vma)
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
2.32.0.rc0.204.g9fa02ecfa5-goog

