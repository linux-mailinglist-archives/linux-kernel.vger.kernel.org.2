Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC4E83E7C56
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 17:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243109AbhHJPc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 11:32:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:33506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241940AbhHJPcY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 11:32:24 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEDCC60E97;
        Tue, 10 Aug 2021 15:32:02 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mDTjU-004675-NO; Tue, 10 Aug 2021 16:32:00 +0100
MIME-Version: 1.0
Date:   Tue, 10 Aug 2021 16:32:00 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] KVM: arm64: Define KVM_PHYS_SHIFT_MIN
In-Reply-To: <43c5ffa3-b3c5-9154-72b5-811eeb9ece8f@arm.com>
References: <1628578961-29097-1-git-send-email-anshuman.khandual@arm.com>
 <1628578961-29097-6-git-send-email-anshuman.khandual@arm.com>
 <2dbeb2c329cfeb1ee9a7331683cdbc97@kernel.org>
 <43c5ffa3-b3c5-9154-72b5-811eeb9ece8f@arm.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <f6293361a98a6a9413643adeeb352f60@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: anshuman.khandual@arm.com, linux-arm-kernel@lists.infradead.org, james.morse@arm.com, alexandru.elisei@arm.com, suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org, kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-10 16:19, Anshuman Khandual wrote:
> On 8/10/21 6:59 PM, Marc Zyngier wrote:
>> On 2021-08-10 08:02, Anshuman Khandual wrote:
>>> Drop the hard coded value for the minimum IPA range i.e 32 bit. 
>>> Instead
>>> define a macro KVM_PHYS_SHIFT_MIN which improves the code 
>>> readability.
>>> 
>>> Cc: Marc Zyngier <maz@kernel.org>
>>> Cc: James Morse <james.morse@arm.com>
>>> Cc: Alexandru Elisei <alexandru.elisei@arm.com>
>>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>> Cc: Will Deacon <will@kernel.org>
>>> Cc: linux-arm-kernel@lists.infradead.org
>>> Cc: kvmarm@lists.cs.columbia.edu
>>> Cc: linux-kernel@vger.kernel.org
>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>> ---
>>>  arch/arm64/include/asm/kvm_mmu.h | 3 ++-
>>>  arch/arm64/kvm/reset.c           | 2 +-
>>>  2 files changed, 3 insertions(+), 2 deletions(-)
>>> 
>>> diff --git a/arch/arm64/include/asm/kvm_mmu.h 
>>> b/arch/arm64/include/asm/kvm_mmu.h
>>> index b52c5c4b9a3d..716f999818d9 100644
>>> --- a/arch/arm64/include/asm/kvm_mmu.h
>>> +++ b/arch/arm64/include/asm/kvm_mmu.h
>>> @@ -141,7 +141,8 @@ static __always_inline unsigned long
>>> __kern_hyp_va(unsigned long v)
>>>   * We currently support using a VM-specified IPA size. For backward
>>>   * compatibility, the default IPA size is fixed to 40bits.
>>>   */
>>> -#define KVM_PHYS_SHIFT    (40)
>>> +#define KVM_PHYS_SHIFT        (40)
>>> +#define KVM_PHYS_SHIFT_MIN    (32)
>>> 
>>>  #define kvm_phys_shift(kvm)        VTCR_EL2_IPA(kvm->arch.vtcr)
>>>  #define kvm_phys_size(kvm)        (_AC(1, ULL) << 
>>> kvm_phys_shift(kvm))
>>> diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
>>> index cba7872d69a8..8dc8b4b9de37 100644
>>> --- a/arch/arm64/kvm/reset.c
>>> +++ b/arch/arm64/kvm/reset.c
>>> @@ -369,7 +369,7 @@ int kvm_arm_setup_stage2(struct kvm *kvm, 
>>> unsigned
>>> long type)
>>>      phys_shift = KVM_VM_TYPE_ARM_IPA_SIZE(type);
>>>      if (phys_shift) {
>>>          if (phys_shift > kvm_ipa_limit ||
>>> -            phys_shift < 32)
>>> +            phys_shift < KVM_PHYS_SHIFT_MIN)
>>>              return -EINVAL;
>>>      } else {
>>>          phys_shift = KVM_PHYS_SHIFT;
>> 
>> This is not a KVM property, but an architectural one. If you
> 
> Architectural property which suggest the minimum physical address shift
> supported on a platform, as indicated via ID_AA64MMFR0.PARANGE = 0x0 ?

That's the one.

         M.
-- 
Jazz is not dead. It just smells funny...
