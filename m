Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E23953FD4DC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 10:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242896AbhIAIFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 04:05:32 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:8994 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232072AbhIAIFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 04:05:31 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GzxQX6Wt1zYvtS;
        Wed,  1 Sep 2021 16:03:48 +0800 (CST)
Received: from [10.174.178.75] (10.174.178.75) by
 dggeme703-chm.china.huawei.com (10.1.199.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Wed, 1 Sep 2021 16:04:30 +0800
Subject: Re: [PATCH 5/6] mm/page_alloc.c: avoid accessing uninitialized pcp
 page migratetype
To:     Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>
CC:     <akpm@linux-foundation.org>, <sfr@canb.auug.org.au>,
        <peterz@infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20210830141051.64090-1-linmiaohe@huawei.com>
 <20210830141051.64090-6-linmiaohe@huawei.com>
 <20210831134311.GG4128@techsingularity.net>
 <00a73cf9-b2e8-116b-dc9c-fc5e2aacb1a1@suse.cz>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <55d7b921-f51c-0c1e-82a8-c9e6148e2115@huawei.com>
Date:   Wed, 1 Sep 2021 16:04:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <00a73cf9-b2e8-116b-dc9c-fc5e2aacb1a1@suse.cz>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.75]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/9/1 0:34, Vlastimil Babka wrote:
> On 8/31/21 15:43, Mel Gorman wrote:
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
> Also Cc: stable, please.
> 
> 

Will do. Many thanks for both of your suggestions!

> 
> .
> 

