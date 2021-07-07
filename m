Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7E63BE4B8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 10:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbhGGIyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 04:54:04 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:52266 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbhGGIyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 04:54:04 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 749EC225C9;
        Wed,  7 Jul 2021 08:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1625647883; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Na5evhOsPxdyk72/iMdkQgvxgJL+H66b/attKNc3EDA=;
        b=MgtFim01IVbQXdnFPyFxUGGjIy5X8tThXCwGmxd/3aH5jzoQCkgj9zlFPa5l1xQD0rIba2
        /R3+FBCiv5ZlQpNzbPM2TdtlJnuGxxYnkrYs5gddR7bdB6JUIq1bAy1go1tkryf1+bP7fy
        oborxHQ6IgFSKtyAN/6ZneEuKFxFhHo=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 3765BA3B9C;
        Wed,  7 Jul 2021 08:51:23 +0000 (UTC)
Date:   Wed, 7 Jul 2021 10:51:22 +0200
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
Subject: Re: [PATCH v2 2/2] mm/vmalloc: Remove gfpflags_allow_blocking() check
Message-ID: <YOVrCs9Uxt8zcHgR@dhcp22.suse.cz>
References: <20210705170537.43060-1-urezki@gmail.com>
 <20210705170537.43060-2-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210705170537.43060-2-urezki@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 05-07-21 19:05:37, Uladzislau Rezki (Sony) wrote:
> Get rid of gfpflags_allow_blocking() check from the vmalloc() path
> as it is supposed to be sleepable anyway. Thus remove it from the
> alloc_vmap_area() as well as from the vm_area_alloc_pages().
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/vmalloc.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 5297958ac7c5..93a9cbdba905 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -1479,6 +1479,7 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
>  				int node, gfp_t gfp_mask)
>  {
>  	struct vmap_area *va;
> +	unsigned long freed;
>  	unsigned long addr;
>  	int purged = 0;
>  	int ret;
> @@ -1542,13 +1543,12 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
>  		goto retry;
>  	}
>  
> -	if (gfpflags_allow_blocking(gfp_mask)) {
> -		unsigned long freed = 0;
> -		blocking_notifier_call_chain(&vmap_notify_list, 0, &freed);
> -		if (freed > 0) {
> -			purged = 0;
> -			goto retry;
> -		}
> +	freed = 0;
> +	blocking_notifier_call_chain(&vmap_notify_list, 0, &freed);
> +
> +	if (freed > 0) {
> +		purged = 0;
> +		goto retry;
>  	}
>  
>  	if (!(gfp_mask & __GFP_NOWARN) && printk_ratelimit())
> @@ -2834,9 +2834,7 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>  		for (i = 0; i < (1U << order); i++)
>  			pages[nr_allocated + i] = page + i;
>  
> -		if (gfpflags_allow_blocking(gfp))
> -			cond_resched();
> -
> +		cond_resched();
>  		nr_allocated += 1U << order;
>  	}
>  
> -- 
> 2.20.1

-- 
Michal Hocko
SUSE Labs
