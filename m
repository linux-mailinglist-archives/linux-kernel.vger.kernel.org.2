Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 981DB401B64
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 14:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242261AbhIFMqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 08:46:22 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:19011 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242199AbhIFMqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 08:46:21 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4H37LL6hX4zbkXS;
        Mon,  6 Sep 2021 20:41:14 +0800 (CST)
Received: from [10.174.178.100] (10.174.178.100) by
 dggeme703-chm.china.huawei.com (10.1.199.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Mon, 6 Sep 2021 20:45:13 +0800
Subject: Re: [PATCH] mm/page_isolation: don't putback unisolated page
To:     David Hildenbrand <david@redhat.com>, <akpm@linux-foundation.org>
CC:     <vbabka@suse.cz>, <iamjoonsoo.kim@lge.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20210904091839.20270-1-linmiaohe@huawei.com>
 <3b36529f-ab97-ddfe-0407-66f0cd1fd38d@redhat.com>
 <2d06db75-5c26-8fe2-6883-ac99056a9894@redhat.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <b0a2947b-360a-40c2-03e4-f0f67845f4c3@huawei.com>
Date:   Mon, 6 Sep 2021 20:45:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <2d06db75-5c26-8fe2-6883-ac99056a9894@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.100]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/9/6 20:11, David Hildenbrand wrote:
> On 06.09.21 14:02, David Hildenbrand wrote:
>> On 04.09.21 11:18, Miaohe Lin wrote:
>>> If __isolate_free_page() failed, due to zone watermark check, the page is
>>> still on the free list. But this page will be put back to free list again
>>> via __putback_isolated_page() now. This may trigger page->flags checks in
>>> __free_one_page() if PageReported is set. Or we will corrupt the free list
>>> because list_add() will be called for pages already on another list.
>>>
>>> Fixes: 3c605096d315 ("mm/page_alloc: restrict max order of merging on isolated pageblock")
>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>>> ---
>>>    mm/page_isolation.c | 6 ++----
>>>    1 file changed, 2 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
>>> index 9bb562d5d194..7d70d772525c 100644
>>> --- a/mm/page_isolation.c
>>> +++ b/mm/page_isolation.c
>>> @@ -93,10 +93,8 @@ static void unset_migratetype_isolate(struct page *page, unsigned migratetype)
>>>                buddy_pfn = __find_buddy_pfn(pfn, order);
>>>                buddy = page + (buddy_pfn - pfn);
>>>    -            if (!is_migrate_isolate_page(buddy)) {
>>> -                __isolate_free_page(page, order);
>>> -                isolated_page = true;
>>> -            }
>>> +            if (!is_migrate_isolate_page(buddy))
>>> +                isolated_page = !!__isolate_free_page(page, order);
>>>            }
>>>        }
>>>   
>>
>> Thanks!
>>
>> Reviewed-by: David Hildenbrand <david@redhat.com>
>>
> 
> To make the confusion perfect (sorry) :D I tripple-checked:
> 
> In unset_migratetype_isolate() we check that is_migrate_isolate_page(page) holds, otherwise we return.
> 
> We call __isolate_free_page() only for such pages.
> 
> __isolate_free_page() won't perform watermark checks on is_migrate_isolate().
> 
> Consequently, __isolate_free_page() should never fail when called from unset_migratetype_isolate()
> 
> If that's correct then we  could instead maybe add a VM_BUG_ON() and a comment why this can't fail.
> 
> 
> Makes sense or am I missing something?

I think you're right. __isolate_free_page() should never fail when called from unset_migratetype_isolate()
as explained by you. But it might be too fragile to reply on the failure conditions of __isolate_free_page().
If that changes, VM_BUG_ON() here might trigger unexpectedly. Or am I just over-worried as failure conditions
of __isolate_free_page() can hardly change?

Many thanks. :)

> 

