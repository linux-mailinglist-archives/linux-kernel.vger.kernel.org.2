Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D26536A465
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 05:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbhDYDe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 23:34:28 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:17054 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbhDYDe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 23:34:27 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FSYTh4WLVz17Rjs;
        Sun, 25 Apr 2021 11:31:20 +0800 (CST)
Received: from [10.174.176.174] (10.174.176.174) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Sun, 25 Apr 2021 11:33:43 +0800
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
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <0213893e-2b05-8d2e-9a79-e8a71db23644@huawei.com>
Date:   Sun, 25 Apr 2021 11:33:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <87bla3xdt0.fsf@yhuang6-desk1.ccr.corp.intel.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.174]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/4/25 11:07, Huang, Ying wrote:
> Miaohe Lin <linmiaohe@huawei.com> writes:
> 
>> When I was investigating the swap code, I found the below possible race
>> window:
>>
>> CPU 1                                         CPU 2
>> -----                                         -----
>> shmem_swapin
>>   swap_cluster_readahead
>>     if (likely(si->flags & (SWP_BLKDEV | SWP_FS_OPS))) {
>>                                               swapoff
>>                                                 ..
>>                                                 si->swap_file = NULL;
>>                                                 ..
>>     struct inode *inode = si->swap_file->f_mapping->host;[oops!]
>>
>> Close this race window by using get/put_swap_device() to guard against
>> concurrent swapoff.
>>
>> Fixes: 8fd2e0b505d1 ("mm: swap: check if swap backing device is congested or not")
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  mm/shmem.c | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/mm/shmem.c b/mm/shmem.c
>> index 26c76b13ad23..be388d0cf8b5 100644
>> --- a/mm/shmem.c
>> +++ b/mm/shmem.c
>> @@ -1696,6 +1696,7 @@ static int shmem_swapin_page(struct inode *inode, pgoff_t index,
>>  	struct address_space *mapping = inode->i_mapping;
>>  	struct shmem_inode_info *info = SHMEM_I(inode);
>>  	struct mm_struct *charge_mm = vma ? vma->vm_mm : current->mm;
>> +	struct swap_info_struct *si;
>>  	struct page *page;
>>  	swp_entry_t swap;
>>  	int error;
>> @@ -1704,6 +1705,12 @@ static int shmem_swapin_page(struct inode *inode, pgoff_t index,
>>  	swap = radix_to_swp_entry(*pagep);
>>  	*pagep = NULL;
>>  
>> +	/* Prevent swapoff from happening to us. */
>> +	si = get_swap_device(swap);
>> +	if (unlikely(!si)) {
>> +		error = EINVAL;
>> +		goto failed;
>> +	}
>>  	/* Look it up and read it in.. */
>>  	page = lookup_swap_cache(swap, NULL, 0);
>>  	if (!page) {
>> @@ -1720,6 +1727,7 @@ static int shmem_swapin_page(struct inode *inode, pgoff_t index,
>>  			goto failed;
>>  		}
>>  	}
>> +	put_swap_device(si);
> 
> I think it's better to put_swap_device() just before returning from the
> function.  It's not a big issue to slow down swapoff() a little.  And
> this will make the logic easier to be understood.
> 

shmem_swapin_page() already has a methed, i.e. locked page, to prevent races. I was intended
to not mix with that. But your suggestion is good as this will make the logic easier to be
understood.

Just to make sure, is this what you mean? Many thanks!

diff --git a/mm/shmem.c b/mm/shmem.c
index 26c76b13ad23..737e5b3200c3 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1696,6 +1696,7 @@ static int shmem_swapin_page(struct inode *inode, pgoff_t index,
        struct address_space *mapping = inode->i_mapping;
        struct shmem_inode_info *info = SHMEM_I(inode);
        struct mm_struct *charge_mm = vma ? vma->vm_mm : current->mm;
+       struct swap_info_struct *si;
        struct page *page;
        swp_entry_t swap;
        int error;
@@ -1704,6 +1705,12 @@ static int shmem_swapin_page(struct inode *inode, pgoff_t index,
        swap = radix_to_swp_entry(*pagep);
        *pagep = NULL;

+       /* Prevent swapoff from happening to us. */
+       si = get_swap_device(swap);
+       if (unlikely(!si)) {
+               error = EINVAL;
+               goto failed;
+       }
        /* Look it up and read it in.. */
        page = lookup_swap_cache(swap, NULL, 0);
        if (!page) {
@@ -1765,6 +1772,8 @@ static int shmem_swapin_page(struct inode *inode, pgoff_t index,
        swap_free(swap);

        *pagep = page;
+       if (si)
+               put_swap_device(si);
        return 0;
 failed:
        if (!shmem_confirm_swap(mapping, index, swap))
@@ -1775,6 +1784,9 @@ static int shmem_swapin_page(struct inode *inode, pgoff_t index,
                put_page(page);
        }

+       if (si)
+               put_swap_device(si);
+
        return error;
 }

> Best Regards,
> Huang, Ying
> 
>>  
>>  	/* We have to do this with page locked to prevent races */
>>  	lock_page(page);
>> @@ -1775,6 +1783,9 @@ static int shmem_swapin_page(struct inode *inode, pgoff_t index,
>>  		put_page(page);
>>  	}
>>  
>> +	if (si)
>> +		put_swap_device(si);
>> +
>>  	return error;
>>  }
> .
> 

