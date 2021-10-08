Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05506426243
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 04:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234188AbhJHCDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 22:03:06 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:13708 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbhJHCDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 22:03:05 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HQWbG6CpWzWqLf;
        Fri,  8 Oct 2021 09:59:38 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 dggeme703-chm.china.huawei.com (10.1.199.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Fri, 8 Oct 2021 10:01:08 +0800
Subject: Re: [PATCH 2/5] mm, slub: fix mismatch between reconstructed freelist
 depth and cnt
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     <gregkh@linuxfoundation.org>, <faiyazm@codeaurora.org>,
        <andreyknvl@gmail.com>, <ryabinin.a.a@gmail.com>,
        <thgarnie@google.com>, <keescook@chromium.org>,
        <bharata@linux.ibm.com>, <guro@fb.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
References: <20210916123920.48704-1-linmiaohe@huawei.com>
 <20210916123920.48704-3-linmiaohe@huawei.com>
 <3b0351d3-4753-1d69-a115-60b20c69656c@suse.cz>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <c8cbecc8-e176-e63d-1c7e-e624410f685f@huawei.com>
Date:   Fri, 8 Oct 2021 10:01:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <3b0351d3-4753-1d69-a115-60b20c69656c@suse.cz>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/10/5 17:57, Vlastimil Babka wrote:
> On 9/16/21 14:39, Miaohe Lin wrote:
>> If object's reuse is delayed, it will be excluded from the reconstructed
>> freelist. But we forgot to adjust the cnt accordingly. So there will be
>> a mismatch between reconstructed freelist depth and cnt. This will lead
>> to free_debug_processing() complain about freelist count or a incorrect
>> slub inuse count.
>>
>> Fixes: c3895391df38 ("kasan, slub: fix handling of kasan_slab_free hook")
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> 
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> 
> I was worried about taking pointer of the cnt parameter when it's hardcoded
> 1, whether it would destroy inlining. Looks like not, luckily, the function
> is just renamed:
> 

Many thanks for your review and thoughtful consideration! :)

>> ./scripts/bloat-o-meter mm/slub.o slub.o.after
> add/remove: 1/1 grow/shrink: 0/0 up/down: 292/-292 (0)
> Function                                     old     new   delta
> slab_free_freelist_hook.constprop              -     292    +292
> slab_free_freelist_hook                      292       -    -292
> 
>> ---
>>  mm/slub.c | 11 +++++++++--
>>  1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/slub.c b/mm/slub.c
>> index ed160b6c54f8..a56a6423d4e8 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -1701,7 +1701,8 @@ static __always_inline bool slab_free_hook(struct kmem_cache *s,
>>  }
>>  
>>  static inline bool slab_free_freelist_hook(struct kmem_cache *s,
>> -					   void **head, void **tail)
>> +					   void **head, void **tail,
>> +					   int *cnt)
>>  {
>>  
>>  	void *object;
>> @@ -1728,6 +1729,12 @@ static inline bool slab_free_freelist_hook(struct kmem_cache *s,
>>  			*head = object;
>>  			if (!*tail)
>>  				*tail = object;
>> +		} else {
>> +			/*
>> +			 * Adjust the reconstructed freelist depth
>> +			 * accordingly if object's reuse is delayed.
>> +			 */
>> +			--(*cnt);
>>  		}
>>  	} while (object != old_tail);
>>  
>> @@ -3480,7 +3487,7 @@ static __always_inline void slab_free(struct kmem_cache *s, struct page *page,
>>  	 * With KASAN enabled slab_free_freelist_hook modifies the freelist
>>  	 * to remove objects, whose reuse must be delayed.
>>  	 */
>> -	if (slab_free_freelist_hook(s, &head, &tail))
>> +	if (slab_free_freelist_hook(s, &head, &tail, &cnt))
>>  		do_slab_free(s, page, head, tail, cnt, addr);
>>  }
>>  
>>
> 
> .
> 

