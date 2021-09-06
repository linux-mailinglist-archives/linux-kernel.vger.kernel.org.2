Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1139401AF9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 14:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241976AbhIFMKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 08:10:02 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:15296 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241957AbhIFMKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 08:10:00 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4H36cV2wQSz8ssd;
        Mon,  6 Sep 2021 20:08:26 +0800 (CST)
Received: from [10.174.178.100] (10.174.178.100) by
 dggeme703-chm.china.huawei.com (10.1.199.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Mon, 6 Sep 2021 20:08:53 +0800
Subject: Re: [PATCH] mm/page_isolation: don't putback unisolated page
To:     David Hildenbrand <david@redhat.com>, <akpm@linux-foundation.org>
CC:     <vbabka@suse.cz>, <iamjoonsoo.kim@lge.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20210904091839.20270-1-linmiaohe@huawei.com>
 <e060283a-6295-9191-9b92-a3c183e9de02@redhat.com>
 <b533742e-e82a-a721-9a24-4087688dd812@huawei.com>
 <5f7c4ac9-d17a-5af3-0326-1152cca38465@redhat.com>
 <2b103abc-2921-9d8a-7280-1d6b451c34f4@redhat.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <3a9921cd-1393-f67c-1002-1320b9d1668d@huawei.com>
Date:   Mon, 6 Sep 2021 20:08:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <2b103abc-2921-9d8a-7280-1d6b451c34f4@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.100]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/9/6 20:01, David Hildenbrand wrote:
> On 06.09.21 13:50, David Hildenbrand wrote:
>> On 06.09.21 13:32, Miaohe Lin wrote:
>>> On 2021/9/6 17:40, David Hildenbrand wrote:
>>>> On 04.09.21 11:18, Miaohe Lin wrote:
>>>>> If __isolate_free_page() failed, due to zone watermark check, the page is
>>>>> still on the free list. But this page will be put back to free list again
>>>>> via __putback_isolated_page() now. This may trigger page->flags checks in
>>>>> __free_one_page() if PageReported is set. Or we will corrupt the free list
>>>>> because list_add() will be called for pages already on another list.
>>>>>
>>>>> Fixes: 3c605096d315 ("mm/page_alloc: restrict max order of merging on isolated pageblock")
>>>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>>>>> ---
>>>>>     mm/page_isolation.c | 6 ++----
>>>>>     1 file changed, 2 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
>>>>> index 9bb562d5d194..7d70d772525c 100644
>>>>> --- a/mm/page_isolation.c
>>>>> +++ b/mm/page_isolation.c
>>>>> @@ -93,10 +93,8 @@ static void unset_migratetype_isolate(struct page *page, unsigned migratetype)
>>>>>                 buddy_pfn = __find_buddy_pfn(pfn, order);
>>>>>                 buddy = page + (buddy_pfn - pfn);
>>>>>     -            if (!is_migrate_isolate_page(buddy)) {
>>>>> -                __isolate_free_page(page, order);
>>>>> -                isolated_page = true;
>>>>> -            }
>>>>> +            if (!is_migrate_isolate_page(buddy))
>>>>> +                isolated_page = !!__isolate_free_page(page, order);
>>>>>             }
>>>>>         }
>>>>>    
>>>>
>>>> Shouldn't we much rather force to ignore watermarks here and make sure __isolate_free_page() never fails?
>>>
>>> It seems it is not easy to force to ignore watermarks here. And it's not a problem
>>> if __isolate_free_page() fails because we can do move_freepages_block() anyway.
>>> What do you think? Many thanks.
>>
>> I'm wondering if all this complexity in this function is even required. What about something like this: (completely untested)
>>
>> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
>> index bddf788f45bf..29ff2fcb339c 100644
>> --- a/mm/page_isolation.c
>> +++ b/mm/page_isolation.c
>> @@ -66,12 +66,10 @@ static int set_migratetype_isolate(struct page *page, int migratetype, int isol_
>>       static void unset_migratetype_isolate(struct page *page, unsigned migratetype)
>>    {
>> +       bool buddy_merge_possible = false;
>>           struct zone *zone;
>>           unsigned long flags, nr_pages;
>> -       bool isolated_page = false;
>>           unsigned int order;
>> -       unsigned long pfn, buddy_pfn;
>> -       struct page *buddy;
>>              zone = page_zone(page);
>>           spin_lock_irqsave(&zone->lock, flags);
>> @@ -79,26 +77,15 @@ static void unset_migratetype_isolate(struct page *page, unsigned migratetype)
>>                   goto out;
>>              /*
>> -        * Because freepage with more than pageblock_order on isolated
>> -        * pageblock is restricted to merge due to freepage counting problem,
>> -        * it is possible that there is free buddy page.
>> -        * move_freepages_block() doesn't care of merge so we need other
>> -        * approach in order to merge them. Isolation and free will make
>> -        * these pages to be merged.
>> +        * If our free page spans at least this whole pageblock and could
>> +        * eventually get merged into an even bigger page, go via
>> +        * __putback_isolated_page(), because move_freepages_block() won't
>> +        * trigger merging of free pages.
>>            */
>>           if (PageBuddy(page)) {
>>                   order = buddy_order(page);
>> -               if (order >= pageblock_order && order < MAX_ORDER - 1) {
>> -                       pfn = page_to_pfn(page);
>> -                       buddy_pfn = __find_buddy_pfn(pfn, order);
>> -                       buddy = page + (buddy_pfn - pfn);
>> -
>> -                       if (pfn_valid_within(buddy_pfn) &&
>> -                           !is_migrate_isolate_page(buddy)) {
>> -                               __isolate_free_page(page, order);
>> -                               isolated_page = true;
>> -                       }
>> -               }
>> +               if (order >= pageblock_order && order < MAX_ORDER - 1)
>> +                       buddy_merge_possible = true;
>>           }
>>              /*
>> @@ -111,12 +98,12 @@ static void unset_migratetype_isolate(struct page *page, unsigned migratetype)
>>            * onlining - just onlined memory won't immediately be considered for
>>            * allocation.
>>            */
>> -       if (!isolated_page) {
>> +       if (!buddy_merge_possible) {
>>                   nr_pages = move_freepages_block(zone, page, migratetype, NULL);
>>                   __mod_zone_freepage_state(zone, nr_pages, migratetype);
>>           }
>>           set_pageblock_migratetype(page, migratetype);
>> -       if (isolated_page)
>> +       if (buddy_merge_possible)
>>                   __putback_isolated_page(page, order, migratetype);
>>           zone->nr_isolate_pageblock--;
>>    out:
> 
> Okay, I just had another look -- that won't work because as you correctly said, it still is on the freelist ...
> 
> So your fix is certainly correct :)
Many thanks for your effort and suggestion. :)

>
