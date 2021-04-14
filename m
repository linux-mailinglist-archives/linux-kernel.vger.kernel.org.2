Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81D2E35F0D3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 11:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235374AbhDNJ2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 05:28:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:40702 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232454AbhDNJ1f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 05:27:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1618392433; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I4M0tkmcqKTvrAzd8ABxiVydKwG24FDTFmuy+1YGYSU=;
        b=N2M1K3wQJyemuE66ZlLCYBTRJ2pc+RcYLwo5N9tkPh603oA31ldIeEXp6BXNizpFAFOEse
        pFtZQU8P0YOdQ2927y6UOD31TXWlBHC+kEs6ZZSSL7a0BUNY6IHLj67f9mgmwRSPuWSXgM
        E7PybdvZ0BB0zzmOTqEEM5/Qzl/8MwQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2D37FACC4;
        Wed, 14 Apr 2021 09:27:13 +0000 (UTC)
Date:   Wed, 14 Apr 2021 11:27:12 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     guro@fb.com, hannes@cmpxchg.org, akpm@linux-foundation.org,
        shakeelb@google.com, vdavydov.dev@gmail.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com
Subject: Re: [PATCH 3/7] mm: memcontrol: remove the pgdata parameter of
 mem_cgroup_page_lruvec
Message-ID: <YHa1cBEjXp09bLZW@dhcp22.suse.cz>
References: <20210413065153.63431-1-songmuchun@bytedance.com>
 <20210413065153.63431-4-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210413065153.63431-4-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 13-04-21 14:51:49, Muchun Song wrote:
> All the callers of mem_cgroup_page_lruvec() just pass page_pgdat(page)
> as the 2nd parameter to it (except isolate_migratepages_block()). But
> for isolate_migratepages_block(), the page_pgdat(page) is also equal
> to the local variable of @pgdat. So mem_cgroup_page_lruvec() do not
> need the pgdat parameter. Just remove it to simplify the code.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

I like this. Two arguments where one can be directly inferred from the
first one can just lead to subtle bugs. In this case it even doesn't
give any advantage for most callers.

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  include/linux/memcontrol.h | 10 +++++-----
>  mm/compaction.c            |  2 +-
>  mm/memcontrol.c            |  9 +++------
>  mm/swap.c                  |  2 +-
>  mm/workingset.c            |  2 +-
>  5 files changed, 11 insertions(+), 14 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index c960fd49c3e8..4f49865c9958 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -743,13 +743,12 @@ static inline struct lruvec *mem_cgroup_lruvec(struct mem_cgroup *memcg,
>  /**
>   * mem_cgroup_page_lruvec - return lruvec for isolating/putting an LRU page
>   * @page: the page
> - * @pgdat: pgdat of the page
>   *
>   * This function relies on page->mem_cgroup being stable.
>   */
> -static inline struct lruvec *mem_cgroup_page_lruvec(struct page *page,
> -						struct pglist_data *pgdat)
> +static inline struct lruvec *mem_cgroup_page_lruvec(struct page *page)
>  {
> +	pg_data_t *pgdat = page_pgdat(page);
>  	struct mem_cgroup *memcg = page_memcg(page);
>  
>  	VM_WARN_ON_ONCE_PAGE(!memcg && !mem_cgroup_disabled(), page);
> @@ -1223,9 +1222,10 @@ static inline struct lruvec *mem_cgroup_lruvec(struct mem_cgroup *memcg,
>  	return &pgdat->__lruvec;
>  }
>  
> -static inline struct lruvec *mem_cgroup_page_lruvec(struct page *page,
> -						    struct pglist_data *pgdat)
> +static inline struct lruvec *mem_cgroup_page_lruvec(struct page *page)
>  {
> +	pg_data_t *pgdat = page_pgdat(page);
> +
>  	return &pgdat->__lruvec;
>  }
>  
> diff --git a/mm/compaction.c b/mm/compaction.c
> index caa4c36c1db3..e7da342003dd 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -1033,7 +1033,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>  		if (!TestClearPageLRU(page))
>  			goto isolate_fail_put;
>  
> -		lruvec = mem_cgroup_page_lruvec(page, pgdat);
> +		lruvec = mem_cgroup_page_lruvec(page);
>  
>  		/* If we already hold the lock, we can skip some rechecking */
>  		if (lruvec != locked) {
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 9cbfff59b171..1f807448233e 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1177,9 +1177,8 @@ void lruvec_memcg_debug(struct lruvec *lruvec, struct page *page)
>  struct lruvec *lock_page_lruvec(struct page *page)
>  {
>  	struct lruvec *lruvec;
> -	struct pglist_data *pgdat = page_pgdat(page);
>  
> -	lruvec = mem_cgroup_page_lruvec(page, pgdat);
> +	lruvec = mem_cgroup_page_lruvec(page);
>  	spin_lock(&lruvec->lru_lock);
>  
>  	lruvec_memcg_debug(lruvec, page);
> @@ -1190,9 +1189,8 @@ struct lruvec *lock_page_lruvec(struct page *page)
>  struct lruvec *lock_page_lruvec_irq(struct page *page)
>  {
>  	struct lruvec *lruvec;
> -	struct pglist_data *pgdat = page_pgdat(page);
>  
> -	lruvec = mem_cgroup_page_lruvec(page, pgdat);
> +	lruvec = mem_cgroup_page_lruvec(page);
>  	spin_lock_irq(&lruvec->lru_lock);
>  
>  	lruvec_memcg_debug(lruvec, page);
> @@ -1203,9 +1201,8 @@ struct lruvec *lock_page_lruvec_irq(struct page *page)
>  struct lruvec *lock_page_lruvec_irqsave(struct page *page, unsigned long *flags)
>  {
>  	struct lruvec *lruvec;
> -	struct pglist_data *pgdat = page_pgdat(page);
>  
> -	lruvec = mem_cgroup_page_lruvec(page, pgdat);
> +	lruvec = mem_cgroup_page_lruvec(page);
>  	spin_lock_irqsave(&lruvec->lru_lock, *flags);
>  
>  	lruvec_memcg_debug(lruvec, page);
> diff --git a/mm/swap.c b/mm/swap.c
> index a75a8265302b..e0d5699213cc 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -313,7 +313,7 @@ void lru_note_cost(struct lruvec *lruvec, bool file, unsigned int nr_pages)
>  
>  void lru_note_cost_page(struct page *page)
>  {
> -	lru_note_cost(mem_cgroup_page_lruvec(page, page_pgdat(page)),
> +	lru_note_cost(mem_cgroup_page_lruvec(page),
>  		      page_is_file_lru(page), thp_nr_pages(page));
>  }
>  
> diff --git a/mm/workingset.c b/mm/workingset.c
> index b7cdeca5a76d..4f7a306ce75a 100644
> --- a/mm/workingset.c
> +++ b/mm/workingset.c
> @@ -408,7 +408,7 @@ void workingset_activation(struct page *page)
>  	memcg = page_memcg_rcu(page);
>  	if (!mem_cgroup_disabled() && !memcg)
>  		goto out;
> -	lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
> +	lruvec = mem_cgroup_page_lruvec(page);
>  	workingset_age_nonresident(lruvec, thp_nr_pages(page));
>  out:
>  	rcu_read_unlock();
> -- 
> 2.11.0

-- 
Michal Hocko
SUSE Labs
