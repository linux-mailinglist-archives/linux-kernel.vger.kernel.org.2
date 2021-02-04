Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 446B330DE3E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 16:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234430AbhBCPd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 10:33:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:56860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233666AbhBCPc0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 10:32:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AE08A64E0A;
        Wed,  3 Feb 2021 15:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612366305;
        bh=bHk3MAJefGi29p8CkNqUBrcGux4IJL+yp5wmEqIttbY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UIKhMApMJbhWoR39hsVRU2nnuRGMZ7R+kdCmmdUFHHszReGleMxYEYRQMm+T6mNzd
         UxBbh9ZVRwzjHd46nKudViopC8J30ZUHTjw8es4Snh0bcMPT22jQsMYfsc54pPtWko
         tWSc3AJm6DgDW7NlJ/vgFV4reApE33G4C5W/S/rKFLbmKrAMmVH3QUvZS8gZdECoqx
         VgbPFdirmgRzCZthQZrRC6vYByWgLA2kD5KnxwOCit8jPImI5+B//gLduvqpUn80XI
         rqtt588qXOjj13kyZjH9UXWAgVW6pVCSXN3Plpfnph3HiiU2dILwfXTk9OmYv4+xF6
         pOeHmU5w/+huA==
Date:   Wed, 3 Feb 2021 15:31:39 +0000
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
Subject: Re: [RFC PATCH v2 17/26] KVM: arm64: Elevate Hyp mappings creation
 at EL2
Message-ID: <20210203153138.GB18974@willie-the-truck>
References: <20210108121524.656872-1-qperret@google.com>
 <20210108121524.656872-18-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210108121524.656872-18-qperret@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 08, 2021 at 12:15:15PM +0000, Quentin Perret wrote:
> Previous commits have introduced infrastructure at EL2 to enable the Hyp
> code to manage its own memory, and more specifically its stage 1 page
> tables. However, this was preliminary work, and none of it is currently
> in use.
> 
> Put all of this together by elevating the hyp mappings creation at EL2
> when memory protection is enabled. In this case, the host kernel running
> at EL1 still creates _temporary_ Hyp mappings, only used while
> initializing the hypervisor, but frees them right after.
> 
> As such, all calls to create_hyp_mappings() after kvm init has finished
> turn into hypercalls, as the host now has no 'legal' way to modify the
> hypevisor page tables directly.
> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/include/asm/kvm_mmu.h |  1 -
>  arch/arm64/kvm/arm.c             | 62 +++++++++++++++++++++++++++++---
>  arch/arm64/kvm/mmu.c             | 34 ++++++++++++++++++
>  3 files changed, 92 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
> index d7ebd73ec86f..6c8466a042a9 100644
> --- a/arch/arm64/include/asm/kvm_mmu.h
> +++ b/arch/arm64/include/asm/kvm_mmu.h
> @@ -309,6 +309,5 @@ static __always_inline void __load_guest_stage2(struct kvm_s2_mmu *mmu)
>  	 */
>  	asm(ALTERNATIVE("nop", "isb", ARM64_WORKAROUND_SPECULATIVE_AT));
>  }
> -
>  #endif /* __ASSEMBLY__ */
>  #endif /* __ARM64_KVM_MMU_H__ */
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index 6af9204bcd5b..e524682c2ccf 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -1421,7 +1421,7 @@ static void cpu_prepare_hyp_mode(int cpu)
>  	kvm_flush_dcache_to_poc(params, sizeof(*params));
>  }
>  
> -static void cpu_init_hyp_mode(void)
> +static void kvm_set_hyp_vector(void)

Please do something about the naming: now we have both cpu_set_hyp_vector()
and kvm_set_hyp_vector()!

