Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4B7E34498B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 16:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbhCVPpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 11:45:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:35566 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230437AbhCVPoq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 11:44:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616427885; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=67HkjStPwpolY5HHSqjDUdChO7Wp0ODjEWqcUb8G5Ns=;
        b=qOO+WoV4nB5K8FNYEu1RzRrPQ5VN+lNHFqZoOEZQBg7x+Rad8ILVqtJ9AHFHB0Bkr1dqWf
        Y5jA88CyaVSyMav5laIXXesXp/HqP0W1vHjCpFSCC7x9ooFazdiZWtvy4xoeHWuK9LXpmc
        ZCZUZpNzxZRiBdH5Uq7HgR1NKMnktZg=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DF09DAC1F;
        Mon, 22 Mar 2021 15:44:44 +0000 (UTC)
Date:   Mon, 22 Mar 2021 16:44:44 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 5/5] mm,page_alloc: Drop unnecessary checks from
 pfn_range_valid_contig
Message-ID: <YFi7bCjBWmvNbgew@dhcp22.suse.cz>
References: <20210319132004.4341-1-osalvador@suse.de>
 <20210319132004.4341-6-osalvador@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319132004.4341-6-osalvador@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 19-03-21 14:20:04, Oscar Salvador wrote:
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

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/page_alloc.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index ce6a14a446a4..516302b280de 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -8685,12 +8685,6 @@ static bool pfn_range_valid_contig(struct zone *z, unsigned long start_pfn,
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
