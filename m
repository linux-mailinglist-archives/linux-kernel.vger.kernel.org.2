Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C71DA442A18
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 10:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbhKBJJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 05:09:41 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:15342 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhKBJJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 05:09:31 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Hk3tZ16Jdz90lF;
        Tue,  2 Nov 2021 17:06:46 +0800 (CST)
Received: from dggpeml500024.china.huawei.com (7.185.36.10) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Tue, 2 Nov 2021 17:06:54 +0800
Received: from [10.174.176.231] (10.174.176.231) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Tue, 2 Nov 2021 17:06:53 +0800
Subject: Re: [PATCH] mm, slub: place the trace before freeing memory in
 kmem_cache_free()
To:     John Hubbard <jhubbard@nvidia.com>, <cl@linux.com>,
        <penberg@kernel.org>, <rientjes@google.com>,
        <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, <vbabka@suse.cz>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC:     <wuxu.wu@huawei.com>, Hewenliang <hewenliang4@huawei.com>
References: <867f6da4-6d38-6435-3fbb-a2a3744029f1@huawei.com>
 <df216633-cc14-6c3b-29ed-cdce136402eb@nvidia.com>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Message-ID: <2ea4e792-816c-a734-db1f-388516c74ea9@huawei.com>
Date:   Tue, 2 Nov 2021 17:06:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <df216633-cc14-6c3b-29ed-cdce136402eb@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.231]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500024.china.huawei.com (7.185.36.10)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/11/2 15:03, John Hubbard wrote:
> On 10/30/21 03:11, Yunfeng Ye wrote:
>> After the memory is freed, it may be allocated by other CPUs and has
>> been recorded by trace. So the timing sequence of the memory tracing is
>> inaccurate.
>>
>> For example, we expect the following timing sequeuce:
>>
>>      CPU 0                 CPU 1
>>
>>    (1) alloc xxxxxx
>>    (2) free  xxxxxx
>>                           (3) alloc xxxxxx
>>                           (4) free  xxxxxx
>>
>> However, the following timing sequence may occur:
>>
>>      CPU 0                 CPU 1
>>
>>    (1) alloc xxxxxx
>>                           (2) alloc xxxxxx
>>    (3) free  xxxxxx
>>                           (4) free  xxxxxx
>>
>> So place the trace before freeing memory in kmem_cache_free().
> 
> Hi Yunfeng,
> 
> Like Muchun, I had some difficulty with the above description, but
> now I think I get it. :)
> 
> In order to make it easier for others, how about this wording and subject
> line, instead:
> 
Ok,I will modify the description in the next version patch.

Thanks.
> 
> mm, slub: emit the "free" trace report before freeing memory in kmem_cache_free()
> 
> After the memory is freed, it can be immediately allocated by other
> CPUs, before the "free" trace report has been emitted. This causes
> inaccurate traces.
> 
> For example, if the following sequence of events occurs:
> 
>     CPU 0                 CPU 1
> 
>   (1) alloc xxxxxx
>   (2) free  xxxxxx
>                          (3) alloc xxxxxx
>                          (4) free  xxxxxx
> 
> ...then they will be inaccurately reported via tracing, so that they
> appear to have happened in this order. This makes it look like CPU 1
> somehow managed to allocate mmemory that CPU 0 still had allocated for
> itself:
> 
>     CPU 0                 CPU 1
> 
>   (1) alloc xxxxxx
>                          (2) alloc xxxxxx
>   (3) free  xxxxxx
>                          (4) free  xxxxxx
> 
> In order to avoid this, emit the "free xxxxxx" tracing report just
> before the actual call to free the memory, instead of just after it.
> 
> 
>>
>> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
>> ---
>>   mm/slub.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/slub.c b/mm/slub.c
>> index 432145d7b4ec..427e62034c3f 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -3526,8 +3526,8 @@ void kmem_cache_free(struct kmem_cache *s, void *x)
>>       s = cache_from_obj(s, x);
>>       if (!s)
>>           return;
>> -    slab_free(s, virt_to_head_page(x), x, NULL, 1, _RET_IP_);
>>       trace_kmem_cache_free(_RET_IP_, x, s->name);
>> +    slab_free(s, virt_to_head_page(x), x, NULL, 1, _RET_IP_);
>>   }
>>   EXPORT_SYMBOL(kmem_cache_free);
>>
> 
> ...the diffs seem correct, too, but I'm not exactly a slub reviewer, so
> take that for what it's worth.
> 
> 
> thanks,
