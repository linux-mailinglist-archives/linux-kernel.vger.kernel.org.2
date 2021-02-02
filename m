Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4A4430B4B9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 02:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbhBBBdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 20:33:47 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:12378 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbhBBBdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 20:33:45 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DV6jZ1DpHz7fV9;
        Tue,  2 Feb 2021 09:31:46 +0800 (CST)
Received: from [10.174.179.241] (10.174.179.241) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Tue, 2 Feb 2021 09:33:00 +0800
Subject: Re: [PATCH] mm/huge_memory.c: use helper range_in_vma() in
 __split_huge_p[u|m]d_locked()
To:     David Rientjes <rientjes@google.com>
CC:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20210201093259.52798-1-linmiaohe@huawei.com>
 <b59215ff-d793-23ee-edc2-242fc810dc73@google.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <0058619f-6516-fb28-7a7b-6bef710889e9@huawei.com>
Date:   Tue, 2 Feb 2021 09:33:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <b59215ff-d793-23ee-edc2-242fc810dc73@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.241]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/2/2 5:27, David Rientjes wrote:
> On Mon, 1 Feb 2021, Miaohe Lin wrote:
> 
>> The helper range_in_vma() is introduced via commit 017b1660df89 ("mm:
>> migration: fix migration of huge PMD shared pages"). But we forgot to
>> use it in __split_huge_pud_locked() and __split_huge_pmd_locked().
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  mm/huge_memory.c | 6 ++----
>>  1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 987cf5e4cf90..33353a4f95fb 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -1959,8 +1959,7 @@ static void __split_huge_pud_locked(struct vm_area_struct *vma, pud_t *pud,
>>  		unsigned long haddr)
>>  {
>>  	VM_BUG_ON(haddr & ~HPAGE_PUD_MASK);
>> -	VM_BUG_ON_VMA(vma->vm_start > haddr, vma);
>> -	VM_BUG_ON_VMA(vma->vm_end < haddr + HPAGE_PUD_SIZE, vma);
>> +	VM_BUG_ON_VMA(!range_in_vma(vma, haddr, haddr + HPAGE_PUD_SIZE), vma);
>>  	VM_BUG_ON(!pud_trans_huge(*pud) && !pud_devmap(*pud));
>>  
>>  	count_vm_event(THP_SPLIT_PUD);
>> @@ -2039,8 +2038,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>>  	int i;
>>  
>>  	VM_BUG_ON(haddr & ~HPAGE_PMD_MASK);
>> -	VM_BUG_ON_VMA(vma->vm_start > haddr, vma);
>> -	VM_BUG_ON_VMA(vma->vm_end < haddr + HPAGE_PMD_SIZE, vma);
>> +	VM_BUG_ON_VMA(!range_in_vma(vma, haddr, haddr + HPAGE_PMD_SIZE), vma);
>>  	VM_BUG_ON(!is_pmd_migration_entry(*pmd) && !pmd_trans_huge(*pmd)
>>  				&& !pmd_devmap(*pmd));
>>  
> 
> This actually loses information, right?  Before the patch, we can 
> determine which conditional is failing because we know the line number 
> that the VM_BUG_ON() is happening on.  After the patch, we don't know 
> this.
> 

You are right. We can determine which conditional is failing only through line number
via VM_BUG_ON_VMA. So this will loses the information. My careless. :(
Many thanks for kindly explanation.

> I don't think that's crucial, but I'm not sure it makes sense to do this 
> if the only upside is that we removed one total line of code :)
> .
> 

