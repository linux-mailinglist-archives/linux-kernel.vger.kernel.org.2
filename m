Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8297F39214C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 22:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234826AbhEZUOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 16:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234459AbhEZUOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 16:14:18 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0051BC061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 13:12:44 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id b15-20020a17090a550fb029015dad75163dso1026866pji.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 13:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eQOkcldMz8ZV0+0FlIeCmLxH8CE8izOoMLx4OKhr7bA=;
        b=j+XiyygpxhohjxCJIfcd8c7j7QGFK1GhcNOHOSWFEd2XaOH+FqVXwjRQHzfBGczTOS
         49KZBflXn9Axpdr98IEV8WN+yqsIhopR02MI1Y2vRpxj+ZNH0Y8gjSjZou3jqXCzWsg6
         O09LpPIUbkLXkv1tvBLsuAMLhAZnpFBz9t2BHvtEXvFZyD1VSAxClFJHf6ldo/saS4BB
         1wa5wgyp69QqfdNGybEdCvrYs8WarXnwQ7JPKrjxVrylGoe6bsqPEuekrg3rAG6O8cZP
         IwdUf5OvmbAhQjAHWMfnAmIY7s/b3OLU/RseHdhPJ/m76EEvqX2AjPtnoQt1s6HUMOil
         +yxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eQOkcldMz8ZV0+0FlIeCmLxH8CE8izOoMLx4OKhr7bA=;
        b=P39YbqKRjw1yJVYxJGBMeFX2h2IZP2w6cYlrFqM3dIogx4VwjjfvNZBgqWI8M0IJuy
         vs3vulVOFZXFGZJF8JU4IvbqSagZFkSYm0ukF4Z0AXsHyQchBugNeMLm8V351aLszx5F
         Y3gTOWJHU8fx2306HTrc3sNZIJIvlVSO2a820Cin/a4pNNQ2yS+lLRVeSE5EmKi4kuVh
         3Y24GZyltUWFQtokkeXDUVRJuFOf+k6qQE7Y3x5Et1gyiD0vrkGpZ7fek0U8nJnftuzY
         JT0e0Nhoubxyh9SSzRd981NSIJBfu5qgvOmgL5tOqlry9zhwCHdg4Bv4WWb+o7L0xmNP
         EjeQ==
X-Gm-Message-State: AOAM532U9teUylSuvFS1qTeVCBV3O0rT4ExLQoMafcFtcqp1/2ipyWqS
        t2RAWd49REtlCNE+HZNaAoM=
X-Google-Smtp-Source: ABdhPJxjC/GA4ohp7Rah2L2JWZQyzkVwgTOuOa3pGRpZkHsVPhCo4VzK9KoIaqSpbPHzgEj1ZE6FMg==
X-Received: by 2002:a17:90a:ec05:: with SMTP id l5mr5764953pjy.141.1622059964600;
        Wed, 26 May 2021 13:12:44 -0700 (PDT)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id m14sm76733pff.17.2021.05.26.13.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 13:12:43 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     hughd@google.com, ziy@nvidia.com, kirill.shutemov@linux.intel.com,
        minchan@kernel.org, naoya.horiguchi@nec.com,
        wangyugui@e16-tech.com, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [v4 PATCH 2/2] mm: rmap: make try_to_unmap() void function
Date:   Wed, 26 May 2021 13:12:39 -0700
Message-Id: <20210526201239.3351-2-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210526201239.3351-1-shy828301@gmail.com>
References: <20210526201239.3351-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently try_to_unmap() return bool value by checking page_mapcount(),
however this may return false positive since page_mapcount() doesn't
check all subpages of compound page.  The total_mapcount() could be used
instead, but its cost is higher since it traverses all subpages.

Actually the most callers of try_to_unmap() don't care about the
return value at all.  So just need check if page is still mapped by
page_mapped() when necessary.  And page_mapped() does bail out early
when it finds mapped subpage.

Suggested-by: Hugh Dickins <hughd@google.com>
Acked-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Yang Shi <shy828301@gmail.com>
---
v4: Updated the comment of try_to_unmap() per Minchan.
    Minor fix and patch reorder per Hugh.
    Collected ack tag from Hugh.
 
 include/linux/rmap.h |  2 +-
 mm/memory-failure.c  | 15 +++++++--------
 mm/rmap.c            |  7 +++----
 mm/vmscan.c          |  3 ++-
 4 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index def5c62c93b3..116cb193110a 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -194,7 +194,7 @@ static inline void page_dup_rmap(struct page *page, bool compound)
 int page_referenced(struct page *, int is_locked,
 			struct mem_cgroup *memcg, unsigned long *vm_flags);
 
-bool try_to_unmap(struct page *, enum ttu_flags flags);
+void try_to_unmap(struct page *, enum ttu_flags flags);
 
 /* Avoid racy checks */
 #define PVMW_SYNC		(1 << 0)
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 9dcc9bcea731..07e462588df9 100644
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
index a35cbbbded0d..d4e0d89726b8 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1749,9 +1749,10 @@ static int page_not_mapped(struct page *page)
  * Tries to remove all the page table entries which are mapping this
  * page, used in the pageout path.  Caller must hold the page lock.
  *
- * If unmap is successful, return true. Otherwise, false.
+ * It is the callers' responsibility to check if the page is still
+ * mapped when needed.
  */
-bool try_to_unmap(struct page *page, enum ttu_flags flags)
+void try_to_unmap(struct page *page, enum ttu_flags flags)
 {
 	struct rmap_walk_control rwc = {
 		.rmap_one = try_to_unmap_one,
@@ -1776,8 +1777,6 @@ bool try_to_unmap(struct page *page, enum ttu_flags flags)
 		rmap_walk_locked(page, &rwc);
 	else
 		rmap_walk(page, &rwc);
-
-	return !page_mapcount(page) ? true : false;
 }
 
 /**
diff --git a/mm/vmscan.c b/mm/vmscan.c
index f96d62159720..fa5052ace415 100644
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

