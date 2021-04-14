Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 049BB35EB71
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 05:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233230AbhDND1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 23:27:52 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15676 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232296AbhDND1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 23:27:51 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FKnry72DqzpXSb;
        Wed, 14 Apr 2021 11:24:34 +0800 (CST)
Received: from [10.174.176.162] (10.174.176.162) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Wed, 14 Apr 2021 11:27:22 +0800
Subject: Re: [PATCH 2/5] swap: fix do_swap_page() race with swapoff
To:     "Huang, Ying" <ying.huang@intel.com>
CC:     <akpm@linux-foundation.org>, <hannes@cmpxchg.org>,
        <mhocko@suse.com>, <iamjoonsoo.kim@lge.com>, <vbabka@suse.cz>,
        <alex.shi@linux.alibaba.com>, <willy@infradead.org>,
        <minchan@kernel.org>, <richard.weiyang@gmail.com>,
        <hughd@google.com>, <tim.c.chen@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20210408130820.48233-1-linmiaohe@huawei.com>
 <20210408130820.48233-3-linmiaohe@huawei.com>
 <87o8ejug76.fsf@yhuang6-desk1.ccr.corp.intel.com>
 <e72bb6a2-6aff-0d6c-3e56-562b4fb53285@huawei.com>
 <87eefdsgwx.fsf@yhuang6-desk1.ccr.corp.intel.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <489bcf5f-1441-a775-913d-cc8b54dc6a2a@huawei.com>
Date:   Wed, 14 Apr 2021 11:27:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <87eefdsgwx.fsf@yhuang6-desk1.ccr.corp.intel.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.162]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/4/14 11:07, Huang, Ying wrote:
> Miaohe Lin <linmiaohe@huawei.com> writes:
> 
>> On 2021/4/13 9:27, Huang, Ying wrote:
>>> Miaohe Lin <linmiaohe@huawei.com> writes:
>>>
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
>>>>       swap_readpage
>>>> 	check sis->flags is ok
>>>> 	  access swap_file, bdev...[oops!]
>>>> 					    si->flags = 0
>>>>
>>>> Using current get/put_swap_device() to guard against concurrent swapoff for
>>>> swap_readpage() looks terrible because swap_readpage() may take really long
>>>> time. And this race may not be really pernicious because swapoff is usually
>>>> done when system shutdown only. To reduce the performance overhead on the
>>>> hot-path as much as possible, it appears we can use the percpu_ref to close
>>>> this race window(as suggested by Huang, Ying).
>>>>
>>>> Fixes: 235b62176712 ("mm/swap: add cluster lock")
>>>
>>> This isn't the commit that introduces the race.  You can use `git blame`
>>> find out the correct commit.  For this it's commit 0bcac06f27d7 "mm,
>>> swap: skip swapcache for swapin of synchronous device".
>>>
>>
>> Sorry about it! What I refer to is commit eb085574a752 ("mm, swap: fix race between
>> swapoff and some swap operations"). And I think this commit does not fix the race
>> condition completely, so I reuse the Fixes tag inside it.
>>
>>> And I suggest to merge 1/5 and 2/5 to make it easy to get the full
>>> picture.
>>>
>>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>>>> ---
>>>>  include/linux/swap.h |  2 +-
>>>>  mm/memory.c          | 10 ++++++++++
>>>>  mm/swapfile.c        | 28 +++++++++++-----------------
>>>>  3 files changed, 22 insertions(+), 18 deletions(-)
>>>>
>>>> diff --git a/include/linux/swap.h b/include/linux/swap.h
>>>> index 849ba5265c11..9066addb57fd 100644
>>>> --- a/include/linux/swap.h
>>>> +++ b/include/linux/swap.h
>>>> @@ -513,7 +513,7 @@ sector_t swap_page_sector(struct page *page);
>>>>  
>>>>  static inline void put_swap_device(struct swap_info_struct *si)
>>>>  {
>>>> -	rcu_read_unlock();
>>>> +	percpu_ref_put(&si->users);
>>>>  }
>>>>  
>>>>  #else /* CONFIG_SWAP */
>>>> diff --git a/mm/memory.c b/mm/memory.c
>>>> index cc71a445c76c..8543c47b955c 100644
>>>> --- a/mm/memory.c
>>>> +++ b/mm/memory.c
>>>> @@ -3311,6 +3311,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>>>  {
>>>>  	struct vm_area_struct *vma = vmf->vma;
>>>>  	struct page *page = NULL, *swapcache;
>>>> +	struct swap_info_struct *si = NULL;
>>>>  	swp_entry_t entry;
>>>>  	pte_t pte;
>>>>  	int locked;
>>>> @@ -3339,6 +3340,11 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>>>  	}
>>>>  
>>>>
>>>
>>> I suggest to add comments here as follows (words copy from Matthew Wilcox)
>>>
>>> 	/* Prevent swapoff from happening to us */
>>
>> Ok.
>>
>>>
>>>> +	si = get_swap_device(entry);
>>>> +	/* In case we raced with swapoff. */
>>>> +	if (unlikely(!si))
>>>> +		goto out;
>>>> +
>>>
>>> Because we wrap the whole do_swap_page() with get/put_swap_device()
>>> now.  We can remove several get/put_swap_device() for function called by
>>> do_swap_page().  That can be another optimization patch.
>>
>> I tried to remove several get/put_swap_device() for function called
>> by do_swap_page() only before I send this series. But it seems they have
>> other callers without proper get/put_swap_device().
> 
> Then we need to revise these callers instead.  Anyway, can be another
> series.

Yes. can be another series.
Thanks.

> 
> Best Regards,
> Huang, Ying
> 
> .
> 

