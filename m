Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0E6030DED9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 16:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234660AbhBCP4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 10:56:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:32902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234048AbhBCPym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 10:54:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 71DCF64F55;
        Wed,  3 Feb 2021 15:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612367641;
        bh=LboLHM+6kIOh+gRaFnxe+9BKVjr4IMqy2/wdrtr8YPM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dIc9iPjjDgDhe3A+EVOFewT1KzjihGTkkVlbtTGWiLbdsiMbRFH0KhRIz9uZyia+f
         z93MgcrhCcxUQW725BBor3g+fQMct+Ns9J1l1dOY9ipYK+E8rvrYvuhuS4lbKQEKXz
         WEizc349XENeMZw90ZJej3JfWzD40pwKEhEIxmqrWpnvxCJYqeAVs4TCp3+k5ogpIy
         skemPMst7d2Z+O6clupBCwPXsNNZQcPWpVXw1b05kHptOzLsL+sX8ygfoWZupSUnWB
         HzwOwX9AGaub0Ao697Dy1MzA7k1CBwREMIdS5S0wFhurodwQNLbhTBjQvZ1yuNqGFr
         ufDHaSbamHi0w==
Date:   Wed, 3 Feb 2021 15:53:54 +0000
From:   Will Deacon <will@kernel.org>
To:     Quentin Perret <qperret@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, android-kvm@google.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        Fuad Tabba <tabba@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        David Brazdil <dbrazdil@google.com>
Subject: Re: [RFC PATCH v2 21/26] KVM: arm64: Refactor kvm_arm_setup_stage2()
Message-ID: <20210203155354.GE18974@willie-the-truck>
References: <20210108121524.656872-1-qperret@google.com>
 <20210108121524.656872-22-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210108121524.656872-22-qperret@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 08, 2021 at 12:15:19PM +0000, Quentin Perret wrote:
> In order to re-use some of the stage 2 setup at EL2, factor parts of
> kvm_arm_setup_stage2() out into static inline functions.
> 
> No functional change intended.
> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/include/asm/kvm_mmu.h | 48 ++++++++++++++++++++++++++++++++
>  arch/arm64/kvm/reset.c           | 42 +++-------------------------
>  2 files changed, 52 insertions(+), 38 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
> index 662f0415344e..83b4c5cf4768 100644
> --- a/arch/arm64/include/asm/kvm_mmu.h
> +++ b/arch/arm64/include/asm/kvm_mmu.h
> @@ -280,6 +280,54 @@ static inline int kvm_write_guest_lock(struct kvm *kvm, gpa_t gpa,
>  	return ret;
>  }
>  
> +static inline u64 kvm_get_parange(u64 mmfr0)
> +{
> +	u64 parange = cpuid_feature_extract_unsigned_field(mmfr0,
> +				ID_AA64MMFR0_PARANGE_SHIFT);
> +	if (parange > ID_AA64MMFR0_PARANGE_MAX)
> +		parange = ID_AA64MMFR0_PARANGE_MAX;
> +
> +	return parange;
> +}
> +
> +/*
> + * The VTCR value is common across all the physical CPUs on the system.
> + * We use system wide sanitised values to fill in different fields,
> + * except for Hardware Management of Access Flags. HA Flag is set
> + * unconditionally on all CPUs, as it is safe to run with or without
> + * the feature and the bit is RES0 on CPUs that don't support it.
> + */
> +static inline u64 kvm_get_vtcr(u64 mmfr0, u64 mmfr1, u32 phys_shift)
> +{
> +	u64 vtcr = VTCR_EL2_FLAGS;
> +	u8 lvls;
> +
> +	vtcr |= kvm_get_parange(mmfr0) << VTCR_EL2_PS_SHIFT;
> +	vtcr |= VTCR_EL2_T0SZ(phys_shift);
> +	/*
> +	 * Use a minimum 2 level page table to prevent splitting
> +	 * host PMD huge pages at stage2.
> +	 */
> +	lvls = stage2_pgtable_levels(phys_shift);
> +	if (lvls < 2)
> +		lvls = 2;
> +	vtcr |= VTCR_EL2_LVLS_TO_SL0(lvls);
> +
> +	/*
> +	 * Enable the Hardware Access Flag management, unconditionally
> +	 * on all CPUs. The features is RES0 on CPUs without the support
> +	 * and must be ignored by the CPUs.
> +	 */
> +	vtcr |= VTCR_EL2_HA;
> +
> +	/* Set the vmid bits */
> +	vtcr |= (get_vmid_bits(mmfr1) == 16) ?
> +		VTCR_EL2_VS_16BIT :
> +		VTCR_EL2_VS_8BIT;
> +
> +	return vtcr;
> +}

Although I think this is functionally fine, I think it's unusual to see
large "static inline" functions like this in shared header files. One
alternative approach would be to follow the example of
kernel/locking/qspinlock_paravirt.h, where the header is guarded in such a
way that is only ever included by kernel/locking/qspinlock.c and therefore
doesn't need the "inline" at all. That separation really helps, I think.

Will
