Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF9D43E268
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 15:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbhJ1Nls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 09:41:48 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:26202 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbhJ1Nlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 09:41:46 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Hg67d1vZPz8tVn;
        Thu, 28 Oct 2021 21:37:49 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Thu, 28 Oct 2021 21:39:12 +0800
Received: from [10.174.178.178] (10.174.178.178) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Thu, 28 Oct 2021 21:39:11 +0800
Message-ID: <505c2aa3-2a36-3981-786e-4d192bc6f8f2@huawei.com>
Date:   Thu, 28 Oct 2021 21:39:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
Subject: Re: [PATCH v3 2/2] mm/vmalloc: introduce
 alloc_pages_bulk_array_mempolicy to accelerate memory allocation
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <npiggin@gmail.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <edumazet@google.com>,
        <wangkefeng.wang@huawei.com>, <guohanjun@huawei.com>,
        <shakeelb@google.com>, <urezki@gmail.com>
References: <20211021080744.874701-1-chenwandun@huawei.com>
 <20211021080744.874701-3-chenwandun@huawei.com>
 <20211021202652.ff8568bd5d58fbcf32946f83@linux-foundation.org>
From:   Chen Wandun <chenwandun@huawei.com>
In-Reply-To: <20211021202652.ff8568bd5d58fbcf32946f83@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.178]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2021/10/22 11:26, Andrew Morton 写道:
> On Thu, 21 Oct 2021 16:07:44 +0800 Chen Wandun <chenwandun@huawei.com> wrote:
> 
>> It
> 
> What is "it"?
it == > [PATCH] mm/vmalloc: fix numa spreading for large hash tables;
> 
>> will cause significant performance regressions in some situations
>> as Andrew mentioned in [1]. The main situation is vmalloc, vmalloc
>> will allocate pages with NUMA_NO_NODE by default, that will result
>> in alloc page one by one;
>>
>> In order to solve this, __alloc_pages_bulk and mempolicy should be
>> considered at the same time.
>>
>> 1) If node is specified in memory allocation request, it will alloc
>> all pages by __alloc_pages_bulk.
>>
>> 2) If interleaving allocate memory, it will cauculate how many pages
>> should be allocated in each node, and use __alloc_pages_bulk to alloc
>> pages in each node.
> 
> This v3 patch didn't incorporate my two fixes, below.  It is usual to
> incorporate such fixes prior to resending.  I have retained those two
> fixes, now against v3.
> 
> 
> From: Andrew Morton <akpm@linux-foundation.org>
> Subject: mm-vmalloc-introduce-alloc_pages_bulk_array_mempolicy-to-accelerate-memory-allocation-fix
> 
> make two functions static
> 
> Cc: Chen Wandun <chenwandun@huawei.com>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Hanjun Guo <guohanjun@huawei.com>
> Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>   mm/mempolicy.c |    4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> --- a/mm/mempolicy.c~mm-vmalloc-introduce-alloc_pages_bulk_array_mempolicy-to-accelerate-memory-allocation-fix
> +++ a/mm/mempolicy.c
> @@ -2196,7 +2196,7 @@ struct page *alloc_pages(gfp_t gfp, unsi
>   }
>   EXPORT_SYMBOL(alloc_pages);
>   
> -unsigned long alloc_pages_bulk_array_interleave(gfp_t gfp,
> +static unsigned long alloc_pages_bulk_array_interleave(gfp_t gfp,
>   		struct mempolicy *pol, unsigned long nr_pages,
>   		struct page **page_array)
>   {
> @@ -2231,7 +2231,7 @@ unsigned long alloc_pages_bulk_array_int
>   	return total_allocated;
>   }
>   
> -unsigned long alloc_pages_bulk_array_preferred_many(gfp_t gfp, int nid,
> +static unsigned long alloc_pages_bulk_array_preferred_many(gfp_t gfp, int nid,
>   		struct mempolicy *pol, unsigned long nr_pages,
>   		struct page **page_array)
>   {
> _
> 
> 
> 
> 
> From: Andrew Morton <akpm@linux-foundation.org>
> Subject: mm-vmalloc-introduce-alloc_pages_bulk_array_mempolicy-to-accelerate-memory-allocation-fix-2
> 
> fix CONFIG_NUMA=n build.  alloc_pages_bulk_array_mempolicy() was undefined
> 
> Cc: Chen Wandun <chenwandun@huawei.com>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Hanjun Guo <guohanjun@huawei.com>
> Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>   mm/vmalloc.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/mm/vmalloc.c~mm-vmalloc-introduce-alloc_pages_bulk_array_mempolicy-to-accelerate-memory-allocation-fix-2
> +++ a/mm/vmalloc.c
> @@ -2860,7 +2860,7 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>   			 * otherwise memory may be allocated in only one node,
>   			 * but mempolcy want to alloc memory by interleaving.
>   			 */
> -			if (nid == NUMA_NO_NODE)
> +			if (IS_ENABLED(CONFIG_NUMA) && nid == NUMA_NO_NODE)
>   				nr = alloc_pages_bulk_array_mempolicy(gfp,
>   							nr_pages_request,
>   							pages + nr_allocated);
> _
> 
> .
> 
