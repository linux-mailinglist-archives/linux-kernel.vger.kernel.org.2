Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8273035F0C9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 11:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350413AbhDNJZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 05:25:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:35028 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350373AbhDNJY5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 05:24:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1618392275; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eU2ARRKP2HKvM+HAl1bRPX/7KV3rG7+C5uUtQ33atXM=;
        b=IGgGnIQtjcrIzFVumv1YMozZ6hq3GY17VTmUjGWyzKv4uT67rU/hjhLEcBTyrE9Zhyx0jR
        kEPfF1i9Euyvldus/fo4V4iS0STdYp/aVRUQgQ8AM+AaUOwUjyb+wz6d3TQ33Js2M28Q82
        g3v7PveyPuDVZ9u3lhscBZJ21+IPvwA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8BC63ACC4;
        Wed, 14 Apr 2021 09:24:35 +0000 (UTC)
Date:   Wed, 14 Apr 2021 11:24:34 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     guro@fb.com, hannes@cmpxchg.org, akpm@linux-foundation.org,
        shakeelb@google.com, vdavydov.dev@gmail.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com
Subject: Re: [PATCH 2/7] mm: memcontrol: bail out early when !mm in
 get_mem_cgroup_from_mm
Message-ID: <YHa00lx7ACWcS1/h@dhcp22.suse.cz>
References: <20210413065153.63431-1-songmuchun@bytedance.com>
 <20210413065153.63431-3-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210413065153.63431-3-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 13-04-21 14:51:48, Muchun Song wrote:
> When mm is NULL, we do not need to hold rcu lock and call css_tryget for
> the root memcg. And we also do not need to check !mm in every loop of
> while. So bail out early when !mm.

mem_cgroup_charge and other callers unconditionally drop the reference
so how come this does not underflow reference count?
 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Reviewed-by: Shakeel Butt <shakeelb@google.com>
> ---
>  mm/memcontrol.c | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index f229de925aa5..9cbfff59b171 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -901,20 +901,19 @@ struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm)
>  	if (mem_cgroup_disabled())
>  		return NULL;
>  
> +	/*
> +	 * Page cache insertions can happen without an
> +	 * actual mm context, e.g. during disk probing
> +	 * on boot, loopback IO, acct() writes etc.
> +	 */
> +	if (unlikely(!mm))
> +		return root_mem_cgroup;
> +
>  	rcu_read_lock();
>  	do {
> -		/*
> -		 * Page cache insertions can happen without an
> -		 * actual mm context, e.g. during disk probing
> -		 * on boot, loopback IO, acct() writes etc.
> -		 */
> -		if (unlikely(!mm))
> +		memcg = mem_cgroup_from_task(rcu_dereference(mm->owner));
> +		if (unlikely(!memcg))
>  			memcg = root_mem_cgroup;
> -		else {
> -			memcg = mem_cgroup_from_task(rcu_dereference(mm->owner));
> -			if (unlikely(!memcg))
> -				memcg = root_mem_cgroup;
> -		}
>  	} while (!css_tryget(&memcg->css));
>  	rcu_read_unlock();
>  	return memcg;
> -- 
> 2.11.0

-- 
Michal Hocko
SUSE Labs
