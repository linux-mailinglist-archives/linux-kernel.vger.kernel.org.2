Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF0042E695
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 04:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235076AbhJOCd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 22:33:27 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:24318 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231730AbhJOCd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 22:33:26 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HVqsP2BGZzRfBJ;
        Fri, 15 Oct 2021 10:26:49 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 15 Oct 2021 10:31:18 +0800
Received: from [10.174.178.178] (10.174.178.178) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 15 Oct 2021 10:31:18 +0800
Message-ID: <d1f7249d-ffc2-7038-ed4c-f7fbb3e68eda@huawei.com>
Date:   Fri, 15 Oct 2021 10:31:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
Subject: Re: [PATCH] mm/vmalloc: fix numa spreading for large hash tables
To:     Nicholas Piggin <npiggin@gmail.com>,
        Shakeel Butt <shakeelb@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Eric Dumazet <edumazet@google.com>, <guohanjun@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
References: <20210928121040.2547407-1-chenwandun@huawei.com>
 <CALvZod4G3SzP3kWxQYn0fj+VgG-G3yWXz=gz17+3N57ru1iajw@mail.gmail.com>
 <8fc5e1ae-a356-6225-2e50-cf0e5ee26208@huawei.com>
 <1634261360.fed2opbgxw.astroid@bobo.none>
From:   Chen Wandun <chenwandun@huawei.com>
In-Reply-To: <1634261360.fed2opbgxw.astroid@bobo.none>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.178]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2021/10/15 9:34, Nicholas Piggin 写道:
> Excerpts from Chen Wandun's message of October 14, 2021 6:59 pm:
>>
>>
>> 在 2021/10/14 5:46, Shakeel Butt 写道:
>>> On Tue, Sep 28, 2021 at 5:03 AM Chen Wandun <chenwandun@huawei.com> wrote:
>>>>
>>>> Eric Dumazet reported a strange numa spreading info in [1], and found
>>>> commit 121e6f3258fe ("mm/vmalloc: hugepage vmalloc mappings") introduced
>>>> this issue [2].
>>>>
>>>> Dig into the difference before and after this patch, page allocation has
>>>> some difference:
>>>>
>>>> before:
>>>> alloc_large_system_hash
>>>>       __vmalloc
>>>>           __vmalloc_node(..., NUMA_NO_NODE, ...)
>>>>               __vmalloc_node_range
>>>>                   __vmalloc_area_node
>>>>                       alloc_page /* because NUMA_NO_NODE, so choose alloc_page branch */
>>>>                           alloc_pages_current
>>>>                               alloc_page_interleave /* can be proved by print policy mode */
>>>>
>>>> after:
>>>> alloc_large_system_hash
>>>>       __vmalloc
>>>>           __vmalloc_node(..., NUMA_NO_NODE, ...)
>>>>               __vmalloc_node_range
>>>>                   __vmalloc_area_node
>>>>                       alloc_pages_node /* choose nid by nuam_mem_id() */
>>>>                           __alloc_pages_node(nid, ....)
>>>>
>>>> So after commit 121e6f3258fe ("mm/vmalloc: hugepage vmalloc mappings"),
>>>> it will allocate memory in current node instead of interleaving allocate
>>>> memory.
>>>>
>>>> [1]
>>>> https://lore.kernel.org/linux-mm/CANn89iL6AAyWhfxdHO+jaT075iOa3XcYn9k6JJc7JR2XYn6k_Q@mail.gmail.com/
>>>>
>>>> [2]
>>>> https://lore.kernel.org/linux-mm/CANn89iLofTR=AK-QOZY87RdUZENCZUT4O6a0hvhu3_EwRMerOg@mail.gmail.com/
>>>>
>>>> Fixes: 121e6f3258fe ("mm/vmalloc: hugepage vmalloc mappings")
>>>> Reported-by: Eric Dumazet <edumazet@google.com>
>>>> Signed-off-by: Chen Wandun <chenwandun@huawei.com>
>>>> ---
>>>>    mm/vmalloc.c | 33 ++++++++++++++++++++++++++-------
>>>>    1 file changed, 26 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
>>>> index f884706c5280..48e717626e94 100644
>>>> --- a/mm/vmalloc.c
>>>> +++ b/mm/vmalloc.c
>>>> @@ -2823,6 +2823,8 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>>>>                   unsigned int order, unsigned int nr_pages, struct page **pages)
>>>>    {
>>>>           unsigned int nr_allocated = 0;
>>>> +       struct page *page;
>>>> +       int i;
>>>>
>>>>           /*
>>>>            * For order-0 pages we make use of bulk allocator, if
>>>> @@ -2833,6 +2835,7 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>>>>           if (!order) {
>>>
>>> Can you please replace the above with if (!order && nid != NUMA_NO_NODE)?
>>>
>>>>                   while (nr_allocated < nr_pages) {
>>>>                           unsigned int nr, nr_pages_request;
>>>> +                       page = NULL;
>>>>
>>>>                           /*
>>>>                            * A maximum allowed request is hard-coded and is 100
>>>> @@ -2842,9 +2845,23 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>>>>                            */
>>>>                           nr_pages_request = min(100U, nr_pages - nr_allocated);
>>>>
>>>
>>> Undo the following change in this if block.
>>
>> Yes, It seem like more simpler as you suggested, But it still have
>> performance regression, I plan to change the following to consider
>> both mempolcy and alloc_pages_bulk.
> 
> Thanks for finding and debugging this. These APIs are a maze of twisty
> little passages, all alike so I could be as confused as I was when I
> wrote that patch, but doesn't a minimal fix look something like this?

Yes, I sent a patch，it looks like as you show, besides it also
contains some performance optimization.

[PATCH] mm/vmalloc: introduce alloc_pages_bulk_array_mempolicy to 
accelerate memory allocation

Thanks,
Wandun

> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index d77830ff604c..75ee9679f521 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2860,7 +2860,10 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>                  struct page *page;
>                  int i;
>   
> -               page = alloc_pages_node(nid, gfp, order);
> +               if (nid == NUMA_NO_NODE)
> +                       page = alloc_pages(gfp, order);
> +               else
> +                       page = alloc_pages_node(nid, gfp, order);
>                  if (unlikely(!page))
>                          break;
>   
> 
> Thanks,
> Nick
> .
> 
