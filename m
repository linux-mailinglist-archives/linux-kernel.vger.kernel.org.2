Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6A1839AE1D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 00:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbhFCWeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 18:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbhFCWeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 18:34:12 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36CBC06174A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jun 2021 15:32:13 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id t9so6272608pgn.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 15:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=1cIH/F1jkzg48s/ae1CSNbZBfiqPXSXFc79arnsiMZc=;
        b=JjGzfKQzJQvXXhtZoV73odsPZGG5/Ot0TPUj2YfgZhWOEUjHeSp8gJNhaZyMmKqzn5
         Kp2jFkuhpdeNtMgfxnM0j8rDRnwRsKnXOgRUuG1BcAuLV38nnd5oPNYl928lSg04wWtQ
         ML4EsSAogz6gM7gOq+UkIXmQ/UhI0BL0MlOE4BU/c8Jb1V4EOtxZ2vWxdV3S3ZoDDQIJ
         Vnoo4NwlWNnqBDilb1bXrPDIP0zvqsNoQ6DbMi+FEfriYC1UcxgBAdexZG5ZQ3XlAyIJ
         xXMf6VUBem3Jl0LnwKkDWTyl/sMvj+acqWklTyi/8UZatUK6A5V5yPmnlQsy9rhyh+PB
         3UDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=1cIH/F1jkzg48s/ae1CSNbZBfiqPXSXFc79arnsiMZc=;
        b=iL8cK3Wk3HUYA2KQq3pRtrZ5TvEuwOyDCVFpbWVKXr4bvUW35RA4KPDQuZ3XfQN4z4
         uhnWj+7gPGpcOkTU5C9rgXz9/XuAm772BeRIC7uQjk3iNR14tVVtg6KU4zIZ1vi/i9dX
         HW1PrGX1/LCiuNeEOFb4L71YNjlP4JxAXdLfMgaO1yF66/T8R1U15XrRNCX1O0WIm11v
         ojdWEfrUS1+Tv0iyO2V1Xx2JYf8+0JCc6weQUHvL6KzwRbFdRsgjEsdgDLPYyOkNp0VY
         bV65eRdKKk9S4enO8NPpLJpRw2O+z+ALZV/UEREC6SQtLMmauuNr24R+Fnm9kMo9Oalu
         3/fw==
X-Gm-Message-State: AOAM530B9KZHIXvVWbJ8RrSwIsxqy3jhVKr7zj9Xd6rBTymiKz+pMCI5
        4UqGnoyd6c+wyhLtG01f9AvZ4A==
X-Google-Smtp-Source: ABdhPJy2Fk7v7u37Zno1oA4L53LfhRnujcJ77HQiMTx4e+GD51tmVyMaiTkfhZ4HdQWMqJcShL97Lw==
X-Received: by 2002:a62:e908:0:b029:2db:8791:c217 with SMTP id j8-20020a62e9080000b02902db8791c217mr1387607pfh.28.1622759532876;
        Thu, 03 Jun 2021 15:32:12 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id v9sm84364pfn.22.2021.06.03.15.32.11
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 03 Jun 2021 15:32:12 -0700 (PDT)
Date:   Thu, 3 Jun 2021 15:32:10 -0700 (PDT)
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
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6.2/7] mm: rmap: make try_to_unmap() void function
Message-ID: <alpine.LSU.2.11.2106031527070.11704@eggly.anvils>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Shi <shy828301@gmail.com>

Currently try_to_unmap() return bool value by checking page_mapcount(),
however this may return false positive since page_mapcount() doesn't
check all subpages of compound page.  The total_mapcount() could be used
instead, but its cost is higher since it traverses all subpages.

Actually the most callers of try_to_unmap() don't care about the
return value at all.  So just need check if page is still mapped by
page_mapped() when necessary.  And page_mapped() does bail out early
when it finds mapped subpage.

Suggested-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Yang Shi <shy828301@gmail.com>
Acked-by: Minchan Kim <minchan@kernel.org>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Hugh Dickins <hughd@google.com>
---
v5: Rediffed by Hugh to fit before 7/7 in mm/thp series; akpm fixed grammar.
v4: Updated the comment of try_to_unmap() per Minchan.
    Minor fix and patch reorder per Hugh.
    Collected ack tag from Hugh.
 
 include/linux/rmap.h |  2 +-
 mm/memory-failure.c  | 15 +++++++--------
 mm/rmap.c            | 15 ++++-----------
 mm/vmscan.c          |  3 ++-
 4 files changed, 14 insertions(+), 21 deletions(-)

