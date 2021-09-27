Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81C434190F5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 10:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233495AbhI0IiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 04:38:17 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:55476 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233403AbhI0IiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 04:38:15 -0400
Received: from relay1.suse.de (relay1.suse.de [149.44.160.133])
        by smtp-out1.suse.de (Postfix) with ESMTP id 59CE821EFB;
        Mon, 27 Sep 2021 08:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1632731797; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+x4udN2qJP7sxmOmDLz0RA9oO/66vJRgrWUbXXLFgQk=;
        b=MEQMjnU4zR2UhlZRJvdZDlAfdWeD/X4BtOaqqg32WWPLN7q2sCj42EJSjtFg/tzspcrI4O
        pemsCXA35L6gWU8zNBgZ+jibrBw59JwmcrV2fm5mtqcuL0GeIZ4nXclT0xNVgpTGHFkEuk
        KQ65q1Zl1+4xVVAUKB6YtEwOErHN24o=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay1.suse.de (Postfix) with ESMTPS id 17B1A25D46;
        Mon, 27 Sep 2021 08:36:37 +0000 (UTC)
Date:   Mon, 27 Sep 2021 10:36:36 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Sultan Alsawaf <sultan@kerneltoast.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: vmscan: Replace shrinker_rwsem trylocks with SRCU
 protection
Message-ID: <YVGClLWLXO8AWaEk@dhcp22.suse.cz>
References: <20210927074823.5825-1-sultan@kerneltoast.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927074823.5825-1-sultan@kerneltoast.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 27-09-21 00:48:23, Sultan Alsawaf wrote:
> From: Sultan Alsawaf <sultan@kerneltoast.com>
> 
> The shrinker rwsem is problematic because the actual shrinking path must
> back off when contention appears, causing some or all shrinkers to be
> skipped. This can be especially bad when shrinkers are frequently
> registered and unregistered. A high frequency of shrinker registrations/
> unregistrations can effectively DoS the shrinker mechanism, rendering it
> useless.

Can you be more specific about those scenarios please?

> Using SRCU to protect iteration through the shrinker list and idr
> eliminates this issue entirely. Now, shrinking can happen concurrently
> with shrinker registrations/unregistrations.

I have a vague recollection that this approach has been proposed in the
past. Have you checked previous attempts?

