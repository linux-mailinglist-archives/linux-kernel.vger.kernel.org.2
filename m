Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2662832DA7D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 20:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235593AbhCDTkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 14:40:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:45574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230458AbhCDTjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 14:39:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3C5D464F60;
        Thu,  4 Mar 2021 19:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614886753;
        bh=aI8BOthiv/XoVAjzXsTcAVCGuPJu3RX8bBEOeiMMP9o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vp0R4MR5XPFCy4evMVY9Vhpn4ovFcqqoWie42ktox8X+fmC5jgR2XEXc0BeOWRA6H
         E8wvUpqIm13NOUVJr2L98dKT7kw7SEOx7/N/EECcqV180dE8pNuIR/ZiwapF2Yl5zk
         IEg+uIjwUjn2SyFAd4ABLrOb7ZqYEguwYk9RHqXGZ5+o2DNNPYclFMVZFhH8q0qGRc
         s/VE2a55ukN3Khe20GuGf2NADpo5cS2lI6HSClJLYGYeJyb1BgerxfT58ynWBYqZB4
         ZsouCxcFwBO2R2M+9nlJgsHJh4oT2VuNJIp92oatIqzDM/hlT4OmFCdBNuOosI+4i+
         Guz9+bCddyRww==
Date:   Thu, 4 Mar 2021 19:39:07 +0000
From:   Will Deacon <will@kernel.org>
To:     Quentin Perret <qperret@google.com>
Cc:     catalin.marinas@arm.com, maz@kernel.org, james.morse@arm.com,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
        android-kvm@google.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, tabba@google.com,
        mark.rutland@arm.com, dbrazdil@google.com, mate.toth-pal@arm.com,
        seanjc@google.com, robh+dt@kernel.org
Subject: Re: [PATCH v3 22/32] KVM: arm64: Refactor __populate_fault_info()
Message-ID: <20210304193906.GB21950@willie-the-truck>
References: <20210302150002.3685113-1-qperret@google.com>
 <20210302150002.3685113-23-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210302150002.3685113-23-qperret@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2021 at 02:59:52PM +0000, Quentin Perret wrote:
> Refactor __populate_fault_info() to introduce __get_fault_info() which
> will be used once the host is wrapped in a stage 2.
> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/kvm/hyp/include/hyp/switch.h | 37 ++++++++++++++-----------
>  1 file changed, 21 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
> index 6c1f51f25eb3..1f017c9851bb 100644
> --- a/arch/arm64/kvm/hyp/include/hyp/switch.h
> +++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
> @@ -160,19 +160,9 @@ static inline bool __translate_far_to_hpfar(u64 far, u64 *hpfar)
>  	return true;
>  }
>  
> -static inline bool __populate_fault_info(struct kvm_vcpu *vcpu)
> +static inline bool __get_fault_info(u64 esr, struct kvm_vcpu_fault_info *fault)
>  {
> -	u8 ec;
> -	u64 esr;
> -	u64 hpfar, far;
> -
> -	esr = vcpu->arch.fault.esr_el2;
> -	ec = ESR_ELx_EC(esr);
> -
> -	if (ec != ESR_ELx_EC_DABT_LOW && ec != ESR_ELx_EC_IABT_LOW)
> -		return true;
> -
> -	far = read_sysreg_el2(SYS_FAR);
> +	fault->far_el2 = read_sysreg_el2(SYS_FAR);
>  
>  	/*
>  	 * The HPFAR can be invalid if the stage 2 fault did not
> @@ -188,14 +178,29 @@ static inline bool __populate_fault_info(struct kvm_vcpu *vcpu)
>  	if (!(esr & ESR_ELx_S1PTW) &&
>  	    (cpus_have_final_cap(ARM64_WORKAROUND_834220) ||
>  	     (esr & ESR_ELx_FSC_TYPE) == FSC_PERM)) {
> -		if (!__translate_far_to_hpfar(far, &hpfar))
> +		if (!__translate_far_to_hpfar(fault->far_el2, &fault->hpfar_el2))
>  			return false;
>  	} else {
> -		hpfar = read_sysreg(hpfar_el2);
> +		fault->hpfar_el2 = read_sysreg(hpfar_el2);
>  	}
>  
> -	vcpu->arch.fault.far_el2 = far;
> -	vcpu->arch.fault.hpfar_el2 = hpfar;
> +	return true;
> +}
> +
> +static inline bool __populate_fault_info(struct kvm_vcpu *vcpu)
> +{
> +	u8 ec;
> +	u64 esr;
> +
> +	esr = vcpu->arch.fault.esr_el2;
> +	ec = ESR_ELx_EC(esr);
> +
> +	if (ec != ESR_ELx_EC_DABT_LOW && ec != ESR_ELx_EC_IABT_LOW)
> +		return true;
> +
> +	if (!__get_fault_info(esr, &vcpu->arch.fault))
> +		return false;
> +
>  	return true;

Just return __get_fault_info(esr, &vcpu->arch.fault); here.

With that:

Acked-by: Will Deacon <will@kernel.org>

Will
