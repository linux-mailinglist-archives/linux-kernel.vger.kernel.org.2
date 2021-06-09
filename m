Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE853A0B44
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 06:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbhFIE2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 00:28:34 -0400
Received: from mail-qt1-f181.google.com ([209.85.160.181]:44678 "EHLO
        mail-qt1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbhFIE2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 00:28:33 -0400
Received: by mail-qt1-f181.google.com with SMTP id t17so17024118qta.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 21:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=Oexv5s0spKxHzuQZR9/nsfhnf91QtP+MqA8iDNbC7OM=;
        b=YOZb6ehBp21ZQtLHgUbb9UZcopJJr9AlVXK18YBLhR7/t2143jZYCiu5oO8mgASh8u
         UF9FxHyPDgScVhf2Cmcdmqo+i+WhQCfi+LTB4iy495pehmdB4SGe8gthJFrzogTMjivV
         BHbtLj8rZT469+apHs3qV+7gtsIuNDrW5FrdbWumJvBohFtBiL86Eb8mile0oYFKSMD9
         JCzawGL/QCBMuvVRmiVeP3lfOi/H2hDoa1xHPs5m7APjPxGvEcP4kqcWWw8xdqMP3r6g
         QmpWMEtz3Kl988Is8J/ZnQFZFDXkgx0dXb18cd8X18W5gQNXxXJmBzL++MQ+2IOuGhRZ
         KQcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=Oexv5s0spKxHzuQZR9/nsfhnf91QtP+MqA8iDNbC7OM=;
        b=bhofwN1nl582PjjL2i4E013Fn+l9yGMIjzAs4aNpmJigz34VAEPYr/ZRXWSOYKewiR
         O/PiybSlOMhso+tW3ai8fWsfLOE8LsTfvC4Hv33a6ZrPzgctYpSC0zIB1l0zF9Fz/e5v
         COUStQY0cZf7EYKpOQ3uqZFbJDhEh+VWDS1PD6N2Yy+JZWKQqRFLOAAIiQTGvYKzJqVf
         oiHG3hUduZVbjSiszL2K4LW15GRn/4kfSkCSCgmtdZbxLPT3bx319q79Pe8GeCrBLwll
         cGE2p4lECM9EPXjORICVCYmMMpDnKkitR4nzFusQWrN2azQoEpSLukSzqUKvUdvfVJ64
         7pgA==
X-Gm-Message-State: AOAM53278g9+uvRto3mwmdX2OYQrQYgdcCuFqSXdXTSrbkHtV4KsVUoi
        4ibT8dBzFSFkMvof82C0Z6YRoA==
X-Google-Smtp-Source: ABdhPJwbPyKWU+Wuips3/pDRxUOpIKw45kcSiPRUUl/Qx0rOshbDGdblVW4/K9JGaXvbsPETG5dlKQ==
X-Received: by 2002:ac8:1090:: with SMTP id a16mr24489959qtj.32.1623212725465;
        Tue, 08 Jun 2021 21:25:25 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id k7sm3114562qke.65.2021.06.08.21.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 21:25:25 -0700 (PDT)
Date:   Tue, 8 Jun 2021 21:25:22 -0700 (PDT)
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
Subject: [PATCH v2 08/10] mm: rmap: make try_to_unmap() void function
In-Reply-To: <af88612-1473-2eaa-903-8d1a448b26@google.com>
Message-ID: <bb27e3fe-6036-b637-5086-272befbfe3da@google.com>
References: <af88612-1473-2eaa-903-8d1a448b26@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
Patch inserted since the v1 series was posted.
v5: Rediffed by Hugh to fit before 7/7 in mm/thp series; akpm fixed grammar.
v4: Updated the comment of try_to_unmap() per Minchan.
    Minor fix and patch reorder per Hugh.
    Collected ack tag from Hugh.

 include/linux/rmap.h |  2 +-
 mm/memory-failure.c  | 15 +++++++--------
 mm/rmap.c            | 15 ++++-----------
 mm/vmscan.c          |  3 ++-
 4 files changed, 14 insertions(+), 21 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 8d04e7deedc6..ed31a559e857 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -195,7 +195,7 @@ static inline void page_dup_rmap(struct page *page, bool compound)
 int page_referenced(struct page *, int is_locked,
 			struct mem_cgroup *memcg, unsigned long *vm_flags);
 
-bool try_to_unmap(struct page *, enum ttu_flags flags);
+void try_to_unmap(struct page *, enum ttu_flags flags);
 
 /* Avoid racy checks */
 #define PVMW_SYNC		(1 << 0)
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 85ad98c00fd9..b6806e446567 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1063,7 +1063,7 @@ static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
 	enum ttu_flags ttu = TTU_IGNORE_MLOCK;
 	struct address_space *mapping;
 	LIST_HEAD(tokill);
-	bool unmap_success = true;
+	bool unmap_success;
 	int kill = 1, forcekill;
 	struct page *hpage = *hpagep;
 	bool mlocked = PageMlocked(hpage);
@@ -1126,7 +1126,7 @@ static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
 		collect_procs(hpage, &tokill, flags & MF_ACTION_REQUIRED);
 
 	if (!PageHuge(hpage)) {
-		unmap_success = try_to_unmap(hpage, ttu);
+		try_to_unmap(hpage, ttu);
 	} else {
 		if (!PageAnon(hpage)) {
 			/*
@@ -1138,17 +1138,16 @@ static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
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
diff --git a/mm/rmap.c b/mm/rmap.c
index e05c300048e6..f9fd5bc54f0a 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1405,7 +1405,7 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 	/*
 	 * When racing against e.g. zap_pte_range() on another cpu,
 	 * in between its ptep_get_and_clear_full() and page_remove_rmap(),
-	 * try_to_unmap() may return false when it is about to become true,
+	 * try_to_unmap() may return before page_mapped() has become false,
 	 * if page table locking is skipped: use TTU_SYNC to wait for that.
 	 */
 	if (flags & TTU_SYNC)
@@ -1756,9 +1756,10 @@ static int page_not_mapped(struct page *page)
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
@@ -1783,14 +1784,6 @@ bool try_to_unmap(struct page *page, enum ttu_flags flags)
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
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 5199b9696bab..db49cb1dc052 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1499,7 +1499,8 @@ static unsigned int shrink_page_list(struct list_head *page_list,
 			if (unlikely(PageTransHuge(page)))
 				flags |= TTU_SPLIT_HUGE_PMD;
 
-			if (!try_to_unmap(page, flags)) {
+			try_to_unmap(page, flags);
+			if (page_mapped(page)) {
 				stat->nr_unmap_fail += nr_pages;
 				if (!was_swapbacked && PageSwapBacked(page))
 					stat->nr_lazyfree_fail += nr_pages;
-- 
2.26.2

