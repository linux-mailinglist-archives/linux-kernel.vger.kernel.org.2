Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF595397B9A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 23:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234882AbhFAVPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 17:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234707AbhFAVPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 17:15:08 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66401C061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 14:13:25 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso585366otu.10
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 14:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=u6fQ87Vl+hYyFQ4f/ypx0zbKSuAdvJqajnMzSb1SoWM=;
        b=BrfQ++mJOezRCujIJDyYnB08NoNcMR02IYLqSZ48uOKDsH41KdlFgVRf+nuSaH+qYp
         NuQowDr3QOY/G/lJzSal1kH+CZQy/xDisDEFHdio3OMWqW0pF910UcULl7PM4QN+KBeL
         UXxd9JlXTXDGPoHigLcJhPkaYISQNfgpg1WTBwf+5a57DyC2fDrfBN9Nf9hYDBhVuYvB
         sdrY1FIk0zfEGe8bfMClfqV39UCkOlZKCErT5kCyqChdiIjIw8b11e3U8AkgjS5GS6Wo
         Qv3GxCaOQkR6yGCKckwyNBi/k5PSbNDwg47sQG5CEfdUaNHeybnvYYl03zL53cEiQRBY
         w4fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=u6fQ87Vl+hYyFQ4f/ypx0zbKSuAdvJqajnMzSb1SoWM=;
        b=eY9hN/bd8DwUZLhNVEsYkWh+1d099IWMn5OiqxmKOenBZH1cjSjlV1xqwNoTmjLHkn
         QX3ZFPrqQbxfSGj8l5Lnh6FErhC2n/li/CD5Q9c41TQaOtcMR+KPVGVP6ySf5W1pbHrR
         pS6rhceDcBPVIMWMPHula3A57wNbQBuOco5HyCzkU8YhCGXZh2ot5NKeU+Ke+9tZRpNR
         sws2S35cBWdM6wTwNd7E38DTZuThYG4eUDC8y8DmwXazGUOFE0wCVea4/eDEqLdS8jyP
         Blk3Z5/UPDU+JCCGCiHAJvaHXmTniLC0VttR4n1/Ss8Kwsa7S2zHsoPcJ7yv03+Frl4C
         JMGw==
X-Gm-Message-State: AOAM533D+1gUUxrv2OFeWdn0Nh6QfC3O+Xs5TD/xaz16DZP5OV79E4eg
        lfs4b8J1L3bjiz4CSzXC2NVz5A==
X-Google-Smtp-Source: ABdhPJylvVdYfMa97TOVKNdR2ndHraP/HRdjKm0hTTAoDzVEhhzQ1XiSYlsrnO29qaxW99S+pc0WnQ==
X-Received: by 2002:a05:6830:1687:: with SMTP id k7mr24262603otr.220.1622582004410;
        Tue, 01 Jun 2021 14:13:24 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id m189sm3602732oif.45.2021.06.01.14.13.22
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 01 Jun 2021 14:13:24 -0700 (PDT)
Date:   Tue, 1 Jun 2021 14:13:21 -0700 (PDT)
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
Subject: [PATCH 5/7] mm/thp: fix page_vma_mapped_walk() if huge page mapped
 by ptes
In-Reply-To: <alpine.LSU.2.11.2106011353270.2148@eggly.anvils>
Message-ID: <alpine.LSU.2.11.2106011411290.2148@eggly.anvils>
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

Crash dumps showed two tail pages of a shmem huge page remained mapped
by pte: ptes in a non-huge-aligned vma of a gVisor process, at the end
of a long unmapped range; and no page table had yet been allocated for
the head of the huge page to be mapped into.

Although designed to handle these odd misaligned huge-page-mapped-by-pte
cases, page_vma_mapped_walk() falls short by returning false prematurely
when !pmd_present or !pud_present or !p4d_present or !pgd_present: there
are cases when a huge page may span the boundary, with ptes present in
the next.

Restructure page_vma_mapped_walk() as a loop to continue in these cases,
while keeping its layout much as before. Add a step_forward() helper to
advance pvmw->address across those boundaries: originally I tried to use
mm's standard p?d_addr_end() macros, but hit the same crash 512 times
less often: because of the way redundant levels are folded together,
but folded differently in different configurations, it was just too
difficult to use them correctly; and step_forward() is simpler anyway.

Merged various other minor fixes and cleanups into page_vma_mapped_walk()
as I worked on it: which I find much easier to enumerate here than to
prise apart into separate commits.

Handle all of the hugetlbfs PageHuge() case once at the start,
so we don't need to worry about it again further down.

Sometimes local copy of pvmw->page was used, sometimes pvmw->page:
just use pvmw->page throughout (and continue to use pvmw->address
throughout, though we could take a local copy instead).

Use pmd_read_atomic() with barrier() instead of READ_ONCE() for pmde:
some architectures (e.g. i386 with PAE) have a multi-word pmd entry,
for which READ_ONCE() is not good enough.

