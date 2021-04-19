Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0CA5363D0E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 09:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238042AbhDSHzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 03:55:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:39294 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238058AbhDSHy5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 03:54:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 87CC3AEB3;
        Mon, 19 Apr 2021 07:54:27 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v10 4/7] mm,hugetlb: Split prep_new_huge_page functionality
Date:   Mon, 19 Apr 2021 09:54:10 +0200
Message-Id: <20210419075413.1064-5-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20210419075413.1064-1-osalvador@suse.de>
References: <20210419075413.1064-1-osalvador@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, prep_new_huge_page() performs two functions.
It sets the right state for a new hugetlb, and increases the hstate's
counters to account for the new page.

Let us split its functionality into two separate functions, decoupling
the handling of the counters from initializing a hugepage.
The outcome is having __prep_new_huge_page(), which only
initializes the page , and __prep_account_new_huge_page(), which adds
the new page to the hstate's counters.

This allows us to be able to set a hugetlb without having to worry
about the counter/locking. It will prove useful in the next patch.
prep_new_huge_page() still calls both functions.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 mm/hugetlb.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 2cb9fa79cbaa..6f39ec79face 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1483,16 +1483,30 @@ void free_huge_page(struct page *page)
 	}
 }
 
-static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
+/*
+ * Must be called with the hugetlb lock held
+ */
+static void __prep_account_new_huge_page(struct hstate *h, int nid)
+{
+	lockdep_assert_held(&hugetlb_lock);
+	h->nr_huge_pages++;
+	h->nr_huge_pages_node[nid]++;
+}
+
+static void __prep_new_huge_page(struct page *page)
 {
 	INIT_LIST_HEAD(&page->lru);
 	set_compound_page_dtor(page, HUGETLB_PAGE_DTOR);
 	hugetlb_set_page_subpool(page, NULL);
 	set_hugetlb_cgroup(page, NULL);
 	set_hugetlb_cgroup_rsvd(page, NULL);
+}
+
+static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
+{
+	__prep_new_huge_page(page);
 	spin_lock_irq(&hugetlb_lock);
-	h->nr_huge_pages++;
-	h->nr_huge_pages_node[nid]++;
+	__prep_account_new_huge_page(h, nid);
 	spin_unlock_irq(&hugetlb_lock);
 }
 
-- 
2.16.3

