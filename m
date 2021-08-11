Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D649A3E8EE3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 12:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236993AbhHKKm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 06:42:58 -0400
Received: from foss.arm.com ([217.140.110.172]:47518 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236830AbhHKKmy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 06:42:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 636A9106F;
        Wed, 11 Aug 2021 03:42:30 -0700 (PDT)
Received: from [10.163.67.241] (unknown [10.163.67.241])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 227203F70D;
        Wed, 11 Aug 2021 03:42:26 -0700 (PDT)
Subject: Re: [PATCH] KVM: arm64: Restrict IPA size to maximum 48 bits on 4K
 and 16K page size
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
References: <1628657549-27584-1-git-send-email-anshuman.khandual@arm.com>
 <87v94c9vbu.wl-maz@kernel.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <acffb56d-8d35-93dc-f96e-61f763bda876@arm.com>
Date:   Wed, 11 Aug 2021 16:13:18 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87v94c9vbu.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/11/21 3:06 PM, Marc Zyngier wrote:
> On Wed, 11 Aug 2021 05:52:29 +0100,
> Anshuman Khandual <anshuman.khandual@arm.com> wrote:
>>
>> Even though ID_AA64MMFR0.PARANGE reports 52 bit PA size support, it cannot
>> be enabled as guest IPA size on 4K or 16K page size configurations. Hence
>> kvm_ipa_limit must be restricted to 48 bits. This change achieves required
>> IPA capping.
>>
>> Before the commit c9b69a0cf0b4 ("KVM: arm64: Don't constrain maximum IPA
>> size based on host configuration"), the problem here would have been just
>> latent via PHYS_MASK_SHIFT (which earlier in turn capped kvm_ipa_limit),
>> which remains capped at 48 bits on 4K and 16K configs.
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
>> Fixes: c9b69a0cf0b4 ("KVM: arm64: Don't constrain maximum IPA size based on host configuration")
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>> This applies on v5.14-rc5
>>
>>  arch/arm64/kvm/reset.c | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
>> index 20588220fe66..e66974c4b9d3 100644
>> --- a/arch/arm64/kvm/reset.c
>> +++ b/arch/arm64/kvm/reset.c
>> @@ -337,6 +337,15 @@ int kvm_set_ipa_limit(void)
>>  		return -EINVAL;
>>  	}
>>  
>> +	/*
>> +	 * IPA size beyond 48 bits could not be supported
>> +	 * on either 4K or 16K page size. Hence let's cap
>> +	 * it to 48 bits, in case it's reported as larger
>> +	 * on the system.
>> +	 */
>> +	if (!IS_ENABLED(CONFIG_ARM64_64K_PAGES))
> 
> As per our earlier discussion, please use (PAGE_SIZE != SZ_64K)
> instead. This is in keeping with the rest of the file.

Sure, will change.

> 
>> +		parange = min(parange, (unsigned int)ID_AA64MMFR0_PARANGE_48);
>> +
> 
> Also, please move it next to the point where we assign parange.

Sure, will move.


> 
>>  	kvm_ipa_limit = id_aa64mmfr0_parange_to_phys_shift(parange);
>>  	kvm_info("IPA Size Limit: %d bits%s\n", kvm_ipa_limit,
>>  		 ((kvm_ipa_limit < KVM_PHYS_SHIFT) ?
> 
> Thanks,
> 
> 	M.
> 
