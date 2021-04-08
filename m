Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9851F3587FA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 17:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbhDHPPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 11:15:15 -0400
Received: from foss.arm.com ([217.140.110.172]:51056 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232089AbhDHPPJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 11:15:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F0694D6E;
        Thu,  8 Apr 2021 08:14:57 -0700 (PDT)
Received: from [192.168.0.110] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 24AA83F694;
        Thu,  8 Apr 2021 08:14:56 -0700 (PDT)
Subject: Re: [PATCH v6 06/20] kvm: arm64: Move SPE availability check to VCPU
 load
To:     Suzuki K Poulose <suzuki.poulose@arm.com>, maz@kernel.org,
        mathieu.poirier@linaro.org
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, anshuman.khandual@arm.com,
        mike.leach@linaro.org, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, leo.yan@linaro.org, robh@kernel.org,
        James Morse <james.morse@arm.com>
References: <20210405164307.1720226-1-suzuki.poulose@arm.com>
 <20210405164307.1720226-7-suzuki.poulose@arm.com>
From:   Alexandru Elisei <alexandru.elisei@arm.com>
Message-ID: <a5b99e5d-2658-45e6-443d-9bb047a2ddd1@arm.com>
Date:   Thu, 8 Apr 2021 16:14:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210405164307.1720226-7-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On 4/5/21 5:42 PM, Suzuki K Poulose wrote:
> At the moment, we check the availability of SPE on the given
> CPU (i.e, SPE is implemented and is allowed at the host) during
> every guest entry. This can be optimized a bit by moving the
> check to vcpu_load time and recording the availability of the
> feature on the current CPU via a new flag. This will also be useful
> for adding the TRBE support.
>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Alexandru Elisei <Alexandru.Elisei@arm.com>
> Cc: James Morse <james.morse@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  arch/arm64/include/asm/kvm_host.h  |  5 +++++
>  arch/arm64/kvm/arm.c               |  2 ++
>  arch/arm64/kvm/debug.c             | 23 +++++++++++++++++++++++
>  arch/arm64/kvm/hyp/nvhe/debug-sr.c | 22 +++++++++-------------
>  4 files changed, 39 insertions(+), 13 deletions(-)
>
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 3d10e6527f7d..acc2b45dd433 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -400,6 +400,7 @@ struct kvm_vcpu_arch {
>  #define KVM_ARM64_GUEST_HAS_PTRAUTH	(1 << 7) /* PTRAUTH exposed to guest */
>  #define KVM_ARM64_PENDING_EXCEPTION	(1 << 8) /* Exception pending */
>  #define KVM_ARM64_EXCEPT_MASK		(7 << 9) /* Target EL/MODE */
> +#define KVM_ARM64_DEBUG_STATE_SAVE_SPE	(1 << 12) /* Save SPE context if active  */

Would you consider renaming the flag to something more generic, like
KVM_ARM64_CPU_HAS_SPE or KVM_ARM64_HOST_HAS_SPE (or something else that you
fancy)? I'm thinking that it might be possible for the flag to be used for
something else in the future.

Also, the comment is somewhat misleading, the flag tells KVM that the physical CPU
has FEAT_SPE, not that the host is actually using SPE. That check is done in the
world switch code.

>  
>  /*
>   * When KVM_ARM64_PENDING_EXCEPTION is set, KVM_ARM64_EXCEPT_MASK can
> @@ -734,6 +735,10 @@ static inline bool kvm_pmu_counter_deferred(struct perf_event_attr *attr)
>  	return (!has_vhe() && attr->exclude_host);
>  }
>  
> +/* Flags for host debug state */
> +void kvm_arch_vcpu_load_debug_state_flags(struct kvm_vcpu *vcpu);
> +void kvm_arch_vcpu_put_debug_state_flags(struct kvm_vcpu *vcpu);
> +
>  #ifdef CONFIG_KVM /* Avoid conflicts with core headers if CONFIG_KVM=n */
>  static inline int kvm_arch_vcpu_run_pid_change(struct kvm_vcpu *vcpu)
>  {
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index 7f06ba76698d..954752208509 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -416,10 +416,12 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
>  
>  	if (vcpu_has_ptrauth(vcpu))
>  		vcpu_ptrauth_disable(vcpu);
> +	kvm_arch_vcpu_load_debug_state_flags(vcpu);
>  }
>  
>  void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
>  {
> +	kvm_arch_vcpu_put_debug_state_flags(vcpu);
>  	kvm_arch_vcpu_put_fp(vcpu);
>  	if (has_vhe())
>  		kvm_vcpu_put_sysregs_vhe(vcpu);

This looks like the correct approach to me. kvm_arch_vcpu_{load,put} are called
when the VCPU is moved around to another physical CPU, so it makes sense to have
the checks here.

> diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
> index dbc890511631..b6d2c33ad1df 100644
> --- a/arch/arm64/kvm/debug.c
> +++ b/arch/arm64/kvm/debug.c
> @@ -231,3 +231,26 @@ void kvm_arm_clear_debug(struct kvm_vcpu *vcpu)
>  		}
>  	}
>  }
> +
> +void kvm_arch_vcpu_load_debug_state_flags(struct kvm_vcpu *vcpu)
> +{
> +	u64 dfr0;
> +
> +	/* For VHE, there is nothing to do */
> +	if (has_vhe())
> +		return;
> +
> +	dfr0 = read_sysreg(id_aa64dfr0_el1);
> +	/*
> +	 * If SPE is present on this CPU and is available at current EL,
> +	 * we may need to check if the host state needs to be saved.
> +	 */
> +	if (cpuid_feature_extract_unsigned_field(dfr0, ID_AA64DFR0_PMSVER_SHIFT) &&
> +	    !(read_sysreg_s(SYS_PMBIDR_EL1) & BIT(SYS_PMBIDR_EL1_P_SHIFT)))
> +		vcpu->arch.flags |= KVM_ARM64_DEBUG_STATE_SAVE_SPE;
> +}

