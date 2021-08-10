Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 520F03E5BC0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 15:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241455AbhHJNdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 09:33:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:47572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235623AbhHJNdl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 09:33:41 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDFE960FDA;
        Tue, 10 Aug 2021 13:33:19 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mDRsb-0044Ei-UE; Tue, 10 Aug 2021 14:33:18 +0100
MIME-Version: 1.0
Date:   Tue, 10 Aug 2021 14:33:17 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] KVM: arm64: Drop direct PAGE_[SHIFT|SIZE] usage as
 page size
In-Reply-To: <1628578961-29097-2-git-send-email-anshuman.khandual@arm.com>
References: <1628578961-29097-1-git-send-email-anshuman.khandual@arm.com>
 <1628578961-29097-2-git-send-email-anshuman.khandual@arm.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <25ee7799069492f2501003faec7f9732@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: anshuman.khandual@arm.com, linux-arm-kernel@lists.infradead.org, james.morse@arm.com, alexandru.elisei@arm.com, suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org, kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-10 08:02, Anshuman Khandual wrote:
> All instances here could just directly test against 
> CONFIG_ARM64_XXK_PAGES
> instead of evaluating via PAGE_SHIFT or PAGE_SIZE. With this change, 
> there
> will be no such usage left.
> 
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: James Morse <james.morse@arm.com>
> Cc: Alexandru Elisei <alexandru.elisei@arm.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: kvmarm@lists.cs.columbia.edu
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  arch/arm64/kvm/hyp/pgtable.c | 6 +++---
>  arch/arm64/mm/mmu.c          | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/kvm/hyp/pgtable.c 
> b/arch/arm64/kvm/hyp/pgtable.c
> index 05321f4165e3..a6112b6d6ef6 100644
> --- a/arch/arm64/kvm/hyp/pgtable.c
> +++ b/arch/arm64/kvm/hyp/pgtable.c
> @@ -85,7 +85,7 @@ static bool kvm_level_supports_block_mapping(u32 
> level)
>  	 * Reject invalid block mappings and don't bother with 4TB mappings 
> for
>  	 * 52-bit PAs.
>  	 */
> -	return !(level == 0 || (PAGE_SIZE != SZ_4K && level == 1));
> +	return !(level == 0 || (!IS_ENABLED(CONFIG_ARM64_4K_PAGES) && level 
> == 1));
>  }
> 
>  static bool kvm_block_mapping_supported(u64 addr, u64 end, u64 phys, 
> u32 level)
> @@ -155,7 +155,7 @@ static u64 kvm_pte_to_phys(kvm_pte_t pte)
>  {
>  	u64 pa = pte & KVM_PTE_ADDR_MASK;
> 
> -	if (PAGE_SHIFT == 16)
> +	if (IS_ENABLED(CONFIG_ARM64_64K_PAGES))
>  		pa |= FIELD_GET(KVM_PTE_ADDR_51_48, pte) << 48;
> 
>  	return pa;
> @@ -165,7 +165,7 @@ static kvm_pte_t kvm_phys_to_pte(u64 pa)
>  {
>  	kvm_pte_t pte = pa & KVM_PTE_ADDR_MASK;
> 
> -	if (PAGE_SHIFT == 16)
> +	if (IS_ENABLED(CONFIG_ARM64_64K_PAGES))
>  		pte |= FIELD_PREP(KVM_PTE_ADDR_51_48, pa >> 48);
> 
>  	return pte;
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 9ff0de1b2b93..8fdfca179815 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -296,7 +296,7 @@ static void alloc_init_cont_pmd(pud_t *pudp,
> unsigned long addr,
>  static inline bool use_1G_block(unsigned long addr, unsigned long 
> next,
>  			unsigned long phys)
>  {
> -	if (PAGE_SHIFT != 12)
> +	if (!IS_ENABLED(CONFIG_ARM64_4K_PAGES))
>  		return false;
> 
>  	if (((addr | next | phys) & ~PUD_MASK) != 0)

I personally find it a lot less readable.

Also, there is no evaluation whatsoever. All the code guarded
by a PAGE_SIZE/PAGE_SHIFT that doesn't match the configuration
is dropped at compile time.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