Re-evaluate pmde after taking lock, then use it in subsequent tests,
instead of repeatedly dereferencing pvmw->pmd pointer.

Rearrange the !pmd_present block to follow the same "return not_found,
return not_found, return true" pattern as the block above it (note:
returning not_found there is never premature, since the existence or
prior existence of a huge pmd guarantees good alignment).

Adjust page table boundary test in case address was not page-aligned.

Reset pvmw->pte to NULL after unmapping that page table.

Respect the 80-column line limit.

Fixes: ace71a19cec5 ("mm: introduce page_vma_mapped_walk()")
Signed-off-by: Hugh Dickins <hughd@google.com>
Cc: <stable@vger.kernel.org>
---
 mm/page_vma_mapped.c | 159 ++++++++++++++++++++++++++-----------------
 1 file changed, 95 insertions(+), 64 deletions(-)

diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index 92f0ecd50524..f38ea5aa4acf 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -116,6 +116,13 @@ static bool check_pte(struct page_vma_mapped_walk *pvmw)
 	return pfn_is_match(pvmw->page, pfn);
 }
 
+static void step_forward(struct page_vma_mapped_walk *pvmw, unsigned long size)
+{
+	pvmw->address = (pvmw->address + size) & ~(size - 1);
+	if (!pvmw->address)
+		pvmw->address = ULONG_MAX;
+}
+
 /**
  * page_vma_mapped_walk - check if @pvmw->page is mapped in @pvmw->vma at
  * @pvmw->address
@@ -143,7 +150,7 @@ static bool check_pte(struct page_vma_mapped_walk *pvmw)
 bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 {
 	struct mm_struct *mm = pvmw->vma->vm_mm;
-	struct page *page = pvmw->page;
+	unsigned long end;
 	pgd_t *pgd;
 	p4d_t *p4d;
 	pud_t *pud;
@@ -153,109 +160,133 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 	if (pvmw->pmd && !pvmw->pte)
 		return not_found(pvmw);
 
-	if (pvmw->pte)
-		goto next_pte;
-
 	if (unlikely(PageHuge(pvmw->page))) {
+		/* The only possible mapping was handled on last iteration */
+		if (pvmw->pte)
+			return not_found(pvmw);
+
 		/* when pud is not present, pte will be NULL */
-		pvmw->pte = huge_pte_offset(mm, pvmw->address, page_size(page));
+		pvmw->pte = huge_pte_offset(mm, pvmw->address,
+					    page_size(pvmw->page));
 		if (!pvmw->pte)
 			return false;
 
-		pvmw->ptl = huge_pte_lockptr(page_hstate(page), mm, pvmw->pte);
+		pvmw->ptl = huge_pte_lockptr(page_hstate(pvmw->page),
+					     mm, pvmw->pte);
 		spin_lock(pvmw->ptl);
 		if (!check_pte(pvmw))
 			return not_found(pvmw);
 		return true;
 	}
-restart:
-	pgd = pgd_offset(mm, pvmw->address);
-	if (!pgd_present(*pgd))
-		return false;
-	p4d = p4d_offset(pgd, pvmw->address);
-	if (!p4d_present(*p4d))
-		return false;
-	pud = pud_offset(p4d, pvmw->address);
-	if (!pud_present(*pud))
-		return false;
-	pvmw->pmd = pmd_offset(pud, pvmw->address);
+
 	/*
-	 * Make sure the pmd value isn't cached in a register by the
-	 * compiler and used as a stale value after we've observed a
-	 * subsequent update.
+	 * Seek to next pte only makes sense for THP.
+	 * But more important than that optimization, is to filter out
+	 * any PageKsm page: whose page->index misleads vma_address()
+	 * and vma_address_end() to disaster.
 	 */
