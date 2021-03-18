Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1863409E0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 17:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbhCRQQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 12:16:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:34198 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231929AbhCRQQD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 12:16:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616084162; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wFutwNBa2WeIFmYM5lIk90CePKHrTcZXcZh3QqcNmZQ=;
        b=LoqwPlOjhiwLkAAbgKJz7q4XhteJEV3BOHqeEdy55YWjvtY1XHcQ8rB8RiSTODP9Fy5UeF
        e7qUGEjCD70BOhGT0MwlIgDGAlv+YMIV/Lah548nRIrPlSnK8biW7S9wkuUO5KyJCzcrvH
        OFVxn1pB0OYonh/vPG6FcTpORqFahF4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 54B5FAB8C;
        Thu, 18 Mar 2021 16:16:02 +0000 (UTC)
Date:   Thu, 18 Mar 2021 17:16:01 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Aaron Tomlin <atomlin@redhat.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: try oom if reclaim is unable to make
 forward progress
Message-ID: <YFN8wXwJA59w9twA@dhcp22.suse.cz>
References: <20210315165837.789593-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210315165837.789593-1-atomlin@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 15-03-21 16:58:37, Aaron Tomlin wrote:
> In the situation where direct reclaim is required to make progress for
> compaction but no_progress_loops is already over the limit of
> MAX_RECLAIM_RETRIES consider invoking the oom killer.

What is the problem you are trying to fix?

> 
> Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
> ---
>  mm/page_alloc.c | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 7a2c89b21115..8d748b1b8d1e 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4181,6 +4181,16 @@ __alloc_pages_direct_compact(gfp_t gfp_mask, unsigned int order,
>  	return NULL;
>  }
>  
> +static inline bool
> +should_try_oom(int no_progress_loops,
> +		enum compact_result last_compact_result)
> +{
> +	if (no_progress_loops > MAX_RECLAIM_RETRIES && last_compact_result
> +			== COMPACT_SKIPPED)
> +		return true;
> +	return false;
> +}
> +
>  static inline bool
>  should_compact_retry(struct alloc_context *ac, int order, int alloc_flags,
>  		     enum compact_result compact_result,
> @@ -4547,10 +4557,11 @@ should_reclaim_retry(gfp_t gfp_mask, unsigned order,
>  	 * Make sure we converge to OOM if we cannot make any progress
>  	 * several times in the row.
>  	 */
> -	if (*no_progress_loops > MAX_RECLAIM_RETRIES) {
> -		/* Before OOM, exhaust highatomic_reserve */
> -		return unreserve_highatomic_pageblock(ac, true);
> -	}
> +	if (*no_progress_loops > MAX_RECLAIM_RETRIES)
> +		result false;
> +	/* Last chance before OOM, try draining highatomic_reserve once */
> +	else if (*no_progress_loops == MAX_RECLAIM_RETRIES)
> +		return unreserve_highatomic_pageblock(ac, true)
>  
>  	/*
>  	 * Keep reclaiming pages while there is a chance this will lead
> @@ -4822,6 +4833,8 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>  				 did_some_progress > 0, &no_progress_loops))
>  		goto retry;
>  
> +	if (should_try_oom(no_progress_loops, compact_result))
> +		goto oom:
>  	/*
>  	 * It doesn't make any sense to retry for the compaction if the order-0
>  	 * reclaim is not able to make any progress because the current
> @@ -4839,6 +4852,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>  	if (check_retry_cpuset(cpuset_mems_cookie, ac))
>  		goto retry_cpuset;
>  
> +oom:
>  	/* Reclaim has failed us, start killing things */
>  	page = __alloc_pages_may_oom(gfp_mask, order, ac, &did_some_progress);
>  	if (page)
> -- 
> 2.26.2
> 

-- 
Michal Hocko
SUSE Labs
