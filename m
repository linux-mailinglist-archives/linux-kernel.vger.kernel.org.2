Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83BA5310333
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 04:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbhBEDJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 22:09:18 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:12425 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbhBEDI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 22:08:57 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DX0hG1fmVzjJ2D;
        Fri,  5 Feb 2021 11:07:10 +0800 (CST)
Received: from [10.174.179.241] (10.174.179.241) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Fri, 5 Feb 2021 11:08:13 +0800
Subject: Re: [PATCH] mm/hugetlb: Remove obsolete comment in vma_has_reserves()
To:     Mike Kravetz <mike.kravetz@oracle.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210204111500.24111-1-linmiaohe@huawei.com>
 <8f2f3bac-5b33-a560-9b84-b50972739636@oracle.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <43b7a6e0-1940-ebe8-4005-d6d8021653c3@huawei.com>
Date:   Fri, 5 Feb 2021 11:08:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <8f2f3bac-5b33-a560-9b84-b50972739636@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.241]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:
On 2021/2/5 5:32, Mike Kravetz wrote:
> On 2/4/21 3:15 AM, Miaohe Lin wrote:
>> Shared mappings are allowed to be created without reservations since
>> commit c37f9fb11c97 ("hugetlb: allow huge page mappings to be created
>> without reservations"). Remove this obsolete comment which may cause
>> confusing.
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  mm/hugetlb.c | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index 9501ec6ad517..cf82629319ed 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -998,7 +998,6 @@ static bool vma_has_reserves(struct vm_area_struct *vma, long chg)
>>  			return false;
>>  	}
>>  
>> -	/* Shared mappings always use reserves */
> 
> I would not say the comment is entirely obsolete or does not apply here.
> 
> As mentioned in the commit message, commit c37f9fb11c97 allowed hugetlb
> mappings to be created without reserves.  It does this by supporting the
> MAP_NORESERVE flag which corresponds to the VM_NORESERVE vma flag.
> 
> Right before this comment, a check is made for VM_NORESERVE and the
> routine will return.  Therefore, by the time we get to this comment
> we know MAP_NORESERVE does not apply and there are reserves associated
> the shared mapping.  In this case the comment is making a distinction
> between shared mappings which will always have reserves, and private
> mappings which may or may not have reserves depending on ownership.
> 

Yes. If I think about it this way, the comment is really making a distinction
between shared mappings and private mappings when not in VM_NORESERVE case.

> I would suggest either leaving the comment as is, or modifying to include

I'd like to leave the comment as is. Many thanks for detailed explanation.

> the information above.  To me, the three distinct blocks of code handling
> the NORESERVE, shared and private cases makes things fairly clear and
> the comment does apply in that context.
> 
Many thanks again. :)
