Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A95935B8EB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 05:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236400AbhDLDZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 23:25:22 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:16523 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235261AbhDLDZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 23:25:19 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FJYv56zKWzPptm;
        Mon, 12 Apr 2021 11:22:09 +0800 (CST)
Received: from [10.174.176.162] (10.174.176.162) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Mon, 12 Apr 2021 11:24:59 +0800
Subject: Re: [PATCH 2/5] swap: fix do_swap_page() race with swapoff
To:     "Huang, Ying" <ying.huang@intel.com>
CC:     Tim Chen <tim.c.chen@linux.intel.com>, <akpm@linux-foundation.org>,
        <hannes@cmpxchg.org>, <mhocko@suse.com>, <iamjoonsoo.kim@lge.com>,
        <vbabka@suse.cz>, <alex.shi@linux.alibaba.com>,
        <willy@infradead.org>, <minchan@kernel.org>,
        <richard.weiyang@gmail.com>, <hughd@google.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20210408130820.48233-1-linmiaohe@huawei.com>
 <20210408130820.48233-3-linmiaohe@huawei.com>
 <7684b3de-2824-9b1f-f033-d4bc14f9e195@linux.intel.com>
 <50d34b02-c155-bad7-da1f-03807ad31275@huawei.com>
 <995a130b-f07a-4771-1fe3-477d2f3c1e8e@linux.intel.com>
 <d2a26fb0-caef-04b7-e163-88bcda358b0d@huawei.com>
 <87r1jgwa2w.fsf@yhuang6-desk1.ccr.corp.intel.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <2268e7f9-cfdf-92f3-9a32-04e103e132fc@huawei.com>
Date:   Mon, 12 Apr 2021 11:24:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <87r1jgwa2w.fsf@yhuang6-desk1.ccr.corp.intel.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.162]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/4/12 9:44, Huang, Ying wrote:
> Miaohe Lin <linmiaohe@huawei.com> writes:
> 
>> On 2021/4/10 1:17, Tim Chen wrote:
>>>
>>>
>>> On 4/9/21 1:42 AM, Miaohe Lin wrote:
>>>> On 2021/4/9 5:34, Tim Chen wrote:
>>>>>
>>>>>
>>>>> On 4/8/21 6:08 AM, Miaohe Lin wrote:
>>>>>> When I was investigating the swap code, I found the below possible race
>>>>>> window:
>>>>>>
>>>>>> CPU 1					CPU 2
>>>>>> -----					-----
>>>>>> do_swap_page
>>>>>>   synchronous swap_readpage
>>>>>>     alloc_page_vma
>>>>>> 					swapoff
>>>>>> 					  release swap_file, bdev, or ...
>>>>>
>>>>
>>>> Many thanks for quick review and reply!
>>>>
>>>>> Perhaps I'm missing something.  The release of swap_file, bdev etc
>>>>> happens after we have cleared the SWP_VALID bit in si->flags in destroy_swap_extents
>>>>> if I read the swapoff code correctly.
>>>> Agree. Let's look this more close:
>>>> CPU1								CPU2
>>>> -----								-----
>>>> swap_readpage
>>>>   if (data_race(sis->flags & SWP_FS_OPS)) {
>>>> 								swapoff
>>>> 								  p->swap_file = NULL;
>>>>     struct file *swap_file = sis->swap_file;
>>>>     struct address_space *mapping = swap_file->f_mapping;[oops!]
>>>> 								  ...
>>>> 								  p->flags = 0;
>>>>     ...
>>>>
>>>> Does this make sense for you?
>>>
>>> p->swapfile = NULL happens after the 
>>> p->flags &= ~SWP_VALID, synchronize_rcu(), destroy_swap_extents() sequence in swapoff().
>>>
>>> So I don't think the sequence you illustrated on CPU2 is in the right order.
>>> That said, without get_swap_device/put_swap_device in swap_readpage, you could
>>> potentially blow pass synchronize_rcu() on CPU2 and causes a problem.  so I think
>>> the problematic race looks something like the following:
>>>
>>>
>>> CPU1								CPU2
>>> -----								-----
>>> swap_readpage
>>>   if (data_race(sis->flags & SWP_FS_OPS)) {
>>> 								swapoff
>>> 								  p->flags = &= ~SWP_VALID;
>>> 								  ..
>>> 								  synchronize_rcu();
>>> 								  ..
>>> 								  p->swap_file = NULL;
>>>     struct file *swap_file = sis->swap_file;
>>>     struct address_space *mapping = swap_file->f_mapping;[oops!]
>>> 								  ...
>>>     ...
>>>
>>
>> Agree. This is also what I meant to illustrate. And you provide a better one. Many thanks!
> 
> For the pages that are swapped in through swap cache.  That isn't an
> issue.  Because the page is locked, the swap entry will be marked with
> SWAP_HAS_CACHE, so swapoff() cannot proceed until the page has been
> unlocked.
> 
> So the race is for the fast path as follows,
> 
> 		if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
> 		    __swap_count(entry) == 1)
> 
> I found it in your original patch description.  But please make it more
> explicit to reduce the potential confusing.

Sure. Should I rephrase the commit log to clarify this or add a comment in the code?

Thanks.

> 
> Best Regards,
> Huang, Ying
> .
> 

