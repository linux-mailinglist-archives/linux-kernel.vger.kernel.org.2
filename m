Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDD5B35D828
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 08:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbhDMGky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 02:40:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:42582 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229534AbhDMGkv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 02:40:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1618296031; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BbGxV0ae0JhOJ49pcOvtfZGV+l+VQAXuXZ/ER034yk8=;
        b=lohbHlsQlwbPpTIeX3QI09J6856iE5bloOlCNzJ62j+5NYb/Ii1AmBZVY6NxtOQw8flQvt
        NkNeRuUQn1M4YdnnXhHihINGMrAOnZJPo4+DIJpaE8JDFckUyGIPg2TRQlNLDuKTcKEgv+
        mWjR6gN86unSSjQT4LCOAzkpIyG+E4I=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5B90CAF0F;
        Tue, 13 Apr 2021 06:40:31 +0000 (UTC)
Date:   Tue, 13 Apr 2021 08:40:30 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Minchan Kim <minchan@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 resend] mm/memory_hotplug: Make unpopulated zones PCP
 structures unreachable during hot remove
Message-ID: <YHU83jawLzKu+N2P@dhcp22.suse.cz>
References: <20210412120842.GY3697@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210412120842.GY3697@techsingularity.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 12-04-21 13:08:42, Mel Gorman wrote:
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

Yes, that is the case since ec6e8c7e0314 ("mm, page_alloc: disable
pcplists during memory offline"). Prior to this commit the behavior was
undefined but full zone/node hotremove is rare enough that an existing
race was likely never observed.

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!
 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
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

-- 
Michal Hocko
SUSE Labs
