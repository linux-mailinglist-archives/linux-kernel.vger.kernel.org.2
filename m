Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6555D35AA79
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 05:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233883AbhDJDRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 23:17:53 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:17301 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhDJDRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 23:17:51 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FHKr94ZV4z9xF3;
        Sat, 10 Apr 2021 11:15:21 +0800 (CST)
Received: from [10.174.179.9] (10.174.179.9) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.498.0; Sat, 10 Apr 2021
 11:17:29 +0800
Subject: Re: [PATCH 2/5] swap: fix do_swap_page() race with swapoff
To:     Tim Chen <tim.c.chen@linux.intel.com>, <akpm@linux-foundation.org>
CC:     <hannes@cmpxchg.org>, <mhocko@suse.com>, <iamjoonsoo.kim@lge.com>,
        <vbabka@suse.cz>, <alex.shi@linux.alibaba.com>,
        <willy@infradead.org>, <minchan@kernel.org>,
        <richard.weiyang@gmail.com>, <ying.huang@intel.com>,
        <hughd@google.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
References: <20210408130820.48233-1-linmiaohe@huawei.com>
 <20210408130820.48233-3-linmiaohe@huawei.com>
 <7684b3de-2824-9b1f-f033-d4bc14f9e195@linux.intel.com>
 <50d34b02-c155-bad7-da1f-03807ad31275@huawei.com>
 <995a130b-f07a-4771-1fe3-477d2f3c1e8e@linux.intel.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <d2a26fb0-caef-04b7-e163-88bcda358b0d@huawei.com>
Date:   Sat, 10 Apr 2021 11:17:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <995a130b-f07a-4771-1fe3-477d2f3c1e8e@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.9]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/4/10 1:17, Tim Chen wrote:
> 
> 
> On 4/9/21 1:42 AM, Miaohe Lin wrote:
>> On 2021/4/9 5:34, Tim Chen wrote:
>>>
>>>
>>> On 4/8/21 6:08 AM, Miaohe Lin wrote:
>>>> When I was investigating the swap code, I found the below possible race
>>>> window:
>>>>
>>>> CPU 1					CPU 2
>>>> -----					-----
>>>> do_swap_page
>>>>   synchronous swap_readpage
>>>>     alloc_page_vma
>>>> 					swapoff
>>>> 					  release swap_file, bdev, or ...
>>>
>>
>> Many thanks for quick review and reply!
>>
>>> Perhaps I'm missing something.  The release of swap_file, bdev etc
>>> happens after we have cleared the SWP_VALID bit in si->flags in destroy_swap_extents
>>> if I read the swapoff code correctly.
>> Agree. Let's look this more close:
>> CPU1								CPU2
>> -----								-----
>> swap_readpage
>>   if (data_race(sis->flags & SWP_FS_OPS)) {
>> 								swapoff
>> 								  p->swap_file = NULL;
>>     struct file *swap_file = sis->swap_file;
>>     struct address_space *mapping = swap_file->f_mapping;[oops!]
>> 								  ...
>> 								  p->flags = 0;
>>     ...
>>
>> Does this make sense for you?
> 
> p->swapfile = NULL happens after the 
> p->flags &= ~SWP_VALID, synchronize_rcu(), destroy_swap_extents() sequence in swapoff().
> 
> So I don't think the sequence you illustrated on CPU2 is in the right order.
> That said, without get_swap_device/put_swap_device in swap_readpage, you could
> potentially blow pass synchronize_rcu() on CPU2 and causes a problem.  so I think
> the problematic race looks something like the following:
> 
> 
> CPU1								CPU2
> -----								-----
> swap_readpage
>   if (data_race(sis->flags & SWP_FS_OPS)) {
> 								swapoff
> 								  p->flags = &= ~SWP_VALID;
> 								  ..
> 								  synchronize_rcu();
> 								  ..
> 								  p->swap_file = NULL;
>     struct file *swap_file = sis->swap_file;
>     struct address_space *mapping = swap_file->f_mapping;[oops!]
> 								  ...
>     ...
> 

Agree. This is also what I meant to illustrate. And you provide a better one. Many thanks!

> By adding get_swap_device/put_swap_device, then the race is fixed.
> 
> 
> CPU1								CPU2
> -----								-----
> swap_readpage
>   get_swap_device()
>   ..
>   if (data_race(sis->flags & SWP_FS_OPS)) {
> 								swapoff
> 								  p->flags = &= ~SWP_VALID;
> 								  ..
>     struct file *swap_file = sis->swap_file;
>     struct address_space *mapping = swap_file->f_mapping;[valid value]
>   ..
>   put_swap_device()
> 								  synchronize_rcu();
> 								  ..
> 								  p->swap_file = NULL;
> 
> 
>>
>>>>
>>>>       swap_readpage
>>>> 	check sis->flags is ok
>>>> 	  access swap_file, bdev...[oops!]
>>>> 					    si->flags = 0
>>>
>>> This happens after we clear the si->flags
>>> 					synchronize_rcu()
>>> 					release swap_file, bdev, in destroy_swap_extents()
>>>
>>> So I think if we have get_swap_device/put_swap_device in do_swap_page,
>>> it should fix the race you've pointed out here.  
>>> Then synchronize_rcu() will wait till we have completed do_swap_page and
>>> call put_swap_device.
>>
>> Right, get_swap_device/put_swap_device could fix this race. __But__ rcu_read_lock()
>> in get_swap_device() could disable preempt and do_swap_page() may take a really long
>> time because it involves I/O. It may not be acceptable to disable preempt for such a
>> long time. :(
> 
> I can see that it is not a good idea to hold rcu read lock for a long
> time over slow file I/O operation, which will be the side effect of
> introducing get/put_swap_device to swap_readpage.  So using percpu_ref
> will then be preferable for synchronization once we introduce 
> get/put_swap_device into swap_readpage.
> 

The sis->bdev should also be protected by get/put_swap_device. It has the similar
issue. And swap_slot_free_notify (called from callback end_swap_bio_read) would
race with swapoff too. So I use get/put_swap_device to protect swap_readpage until
file I/O operation is completed.

Thanks again!

> Tim
> .
> 
