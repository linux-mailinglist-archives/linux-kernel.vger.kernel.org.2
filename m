Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD46436559D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 11:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbhDTJlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 05:41:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:44450 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229937AbhDTJlW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 05:41:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1618911650; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ISg7e+JkeB3CvE9TQuR+dfKDLHA8lmXq7TDVEpR7Mgo=;
        b=HWPmlZftGFx3CKPVNnHNN7B+CMURDvW8o3b4OwaFx+MWuH0085ACoaFfmdFfTjWlg2VF4R
        dbOPdLFj5UUxOX0c+LbS6OvuMBum6FoOIJbMJ00zDKqn8J+2CX+Mi1rDaOD3vhn/MT2q+0
        NE0St2D23IYhN0sxI7mNnyexRVmnCOw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BC42BAC3E;
        Tue, 20 Apr 2021 09:40:50 +0000 (UTC)
Date:   Tue, 20 Apr 2021 11:40:50 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 2/8] mm,memory_hotplug: Relax fully spanned sections
 check
Message-ID: <YH6hoieSEFtSUfMQ@dhcp22.suse.cz>
References: <20210416112411.9826-1-osalvador@suse.de>
 <20210416112411.9826-3-osalvador@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416112411.9826-3-osalvador@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 16-04-21 13:24:05, Oscar Salvador wrote:
> When using self-hosted vmemmap pages, the number of pages passed to
> {online,offline}_pages might not fully span sections, but they always
> fully span pageblocks.
> Relax the check account for that case.

It would be good to call those out explicitly.  It would be also
great to explain why pageblock_nr_pages is an actual constrain. There
shouldn't be any real reason for that except for "we want online_pages
to operate on whole memblocks and memmap_on_memory will poke
pageblock_nr_pages aligned holes in the beginning which is a special
case we want to allow."

> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> Reviewed-by: David Hildenbrand <david@redhat.com>

With the changelog extended and the comment clarification (se below)
feel free to add
Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/memory_hotplug.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 0cdbbfbc5757..25e59d5dc13c 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -838,9 +838,14 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
>  	int ret;
>  	struct memory_notify arg;
>  
> -	/* We can only online full sections (e.g., SECTION_IS_ONLINE) */
> +	/* We can only offline full sections (e.g., SECTION_IS_ONLINE).
> +	 * However, when using e.g: memmap_on_memory, some pages are initialized
> +	 * prior to calling in here. The remaining amount of pages must be
> +	 * pageblock aligned.


I would rephrase (and also note that multi line comment usually have a
leading line without any content - not that I care much though).

	/*
	 * {on,off}lining is constrained to full memory sections (or
	 * more precisly to memory blocks from the user space POV).
	 * memmap_on_memory is an exception because it reserves initial
	 * part of the physical memory space for vmemmaps. That space is
	 * pageblock aligned.
> +	 */

Same comment would apply to oofline_pages.

>  	if (WARN_ON_ONCE(!nr_pages ||
> -			 !IS_ALIGNED(pfn | nr_pages, PAGES_PER_SECTION)))
> +			 !IS_ALIGNED(pfn, pageblock_nr_pages) ||
> +			 !IS_ALIGNED(pfn + nr_pages, PAGES_PER_SECTION)))
>  		return -EINVAL;
>  
>  	mem_hotplug_begin();
> @@ -1573,9 +1578,14 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
>  	int ret, node;
>  	char *reason;
>  
> -	/* We can only offline full sections (e.g., SECTION_IS_ONLINE) */
> +	/* We can only offline full sections (e.g., SECTION_IS_ONLINE).
> +	 * However, when using e.g: memmap_on_memory, some pages are initialized
> +	 * prior to calling in here. The remaining amount of pages must be
> +	 * pageblock aligned.
> +	 */
>  	if (WARN_ON_ONCE(!nr_pages ||
> -			 !IS_ALIGNED(start_pfn | nr_pages, PAGES_PER_SECTION)))
> +			 !IS_ALIGNED(start_pfn, pageblock_nr_pages) ||
> +			 !IS_ALIGNED(start_pfn + nr_pages, PAGES_PER_SECTION)))
>  		return -EINVAL;
>  
>  	mem_hotplug_begin();
> -- 
> 2.16.3

-- 
Michal Hocko
SUSE Labs
