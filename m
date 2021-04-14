Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE18035F0AC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 11:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347617AbhDNJVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 05:21:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:60074 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230247AbhDNJUs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 05:20:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1618392025; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Mr3scI/YTtt7ex3orLLYYw+pW4lHQUrTP1/LVJpZfoM=;
        b=odp2cs3oBeu4/nv5hFcVVVM+v8y5f7n9+IxPU37m5dVSeAFfRwLsTVeuh12rWg3yWR4hFy
        uWPRvHKtgnQvNur1pwxkK7GOdz4WpdFSd49qg7j4J4TSjwLq2jN7htiwSQCrk8ajYQ3p1/
        DEByuGHjeF8BnVGL0mHfPhKVuIbtc0w=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D0940AE37;
        Wed, 14 Apr 2021 09:20:24 +0000 (UTC)
Date:   Wed, 14 Apr 2021 11:20:24 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     guro@fb.com, hannes@cmpxchg.org, akpm@linux-foundation.org,
        shakeelb@google.com, vdavydov.dev@gmail.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com
Subject: Re: [PATCH 1/7] mm: memcontrol: fix page charging in page replacement
Message-ID: <YHaz2MgbX3nk8Am8@dhcp22.suse.cz>
References: <20210413065153.63431-1-songmuchun@bytedance.com>
 <20210413065153.63431-2-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210413065153.63431-2-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 13-04-21 14:51:47, Muchun Song wrote:
> The pages aren't accounted at the root level, so do not charge the page
> to the root memcg in page replacement. Although we do not display the
> value (mem_cgroup_usage) so there shouldn't be any actual problem, but
> there is a WARN_ON_ONCE in the page_counter_cancel(). Who knows if it
> will trigger? So it is better to fix it.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Reviewed-by: Shakeel Butt <shakeelb@google.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/memcontrol.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 64ada9e650a5..f229de925aa5 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -6806,9 +6806,11 @@ void mem_cgroup_migrate(struct page *oldpage, struct page *newpage)
>  	/* Force-charge the new page. The old one will be freed soon */
>  	nr_pages = thp_nr_pages(newpage);
>  
> -	page_counter_charge(&memcg->memory, nr_pages);
> -	if (do_memsw_account())
> -		page_counter_charge(&memcg->memsw, nr_pages);
> +	if (!mem_cgroup_is_root(memcg)) {
> +		page_counter_charge(&memcg->memory, nr_pages);
> +		if (do_memsw_account())
> +			page_counter_charge(&memcg->memsw, nr_pages);
> +	}
>  
>  	css_get(&memcg->css);
>  	commit_charge(newpage, memcg);
> -- 
> 2.11.0

-- 
Michal Hocko
SUSE Labs
