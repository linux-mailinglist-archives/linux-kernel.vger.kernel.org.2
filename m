Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 293BC3E7BF7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 17:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241560AbhHJPTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 11:19:12 -0400
Received: from foss.arm.com ([217.140.110.172]:57866 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239937AbhHJPTL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 11:19:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F14001FB;
        Tue, 10 Aug 2021 08:18:48 -0700 (PDT)
Received: from [10.163.67.89] (unknown [10.163.67.89])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DA9403F718;
        Tue, 10 Aug 2021 08:18:45 -0700 (PDT)
Subject: Re: [PATCH 5/5] KVM: arm64: Define KVM_PHYS_SHIFT_MIN
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
References: <1628578961-29097-1-git-send-email-anshuman.khandual@arm.com>
 <1628578961-29097-6-git-send-email-anshuman.khandual@arm.com>
 <2dbeb2c329cfeb1ee9a7331683cdbc97@kernel.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <43c5ffa3-b3c5-9154-72b5-811eeb9ece8f@arm.com>
Date:   Tue, 10 Aug 2021 20:49:38 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <2dbeb2c329cfeb1ee9a7331683cdbc97@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/10/21 6:59 PM, Marc Zyngier wrote:
> On 2021-08-10 08:02, Anshuman Khandual wrote:
>> Drop the hard coded value for the minimum IPA range i.e 32 bit. Instead
>> define a macro KVM_PHYS_SHIFT_MIN which improves the code readability.
>>
>> Cc: Marc Zyngier <maz@kernel.org>
>> Cc: James Morse <james.morse@arm.com>
>> Cc: Alexandru Elisei <alexandru.elisei@arm.com>
>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: kvmarm@lists.cs.columbia.edu
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>  arch/arm64/include/asm/kvm_mmu.h | 3 ++-
>>  arch/arm64/kvm/reset.c           | 2 +-
>>  2 files changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
>> index b52c5c4b9a3d..716f999818d9 100644
>> --- a/arch/arm64/include/asm/kvm_mmu.h
>> +++ b/arch/arm64/include/asm/kvm_mmu.h
>> @@ -141,7 +141,8 @@ static __always_inline unsigned long
>> __kern_hyp_va(unsigned long v)
>>   * We currently support using a VM-specified IPA size. For backward
>>   * compatibility, the default IPA size is fixed to 40bits.
>>   */
>> -#define KVM_PHYS_SHIFT    (40)
>> +#define KVM_PHYS_SHIFT        (40)
>> +#define KVM_PHYS_SHIFT_MIN    (32)
>>
>>  #define kvm_phys_shift(kvm)        VTCR_EL2_IPA(kvm->arch.vtcr)
>>  #define kvm_phys_size(kvm)        (_AC(1, ULL) << kvm_phys_shift(kvm))
>> diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
>> index cba7872d69a8..8dc8b4b9de37 100644
>> --- a/arch/arm64/kvm/reset.c
>> +++ b/arch/arm64/kvm/reset.c
>> @@ -369,7 +369,7 @@ int kvm_arm_setup_stage2(struct kvm *kvm, unsigned
>> long type)
>>      phys_shift = KVM_VM_TYPE_ARM_IPA_SIZE(type);
>>      if (phys_shift) {
>>          if (phys_shift > kvm_ipa_limit ||
>> -            phys_shift < 32)
>> +            phys_shift < KVM_PHYS_SHIFT_MIN)
>>              return -EINVAL;
>>      } else {
>>          phys_shift = KVM_PHYS_SHIFT;
> 
> This is not a KVM property, but an architectural one. If you

Architectural property which suggest the minimum physical address shift
supported on a platform, as indicated via ID_AA64MMFR0.PARANGE = 0x0 ?

> want to replace it with something more readable, please
> make it global to the whole of arm64 (ARM64_MIN_PARANGE?).

Sure, will do.
