Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2EC35DCC7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 12:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344160AbhDMKtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 06:49:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:53048 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343870AbhDMKsc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 06:48:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id ED229B176;
        Tue, 13 Apr 2021 10:48:06 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v7 7/7] mm,page_alloc: Drop unnecessary checks from pfn_range_valid_contig
Date:   Tue, 13 Apr 2021 12:47:47 +0200
Message-Id: <20210413104747.12177-8-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20210413104747.12177-1-osalvador@suse.de>
References: <20210413104747.12177-1-osalvador@suse.de>
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
index b5a94de3cdde..c5338e912ace 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8901,12 +8901,6 @@ static bool pfn_range_valid_contig(struct zone *z, unsigned long start_pfn,
 
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

