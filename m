Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9AE341E03
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 14:21:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbhCSNUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 09:20:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:49632 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229862AbhCSNUW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 09:20:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 30453AE5C;
        Fri, 19 Mar 2021 13:20:21 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v6 5/5] mm,page_alloc: Drop unnecessary checks from pfn_range_valid_contig
Date:   Fri, 19 Mar 2021 14:20:04 +0100
Message-Id: <20210319132004.4341-6-osalvador@suse.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210319132004.4341-1-osalvador@suse.de>
References: <20210319132004.4341-1-osalvador@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pfn_range_valid_contig() bails out when it finds an in-use page or a
hugetlb page, among other things.
We can drop the in-use page check since __alloc_contig_pages can migrate
away those pages, and the hugetlb page check can go too since
isolate_migratepages_range is now capable of dealing with hugetlb pages.
Either way, those checks are racy so let the end function handle it
when the time comes.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
Suggested-by: David Hildenbrand <david@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 mm/page_alloc.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index ce6a14a446a4..516302b280de 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8685,12 +8685,6 @@ static bool pfn_range_valid_contig(struct zone *z, unsigned long start_pfn,
 
 		if (PageReserved(page))
 			return false;
-
-		if (page_count(page) > 0)
-			return false;
-
-		if (PageHuge(page))
-			return false;
 	}
 	return true;
 }
-- 
2.16.3

