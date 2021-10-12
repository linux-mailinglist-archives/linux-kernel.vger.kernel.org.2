Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34EC9429C40
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 06:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbhJLE0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 00:26:24 -0400
Received: from foss.arm.com ([217.140.110.172]:43836 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229593AbhJLE0W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 00:26:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AFA85101E;
        Mon, 11 Oct 2021 21:24:21 -0700 (PDT)
Received: from [10.163.74.251] (unknown [10.163.74.251])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2591E3F70D;
        Mon, 11 Oct 2021 21:24:18 -0700 (PDT)
Subject: Re: [RFC V3 13/13] KVM: arm64: Enable FEAT_LPA2 based 52 bits IPA
 size on 4K and 16K
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        suzuki.poulose@arm.com, mark.rutland@arm.com, will@kernel.org,
        catalin.marinas@arm.com, james.morse@arm.com, steven.price@arm.com
References: <1632998116-11552-1-git-send-email-anshuman.khandual@arm.com>
 <1632998116-11552-14-git-send-email-anshuman.khandual@arm.com>
 <87r1crq32z.wl-maz@kernel.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <acf7847f-a6c6-38a7-7bce-48a24549716b@arm.com>
Date:   Tue, 12 Oct 2021 09:54:15 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87r1crq32z.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Marc,

On 10/11/21 3:46 PM, Marc Zyngier wrote:
> On Thu, 30 Sep 2021 11:35:16 +0100,
> Anshuman Khandual <anshuman.khandual@arm.com> wrote:
>>
>> Stage-2 FEAT_LPA2 support is independent and also orthogonal to FEAT_LPA2
>> support either in Stage-1 or in the host kernel. Stage-2 IPA range support
>> is evaluated from the platform via ID_AA64MMFR0_TGRAN_2_SUPPORTED_LPA2 and
>> gets enabled regardless of Stage-1 translation.
>>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>  arch/arm64/include/asm/kvm_pgtable.h | 10 +++++++++-
>>  arch/arm64/kvm/hyp/pgtable.c         | 25 +++++++++++++++++++++++--
>>  arch/arm64/kvm/reset.c               | 14 ++++++++++----
>>  3 files changed, 42 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
>> index 0277838..78a9d12 100644
>> --- a/arch/arm64/include/asm/kvm_pgtable.h
>> +++ b/arch/arm64/include/asm/kvm_pgtable.h
>> @@ -29,18 +29,26 @@ typedef u64 kvm_pte_t;
>>  
>>  #define KVM_PTE_ADDR_MASK		GENMASK(47, PAGE_SHIFT)
>>  #define KVM_PTE_ADDR_51_48		GENMASK(15, 12)
>> +#define KVM_PTE_ADDR_51_50		GENMASK(9, 8)
>>  
>>  static inline bool kvm_pte_valid(kvm_pte_t pte)
>>  {
>>  	return pte & KVM_PTE_VALID;
>>  }
>>  
>> +void set_kvm_lpa2_enabled(void);
>> +bool get_kvm_lpa2_enabled(void);
>> +
>>  static inline u64 kvm_pte_to_phys(kvm_pte_t pte)
>>  {
>>  	u64 pa = pte & KVM_PTE_ADDR_MASK;
>>  
>> -	if (PAGE_SHIFT == 16)
>> +	if (PAGE_SHIFT == 16) {
>>  		pa |= FIELD_GET(KVM_PTE_ADDR_51_48, pte) << 48;
>> +	} else {
>> +		if (get_kvm_lpa2_enabled())
> 
> Having to do a function call just for this test seems bad, specially
> for something that is used so often on the fault path.
> 
> Why can't this be made a normal capability that indicates LPA support
> for the current page size?

Although I could look into making this a normal capability check, would
not a static key based implementation be preferred if the function call
based construct here is too expensive ?

Originally, avoided capability method for stage-2 because it would have
been difficult in stage-1 where the FEAT_LPA2 detection is required way
earlier during boot before cpu capability comes up. Hence just followed
a simple variable method both for stage-1 and stage-2 keeping it same.

> 
>> +			pa |= FIELD_GET(KVM_PTE_ADDR_51_50, pte) << 50;
> 
> Where are bits 48 and 49?

Unlike the current FEAT_LPA feature, bits 48 and 49 are part of the PA
itself. Only the bits 50 and 51 move into bits 8 and 9, while creating
a PTE.

> 
>> +	}
>>  
>>  	return pa;
>>  }
>> diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
>> index f8ceebe..58141bf 100644
>> --- a/arch/arm64/kvm/hyp/pgtable.c
>> +++ b/arch/arm64/kvm/hyp/pgtable.c
>> @@ -49,6 +49,18 @@
>>  #define KVM_INVALID_PTE_OWNER_MASK	GENMASK(9, 2)
>>  #define KVM_MAX_OWNER_ID		1
>>  
>> +static bool kvm_lpa2_enabled;
>> +
>> +bool get_kvm_lpa2_enabled(void)
>> +{
>> +	return kvm_lpa2_enabled;
>> +}
>> +
>> +void set_kvm_lpa2_enabled(void)
>> +{
>> +	kvm_lpa2_enabled = true;
>> +}
>> +
>>  struct kvm_pgtable_walk_data {
>>  	struct kvm_pgtable		*pgt;
>>  	struct kvm_pgtable_walker	*walker;
>> @@ -126,8 +138,12 @@ static kvm_pte_t kvm_phys_to_pte(u64 pa)
>>  {
>>  	kvm_pte_t pte = pa & KVM_PTE_ADDR_MASK;
>>  
>> -	if (PAGE_SHIFT == 16)
>> +	if (PAGE_SHIFT == 16) {
>>  		pte |= FIELD_PREP(KVM_PTE_ADDR_51_48, pa >> 48);
>> +	} else {
>> +		if (get_kvm_lpa2_enabled())
>> +			pte |= FIELD_PREP(KVM_PTE_ADDR_51_50, pa >> 50);
>> +	}
>>  
>>  	return pte;
>>  }
>> @@ -540,6 +556,9 @@ u64 kvm_get_vtcr(u64 mmfr0, u64 mmfr1, u32 phys_shift)
>>  	 */
>>  	vtcr |= VTCR_EL2_HA;
>>  
>> +	if (get_kvm_lpa2_enabled())
>> +		vtcr |= VTCR_EL2_DS;
>> +
>>  	/* Set the vmid bits */
>>  	vtcr |= (get_vmid_bits(mmfr1) == 16) ?
>>  		VTCR_EL2_VS_16BIT :
>> @@ -577,7 +596,9 @@ static int stage2_set_prot_attr(struct kvm_pgtable *pgt, enum kvm_pgtable_prot p
>>  	if (prot & KVM_PGTABLE_PROT_W)
>>  		attr |= KVM_PTE_LEAF_ATTR_LO_S2_S2AP_W;
>>  
>> -	attr |= FIELD_PREP(KVM_PTE_LEAF_ATTR_LO_S2_SH, sh);
>> +	if (!get_kvm_lpa2_enabled())
>> +		attr |= FIELD_PREP(KVM_PTE_LEAF_ATTR_LO_S2_SH, sh);
>> +
>>  	attr |= KVM_PTE_LEAF_ATTR_LO_S2_AF;
>>  	attr |= prot & KVM_PTE_LEAF_ATTR_HI_SW;
>>  	*ptep = attr;
>> diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
>> index 5ce36b0..97ec387 100644
>> --- a/arch/arm64/kvm/reset.c
>> +++ b/arch/arm64/kvm/reset.c
>> @@ -315,26 +315,32 @@ u32 get_kvm_ipa_limit(void)
>>  
>>  int kvm_set_ipa_limit(void)
>>  {
>> -	unsigned int parange;
>> +	unsigned int parange, tgran;
>>  	u64 mmfr0;
>>  
>>  	mmfr0 = read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1);
>>  	parange = cpuid_feature_extract_unsigned_field(mmfr0,
>>  				ID_AA64MMFR0_PARANGE_SHIFT);
>> +	tgran = cpuid_feature_extract_unsigned_field(mmfr0,
>> +				ID_AA64MMFR0_TGRAN_2_SHIFT);
>>  	/*
>>  	 * IPA size beyond 48 bits could not be supported
>>  	 * on either 4K or 16K page size. Hence let's cap
>>  	 * it to 48 bits, in case it's reported as larger
>>  	 * on the system.
> 
> Shouldn't you fix this comment?

Ahh ! sure, will fix the comment.

> 
>>  	 */
>> -	if (PAGE_SIZE != SZ_64K)
>> -		parange = min(parange, (unsigned int)ID_AA64MMFR0_PARANGE_48);
>> +	if (PAGE_SIZE != SZ_64K) {
>> +		if (tgran == ID_AA64MMFR0_TGRAN_2_SUPPORTED_LPA2)
>> +			set_kvm_lpa2_enabled();
>> +		else
>> +			parange = min(parange, (unsigned int)ID_AA64MMFR0_PARANGE_48);
>> +	}
>>  
>>  	/*
>>  	 * Check with ARMv8.5-GTG that our PAGE_SIZE is supported at
>>  	 * Stage-2. If not, things will stop very quickly.
>>  	 */
>> -	switch (cpuid_feature_extract_unsigned_field(mmfr0, ID_AA64MMFR0_TGRAN_2_SHIFT)) {
>> +	switch (tgran) {
>>  	case ID_AA64MMFR0_TGRAN_2_SUPPORTED_NONE:
>>  		kvm_err("PAGE_SIZE not supported at Stage-2, giving up\n");
>>  		return -EINVAL;
> 
> Another thing I don't see is how you manage TLB invalidation by level
> now that we gain a level 0 at 4kB, breaking the current assumptions
> encoded in __tlbi_level().

Right, I guess something like this (not build tested) will be required as
level 0 for 4K and level 1 for 16K would only make sense when FEAT_LPA2 is
implemented, otherwise it will fallback to the default behaviour i.e table
level hint was not provided (TTL[3:2] is 0b00). Is there any other concern
which I might be missing here ?

--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -104,8 +104,7 @@ static inline unsigned long get_trans_granule(void)
 #define __tlbi_level(op, addr, level) do {                             \
        u64 arg = addr;                                                 \
                                                                        \
-       if (cpus_have_const_cap(ARM64_HAS_ARMv8_4_TTL) &&               \
-           level) {                                                    \
+       if (cpus_have_const_cap(ARM64_HAS_ARMv8_4_TTL) {                \
                u64 ttl = level & 3;                                    \
                ttl |= get_trans_granule() << 2;                        \
                arg &= ~TLBI_TTL_MASK;                                  \
