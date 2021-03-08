Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52D1D331A47
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 23:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbhCHWiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 17:38:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbhCHWhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 17:37:39 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECBD9C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 14:37:38 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id u18so5556884plc.12
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 14:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dWbXoRT50C4P8kLkFX7QtNixm4uO5hHwOSRbkOw9z/c=;
        b=hhMoJRHbSxa//fJjDpCkUu0/qUaSaGePV56FtPwi3DdKgWW6xLMXrcpB8bIyX7kyBv
         UiL1PLI1xoKqM7Gs7cSC8hpZcfeAtmZiBB1ZLWJdlkFXOUE7J36h9advKwM4CBRWoORZ
         MTBgGGCFs9kNlXj+dOF/c0DFGe/HAeWRqZd69YQG29Ue7D1zH/FDqKqvFgZd6GFKLo13
         HhgHuYpdZFNtGADE7uhpHK++7weTw5vpF/EJQvR3U6++TD0ElP4Nq+U8O/83pfMqOT4z
         N7/ClExcy/MDfn9UFU/0UPqbdMUfhNlEbND8EJW9qeqoGXe5m/LYhr3TJs0qduAvOi2m
         fvWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dWbXoRT50C4P8kLkFX7QtNixm4uO5hHwOSRbkOw9z/c=;
        b=ffC7l9D2uHa7d2SaujPGFNuK4nUpDmZOr1jfHgnjbOgFR39GyMyCBoI4VsYOJjeV/v
         Vq78wKLSaj1uWoVv2QbTAdnUMT6fkFklRYGic6bPsEAbcyetly5XjWZqQIrqN/nUCqZO
         vbV/3oSWwc+0w/D5owlLLtm7sOJvQhdWzw9mFxcha63FT6kvspAtAj1hFRGGDONlJJUe
         mlYHQQWnSDtngLQrl2nb5fplwHRkKYxPsqYhQMnzuoUYb4wjqC+dyOUZjnIQZTe7nj8z
         mOjEBuQPSE8uh5C8Yh85yg+CEGJYJpQ/rVLlAELiyeSADjfcTmNX9n6k0522ImyiBdB8
         JLNg==
X-Gm-Message-State: AOAM531uoifpqyatcnCHWvYR6dmrNZWCS/UaCwvyUa+Sy71A4niT+S50
        HPjsy4InJMRZIy9kChsBSfY=
X-Google-Smtp-Source: ABdhPJxrCpZdynjiOo8lGK1qfy+hvlzfD+jPBn6jwOcCfjuHvCFWz3YxNR4+OKbFZxcqF/epD5bF6g==
X-Received: by 2002:a17:90a:f28d:: with SMTP id fs13mr1168541pjb.220.1615243058300;
        Mon, 08 Mar 2021 14:37:38 -0800 (PST)
Received: from f8ffc2228008.ant.amazon.com ([54.240.193.1])
        by smtp.gmail.com with ESMTPSA id p5sm9350647pfq.56.2021.03.08.14.37.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Mar 2021 14:37:37 -0800 (PST)
Subject: Re: [PATCH v2 1/2] mm/memcg: rename mem_cgroup_split_huge_fixup to
 split_page_memcg
To:     Zhou Guanghui <zhouguanghui1@huawei.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, mhocko@suse.com, hannes@cmpxchg.org,
        hughd@google.com, kirill.shutemov@linux.intel.com,
        npiggin@gmail.com, ziy@nvidia.com, wangkefeng.wang@huawei.com,
        guohanjun@huawei.com, dingtianhong@huawei.com,
        chenweilong@huawei.com, rui.xiang@huawei.com
References: <20210304074053.65527-1-zhouguanghui1@huawei.com>
 <20210304074053.65527-2-zhouguanghui1@huawei.com>
From:   "Singh, Balbir" <bsingharora@gmail.com>
Message-ID: <3ad50842-881f-eb88-a14d-0b6c70ce33d2@gmail.com>
Date:   Tue, 9 Mar 2021 09:37:29 +1100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210304074053.65527-2-zhouguanghui1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/3/21 6:40 pm, Zhou Guanghui wrote:
> Rename mem_cgroup_split_huge_fixup to split_page_memcg and explicitly
> pass in page number argument.
> 
> In this way, the interface name is more common and can be used by
> potential users. In addition, the complete info(memcg and flag) of
> the memcg needs to be set to the tail pages.
> 
> Signed-off-by: Zhou Guanghui <zhouguanghui1@huawei.com>
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

Do we need input validation on nr? Can nr be aribtrary or can we enforce

VM_BUG_ON(!is_power_of_2(nr));


Balbir Singh

