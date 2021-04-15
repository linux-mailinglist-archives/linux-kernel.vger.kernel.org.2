Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F18D36073D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 12:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbhDOKgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 06:36:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:49530 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232134AbhDOKgO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 06:36:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2AE4AAD09;
        Thu, 15 Apr 2021 10:35:51 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v8 3/7] mm,hugetlb: Drop clearing of flag from prep_new_huge_page
Date:   Thu, 15 Apr 2021 12:35:40 +0200
Message-Id: <20210415103544.6791-4-osalvador@suse.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210415103544.6791-1-osalvador@suse.de>
References: <20210415103544.6791-1-osalvador@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pages allocated after boot get its private field cleared by means
of post_alloc_hook().
Pages allocated during boot, that is directly from the memblock allocator,
get cleared by paging_init()->..->memmap_init_zone->..->__init_single_page()
before any memblock allocation.

Based on this ground, let us remove the clearing of the flag from
prep_new_huge_page() as it is not needed.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
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