-	pmde = READ_ONCE(*pvmw->pmd);
-	if (pmd_trans_huge(pmde) || is_pmd_migration_entry(pmde)) {
-		pvmw->ptl = pmd_lock(mm, pvmw->pmd);
-		if (likely(pmd_trans_huge(*pvmw->pmd))) {
-			if (pvmw->flags & PVMW_MIGRATION)
-				return not_found(pvmw);
-			if (pmd_page(*pvmw->pmd) != page)
-				return not_found(pvmw);
-			return true;
-		} else if (!pmd_present(*pvmw->pmd)) {
-			if (thp_migration_supported()) {
-				if (!(pvmw->flags & PVMW_MIGRATION))
+	end = PageTransCompound(pvmw->page) ?
+		vma_address_end(pvmw->page, pvmw->vma) :
+		pvmw->address + PAGE_SIZE;
+	if (pvmw->pte)
+		goto next_pte;
+restart:
+	do {
+		pgd = pgd_offset(mm, pvmw->address);
+		if (!pgd_present(*pgd)) {
+			step_forward(pvmw, PGDIR_SIZE);
+			continue;
+		}
+		p4d = p4d_offset(pgd, pvmw->address);
+		if (!p4d_present(*p4d)) {
+			step_forward(pvmw, P4D_SIZE);
+			continue;
+		}
+		pud = pud_offset(p4d, pvmw->address);
+		if (!pud_present(*pud)) {
+			step_forward(pvmw, PUD_SIZE);
+			continue;
+		}
+
+		pvmw->pmd = pmd_offset(pud, pvmw->address);
+		/*
+		 * Make sure the pmd value isn't cached in a register by the
+		 * compiler and used as a stale value after we've observed a
+		 * subsequent update.
+		 */
+		pmde = pmd_read_atomic(pvmw->pmd);
+		barrier();
+
+		if (pmd_trans_huge(pmde) || is_pmd_migration_entry(pmde)) {
+			pvmw->ptl = pmd_lock(mm, pvmw->pmd);
+			pmde = *pvmw->pmd;
+			if (likely(pmd_trans_huge(pmde))) {
+				if (pvmw->flags & PVMW_MIGRATION)
+					return not_found(pvmw);
+				if (pmd_page(pmde) != pvmw->page)
 					return not_found(pvmw);
-				if (is_migration_entry(pmd_to_swp_entry(*pvmw->pmd))) {
-					swp_entry_t entry = pmd_to_swp_entry(*pvmw->pmd);
+				return true;
+			}
+			if (!pmd_present(pmde)) {
+				swp_entry_t swap;
 
-					if (migration_entry_to_page(entry) != page)
-						return not_found(pvmw);
-					return true;
-				}
+				if (!thp_migration_supported() ||
+				    !(pvmw->flags & PVMW_MIGRATION))
+					return not_found(pvmw);
+				swap = pmd_to_swp_entry(pmde);
+				if (!is_migration_entry(swap) ||
+				    migration_entry_to_page(swap) != pvmw->page)
+					return not_found(pvmw);
+				return true;
 			}
-			return not_found(pvmw);
-		} else {
 			/* THP pmd was split under us: handle on pte level */
 			spin_unlock(pvmw->ptl);
 			pvmw->ptl = NULL;
+		} else if (!pmd_present(pmde)) {
+			/*
+			 * If PVMW_SYNC, take and drop THP pmd lock so that we
+			 * cannot return prematurely, while zap_huge_pmd() has
+			 * cleared *pmd but not decremented compound_mapcount().
+			 */
+			if ((pvmw->flags & PVMW_SYNC) &&
+			    PageTransCompound(pvmw->page))
+				spin_unlock(pmd_lock(mm, pvmw->pmd));
+			step_forward(pvmw, PMD_SIZE);
+			continue;
 		}
-	} else if (!pmd_present(pmde)) {
-		/*
-		 * If PVMW_SYNC, take and drop THP pmd lock so that we
-		 * cannot return prematurely, while zap_huge_pmd() has
-		 * cleared *pmd but not decremented compound_mapcount().
-		 */
-		if ((pvmw->flags & PVMW_SYNC) &&
-		    PageTransCompound(pvmw->page))
-			spin_unlock(pmd_lock(mm, pvmw->pmd));
-		return false;
-	}
-	if (!map_pte(pvmw))
-		goto next_pte;
-	while (1) {
-		unsigned long end;
 
+		if (!map_pte(pvmw))
+			goto next_pte;
+this_pte:
 		if (check_pte(pvmw))
 			return true;
 next_pte:
-		/* Seek to next pte only makes sense for THP */
-		if (!PageTransHuge(pvmw->page) || PageHuge(pvmw->page))
-			return not_found(pvmw);
-		end = vma_address_end(pvmw->page, pvmw->vma);
 		do {
 			pvmw->address += PAGE_SIZE;
 			if (pvmw->address >= end)
 				return not_found(pvmw);
+
 			/* Did we cross page table boundary? */
-			if (pvmw->address % PMD_SIZE == 0) {
-				pte_unmap(pvmw->pte);
+			if ((pvmw->address & (PMD_SIZE - PAGE_SIZE)) == 0) {
 				if (pvmw->ptl) {
 					spin_unlock(pvmw->ptl);
 					pvmw->ptl = NULL;
 				}
+				pte_unmap(pvmw->pte);
+				pvmw->pte = NULL;
 				goto restart;
-			} else {
-				pvmw->pte++;
 			}
+			pvmw->pte++;
 		} while (pte_none(*pvmw->pte));
 
 		if (!pvmw->ptl) {
 			pvmw->ptl = pte_lockptr(mm, pvmw->pmd);
 			spin_lock(pvmw->ptl);
 		}
-	}
+		goto this_pte;
+	} while (pvmw->address < end);
+
+	return false;
 }
 
 /**
-- 
2.32.0.rc0.204.g9fa02ecfa5-goog

