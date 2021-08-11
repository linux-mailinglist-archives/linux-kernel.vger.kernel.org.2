Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98F3D3E89C4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 07:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234293AbhHKFeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 01:34:21 -0400
Received: from foss.arm.com ([217.140.110.172]:42938 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229730AbhHKFeT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 01:34:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8DD671FB;
        Tue, 10 Aug 2021 22:33:56 -0700 (PDT)
Received: from [10.163.67.241] (unknown [10.163.67.241])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 12A223F718;
        Tue, 10 Aug 2021 22:33:53 -0700 (PDT)
Subject: Re: [PATCH 1/5] KVM: arm64: Drop direct PAGE_[SHIFT|SIZE] usage as
 page size
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
References: <1628578961-29097-1-git-send-email-anshuman.khandual@arm.com>
 <1628578961-29097-2-git-send-email-anshuman.khandual@arm.com>
 <25ee7799069492f2501003faec7f9732@kernel.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <0b47c654-7e9b-a7ca-bdf4-f9607062200e@arm.com>
Date:   Wed, 11 Aug 2021 11:04:46 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <25ee7799069492f2501003faec7f9732@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/10/21 7:03 PM, Marc Zyngier wrote:
> On 2021-08-10 08:02, Anshuman Khandual wrote:
>> All instances here could just directly test against CONFIG_ARM64_XXK_PAGES
>> instead of evaluating via PAGE_SHIFT or PAGE_SIZE. With this change, there
>> will be no such usage left.
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
>>  arch/arm64/kvm/hyp/pgtable.c | 6 +++---
>>  arch/arm64/mm/mmu.c          | 2 +-
>>  2 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
>> index 05321f4165e3..a6112b6d6ef6 100644
>> --- a/arch/arm64/kvm/hyp/pgtable.c
>> +++ b/arch/arm64/kvm/hyp/pgtable.c
>> @@ -85,7 +85,7 @@ static bool kvm_level_supports_block_mapping(u32 level)
>>       * Reject invalid block mappings and don't bother with 4TB mappings for
>>       * 52-bit PAs.
>>       */
>> -    return !(level == 0 || (PAGE_SIZE != SZ_4K && level == 1));
>> +    return !(level == 0 || (!IS_ENABLED(CONFIG_ARM64_4K_PAGES) && level == 1));
>>  }
>>
>>  static bool kvm_block_mapping_supported(u64 addr, u64 end, u64 phys, u32 level)
>> @@ -155,7 +155,7 @@ static u64 kvm_pte_to_phys(kvm_pte_t pte)
>>  {
>>      u64 pa = pte & KVM_PTE_ADDR_MASK;
>>
>> -    if (PAGE_SHIFT == 16)
>> +    if (IS_ENABLED(CONFIG_ARM64_64K_PAGES))
>>          pa |= FIELD_GET(KVM_PTE_ADDR_51_48, pte) << 48;
>>
>>      return pa;
>> @@ -165,7 +165,7 @@ static kvm_pte_t kvm_phys_to_pte(u64 pa)
>>  {
>>      kvm_pte_t pte = pa & KVM_PTE_ADDR_MASK;
>>
>> -    if (PAGE_SHIFT == 16)
>> +    if (IS_ENABLED(CONFIG_ARM64_64K_PAGES))
>>          pte |= FIELD_PREP(KVM_PTE_ADDR_51_48, pa >> 48);
>>
>>      return pte;
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index 9ff0de1b2b93..8fdfca179815 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -296,7 +296,7 @@ static void alloc_init_cont_pmd(pud_t *pudp,
>> unsigned long addr,
>>  static inline bool use_1G_block(unsigned long addr, unsigned long next,
>>              unsigned long phys)
>>  {
>> -    if (PAGE_SHIFT != 12)
>> +    if (!IS_ENABLED(CONFIG_ARM64_4K_PAGES))
>>          return false;
>>
>>      if (((addr | next | phys) & ~PUD_MASK) != 0)
> 
> I personally find it a lot less readable.
> 
> Also, there is no evaluation whatsoever. All the code guarded
> by a PAGE_SIZE/PAGE_SHIFT that doesn't match the configuration
> is dropped at compile time.

The primary idea here is to unify around IS_ENABLED(CONFIG_ARM64_XXK_PAGES)
usage in arm64, rather than having multiple methods to test page size when
ever required.
