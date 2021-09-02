Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB4933FEDF4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 14:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344668AbhIBMqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 08:46:54 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:19003 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344561AbhIBMqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 08:46:52 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4H0gY02qcjzbkW4;
        Thu,  2 Sep 2021 20:41:56 +0800 (CST)
Received: from [10.174.178.75] (10.174.178.75) by
 dggeme703-chm.china.huawei.com (10.1.199.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Thu, 2 Sep 2021 20:45:51 +0800
Subject: Re: [PATCH v2 5/5] mm/page_alloc.c: avoid allocating highmem pages
 via alloc_pages_exact[_nid]
To:     David Hildenbrand <david@redhat.com>, <akpm@linux-foundation.org>
CC:     <vbabka@suse.cz>, <sfr@canb.auug.org.au>, <peterz@infradead.org>,
        <mgorman@techsingularity.net>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20210902121242.41607-1-linmiaohe@huawei.com>
 <20210902121242.41607-6-linmiaohe@huawei.com>
 <1ef3dc5d-7eb9-90a5-afbf-f551afcf7d8b@redhat.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <0a14f77f-2242-e3e3-611b-6d23fdf51756@huawei.com>
Date:   Thu, 2 Sep 2021 20:45:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <1ef3dc5d-7eb9-90a5-afbf-f551afcf7d8b@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.75]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/9/2 20:16, David Hildenbrand wrote:
> On 02.09.21 14:12, Miaohe Lin wrote:
>> Don't use with __GFP_HIGHMEM because page_address() cannot represent
>> highmem pages without kmap(). Newly allocated pages would leak as
>> page_address() will return NULL for highmem pages here. But It works
>> now because the callers do not specify __GFP_HIGHMEM now.
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>   mm/page_alloc.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 9c09dcb24149..e1d0e27d005a 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -5614,8 +5614,8 @@ void *alloc_pages_exact(size_t size, gfp_t gfp_mask)
>>       unsigned int order = get_order(size);
>>       unsigned long addr;
>>   -    if (WARN_ON_ONCE(gfp_mask & __GFP_COMP))
>> -        gfp_mask &= ~__GFP_COMP;
>> +    if (WARN_ON_ONCE(gfp_mask & (__GFP_COMP | __GFP_HIGHMEM)))
>> +        gfp_mask &= ~(__GFP_COMP | __GFP_HIGHMEM);
>>         addr = __get_free_pages(gfp_mask, order);
>>       return make_alloc_exact(addr, order, size);
>> @@ -5639,8 +5639,8 @@ void * __meminit alloc_pages_exact_nid(int nid, size_t size, gfp_t gfp_mask)
>>       unsigned int order = get_order(size);
>>       struct page *p;
>>   -    if (WARN_ON_ONCE(gfp_mask & __GFP_COMP))
>> -        gfp_mask &= ~__GFP_COMP;
>> +    if (WARN_ON_ONCE(gfp_mask & (__GFP_COMP | __GFP_HIGHMEM)))
>> +        gfp_mask &= ~(__GFP_COMP | __GFP_HIGHMEM);
>>         p = alloc_pages_node(nid, gfp_mask, order);
>>       if (!p)
>>
> 
> Ideally we would convert this WARN_ON_ONCE() to pr_warn_once(), but I guess this really never ever happens on a production system and would get caught early while testing.
> 

This patch is mainly intended to make it clear that we simply can't call
alloc_pages_exact[_nid] with GFP_HIGHMEM. So this warning would never ever happens.

> Reviewed-by: David Hildenbrand <david@redhat.com>
> 

Many thanks for your review and reply.
