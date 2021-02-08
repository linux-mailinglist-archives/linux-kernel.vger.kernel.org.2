Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9327D312F74
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 11:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbhBHKtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 05:49:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:57660 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232344AbhBHKi7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 05:38:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2109AAEB3;
        Mon,  8 Feb 2021 10:38:16 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [RFC PATCH 2/2] mm,page_alloc: Make alloc_contig_range handle free hugetlb pages
Date:   Mon,  8 Feb 2021 11:38:12 +0100
Message-Id: <20210208103812.32056-3-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20210208103812.32056-1-osalvador@suse.de>
References: <20210208103812.32056-1-osalvador@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Free hugetlb pages are trickier to handle as to in order to guarantee
no userspace appplication disruption, we need to replace the
current free hugepage with a new one.

In order to do that, a new function called alloc_and_dissolve_huge_page
in introduced.
This function will first try to get a new fresh hugetlb page, and if it
succeeds, it will dissolve the old one.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 include/linux/hugetlb.h |  6 ++++++
 mm/compaction.c         | 11 +++++++++++
 mm/hugetlb.c            | 35 +++++++++++++++++++++++++++++++++++
 3 files changed, 52 insertions(+)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index ebca2ef02212..f81afcb86e89 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -505,6 +505,7 @@ struct huge_bootmem_page {
 	struct hstate *hstate;
 };
 
+bool alloc_and_dissolve_huge_page(struct page *page);
 struct page *alloc_huge_page(struct vm_area_struct *vma,
 				unsigned long addr, int avoid_reserve);
 struct page *alloc_huge_page_nodemask(struct hstate *h, int preferred_nid,
@@ -773,6 +774,11 @@ static inline void huge_ptep_modify_prot_commit(struct vm_area_struct *vma,
 #else	/* CONFIG_HUGETLB_PAGE */
 struct hstate {};
 
+static inline bool alloc_and_dissolve_huge_page(struct page *page)
+{
+	return false;
+}
+
 static inline struct page *alloc_huge_page(struct vm_area_struct *vma,
 					   unsigned long addr,
 					   int avoid_reserve)
diff --git a/mm/compaction.c b/mm/compaction.c
index 89cd2e60da29..7969ddc10856 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -952,6 +952,17 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 					low_pfn += compound_nr(page) - 1;
 					goto isolate_success_no_list;
 				}
+			} else {
+				/*
+				 * Free hugetlb page. Allocate a new one and
+				 * dissolve this is if succeed.
+				 */
+				if (alloc_and_dissolve_huge_page(page)) {
+					unsigned long order = buddy_order_unsafe(page);
+
+					low_pfn += (1UL << order) - 1;
+					continue;
+				}
 			}
 			goto isolate_fail;
 		}
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 18f6ee317900..79ffbb64c4ee 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2253,6 +2253,41 @@ static void restore_reserve_on_error(struct hstate *h,
 	}
 }
 
+bool alloc_and_dissolve_huge_page(struct page *page)
+{
+	NODEMASK_ALLOC(nodemask_t, nodes_allowed, GFP_KERNEL);
+	struct page *head;
+	struct hstate *h;
+	bool ret = false;
+	int nid;
+
+	if (!nodes_allowed)
+		return ret;
+
+	spin_lock(&hugetlb_lock);
+	head = compound_head(page);
+	h = page_hstate(head);
+	nid = page_to_nid(head);
+	spin_unlock(&hugetlb_lock);
+
+	init_nodemask_of_node(nodes_allowed, nid);
+
+	/*
+	 * Before dissolving the page, we need to allocate a new one,
+	 * so the pool remains stable.
+	 */
+	if (alloc_pool_huge_page(h, nodes_allowed, NULL)) {
+		/*
+		 * Ok, we have a free hugetlb-page to replace this
+		 * one. Dissolve the old page.
+		 */
+		if (!dissolve_free_huge_page(page))
+			ret = true;
+	}
+
+	return ret;
+}
+
 struct page *alloc_huge_page(struct vm_area_struct *vma,
 				    unsigned long addr, int avoid_reserve)
 {
-- 
2.16.3

