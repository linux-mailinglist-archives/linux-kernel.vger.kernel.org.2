Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5B613E32F5
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 05:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbhHGD0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 23:26:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50078 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230398AbhHGDZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 23:25:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628306732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OK+bQTiUipxL6Jk7xja/DmcKUDIieuX4Ee7RUXkwoH4=;
        b=MxGj6GCWZEImAV6N249Gfr7A05BwEAPnH1JZ/kaBDVQbLz1kwDxA+zlufKOA6SPnRaIkF6
        BDqingXoOQKWway8hSdHRXHeVtTfM3V/+smI6zk1qEWUKaIj40Uz30DW86oi71TRyRAJ05
        23lBW1kKy6P6892E/S8pCpf390JaOOY=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-vaQgol2KMBuewB14T-oPWg-1; Fri, 06 Aug 2021 23:25:31 -0400
X-MC-Unique: vaQgol2KMBuewB14T-oPWg-1
Received: by mail-qk1-f199.google.com with SMTP id w2-20020a3794020000b02903b54f40b442so7768383qkd.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 20:25:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OK+bQTiUipxL6Jk7xja/DmcKUDIieuX4Ee7RUXkwoH4=;
        b=NcDc4LcCoebSMd6q6LdghOymz5O0ITTBi8rMDBvnloLq7jw32GFxzuV92qWuvc+/N9
         9BgKaLnSkqWU4sOVNN3EOR4290aHZZIclFx7Bb+5F+p2rEHqactm2EF6VIeAIXrk4YGB
         3c33jA+gj2pBn3b5x7fvzmPs0KFv0+zDcGqJWXOohhVYTFPHkqUFsri8aMhFP2K1j6WV
         Q72Y05neM+ub1eIzZjk7XEZhz/cIDm/IIxDjQGbSxwdiEbXiuPYnYc0CS65qTYitIhQG
         N9aQDw58j4lSXHDYGEBI2gEoD/orXAULIXYguKb9tiefHTGh1HaQ8UJP8+5JU/tambAl
         gRmg==
X-Gm-Message-State: AOAM530IWZzwb4cMkLZol9W7Lpvr3Dv22CoqDm0DNhqPKl1RpkYxYOuX
        uQJcTlidme3vjjVHAZbTiI2VnR+0R1DaJAQhX0xSGpGdNUcNTG43s8i3gcD1XADwhGpK55HPgFG
        FjDlFI0x5rut0NptREB9Ea4uxGc5ywM65cP/FT8Puwpj7J7GHkmoaXQE7Oo/jmydLNmHxoP99iA
        ==
X-Received: by 2002:aed:2163:: with SMTP id 90mr11658380qtc.186.1628306730437;
        Fri, 06 Aug 2021 20:25:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzCK0I1XtqNK7P9nzzv0g1D1B3S1najqoV6hQLfL5gLFgAFA6yE5Kw0DBDbjYav/08UMiA3oA==
X-Received: by 2002:aed:2163:: with SMTP id 90mr11658356qtc.186.1628306730149;
        Fri, 06 Aug 2021 20:25:30 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-92-76-70-75-133.dsl.bell.ca. [76.70.75.133])
        by smtp.gmail.com with ESMTPSA id a5sm5514875qkk.92.2021.08.06.20.25.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Aug 2021 20:25:29 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Alistair Popple <apopple@nvidia.com>,
        Tiberiu Georgescu <tiberiu.georgescu@nutanix.com>,
        ivan.teterevkov@nutanix.com,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Hugh Dickins <hughd@google.com>, peterx@redhat.com,
        Matthew Wilcox <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH RFC 4/4] mm: Install marker pte when page out for shmem pages
Date:   Fri,  6 Aug 2021 23:25:21 -0400
Message-Id: <20210807032521.7591-5-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210807032521.7591-1-peterx@redhat.com>
References: <20210807032521.7591-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When shmem pages are swapped out, instead of clearing the pte entry, we leave a
marker pte showing that this page is swapped out as a hint for pagemap.  A new
TTU flag is introduced to identify this case.

This can be useful for detecting swapped out cold shmem pages.  Then after some
memory background scanning work (which will fault in the shmem page and
confusing page reclaim), we can do MADV_PAGEOUT explicitly on this page to swap
it out again as we know it was cold.

For pagemap, we don't need to explicitly set PM_SWAP bit, because by nature
SWP_PTE_MARKER ptes are already counted as PM_SWAP due to it's format as swap.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 fs/proc/task_mmu.c   |  1 +
 include/linux/rmap.h |  1 +
 mm/rmap.c            | 19 +++++++++++++++++++
 mm/vmscan.c          |  2 +-
 4 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index eb97468dfe4c..21b8594abc1d 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1384,6 +1384,7 @@ static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
 		if (pm->show_pfn)
 			frame = swp_type(entry) |
 				(swp_offset(entry) << MAX_SWAPFILES_SHIFT);
+		/* NOTE: this covers PTE_MARKER_PAGEOUT too */
 		flags |= PM_SWAP;
 		if (is_pfn_swap_entry(entry))
 			page = pfn_swap_entry_to_page(entry);
diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index c976cc6de257..318a0e95c7fb 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -95,6 +95,7 @@ enum ttu_flags {
 					 * do a final flush if necessary */
 	TTU_RMAP_LOCKED		= 0x80,	/* do not grab rmap lock:
 					 * caller holds it */
+	TTU_HINT_PAGEOUT	= 0x100, /* Hint for pageout operation */
 };
 
 #ifdef CONFIG_MMU
diff --git a/mm/rmap.c b/mm/rmap.c
index b9eb5c12f3fe..24a70b36b6da 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1384,6 +1384,22 @@ void page_remove_rmap(struct page *page, bool compound)
 	unlock_page_memcg(page);
 }
 
+static inline void
+pte_marker_install(struct vm_area_struct *vma, pte_t *pte,
+		   struct page *page, unsigned long address)
+{
+#ifdef CONFIG_PTE_MARKER_PAGEOUT
+	swp_entry_t entry;
+	pte_t pteval;
+
+	if (vma_is_shmem(vma) && !PageAnon(page) && pte_none(*pte)) {
+		entry = make_pte_marker_entry(PTE_MARKER_PAGEOUT);
+		pteval = swp_entry_to_pte(entry);
+		set_pte_at(vma->vm_mm, address, pte, pteval);
+	}
+#endif
+}
+
 /*
  * @arg: enum ttu_flags will be passed to this argument
  */
@@ -1628,6 +1644,9 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 			 */
 			dec_mm_counter(mm, mm_counter_file(page));
 		}
+
+		if (flags & TTU_HINT_PAGEOUT)
+			pte_marker_install(vma, pvmw.pte, page, address);
 discard:
 		/*
 		 * No need to call mmu_notifier_invalidate_range() it has be
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 4620df62f0ff..4754af6fa24b 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1493,7 +1493,7 @@ static unsigned int shrink_page_list(struct list_head *page_list,
 		 * processes. Try to unmap it here.
 		 */
 		if (page_mapped(page)) {
-			enum ttu_flags flags = TTU_BATCH_FLUSH;
+			enum ttu_flags flags = TTU_BATCH_FLUSH | TTU_HINT_PAGEOUT;
 			bool was_swapbacked = PageSwapBacked(page);
 
 			if (unlikely(PageTransHuge(page)))
-- 
2.32.0

