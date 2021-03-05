Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA4DD32E765
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 12:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbhCELsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 06:48:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:38366 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229591AbhCELsD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 06:48:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614944882; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6WeC3+MgZVHAE3bpKTnOSw5jwR/M940LyaOSeo03HC4=;
        b=qtH+XHRf5FIZiV19w3D+9pUe6TJ52SfBcVbFfFU5eO0+gKQJ6uYkyJY2QCUSWcvXFvbg6K
        DbNZeAwZ4IMiuPbxOCUmvN3tOC0Nz2IU/Z+BGzRZhkU0jMLUfuLNTs92OhL/MJ6msyiLHA
        8HKN9sr1/GtRgMs2/DfxkXigJ6h1gpI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 35CE0AC54;
        Fri,  5 Mar 2021 11:48:02 +0000 (UTC)
Date:   Fri, 5 Mar 2021 12:48:00 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Zhou Guanghui <zhouguanghui1@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, hannes@cmpxchg.org, hughd@google.com,
        kirill.shutemov@linux.intel.com, npiggin@gmail.com, ziy@nvidia.com,
        wangkefeng.wang@huawei.com, guohanjun@huawei.com,
        dingtianhong@huawei.com, chenweilong@huawei.com,
        rui.xiang@huawei.com
Subject: Re: [PATCH v2 1/2] mm/memcg: rename mem_cgroup_split_huge_fixup to
 split_page_memcg
Message-ID: <YEIacHQNSwgSjrCT@dhcp22.suse.cz>
References: <20210304074053.65527-1-zhouguanghui1@huawei.com>
 <20210304074053.65527-2-zhouguanghui1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304074053.65527-2-zhouguanghui1@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 04-03-21 07:40:52, Zhou Guanghui wrote:
> Rename mem_cgroup_split_huge_fixup to split_page_memcg and explicitly
> pass in page number argument.
> 
> In this way, the interface name is more common and can be used by
> potential users. In addition, the complete info(memcg and flag) of
> the memcg needs to be set to the tail pages.

I think it is good to call out the css_get -> css_get_many as a
microptimization explicitly. Even though I do not expect this to be
easily visible it makes sense to save rcu section for each of the tail
page in general.

> Signed-off-by: Zhou Guanghui <zhouguanghui1@huawei.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  include/linux/memcontrol.h |  6 ++----
>  mm/huge_memory.c           |  2 +-
>  mm/memcontrol.c            | 15 ++++++---------
>  3 files changed, 9 insertions(+), 14 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index e6dc793d587d..0c04d39a7967 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1061,9 +1061,7 @@ static inline void memcg_memory_event_mm(struct mm_struct *mm,
>  	rcu_read_unlock();
>  }
>  
> -#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -void mem_cgroup_split_huge_fixup(struct page *head);
> -#endif
> +void split_page_memcg(struct page *head, unsigned int nr);
>  
>  #else /* CONFIG_MEMCG */
>  
> @@ -1400,7 +1398,7 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
>  	return 0;
>  }
>  
> -static inline void mem_cgroup_split_huge_fixup(struct page *head)
> +static inline void split_page_memcg(struct page *head, unsigned int nr)
>  {
>  }
>  
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 395c75111d33..e7f29308ebc8 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2471,7 +2471,7 @@ static void __split_huge_page(struct page *page, struct list_head *list,
>  	int i;
>  
>  	/* complete memcg works before add pages to LRU */
> -	mem_cgroup_split_huge_fixup(head);
> +	split_page_memcg(head, nr);
>  
>  	if (PageAnon(head) && PageSwapCache(head)) {
>  		swp_entry_t entry = { .val = page_private(head) };
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 845eec01ef9d..e064ac0d850a 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3287,24 +3287,21 @@ void obj_cgroup_uncharge(struct obj_cgroup *objcg, size_t size)
>  
>  #endif /* CONFIG_MEMCG_KMEM */
>  
> -#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  /*
> - * Because page_memcg(head) is not set on compound tails, set it now.
> + * Because page_memcg(head) is not set on tails, set it now.
>   */
> -void mem_cgroup_split_huge_fixup(struct page *head)
> +void split_page_memcg(struct page *head, unsigned int nr)
>  {
>  	struct mem_cgroup *memcg = page_memcg(head);
>  	int i;
>  
> -	if (mem_cgroup_disabled())
> +	if (mem_cgroup_disabled() || !memcg)
>  		return;
>  
> -	for (i = 1; i < HPAGE_PMD_NR; i++) {
> -		css_get(&memcg->css);
> -		head[i].memcg_data = (unsigned long)memcg;
> -	}
> +	for (i = 1; i < nr; i++)
> +		head[i].memcg_data = head->memcg_data;
> +	css_get_many(&memcg->css, nr - 1);
>  }
> -#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>  
>  #ifdef CONFIG_MEMCG_SWAP
>  /**
> -- 
> 2.25.0
> 

-- 
Michal Hocko
SUSE Labs
