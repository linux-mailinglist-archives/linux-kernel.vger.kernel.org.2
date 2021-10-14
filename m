Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A35E42D595
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 10:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbhJNJB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 05:01:29 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:25185 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbhJNJBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 05:01:19 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4HVNbH27Hzz8tfS;
        Thu, 14 Oct 2021 16:58:03 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 14 Oct 2021 16:59:11 +0800
Received: from [10.174.178.178] (10.174.178.178) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 14 Oct 2021 16:59:10 +0800
Message-ID: <8fc5e1ae-a356-6225-2e50-cf0e5ee26208@huawei.com>
Date:   Thu, 14 Oct 2021 16:59:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
Subject: Re: [PATCH] mm/vmalloc: fix numa spreading for large hash tables
To:     Shakeel Butt <shakeelb@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "Kefeng Wang" <wangkefeng.wang@huawei.com>, <guohanjun@huawei.com>
References: <20210928121040.2547407-1-chenwandun@huawei.com>
 <CALvZod4G3SzP3kWxQYn0fj+VgG-G3yWXz=gz17+3N57ru1iajw@mail.gmail.com>
From:   Chen Wandun <chenwandun@huawei.com>
In-Reply-To: <CALvZod4G3SzP3kWxQYn0fj+VgG-G3yWXz=gz17+3N57ru1iajw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.178]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2021/10/14 5:46, Shakeel Butt 写道:
> On Tue, Sep 28, 2021 at 5:03 AM Chen Wandun <chenwandun@huawei.com> wrote:
>>
>> Eric Dumazet reported a strange numa spreading info in [1], and found
>> commit 121e6f3258fe ("mm/vmalloc: hugepage vmalloc mappings") introduced
>> this issue [2].
>>
>> Dig into the difference before and after this patch, page allocation has
>> some difference:
>>
>> before:
>> alloc_large_system_hash
>>      __vmalloc
>>          __vmalloc_node(..., NUMA_NO_NODE, ...)
>>              __vmalloc_node_range
>>                  __vmalloc_area_node
>>                      alloc_page /* because NUMA_NO_NODE, so choose alloc_page branch */
>>                          alloc_pages_current
>>                              alloc_page_interleave /* can be proved by print policy mode */
>>
>> after:
>> alloc_large_system_hash
>>      __vmalloc
>>          __vmalloc_node(..., NUMA_NO_NODE, ...)
>>              __vmalloc_node_range
>>                  __vmalloc_area_node
>>                      alloc_pages_node /* choose nid by nuam_mem_id() */
>>                          __alloc_pages_node(nid, ....)
>>
>> So after commit 121e6f3258fe ("mm/vmalloc: hugepage vmalloc mappings"),
>> it will allocate memory in current node instead of interleaving allocate
>> memory.
>>
>> [1]
>> https://lore.kernel.org/linux-mm/CANn89iL6AAyWhfxdHO+jaT075iOa3XcYn9k6JJc7JR2XYn6k_Q@mail.gmail.com/
>>
>> [2]
>> https://lore.kernel.org/linux-mm/CANn89iLofTR=AK-QOZY87RdUZENCZUT4O6a0hvhu3_EwRMerOg@mail.gmail.com/
>>
>> Fixes: 121e6f3258fe ("mm/vmalloc: hugepage vmalloc mappings")
>> Reported-by: Eric Dumazet <edumazet@google.com>
>> Signed-off-by: Chen Wandun <chenwandun@huawei.com>
>> ---
>>   mm/vmalloc.c | 33 ++++++++++++++++++++++++++-------
>>   1 file changed, 26 insertions(+), 7 deletions(-)
>>
>> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
>> index f884706c5280..48e717626e94 100644
>> --- a/mm/vmalloc.c
>> +++ b/mm/vmalloc.c
>> @@ -2823,6 +2823,8 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>>                  unsigned int order, unsigned int nr_pages, struct page **pages)
>>   {
>>          unsigned int nr_allocated = 0;
>> +       struct page *page;
>> +       int i;
>>
>>          /*
>>           * For order-0 pages we make use of bulk allocator, if
>> @@ -2833,6 +2835,7 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>>          if (!order) {
> 
> Can you please replace the above with if (!order && nid != NUMA_NO_NODE)?
> 
>>                  while (nr_allocated < nr_pages) {
>>                          unsigned int nr, nr_pages_request;
>> +                       page = NULL;
>>
>>                          /*
>>                           * A maximum allowed request is hard-coded and is 100
>> @@ -2842,9 +2845,23 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>>                           */
>>                          nr_pages_request = min(100U, nr_pages - nr_allocated);
>>
> 
> Undo the following change in this if block.

Yes, It seem like more simpler as you suggested, But it still have 
performance regression, I plan to change the following to consider
both mempolcy and alloc_pages_bulk.

Thanks,
Wandun

> 
>> -                       nr = alloc_pages_bulk_array_node(gfp, nid,
>> -                               nr_pages_request, pages + nr_allocated);
>> -
>> +                       if (nid == NUMA_NO_NODE) {
>> +                               for (i = 0; i < nr_pages_request; i++) {
>> +                                       page = alloc_page(gfp);
>> +                                       if (page)
>> +                                               pages[nr_allocated + i] = page;
>> +                                       else {
>> +                                               nr = i;
>> +                                               break;
>> +                                       }
>> +                               }
>> +                               if (i >= nr_pages_request)
>> +                                       nr = nr_pages_request;
>> +                       } else {
>> +                               nr = alloc_pages_bulk_array_node(gfp, nid,
>> +                                                       nr_pages_request,
>> +                                                       pages + nr_allocated);
>> +                       }
>>                          nr_allocated += nr;
>>                          cond_resched();
>>
>> @@ -2863,11 +2880,13 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
> 
> Put the following line under "else if (order)"
> 
>>                  gfp |= __GFP_COMP;
>>
>>          /* High-order pages or fallback path if "bulk" fails. */
>> -       while (nr_allocated < nr_pages) {
> 
> Keep the following declarations inside the while loop.
> 
>> -               struct page *page;
>> -               int i;
>>
>> -               page = alloc_pages_node(nid, gfp, order);
>> +       page = NULL;
>> +       while (nr_allocated < nr_pages) {
>> +               if (nid == NUMA_NO_NODE)
>> +                       page = alloc_pages(gfp, order);
>> +               else
>> +                       page = alloc_pages_node(nid, gfp, order);
>>                  if (unlikely(!page))
>>                          break;
>>
>> --
>> 2.25.1
>>
> . 
> 
