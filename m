Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD933C7113
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 15:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236420AbhGMNQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 09:16:45 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:6810 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236265AbhGMNQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 09:16:44 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GPLXv595lzXp3J;
        Tue, 13 Jul 2021 21:08:15 +0800 (CST)
Received: from [10.174.178.125] (10.174.178.125) by
 dggeme703-chm.china.huawei.com (10.1.199.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 13 Jul 2021 21:13:51 +0800
Subject: Re: [PATCH 1/5] mm/vmscan: put the redirtied MADV_FREE pages back to
 anonymous LRU list
To:     Michal Hocko <mhocko@suse.com>
CC:     <akpm@linux-foundation.org>, <hannes@cmpxchg.org>,
        <vbabka@suse.cz>, <axboe@kernel.dk>, <iamjoonsoo.kim@lge.com>,
        <alexs@kernel.org>, <apopple@nvidia.com>, <willy@infradead.org>,
        <minchan@kernel.org>, <david@redhat.com>, <shli@fb.com>,
        <hillf.zj@alibaba-inc.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20210710100329.49174-1-linmiaohe@huawei.com>
 <20210710100329.49174-2-linmiaohe@huawei.com>
 <YOvtmy9ggJA4KUIQ@dhcp22.suse.cz>
 <9409189e-44f7-2608-68af-851629b6d453@huawei.com>
 <YO1dGvcTLaRJplRQ@dhcp22.suse.cz>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <ec86d902-1da5-2f49-7324-a796d32ac979@huawei.com>
Date:   Tue, 13 Jul 2021 21:13:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YO1dGvcTLaRJplRQ@dhcp22.suse.cz>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.125]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/7/13 17:30, Michal Hocko wrote:
> On Mon 12-07-21 19:03:39, Miaohe Lin wrote:
>> On 2021/7/12 15:22, Michal Hocko wrote:
>>> On Sat 10-07-21 18:03:25, Miaohe Lin wrote:
>>>> If the MADV_FREE pages are redirtied before they could be reclaimed, put
>>>> the pages back to anonymous LRU list by setting SwapBacked flag and the
>>>> pages will be reclaimed in normal swapout way. Otherwise MADV_FREE pages
>>>> won't be reclaimed as expected.
>>>
>>> Could you describe problem which you are trying to address? What does it
>>> mean that pages won't be reclaimed as expected?
>>>
>>
>> In fact, this is not a bug and harmless.
> 
> Fixes tag is then misleading and the changelog should be more clear
> about this as well.

Sure.

> 
>> But it looks buggy as it didn't perform
>> the expected ops from code view. Lazyfree (MADV_FREE) pages are clean anonymous
>> pages. They have SwapBacked flag cleared to distinguish normal anonymous pages.
> 
> yes.
> 
>> When the MADV_FREE pages are redirtied before they could be reclaimed, the pages
>> should be put back to anonymous LRU list by setting SwapBacked flag, thus the
>> pages will be reclaimed in normal swapout way.
> 
> Agreed. But the question is why this needs an explicit handling here
> when we already do handle this case when trying to unmap the page.

This makes me think more. It seems even the page_ref_freeze call is guaranteed to
success as no one can grab the page refcnt after the page is successfully unmapped.

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

> Please make sure to document the behavior you are observing, why it is
> not desirable.
> 
>> Many thanks for review and reply.
>>
>>> Also why is SetPageSwapBacked in shrink_page_list insufficient?
> 
> Sorry I meant to say try_to_unmap path here
> 
>>>> Fixes: 802a3a92ad7a ("mm: reclaim MADV_FREE pages")
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
>>>>  			if (!page_ref_freeze(page, 1))
>>>>  				goto keep_locked;
>>>>  			if (PageDirty(page)) {
>>>> +				SetPageSwapBacked(page);
>>>>  				page_ref_unfreeze(page, 1);
>>>>  				goto keep_locked;
>>>>  			}
>>>> -- 
>>>> 2.23.0
>>>
> 

