Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2050535DCC1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 12:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343946AbhDMKsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 06:48:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:52830 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245104AbhDMKsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 06:48:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5D0B3B130;
        Tue, 13 Apr 2021 10:48:03 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v7 3/7] mm,hugetlb: Clear HPageFreed outside of the lock
Date:   Tue, 13 Apr 2021 12:47:43 +0200
Message-Id: <20210413104747.12177-4-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20210413104747.12177-1-osalvador@suse.de>
References: <20210413104747.12177-1-osalvador@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the clearing of the flag is done under the lock, but this
is unnecessary as we just allocated the page and we did not give it
away yet, so no one should be messing with it.

Also, this helps making clear that here the lock is only protecting the
counter.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/hugetlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 54d81d5947ed..e40d5fe5c63c 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1490,10 +1490,10 @@ static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
 	hugetlb_set_page_subpool(page, NULL);
 	set_hugetlb_cgroup(page, NULL);
 	set_hugetlb_cgroup_rsvd(page, NULL);
+	ClearHPageFreed(page);
 	spin_lock_irq(&hugetlb_lock);
 	h->nr_huge_pages++;
 	h->nr_huge_pages_node[nid]++;
-	ClearHPageFreed(page);
 	spin_unlock_irq(&hugetlb_lock);
 }
 
-- 
2.16.3

