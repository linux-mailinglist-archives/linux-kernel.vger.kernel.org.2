Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04FA63D9369
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 18:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbhG1Qpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 12:45:52 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:58592 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbhG1Qpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 12:45:51 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id E0AC122332;
        Wed, 28 Jul 2021 16:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1627490748; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I4kQI0znLqLVVTW/73drb4OCrBjSeGIiwx6TpMRNhvw=;
        b=OtOWzic9yUr6KdYRiYwZEIS8FBl3sUIrCOO41dU9gfruHKh9uRpCpzqGjATC3WGmGga4JD
        0WJfgpdLkxHFEH60v8a6GGLaQOLlxRN4jVqtudoEcuXQnYFPT8zzR7DYHf0UYUOgY/OSId
        3LJJrerHykDjRS0u4gKAWLQoK3wXAvU=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 79AB9A3B83;
        Wed, 28 Jul 2021 16:45:48 +0000 (UTC)
Date:   Wed, 28 Jul 2021 18:45:48 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>,
        Wang Hai <wanghai38@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] slub: fix unreclaimable slab stat for bulk free
Message-ID: <YQGJvF8NffbCKT2x@dhcp22.suse.cz>
References: <20210728155354.3440560-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210728155354.3440560-1-shakeelb@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 28-07-21 08:53:54, Shakeel Butt wrote:
> SLUB uses page allocator for higher order allocations and update
> unreclaimable slab stat for such allocations. At the moment, the bulk
> free for SLUB does not share code with normal free code path for these
> type of allocations and have missed the stat update. So, fix the stat
> update by common code. The user visible impact of the bug is the
> potential of inconsistent unreclaimable slab stat visible through
> meminfo and vmstat.
> 
> Fixes: 6a486c0ad4dc ("mm, sl[ou]b: improve memory accounting")
> Signed-off-by: Shakeel Butt <shakeelb@google.com>

LGTM
Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/slub.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 6dad2b6fda6f..03770291aa6b 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3238,6 +3238,16 @@ struct detached_freelist {
>  	struct kmem_cache *s;
>  };
>  
> +static inline void free_nonslab_page(struct page *page)
> +{
> +	unsigned int order = compound_order(page);
> +
> +	VM_BUG_ON_PAGE(!PageCompound(page), page);
> +	kfree_hook(page_address(page));
> +	mod_lruvec_page_state(page, NR_SLAB_UNRECLAIMABLE_B, -(PAGE_SIZE << order));
> +	__free_pages(page, order);
> +}
> +
>  /*
>   * This function progressively scans the array with free objects (with
>   * a limited look ahead) and extract objects belonging to the same
> @@ -3274,9 +3284,7 @@ int build_detached_freelist(struct kmem_cache *s, size_t size,
>  	if (!s) {
>  		/* Handle kalloc'ed objects */
>  		if (unlikely(!PageSlab(page))) {
> -			BUG_ON(!PageCompound(page));
> -			kfree_hook(object);
> -			__free_pages(page, compound_order(page));
> +			free_nonslab_page(page);
>  			p[size] = NULL; /* mark object processed */
>  			return size;
>  		}
> @@ -4252,13 +4260,7 @@ void kfree(const void *x)
>  
>  	page = virt_to_head_page(x);
>  	if (unlikely(!PageSlab(page))) {
> -		unsigned int order = compound_order(page);
> -
> -		BUG_ON(!PageCompound(page));
> -		kfree_hook(object);
> -		mod_lruvec_page_state(page, NR_SLAB_UNRECLAIMABLE_B,
> -				      -(PAGE_SIZE << order));
> -		__free_pages(page, order);
> +		free_nonslab_page(page);
>  		return;
>  	}
>  	slab_free(page->slab_cache, page, object, NULL, 1, _RET_IP_);
> -- 
> 2.32.0.432.gabb21c7263-goog

-- 
Michal Hocko
SUSE Labs
