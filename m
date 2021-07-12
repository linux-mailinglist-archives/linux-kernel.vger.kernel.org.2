Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 319D93C52C2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 12:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347184AbhGLHtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 03:49:24 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:10355 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241589AbhGLHOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 03:14:48 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4GNZb64GP0z78WH;
        Mon, 12 Jul 2021 15:07:30 +0800 (CST)
Received: from [10.174.178.125] (10.174.178.125) by
 dggeme703-chm.china.huawei.com (10.1.199.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 12 Jul 2021 15:11:56 +0800
Subject: Re: [PATCH 1/5] mm/vmscan: put the redirtied MADV_FREE pages back to
 anonymous LRU list
To:     Yu Zhao <yuzhao@google.com>
CC:     <akpm@linux-foundation.org>, <hannes@cmpxchg.org>,
        <vbabka@suse.cz>, <mhocko@suse.com>, <axboe@kernel.dk>,
        <iamjoonsoo.kim@lge.com>, <alexs@kernel.org>, <apopple@nvidia.com>,
        <willy@infradead.org>, <minchan@kernel.org>, <david@redhat.com>,
        <shli@fb.com>, <hillf.zj@alibaba-inc.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20210710100329.49174-1-linmiaohe@huawei.com>
 <20210710100329.49174-2-linmiaohe@huawei.com>
 <CAOUHufZpU4uQOBb4p10uCXs-40MeETRUmGiqy96Eim1w3o_dgQ@mail.gmail.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <022f2f7c-fc03-182a-1f8f-4b77c0731d4f@huawei.com>
Date:   Mon, 12 Jul 2021 15:11:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAOUHufZpU4uQOBb4p10uCXs-40MeETRUmGiqy96Eim1w3o_dgQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.125]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/7/11 7:22, Yu Zhao wrote:
> On Sat, Jul 10, 2021 at 4:03 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
>>
>> If the MADV_FREE pages are redirtied before they could be reclaimed, put
>> the pages back to anonymous LRU list by setting SwapBacked flag and the
>> pages will be reclaimed in normal swapout way. Otherwise MADV_FREE pages
>> won't be reclaimed as expected.
>>
>> Fixes: 802a3a92ad7a ("mm: reclaim MADV_FREE pages")
> 
> This is not a bug -- the dirty check isn't needed but it was copied
> from __remove_mapping().

Yes, this is not a bug and harmless. When we reach here, page should not be
dirtied because PageDirty is handled above and there is no way to redirty it
again as pagetable references are all gone and it's not in the swap cache.

> 
> The page has only one reference left, which is from the isolation.
> After the caller puts the page back on lru and drops the reference,
> the page will be freed anyway. It doesn't matter which lru it goes.

But it looks buggy as it didn't perform the expected ops from code view.
Should I drop the Fixes tag and send a v2 version?

Many thanks for reply!

> 
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  mm/vmscan.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index a7602f71ec04..6483fe0e2065 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -1628,6 +1628,7 @@ static unsigned int shrink_page_list(struct list_head *page_list,
>>                         if (!page_ref_freeze(page, 1))
>>                                 goto keep_locked;
>>                         if (PageDirty(page)) {
>> +                               SetPageSwapBacked(page);
>>                                 page_ref_unfreeze(page, 1);
>>                                 goto keep_locked;
>>                         }
>> --
>> 2.23.0
>>
>>
> .
> 