> Signed-off-by: Sultan Alsawaf <sultan@kerneltoast.com>
> ---
>  mm/vmscan.c | 68 ++++++++++++++++++++++++++++-------------------------
>  1 file changed, 36 insertions(+), 32 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 74296c2d1fed..3dea927be5ad 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -190,6 +190,7 @@ static void set_task_reclaim_state(struct task_struct *task,
>  
>  static LIST_HEAD(shrinker_list);
>  static DECLARE_RWSEM(shrinker_rwsem);
> +DEFINE_STATIC_SRCU(shrinker_srcu);
>  
>  #ifdef CONFIG_MEMCG
>  static int shrinker_nr_max;
> @@ -212,6 +213,20 @@ static struct shrinker_info *shrinker_info_protected(struct mem_cgroup *memcg,
>  					 lockdep_is_held(&shrinker_rwsem));
>  }
>  
> +static struct shrinker_info *shrinker_info_srcu(struct mem_cgroup *memcg,
> +						int nid)
> +{
> +	return srcu_dereference(memcg->nodeinfo[nid]->shrinker_info,
> +				&shrinker_srcu);
> +}
> +
> +static void free_shrinker_info_srcu(struct rcu_head *head)
> +{
> +	struct shrinker_info *info = container_of(head, typeof(*info), rcu);
> +
> +	kvfree_rcu(info, rcu);
> +}
> +
>  static int expand_one_shrinker_info(struct mem_cgroup *memcg,
>  				    int map_size, int defer_size,
>  				    int old_map_size, int old_defer_size)
> @@ -244,7 +259,12 @@ static int expand_one_shrinker_info(struct mem_cgroup *memcg,
>  		       defer_size - old_defer_size);
>  
>  		rcu_assign_pointer(pn->shrinker_info, new);
> -		kvfree_rcu(old, rcu);
> +
> +		/*
> +		 * Shrinker info is used under both SRCU and regular RCU, so
> +		 * synchronize the free against both of them.
> +		 */
> +		call_srcu(&shrinker_srcu, &old->rcu, free_shrinker_info_srcu);
>  	}
>  
>  	return 0;
> @@ -357,7 +377,6 @@ static int prealloc_memcg_shrinker(struct shrinker *shrinker)
>  		return -ENOSYS;
>  
>  	down_write(&shrinker_rwsem);
> -	/* This may call shrinker, so it must use down_read_trylock() */
>  	id = idr_alloc(&shrinker_idr, shrinker, 0, 0, GFP_KERNEL);
>  	if (id < 0)
>  		goto unlock;
> @@ -391,7 +410,7 @@ static long xchg_nr_deferred_memcg(int nid, struct shrinker *shrinker,
>  {
>  	struct shrinker_info *info;
>  
> -	info = shrinker_info_protected(memcg, nid);
> +	info = shrinker_info_srcu(memcg, nid);
>  	return atomic_long_xchg(&info->nr_deferred[shrinker->id], 0);
>  }
>  
> @@ -400,7 +419,7 @@ static long add_nr_deferred_memcg(long nr, int nid, struct shrinker *shrinker,
>  {
>  	struct shrinker_info *info;
>  
> -	info = shrinker_info_protected(memcg, nid);
> +	info = shrinker_info_srcu(memcg, nid);
>  	return atomic_long_add_return(nr, &info->nr_deferred[shrinker->id]);
>  }
>  
> @@ -641,6 +660,7 @@ void free_prealloced_shrinker(struct shrinker *shrinker)
>  		down_write(&shrinker_rwsem);
>  		unregister_memcg_shrinker(shrinker);
>  		up_write(&shrinker_rwsem);
> +		synchronize_srcu(&shrinker_srcu);
>  		return;
>  	}
>  
> @@ -651,7 +671,7 @@ void free_prealloced_shrinker(struct shrinker *shrinker)
>  void register_shrinker_prepared(struct shrinker *shrinker)
>  {
>  	down_write(&shrinker_rwsem);
> -	list_add_tail(&shrinker->list, &shrinker_list);
> +	list_add_tail_rcu(&shrinker->list, &shrinker_list);
>  	shrinker->flags |= SHRINKER_REGISTERED;
>  	up_write(&shrinker_rwsem);
>  }
> @@ -676,11 +696,12 @@ void unregister_shrinker(struct shrinker *shrinker)
>  		return;
>  
>  	down_write(&shrinker_rwsem);
> -	list_del(&shrinker->list);
> +	list_del_rcu(&shrinker->list);
>  	shrinker->flags &= ~SHRINKER_REGISTERED;
>  	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
>  		unregister_memcg_shrinker(shrinker);
>  	up_write(&shrinker_rwsem);
> +	synchronize_srcu(&shrinker_srcu);
>  
>  	kfree(shrinker->nr_deferred);
>  	shrinker->nr_deferred = NULL;
> @@ -792,15 +813,13 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
>  {
>  	struct shrinker_info *info;
>  	unsigned long ret, freed = 0;
> -	int i;
> +	int i, srcu_idx;
>  
>  	if (!mem_cgroup_online(memcg))
>  		return 0;
>  
> -	if (!down_read_trylock(&shrinker_rwsem))
> -		return 0;
> -
> -	info = shrinker_info_protected(memcg, nid);
> +	srcu_idx = srcu_read_lock(&shrinker_srcu);
> +	info = shrinker_info_srcu(memcg, nid);
>  	if (unlikely(!info))
>  		goto unlock;
>  
> @@ -850,14 +869,9 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
>  				set_shrinker_bit(memcg, nid, i);
>  		}
>  		freed += ret;
> -
> -		if (rwsem_is_contended(&shrinker_rwsem)) {
> -			freed = freed ? : 1;
> -			break;
> -		}
>  	}
>  unlock:
> -	up_read(&shrinker_rwsem);
> +	srcu_read_unlock(&shrinker_srcu, srcu_idx);
>  	return freed;
>  }
>  #else /* CONFIG_MEMCG */
> @@ -894,6 +908,7 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
>  {
>  	unsigned long ret, freed = 0;
>  	struct shrinker *shrinker;
> +	int srcu_idx;
>  
>  	/*
>  	 * The root memcg might be allocated even though memcg is disabled
> @@ -905,10 +920,9 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
>  	if (!mem_cgroup_disabled() && !mem_cgroup_is_root(memcg))
>  		return shrink_slab_memcg(gfp_mask, nid, memcg, priority);
>  
> -	if (!down_read_trylock(&shrinker_rwsem))
> -		goto out;
> -
> -	list_for_each_entry(shrinker, &shrinker_list, list) {
> +	srcu_idx = srcu_read_lock(&shrinker_srcu);
> +	list_for_each_entry_srcu(shrinker, &shrinker_list, list,
> +				 srcu_read_lock_held(&shrinker_srcu)) {
>  		struct shrink_control sc = {
>  			.gfp_mask = gfp_mask,
>  			.nid = nid,
> @@ -919,19 +933,9 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
>  		if (ret == SHRINK_EMPTY)
>  			ret = 0;
>  		freed += ret;
> -		/*
> -		 * Bail out if someone want to register a new shrinker to
> -		 * prevent the registration from being stalled for long periods
> -		 * by parallel ongoing shrinking.
> -		 */
> -		if (rwsem_is_contended(&shrinker_rwsem)) {
> -			freed = freed ? : 1;
> -			break;
> -		}
>  	}
> +	srcu_read_unlock(&shrinker_srcu, srcu_idx);
>  
> -	up_read(&shrinker_rwsem);
> -out:
>  	cond_resched();
>  	return freed;
>  }
> -- 
> 2.33.0

-- 
Michal Hocko
SUSE Labs
