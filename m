Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA23D35F0FB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 11:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235621AbhDNJoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 05:44:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:58550 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233066AbhDNJoe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 05:44:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1618393452; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xIV9mSCMhWgVCV1DmyiKJTiT4x6BbNMzGFIKxnc5TRc=;
        b=ROVOiiFhsfcHUWBrInqbls1h5UVNQHQtTNGJNSZoinLAyv7YpkJK9dELFHhc9+i+6KVYfa
        vO8zjR1poOPzh4wuqz5iXNPjaU5ea4FSEkNnY++4ojcTJSlMwbCXL8rBBzLj4zky+mWaN/
        IIiTY0SGMaT0Fr9mXc78+AOEmVmYCnQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 10307ABB3;
        Wed, 14 Apr 2021 09:44:12 +0000 (UTC)
Date:   Wed, 14 Apr 2021 11:44:10 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     guro@fb.com, hannes@cmpxchg.org, akpm@linux-foundation.org,
        shakeelb@google.com, vdavydov.dev@gmail.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com
Subject: Re: [PATCH 4/7] mm: memcontrol: simplify lruvec_holds_page_lru_lock
Message-ID: <YHa5ao/JgoqHQh0Z@dhcp22.suse.cz>
References: <20210413065153.63431-1-songmuchun@bytedance.com>
 <20210413065153.63431-5-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210413065153.63431-5-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 13-04-21 14:51:50, Muchun Song wrote:
> We already have a helper lruvec_memcg() to get the memcg from lruvec, we
> do not need to do it ourselves in the lruvec_holds_page_lru_lock(). So use
> lruvec_memcg() instead. And if mem_cgroup_disabled() returns false, the
> page_memcg(page) (the LRU pages) cannot be NULL. So remove the odd logic
> of "memcg = page_memcg(page) ? : root_mem_cgroup". And use lruvec_pgdat
> to simplify the code. We can have a single definition for this function
> that works for !CONFIG_MEMCG, CONFIG_MEMCG + mem_cgroup_disabled() and
> CONFIG_MEMCG.

Neat. While you are at it wouldn't it make sesne to rename the function
as well. I do not want to bikeshed but this is really a misnomer. it
doesn't check anything about locking. page_belongs_lruvec?

> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  include/linux/memcontrol.h | 31 +++++++------------------------
>  1 file changed, 7 insertions(+), 24 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 4f49865c9958..38b8d3fb24ff 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -755,22 +755,6 @@ static inline struct lruvec *mem_cgroup_page_lruvec(struct page *page)
>  	return mem_cgroup_lruvec(memcg, pgdat);
>  }
>  
> -static inline bool lruvec_holds_page_lru_lock(struct page *page,
> -					      struct lruvec *lruvec)
> -{
> -	pg_data_t *pgdat = page_pgdat(page);
> -	const struct mem_cgroup *memcg;
> -	struct mem_cgroup_per_node *mz;
> -
> -	if (mem_cgroup_disabled())
> -		return lruvec == &pgdat->__lruvec;
> -
> -	mz = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
> -	memcg = page_memcg(page) ? : root_mem_cgroup;
> -
> -	return lruvec->pgdat == pgdat && mz->memcg == memcg;
> -}
> -
>  struct mem_cgroup *mem_cgroup_from_task(struct task_struct *p);
>  
>  struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm);
> @@ -1229,14 +1213,6 @@ static inline struct lruvec *mem_cgroup_page_lruvec(struct page *page)
>  	return &pgdat->__lruvec;
>  }
>  
> -static inline bool lruvec_holds_page_lru_lock(struct page *page,
> -					      struct lruvec *lruvec)
> -{
> -	pg_data_t *pgdat = page_pgdat(page);
> -
> -	return lruvec == &pgdat->__lruvec;
> -}
> -
>  static inline void lruvec_memcg_debug(struct lruvec *lruvec, struct page *page)
>  {
>  }
> @@ -1518,6 +1494,13 @@ static inline void unlock_page_lruvec_irqrestore(struct lruvec *lruvec,
>  	spin_unlock_irqrestore(&lruvec->lru_lock, flags);
>  }
>  
> +static inline bool lruvec_holds_page_lru_lock(struct page *page,
> +					      struct lruvec *lruvec)
> +{
> +	return lruvec_pgdat(lruvec) == page_pgdat(page) &&
> +	       lruvec_memcg(lruvec) == page_memcg(page);
> +}
> +
>  /* Don't lock again iff page's lruvec locked */
>  static inline struct lruvec *relock_page_lruvec_irq(struct page *page,
>  		struct lruvec *locked_lruvec)
> -- 
> 2.11.0

-- 
Michal Hocko
SUSE Labs
