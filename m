Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7CF1390686
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 18:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbhEYQXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 12:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbhEYQXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 12:23:18 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2D2C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 09:21:48 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id s4so15054050plg.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 09:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LV7x92f0QnEOEbD+UIPivGRGEvqdiDitTjQ43vOV6Fc=;
        b=c1YciXiw1HnElOZummb+oM3cKQ24xEv/oBVCKgZ8FIAUmStJnIcisIMq4Nw4xw3pzz
         leczUPKeuCxPhrzailBKqECLgtLYdyygH9FivuzofzDiWn34X3J8mriQHlgEjU/2ASXJ
         9hvB1RVG2EpOyYBq9CM9wC6NEPre19ycooEiHClk6WO+xHkzm3zPBXdanYwoGNxilukX
         gwdj7IQ1Bqvkwk2hUa1k3HfzQ/fTnowEwoDY1RBhyN++y1E8xOOm+aZS+kJP0/yHTp3z
         doR0l4Y7WFG47WgpI0P0DA4Q+nsB0sfCtLMpeQiv62HE10B5BvNHnrGabg/NQK4lcOFh
         Pw/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LV7x92f0QnEOEbD+UIPivGRGEvqdiDitTjQ43vOV6Fc=;
        b=U5u+cYfcRDpjHtERwR/FwGxgZvgwbsdk68aM/H/HDWPUNe7+09Np3eZDhkd3ONT+zB
         dnL8+i19+X/ADVc+BVvr9Op9tGaaayKPWeqgBgDfVei9yF6E87yxTq+Eg+IhGDh2pjvh
         QDlUp+MB6OlOABNonC6AnHEw+yDtVEOk8T7N4aXXlw0n/3BTvxAGuUUqoVI76bUwSaRr
         IJpcwCvC0CB41v4hisSzH2LuQqPwyITg3CWW67flfERizwJ52EfmBEOeL+UenkOOxGDp
         FtH2oAoFRIKI91JIhwg2xCXW/mvEItg/fjZjYkLyzx2ZaT54v9P9nOhHj3LXf1FFhiVX
         O/jQ==
X-Gm-Message-State: AOAM5316w3Jb86cfTlaQI0axfsMhrtEFKPmUu88I4RENi9CDcSov7I2s
        4HsENGK/B+p/h8s41zkqMqQ=
X-Google-Smtp-Source: ABdhPJz+dQWuMdya3EF4zCIsGQlzFDX+GPDVbAj3bBG3Wzyu8poC1aLTK4pi08x3qZkbWzbZMyPyJw==
X-Received: by 2002:a17:90a:d0c5:: with SMTP id y5mr31056828pjw.109.1621959707704;
        Tue, 25 May 2021 09:21:47 -0700 (PDT)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id e22sm7493087pfl.188.2021.05.25.09.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 09:21:47 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     hughd@google.com, ziy@nvidia.com, kirill.shutemov@linux.intel.com,
        naoya.horiguchi@nec.com, wangyugui@e16-tech.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [v3 PATCH 1/2] mm: rmap: make try_to_unmap() void function
Date:   Tue, 25 May 2021 09:21:44 -0700
Message-Id: <20210525162145.3510-1-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
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
Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 include/linux/rmap.h |  2 +-
 mm/huge_memory.c     |  4 +---
 mm/memory-failure.c  | 13 ++++++-------
 mm/rmap.c            |  6 +-----
 mm/vmscan.c          |  3 ++-
 5 files changed, 11 insertions(+), 17 deletions(-)

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
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 19195fca1aee..80fe642d742d 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2336,15 +2336,13 @@ static void unmap_page(struct page *page)
 {
 	enum ttu_flags ttu_flags = TTU_IGNORE_MLOCK |
 		TTU_RMAP_LOCKED | TTU_SPLIT_HUGE_PMD;
-	bool unmap_success;
 
 	VM_BUG_ON_PAGE(!PageHead(page), page);
 
 	if (PageAnon(page))
 		ttu_flags |= TTU_SPLIT_FREEZE;
 
-	unmap_success = try_to_unmap(page, ttu_flags);
-	VM_BUG_ON_PAGE(!unmap_success, page);
+	try_to_unmap(page, ttu_flags);
 }
 
 static void remap_page(struct page *page, unsigned int nr)
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 9dcc9bcea731..6dd53ff34825 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
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
index a35cbbbded0d..728de421e43a 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1748,10 +1748,8 @@ static int page_not_mapped(struct page *page)
  *
  * Tries to remove all the page table entries which are mapping this
  * page, used in the pageout path.  Caller must hold the page lock.
- *
- * If unmap is successful, return true. Otherwise, false.
  */
-bool try_to_unmap(struct page *page, enum ttu_flags flags)
+void try_to_unmap(struct page *page, enum ttu_flags flags)
 {
 	struct rmap_walk_control rwc = {
 		.rmap_one = try_to_unmap_one,
@@ -1776,8 +1774,6 @@ bool try_to_unmap(struct page *page, enum ttu_flags flags)
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

