Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6FC9339B6A
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 03:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232255AbhCMCye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 21:54:34 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:13158 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbhCMCyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 21:54:16 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Dy6f34hcNzmWn8;
        Sat, 13 Mar 2021 10:51:55 +0800 (CST)
Received: from [10.174.179.232] (10.174.179.232) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.498.0; Sat, 13 Mar 2021 10:54:08 +0800
Subject: Re: [PATCH 4/5] mm/hugetlb: simplify the code when alloc_huge_page()
 failed in hugetlb_no_page()
To:     Mike Kravetz <mike.kravetz@oracle.com>, <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20210308112809.26107-1-linmiaohe@huawei.com>
 <20210308112809.26107-5-linmiaohe@huawei.com>
 <987f50e0-5511-7f53-c4b9-d8878d840bb5@oracle.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <1d72e0c4-de4d-351c-2867-10981f44b7fb@huawei.com>
Date:   Sat, 13 Mar 2021 10:54:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <987f50e0-5511-7f53-c4b9-d8878d840bb5@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.232]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/3/13 3:58, Mike Kravetz wrote:
> On 3/8/21 3:28 AM, Miaohe Lin wrote:
>> Rework the error handling code when alloc_huge_page() failed to remove some
>> duplicated code and simplify the code slightly.
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  mm/hugetlb.c | 9 +++------
>>  1 file changed, 3 insertions(+), 6 deletions(-)
>>
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index 695603071f2c..69b8de866a24 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -4337,13 +4337,10 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
>>  			 * sure there really is no pte entry.
>>  			 */
>>  			ptl = huge_pte_lock(h, mm, ptep);
>> -			if (!huge_pte_none(huge_ptep_get(ptep))) {
>> -				ret = 0;
>> -				spin_unlock(ptl);
>> -				goto out;
>> -			}
>> +			ret = 0;
>> +			if (huge_pte_none(huge_ptep_get(ptep)))
>> +				ret = vmf_error(PTR_ERR(page));
> 
> This new code is simpler.
> 
> The !huge_pte_none() catches an unlikely race.  IMO, the existing code
> made that very clear.  Would have been even more clear with an unlikely
> modifier.  In any case, the lengthy comment above this code makes it
> clear why the check is there.  Code changes are fine.
> 

Yep, the lengthy comment above this code makes it much clear why we need the check.
Thanks for carefully review! :)

> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
>
