Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38EF736086F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 13:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232658AbhDOLnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 07:43:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:44214 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230190AbhDOLnT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 07:43:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1618486976; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZxvJbfkWzNPA4y8TM5w+ufaw7NwfQQ+gZ7nfkT3HSSU=;
        b=erm68Nk3sewm7NX5iM2VCsgdh05X3/Zwz4C68LHbYdiOaanmZlJ/RfeLY+qkPhHavd7jI/
        FHihJ8u+p+Zio6xGd5Or+LBvNG8hm5hyZNz/yRgydIk2aM/PAryyHSglShEWxswMiPdGpg
        F3izSIdO5zViP0KdH6bocp+6QghcMmc=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 465C9AE56;
        Thu, 15 Apr 2021 11:42:56 +0000 (UTC)
Date:   Thu, 15 Apr 2021 13:42:55 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 7/7] mm,page_alloc: Drop unnecessary checks from
 pfn_range_valid_contig
Message-ID: <YHgmv68CC9hC8GEI@dhcp22.suse.cz>
References: <20210415103544.6791-1-osalvador@suse.de>
 <20210415103544.6791-8-osalvador@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210415103544.6791-8-osalvador@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 15-04-21 12:35:44, Oscar Salvador wrote:
> pfn_range_valid_contig() bails out when it finds an in-use page or a
> hugetlb page, among other things.
> We can drop the in-use page check since __alloc_contig_pages can migrate
> away those pages, and the hugetlb page check can go too since
> isolate_migratepages_range is now capable of dealing with hugetlb pages.
> Either way, those checks are racy so let the end function handle it
> when the time comes.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Acked-by: Mike Kravetz <mike.kravetz@oracle.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/page_alloc.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index b5a94de3cdde..c5338e912ace 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -8901,12 +8901,6 @@ static bool pfn_range_valid_contig(struct zone *z, unsigned long start_pfn,
>  
>  		if (PageReserved(page))
>  			return false;
> -
> -		if (page_count(page) > 0)
> -			return false;
> -
> -		if (PageHuge(page))
> -			return false;
>  	}
>  	return true;
>  }
> -- 
> 2.16.3

-- 
Michal Hocko
SUSE Labs
