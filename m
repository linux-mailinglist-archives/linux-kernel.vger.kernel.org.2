Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21C3B33B037
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 11:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbhCOKqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 06:46:35 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:14341 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbhCOKqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 06:46:18 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DzY2D4q84z8xmQ;
        Mon, 15 Mar 2021 18:44:20 +0800 (CST)
Received: from [10.174.184.42] (10.174.184.42) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Mon, 15 Mar 2021 18:46:06 +0800
Subject: Re: [PATCH 4/4] KVM: arm64: Don't retrieve memory slot again in page
 fault handler
To:     Gavin Shan <gshan@redhat.com>, <kvmarm@lists.cs.columbia.edu>
References: <20210315041844.64915-1-gshan@redhat.com>
 <20210315041844.64915-5-gshan@redhat.com>
 <30073114-339f-33dd-0168-b4d6bfbe88bc@huawei.com>
 <7a29ac43-ef11-e990-e08c-c5e97ea7d78d@redhat.com>
CC:     <maz@kernel.org>, <will@kernel.org>,
        <linux-kernel@vger.kernel.org>, <shan.gavin@gmail.com>
From:   Keqian Zhu <zhukeqian1@huawei.com>
Message-ID: <b3a175ca-67a7-7371-44ac-e17c8616badc@huawei.com>
Date:   Mon, 15 Mar 2021 18:46:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <7a29ac43-ef11-e990-e08c-c5e97ea7d78d@redhat.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.184.42]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gavin,

On 2021/3/15 17:56, Gavin Shan wrote:
> Hi Keqian,
> 
> On 3/15/21 7:25 PM, Keqian Zhu wrote:
>> On 2021/3/15 12:18, Gavin Shan wrote:
>>> We needn't retrieve the memory slot again in user_mem_abort() because
>>> the corresponding memory slot has been passed from the caller. This
>> I think you are right, though fault_ipa will be adjusted when we try to use block mapping,
>> the fault_supports_stage2_huge_mapping() makes sure we're not trying to map anything
>> not covered by the memslot, so the adjusted fault_ipa still belongs to the memslot.
>>
> 
> Yeah, it's correct. Besides, the @logging_active is determined
> based on the passed memory slot. It means user_mem_abort() can't
> support memory range which spans multiple memory slot.
> 
>>> would save some CPU cycles. For example, the time used to write 1GB
>>> memory, which is backed by 2MB hugetlb pages and write-protected, is
>>> dropped by 6.8% from 928ms to 864ms.
>>>
>>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>>> ---
>>>   arch/arm64/kvm/mmu.c | 5 +++--
>>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
>>> index a5a8ade9fde4..4a4abcccfafb 100644
>>> --- a/arch/arm64/kvm/mmu.c
>>> +++ b/arch/arm64/kvm/mmu.c
>>> @@ -846,7 +846,8 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>>>        */
>>>       smp_rmb();
>>>   -    pfn = gfn_to_pfn_prot(kvm, gfn, write_fault, &writable);
>>> +    pfn = __gfn_to_pfn_memslot(memslot, gfn, false, NULL,
>>> +                   write_fault, &writable, NULL);
>> It's better to update the code comments at same time.
>>
> 
> I guess you need some comments here? If so, I would add something
> like below in v2:
> 
>     /*
>      * gfn_to_pfn_prot() can be used either with unnecessary overhead
>      * introduced to locate the memory slot because the memory slot is
>      * always fixed even @gfn is adjusted for huge pages.
>      */
Looks good.

See comments above "smp_rmb();", and actually my meaning is that we should change "gfn_to_pfn_prot"
to "__gfn_to_pfn_memslot" :)

Thanks,
Keqian

> 
>>>       if (pfn == KVM_PFN_ERR_HWPOISON) {
>>>           kvm_send_hwpoison_signal(hva, vma_shift);
>>>           return 0;
>>> @@ -912,7 +913,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>>>       /* Mark the page dirty only if the fault is handled successfully */
>>>       if (writable && !ret) {
>>>           kvm_set_pfn_dirty(pfn);
>>> -        mark_page_dirty(kvm, gfn);
>>> +        mark_page_dirty_in_slot(kvm, memslot, gfn);
>>>       }
>>>     out_unlock:
>>>
> 
> Thanks,
> Gavin
> 
> 
> .
> 
