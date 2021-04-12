Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28B3E35B8D4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 05:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236666AbhDLDMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 23:12:52 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:16521 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236345AbhDLDMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 23:12:51 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FJYck0ZR1zPqGT;
        Mon, 12 Apr 2021 11:09:42 +0800 (CST)
Received: from [10.174.176.162] (10.174.176.162) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Mon, 12 Apr 2021 11:12:29 +0800
Subject: Re: [Question] Is there a race window between swapoff vs synchronous
 swap_readpage
To:     Yu Zhao <yuzhao@google.com>
CC:     Linux-MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Shakeel Butt <shakeelb@google.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Minchan Kim <minchan@kernel.org>,
        "Huang, Ying" <ying.huang@intel.com>
References: <364d7ce9-ccb7-fa04-7067-44a96be87060@huawei.com>
 <8735wdbdy4.fsf@yhuang6-desk1.ccr.corp.intel.com>
 <0cb765aa-1783-cd62-c4a4-b3fbc620532d@huawei.com>
 <87h7kt9ufw.fsf@yhuang6-desk1.ccr.corp.intel.com>
 <CAOUHufYMjhQagKfdjekxr62bsB83UJvArddUsuwTXoo-5jA45A@mail.gmail.com>
 <874kgt9lii.fsf@yhuang6-desk1.ccr.corp.intel.com>
 <CAOUHufZjwjqEx78nm2nw_1fTFP0xUW_7fNPdhxGXVpcfeQEc_g@mail.gmail.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <c23f7754-a078-fa27-0be3-495a0c16de2e@huawei.com>
Date:   Mon, 12 Apr 2021 11:12:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAOUHufZjwjqEx78nm2nw_1fTFP0xUW_7fNPdhxGXVpcfeQEc_g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.162]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/3/30 15:27, Yu Zhao wrote:
> On Tue, Mar 30, 2021 at 12:57 AM Huang, Ying <ying.huang@intel.com> wrote:
>>
>> Yu Zhao <yuzhao@google.com> writes:
>>
>>> On Mon, Mar 29, 2021 at 9:44 PM Huang, Ying <ying.huang@intel.com> wrote:
>>>>
>>>> Miaohe Lin <linmiaohe@huawei.com> writes:
>>>>
>>>>> On 2021/3/30 9:57, Huang, Ying wrote:
>>>>>> Hi, Miaohe,
>>>>>>
>>>>>> Miaohe Lin <linmiaohe@huawei.com> writes:
>>>>>>
>>>>>>> Hi all,
>>>>>>> I am investigating the swap code, and I found the below possible race window:
>>>>>>>
>>>>>>> CPU 1                                                       CPU 2
>>>>>>> -----                                                       -----
>>>>>>> do_swap_page
>>>>>>>   skip swapcache case (synchronous swap_readpage)
>>>>>>>     alloc_page_vma
>>>>>>>                                                     swapoff
>>>>>>>                                                       release swap_file, bdev, or ...
>>>>>>>       swap_readpage
>>>>>>>     check sis->flags is ok
>>>>>>>       access swap_file, bdev or ...[oops!]
>>>>>>>                                                         si->flags = 0
>>>>>>>
>>>>>>> The swapcache case is ok because swapoff will wait on the page_lock of swapcache page.
>>>>>>> Is this will really happen or Am I miss something ?
>>>>>>> Any reply would be really grateful. Thanks! :)
>>>>>>
>>>>>> This appears possible.  Even for swapcache case, we can't guarantee the
>>>>>
>>>>> Many thanks for reply!
>>>>>
>>>>>> swap entry gotten from the page table is always valid too.  The
>>>>>
>>>>> The page table may change at any time. And we may thus do some useless work.
>>>>> But the pte_same() check could handle these races correctly if these do not
>>>>> result in oops.
>>>>>
>>>>>> underlying swap device can be swapped off at the same time.  So we use
>>>>>> get/put_swap_device() for that.  Maybe we need similar stuff here.
>>>>>
>>>>> Using get/put_swap_device() to guard against swapoff for swap_readpage() sounds
>>>>> really bad as swap_readpage() may take really long time. Also such race may not be
>>>>> really hurtful because swapoff is usually done when system shutdown only.
>>>>> I can not figure some simple and stable stuff out to fix this. Any suggestions or
>>>>> could anyone help get rid of such race?
>>>>
>>>> Some reference counting on the swap device can prevent swap device from
>>>> swapping-off.  To reduce the performance overhead on the hot-path as
>>>> much as possible, it appears we can use the percpu_ref.
>>>
>>> Hi,
>>>
>>> I've been seeing crashes when testing the latest kernels with
>>>   stress-ng --class vm -a 20 -t 600s --temp-path /tmp
>>>
>>> I haven't had time to look into them yet:
>>>
>>> DEBUG_VM:
>>>   BUG: unable to handle page fault for address: ffff905c33c9a000
>>>   Call Trace:
>>>    get_swap_pages+0x278/0x590
>>>    get_swap_page+0x1ab/0x280
>>>    add_to_swap+0x7d/0x130
>>>    shrink_page_list+0xf84/0x25f0
>>>    reclaim_pages+0x313/0x430
>>>    madvise_cold_or_pageout_pte_range+0x95c/0xaa0
>>
>> If my understanding were correct, two bugs are reported?  One above and
>> one below?  If so, and the above one is reported firstly.  Can you share
>> the full bug message reported in dmesg?
> 
> No, they are from two different kernel configs. I saw the first crash
> and didn't know what to look. So I turned on KASAN to see if it gives
> more clue. Unfortunately I haven't had time to spend more time on it.
> 
>> Can you convert the call trace to source line?  And the commit of the
>> kernel?  Or the full kconfig?  So I can build it by myself.
> 
> It seems to be very reproducible if you enable these three options, on
> 5.12, 5.11, 5.10 which is where I gave up trying.
> 
>>> CONFIG_MEMCG_SWAP=y
>>> CONFIG_THP_SWAP=y
>>> CONFIG_ZSWAP=y
> 
> I'll dig into the log and see if I could at least give you the line
> numbers. Kernel config attached. Thanks!
> 

