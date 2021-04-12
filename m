Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17BF535B8D0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 05:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236657AbhDLDIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 23:08:53 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:16438 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236345AbhDLDIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 23:08:50 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FJYXl50FVzwS2R;
        Mon, 12 Apr 2021 11:06:15 +0800 (CST)
Received: from [10.174.176.162] (10.174.176.162) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.498.0; Mon, 12 Apr 2021 11:08:25 +0800
Subject: Re: [PATCH] mm/frontswap: fix frontswap_register_ops() race with
 swapon and swapoff
To:     Yu Zhao <yuzhao@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        <konrad.wilk@oracle.com>, "Dan Streetman" <ddstreet@ieee.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <20210405102008.25504-1-linmiaohe@huawei.com>
 <5ec0f24e-eac2-1e62-628b-757f8ce11dc2@huawei.com>
 <CAOUHufYYjRgO0+3zD6OMn2m3u5qm6sFg5pWxNujnPMaK0hv4Qw@mail.gmail.com>
 <7e5ea991-f219-5b42-ee71-4ec4004ca550@huawei.com>
 <CAOUHufbZWC0+7bSko1zQAvqKbUUOF1fa_c33J5VrVphS2bvZ0Q@mail.gmail.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <c8a13b3a-d11e-2800-d621-3dcbd28eea3a@huawei.com>
Date:   Mon, 12 Apr 2021 11:08:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAOUHufbZWC0+7bSko1zQAvqKbUUOF1fa_c33J5VrVphS2bvZ0Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.162]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/4/11 4:02, Yu Zhao wrote:
> On Sat, Apr 10, 2021 at 5:01 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
>>
>> On 2021/4/10 18:42, Yu Zhao wrote:
>>> On Sat, Apr 10, 2021 at 1:30 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
>>>>
>>>> Hi:
>>>> On 2021/4/5 18:20, Miaohe Lin wrote:
>>>>> frontswap_register_ops can race with swapon. Consider the following scene:
>>>>
>>>> Any comment or suggestion? Or is this race window too theoretical to fix?
>>>> Thanks.
>>>
>>> Let me run a stress test and get back to you (within a day or so).
>>
>> That's very kind of you. Many thanks!
> 
> I'm still getting the following crash. Probably I should try the other
> series you sent earlier too?
> 
>   BUG: unable to handle page fault for address: ffffaa7937d82000
>   RIP: 0010:scan_swap_map_slots+0x12b/0x7f0
>   Call Trace:
>   get_swap_pages+0x278/0x590
>    get_swap_page+0x1ab/0x280
>    add_to_swap+0x7d/0x130
>    shrink_page_list+0xf84/0x25f0
>    reclaim_pages+0x313/0x430
>   madvise_cold_or_pageout_pte_range+0x95c/0xaa0
>    walk_p4d_range+0x43f/0x790
>    walk_pgd_range+0xf1/0x150
>    __walk_page_range+0x6f/0x1b0
>    walk_page_range+0xbe/0x1e
>    do_madvise+0x271/0x720

Sorry about it! This patch is fix the frontswap_register_ops() race with swapon/swapoff.
And the earlier patch is fix the race I found when I was investigating the swap code. So
this crash may not be included.

