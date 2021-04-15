Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BDC836073E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 12:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232367AbhDOKg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 06:36:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:49482 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232173AbhDOKgP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 06:36:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EC1FBB21D;
        Thu, 15 Apr 2021 10:35:51 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH v8 4/7] mm,hugetlb: Split prep_new_huge_page functionality
Date:   Thu, 15 Apr 2021 12:35:41 +0200
Message-Id: <20210415103544.6791-5-osalvador@suse.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210415103544.6791-1-osalvador@suse.de>
References: <20210415103544.6791-1-osalvador@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

