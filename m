Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03129346492
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 17:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233176AbhCWQLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 12:11:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:32896 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233017AbhCWQLE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 12:11:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616515863; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EBzFai2/9UHXdLCg+ptfPYt+b4h1PCkVbj2YlqjJF+8=;
        b=dhX7AXuqSadfv+l2TtEdZwG20UOhZKzHOfIDUXc1uC1dklJdwR0cpzCZr/v0yU+rMjWEMl
        Dc1hidPn1rhLPYxPxOz6SvEdgc/+oFMDFU0JWRGMbbYT3can7CstaOIrmNxn180qb7FmdY
        wfkzEvjh2zJT7GB+PIlb2KRMcbq1XLE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1111AADAA;
        Tue, 23 Mar 2021 16:11:03 +0000 (UTC)
Date:   Tue, 23 Mar 2021 17:11:00 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     guro@fb.com, hannes@cmpxchg.org, akpm@linux-foundation.org,
        shakeelb@google.com, vdavydov.dev@gmail.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com
Subject: Re: [PATCH] mm: memcontrol: fix memsw uncharge for root_mem_cgroup
Message-ID: <YFoTFJ349TqzYx40@dhcp22.suse.cz>
References: <20210323145653.25684-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323145653.25684-1-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 23-03-21 22:56:53, Muchun Song wrote:
> The pages aren't accounted at the root level, so we cannot uncharge the
> page to the memsw counter for the root memcg. Fix this.

The patch is correct but I do wonder whether this matters much in the
end. We shouldn't really rely on a correct page counter for the root
memcg AFAICS in the kernel. We do not display the value
(mem_cgroup_usage) so there shouldn't be any actual problem. Unless I am
missing something make sure to spell that out in the changelog.

> Fixes: 1f47b61fb407 ("mm: memcontrol: fix swap counter leak on swapout from offline cgroup")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Acked-by: Michal Hocko <mhocko@suse.com>
> ---
>  mm/memcontrol.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 533b4b31b464..7d765a106684 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -7155,7 +7155,8 @@ void mem_cgroup_swapout(struct page *page, swp_entry_t entry)
>  	if (!cgroup_memory_noswap && memcg != swap_memcg) {
>  		if (!mem_cgroup_is_root(swap_memcg))
>  			page_counter_charge(&swap_memcg->memsw, nr_entries);
> -		page_counter_uncharge(&memcg->memsw, nr_entries);
> +		if (!mem_cgroup_is_root(memcg))
> +			page_counter_uncharge(&memcg->memsw, nr_entries);
>  	}
>  
>  	/*
> -- 
> 2.11.0

-- 
Michal Hocko
SUSE Labs
