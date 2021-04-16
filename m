Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADE4361A44
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 09:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239287AbhDPHBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 03:01:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:49032 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238391AbhDPHA7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 03:00:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0B132AF28;
        Fri, 16 Apr 2021 07:00:34 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH v9 3/7] mm,hugetlb: Drop clearing of flag from prep_new_huge_page
Date:   Fri, 16 Apr 2021 09:00:19 +0200
Message-Id: <20210416070023.4742-4-osalvador@suse.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210416070023.4742-1-osalvador@suse.de>
References: <20210416070023.4742-1-osalvador@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pages allocated via the page allocator or CMA get its private field cleared
by means of post_alloc_hook().
Pages allocated during boot, that is directly from the memblock allocator,
get cleared by paging_init()->..->memmap_init_zone->..->__init_single_page()
before any memblock allocation.

Based on this ground, let us remove the clearing of the flag from
prep_new_huge_page() as it is not needed.
This was a leftover from 6c0371490140 ("hugetlb: convert PageHugeFreed
to HPageFreed flag"). Previously the explicit clearing was necessary
because compound allocations do not get this initialization
(see prep_compound_page).

Signed-off-by: Oscar Salvador <osalvador@suse.de>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 54d81d5947ed..2cb9fa79cbaa 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1493,7 +1493,6 @@ static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
 	spin_lock_irq(&hugetlb_lock);
 	h->nr_huge_pages++;
 	h->nr_huge_pages_node[nid]++;
-	ClearHPageFreed(page);
 	spin_unlock_irq(&hugetlb_lock);
 }
 
-- 
2.16.3

