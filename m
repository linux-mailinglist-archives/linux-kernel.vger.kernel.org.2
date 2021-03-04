Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA5AF32DA5B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 20:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbhCDT0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 14:26:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:43582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233627AbhCDT02 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 14:26:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9CD2A64F60;
        Thu,  4 Mar 2021 19:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614885947;
        bh=d5oyr0RbUTr11eGau8HQOa9mCj+ZMHZCRHmDN/GuD5o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eoTTgYBi5Y3qIoUH4K2ybb28vRP9ms605NREGXE9ltqXx1sIS6WNUyKEXteNnyJPy
         eEfyhYFaf9li2Otd8xLVO7qcKq6MJIjSalFKpTMcq17zvI9cwWJKu5Vb5EFb/XYVCZ
         2IhNMlyJJZIN8U3rm1c2NqktkoeCD+i0qn2po3eWk5i7wnVk5izKSyIF1LPV5o/s2B
         4+q7xqXHuRHVQ0OjT47DYPDjKn2VxmZ9f8NWSo0KIZFDjJ5IHlICuwqRUoBEqS0RvA
         8m5RZ0wJ8gGiEWFgJJycEvk9brxtFyGUFBb1kaXyBbB0CCMxFv+GreCHZ0D/QEfFtn
         shJ9nsNOAfWxg==
Date:   Thu, 4 Mar 2021 19:25:41 +0000
From:   Will Deacon <will@kernel.org>
To:     Quentin Perret <qperret@google.com>
Cc:     catalin.marinas@arm.com, maz@kernel.org, james.morse@arm.com,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
        android-kvm@google.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, tabba@google.com,
        mark.rutland@arm.com, dbrazdil@google.com, mate.toth-pal@arm.com,
        seanjc@google.com, robh+dt@kernel.org
Subject: Re: [PATCH v3 16/32] KVM: arm64: Elevate hypervisor mappings
 creation at EL2
Message-ID: <20210304192540.GE21795@willie-the-truck>
References: <20210302150002.3685113-1-qperret@google.com>
 <20210302150002.3685113-17-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210302150002.3685113-17-qperret@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2021 at 02:59:46PM +0000, Quentin Perret wrote:
> Previous commits have introduced infrastructure to enable the EL2 code
> to manage its own stage 1 mappings. However, this was preliminary work,
> and none of it is currently in use.
> 
> Put all of this together by elevating the mapping creation at EL2 when
> memory protection is enabled. In this case, the host kernel running
> at EL1 still creates _temporary_ EL2 mappings, only used while
> initializing the hypervisor, but frees them right after.
> 
> As such, all calls to create_hyp_mappings() after kvm init has finished
> turn into hypercalls, as the host now has no 'legal' way to modify the
> hypevisor page tables directly.
> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/include/asm/kvm_mmu.h |  2 +-
>  arch/arm64/kvm/arm.c             | 87 +++++++++++++++++++++++++++++---
>  arch/arm64/kvm/mmu.c             | 43 ++++++++++++++--
>  3 files changed, 120 insertions(+), 12 deletions(-)

[...]

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
> @@ -1691,18 +1700,59 @@ static void teardown_hyp_mode(void)
>  	}
>  }
>  
> +static int do_pkvm_init(u32 hyp_va_bits)
> +{
> +	void *per_cpu_base = kvm_ksym_ref(kvm_arm_hyp_percpu_base);
> +	int ret;
> +
> +	preempt_disable();
> +	hyp_install_host_vector();

It's a shame we need this both here _and_ on the reinit path, but it looks
like it's necessary.

> +	ret = kvm_call_hyp_nvhe(__pkvm_init, hyp_mem_base, hyp_mem_size,
> +				num_possible_cpus(), kern_hyp_va(per_cpu_base),
> +				hyp_va_bits);
> +	preempt_enable();
> +
> +	return ret;
> +}

[...]

>  /**
>   * Inits Hyp-mode on all online CPUs
>   */
>  static int init_hyp_mode(void)
>  {
> +	u32 hyp_va_bits;
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

This skips the error message you get on the out_err path.

> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index 4d41d7838d53..9d331bf262d2 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -221,15 +221,39 @@ void free_hyp_pgds(void)
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
> +	WARN_ON(!hyp_pgtable);
> +
> +	return true;

	return !(WARN_ON(!hyp_pgtable) && is_protected_kvm_enabled());

?

Will
