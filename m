Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00D163282D4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 16:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237458AbhCAPxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 10:53:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:58172 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237394AbhCAPxV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 10:53:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614613950; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J8aNPfcrByRMnbgjPkO4YD4mA4esidLDQxdZhSdcPUE=;
        b=BtmPBL9eZIBj17BSbuu8ZnGI06iA3+Rs6WmNS+GygDjx/RLHRj7VrE0HBdFqugSOWCfZqh
        uWY5xM6V344UgKDZOrBhooX+HiN7pKxTbo/Vd3iH2d1aIa64peclLR6XiJRyZ77xe7c2Kw
        DO0P3WuaeoDNGLTdEj4umY2M0CTAaW4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 12E7EAF54;
        Mon,  1 Mar 2021 15:52:30 +0000 (UTC)
Date:   Mon, 1 Mar 2021 16:52:28 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v1] mm/page_alloc: drop pr_info_ratelimited() in
 alloc_contig_range()
Message-ID: <YD0NvDz8F4MPmMjk@dhcp22.suse.cz>
References: <20210301150945.77012-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210301150945.77012-1-david@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 01-03-21 16:09:45, David Hildenbrand wrote:
> The information that some PFNs are busy is:
> a) not helpful for ordinary users: we don't even know *who* called
>    alloc_contig_range(). This is certainly not worth a pr_info.*().
> b) not really helpful for debugging: we don't have any details *why*
>    these PFNs are busy, and that is what we usually care about.
> c) not complete: there are other cases where we fail alloc_contig_range()
>    using different paths that are not getting recorded.
> 
> For example, we reach this path once we succeeded in isolating pageblocks,
> but failed to migrate some pages - which can happen easily on
> ZONE_NORMAL (i.e., has_unmovable_pages() is racy) but also on ZONE_MOVABLE
> i.e., we would have to retry longer to migrate).
> 
> For example via virtio-mem when unplugging memory, we can create quite
> some noise (especially with ZONE_NORMAL) that is not of interest to
> users - it's expected that some allocations may fail as memory is busy.
> 
> Let's just drop that pr_info_ratelimit() and rather implement a dynamic
> debugging mechanism in the future that can give us a better reason why
> alloc_contig_range() failed on specific pages.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/page_alloc.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 519a60d5b6f7..efb924fb13e8 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -8647,8 +8647,6 @@ int alloc_contig_range(unsigned long start, unsigned long end,
>  
>  	/* Make sure the range is really isolated. */
>  	if (test_pages_isolated(outer_start, end, 0)) {
> -		pr_info_ratelimited("%s: [%lx, %lx) PFNs busy\n",
> -			__func__, outer_start, end);
>  		ret = -EBUSY;
>  		goto done;
>  	}
> -- 
> 2.29.2

-- 
Michal Hocko
SUSE Labs
