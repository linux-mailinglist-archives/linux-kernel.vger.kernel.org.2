Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93BA832D99E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 19:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235020AbhCDSsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 13:48:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:35016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234985AbhCDSsF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 13:48:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3E6AB64F62;
        Thu,  4 Mar 2021 18:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614883645;
        bh=S7ckbpy5k+FMYq7pq6vAO3yRrbvaZRD48psVeKkEYws=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lmub3J0ySh9kg/YLOGmK63ZbK4yI7/sglPxmzJMzMwvqJxE0oghLQQSsHTkhaxGc4
         NRpLwz3FaDRDzrthiSL/C/y3P7P051jjtBZ2ExkZcisAeTmryPNf/pkxg4deSP/nM1
         0VrYJ2dZKWW3EfQ0Uu71CqKtLX3t5w5zSwyR86aoM/TVojE169AJrUTm6VIh9z5+mr
         elIjgsFyBf+pRcuvSUfZGz+bFS3Hvzfvv2mjPx3QxT3Iq1FGvsxg9iE3F0NHMOrwH3
         fiqLrWI6x98xdPeFFudWVgSrScA3kkHyaB2LelAmsrNTwT2f3rD+unKJ3rSGn44QFo
         8SMiBub77GgJg==
Date:   Thu, 4 Mar 2021 18:47:17 +0000
From:   Will Deacon <will@kernel.org>
To:     Quentin Perret <qperret@google.com>
Cc:     catalin.marinas@arm.com, maz@kernel.org, james.morse@arm.com,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
        android-kvm@google.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, tabba@google.com,
        mark.rutland@arm.com, dbrazdil@google.com, mate.toth-pal@arm.com,
        seanjc@google.com, robh+dt@kernel.org
Subject: Re: [PATCH v3 15/32] KVM: arm64: Prepare the creation of s1 mappings
 at EL2
Message-ID: <20210304184717.GB21795@willie-the-truck>
References: <20210302150002.3685113-1-qperret@google.com>
 <20210302150002.3685113-16-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210302150002.3685113-16-qperret@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quentin,

On Tue, Mar 02, 2021 at 02:59:45PM +0000, Quentin Perret wrote:
> When memory protection is enabled, the EL2 code needs the ability to
> create and manage its own page-table. To do so, introduce a new set of
> hypercalls to bootstrap a memory management system at EL2.
> 
> This leads to the following boot flow in nVHE Protected mode:
> 
>  1. the host allocates memory for the hypervisor very early on, using
>     the memblock API;
> 
>  2. the host creates a set of stage 1 page-table for EL2, installs the
>     EL2 vectors, and issues the __pkvm_init hypercall;
> 
>  3. during __pkvm_init, the hypervisor re-creates its stage 1 page-table
>     and stores it in the memory pool provided by the host;
> 
>  4. the hypervisor then extends its stage 1 mappings to include a
>     vmemmap in the EL2 VA space, hence allowing to use the buddy
>     allocator introduced in a previous patch;
> 
>  5. the hypervisor jumps back in the idmap page, switches from the
>     host-provided page-table to the new one, and wraps up its
>     initialization by enabling the new allocator, before returning to
>     the host.
> 
>  6. the host can free the now unused page-table created for EL2, and
>     will now need to issue hypercalls to make changes to the EL2 stage 1
>     mappings instead of modifying them directly.
> 
> Note that for the sake of simplifying the review, this patch focuses on
> the hypervisor side of things. In other words, this only implements the
> new hypercalls, but does not make use of them from the host yet. The
> host-side changes will follow in a subsequent patch.
> 
> Credits to Will for __pkvm_init_switch_pgd.
> 
> Co-authored-by: Will Deacon <will@kernel.org>
> Signed-off-by: Will Deacon <will@kernel.org>
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/include/asm/kvm_asm.h     |   4 +
>  arch/arm64/include/asm/kvm_host.h    |   7 +
>  arch/arm64/include/asm/kvm_hyp.h     |   8 ++
>  arch/arm64/include/asm/kvm_pgtable.h |   2 +
>  arch/arm64/kernel/image-vars.h       |  16 +++
>  arch/arm64/kvm/hyp/Makefile          |   2 +-
>  arch/arm64/kvm/hyp/include/nvhe/mm.h |  71 ++++++++++
>  arch/arm64/kvm/hyp/nvhe/Makefile     |   4 +-
>  arch/arm64/kvm/hyp/nvhe/hyp-init.S   |  31 +++++
>  arch/arm64/kvm/hyp/nvhe/hyp-main.c   |  49 +++++++
>  arch/arm64/kvm/hyp/nvhe/mm.c         | 173 ++++++++++++++++++++++++
>  arch/arm64/kvm/hyp/nvhe/setup.c      | 195 +++++++++++++++++++++++++++
>  arch/arm64/kvm/hyp/pgtable.c         |   2 -
>  arch/arm64/kvm/hyp/reserved_mem.c    |  92 +++++++++++++
>  arch/arm64/mm/init.c                 |   3 +
>  15 files changed, 654 insertions(+), 5 deletions(-)

