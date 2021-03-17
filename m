Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2889033EE04
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 11:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbhCQKFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 06:05:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:35036 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229767AbhCQKF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 06:05:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0D497AC1F;
        Wed, 17 Mar 2021 10:05:26 +0000 (UTC)
Date:   Wed, 17 Mar 2021 11:05:23 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH v4 0/4] Make alloc_contig_range handle Hugetlb pages
Message-ID: <20210317100518.GA16479@linux>
References: <20210310150853.13541-1-osalvador@suse.de>
 <c7ba5bba-77fb-6c43-2067-2ebc83b014da@redhat.com>
 <b04aaf5534f9ec0a40937e23a2500fdf@suse.de>
 <01d2ee6a-f0aa-4580-b1f4-f0e8a2ded4f8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01d2ee6a-f0aa-4580-b1f4-f0e8a2ded4f8@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 10:48:31AM +0100, David Hildenbrand wrote:
> > I was preparing v5, and I wanted to be sure I understood you here.
> > 
> > Right you are that the in-use page check can be dropped, as those pages
> > can
> > be migrated away, and the Hugetlb page check can also be dropped since
> > isolate_migratepages_range is now capable of dealing with those kind of
> > pages.
> > 
> > > b) Similarly, check for gigantic pages and/or movability/migratability.
> > 
> > I lost you here.
> > 
> > isolate_or_dissolve_huge_page() already bails out on hugetlb-gigantic
> > pages.
> > 
> > Or do you mean to place an upfront check here? (hstate_is_gigantic())?
> 
> Yes. But I prefer a) and keeping it simple here -- just doing basic sanity
> checks (online, zone, PageReserved()) that are absolutely necessary.

Ok, I am probably dense as I understood as if you were lean towards having
a) + b).

That is what I have as the last patch of the patchset:

From e97175b7d4970cbdcbafcf8c398f72a571e817b0 Mon Sep 17 00:00:00 2001
From: Oscar Salvador <osalvador@suse.de>
Date: Thu, 18 Mar 2021 05:03:18 +0100
Subject: [PATCH] mm,page_alloc: Drop unnecesary checks from
 pfn_range_valid_contig

pfn_range_valid_contig() bails out when it finds an in-use page or a
hugetlb page, among other things.
We can drop the in-use page check since __alloc_contig_pages can migrate
away those pages, and the hugetlb page check can go too since
isolate_migratepages_range is now capable of dealing with hugetlb pages.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/page_alloc.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 4cb455355f6d..50d73e68b79e 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8685,12 +8685,6 @@ static bool pfn_range_valid_contig(struct zone *z, unsigned long start_pfn,

                if (PageReserved(page))
                        return false;
-
-               if (page_count(page) > 0)
-                       return false;
-
-               if (PageHuge(page))
-                       return false;
        }
        return true;
 }

-- 
Oscar Salvador
SUSE L3
