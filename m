Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8627A408B42
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 14:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236267AbhIMMoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 08:44:55 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:15407 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236172AbhIMMoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 08:44:54 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4H7Qz75J3xzQq7M;
        Mon, 13 Sep 2021 20:39:31 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 dggeme703-chm.china.huawei.com (10.1.199.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Mon, 13 Sep 2021 20:43:36 +0800
Subject: Re: [PATCH v2] mm/page_isolation: fix potential missing call to
 unset_migratetype_isolate()
To:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>
CC:     <akpm@linux-foundation.org>, <vbabka@suse.cz>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20210913115125.33617-1-linmiaohe@huawei.com>
 <YT9AS6I1Th14mCxh@dhcp22.suse.cz>
 <e1e772b8-b9a7-0182-c469-73f32cda005e@redhat.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <6cb372ff-0b68-2143-913e-04ab3e6b4160@huawei.com>
Date:   Mon, 13 Sep 2021 20:43:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <e1e772b8-b9a7-0182-c469-73f32cda005e@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/9/13 20:20, David Hildenbrand wrote:
> On 13.09.21 14:12, Michal Hocko wrote:
>> On Mon 13-09-21 19:51:25, Miaohe Lin wrote:
>>> In start_isolate_page_range() undo path, pfn_to_online_page() just checks
>>> the first pfn in a pageblock while __first_valid_page() will traverse the
>>> pageblock until the first online pfn is found. So we may miss the call to
>>> unset_migratetype_isolate() in undo path and pages will remain isolated
>>> unexpectedly. Fix this by calling undo_isolate_page_range() and this will
>>> also help to simplify the code further.
>>
>> I like the clean up part but is this a real problem that requires CC
>> stable? Have you ever seen this to be a real problem? It looks like
>> something based on reading the code.

I'm sorry but I haven't seen this to be a real problem. It's a theoretical bug.

> 
> We discussed that it isn't an issue anymore (we never call it on memory holes), but might have been an issue on older kernels, back when we didn't have the "memory holes" check in the memory offlining path in place.

So is the Cc:stable needed in this case?

Many thanks for both of you.

> 
> Agreed, these details belong into this description.
> 
>>
>>> Fixes: 2ce13640b3f4 ("mm: __first_valid_page skip over offline pages")
>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>>> Cc: <stable@vger.kernel.org>
>>> ---
>>> v1->v2:
>>>    Simplify the code further per David Hildenbrand.
>>> ---
>>>   mm/page_isolation.c | 20 +++-----------------
>>>   1 file changed, 3 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
>>> index a95c2c6562d0..f93cc63d8fa1 100644
>>> --- a/mm/page_isolation.c
>>> +++ b/mm/page_isolation.c
>>> @@ -183,7 +183,6 @@ int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
>>>                    unsigned migratetype, int flags)
>>>   {
>>>       unsigned long pfn;
>>> -    unsigned long undo_pfn;
>>>       struct page *page;
>>>         BUG_ON(!IS_ALIGNED(start_pfn, pageblock_nr_pages));
>>> @@ -193,25 +192,12 @@ int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
>>>            pfn < end_pfn;
>>>            pfn += pageblock_nr_pages) {
>>>           page = __first_valid_page(pfn, pageblock_nr_pages);
>>> -        if (page) {
>>> -            if (set_migratetype_isolate(page, migratetype, flags)) {
>>> -                undo_pfn = pfn;
>>> -                goto undo;
>>> -            }
>>> +        if (page && set_migratetype_isolate(page, migratetype, flags)) {
>>> +            undo_isolate_page_range(start_pfn, pfn, migratetype);
>>> +            return -EBUSY;
>>>           }
>>>       }
>>>       return 0;
>>> -undo:
>>> -    for (pfn = start_pfn;
>>> -         pfn < undo_pfn;
>>> -         pfn += pageblock_nr_pages) {
>>> -        struct page *page = pfn_to_online_page(pfn);
>>> -        if (!page)
>>> -            continue;
>>> -        unset_migratetype_isolate(page, migratetype);
>>> -    }
>>> -
>>> -    return -EBUSY;
>>>   }
>>>     /*
>>> -- 
>>> 2.23.0
>>
> 
> 

