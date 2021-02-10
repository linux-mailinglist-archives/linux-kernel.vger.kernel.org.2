Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2183C3160EC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 09:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbhBJI0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 03:26:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44964 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233443AbhBJIZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 03:25:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612945447;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aB6w5KMqRZs4fASbYkKOZF5C6NqksMPRWk0Bw9OA14Q=;
        b=NA6/WV0yl/jwUs3wpgSYMh1nwE9uw9vB7Yw4PH5nRB2DdqTWzuuyUMY8D0vg4iRxHLpRPW
        RRImMByjO4tTs2UPPLghIHP4b5G5CiFtVuW6ZVd8kxSvx2AEv/N9FB4qWLhHlMnC8fkXBU
        sCrZuB1CyjvfpOpGOTGbn6vnVdE+4A0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-533-bBsgDbSGMsKuAwQuLSsIeg-1; Wed, 10 Feb 2021 03:24:03 -0500
X-MC-Unique: bBsgDbSGMsKuAwQuLSsIeg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3C885107ACC7;
        Wed, 10 Feb 2021 08:24:02 +0000 (UTC)
Received: from [10.36.113.218] (ovpn-113-218.ams2.redhat.com [10.36.113.218])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B30C26091B;
        Wed, 10 Feb 2021 08:24:00 +0000 (UTC)
To:     Oscar Salvador <osalvador@suse.de>,
        Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210208103812.32056-1-osalvador@suse.de>
 <20210208103812.32056-3-osalvador@suse.de>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: [RFC PATCH 2/2] mm,page_alloc: Make alloc_contig_range handle
 free hugetlb pages
Message-ID: <9ed946df-9c6c-9a4d-4be9-2f32809974f7@redhat.com>
Date:   Wed, 10 Feb 2021 09:23:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210208103812.32056-3-osalvador@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.02.21 11:38, Oscar Salvador wrote:
> Free hugetlb pages are trickier to handle as to in order to guarantee
> no userspace appplication disruption, we need to replace the
> current free hugepage with a new one.
> 
> In order to do that, a new function called alloc_and_dissolve_huge_page
> in introduced.
> This function will first try to get a new fresh hugetlb page, and if it
> succeeds, it will dissolve the old one.
>

Thanks for looking into this! Can we move this patch to #1 in the 
series? It is the easier case.

I also wonder if we should at least try on the memory unplug path to 
keep nr_pages by at least trying to allocate at new one if required, and 
printing a warning if that fails (after all, we're messing with 
something configured by the admin - "nr_pages"). Note that gigantic 
pages are special (below).

> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
>   include/linux/hugetlb.h |  6 ++++++
>   mm/compaction.c         | 11 +++++++++++
>   mm/hugetlb.c            | 35 +++++++++++++++++++++++++++++++++++
>   3 files changed, 52 insertions(+)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index ebca2ef02212..f81afcb86e89 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -505,6 +505,7 @@ struct huge_bootmem_page {
>   	struct hstate *hstate;
>   };
>   
> +bool alloc_and_dissolve_huge_page(struct page *page);
>   struct page *alloc_huge_page(struct vm_area_struct *vma,
>   				unsigned long addr, int avoid_reserve);
>   struct page *alloc_huge_page_nodemask(struct hstate *h, int preferred_nid,
> @@ -773,6 +774,11 @@ static inline void huge_ptep_modify_prot_commit(struct vm_area_struct *vma,
>   #else	/* CONFIG_HUGETLB_PAGE */
>   struct hstate {};
>   
> +static inline bool alloc_and_dissolve_huge_page(struct page *page)
> +{
> +	return false;
> +}
> +
>   static inline struct page *alloc_huge_page(struct vm_area_struct *vma,
>   					   unsigned long addr,
>   					   int avoid_reserve)
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 89cd2e60da29..7969ddc10856 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -952,6 +952,17 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>   					low_pfn += compound_nr(page) - 1;
>   					goto isolate_success_no_list;
>   				}
> +			} else {

} else if (alloc_and_dissolve_huge_page(page))) {

...

> +				/*
> +				 * Free hugetlb page. Allocate a new one and
> +				 * dissolve this is if succeed.
> +				 */
> +				if (alloc_and_dissolve_huge_page(page)) {
> +					unsigned long order = buddy_order_unsafe(page);
> +
> +					low_pfn += (1UL << order) - 1;
> +					continue;
> +				}



Note that there is a very ugly corner case we will have to handle 
gracefully (I think also in patch #1):

Assume you allocated a gigantic page (and assume that we are not using 
CMA for gigantic pages for simplicity). Assume you want to allocate 
another one. alloc_pool_huge_page()->...->alloc_contig_pages() will 
stumble over the first allocated page. It will try to 
alloc_and_dissolve_huge_page() the existing gigantic page. To do that, 
it will alloc_pool_huge_page()->...->alloc_contig_pages() ... and so on. 
Bad.

We really don't want to mess with gigantic pages (migrate, dissolve) 
while allocating a gigantic page. I think the easiest (and cleanest) way 
forward is to not mess (isolate, migrate, dissolve) with gigantic pages 
at all.

Gigantic pages are not movable, so they won't be placed on random CMA / 
ZONE_MOVABLE.

Some hstate_is_gigantic(h) calls (maybe inside 
alloc_and_dissolve_huge_page() ? ) along with a nice comment might be 
good enough to avoid having to pass down some kind of alloc_contig 
context. I even think that should be handled inside

(the main issue is that in contrast to CMA, plain alloc_contig_pages() 
has no memory about which parts were allocated and will simply try 
re-allocating what it previously allocated and never freed - which is 
usually fine, unless we're dealing with such special cases)

Apart from that, not messing with gigantic pages feels like the right 
approach (allocating/migrating gigantic pages is just horribly slow and 
most probably not worth it anyway).

-- 
Thanks,

David / dhildenb

