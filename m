Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B98942B38F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 05:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237638AbhJMDa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 23:30:56 -0400
Received: from foss.arm.com ([217.140.110.172]:45524 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237282AbhJMDax (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 23:30:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 747A91FB;
        Tue, 12 Oct 2021 20:28:50 -0700 (PDT)
Received: from [10.163.74.158] (unknown [10.163.74.158])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B087F3F70D;
        Tue, 12 Oct 2021 20:28:47 -0700 (PDT)
Subject: Re: [RFC V3 13/13] KVM: arm64: Enable FEAT_LPA2 based 52 bits IPA
 size on 4K and 16K
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        suzuki.poulose@arm.com, mark.rutland@arm.com, will@kernel.org,
        catalin.marinas@arm.com, james.morse@arm.com, steven.price@arm.com
References: <1632998116-11552-1-git-send-email-anshuman.khandual@arm.com>
 <1632998116-11552-14-git-send-email-anshuman.khandual@arm.com>
 <87r1crq32z.wl-maz@kernel.org> <acf7847f-a6c6-38a7-7bce-48a24549716b@arm.com>
 <87k0iiprvz.wl-maz@kernel.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <2e48f9c3-020f-5769-aeaf-f704bb35a827@arm.com>
Date:   Wed, 13 Oct 2021 08:58:44 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87k0iiprvz.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/12/21 2:00 PM, Marc Zyngier wrote:
> On Tue, 12 Oct 2021 05:24:15 +0100,
> Anshuman Khandual <anshuman.khandual@arm.com> wrote:
>>
>> Hello Marc,
>>
>> On 10/11/21 3:46 PM, Marc Zyngier wrote:
>>> On Thu, 30 Sep 2021 11:35:16 +0100,
>>> Anshuman Khandual <anshuman.khandual@arm.com> wrote:
>>>>
>>>> Stage-2 FEAT_LPA2 support is independent and also orthogonal to FEAT_LPA2
>>>> support either in Stage-1 or in the host kernel. Stage-2 IPA range support
>>>> is evaluated from the platform via ID_AA64MMFR0_TGRAN_2_SUPPORTED_LPA2 and
>>>> gets enabled regardless of Stage-1 translation.
>>>>
>>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>>> ---
>>>>  arch/arm64/include/asm/kvm_pgtable.h | 10 +++++++++-
>>>>  arch/arm64/kvm/hyp/pgtable.c         | 25 +++++++++++++++++++++++--
>>>>  arch/arm64/kvm/reset.c               | 14 ++++++++++----
>>>>  3 files changed, 42 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
>>>> index 0277838..78a9d12 100644
>>>> --- a/arch/arm64/include/asm/kvm_pgtable.h
>>>> +++ b/arch/arm64/include/asm/kvm_pgtable.h
>>>> @@ -29,18 +29,26 @@ typedef u64 kvm_pte_t;
>>>>  
>>>>  #define KVM_PTE_ADDR_MASK		GENMASK(47, PAGE_SHIFT)
>>>>  #define KVM_PTE_ADDR_51_48		GENMASK(15, 12)
>>>> +#define KVM_PTE_ADDR_51_50		GENMASK(9, 8)
>>>>  
>>>>  static inline bool kvm_pte_valid(kvm_pte_t pte)
>>>>  {
>>>>  	return pte & KVM_PTE_VALID;
>>>>  }
>>>>  
>>>> +void set_kvm_lpa2_enabled(void);
>>>> +bool get_kvm_lpa2_enabled(void);
>>>> +
>>>>  static inline u64 kvm_pte_to_phys(kvm_pte_t pte)
>>>>  {
>>>>  	u64 pa = pte & KVM_PTE_ADDR_MASK;
>>>>  
>>>> -	if (PAGE_SHIFT == 16)
>>>> +	if (PAGE_SHIFT == 16) {
>>>>  		pa |= FIELD_GET(KVM_PTE_ADDR_51_48, pte) << 48;
>>>> +	} else {
>>>> +		if (get_kvm_lpa2_enabled())
>>>
>>> Having to do a function call just for this test seems bad, specially
>>> for something that is used so often on the fault path.
>>>
>>> Why can't this be made a normal capability that indicates LPA support
>>> for the current page size?
>>
>> Although I could look into making this a normal capability check, would
>> not a static key based implementation be preferred if the function call
>> based construct here is too expensive ?
> 
> A capability *is* a static key. Specially if you make it final.

Sure.

> 
>> Originally, avoided capability method for stage-2 because it would have
>> been difficult in stage-1 where the FEAT_LPA2 detection is required way
>> earlier during boot before cpu capability comes up. Hence just followed
>> a simple variable method both for stage-1 and stage-2 keeping it same.
> 
> I think you'll have to find a way to make it work with a capability
> for S1 too. Capabilities can be used even when not final, and you may
> have to do something similar.

Sure, will explore that.

> 
>>>
>>>> +			pa |= FIELD_GET(KVM_PTE_ADDR_51_50, pte) << 50;
>>>
>>> Where are bits 48 and 49?
>>
>> Unlike the current FEAT_LPA feature, bits 48 and 49 are part of the PA
>> itself. Only the bits 50 and 51 move into bits 8 and 9, while creating
>> a PTE.
> 
> So why are you actively dropping these bits? Hint: look at
> KVM_PTE_ADDR_MASK and the way it is used to extract the initial value
> of 'pa'.

Right, will need another address mask i.e KVM_PTE_ADDR_MASK_50 which will
extract the PA field both in kvm_pte_to_phys() and kvm_phys_to_pte().

> 
> [...]
> 
>>> Another thing I don't see is how you manage TLB invalidation by level
>>> now that we gain a level 0 at 4kB, breaking the current assumptions
>>> encoded in __tlbi_level().
>>
>> Right, I guess something like this (not build tested) will be required as
>> level 0 for 4K and level 1 for 16K would only make sense when FEAT_LPA2 is
>> implemented, otherwise it will fallback to the default behaviour i.e table
>> level hint was not provided (TTL[3:2] is 0b00). Is there any other concern
>> which I might be missing here ?
>>
>> --- a/arch/arm64/include/asm/tlbflush.h
>> +++ b/arch/arm64/include/asm/tlbflush.h
>> @@ -104,8 +104,7 @@ static inline unsigned long get_trans_granule(void)
>>  #define __tlbi_level(op, addr, level) do {                             \
>>         u64 arg = addr;                                                 \
>>                                                                         \
>> -       if (cpus_have_const_cap(ARM64_HAS_ARMv8_4_TTL) &&               \
>> -           level) {                                                    \
>> +       if (cpus_have_const_cap(ARM64_HAS_ARMv8_4_TTL) {                \
>>                 u64 ttl = level & 3;                                    \
>>                 ttl |= get_trans_granule() << 2;                        \
>>                 arg &= ~TLBI_TTL_MASK;                                  \
>>
> 
> That's a start, but 0 has always meant 'at any level' until now. You
> will have to audit all the call sites and work out whether they can
> pass 0 if they don't track the actual level.

Hmm, sure will audit the call sites. But wondering if the caller is not
sure about the level, should not it just use __tlbi(op, arg) instead ?
Seems like __tlbi_level(op, addr, level) should only accept level as 0
when the level is determined to be 0. The actual impact will depend on
if FEAT_LPA2 is implemented otherwise it falls back to __tlbi(op, arg).
Basically we should convert existing sites which call __tlbi_level()
with level as 0 (without determining), to use __tlbi() directly ?
