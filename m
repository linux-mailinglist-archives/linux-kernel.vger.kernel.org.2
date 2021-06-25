Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0AEC3B3FB0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 10:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbhFYIs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 04:48:57 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:5078 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbhFYIs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 04:48:56 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GB9TD4CcTzXkcs;
        Fri, 25 Jun 2021 16:41:20 +0800 (CST)
Received: from [10.174.177.120] (10.174.177.120) by
 dggeme703-chm.china.huawei.com (10.1.199.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 25 Jun 2021 16:46:33 +0800
Subject: Re: [Phishing Risk] [External] [PATCH 2/3] mm/zsmalloc.c: combine two
 atomic ops in zs_pool_dec_isolated()
To:     Muchun Song <songmuchun@bytedance.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>, <ngupta@vflare.org>,
        <senozhatsky@chromium.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
References: <20210624123930.1769093-1-linmiaohe@huawei.com>
 <20210624123930.1769093-3-linmiaohe@huawei.com>
 <CAMZfGtUNtR3ZPv4m5bBCGdE5GuMR5Bw18_n7YzqB4s6QHyV+Pg@mail.gmail.com>
 <1b38b33f-316e-1816-216f-9923f612ceb6@huawei.com>
 <CAMZfGtXnYxumuNau2rvk+ivPEa-ows0KD4EWFBjCiM6e_iagtg@mail.gmail.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <01117bc0-53b1-d81a-a4d8-2a1dbe5dcd94@huawei.com>
Date:   Fri, 25 Jun 2021 16:46:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAMZfGtXnYxumuNau2rvk+ivPEa-ows0KD4EWFBjCiM6e_iagtg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.120]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/6/25 15:29, Muchun Song wrote:
> On Fri, Jun 25, 2021 at 2:32 PM Miaohe Lin <linmiaohe@huawei.com> wrote:
>>
>> On 2021/6/25 13:01, Muchun Song wrote:
>>> On Thu, Jun 24, 2021 at 8:40 PM Miaohe Lin <linmiaohe@huawei.com> wrote:
>>>>
>>>> atomic_long_dec_and_test() is equivalent to atomic_long_dec() and
>>>> atomic_long_read() == 0. Use it to make code more succinct.
>>>
>>> Actually, they are not equal. atomic_long_dec_and_test implies a
>>> full memory barrier around it but atomic_long_dec and atomic_long_read
>>> don't.
>>>
>>
>> Many thanks for comment. They are indeed not completely equal as you said.
>> What I mean is they can do the same things we want in this specified context.
>> Thanks again.
> 
> I don't think so. Using individual operations can eliminate memory barriers.
> We will pay for the barrier if we use atomic_long_dec_and_test here.

The combination of atomic_long_dec and atomic_long_read usecase is rare and looks somehow
weird. I think it's worth to do this with the cost of barrier.

> 
>>
>>> That RMW operations that have a return value is equal to the following.
>>>
>>> smp_mb__before_atomic()
>>> non-RMW operations or RMW operations that have no return value
>>> smp_mb__after_atomic()
>>>
>>> Thanks.
>>>
>>>>
>>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>>>> ---
>>>>  mm/zsmalloc.c | 3 +--
>>>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>>>
>>>> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
>>>> index 1476289b619f..0b4b23740d78 100644
>>>> --- a/mm/zsmalloc.c
>>>> +++ b/mm/zsmalloc.c
>>>> @@ -1828,13 +1828,12 @@ static void putback_zspage_deferred(struct zs_pool *pool,
>>>>  static inline void zs_pool_dec_isolated(struct zs_pool *pool)
>>>>  {
>>>>         VM_BUG_ON(atomic_long_read(&pool->isolated_pages) <= 0);
>>>> -       atomic_long_dec(&pool->isolated_pages);
>>>>         /*
>>>>          * There's no possibility of racing, since wait_for_isolated_drain()
>>>>          * checks the isolated count under &class->lock after enqueuing
>>>>          * on migration_wait.
>>>>          */
>>>> -       if (atomic_long_read(&pool->isolated_pages) == 0 && pool->destroying)
>>>> +       if (atomic_long_dec_and_test(&pool->isolated_pages) && pool->destroying)
>>>>                 wake_up_all(&pool->migration_wait);
>>>>  }
>>>>
>>>> --
>>>> 2.23.0
>>>>
>>> .
>>>
>>
> .
> 

