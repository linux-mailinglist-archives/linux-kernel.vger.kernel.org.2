Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C91D03C13E8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 15:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbhGHNNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 09:13:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51888 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230080AbhGHNNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 09:13:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625749829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Su19WDhoU/YXgcv3TtubE0a9+gNAyxVy+Jnc8J4aC5U=;
        b=JxmLJoVKxFTxguND4YNL6NuuiGGZbXAh8OWgN3HHrJ6b8A0y8c4IYsCAeq7DfipnsdaJt3
        1U2a58crcCslIZAIGMYr3BqJ9ydd7khfMvb8LAud4Kt8w7gSGP/hOhqZwJ0mkEAge4ABAJ
        AqfJWfr1r1DUmhRWQSQj5ZgRE7dBaSo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-584-GX00-M0UPyaJOTd3kjjI3A-1; Thu, 08 Jul 2021 09:10:26 -0400
X-MC-Unique: GX00-M0UPyaJOTd3kjjI3A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 690E5192CC6B;
        Thu,  8 Jul 2021 13:10:24 +0000 (UTC)
Received: from optiplex-fbsd (unknown [10.3.128.11])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D9231E2F7;
        Thu,  8 Jul 2021 13:10:21 +0000 (UTC)
Date:   Thu, 8 Jul 2021 09:10:18 -0400
From:   Rafael Aquini <aquini@redhat.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        Zqiang <qiang.zhang@windriver.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+127fd7828d6eeb611703@syzkaller.appspotmail.com
Subject: Re: [PATCH] mm/page_alloc: Avoid page allocator recursion with
 pagesets.lock held
Message-ID: <YOb5OrkqjWu4TODN@optiplex-fbsd>
References: <20210708081434.GV3840@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210708081434.GV3840@techsingularity.net>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 08, 2021 at 09:14:34AM +0100, Mel Gorman wrote:
> Syzbot is reporting potential deadlocks due to pagesets.lock when
> PAGE_OWNER is enabled. One example from Desmond Cheong Zhi Xi is
> as follows
> 
>   __alloc_pages_bulk()
>     local_lock_irqsave(&pagesets.lock, flags) <---- outer lock here
>     prep_new_page():
>       post_alloc_hook():
>         set_page_owner():
>           __set_page_owner():
>             save_stack():
>               stack_depot_save():
>                 alloc_pages():
>                   alloc_page_interleave():
>                     __alloc_pages():
>                       get_page_from_freelist():
>                         rm_queue():
>                           rm_queue_pcplist():
>                             local_lock_irqsave(&pagesets.lock, flags);
>                             *** DEADLOCK ***
> 
> Zhang, Qiang also reported
> 
>   BUG: sleeping function called from invalid context at mm/page_alloc.c:5179
>   in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 1, name: swapper/0
>   .....
>   __dump_stack lib/dump_stack.c:79 [inline]
>   dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:96
>   ___might_sleep.cold+0x1f1/0x237 kernel/sched/core.c:9153
>   prepare_alloc_pages+0x3da/0x580 mm/page_alloc.c:5179
>   __alloc_pages+0x12f/0x500 mm/page_alloc.c:5375
>   alloc_page_interleave+0x1e/0x200 mm/mempolicy.c:2147
>   alloc_pages+0x238/0x2a0 mm/mempolicy.c:2270
>   stack_depot_save+0x39d/0x4e0 lib/stackdepot.c:303
>   save_stack+0x15e/0x1e0 mm/page_owner.c:120
>   __set_page_owner+0x50/0x290 mm/page_owner.c:181
>   prep_new_page mm/page_alloc.c:2445 [inline]
>   __alloc_pages_bulk+0x8b9/0x1870 mm/page_alloc.c:5313
>   alloc_pages_bulk_array_node include/linux/gfp.h:557 [inline]
>   vm_area_alloc_pages mm/vmalloc.c:2775 [inline]
>   __vmalloc_area_node mm/vmalloc.c:2845 [inline]
>   __vmalloc_node_range+0x39d/0x960 mm/vmalloc.c:2947
>   __vmalloc_node mm/vmalloc.c:2996 [inline]
>   vzalloc+0x67/0x80 mm/vmalloc.c:3066
> 
> There are a number of ways it could be fixed. The page owner code could
> be audited to strip GFP flags that allow sleeping but it'll impair the
> functionality of PAGE_OWNER if allocations fail. The bulk allocator
> could add a special case to release/reacquire the lock for prep_new_page
> and lookup PCP after the lock is reacquired at the cost of performance.
> The patches requiring prep could be tracked using the least significant
> bit and looping through the array although it is more complicated for
> the list interface. The options are relatively complex and the second
> one still incurs a performance penalty when PAGE_OWNER is active so this
> patch takes the simple approach -- disable bulk allocation of PAGE_OWNER is
                                                            ^^^^
Minor nit: s/of/if

> active. The caller will be forced to allocate one page at a time incurring
> a performance penalty but PAGE_OWNER is already a performance penalty.
> 
> Fixes: dbbee9d5cd83 ("mm/page_alloc: convert per-cpu list protection to local_lock")
> Reported-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
> Reported-by: "Zhang, Qiang" <Qiang.Zhang@windriver.com>
> Reported-and-tested-by: syzbot+127fd7828d6eeb611703@syzkaller.appspotmail.com
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> ---
>  mm/page_alloc.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 3b97e17806be..6ef86f338151 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5239,6 +5239,18 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
>  	if (nr_pages - nr_populated == 1)
>  		goto failed;
>  
> +#ifdef CONFIG_PAGE_OWNER
> +	/*
> +	 * PAGE_OWNER may recurse into the allocator to allocate space to
> +	 * save the stack with pagesets.lock held. Releasing/reacquiring
> +	 * removes much of the performance benefit of bulk allocation so
> +	 * force the caller to allocate one page at a time as it'll have
> +	 * similar performance to added complexity to the bulk allocator.
> +	 */
> +	if (static_branch_unlikely(&page_owner_inited))
> +		goto failed;
> +#endif
> +
>  	/* May set ALLOC_NOFRAGMENT, fragmentation will return 1 page. */
>  	gfp &= gfp_allowed_mask;
>  	alloc_gfp = gfp;
> 
Acked-by: Rafael Aquini <aquini@redhat.com>

