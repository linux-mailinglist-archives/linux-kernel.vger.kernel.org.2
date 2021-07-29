Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1737F3D9DE2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 08:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234419AbhG2GwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 02:52:23 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:13209 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234161AbhG2GwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 02:52:22 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Gb1Jr6CZrz1CQDk;
        Thu, 29 Jul 2021 14:46:20 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 29 Jul 2021 14:52:09 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 29 Jul 2021 14:52:09 +0800
Subject: Re: [PATCH] slub: fix unreclaimable slab stat for bulk free
To:     Shakeel Butt <shakeelb@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>
CC:     Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Wang Hai <wanghai38@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20210728155354.3440560-1-shakeelb@google.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <8c14efe2-69dc-6eab-3cd5-c042576770e7@huawei.com>
Date:   Thu, 29 Jul 2021 14:52:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20210728155354.3440560-1-shakeelb@google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/7/28 23:53, Shakeel Butt wrote:
> SLUB uses page allocator for higher order allocations and update
> unreclaimable slab stat for such allocations. At the moment, the bulk
> free for SLUB does not share code with normal free code path for these
> type of allocations and have missed the stat update. So, fix the stat
> update by common code. The user visible impact of the bug is the
> potential of inconsistent unreclaimable slab stat visible through
> meminfo and vmstat.
>
> Fixes: 6a486c0ad4dc ("mm, sl[ou]b: improve memory accounting")
> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> ---
>   mm/slub.c | 22 ++++++++++++----------
>   1 file changed, 12 insertions(+), 10 deletions(-)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index 6dad2b6fda6f..03770291aa6b 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3238,6 +3238,16 @@ struct detached_freelist {
>   	struct kmem_cache *s;
>   };
>   
> +static inline void free_nonslab_page(struct page *page)
> +{
> +	unsigned int order = compound_order(page);
> +
> +	VM_BUG_ON_PAGE(!PageCompound(page), page);

Could we add WARN_ON here, or we got nothing when CONFIG_DEBUG_VM is 
disabled.


> +	kfree_hook(page_address(page));
> +	mod_lruvec_page_state(page, NR_SLAB_UNRECLAIMABLE_B, -(PAGE_SIZE << order));
> +	__free_pages(page, order);
> +}
> +
>   /*
>    * This function progressively scans the array with free objects (with
>    * a limited look ahead) and extract objects belonging to the same
> @@ -3274,9 +3284,7 @@ int build_detached_freelist(struct kmem_cache *s, size_t size,
>   	if (!s) {
>   		/* Handle kalloc'ed objects */
>   		if (unlikely(!PageSlab(page))) {
> -			BUG_ON(!PageCompound(page));
> -			kfree_hook(object);
> -			__free_pages(page, compound_order(page));
> +			free_nonslab_page(page);
>   			p[size] = NULL; /* mark object processed */
>   			return size;
>   		}
> @@ -4252,13 +4260,7 @@ void kfree(const void *x)
>   
>   	page = virt_to_head_page(x);
>   	if (unlikely(!PageSlab(page))) {
> -		unsigned int order = compound_order(page);
> -
> -		BUG_ON(!PageCompound(page));
> -		kfree_hook(object);
> -		mod_lruvec_page_state(page, NR_SLAB_UNRECLAIMABLE_B,
> -				      -(PAGE_SIZE << order));
> -		__free_pages(page, order);
> +		free_nonslab_page(page);
>   		return;
>   	}
>   	slab_free(page->slab_cache, page, object, NULL, 1, _RET_IP_);
