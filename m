Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDA75345CD3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 12:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbhCWL2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 07:28:43 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14126 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbhCWL2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 07:28:38 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F4TbK3Nspz19HGk;
        Tue, 23 Mar 2021 19:26:37 +0800 (CST)
Received: from [10.174.178.163] (10.174.178.163) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Tue, 23 Mar 2021 19:28:32 +0800
Subject: Re: [PATCH 3/5] mm/migrate.c: fix potential indeterminate pte entry
 in migrate_vma_insert_page()
To:     Alistair Popple <apopple@nvidia.com>
CC:     David Hildenbrand <david@redhat.com>, <akpm@linux-foundation.org>,
        <jglisse@redhat.com>, <shy828301@gmail.com>, <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210320093701.12829-1-linmiaohe@huawei.com>
 <20210320093701.12829-4-linmiaohe@huawei.com>
 <0bee2243-5771-4969-7b92-aaca67abc90c@redhat.com>
 <5999334.9xz1uWCbsP@nvdebian>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <eca49322-a5d2-d3b0-d2eb-ee7a5db3a942@huawei.com>
Date:   Tue, 23 Mar 2021 19:28:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <5999334.9xz1uWCbsP@nvdebian>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.163]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/3/23 19:07, Alistair Popple wrote:
> On Tuesday, 23 March 2021 9:26:43 PM AEDT David Hildenbrand wrote:
>> On 20.03.21 10:36, Miaohe Lin wrote:
>>> If the zone device page does not belong to un-addressable device memory,
>>> the variable entry will be uninitialized and lead to indeterminate pte
>>> entry ultimately. Fix this unexpectant case and warn about it.
>>
>> s/unexpectant/unexpected/
>>
>>>
>>> Fixes: df6ad69838fc ("mm/device-public-memory: device memory cache 
> coherent with CPU")
>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>>> ---
>>>   mm/migrate.c | 7 +++++++
>>>   1 file changed, 7 insertions(+)
>>>
>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>> index 20a3bf75270a..271081b014cb 100644
>>> --- a/mm/migrate.c
>>> +++ b/mm/migrate.c
>>> @@ -2972,6 +2972,13 @@ static void migrate_vma_insert_page(struct 
> migrate_vma *migrate,
>>>   
>>>   			swp_entry = make_device_private_entry(page, vma->vm_flags & 
> VM_WRITE);
>>>   			entry = swp_entry_to_pte(swp_entry);
>>> +		} else {
>>> +			/*
>>> +			 * For now we only support migrating to un-addressable
>>> +			 * device memory.
>>> +			 */
>>> +			WARN_ON(1);
>>> +			goto abort;
>>
>> Fix it by crashing the kernel with panic_on_warn? :)
>>
>> If this case can actual happen, than no WARN_ON() - rather a 
>> pr_warn_once(). If this case cannot happen, why do we even care (it's 
>> not a fix then)?
> 
> There is also already a check for this case in migrate_vma_pages(). The 
> problem is it happens after the call to migrate_vma_insert_page(). I wonder if 
> instead it would be better just to move the existing check to before that 
> call?
> 

Yes, sounds good! Many thanks for your advice! :)

> >
> .
> 