>  {
>  	struct kvm_nvhe_init_params *params;
>  	struct arm_smccc_res res;
> @@ -1439,6 +1439,11 @@ static void cpu_init_hyp_mode(void)
>  	params = this_cpu_ptr_nvhe_sym(kvm_init_params);
>  	arm_smccc_1_1_hvc(KVM_HOST_SMCCC_FUNC(__kvm_hyp_init), virt_to_phys(params), &res);
>  	WARN_ON(res.a0 != SMCCC_RET_SUCCESS);
> +}
> +
> +static void cpu_init_hyp_mode(void)
> +{
> +	kvm_set_hyp_vector();
>  
>  	/*
>  	 * Disabling SSBD on a non-VHE system requires us to enable SSBS
> @@ -1481,7 +1486,10 @@ static void cpu_set_hyp_vector(void)
>  	struct bp_hardening_data *data = this_cpu_ptr(&bp_hardening_data);
>  	void *vector = hyp_spectre_vector_selector[data->slot];
>  
> -	*this_cpu_ptr_hyp_sym(kvm_hyp_vector) = (unsigned long)vector;
> +	if (!is_protected_kvm_enabled())
> +		*this_cpu_ptr_hyp_sym(kvm_hyp_vector) = (unsigned long)vector;
> +	else
> +		kvm_call_hyp_nvhe(__pkvm_cpu_set_vector, data->slot);

*Very* minor nit, but it might be cleaner to have static inline functions
with the same prototypes as the hypercalls, just to make the code even
easier to read. e.g

	if (!is_protected_kvm_enabled())
		_cpu_set_vector(data->slot);
	else
		kvm_call_hyp_nvhe(__pkvm_cpu_set_vector, data->slot);

you could then conceivably wrap that in a macro and avoid having the
"is_protected_kvm_enabled()" checks explicit every time.

>  }
>  
>  static void cpu_hyp_reinit(void)
> @@ -1489,13 +1497,14 @@ static void cpu_hyp_reinit(void)
>  	kvm_init_host_cpu_context(&this_cpu_ptr_hyp_sym(kvm_host_data)->host_ctxt);
>  
>  	cpu_hyp_reset();
> -	cpu_set_hyp_vector();
>  
>  	if (is_kernel_in_hyp_mode())
>  		kvm_timer_init_vhe();
>  	else
>  		cpu_init_hyp_mode();
>  
> +	cpu_set_hyp_vector();
> +
>  	kvm_arm_init_debug();
>  
>  	if (vgic_present)
> @@ -1714,13 +1723,52 @@ static int copy_cpu_ftr_regs(void)
>  	return 0;
>  }
>  
> +static int kvm_hyp_enable_protection(void)
> +{
> +	void *per_cpu_base = kvm_ksym_ref(kvm_arm_hyp_percpu_base);
> +	int ret, cpu;
> +	void *addr;
> +
> +	if (!is_protected_kvm_enabled())
> +		return 0;

Maybe I'm hung up on my previous suggestion, but I feel like we shouldn't
get here if protected kvm isn't enabled.

> +	if (!hyp_mem_base)
> +		return -ENOMEM;
> +
> +	addr = phys_to_virt(hyp_mem_base);
> +	ret = create_hyp_mappings(addr, addr + hyp_mem_size - 1, PAGE_HYP);
> +	if (ret)
> +		return ret;
> +
> +	preempt_disable();
> +	kvm_set_hyp_vector();
> +	ret = kvm_call_hyp_nvhe(__pkvm_init, hyp_mem_base, hyp_mem_size,
> +				num_possible_cpus(), kern_hyp_va(per_cpu_base));

Would it make sense for the __pkvm_init() hypercall to set the vector as
well, so that we wouldn't need to disable preemption over two hypercalls?

Failing that, maybe move the whole preempt_disable/enable sequence into
another function.

> +	preempt_enable();
> +	if (ret)
> +		return ret;
> +
> +	free_hyp_pgds();
> +	for_each_possible_cpu(cpu)
> +		free_page(per_cpu(kvm_arm_hyp_stack_page, cpu));
> +
> +	return 0;
> +}
> +
>  /**
>   * Inits Hyp-mode on all online CPUs
>   */
>  static int init_hyp_mode(void)
>  {
>  	int cpu;
> -	int err = 0;
> +	int err = -ENOMEM;
> +
> +	/*
> +	 * The protected Hyp-mode cannot be initialized if the memory pool
> +	 * allocation has failed.
> +	 */
> +	if (is_protected_kvm_enabled() && !hyp_mem_base)
> +		return err;
>  
>  	/*
>  	 * Copy the required CPU feature register in their EL2 counterpart
> @@ -1854,6 +1902,12 @@ static int init_hyp_mode(void)
>  	for_each_possible_cpu(cpu)
>  		cpu_prepare_hyp_mode(cpu);
>  
> +	err = kvm_hyp_enable_protection();
> +	if (err) {
> +		kvm_err("Failed to enable hyp memory protection: %d\n", err);
> +		goto out_err;
> +	}
> +
>  	return 0;
>  
>  out_err:
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index 3cf9397dabdb..9d4c9251208e 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -225,15 +225,39 @@ void free_hyp_pgds(void)
>  	if (hyp_pgtable) {
>  		kvm_pgtable_hyp_destroy(hyp_pgtable);
>  		kfree(hyp_pgtable);
> +		hyp_pgtable = NULL;
>  	}
>  	mutex_unlock(&kvm_hyp_pgd_mutex);
>  }
>  
> +static bool kvm_host_owns_hyp_mappings(void)
> +{
> +	if (static_branch_likely(&kvm_protected_mode_initialized))
> +		return false;
> +
> +	/*
> +	 * This can happen at boot time when __create_hyp_mappings() is called
> +	 * after the hyp protection has been enabled, but the static key has
> +	 * not been flipped yet.
> +	 */
> +	if (!hyp_pgtable && is_protected_kvm_enabled())
> +		return false;
> +
> +	BUG_ON(!hyp_pgtable);

Can we fail more gracefully, e.g. by continuing without KVM?

Will
