Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2829A3C7118
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 15:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236450AbhGMNTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 09:19:45 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:11271 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236283AbhGMNTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 09:19:44 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4GPLcM2LLNz1CJQh;
        Tue, 13 Jul 2021 21:11:15 +0800 (CST)
Received: from [10.174.178.125] (10.174.178.125) by
 dggeme703-chm.china.huawei.com (10.1.199.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 13 Jul 2021 21:16:51 +0800
Subject: Re: [PATCH 1/5] mm/vmscan: put the redirtied MADV_FREE pages back to
 anonymous LRU list
To:     Yu Zhao <yuzhao@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Alex Shi <alexs@kernel.org>, <apopple@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Minchan Kim <minchan@kernel.org>,
        David Hildenbrand <david@redhat.com>, <shli@fb.com>,
        <hillf.zj@alibaba-inc.com>, Linux-MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210710100329.49174-1-linmiaohe@huawei.com>
 <20210710100329.49174-2-linmiaohe@huawei.com>
 <CAOUHufZpU4uQOBb4p10uCXs-40MeETRUmGiqy96Eim1w3o_dgQ@mail.gmail.com>
 <022f2f7c-fc03-182a-1f8f-4b77c0731d4f@huawei.com>
 <CAOUHufaEPKj4VU1qbjuqsr53rjVwhEXdRCC_C=LBOF0KTveBfQ@mail.gmail.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <ff349ed2-14b5-8583-0c0c-725990d965e0@huawei.com>
Date:   Tue, 13 Jul 2021 21:16:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAOUHufaEPKj4VU1qbjuqsr53rjVwhEXdRCC_C=LBOF0KTveBfQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.125]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/7/13 15:25, Yu Zhao wrote:
> On Mon, Jul 12, 2021 at 1:12 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
>>
>> On 2021/7/11 7:22, Yu Zhao wrote:
>>> On Sat, Jul 10, 2021 at 4:03 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
>>>>
>>>> If the MADV_FREE pages are redirtied before they could be reclaimed, put
>>>> the pages back to anonymous LRU list by setting SwapBacked flag and the
>>>> pages will be reclaimed in normal swapout way. Otherwise MADV_FREE pages
>>>> won't be reclaimed as expected.
>>>>
>>>> Fixes: 802a3a92ad7a ("mm: reclaim MADV_FREE pages")
>>>
>>> This is not a bug -- the dirty check isn't needed but it was copied
>>> from __remove_mapping().
>>
>> Yes, this is not a bug and harmless. When we reach here, page should not be
>> dirtied because PageDirty is handled above and there is no way to redirty it
>> again as pagetable references are all gone and it's not in the swap cache.
>>
>>>
>>> The page has only one reference left, which is from the isolation.
>>> After the caller puts the page back on lru and drops the reference,
>>> the page will be freed anyway. It doesn't matter which lru it goes.
>>
>> But it looks buggy as it didn't perform the expected ops from code view.
>> Should I drop the Fixes tag and send a v2 version?
> 
> I don't understand the logic here -- it looks pretty obvious to me
> that, if we want to change anything, we should delete the dirty check,
> not add another line that would enforce the belief that the dirty
> check is needed.
> 

The dirty check could be removed even with the page_ref_freeze check because no one can grab
the page refcnt after the page is successfully unmapped.

Does the change below makes sense for you?

Many Thanks.

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 6e26b3c93242..c31925320b33 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1624,15 +1624,11 @@ static unsigned int shrink_page_list(struct list_head *page_list,
                }

                if (PageAnon(page) && !PageSwapBacked(page)) {
-                       /* follow __remove_mapping for reference */
-                       if (!page_ref_freeze(page, 1))
-                               goto keep_locked;
-                       if (PageDirty(page)) {
-                               SetPageSwapBacked(page);
-                               page_ref_unfreeze(page, 1);
-                               goto keep_locked;
-                       }
-
+                       /*
+                        * No one can grab the page refcnt or redirty the page
+                        * after the page is successfully unmapped.
+                        */
+                       WARN_ON_ONCE(!page_ref_freeze(page, 1));
                        count_vm_event(PGLAZYFREED);
                        count_memcg_page_event(page, PGLAZYFREED);
                } else if (!mapping || !__remove_mapping(mapping, page, true,

>>
>> Many thanks for reply!
>>
>>>
>>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>>>> ---
>>>>  mm/vmscan.c | 1 +
>>>>  1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>>>> index a7602f71ec04..6483fe0e2065 100644
>>>> --- a/mm/vmscan.c
>>>> +++ b/mm/vmscan.c
>>>> @@ -1628,6 +1628,7 @@ static unsigned int shrink_page_list(struct list_head *page_list,
>>>>                         if (!page_ref_freeze(page, 1))
>>>>                                 goto keep_locked;
>>>>                         if (PageDirty(page)) {
>>>> +                               SetPageSwapBacked(page);
>>>>                                 page_ref_unfreeze(page, 1);
>>>>                                 goto keep_locked;
>>>>                         }
>>>> --
>>>> 2.23.0
>>>>
>>>>
>>> .
>>>
>>
> .
> 

