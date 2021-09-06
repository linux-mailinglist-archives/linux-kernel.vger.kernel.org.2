Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4204018FC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 11:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241200AbhIFJkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 05:40:10 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:15241 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239548AbhIFJkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 05:40:05 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4H33H65l13z1DGjC;
        Mon,  6 Sep 2021 17:38:10 +0800 (CST)
Received: from [10.174.178.100] (10.174.178.100) by
 dggeme703-chm.china.huawei.com (10.1.199.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Mon, 6 Sep 2021 17:38:59 +0800
Subject: Re: [PATCH] mm/page_isolation: fix potential missing call to
 unset_migratetype_isolate()
To:     David Hildenbrand <david@redhat.com>, <akpm@linux-foundation.org>
CC:     <mhocko@suse.com>, <vbabka@suse.cz>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20210904092053.33037-1-linmiaohe@huawei.com>
 <dcfcacf2-0018-3b91-6da5-2420bad889c1@redhat.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <ebbef13c-921e-c385-1233-a7aeecec6127@huawei.com>
Date:   Mon, 6 Sep 2021 17:38:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <dcfcacf2-0018-3b91-6da5-2420bad889c1@redhat.com>
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

On 2021/9/6 17:27, David Hildenbrand wrote:
> On 04.09.21 11:20, Miaohe Lin wrote:
>> In start_isolate_page_range() undo path, pfn_to_online_page() just checks
>> the first pfn in a pageblock while __first_valid_page() will traverse the
>> pageblock until the first online pfn is found. So we may miss the call to
>> unset_migratetype_isolate() in undo path and pages will remain isolated
>> unexpectedly. Fix this by calling undo_isolate_page_range() and this will
>> also help to remove some duplicated codes.
>>
>> Fixes: 2ce13640b3f4 ("mm: __first_valid_page skip over offline pages")
> 
> While that is true, we shouldn't ever trigger, neither via cma, virtio-mem nor memory offlining, because essentially all operate on MAX_ORDER -1 -aligned ranges without memory holes.

I think this should never trigger too. It's a theoretical issue. So is the Fixes tag necessary ?

> 
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>   mm/page_isolation.c | 9 +--------
>>   1 file changed, 1 insertion(+), 8 deletions(-)
>>
>> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
>> index 471e3a13b541..9bb562d5d194 100644
>> --- a/mm/page_isolation.c
>> +++ b/mm/page_isolation.c
>> @@ -202,14 +202,7 @@ int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
>>       }
>>       return 0;
>>   undo:
>> -    for (pfn = start_pfn;
>> -         pfn < undo_pfn;
>> -         pfn += pageblock_nr_pages) {
>> -        struct page *page = pfn_to_online_page(pfn);
>> -        if (!page)
>> -            continue;
>> -        unset_migratetype_isolate(page, migratetype);
>> -    }
>> +    undo_isolate_page_range(start_pfn, undo_pfn, migratetype);
>>   
> 
> It'd be even cleaner to drop the label completely and call it from the single callsite. We can even avoid undo_pfn ...
> 
> if (page && set_migratetype_isolate(page, migratetype, flags)) {
>     undo_isolate_page_range(start_pfn, pfn, migratetype);
>     return -EBUSY;
> }
> 

Looks much better. Will do it later. Many thanks. :)

> If pfn == start_pfn, undo_isolate_page_range() will simply do nothing.
> 
>>       return -EBUSY;
>>   }
>>
> 

