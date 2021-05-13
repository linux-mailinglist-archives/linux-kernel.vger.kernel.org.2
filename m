Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 215AA37F6AC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 13:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233247AbhEML2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 07:28:20 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3746 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbhEML2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 07:28:18 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Fgq6R5jLBzqTYq;
        Thu, 13 May 2021 19:23:43 +0800 (CST)
Received: from [10.174.176.232] (10.174.176.232) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Thu, 13 May 2021 19:27:05 +0800
Subject: Re: [PATCH] mm, swap: Remove unnecessary smp_rmb() in
 swap_type_to_swap_info()
To:     Muchun Song <smuchun@gmail.com>
CC:     Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, linux-kernel <linux-kernel@vger.kernel.org>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Omar Sandoval <osandov@fb.com>,
        Paul McKenney <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>,
        Will Deacon <will.deacon@arm.com>
References: <20210513064837.3949064-1-ying.huang@intel.com>
 <176421ba-77d9-8422-21e0-b5e2951533bd@huawei.com>
 <CAPSr9jEtdSgr5kDX=ESUrVtbuonUNEeFsOHpYYoFxD3PQ20C2A@mail.gmail.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <68166038-7b89-8cea-9549-0e454bd0c031@huawei.com>
Date:   Thu, 13 May 2021 19:27:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAPSr9jEtdSgr5kDX=ESUrVtbuonUNEeFsOHpYYoFxD3PQ20C2A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.232]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/5/13 17:54, Muchun Song wrote:
> On Thu, May 13, 2021 at 5:11 PM Miaohe Lin <linmiaohe@huawei.com> wrote:
>>
>> On 2021/5/13 14:48, Huang Ying wrote:
>>> Before commit c10d38cc8d3e ("mm, swap: bounds check swap_info array
>>> accesses to avoid NULL derefs"), the typical code to reference the
>>> swap_info[] is as follows,
>>>
>>>   type = swp_type(swp_entry);
>>>   if (type >= nr_swapfiles)
>>>           /* handle invalid swp_entry */;
>>>   p = swap_info[type];
>>>   /* access fields of *p.  OOPS! p may be NULL! */
>>>
>>> Because the ordering isn't guaranteed, it's possible that "p" is read
>>> before checking "type".  And that may result in NULL pointer
>>> dereference.
>>>
>>> So in commit c10d38cc8d3e, the code becomes,
>>>
>>>   struct swap_info_struct *swap_type_to_swap_info(int type)
>>>   {
>>>         if (type >= READ_ONCE(nr_swapfiles))
>>>                 return NULL;
>>>         smp_rmb();
>>>         return READ_ONCE(swap_info[type]);
>>>   }
>>>
>>>   /* users */
>>>   type = swp_type(swp_entry);
>>>   p = swap_type_to_swap_info(type);
>>>   if (!p)
>>>         /* handle invalid swp_entry */;
>>>   /* access fields of *p */
>>>
>>> Because "p" is checked to be non-zero before dereference, smp_rmb()
>>> isn't needed anymore.
>>>
>>> We still need to guarantee swap_info[type] is read before dereference.
>>> That can be satisfied via the data dependency ordering of
>>> READ_ONCE(swap_info[type]).  The corresponding smp_wmb() is adjusted
>>> in alloc_swap_info() too.
>>>
>>> And, we don't need to read "nr_swapfiles" too.  Because if
>>> "type >= nr_swapfiles", swap_info[type] will be NULL.  We just need
>>> to make sure we will not access out of the boundary of the array.
>>> With that change, nr_swapfiles will only be accessed with swap_lock
>>> held, except in swapcache_free_entries().  Where the absolute
>>> correctness of the value isn't needed, as described in the comments.
>>>
>>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>>> Cc: Daniel Jordan <daniel.m.jordan@oracle.com>
>>> Cc: Dan Carpenter <dan.carpenter@oracle.com>
>>> Cc: Andrea Parri <andrea.parri@amarulasolutions.com>
>>> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
>>> Cc: Andi Kleen <ak@linux.intel.com>
>>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>>> Cc: Omar Sandoval <osandov@fb.com>
>>> Cc: Paul McKenney <paulmck@kernel.org>
>>> Cc: Tejun Heo <tj@kernel.org>
>>> Cc: Will Deacon <will.deacon@arm.com>
>>> Cc: Miaohe Lin <linmiaohe@huawei.com>
>>> ---
>>>  mm/swapfile.c | 18 +++++++++---------
>>>  1 file changed, 9 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/mm/swapfile.c b/mm/swapfile.c
>>> index 2aad85751991..4c1fb28bbe0e 100644
>>> --- a/mm/swapfile.c
>>> +++ b/mm/swapfile.c
>>> @@ -100,10 +100,14 @@ atomic_t nr_rotate_swap = ATOMIC_INIT(0);
>>>
>>>  static struct swap_info_struct *swap_type_to_swap_info(int type)
>>>  {
>>> -     if (type >= READ_ONCE(nr_swapfiles))
>>> +     if (type >= MAX_SWAPFILES)
>>>               return NULL;
>>>
>>> -     smp_rmb();      /* Pairs with smp_wmb in alloc_swap_info. */
>>> +     /*
>>> +      * The data dependency ordering from the READ_ONCE() pairs
>>> +      * with smp_wmb() in alloc_swap_info() to guarantee the
>>> +      * swap_info_struct fields are read after swap_info[type].
>>> +      */
>>>       return READ_ONCE(swap_info[type]);
>>>  }
>>>
>>> @@ -2884,14 +2888,10 @@ static struct swap_info_struct *alloc_swap_info(void)
>>>       }
>>>       if (type >= nr_swapfiles) {
>>>               p->type = type;
>>> -             WRITE_ONCE(swap_info[type], p);
>>> -             /*
>>> -              * Write swap_info[type] before nr_swapfiles, in case a
>>> -              * racing procfs swap_start() or swap_next() is reading them.
>>> -              * (We never shrink nr_swapfiles, we never free this entry.)
>>> -              */
>>> +             /* Paired with READ_ONCE() in swap_type_to_swap_info() */
>>>               smp_wmb();
>>
>> Many thank for your patch. The patch looks fine to me. There is one question:
>>
>> There is no smp_rmb() paired with above smp_wmb(). What is this smp_wmb() used for ?
>> Could you please have a explanation ?
> 
> The comment is very clear, it matches READ_ONCE() which implies a
> data dependence barrier on some archs.
> 
> Thanks.

Got it. I misunderstood it... Thanks!

> 
>>
>> Thanks again!
>>
>>> -             WRITE_ONCE(nr_swapfiles, nr_swapfiles + 1);
>>> +             WRITE_ONCE(swap_info[type], p);
>>> +             nr_swapfiles++;
>>>       } else {
>>>               defer = p;
>>>               p = swap_info[type];
>>>
>>
> .
> 

