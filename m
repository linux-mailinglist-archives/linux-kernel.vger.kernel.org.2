Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1AFE36AC9E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 09:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbhDZHFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 03:05:54 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:17817 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbhDZHFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 03:05:53 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FTG7731QYzBryB;
        Mon, 26 Apr 2021 15:02:43 +0800 (CST)
Received: from [10.174.176.174] (10.174.176.174) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Mon, 26 Apr 2021 15:05:08 +0800
Subject: Re: [PATCH v5 4/4] mm/shmem: fix shmem_swapin() race with swapoff
To:     Yu Zhao <yuzhao@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>, <dennis@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Hugh Dickins <hughd@google.com>,
        "Johannes Weiner" <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, <alexs@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Minchan Kim <minchan@kernel.org>,
        Wei Yang <richard.weiyang@gmail.com>,
        Yang Shi <shy828301@gmail.com>,
        "David Hildenbrand" <david@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <20210425095419.3830298-1-linmiaohe@huawei.com>
 <20210425095419.3830298-5-linmiaohe@huawei.com>
 <CAOUHufZbT06isT_TU=x8d3P+AEHG8W=xd9GyX_5GHPNBT9KT9g@mail.gmail.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <2408403a-a0c3-b87e-b7ab-46cbaf35fb47@huawei.com>
Date:   Mon, 26 Apr 2021 15:05:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAOUHufZbT06isT_TU=x8d3P+AEHG8W=xd9GyX_5GHPNBT9KT9g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.174]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/4/26 14:53, Yu Zhao wrote:
> On Sun, Apr 25, 2021 at 3:54 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
>>
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
>>  mm/shmem.c | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/mm/shmem.c b/mm/shmem.c
>> index 26c76b13ad23..2dafd65b0b42 100644
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
>> +       if (!si) {
>> +               error = EINVAL;
>> +               goto failed;
>> +       }
> 
> page is uninitialized?
> 

Sorry, my overlook! Compiler should have complained about it but there is none...
Many thanks for pointing this out! Will fix it in next version.

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
>> --
>> 2.23.0
>>
>>
> .
> 