This also looks correct, and it matches the equivalent checks that were removed
from __debug_save_spe().

> +
> +void kvm_arch_vcpu_put_debug_state_flags(struct kvm_vcpu *vcpu)
> +{
> +	vcpu->arch.flags &= ~KVM_ARM64_DEBUG_STATE_SAVE_SPE;
> +}
> diff --git a/arch/arm64/kvm/hyp/nvhe/debug-sr.c b/arch/arm64/kvm/hyp/nvhe/debug-sr.c
> index f401724f12ef..e6ee9b7faec6 100644
> --- a/arch/arm64/kvm/hyp/nvhe/debug-sr.c
> +++ b/arch/arm64/kvm/hyp/nvhe/debug-sr.c
> @@ -21,17 +21,11 @@ static void __debug_save_spe(u64 *pmscr_el1)
>  	/* Clear pmscr in case of early return */
>  	*pmscr_el1 = 0;
>  
> -	/* SPE present on this CPU? */
> -	if (!cpuid_feature_extract_unsigned_field(read_sysreg(id_aa64dfr0_el1),
> -						  ID_AA64DFR0_PMSVER_SHIFT))
> -		return;
> -
> -	/* Yes; is it owned by EL3? */
> -	reg = read_sysreg_s(SYS_PMBIDR_EL1);
> -	if (reg & BIT(SYS_PMBIDR_EL1_P_SHIFT))
> -		return;
> -
> -	/* No; is the host actually using the thing? */
> +	/*
> +	 * At this point, we know that this CPU implements

Nitpick: the line length looks suspiciously short here.

Thanks,

Alex

> +	 * SPE and is available to the host.
> +	 * Check if the host is actually using it ?
> +	 */
>  	reg = read_sysreg_s(SYS_PMBLIMITR_EL1);
>  	if (!(reg & BIT(SYS_PMBLIMITR_EL1_E_SHIFT)))
>  		return;
> @@ -61,7 +55,8 @@ static void __debug_restore_spe(u64 pmscr_el1)
>  void __debug_save_host_buffers_nvhe(struct kvm_vcpu *vcpu)
>  {
>  	/* Disable and flush SPE data generation */
> -	__debug_save_spe(&vcpu->arch.host_debug_state.pmscr_el1);
> +	if (vcpu->arch.flags & KVM_ARM64_DEBUG_STATE_SAVE_SPE)
> +		__debug_save_spe(&vcpu->arch.host_debug_state.pmscr_el1);
>  }
>  
>  void __debug_switch_to_guest(struct kvm_vcpu *vcpu)
> @@ -71,7 +66,8 @@ void __debug_switch_to_guest(struct kvm_vcpu *vcpu)
>  
>  void __debug_restore_host_buffers_nvhe(struct kvm_vcpu *vcpu)
>  {
> -	__debug_restore_spe(vcpu->arch.host_debug_state.pmscr_el1);
> +	if (vcpu->arch.flags & KVM_ARM64_DEBUG_STATE_SAVE_SPE)
> +		__debug_restore_spe(vcpu->arch.host_debug_state.pmscr_el1);
>  }
>  
>  void __debug_switch_to_host(struct kvm_vcpu *vcpu)
