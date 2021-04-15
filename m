Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6A50360869
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 13:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbhDOLmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 07:42:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:40090 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230190AbhDOLmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 07:42:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1618486915; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AWTd6/m39oUkBJNSJE/HcyD5g317S23D1lc5xsrQSqU=;
        b=kN0KZ311irOy1r/ebS07SxvLArmpSGA7tXgukgChcYaIhqBMflXvyWDqzn4PrO4FZOzU7T
        bMG3K9f7+u8mFA+8ykHLozY4yZE9V+I1Gou3HVAsZnU8WxpHDRtL4lQ3PYnUNtO4Mbl34d
        Yfjjy9XUbLxv0hSqMcaiCyrdCjbvFvQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 33686AF11;
        Thu, 15 Apr 2021 11:41:55 +0000 (UTC)
Date:   Thu, 15 Apr 2021 13:41:54 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 3/7] mm,hugetlb: Drop clearing of flag from
 prep_new_huge_page
Message-ID: <YHgmgtJRadMB2c5k@dhcp22.suse.cz>
References: <20210415103544.6791-1-osalvador@suse.de>
 <20210415103544.6791-4-osalvador@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210415103544.6791-4-osalvador@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 15-04-21 12:35:40, Oscar Salvador wrote:
> Pages allocated after boot get its private field cleared by means
> of post_alloc_hook().

You surely meant to say s@boot@page/cma allocator@ here

> Pages allocated during boot, that is directly from the memblock allocator,
> get cleared by paging_init()->..->memmap_init_zone->..->__init_single_page()
> before any memblock allocation.
> 
> Based on this ground, let us remove the clearing of the flag from
> prep_new_huge_page() as it is not needed.

I would also mention that this is a leftover from 6c0371490140
("hugetlb: convert PageHugeFreed to HPageFreed flag"). Previously the
explicit clearing was necessary because compound allocations do not get
this initialization (see prep_compound_page).

> Signed-off-by: Oscar Salvador <osalvador@suse.de>

with that
Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/hugetlb.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 54d81d5947ed..2cb9fa79cbaa 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1493,7 +1493,6 @@ static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
>  	spin_lock_irq(&hugetlb_lock);
>  	h->nr_huge_pages++;
>  	h->nr_huge_pages_node[nid]++;
> -	ClearHPageFreed(page);
>  	spin_unlock_irq(&hugetlb_lock);
>  }
>  
> -- 
> 2.16.3

-- 
Michal Hocko
SUSE Labs