--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -195,7 +195,7 @@ static inline void page_dup_rmap(struct
 int page_referenced(struct page *, int is_locked,
 			struct mem_cgroup *memcg, unsigned long *vm_flags);
 
-bool try_to_unmap(struct page *, enum ttu_flags flags);
+void try_to_unmap(struct page *, enum ttu_flags flags);
 
 /* Avoid racy checks */
 #define PVMW_SYNC		(1 << 0)
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1063,7 +1063,7 @@ static bool hwpoison_user_mappings(struc
 	enum ttu_flags ttu = TTU_IGNORE_MLOCK;
 	struct address_space *mapping;
 	LIST_HEAD(tokill);
-	bool unmap_success = true;
+	bool unmap_success;
 	int kill = 1, forcekill;
 	struct page *hpage = *hpagep;
 	bool mlocked = PageMlocked(hpage);
@@ -1126,7 +1126,7 @@ static bool hwpoison_user_mappings(struc
 		collect_procs(hpage, &tokill, flags & MF_ACTION_REQUIRED);
 
 	if (!PageHuge(hpage)) {
-		unmap_success = try_to_unmap(hpage, ttu);
+		try_to_unmap(hpage, ttu);
 	} else {
 		if (!PageAnon(hpage)) {
 			/*
@@ -1138,17 +1138,16 @@ static bool hwpoison_user_mappings(struc
 			 */
 			mapping = hugetlb_page_mapping_lock_write(hpage);
 			if (mapping) {
-				unmap_success = try_to_unmap(hpage,
-						     ttu|TTU_RMAP_LOCKED);
+				try_to_unmap(hpage, ttu|TTU_RMAP_LOCKED);
 				i_mmap_unlock_write(mapping);
-			} else {
+			} else
 				pr_info("Memory failure: %#lx: could not lock mapping for mapped huge page\n", pfn);
-				unmap_success = false;
-			}
 		} else {
-			unmap_success = try_to_unmap(hpage, ttu);
+			try_to_unmap(hpage, ttu);
 		}
 	}
+
+	unmap_success = !page_mapped(hpage);
 	if (!unmap_success)
 		pr_err("Memory failure: %#lx: failed to unmap page (mapcount=%d)\n",
 		       pfn, page_mapcount(hpage));
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1405,7 +1405,7 @@ static bool try_to_unmap_one(struct page
 	/*
 	 * When racing against e.g. zap_pte_range() on another cpu,
 	 * in between its ptep_get_and_clear_full() and page_remove_rmap(),
-	 * try_to_unmap() may return false when it is about to become true,
+	 * try_to_unmap() may return before page_mapped() has become false,
 	 * if page table locking is skipped: use TTU_SYNC to wait for that.
 	 */
 	if (flags & TTU_SYNC)
@@ -1756,9 +1756,10 @@ static int page_not_mapped(struct page *
  * Tries to remove all the page table entries which are mapping this
  * page, used in the pageout path.  Caller must hold the page lock.
  *
- * If unmap is successful, return true. Otherwise, false.
+ * It is the caller's responsibility to check if the page is still
+ * mapped when needed (use TTU_SYNC to prevent accounting races).
  */
-bool try_to_unmap(struct page *page, enum ttu_flags flags)
+void try_to_unmap(struct page *page, enum ttu_flags flags)
 {
 	struct rmap_walk_control rwc = {
 		.rmap_one = try_to_unmap_one,
@@ -1783,14 +1784,6 @@ bool try_to_unmap(struct page *page, enu
 		rmap_walk_locked(page, &rwc);
 	else
 		rmap_walk(page, &rwc);
-
-	/*
-	 * When racing against e.g. zap_pte_range() on another cpu,
-	 * in between its ptep_get_and_clear_full() and page_remove_rmap(),
-	 * try_to_unmap() may return false when it is about to become true,
-	 * if page table locking is skipped: use TTU_SYNC to wait for that.
-	 */
-	return !page_mapcount(page);
 }
 
 /**
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1499,7 +1499,8 @@ static unsigned int shrink_page_list(str
 			if (unlikely(PageTransHuge(page)))
 				flags |= TTU_SPLIT_HUGE_PMD;
 
-			if (!try_to_unmap(page, flags)) {
+			try_to_unmap(page, flags);
+			if (page_mapped(page)) {
 				stat->nr_unmap_fail += nr_pages;
 				if (!was_swapbacked && PageSwapBacked(page))
 					stat->nr_lazyfree_fail += nr_pages;