Maybe we could try to fix this issue here with more detailed info. Thanks.

> And the command line I used, which is nothing fancy:
> 
>>>   stress-ng --class vm -a 20 -t 600s --temp-path /tmp
> 
>>> KASAN:
>>>   ==================================================================
>>>   BUG: KASAN: slab-out-of-bounds in __frontswap_store+0xc9/0x2e0
>>>   Read of size 8 at addr ffff88901f646f18 by task stress-ng-mrema/31329
>>>   CPU: 2 PID: 31329 Comm: stress-ng-mrema Tainted: G S        I  L
>>> 5.12.0-smp-DEV #2
>>>   Call Trace:
>>>    dump_stack+0xff/0x165
>>>    print_address_description+0x81/0x390
>>>    __kasan_report+0x154/0x1b0
>>>    ? __frontswap_store+0xc9/0x2e0
>>>    ? __frontswap_store+0xc9/0x2e0
>>>    kasan_report+0x47/0x60
>>>    kasan_check_range+0x2f3/0x340
>>>    __kasan_check_read+0x11/0x20
>>>    __frontswap_store+0xc9/0x2e0
>>>    swap_writepage+0x52/0x80
>>>    pageout+0x489/0x7f0
>>>    shrink_page_list+0x1b11/0x2c90
>>>    reclaim_pages+0x6ca/0x930
>>>    madvise_cold_or_pageout_pte_range+0x1260/0x13a0
>>>
>>>   Allocated by task 16813:
>>>    ____kasan_kmalloc+0xb0/0xe0
>>>    __kasan_kmalloc+0x9/0x10
>>>    __kmalloc_node+0x52/0x70
>>>    kvmalloc_node+0x50/0x90
>>>    __se_sys_swapon+0x353a/0x4860
>>>    __x64_sys_swapon+0x5b/0x70
>>>
>>>   The buggy address belongs to the object at ffff88901f640000
>>>    which belongs to the cache kmalloc-32k of size 32768
>>>   The buggy address is located 28440 bytes inside of
>>>    32768-byte region [ffff88901f640000, ffff88901f648000)
>>>   The buggy address belongs to the page:
>>>   page:0000000032d23e33 refcount:1 mapcount:0 mapping:0000000000000000
>>> index:0x0 pfn:0x101f640
>>>   head:0000000032d23e33 order:4 compound_mapcount:0 compound_pincount:0
>>>   flags: 0x400000000010200(slab|head)
>>>   raw: 0400000000010200 ffffea00062b8408 ffffea000a6e9008 ffff888100040300
>>>   raw: 0000000000000000 ffff88901f640000 0000000100000001 000000000000000
>>>   page dumped because: kasan: bad access detected
>>>
>>> Memory state around the buggy address:
>>>    ffff88901f646e00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>    ffff88901f646e80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>   >ffff88901f646f00: 00 00 00 fc fc fc fc fc fc fc fc fc fc fc fc fc
>>>                               ^
>>>    ffff88901f646f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>>>    ffff88901f647000: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>>>   ==================================================================
>>>
>>> Relevant config options I could think of:
>>>
>>> CONFIG_MEMCG_SWAP=y
>>> CONFIG_THP_SWAP=y
>>> CONFIG_ZSWAP=y

