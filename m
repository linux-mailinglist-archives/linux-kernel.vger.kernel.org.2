Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57AF035DCC4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 12:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343910AbhDMKs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 06:48:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:52872 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343819AbhDMKsY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 06:48:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 40277B158;
        Tue, 13 Apr 2021 10:48:04 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v7 4/7] mm,hugetlb: Split prep_new_huge_page functionality
Date:   Tue, 13 Apr 2021 12:47:44 +0200
Message-Id: <20210413104747.12177-5-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20210413104747.12177-1-osalvador@suse.de>
References: <20210413104747.12177-1-osalvador@suse.de>
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
---
 mm/hugetlb.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index e40d5fe5c63c..0607b2b71ac6 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1483,7 +1483,16 @@ void free_huge_page(struct page *page)
 	}
 }
 
-static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
+/*
+ * Must be called with the hugetlb lock held
+ */
+static void __prep_account_new_huge_page(struct hstate *h, int nid)
+{
+	h->nr_huge_pages++;
+	h->nr_huge_pages_node[nid]++;
+}
+
+static void __prep_new_huge_page(struct page *page)
 {
 	INIT_LIST_HEAD(&page->lru);
 	set_compound_page_dtor(page, HUGETLB_PAGE_DTOR);
@@ -1491,9 +1500,13 @@ static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
 	set_hugetlb_cgroup(page, NULL);
 	set_hugetlb_cgroup_rsvd(page, NULL);
 	ClearHPageFreed(page);
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

