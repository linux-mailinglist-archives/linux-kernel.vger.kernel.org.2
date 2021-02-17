Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9CD31D74D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 11:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbhBQKJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 05:09:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:50736 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232102AbhBQKJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 05:09:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6E730B7B2;
        Wed, 17 Feb 2021 10:08:26 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH 1/2] mm: Make alloc_contig_range handle free hugetlb pages
Date:   Wed, 17 Feb 2021 11:08:15 +0100
Message-Id: <20210217100816.28860-2-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20210217100816.28860-1-osalvador@suse.de>
References: <20210217100816.28860-1-osalvador@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Free hugetlb pages are tricky to handle so as to no userspace application
notices disruption, we need to replace the current free hugepage with
a new one.

In order to do that, a new function called alloc_and_dissolve_huge_page
is introduced.
This function will first try to get a new fresh hugetlb page, and if it
succeeds, it will dissolve the old one.

With regard to the allocation, since we do not know whether the old page
was allocated on a specific node on request, the node the old page belongs
to will be tried first, and then we will fallback to all nodes containing
memory (N_MEMORY).

Note that gigantic hugetlb pages are fenced off since there is a cyclic
dependency between them and alloc_contig_range.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 include/linux/hugetlb.h |  6 ++++
 mm/compaction.c         | 12 +++++++
 mm/hugetlb.c            | 91 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 109 insertions(+)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index b5807f23caf8..72352d718829 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -505,6 +505,7 @@ struct huge_bootmem_page {
 	struct hstate *hstate;
 };
 
+bool isolate_or_dissolve_huge_page(struct page *page);
 struct page *alloc_huge_page(struct vm_area_struct *vma,
 				unsigned long addr, int avoid_reserve);
 struct page *alloc_huge_page_nodemask(struct hstate *h, int preferred_nid,
@@ -775,6 +776,11 @@ void set_page_huge_active(struct page *page);
 #else	/* CONFIG_HUGETLB_PAGE */
 struct hstate {};
 
+static inline bool isolate_or_dissolve_huge_page(struct page *page)
+{
+	return false;
+}
+
 static inline struct page *alloc_huge_page(struct vm_area_struct *vma,
 					   unsigned long addr,
 					   int avoid_reserve)
diff --git a/mm/compaction.c b/mm/compaction.c
index 190ccdaa6c19..d52506ed9db7 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -905,6 +905,18 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 			valid_page = page;
 		}
 
+		if (PageHuge(page) && cc->alloc_contig) {
+			if (!isolate_or_dissolve_huge_page(page))
+				goto isolate_fail;
+
+			/*
+			 * Ok, the hugepage was dissolved. Now these pages are
+			 * Buddy and cannot be re-allocated because they are
+			 * isolated. Fall-through as the check below handles
+			 * Buddy pages.
+			 */
+		}
+
 		/*
 		 * Skip if free. We read page order here without zone lock
 		 * which is generally unsafe, but the race window is small and
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 4bdb58ab14cb..b78926bca60a 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2294,6 +2294,97 @@ static void restore_reserve_on_error(struct hstate *h,
 	}
 }
 
+static bool alloc_and_dissolve_huge_page(struct hstate *h, struct page *page)
+{
+	gfp_t gfp_mask = htlb_alloc_mask(h);
+	nodemask_t *nmask = &node_states[N_MEMORY];
+	struct page *new_page;
+	bool ret = false;
+	int nid;
+
+	spin_lock(&hugetlb_lock);
+	/*
+	 * Check one more time to make race-window smaller.
+	 */
+	if (!PageHuge(page)) {
+		/*
+		 * Dissolved from under our feet.
+		 */
+		spin_unlock(&hugetlb_lock);
+		return true;
+	}
+
+	nid = page_to_nid(page);
+	spin_unlock(&hugetlb_lock);
+
+	/*
+	 * Before dissolving the page, we need to allocate a new one,
+	 * so the pool remains stable.
+	 */
+	new_page = alloc_fresh_huge_page(h, gfp_mask, nid, nmask, NULL);
+	if (new_page) {
+		/*
+		 * Ok, we got a new free hugepage to replace this one. Try to
+		 * dissolve the old page.
+		 */
+		if (!dissolve_free_huge_page(page)) {
+			ret = true;
+		} else if (dissolve_free_huge_page(new_page)) {
+			/*
+			 * Seems the old page could not be dissolved, so try to
+			 * dissolve the freshly allocated page. If that fails
+			 * too, let us count the new page as a surplus. Doing so
+			 * allows the pool to be re-balanced when pages are freed
+			 * instead of enqueued again.
+			 */
+			spin_lock(&hugetlb_lock);
+			h->surplus_huge_pages++;
+			h->surplus_huge_pages_node[nid]++;
+			spin_unlock(&hugetlb_lock);
+		}
+		/*
+		 * Free it into the hugepage allocator
+		 */
+		put_page(new_page);
+	}
+
+	return ret;
+}
+
+bool isolate_or_dissolve_huge_page(struct page *page)
+{
+	struct hstate *h = NULL;
+	struct page *head;
+	bool ret = false;
+
+	spin_lock(&hugetlb_lock);
+	if (PageHuge(page)) {
+		head = compound_head(page);
+		h = page_hstate(head);
+	}
+	spin_unlock(&hugetlb_lock);
+
+	if (!h)
+		/*
+		 * The page might have been dissolved from under our feet.
+		 * If that is the case, return success as if we dissolved it
+		 * ourselves.
+		 */
+		return true;
+
+	if (hstate_is_gigantic(h))
+		/*
+		 * Fence off gigantic pages as there is a cyclic dependency
+		 * between alloc_contig_range and them.
+		 */
+		return ret;
+
+	if(!page_count(head) && alloc_and_dissolve_huge_page(h, head))
+		ret = true;
+
+	return ret;
+}
+
 struct page *alloc_huge_page(struct vm_area_struct *vma,
 				    unsigned long addr, int avoid_reserve)
 {
-- 
2.16.3

