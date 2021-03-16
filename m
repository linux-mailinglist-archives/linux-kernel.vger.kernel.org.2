Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FEEA33CC85
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 05:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234151AbhCPEUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 00:20:41 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:13936 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233798AbhCPEUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 00:20:21 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4F00Qw4RtQzkZKl;
        Tue, 16 Mar 2021 12:18:48 +0800 (CST)
Received: from [10.174.184.42] (10.174.184.42) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Tue, 16 Mar 2021 12:20:16 +0800
Subject: Re: [PATCH 2/4] KVM: arm64: Use find_vma_intersection()
To:     Gavin Shan <gshan@redhat.com>, <kvmarm@lists.cs.columbia.edu>
References: <20210315041844.64915-1-gshan@redhat.com>
 <20210315041844.64915-3-gshan@redhat.com>
 <65dfdca3-af94-7d5a-86fe-24825301655b@huawei.com>
 <2eef2b42-13bd-2414-f748-551039677bf5@redhat.com>
 <d46320a2-7381-a46a-42e5-6bfa75321d31@redhat.com>
CC:     <maz@kernel.org>, <will@kernel.org>,
        <linux-kernel@vger.kernel.org>, <shan.gavin@gmail.com>
From:   Keqian Zhu <zhukeqian1@huawei.com>
Message-ID: <05f08046-9c18-bbef-f502-47733000e9ff@huawei.com>
Date:   Tue, 16 Mar 2021 12:20:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <d46320a2-7381-a46a-42e5-6bfa75321d31@redhat.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.184.42]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gavin,

On 2021/3/16 11:52, Gavin Shan wrote:
> Hi Keqian,
> 
> On 3/15/21 8:42 PM, Gavin Shan wrote:
>> On 3/15/21 7:04 PM, Keqian Zhu wrote:
>>> On 2021/3/15 12:18, Gavin Shan wrote:
>>>> find_vma_intersection() has been existing to search the intersected
>>>> vma. This uses the function where it's applicable, to simplify the
>>>> code.
>>>>
>>>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>>>> ---
>>>>   arch/arm64/kvm/mmu.c | 10 ++++++----
>>>>   1 file changed, 6 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
>>>> index 84e70f953de6..286b603ed0d3 100644
>>>> --- a/arch/arm64/kvm/mmu.c
>>>> +++ b/arch/arm64/kvm/mmu.c
>>>> @@ -421,10 +421,11 @@ static void stage2_unmap_memslot(struct kvm *kvm,
>>>>        *     +--------------------------------------------+
>>>>        */
>>>>       do {
>>>> -        struct vm_area_struct *vma = find_vma(current->mm, hva);
>>>> +        struct vm_area_struct *vma;
>>>>           hva_t vm_start, vm_end;
>>>> -        if (!vma || vma->vm_start >= reg_end)
>>>> +        vma = find_vma_intersection(current->mm, hva, reg_end);
>>> Nit: Keep a same style may be better(Assign vma when declare it).
>>> Other looks good to me.
>>>
>>
>> Yeah, I agree. I will adjust the code in v2 and included your r-b.
>> Thanks for your time to review.
>>
> 
> After rechecking the code, I think it'd better to keep current style
> because there is a follow-on validation on @vma. Keeping them together
> seems a good idea. I think it wouldn't a big deal to you. So I will
> keep current style with your r-b in v2.
Sure, both is OK. ;-)

Thanks,
Keqian
> 
>     vma = find_vma_intersection(current->mm, hva, reg_end);
>         if (!vma)
>              break;
> Thanks,
> Gavin
>  
>>>> +        if (!vma)
>>>>               break;
>>>>           /*
>>>> @@ -1330,10 +1331,11 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
>>>>        *     +--------------------------------------------+
>>>>        */
>>>>       do {
>>>> -        struct vm_area_struct *vma = find_vma(current->mm, hva);
>>>> +        struct vm_area_struct *vma;
>>>>           hva_t vm_start, vm_end;
>>>> -        if (!vma || vma->vm_start >= reg_end)
>>>> +        vma = find_vma_intersection(current->mm, hva, reg_end);
>>>> +        if (!vma)
>>>>               break;
>>>>           /*
>>>>
>>>
>>
> 
> .
> 
