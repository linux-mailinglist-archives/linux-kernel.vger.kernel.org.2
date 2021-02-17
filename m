Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4006D31DC2F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 16:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233737AbhBQPcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 10:32:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:57478 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233708AbhBQPZT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 10:25:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613574403; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k6dBzKXy/EXV9qFYBWQcgPsAD8tD43VtG3457euIWxw=;
        b=AV3SrKn4DQSEjgAbawUctdUOlcP+ZuByCkMtRa9sBy0Hsw25DvHD55WRYRNuPyL4BDyhsy
        Xt7CWRh7XfP4ZpCMYJWKufuKaWdOgVk6RU4Ie8rS6Uaj+U+9Nye5wCcNhqwXug96K4g/E3
        cqTmkguZyQtleYn8VQdwkK189cVAwJo=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 090BAB8FE;
        Wed, 17 Feb 2021 15:06:43 +0000 (UTC)
Date:   Wed, 17 Feb 2021 16:06:42 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm: Make alloc_contig_range handle in-use hugetlb
 pages
Message-ID: <YC0xAmuJLJ6yNbCD@dhcp22.suse.cz>
References: <20210217100816.28860-1-osalvador@suse.de>
 <20210217100816.28860-3-osalvador@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210217100816.28860-3-osalvador@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 17-02-21 11:08:16, Oscar Salvador wrote:
> In-use hugetlb pages can be migrated as any other page (LRU
> and Movable), so let alloc_contig_range handle them.
> 
> All we need is to succesfully isolate such page.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
>  include/linux/hugetlb.h |  5 +++--
>  mm/compaction.c         | 11 ++++++++++-
>  mm/hugetlb.c            |  6 ++++--
>  mm/vmscan.c             |  5 +++--
>  4 files changed, 20 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 72352d718829..8c17d0dbc87c 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -505,7 +505,7 @@ struct huge_bootmem_page {
>  	struct hstate *hstate;
>  };
>  
> -bool isolate_or_dissolve_huge_page(struct page *page);
> +bool isolate_or_dissolve_huge_page(struct page *page, struct list_head *list);
>  struct page *alloc_huge_page(struct vm_area_struct *vma,
>  				unsigned long addr, int avoid_reserve);
>  struct page *alloc_huge_page_nodemask(struct hstate *h, int preferred_nid,
> @@ -776,7 +776,8 @@ void set_page_huge_active(struct page *page);
>  #else	/* CONFIG_HUGETLB_PAGE */
>  struct hstate {};
>  
> -static inline bool isolate_or_dissolve_huge_page(struct page *page)
> +static inline bool isolate_or_dissolve_huge_page(struct page *page,
> +						 struct list_head *list)
>  {
>  	return false;
>  }
> diff --git a/mm/compaction.c b/mm/compaction.c
> index d52506ed9db7..55a41a9228a9 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -906,9 +906,17 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>  		}
>  
>  		if (PageHuge(page) && cc->alloc_contig) {
> -			if (!isolate_or_dissolve_huge_page(page))
> +			if (!isolate_or_dissolve_huge_page(page, &cc->migratepages))
>  				goto isolate_fail;
>  
> +			if (PageHuge(page)) {
> +				/*
> +				 * Hugepage was succesfully isolated.
> +				 */
> +				low_pfn += compound_nr(page) - 1;
> +				goto isolate_success_no_list;
> +			}
> +
>  			/*
>  			 * Ok, the hugepage was dissolved. Now these pages are
>  			 * Buddy and cannot be re-allocated because they are
> @@ -1053,6 +1061,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>  
>  isolate_success:
>  		list_add(&page->lru, &cc->migratepages);
> +isolate_success_no_list:
>  		cc->nr_migratepages += compound_nr(page);

I do not follow. You have successfully isolated huge pages so why don't
you add that page to the migratepages list to be migrated?
-- 
Michal Hocko
SUSE Labs
