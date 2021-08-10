Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFCAC3E5B9D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 15:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238853AbhHJN3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 09:29:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:46216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229663AbhHJN3i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 09:29:38 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C49FD60F25;
        Tue, 10 Aug 2021 13:29:16 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mDRog-00448e-Ro; Tue, 10 Aug 2021 14:29:15 +0100
MIME-Version: 1.0
Date:   Tue, 10 Aug 2021 14:29:14 +0100
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
In-Reply-To: <1628578961-29097-6-git-send-email-anshuman.khandual@arm.com>
References: <1628578961-29097-1-git-send-email-anshuman.khandual@arm.com>
 <1628578961-29097-6-git-send-email-anshuman.khandual@arm.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <2dbeb2c329cfeb1ee9a7331683cdbc97@kernel.org>
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
> Drop the hard coded value for the minimum IPA range i.e 32 bit. Instead
> define a macro KVM_PHYS_SHIFT_MIN which improves the code readability.
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
>  arch/arm64/include/asm/kvm_mmu.h | 3 ++-
>  arch/arm64/kvm/reset.c           | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_mmu.h 
> b/arch/arm64/include/asm/kvm_mmu.h
> index b52c5c4b9a3d..716f999818d9 100644
> --- a/arch/arm64/include/asm/kvm_mmu.h
> +++ b/arch/arm64/include/asm/kvm_mmu.h
> @@ -141,7 +141,8 @@ static __always_inline unsigned long
> __kern_hyp_va(unsigned long v)
>   * We currently support using a VM-specified IPA size. For backward
>   * compatibility, the default IPA size is fixed to 40bits.
>   */
> -#define KVM_PHYS_SHIFT	(40)
> +#define KVM_PHYS_SHIFT		(40)
> +#define KVM_PHYS_SHIFT_MIN	(32)
> 
>  #define kvm_phys_shift(kvm)		VTCR_EL2_IPA(kvm->arch.vtcr)
>  #define kvm_phys_size(kvm)		(_AC(1, ULL) << kvm_phys_shift(kvm))
> diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
> index cba7872d69a8..8dc8b4b9de37 100644
> --- a/arch/arm64/kvm/reset.c
> +++ b/arch/arm64/kvm/reset.c
> @@ -369,7 +369,7 @@ int kvm_arm_setup_stage2(struct kvm *kvm, unsigned
> long type)
>  	phys_shift = KVM_VM_TYPE_ARM_IPA_SIZE(type);
>  	if (phys_shift) {
>  		if (phys_shift > kvm_ipa_limit ||
> -		    phys_shift < 32)
> +		    phys_shift < KVM_PHYS_SHIFT_MIN)
>  			return -EINVAL;
>  	} else {
>  		phys_shift = KVM_PHYS_SHIFT;

This is not a KVM property, but an architectural one. If you
want to replace it with something more readable, please
make it global to the whole of arm64 (ARM64_MIN_PARANGE?).

Thanks,

       M.
-- 
Jazz is not dead. It just smells funny...
