Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82CAC33F27D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 15:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231643AbhCQOXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 10:23:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:41398 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231562AbhCQOXA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 10:23:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615990979; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hJZJQ8McgcLqhmV4lTLgUeWAHRAD2n58aQMbQhzih7I=;
        b=vZMNbbh1KOl1d2kF5e6qI+Hpi0dlwt6xMCTnXY3I3O4t8Un8MgyRX4x04t6oHG5M5gnO0d
        diSWHvsShphqGmaqKQLqcq2zmRc/lI0/rIbiTd6EWhoERtjkeXJn7xFE5PI6cOpTVjUenP
        yTBMtRJFhHYUHrT2s8qxcQgyGL4e9HU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 22BC0AD72;
        Wed, 17 Mar 2021 14:22:59 +0000 (UTC)
Date:   Wed, 17 Mar 2021 15:22:58 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/5] mm: Make alloc_contig_range handle free hugetlb
 pages
Message-ID: <YFIQwlt0ndU0R05z@dhcp22.suse.cz>
References: <20210317111251.17808-1-osalvador@suse.de>
 <20210317111251.17808-4-osalvador@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210317111251.17808-4-osalvador@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 17-03-21 12:12:49, Oscar Salvador wrote:
> alloc_contig_range will fail if it ever sees a HugeTLB page within the
> range we are trying to allocate, even when that page is free and can be
> easily reallocated.
> This has proved to be problematic for some users of alloc_contic_range,
> e.g: CMA and virtio-mem, where those would fail the call even when those
> pages lay in ZONE_MOVABLE and are free.
> 
> We can do better by trying to replace such page.
> 
> Free hugepages are tricky to handle so as to no userspace application
> notices disruption, we need to replace the current free hugepage with
> a new one.
> 
> In order to do that, a new function called alloc_and_dissolve_huge_page
> is introduced.
> This function will first try to get a new fresh hugepage, and if it
> succeeds, it will replace the old one in the free hugepage pool.
> 
> All operations are being handled under hugetlb_lock, so no races are

Slightly confusing because allocation which is a part of the process is
certainly not done under the lock.
"The free page replacement is done under hugetlb_lock, so no external
user of hugetlb will notice the change. There is one tricky case when
page's refcount is 0 because it is in the process of being released.
A mising PageHugeFreed bit will tell us that freeing is in flight so we
retry after dropping the hugetlb_lock. The race window should be small
and the next retry should make a forward progress.

> possible. The only exception is when page's refcount is 0, but it still
> has not been flagged as PageHugeFreed.
> E.g, below scenario:
> 
> CPU0				CPU1
> __free_huge_page()		isolate_or_dissolve_huge_page
> 				  PageHuge() == T
> 				  alloc_and_dissolve_huge_page
> 				    alloc_fresh_huge_page()
> 				    spin_lock(hugetlb_lock)
> 				    // PageHuge() && !PageHugeFreed &&
> 				    // !PageCount()
> 				    spin_unlock(hugetlb_lock)
>   spin_lock(hugetlb_lock)
>   1) update_and_free_page
>        PageHuge() == F
>        __free_pages()
>   2) enqueue_huge_page
>        SetPageHugeFreed()
>   spin_unlock(&hugetlb_lock)
> 				  spin_lock(hugetlb_lock)
>                                    1) PageHuge() == F (freed by case#1 from CPU0)
> 				   2) PageHuge() == T
>                                        PageHugeFreed() == T
>                                        - proceed with replacing the page
> 
> In the case above we retry as the window race is quite small and we have high
> chances to succeed next time.
> 
> With regard to the allocation, we restrict it to the node the page belongs
> to with __GFP_THISNODE, meaning we do not fallback on other node's zones.
> 
> Note that gigantic hugetlb pages are fenced off since there is a cyclic
> dependency between them and alloc_contig_range.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
> Acked-by: Michal Hocko <mhocko@suse.com>

my ack still applies.
-- 
Michal Hocko
SUSE Labs
