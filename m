Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9EF35B8E1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 05:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236080AbhDLDSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 23:18:17 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:16522 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235095AbhDLDSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 23:18:15 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FJYky441qzPqGT;
        Mon, 12 Apr 2021 11:15:06 +0800 (CST)
Received: from [10.174.176.162] (10.174.176.162) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Mon, 12 Apr 2021 11:17:54 +0800
Subject: Re: [PATCH 4/5] mm/swap_state: fix potential faulted in race in
 swap_ra_info()
To:     "Huang, Ying" <ying.huang@intel.com>
CC:     <akpm@linux-foundation.org>, <hannes@cmpxchg.org>,
        <mhocko@suse.com>, <iamjoonsoo.kim@lge.com>, <vbabka@suse.cz>,
        <alex.shi@linux.alibaba.com>, <willy@infradead.org>,
        <minchan@kernel.org>, <richard.weiyang@gmail.com>,
        <hughd@google.com>, <tim.c.chen@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20210408130820.48233-1-linmiaohe@huawei.com>
 <20210408130820.48233-5-linmiaohe@huawei.com>
 <874kgfyh85.fsf@yhuang6-desk1.ccr.corp.intel.com>
 <d88fbae4-20f5-0c7f-1c9b-b814b87ab222@huawei.com>
 <87v98swcd6.fsf@yhuang6-desk1.ccr.corp.intel.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <55611ebf-e608-87df-c86a-e6a19bab96ca@huawei.com>
Date:   Mon, 12 Apr 2021 11:17:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <87v98swcd6.fsf@yhuang6-desk1.ccr.corp.intel.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.162]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/4/12 8:55, Huang, Ying wrote:
> Miaohe Lin <linmiaohe@huawei.com> writes:
> 
>> On 2021/4/9 16:50, Huang, Ying wrote:
>>> Miaohe Lin <linmiaohe@huawei.com> writes:
>>>
>>>> While we released the pte lock, somebody else might faulted in this pte.
>>>> So we should check whether it's swap pte first to guard against such race
>>>> or swp_type would be unexpected. And we can also avoid some unnecessary
>>>> readahead cpu cycles possibly.
>>>>
>>>> Fixes: ec560175c0b6 ("mm, swap: VMA based swap readahead")
>>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>>>> ---
>>>>  mm/swap_state.c | 13 +++++++++----
>>>>  1 file changed, 9 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/mm/swap_state.c b/mm/swap_state.c
>>>> index 709c260d644a..3bf0d0c297bc 100644
>>>> --- a/mm/swap_state.c
>>>> +++ b/mm/swap_state.c
>>>> @@ -724,10 +724,10 @@ static void swap_ra_info(struct vm_fault *vmf,
>>>>  {
>>>>  	struct vm_area_struct *vma = vmf->vma;
>>>>  	unsigned long ra_val;
>>>> -	swp_entry_t entry;
>>>> +	swp_entry_t swap_entry;
>>>>  	unsigned long faddr, pfn, fpfn;
>>>>  	unsigned long start, end;
>>>> -	pte_t *pte, *orig_pte;
>>>> +	pte_t *pte, *orig_pte, entry;
>>>>  	unsigned int max_win, hits, prev_win, win, left;
>>>>  #ifndef CONFIG_64BIT
>>>>  	pte_t *tpte;
>>>> @@ -742,8 +742,13 @@ static void swap_ra_info(struct vm_fault *vmf,
>>>>  
>>>>  	faddr = vmf->address;
>>>>  	orig_pte = pte = pte_offset_map(vmf->pmd, faddr);
>>>> -	entry = pte_to_swp_entry(*pte);
>>>> -	if ((unlikely(non_swap_entry(entry)))) {
>>>> +	entry = *pte;
>>>> +	if (unlikely(!is_swap_pte(entry))) {
>>>> +		pte_unmap(orig_pte);
>>>> +		return;
>>>> +	}
>>>> +	swap_entry = pte_to_swp_entry(entry);
>>>> +	if ((unlikely(non_swap_entry(swap_entry)))) {
>>>>  		pte_unmap(orig_pte);
>>>>  		return;
>>>>  	}
>>>
>>> This isn't a real issue.  entry or swap_entry isn't used in this
>>
>> Agree. It seems the entry or swap_entry here is just used for check whether
>> pte is still valid swap_entry.
> 
> If you check the git history, you will find that the check has been
> necessary before.  Because the function is used earlier in
> do_swap_page() at that time.
> 

I see. Many thanks for explanation. :)

> Best Regards,
> Huang, Ying
> .
> 

