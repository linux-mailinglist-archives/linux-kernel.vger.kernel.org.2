Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03C5E42E673
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 04:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234941AbhJOCXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 22:23:02 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:24317 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234892AbhJOCXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 22:23:00 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HVqdM43fBzbfXP;
        Fri, 15 Oct 2021 10:16:23 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 15 Oct 2021 10:20:49 +0800
Received: from [10.174.178.178] (10.174.178.178) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 15 Oct 2021 10:20:48 +0800
Message-ID: <ef5683ac-807a-f187-1cb0-1a5566174d85@huawei.com>
Date:   Fri, 15 Oct 2021 10:20:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
Subject: Re: [PATCH] mm/vmalloc: fix numa spreading for large hash tables
To:     Uladzislau Rezki <urezki@gmail.com>
CC:     <akpm@linux-foundation.org>, <npiggin@gmail.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <edumazet@google.com>, <wangkefeng.wang@huawei.com>,
        <guohanjun@huawei.com>
References: <20210928121040.2547407-1-chenwandun@huawei.com>
 <20211014100157.GA1844@pc638.lan>
From:   Chen Wandun <chenwandun@huawei.com>
In-Reply-To: <20211014100157.GA1844@pc638.lan>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.178]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2021/10/14 18:01, Uladzislau Rezki 写道:
> On Tue, Sep 28, 2021 at 08:10:40PM +0800, Chen Wandun wrote:
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
>>   		unsigned int order, unsigned int nr_pages, struct page **pages)
>>   {
>>   	unsigned int nr_allocated = 0;
>> +	struct page *page;
>> +	int i;
>>   
>>   	/*
>>   	 * For order-0 pages we make use of bulk allocator, if
>> @@ -2833,6 +2835,7 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>>   	if (!order) {
>>   		while (nr_allocated < nr_pages) {
>>   			unsigned int nr, nr_pages_request;
>> +			page = NULL;
>>   
>>   			/*
>>   			 * A maximum allowed request is hard-coded and is 100
>> @@ -2842,9 +2845,23 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>>   			 */
>>   			nr_pages_request = min(100U, nr_pages - nr_allocated);
>>   
>> -			nr = alloc_pages_bulk_array_node(gfp, nid,
>> -				nr_pages_request, pages + nr_allocated);
>> -
>> +			if (nid == NUMA_NO_NODE) {
>>
> <snip>
> void *vmalloc(unsigned long size)
> {
> 	return __vmalloc_node(size, 1, GFP_KERNEL, NUMA_NO_NODE,
> 		__builtin_return_address(0));
> }
> EXPORT_SYMBOL(vmalloc);
> <snip>
> 
> vmalloc() uses NUMA_NO_NODE, so all vmalloc calls will be reverted to a single
> page allocator for NUMA and non-NUMA systems. Is it intentional to bypass the
> optimized bulk allocator for non-NUMA systems?
I sent a patch, it will help to solve this.

[PATCH] mm/vmalloc: introduce alloc_pages_bulk_array_mempolicy to 
accelerate memory allocation

Thanks,
Wandun

> 
> Thanks!
> 
> --
> Vlad Rezki
> .
> 
