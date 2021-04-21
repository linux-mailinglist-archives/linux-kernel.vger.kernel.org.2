Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44EF6366649
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 09:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236735AbhDUHe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 03:34:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:54786 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234038AbhDUHe5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 03:34:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1618990464; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Zly4Y5bY/7sVzFR1D7MJtPS/ysK81xWuNjbRZ79r6+w=;
        b=NXomZfSNfkrXR5oqhS+ficumz14UX3ZMVY54MUXmSxWVkw6HzkfjnsMhQPr4C6xqrT3fGM
        bYw5SZeMzJlFCSGqZaI91Z7nOz3ZrJ+/lt5IJMzh0Ud1pzwWKefbhpHU++PB+AaiPdbike
        bGaEDNgZ8rWiokCMH3sEgOZf1/2VNOg=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F2BB4B127;
        Wed, 21 Apr 2021 07:34:23 +0000 (UTC)
Date:   Wed, 21 Apr 2021 09:34:23 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     guro@fb.com, hannes@cmpxchg.org, akpm@linux-foundation.org,
        shakeelb@google.com, vdavydov.dev@gmail.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com
Subject: Re: [PATCH] mm: memcontrol: fix root_mem_cgroup charging
Message-ID: <YH/Vf8SDRy7VR7ur@dhcp22.suse.cz>
References: <20210421062644.68331-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421062644.68331-1-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 21-04-21 14:26:44, Muchun Song wrote:
> The below scenario can cause the page counters of the root_mem_cgroup
> to be out of balance.
> 
> CPU0:                                   CPU1:
> 
> objcg = get_obj_cgroup_from_current()
> obj_cgroup_charge_pages(objcg)
>                                         memcg_reparent_objcgs()
>                                             // reparent to root_mem_cgroup
>                                             WRITE_ONCE(iter->memcg, parent)
>     // memcg == root_mem_cgroup
>     memcg = get_mem_cgroup_from_objcg(objcg)
>     // do not charge to the root_mem_cgroup
>     try_charge(memcg)
> 
> obj_cgroup_uncharge_pages(objcg)
>     memcg = get_mem_cgroup_from_objcg(objcg)
>     // uncharge from the root_mem_cgroup
>     page_counter_uncharge(&memcg->memory)
> 
> This can cause the page counter to be less than the actual value,
> Although we do not display the value (mem_cgroup_usage) so there
> shouldn't be any actual problem, but there is a WARN_ON_ONCE in
> the page_counter_cancel(). Who knows if it will trigger? So it
> is better to fix it.

The changelog doesn't explain the fix and why you have chosen to charge
kmem objects to root memcg and left all other try_charge users intact.
The reason is likely that those are not reparented now but that just
adds an inconsistency.

Is there any reason you haven't simply matched obj_cgroup_uncharge_pages
to check for the root memcg and bail out early?

> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/memcontrol.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 1e68a9992b01..81b54bd9b9e0 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2686,8 +2686,8 @@ void mem_cgroup_handle_over_high(void)
>  	css_put(&memcg->css);
>  }
>  
> -static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
> -		      unsigned int nr_pages)
> +static int __try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
> +			unsigned int nr_pages)
>  {
>  	unsigned int batch = max(MEMCG_CHARGE_BATCH, nr_pages);
>  	int nr_retries = MAX_RECLAIM_RETRIES;
> @@ -2699,8 +2699,6 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  	bool drained = false;
>  	unsigned long pflags;
>  
> -	if (mem_cgroup_is_root(memcg))
> -		return 0;
>  retry:
>  	if (consume_stock(memcg, nr_pages))
>  		return 0;
> @@ -2880,6 +2878,15 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  	return 0;
>  }
>  
> +static inline int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
> +			     unsigned int nr_pages)
> +{
> +	if (mem_cgroup_is_root(memcg))
> +		return 0;
> +
> +	return __try_charge(memcg, gfp_mask, nr_pages);
> +}
> +
>  #if defined(CONFIG_MEMCG_KMEM) || defined(CONFIG_MMU)
>  static void cancel_charge(struct mem_cgroup *memcg, unsigned int nr_pages)
>  {
> @@ -3125,7 +3132,7 @@ static int obj_cgroup_charge_pages(struct obj_cgroup *objcg, gfp_t gfp,
>  
>  	memcg = get_mem_cgroup_from_objcg(objcg);
>  
> -	ret = try_charge(memcg, gfp, nr_pages);
> +	ret = __try_charge(memcg, gfp, nr_pages);
>  	if (ret)
>  		goto out;
>  
> -- 
> 2.11.0

-- 
Michal Hocko
SUSE Labs
