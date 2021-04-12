Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E27C935C670
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 14:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241124AbhDLMkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 08:40:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:51360 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238587AbhDLMki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 08:40:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 976F3AC6A;
        Mon, 12 Apr 2021 12:40:19 +0000 (UTC)
To:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Oscar Salvador <osalvador@suse.de>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20210412120842.GY3697@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v2 resend] mm/memory_hotplug: Make unpopulated zones PCP
 structures unreachable during hot remove
Message-ID: <d4e4c3e4-7d47-d634-4374-4cf1e55c7895@suse.cz>
Date:   Mon, 12 Apr 2021 14:40:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210412120842.GY3697@techsingularity.net>
Content-Type:   text/plain; charset=US-ASCII
Content-Language: en-US
Content-Transfer-Encoding: 7BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/12/21 2:08 PM, Mel Gorman wrote:
> zone_pcp_reset allegedly protects against a race with drain_pages
> using local_irq_save but this is bogus. local_irq_save only operates
> on the local CPU. If memory hotplug is running on CPU A and drain_pages
> is running on CPU B, disabling IRQs on CPU A does not affect CPU B and
> offers no protection.
> 
> This patch deletes IRQ disable/enable on the grounds that IRQs protect
> nothing and assumes the existing hotplug paths guarantees the PCP cannot be
> used after zone_pcp_enable(). That should be the case already because all
> the pages have been freed and there is no page to put on the PCP lists.
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Yeah the irq disabling here is clearly bogus, so:

Acked-by: Vlastimil Babka <vbabka@suse.cz>

But I think Michal has a point that we might best leave the pagesets around, by
a future change. I'm have some doubts that even with your reordering of the
reset/destroy after zonelist rebuild in v1 they cant't be reachable. We have no
protection between zonelist rebuild and zonelist traversal, and that's why we
just leave pgdats around.

So I can imagine a task racing with memory hotremove might see watermarks as ok
in get_page_from_freelist() for the zone and proceeds to try_this_zone:, then
gets stalled/scheduled out while hotremove rebuilds the zonelist and destroys
the pcplists, then the first task is resumed and proceeds with rmqueue_pcplist().

So that's very rare thus not urgent, and this patch doesn't make it less rare so
not a reason to block it.

> ---
> Resending for email address correction and adding lists
> 
> Changelog since v1
> o Minimal fix
> 
>  mm/page_alloc.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 5e8aedb64b57..9bf0db982f14 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -8952,12 +8952,9 @@ void zone_pcp_enable(struct zone *zone)
>  
>  void zone_pcp_reset(struct zone *zone)
>  {
> -	unsigned long flags;
>  	int cpu;
>  	struct per_cpu_pageset *pset;
>  
> -	/* avoid races with drain_pages()  */
> -	local_irq_save(flags);
>  	if (zone->pageset != &boot_pageset) {
>  		for_each_online_cpu(cpu) {
>  			pset = per_cpu_ptr(zone->pageset, cpu);
> @@ -8966,7 +8963,6 @@ void zone_pcp_reset(struct zone *zone)
>  		free_percpu(zone->pageset);
>  		zone->pageset = &boot_pageset;
>  	}
> -	local_irq_restore(flags);
>  }
>  
>  #ifdef CONFIG_MEMORY_HOTREMOVE
> 

