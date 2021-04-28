Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDB236D3DD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 10:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237172AbhD1IYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 04:24:12 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:17067 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236961AbhD1IYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 04:24:11 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FVWmS4HTwz16MPc;
        Wed, 28 Apr 2021 16:20:56 +0800 (CST)
Received: from [10.174.176.174] (10.174.176.174) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Wed, 28 Apr 2021 16:23:22 +0800
Subject: Re: [PATCH 2/5] mm/huge_memory.c: use page->deferred_list
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        <akpm@linux-foundation.org>
CC:     <ziy@nvidia.com>, <william.kucharski@oracle.com>,
        <willy@infradead.org>, <yang.shi@linux.alibaba.com>,
        <aneesh.kumar@linux.ibm.com>, <rcampbell@nvidia.com>,
        <songliubraving@fb.com>, <kirill.shutemov@linux.intel.com>,
        <riel@surriel.com>, <hannes@cmpxchg.org>, <minchan@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20210427133214.2270207-1-linmiaohe@huawei.com>
 <20210427133214.2270207-3-linmiaohe@huawei.com>
 <e326f0c6-a4dc-6788-7be7-a175c47b2249@arm.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <2cda7d1a-d769-2635-24ce-928e33d6bfcc@huawei.com>
Date:   Wed, 28 Apr 2021 16:23:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <e326f0c6-a4dc-6788-7be7-a175c47b2249@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.174]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/4/28 11:07, Anshuman Khandual wrote:
> 
> On 4/27/21 7:02 PM, Miaohe Lin wrote:
>> Now that we can represent the location of ->deferred_list instead of
>> ->mapping + ->index, make use of it to improve readability.
> 
> Could you please explain how page->deferred_list and page->mapping
> are interchangeable here ?

It's because there is a union in struct page:

union {
		struct {
			struct list_head lru;
			struct address_space *mapping;
			pgoff_t index;
			unsigned long private;
		};
		struct {
			unsigned long _compound_pad_1;
			atomic_t hpage_pinned_refcount;
			struct list_head *deferred_list*;
		};
};

And initially there is no deferred_list and it's added via commit 66a6ffd2af42 ("mm: combine first
three unions in struct page"). Also commit fa3015b7eed5 ("mm: use page->deferred_list") did the similar
cleanup. Am I expected to add these to the commit log?

Many thanks.

> 
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  mm/huge_memory.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 63ed6b25deaa..76ca1eb2a223 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -2868,7 +2868,7 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
>>  	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
>>  	/* Take pin on all head pages to avoid freeing them under us */
>>  	list_for_each_safe(pos, next, &ds_queue->split_queue) {
>> -		page = list_entry((void *)pos, struct page, mapping);
>> +		page = list_entry((void *)pos, struct page, deferred_list);
>>  		page = compound_head(page);
>>  		if (get_page_unless_zero(page)) {
>>  			list_move(page_deferred_list(page), &list);
>> @@ -2883,7 +2883,7 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
>>  	spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
>>  
>>  	list_for_each_safe(pos, next, &list) {
>> -		page = list_entry((void *)pos, struct page, mapping);
>> +		page = list_entry((void *)pos, struct page, deferred_list);
>>  		if (!trylock_page(page))
>>  			goto next;
>>  		/* split_huge_page() removes page from list on success */
>>
> .
> 

