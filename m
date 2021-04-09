Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 084D5359823
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 10:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbhDIImp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 04:42:45 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:16113 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbhDIImo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 04:42:44 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FGs5Y3kT1z19KrK;
        Fri,  9 Apr 2021 16:40:17 +0800 (CST)
Received: from [10.174.179.9] (10.174.179.9) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.498.0; Fri, 9 Apr 2021
 16:42:25 +0800
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
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <50d34b02-c155-bad7-da1f-03807ad31275@huawei.com>
Date:   Fri, 9 Apr 2021 16:42:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <7684b3de-2824-9b1f-f033-d4bc14f9e195@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.9]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/4/9 5:34, Tim Chen wrote:
> 
> 
> On 4/8/21 6:08 AM, Miaohe Lin wrote:
>> When I was investigating the swap code, I found the below possible race
>> window:
>>
>> CPU 1					CPU 2
>> -----					-----
>> do_swap_page
>>   synchronous swap_readpage
>>     alloc_page_vma
>> 					swapoff
>> 					  release swap_file, bdev, or ...
> 

Many thanks for quick review and reply!

> Perhaps I'm missing something.  The release of swap_file, bdev etc
> happens after we have cleared the SWP_VALID bit in si->flags in destroy_swap_extents
> if I read the swapoff code correctly.
Agree. Let's look this more close:
CPU1								CPU2
-----								-----
swap_readpage
  if (data_race(sis->flags & SWP_FS_OPS)) {
								swapoff
								  p->swap_file = NULL;
    struct file *swap_file = sis->swap_file;
    struct address_space *mapping = swap_file->f_mapping;[oops!]
								  ...
								  p->flags = 0;
    ...

Does this make sense for you?

> >
>>       swap_readpage
>> 	check sis->flags is ok
>> 	  access swap_file, bdev...[oops!]
>> 					    si->flags = 0
> 
> This happens after we clear the si->flags
> 					synchronize_rcu()
> 					release swap_file, bdev, in destroy_swap_extents()
> 
> So I think if we have get_swap_device/put_swap_device in do_swap_page,
> it should fix the race you've pointed out here.  
> Then synchronize_rcu() will wait till we have completed do_swap_page and
> call put_swap_device.

Right, get_swap_device/put_swap_device could fix this race. __But__ rcu_read_lock()
in get_swap_device() could disable preempt and do_swap_page() may take a really long
time because it involves I/O. It may not be acceptable to disable preempt for such a
long time. :(

> 					
>>
>> Using current get/put_swap_device() to guard against concurrent swapoff for
>> swap_readpage() looks terrible because swap_readpage() may take really long
>> time. And this race may not be really pernicious because swapoff is usually
>> done when system shutdown only. To reduce the performance overhead on the
>> hot-path as much as possible, it appears we can use the percpu_ref to close
>> this race window(as suggested by Huang, Ying).
> 
> I think it is better to break this patch into two.
> > One patch is to fix the race in do_swap_page and swapoff
> by adding get_swap_device/put_swap_device in do_swap_page.
> 
> The second patch is to modify get_swap_device and put_swap_device
> with percpu_ref. But swapoff is a relatively rare events.  

Sounds reasonable. Will do it.

> 
> I am not sure making percpu_ref change for performance is really beneficial.
> Did you encounter a real use case where you see a problem with swapoff?
> The delay in swapoff is primarily in try_to_unuse to bring all
> the swapped off pages back into memory.  Synchronizing with other
> CPU for paging in probably is a small component in overall scheme
> of things.
> 

I can't find a more simple and stable way to fix this potential and *theoretical* issue.
This could happen in real word but the race window should be very small. While swapoff
is usually done when system shutdown only, I'am not really sure if this effort is worth.

But IMO, we should eliminate any potential trouble. :)

> Thanks.
> 

Thanks again.

> Tim
> 
> .
> 