This mostly looks good to me, but in a patch this size I was bound to spot
a few niggles. It is _huge_!

> diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-init.S b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
> index c631e29fb001..bc56ea92b812 100644
> --- a/arch/arm64/kvm/hyp/nvhe/hyp-init.S
> +++ b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
> @@ -244,4 +244,35 @@ alternative_else_nop_endif
>  
>  SYM_CODE_END(__kvm_handle_stub_hvc)
>  
> +SYM_FUNC_START(__pkvm_init_switch_pgd)
> +	/* Turn the MMU off */
> +	pre_disable_mmu_workaround
> +	mrs	x2, sctlr_el2
> +	bic	x3, x2, #SCTLR_ELx_M
> +	msr	sctlr_el2, x3
> +	isb
> +
> +	tlbi	alle2
> +
> +	/* Install the new pgtables */
> +	ldr	x3, [x0, #NVHE_INIT_PGD_PA]
> +	phys_to_ttbr x4, x3
> +alternative_if ARM64_HAS_CNP
> +	orr	x4, x4, #TTBR_CNP_BIT
> +alternative_else_nop_endif
> +	msr	ttbr0_el2, x4
> +
> +	/* Set the new stack pointer */
> +	ldr	x0, [x0, #NVHE_INIT_STACK_HYP_VA]
> +	mov	sp, x0
> +
> +	/* And turn the MMU back on! */
> +	dsb	nsh
> +	isb
> +	msr	sctlr_el2, x2
> +	ic	iallu
> +	isb

Comparing with the new-fangled set_sctlr_el1 macro we have, this sequence
isn't quite right. Probably best to introduce set_sctlr_el2, and implement
that and the existing macro in terms of set_sctlr_elX or something like
that.

> +void __noreturn __pkvm_init_finalise(void)
> +{
> +	struct kvm_host_data *host_data = this_cpu_ptr(&kvm_host_data);
> +	struct kvm_cpu_context *host_ctxt = &host_data->host_ctxt;
> +	unsigned long nr_pages, reserved_pages, pfn;
> +	int ret;
> +
> +	/* Now that the vmemmap is backed, install the full-fledged allocator */
> +	pfn = hyp_virt_to_pfn(hyp_pgt_base);
> +	nr_pages = hyp_s1_pgtable_pages();
> +	reserved_pages = hyp_early_alloc_nr_used_pages();
> +	ret = hyp_pool_init(&hpool, pfn, nr_pages, reserved_pages);
> +	if (ret)
> +		goto out;
> +
> +	pkvm_pgtable_mm_ops.zalloc_page = hyp_zalloc_hyp_page;
> +	pkvm_pgtable_mm_ops.phys_to_virt = hyp_phys_to_virt;
> +	pkvm_pgtable_mm_ops.virt_to_phys = hyp_virt_to_phys;
> +	pkvm_pgtable_mm_ops.get_page = hyp_get_page;
> +	pkvm_pgtable_mm_ops.put_page = hyp_put_page;
> +	pkvm_pgtable.mm_ops = &pkvm_pgtable_mm_ops;

Can you do:

	pkvm_pgtable_mm_ops = (struct kvm_pgtable_mm_ops) {
		.zalloc_page	= hyp_zalloc_hyp_page,
		.phys_to_virt	= ...,
		...
	};

here?

> +
> +out:
> +	/*
> +	 * We tail-called to here from handle___pkvm_init() and will not return,
> +	 * so make sure to propagate the return value to the host.
> +	 */
> +	cpu_reg(host_ctxt, 1) = ret;
> +
> +	__host_enter(host_ctxt);
> +}
> +
> +int __pkvm_init(phys_addr_t phys, unsigned long size, unsigned long nr_cpus,
> +		unsigned long *per_cpu_base, u32 hyp_va_bits)
> +{
> +	struct kvm_nvhe_init_params *params;
> +	void *virt = hyp_phys_to_virt(phys);
> +	void (*fn)(phys_addr_t params_pa, void *finalize_fn_va);
> +	int ret;
> +
> +	if (phys % PAGE_SIZE || size % PAGE_SIZE)
> +		return -EINVAL;

Either PAGE_ALIGNED or '& ~PAGE_MASK' would be better than spelling this
with '%', I reckon.

Anyway, other than these nits:

Acked-by: Will Deacon <will@kernel.org>

Will
