Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2233BE4B5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 10:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbhGGIx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 04:53:27 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:40484 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbhGGIx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 04:53:26 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B6B732003F;
        Wed,  7 Jul 2021 08:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1625647845; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CjPSVe+JcATwl+mTh/cMUbmmA1jVuqsHEJ4EAY3GkiA=;
        b=XMQs/DbKNkbKMcxhmLfss1zUa8YfEzWzVpaNPi7qSx8Dih7G0NRpDUx35I7gbXiuTBFqb1
        xilQjZarez3shhtEJ1psvee8XY7guo+ujiDKIi/S7Sb6QLM7uDaMz5kXESsUJO46kobrRo
        TOx7J2jHfZlQ1Rus80MeoSInJY4oNzo=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4B308A3B8A;
        Wed,  7 Jul 2021 08:50:45 +0000 (UTC)
Date:   Wed, 7 Jul 2021 10:50:44 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 1/2] mm/vmalloc: Use batched page requests in
 bulk-allocator
Message-ID: <YOVq5EEOEemvZiOi@dhcp22.suse.cz>
References: <20210705170537.43060-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210705170537.43060-1-urezki@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 05-07-21 19:05:36, Uladzislau Rezki (Sony) wrote:
> In case of simultaneous vmalloc allocations, for example it is 1GB and
> 12 CPUs my system is able to hit "BUG: soft lockup" for !CONFIG_PREEMPT
> kernel.
> 
> <snip>
> [   62.512621] RIP: 0010:__alloc_pages_bulk+0xa9f/0xbb0
> [   62.512628] Code: ff 8b 44 24 48 44 29 f8 83 f8 01 0f 84 ea fe ff ff e9 07 f6 ff ff 48 8b 44 24 60 48 89 28 e9 00 f9 ff ff fb 66 0f 1f 44 00 00 <e9> e8 fd ff ff 65 48 01 51 10 e9 3e fe ff ff 48 8b 44 24 78 4d 89
> [   62.512629] RSP: 0018:ffffa7bfc29ffd20 EFLAGS: 00000206
> [   62.512631] RAX: 0000000000000200 RBX: ffffcd5405421888 RCX: ffff8c36ffdeb928
> [   62.512632] RDX: 0000000000040000 RSI: ffffa896f06b2ff8 RDI: ffffcd5405421880
> [   62.512633] RBP: ffffcd5405421880 R08: 000000000000007d R09: ffffffffffffffff
> [   62.512634] R10: ffffffff9d63c084 R11: 00000000ffffffff R12: ffff8c373ffaeb80
> [   62.512635] R13: ffff8c36ffdf65f8 R14: ffff8c373ffaeb80 R15: 0000000000040000
> [   62.512637] FS:  0000000000000000(0000) GS:ffff8c36ffdc0000(0000) knlGS:0000000000000000
> [   62.512638] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   62.512639] CR2: 000055c8e2fe8610 CR3: 0000000c13e10000 CR4: 00000000000006e0
> [   62.512641] Call Trace:
> [   62.512646]  __vmalloc_node_range+0x11c/0x2d0
> [   62.512649]  ? full_fit_alloc_test+0x140/0x140 [test_vmalloc]
> [   62.512654]  __vmalloc_node+0x4b/0x70
> [   62.512656]  ? fix_size_alloc_test+0x44/0x60 [test_vmalloc]
> [   62.512659]  fix_size_alloc_test+0x44/0x60 [test_vmalloc]
> [   62.512662]  test_func+0xe7/0x1f0 [test_vmalloc]
> [   62.512666]  ? fix_align_alloc_test+0x50/0x50 [test_vmalloc]
> [   62.512668]  kthread+0x11a/0x140
> [   62.512671]  ? set_kthread_struct+0x40/0x40
> [   62.512672]  ret_from_fork+0x22/0x30
> <snip>
> 
> To address this issue invoke a bulk-allocator many times until all pages
> are obtained, i.e. do batched page requests adding cond_resched() meanwhile
> to reschedule. Batched value is hard-coded and is 100 pages per call.

Yes, this makes perfect sense to me. I would just be more explicit that
this is an artificially created problem likely not being a problem at
the moment but why not to prepare for a future.

> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Acked-by: Michal Hocko <mhocko@suse.com>


Thanks!
> ---
>  mm/vmalloc.c | 30 ++++++++++++++++++++++++++----
>  1 file changed, 26 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index aaad569e8963..5297958ac7c5 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2785,10 +2785,32 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>  	 * to fails, fallback to a single page allocator that is
>  	 * more permissive.
>  	 */
> -	if (!order)
> -		nr_allocated = alloc_pages_bulk_array_node(
> -			gfp, nid, nr_pages, pages);
> -	else
> +	if (!order) {
> +		while (nr_allocated < nr_pages) {
> +			int nr, nr_pages_request;
> +
> +			/*
> +			 * A maximum allowed request is hard-coded and is 100
> +			 * pages per call. That is done in order to prevent a
> +			 * long preemption off scenario in the bulk-allocator
> +			 * so the range is [1:100].
> +			 */
> +			nr_pages_request = min(100, (int)(nr_pages - nr_allocated));
> +
> +			nr = alloc_pages_bulk_array_node(gfp, nid,
> +				nr_pages_request, pages + nr_allocated);
> +
> +			nr_allocated += nr;
> +			cond_resched();
> +
> +			/*
> +			 * If zero or pages were obtained partly,
> +			 * fallback to a single page allocator.
> +			 */
> +			if (nr != nr_pages_request)
> +				break;
> +		}
> +	} else
>  		/*
>  		 * Compound pages required for remap_vmalloc_page if
>  		 * high-order pages.
> -- 
> 2.20.1

-- 
Michal Hocko
SUSE Labs
