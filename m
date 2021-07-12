Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 908833C5B22
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 13:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235434AbhGLLGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 07:06:34 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:10471 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235410AbhGLLGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 07:06:30 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GNglr0hmxzccSn;
        Mon, 12 Jul 2021 19:00:24 +0800 (CST)
Received: from [10.174.178.125] (10.174.178.125) by
 dggeme703-chm.china.huawei.com (10.1.199.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 12 Jul 2021 19:03:39 +0800
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
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <9409189e-44f7-2608-68af-851629b6d453@huawei.com>
Date:   Mon, 12 Jul 2021 19:03:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YOvtmy9ggJA4KUIQ@dhcp22.suse.cz>
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

On 2021/7/12 15:22, Michal Hocko wrote:
> On Sat 10-07-21 18:03:25, Miaohe Lin wrote:
>> If the MADV_FREE pages are redirtied before they could be reclaimed, put
>> the pages back to anonymous LRU list by setting SwapBacked flag and the
>> pages will be reclaimed in normal swapout way. Otherwise MADV_FREE pages
>> won't be reclaimed as expected.
> 
> Could you describe problem which you are trying to address? What does it
> mean that pages won't be reclaimed as expected?
> 

In fact, this is not a bug and harmless. But it looks buggy as it didn't perform
the expected ops from code view. Lazyfree (MADV_FREE) pages are clean anonymous
pages. They have SwapBacked flag cleared to distinguish normal anonymous pages.
When the MADV_FREE pages are redirtied before they could be reclaimed, the pages
should be put back to anonymous LRU list by setting SwapBacked flag, thus the
pages will be reclaimed in normal swapout way.

Many thanks for review and reply.

> Also why is SetPageSwapBacked in shrink_page_list insufficient?
> 
>> Fixes: 802a3a92ad7a ("mm: reclaim MADV_FREE pages")
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
>>  			if (!page_ref_freeze(page, 1))
>>  				goto keep_locked;
>>  			if (PageDirty(page)) {
>> +				SetPageSwapBacked(page);
>>  				page_ref_unfreeze(page, 1);
>>  				goto keep_locked;
>>  			}
>> -- 
>> 2.23.0
> 

