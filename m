Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFB3834029B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 11:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbhCRJ73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 05:59:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:44656 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229894AbhCRJ7P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 05:59:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E76FEAC1E;
        Thu, 18 Mar 2021 09:59:13 +0000 (UTC)
Date:   Thu, 18 Mar 2021 10:59:10 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/5] mm: Make alloc_contig_range handle in-use hugetlb
 pages
Message-ID: <YFMkbuUbsLti5P6a@localhost.localdomain>
References: <20210317111251.17808-1-osalvador@suse.de>
 <20210317111251.17808-5-osalvador@suse.de>
 <YFIRqtEt4ecfu1TN@dhcp22.suse.cz>
 <YFMVKSrSQCdUQy+p@localhost.localdomain>
 <YFMdlaXBGrZFRpQQ@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFMdlaXBGrZFRpQQ@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 10:29:57AM +0100, Michal Hocko wrote:
> On Thu 18-03-21 09:54:01, Oscar Salvador wrote:
> [...]
> > @@ -2287,10 +2288,12 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page)
> >  		goto unlock;
> >  	} else if (page_count(old_page)) {
> >  		/*
> > -		 * Someone has grabbed the page, fail for now.
> > +		 * Someone has grabbed the page, try to isolate it here.
> > +		 * Fail with -EBUSY if not possible.
> >  		 */
> > -		ret = -EBUSY;
> >  		update_and_free_page(h, new_page);
> > +		if (!isolate_huge_page(old_page, list)
> > +			ret = -EBUSY;
> >  		goto unlock;
> >  	} else if (!HPageFreed(old_page)) {
> 
> I do not think you want to call isolate_huge_page with hugetlb_lock
> held. You would need to drop the lock before calling isolate_huge_page.

Yeah, that was an oversight. As I said I did not compile it(let alone
test it), otherwise the system would have screamed I guess.

I was more interested in knowing whether how did it look wrt. retry
concerns:

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index bcff86ca616f..a37b4ce86e58 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -583,7 +583,7 @@ struct huge_bootmem_page {
 	struct hstate *hstate;
 };

-int isolate_or_dissolve_huge_page(struct page *page);
+int isolate_or_dissolve_huge_page(struct page *page, struct list_head *list);
 struct page *alloc_huge_page(struct vm_area_struct *vma,
 				unsigned long addr, int avoid_reserve);
 struct page *alloc_huge_page_nodemask(struct hstate *h, int preferred_nid,
@@ -866,7 +866,8 @@ static inline void huge_ptep_modify_prot_commit(struct vm_area_struct *vma,
 #else	/* CONFIG_HUGETLB_PAGE */
 struct hstate {};

-static inline int isolate_or_dissolve_huge_page(struct page *page)
+static inline int isolate_or_dissolve_huge_page(struct page *page,
+						struct list_head *list)
 {
 	return -ENOMEM;
 }
diff --git a/mm/compaction.c b/mm/compaction.c
index 9f253fc3b4f9..6e47855fd154 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -910,7 +910,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 		}

 		if (PageHuge(page) && cc->alloc_contig) {
-			ret = isolate_or_dissolve_huge_page(page);
+			ret = isolate_or_dissolve_huge_page(page, &cc->migratepages);

 			/*
 			 * Fail isolation in case isolate_or_dissolve_huge_page
@@ -927,6 +927,15 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 				goto isolate_fail;
 			}

+			if (PageHuge(page)) {
+				/*
+				 * Hugepage was successfully isolated and placed
+				 * on the cc->migratepages list.
+				 */
+				low_pfn += compound_nr(page) - 1;
+				goto isolate_success_no_list;
+			}
+
 			/*
 			 * Ok, the hugepage was dissolved. Now these pages are
 			 * Buddy and cannot be re-allocated because they are
@@ -1068,6 +1077,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,

 isolate_success:
 		list_add(&page->lru, &cc->migratepages);
+isolate_success_no_list:
 		cc->nr_migratepages += compound_nr(page);
 		nr_isolated += compound_nr(page);

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 3194c1bd9e32..f55fa6acc6f9 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2257,7 +2257,8 @@ static void restore_reserve_on_error(struct hstate *h,
  * Returns 0 on success, otherwise negated error.
  */

-static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page)
+static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
+					struct list_head *list)
 {
 	gfp_t gfp_mask = htlb_alloc_mask(h) | __GFP_THISNODE;
 	int nid = page_to_nid(old_page);
@@ -2287,10 +2288,14 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page)
 		goto unlock;
 	} else if (page_count(old_page)) {
 		/*
-		 * Someone has grabbed the page, fail for now.
+		 * Someone has grabbed the page, try to isolate it here.
+		 * Fail with -EBUSY if not possible.
 		 */
-		ret = -EBUSY;
 		update_and_free_page(h, new_page);
+		spin_unlock(&hugetlb_lock);
+		if (!isolate_huge_page(old_page, list)
+			ret = -EBUSY;
+		spin_lock(&hugetlb_lock);
 		goto unlock;
 	} else if (!HPageFreed(old_page)) {
 		/*
@@ -2319,10 +2324,11 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page)
 	return ret;
 }

-int isolate_or_dissolve_huge_page(struct page *page)
+int isolate_or_dissolve_huge_page(struct page *page, struct list_head *list)
 {
 	struct hstate *h;
 	struct page *head;
+	int ret = -EBUSY;

 	/*
 	 * The page might have been dissolved from under our feet, so make sure
@@ -2347,7 +2353,12 @@ int isolate_or_dissolve_huge_page(struct page *page)
 	if (hstate_is_gigantic(h))
 		return -ENOMEM;

-	return alloc_and_dissolve_huge_page(h, head);
+	if (page_count(head) && isolate_huge_page(head, list))
+		ret = 0;
+	else if (!page_count(head))
+		ret = alloc_and_dissolve_huge_page(h, head, list);
+
+	return ret;
 }

 struct page *alloc_huge_page(struct vm_area_struct *vma,
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 562e87cbd7a1..42aaef30633e 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1507,8 +1507,9 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
 	LIST_HEAD(clean_pages);

 	list_for_each_entry_safe(page, next, page_list, lru) {
-		if (page_is_file_lru(page) && !PageDirty(page) &&
-		    !__PageMovable(page) && !PageUnevictable(page)) {
+		if (!PageHuge(page) && page_is_file_lru(page) &&
+		    !PageDirty(page) && !__PageMovable(page) &&
+		    !PageUnevictable(page)) {
 			ClearPageActive(page);
 			list_move(&page->lru, &clean_pages);
 		}


The spin_lock after the isolate_huge_page() in
alloc_and_dissolve_huge_page() could probably be spared by placing a
goto out directly before the return.
But just a POC.

-- 
Oscar Salvador
SUSE L3
