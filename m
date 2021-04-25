Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFAD36A51A
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 08:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbhDYG2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 02:28:23 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:17035 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbhDYG2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 02:28:22 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FSdKc1RYFzNxhm;
        Sun, 25 Apr 2021 14:24:36 +0800 (CST)
Received: from [10.174.176.174] (10.174.176.174) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.498.0; Sun, 25 Apr 2021 14:27:35 +0800
Subject: Re: [PATCH v4 4/4] mm/shmem: fix shmem_swapin() race with swapoff
To:     "Huang, Ying" <ying.huang@intel.com>
CC:     <akpm@linux-foundation.org>, <dennis@kernel.org>,
        <tim.c.chen@linux.intel.com>, <hughd@google.com>,
        <hannes@cmpxchg.org>, <mhocko@suse.com>, <iamjoonsoo.kim@lge.com>,
        <alexs@kernel.org>, <willy@infradead.org>, <minchan@kernel.org>,
        <richard.weiyang@gmail.com>, <shy828301@gmail.com>,
        <david@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
References: <20210425023806.3537283-1-linmiaohe@huawei.com>
 <20210425023806.3537283-5-linmiaohe@huawei.com>
 <87bla3xdt0.fsf@yhuang6-desk1.ccr.corp.intel.com>
 <0213893e-2b05-8d2e-9a79-e8a71db23644@huawei.com>
 <87y2d7vvuq.fsf@yhuang6-desk1.ccr.corp.intel.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <63a730d6-b765-8ac5-f0eb-8e53e1c93b54@huawei.com>
Date:   Sun, 25 Apr 2021 14:27:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <87y2d7vvuq.fsf@yhuang6-desk1.ccr.corp.intel.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.174]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/4/25 12:20, Huang, Ying wrote:
> Miaohe Lin <linmiaohe@huawei.com> writes:
> 
>> On 2021/4/25 11:07, Huang, Ying wrote:
>>> I think it's better to put_swap_device() just before returning from the
>>> function.  It's not a big issue to slow down swapoff() a little.  And
>>> this will make the logic easier to be understood.
>>>
>>
>> shmem_swapin_page() already has a methed, i.e. locked page, to prevent races. I was intended
>> to not mix with that. But your suggestion is good as this will make the logic easier to be
>> understood.
>>
>> Just to make sure, is this what you mean? Many thanks!
> 
> Yes.  Just a minor comment.
> 
>>
>> diff --git a/mm/shmem.c b/mm/shmem.c
>> index 26c76b13ad23..737e5b3200c3 100644
>> --- a/mm/shmem.c
>> +++ b/mm/shmem.c
>> @@ -1696,6 +1696,7 @@ static int shmem_swapin_page(struct inode *inode, pgoff_t index,
>>         struct address_space *mapping = inode->i_mapping;
>>         struct shmem_inode_info *info = SHMEM_I(inode);
>>         struct mm_struct *charge_mm = vma ? vma->vm_mm : current->mm;
>> +       struct swap_info_struct *si;
>>         struct page *page;
>>         swp_entry_t swap;
>>         int error;
>> @@ -1704,6 +1705,12 @@ static int shmem_swapin_page(struct inode *inode, pgoff_t index,
>>         swap = radix_to_swp_entry(*pagep);
>>         *pagep = NULL;
>>
>> +       /* Prevent swapoff from happening to us. */
>> +       si = get_swap_device(swap);
>> +       if (unlikely(!si)) {
> 
> I don't think it's necessary to use unlikely() here.
> 

Will do in next version. Thanks!

> Best Regards,
> Huang, Ying
> 
>> +               error = EINVAL;
>> +               goto failed;
>> +       }
>>         /* Look it up and read it in.. */
>>         page = lookup_swap_cache(swap, NULL, 0);
>>         if (!page) {
>> @@ -1765,6 +1772,8 @@ static int shmem_swapin_page(struct inode *inode, pgoff_t index,
>>         swap_free(swap);
>>
>>         *pagep = page;
>> +       if (si)
>> +               put_swap_device(si);
>>         return 0;
>>  failed:
>>         if (!shmem_confirm_swap(mapping, index, swap))
>> @@ -1775,6 +1784,9 @@ static int shmem_swapin_page(struct inode *inode, pgoff_t index,
>>                 put_page(page);
>>         }
>>
>> +       if (si)
>> +               put_swap_device(si);
>> +
>>         return error;
>>  }
>>
>>> Best Regards,
>>> Huang, Ying
>>>
> .
> 

