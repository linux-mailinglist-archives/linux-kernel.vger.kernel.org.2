Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B76C363BE6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 08:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237612AbhDSGrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 02:47:36 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:17373 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbhDSGre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 02:47:34 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FNy435WwWzlYyF;
        Mon, 19 Apr 2021 14:45:07 +0800 (CST)
Received: from [10.174.178.5] (10.174.178.5) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.498.0; Mon, 19 Apr 2021
 14:46:59 +0800
Subject: Re: [PATCH v2 4/5] mm/swap: remove confusing checking for
 non_swap_entry() in swap_ra_info()
To:     "Huang, Ying" <ying.huang@intel.com>
CC:     <akpm@linux-foundation.org>, <dennis@kernel.org>,
        <tim.c.chen@linux.intel.com>, <hughd@google.com>,
        <hannes@cmpxchg.org>, <mhocko@suse.com>, <iamjoonsoo.kim@lge.com>,
        <alexs@kernel.org>, <david@redhat.com>, <minchan@kernel.org>,
        <richard.weiyang@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
References: <20210417094039.51711-1-linmiaohe@huawei.com>
 <20210417094039.51711-5-linmiaohe@huawei.com>
 <87v98jkpjt.fsf@yhuang6-desk1.ccr.corp.intel.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <6ea114e9-02bd-b8df-732d-d0c85ff4407c@huawei.com>
Date:   Mon, 19 Apr 2021 14:46:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <87v98jkpjt.fsf@yhuang6-desk1.ccr.corp.intel.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.5]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/4/19 9:53, Huang, Ying wrote:
> Miaohe Lin <linmiaohe@huawei.com> writes:
> 
>> While we released the pte lock, somebody else might faulted in this pte.
>> So we should check whether it's swap pte first to guard against such race
>> or swp_type would be unexpected. But the swap_entry isn't used in this
>> function and we will have enough checking when we really operate the PTE
>> entries later. So checking for non_swap_entry() is not really needed here
>> and should be removed to avoid confusion.
> 
> Please rephrase the change log to describe why we have the code and why
> it's unnecessary now.  You can dig the git history via git-blame to find
> out it.
> 

Will try to do it. Thanks.

> The patch itself looks good to me.
> 
> Best Regards,
> Huang, Ying
> 
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  mm/swap_state.c | 6 ------
>>  1 file changed, 6 deletions(-)
>>
>> diff --git a/mm/swap_state.c b/mm/swap_state.c
>> index 272ea2108c9d..df5405384520 100644
>> --- a/mm/swap_state.c
>> +++ b/mm/swap_state.c
>> @@ -721,7 +721,6 @@ static void swap_ra_info(struct vm_fault *vmf,
>>  {
>>  	struct vm_area_struct *vma = vmf->vma;
>>  	unsigned long ra_val;
>> -	swp_entry_t entry;
>>  	unsigned long faddr, pfn, fpfn;
>>  	unsigned long start, end;
>>  	pte_t *pte, *orig_pte;
>> @@ -739,11 +738,6 @@ static void swap_ra_info(struct vm_fault *vmf,
>>  
>>  	faddr = vmf->address;
>>  	orig_pte = pte = pte_offset_map(vmf->pmd, faddr);
>> -	entry = pte_to_swp_entry(*pte);
>> -	if ((unlikely(non_swap_entry(entry)))) {
>> -		pte_unmap(orig_pte);
>> -		return;
>> -	}
>>  
>>  	fpfn = PFN_DOWN(faddr);
>>  	ra_val = GET_SWAP_RA_VAL(vma);
> .
> 

