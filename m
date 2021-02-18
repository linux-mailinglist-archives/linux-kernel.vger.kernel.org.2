Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6591A31EA9A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 14:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbhBRNxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 08:53:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:58950 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230495AbhBRMBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 07:01:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 99A7AAF1B;
        Thu, 18 Feb 2021 12:00:39 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v2 1/2] mm: Make alloc_contig_range handle free hugetlb pages
Date:   Thu, 18 Feb 2021 13:00:27 +0100
Message-Id: <20210218120028.6499-2-osalvador@suse.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210218120028.6499-1-osalvador@suse.de>
References: <20210218120028.6499-1-osalvador@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

alloc_contig_range will fail if it ever sees a HugeTLB page within the
range we are trying to allocate, even when that page is free and can be
easily reallocated.
This has proofed to be problematic for some users of alloc_contic_range,
e.g: CMA and virtio-mem, where those would fail the call even when those
pages lay in ZONE_MOVABLE and are free.

We can do better by trying to dissolve such pages.

Free hugepages are tricky to handle so as to no userspace application
notices disruption, we need to replace the current free hugepage with
a new one.

In order to do that, a new function called alloc_and_dissolve_huge_page
is introduced.
This function will first try to get a new fresh hugepage, and if it
succeeds, it will dissolve the old one.

If the old hugepage cannot be be dissolved, we have to dissolve the new
hugepage we just got.
Should that fail as well, we count is as a surplus, so the pool will be
re-balanced when a hugepage gets free instead of enqueues again.

With regard to the allocation, we restrict it to the node the page belongs
to with __GFP_THISNODE, meaning we do not fallback on other node's zones.

Note that gigantic hugetlb pages are fenced off since there is a cyclic
dependency between them and alloc_contig_range.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 include/linux/hugetlb.h |  6 ++++
 mm/compaction.c         | 12 ++++++++
 mm/hugetlb.c            | 75 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 93 insertions(+)

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
index 4bdb58ab14cb..a4fbbe924a55 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2294,6 +2294,81 @@ static void restore_reserve_on_error(struct hstate *h,
 	}
 }
 
+static bool alloc_and_dissolve_huge_page(struct hstate *h, struct page *page)
+{
+	gfp_t gfp_mask = htlb_alloc_mask(h) | __GFP_THISNODE;
+	int nid = page_to_nid(page);
+	struct page *new_page;
+	bool ret = false;
+
+	/*
+	 * Before dissolving the page, we need to allocate a new one,
+	 * so the pool remains stable.
+	 */
+	new_page = alloc_fresh_huge_page(h, gfp_mask, nid, NULL, NULL);
+	if (new_page) {
+		/*
+		 * Free it into the hugepage allocator
+		 */
+		put_page(new_page);
+
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
+	/*
+	 * The page might have been dissolved from under our feet.
+	 * If that is the case, return success as if we dissolved it ourselves.
+	 */
+	if (!h)
+		return true;
+
+	/*
+	 * Fence off gigantic pages as there is a cyclic dependency
+	 * between alloc_contig_range and them.
+	 */
+	if (hstate_is_gigantic(h))
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

