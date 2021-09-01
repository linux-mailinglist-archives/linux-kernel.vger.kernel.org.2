Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8A73FD4DA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 10:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242899AbhIAIDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 04:03:47 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:14445 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242777AbhIAIDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 04:03:41 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GzxJj1BmyzbdQC;
        Wed,  1 Sep 2021 15:58:45 +0800 (CST)
Received: from [10.174.178.75] (10.174.178.75) by
 dggeme703-chm.china.huawei.com (10.1.199.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Wed, 1 Sep 2021 16:02:40 +0800
Subject: Re: [PATCH 5/6] mm/page_alloc.c: avoid accessing uninitialized pcp
 page migratetype
To:     David Hildenbrand <david@redhat.com>
CC:     <akpm@linux-foundation.org>, <vbabka@suse.cz>,
        <sfr@canb.auug.org.au>, <peterz@infradead.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
References: <20210830141051.64090-1-linmiaohe@huawei.com>
 <20210830141051.64090-6-linmiaohe@huawei.com>
 <20210831134311.GG4128@techsingularity.net>
 <877b7043-65c3-5e08-ac89-ad6f10e354b3@redhat.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <f801cd23-6897-53c7-a689-2ade60578d7e@huawei.com>
Date:   Wed, 1 Sep 2021 16:02:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <877b7043-65c3-5e08-ac89-ad6f10e354b3@redhat.com>
Content-Type: text/plain; charset="iso-8859-15"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.75]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/8/31 22:23, David Hildenbrand wrote:
> On 31.08.21 15:43, Mel Gorman wrote:
>> On Mon, Aug 30, 2021 at 10:10:50PM +0800, Miaohe Lin wrote:
>>> If it's not prepared to free unref page, the pcp page migratetype is
>>> unset. Thus We will get rubbish from get_pcppage_migratetype() and
>>> might list_del &page->lru again after it's already deleted from the
>>> list leading to grumble about data corruption.
>>>
>>> Fixes: 3dcbe270d8ec ("mm/page_alloc: avoid conflating IRQs disabled with zone->lock")
>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>>
>> Acked-by: Mel Gorman <mgorman@techsingularity.net>
>>
>> This fix is fairly important. Take this patch out and send it on its own
>> so it gets picked up relatively quickly. It does not belong in a series
>> that is mostly cosmetic cleanups.
> 
> I think the commit id is wrong. Shouldn't that be
> 
> df1acc856923 ("mm/page_alloc: avoid conflating IRQs disabled with zone->lock")
> 
> ?
> 

Many thanks for pointing this out.

I used to save the git log in a file to make life easier. But it seems this leads
to the old commit id above.

commit 3dcbe270d8ec57e534f5c605279cdc3ceb1f044a
Author: Mel Gorman <mgorman@techsingularity.net>
Date:   Fri Jun 4 14:20:03 2021 +1000

    mm/page_alloc: avoid conflating IRQs disabled with zone->lock

git name-rev 3dcbe270d8ec
3dcbe270d8ec tags/next-20210604~2^2~196

vs

commit df1acc856923c0a65c28b588585449106c316b71
Author: Mel Gorman <mgorman@techsingularity.net>
Date:   Mon Jun 28 19:42:00 2021 -0700

    mm/page_alloc: avoid conflating IRQs disabled with zone->lock

git name-rev df1acc856923
df1acc856923 tags/next-20210630~2^2~278

Their contents are same but with different commit id. The previous one
could have been git-rebased.
