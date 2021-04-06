Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7CDC355815
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 17:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233161AbhDFPfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 11:35:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47376 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242518AbhDFPeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 11:34:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617723233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UllT1wJZcz9S7vr+x2CExpW1HWLr0CCgm56mVvgBvoA=;
        b=BzprzjZdtvMh/shRyydmjzoyFfgb++FSp3bJzdrH9mrmEmYYITXnBXI8MmLB8Ewl4Q90bd
        3XiDsO7MBdHOiWkwUYYuedTD8mIIiKWZwXRlYx5xD9WuW8Fsf0f3ZUVQ52jEFES4wk4N3g
        CsIlXGN0rqgRONJ9ggduAIaer88XU8s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-531-YwRlmJ2YOdKvCANKKOlSDA-1; Tue, 06 Apr 2021 11:33:51 -0400
X-MC-Unique: YwRlmJ2YOdKvCANKKOlSDA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2C0391084C83;
        Tue,  6 Apr 2021 15:33:49 +0000 (UTC)
Received: from [10.36.113.79] (ovpn-113-79.ams2.redhat.com [10.36.113.79])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 23D035C729;
        Tue,  6 Apr 2021 15:33:46 +0000 (UTC)
Subject: Re: [PATCH v6 3/8] mm,memory_hotplug: Factor out adjusting present
 pages into adjust_present_page_count()
To:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210406111115.8953-1-osalvador@suse.de>
 <20210406111115.8953-4-osalvador@suse.de>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <f2682c45-1a7d-cefa-ccf1-af54898421f1@redhat.com>
Date:   Tue, 6 Apr 2021 17:33:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210406111115.8953-4-osalvador@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.04.21 13:11, Oscar Salvador wrote:
> From: David Hildenbrand <david@redhat.com>
> 
> Let's have a single place (inspired by adjust_managed_page_count()) where
> we adjust present pages, to prepare for additional bookkeeping.

Maybe in the context of this series, remove the "additional bookkeeping" 
part.

> In contrast to adjust_managed_page_count(), only memory onlining/offlining
> is allowed to modify the number of present pages.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> ---
>   mm/memory_hotplug.c | 22 ++++++++++++----------
>   1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 5fe3e3942b19..7411f6b5287d 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -829,6 +829,16 @@ struct zone * zone_for_pfn_range(int online_type, int nid, unsigned start_pfn,
>   	return default_zone_for_pfn(nid, start_pfn, nr_pages);
>   }
>   
> +static void adjust_present_page_count(struct zone *zone, long nr_pages)
> +{
> +	unsigned long flags;
> +
> +	zone->present_pages += nr_pages;
> +	pgdat_resize_lock(zone->zone_pgdat, &flags);
> +	zone->zone_pgdat->node_present_pages += nr_pages;
> +	pgdat_resize_unlock(zone->zone_pgdat, &flags);
> +}
> +
>   int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
>   		       int online_type, int nid)
>   {
> @@ -881,11 +891,7 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
>   	}
>   
>   	online_pages_range(pfn, nr_pages);
> -	zone->present_pages += nr_pages;
> -
> -	pgdat_resize_lock(zone->zone_pgdat, &flags);
> -	zone->zone_pgdat->node_present_pages += nr_pages;
> -	pgdat_resize_unlock(zone->zone_pgdat, &flags);
> +	adjust_present_page_count(zone, nr_pages);
>   
>   	node_states_set_node(nid, &arg);
>   	if (need_zonelists_rebuild)
> @@ -1699,11 +1705,7 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
>   
>   	/* removal success */
>   	adjust_managed_page_count(pfn_to_page(start_pfn), -nr_pages);
> -	zone->present_pages -= nr_pages;
> -
> -	pgdat_resize_lock(zone->zone_pgdat, &flags);
> -	zone->zone_pgdat->node_present_pages -= nr_pages;
> -	pgdat_resize_unlock(zone->zone_pgdat, &flags);
> +	adjust_present_page_count(zone, -nr_pages);
>   
>   	init_per_zone_wmark_min();
>   
> 


-- 
Thanks,

David / dhildenb