> 
>>>>> CPU1                                  CPU2
>>>>> ----                                  ----
>>>>> frontswap_register_ops
>>>>>   fill bitmap a
>>>>>   ops->init
>>>>>                                       sys_swapon
>>>>>                                         enable_swap_info
>>>>>                                           frontswap_init without new ops
>>>>>   add ops to frontswap_ops list
>>>>>   check if swap_active_head changed
>>>>>                                           add to swap_active_head
>>>>>
>>>>> So the frontswap_ops init is missed on the new swap device. Consider the
>>>>> another scene:
>>>>> CPU1                                    CPU2
>>>>> ----                                    ----
>>>>> frontswap_register_ops
>>>>>   fill bitmap a
>>>>>   ops->init
>>>>>   add ops to frontswap_ops list
>>>>>                                         sys_swapon
>>>>>                                           enable_swap_info
>>>>>                                             frontswap_init with new ops
>>>>>                                             add to swap_active_head
>>>>>   check if swap_active_head changed
>>>>>   ops->init for new swap device [twice!]
>>>>>
>>>>> The frontswap_ops init will be called two times on the new swap device this
>>>>> time. frontswap_register_ops can also race with swapoff. Consider the
>>>>> following scene:
>>>>>
>>>>> CPU1                                    CPU2
>>>>> ----                                    ----
>>>>>                                         sys_swapoff
>>>>>                                         removed from swap_active_head
>>>>> frontswap_register_ops
>>>>>   fill bitmap a
>>>>>   ops->init without swap device
>>>>>   add ops to frontswap_ops list
>>>>>                                             invalidate_area with new ops
>>>>>   check if swap_active_head changed
>>>>>
>>>>> We could call invalidate_area on a swap device under swapoff with frontswap
>>>>> is uninitialized yet. Fix all these by using swapon_mutex to guard against
>>>>> race with swapon and add swap_info_get_if_under_swapoff() to collect swap
>>>>> devices under swapoff.
>>>>>
>>>>> Fixes: d1dc6f1bcf1e ("frontswap: allow multiple backends")
>>>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>>>>> ---
>>>>>  include/linux/swapfile.h |  2 ++
>>>>>  mm/frontswap.c           | 40 +++++++++++++++++-----------------------
>>>>>  mm/swapfile.c            | 13 ++++++++++++-
>>>>>  3 files changed, 31 insertions(+), 24 deletions(-)
>>>>>
>>>>> diff --git a/include/linux/swapfile.h b/include/linux/swapfile.h
>>>>> index e06febf62978..7ae15d917828 100644
>>>>> --- a/include/linux/swapfile.h
>>>>> +++ b/include/linux/swapfile.h
>>>>> @@ -9,8 +9,10 @@
>>>>>  extern spinlock_t swap_lock;
>>>>>  extern struct plist_head swap_active_head;
>>>>>  extern struct swap_info_struct *swap_info[];
>>>>> +extern struct mutex swapon_mutex;
>>>>>  extern int try_to_unuse(unsigned int, bool, unsigned long);
>>>>>  extern unsigned long generic_max_swapfile_size(void);
>>>>>  extern unsigned long max_swapfile_size(void);
>>>>> +extern struct swap_info_struct *swap_info_get_if_under_swapoff(int type);
>>>>>
>>>>>  #endif /* _LINUX_SWAPFILE_H */
>>>>> diff --git a/mm/frontswap.c b/mm/frontswap.c
>>>>> index 130e301c5ac0..c16bfc7550b5 100644
>>>>> --- a/mm/frontswap.c
>>>>> +++ b/mm/frontswap.c
>>>>> @@ -123,12 +123,26 @@ void frontswap_register_ops(struct frontswap_ops *ops)
>>>>>
>>>>>       bitmap_zero(a, MAX_SWAPFILES);
>>>>>       bitmap_zero(b, MAX_SWAPFILES);
>>>>> -
>>>>> +     mutex_lock(&swapon_mutex);
>>>>>       spin_lock(&swap_lock);
>>>>>       plist_for_each_entry(si, &swap_active_head, list) {
>>>>>               if (!WARN_ON(!si->frontswap_map))
>>>>>                       set_bit(si->type, a);
>>>>>       }
>>>>> +     /*
>>>>> +      * There might be some swap devices under swapoff, i.e. they are
>>>>> +      * removed from swap_active_head but frontswap_invalidate_area()
>>>>> +      * is not called yet due to swapon_mutex is held here. We must
>>>>> +      * collect these swap devices and call ops->init on them or they
>>>>> +      * might invalidate frontswap area while frontswap is uninitialized.
>>>>> +      */
>>>>> +     for_each_clear_bit(i, a, MAX_SWAPFILES) {
>>>>> +             si = swap_info_get_if_under_swapoff(i);
>>>>> +             if (!si || !si->frontswap_map)
>>>>> +                     continue;
>>>>> +             set_bit(si->type, b);
>>>>> +     }
>>>>> +     bitmap_or(a, a, b, MAX_SWAPFILES);
>>>>>       spin_unlock(&swap_lock);
>>>>>
>>>>>       /* the new ops needs to know the currently active swap devices */
>>>>> @@ -144,29 +158,9 @@ void frontswap_register_ops(struct frontswap_ops *ops)
>>>>>               ops->next = frontswap_ops;
>>>>>       } while (cmpxchg(&frontswap_ops, ops->next, ops) != ops->next);
>>>>>
>>>>> -     static_branch_inc(&frontswap_enabled_key);
>>>>> -
>>>>> -     spin_lock(&swap_lock);
>>>>> -     plist_for_each_entry(si, &swap_active_head, list) {
>>>>> -             if (si->frontswap_map)
>>>>> -                     set_bit(si->type, b);
>>>>> -     }
>>>>> -     spin_unlock(&swap_lock);
>>>>> +     mutex_unlock(&swapon_mutex);
>>>>>
>>>>> -     /*
>>>>> -      * On the very unlikely chance that a swap device was added or
>>>>> -      * removed between setting the "a" list bits and the ops init
>>>>> -      * calls, we re-check and do init or invalidate for any changed
>>>>> -      * bits.
>>>>> -      */
>>>>> -     if (unlikely(!bitmap_equal(a, b, MAX_SWAPFILES))) {
>>>>> -             for (i = 0; i < MAX_SWAPFILES; i++) {
>>>>> -                     if (!test_bit(i, a) && test_bit(i, b))
>>>>> -                             ops->init(i);
>>>>> -                     else if (test_bit(i, a) && !test_bit(i, b))
>>>>> -                             ops->invalidate_area(i);
>>>>> -             }
>>>>> -     }
>>>>> +     static_branch_inc(&frontswap_enabled_key);
>>>>>  }
>>>>>  EXPORT_SYMBOL(frontswap_register_ops);
>>>>>
>>>>> diff --git a/mm/swapfile.c b/mm/swapfile.c
>>>>> index 149e77454e3c..ee736533717f 100644
>>>>> --- a/mm/swapfile.c
>>>>> +++ b/mm/swapfile.c
>>>>> @@ -89,7 +89,7 @@ static DEFINE_SPINLOCK(swap_avail_lock);
>>>>>
>>>>>  struct swap_info_struct *swap_info[MAX_SWAPFILES];
>>>>>
>>>>> -static DEFINE_MUTEX(swapon_mutex);
>>>>> +DEFINE_MUTEX(swapon_mutex);
>>>>>
>>>>>  static DECLARE_WAIT_QUEUE_HEAD(proc_poll_wait);
>>>>>  /* Activity counter to indicate that a swapon or swapoff has occurred */
>>>>> @@ -2958,6 +2958,17 @@ __weak unsigned long max_swapfile_size(void)
>>>>>       return generic_max_swapfile_size();
>>>>>  }
>>>>>
>>>>> +struct swap_info_struct *swap_info_get_if_under_swapoff(int type)
>>>>> +{
>>>>> +     struct swap_info_struct *si = swap_type_to_swap_info(type);
>>>>> +
>>>>> +     if (!si || !si->swap_map)
>>>>> +             return NULL;
>>>>> +     if ((si->flags & SWP_USED) && !(si->flags & SWP_WRITEOK))
>>>>> +             return si;
>>>>> +     return NULL;
>>>>> +}
>>>>> +
>>>>>  static unsigned long read_swap_header(struct swap_info_struct *p,
>>>>>                                       union swap_header *swap_header,
>>>>>                                       struct inode *inode)
>>>>>
>>>>
>>>>
>>> .
>>>
>>
>>
> .
> 

