Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEF4532A3D1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 16:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382577AbhCBJkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 04:40:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:50002 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1838025AbhCBJRu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 04:17:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614676623; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2lTNGUQOU5ZRn8hHITEAj8ERC6Szv7NUv4WYSpUAvfo=;
        b=ONVwZQZrA45Na87INciY0J/4eHEq8CM4tW4gUsuWgvkwKbb+1pYu/hLH1FaZxKguoGXPoX
        8d2fQgFqw877ImT19JUUBURst+EUUkY//7eBxrVGrH6Ms9g7zrKSPB23BQc1uwBlJv/vSm
        7usGuaI7NIMf/W7FyuAF+BBJvbLvKhc=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3C880AFCE;
        Tue,  2 Mar 2021 09:17:03 +0000 (UTC)
Date:   Tue, 2 Mar 2021 10:17:02 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Zhou Guanghui <zhouguanghui1@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, wangkefeng.wang@huawei.com,
        guohanjun@huawei.com, dingtianhong@huawei.com,
        chenweilong@huawei.com, rui.xiang@huawei.com,
        Johannes Weiner <hannes@cmpxchg.org>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] mm/memcg: set memcg when split pages
Message-ID: <YD4CciUX0/eXFLM0@dhcp22.suse.cz>
References: <20210302013451.118701-1-zhouguanghui1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210302013451.118701-1-zhouguanghui1@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Cc Johannes for awareness and fixup Nick's email]

On Tue 02-03-21 01:34:51, Zhou Guanghui wrote:
> When split page, the memory cgroup info recorded in first page is
> not copied to tail pages. In this case, when the tail pages are
> freed, the uncharge operation is not performed. As a result, the
> usage of this memcg keeps increasing, and the OOM may occur.
> 
> So, the copying of first page's memory cgroup info to tail pages
> is needed when split page.

I was not aware that alloc_pages_exact is used for accounted allocations
but git grep told me otherwise so this is not a theoretical one. Both
users (arm64 and s390 kvm) are quite recent AFAICS. split_page is also
used in dma allocator but I got lost in indirection so I have no idea
whether there are any users there.

The page itself looks reasonable to me.

> Signed-off-by: Zhou Guanghui <zhouguanghui1@huawei.com>

Acked-by: Michal Hocko <mhocko@suse.com>

Minor nit

> ---
>  include/linux/memcontrol.h | 10 ++++++++++
>  mm/page_alloc.c            |  4 +++-
>  2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index e6dc793d587d..c7e2b4421dc1 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -867,6 +867,12 @@ void mem_cgroup_print_oom_group(struct mem_cgroup *memcg);
>  extern bool cgroup_memory_noswap;
>  #endif
>  
> +static inline void copy_page_memcg(struct page *dst, struct page *src)
> +{
> +	if (src->memcg_data)
> +		dst->memcg_data = src->memcg_data;

I would just drop the test. The struct page is a single cache line which
is dirty by the reference count so another store will unlikely be
noticeable even when NULL is stored here and you safe a conditional.

> +}
> +
>  struct mem_cgroup *lock_page_memcg(struct page *page);
>  void __unlock_page_memcg(struct mem_cgroup *memcg);
>  void unlock_page_memcg(struct page *page);
> @@ -1291,6 +1297,10 @@ mem_cgroup_print_oom_meminfo(struct mem_cgroup *memcg)
>  {
>  }
>  
> +static inline void copy_page_memcg(struct page *dst, struct page *src)
> +{
> +}
> +
>  static inline struct mem_cgroup *lock_page_memcg(struct page *page)
>  {
>  	return NULL;
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 3e4b29ee2b1e..ee0a63dc1c9b 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3307,8 +3307,10 @@ void split_page(struct page *page, unsigned int order)
>  	VM_BUG_ON_PAGE(PageCompound(page), page);
>  	VM_BUG_ON_PAGE(!page_count(page), page);
>  
> -	for (i = 1; i < (1 << order); i++)
> +	for (i = 1; i < (1 << order); i++) {
>  		set_page_refcounted(page + i);
> +		copy_page_memcg(page + i, page);
> +	}
>  	split_page_owner(page, 1 << order);
>  }
>  EXPORT_SYMBOL_GPL(split_page);
> -- 
> 2.25.0
> 

-- 
Michal Hocko
SUSE Labs
