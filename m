Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E06863D1440
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 18:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234204AbhGUPvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 11:51:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:60720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231219AbhGUPvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 11:51:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 94EDF60FF3;
        Wed, 21 Jul 2021 16:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626885104;
        bh=b+eyZKwXabnVt+UjMV9OoFipdi6nkiIvKOjz34qdmyU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q/Kp5r04BDGIq0tKftkH8+P/tDazAi/vkiZ2bx3TbNLkTUpGZ5KqFK6XlqETvPGWs
         tECA1E08WuXB81889LUTDQAPms55KzycEkQi3Eiz6UsRKYAYF6eaO9+7d+QXM9v4ge
         yeFk1WMgoR/sKFTjLAq56pZ48rr823kk70dDlUfCnIYBMV1Q5snj42ZeIRsyYV6Dxw
         f45/atVNb/rrxq0QpBqxh+7FzLsE5zq14324k7tKcq2NjGZbE4gQIOZjFP6841Pnih
         7mQBBxS1XMuXc4BAh+t6nxG8cPh9v7Uz2CcXsVu8WYRj7RMu2feJqqJWYvA2Hid+mK
         b42QWSiMRdL9Q==
Date:   Wed, 21 Jul 2021 17:31:39 +0100
From:   Will Deacon <will@kernel.org>
To:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, maz@kernel.org,
        catalin.marinas@arm.com, james.morse@arm.com,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
        jean-philippe@linaro.org, Alexandru.Elisei@arm.com,
        linuxarm@huawei.com, qperret@google.com
Subject: Re: [PATCH v2 3/3] kvm/arm: Align the VMID allocation with the arm64
 ASID one
Message-ID: <20210721163138.GD11003@willie-the-truck>
References: <20210616155606.2806-1-shameerali.kolothum.thodi@huawei.com>
 <20210616155606.2806-4-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210616155606.2806-4-shameerali.kolothum.thodi@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+Quentin]

On Wed, Jun 16, 2021 at 04:56:06PM +0100, Shameer Kolothum wrote:
> From: Julien Grall <julien.grall@arm.com>
> 
> At the moment, the VMID algorithm will send an SGI to all the CPUs to
> force an exit and then broadcast a full TLB flush and I-Cache
> invalidation.
> 
> This patch use the new VMID allocator. The
> benefits are:
>     - CPUs are not forced to exit at roll-over. Instead the VMID will be
>     marked reserved and the context will be flushed at next exit. This
>     will reduce the IPIs traffic.
>     - Context invalidation is now per-CPU rather than broadcasted.
>     - Catalin has a formal model of the ASID allocator.
> 
> With the new algo, the code is now adapted:
>     - The function __kvm_flush_vm_context() has been renamed to
>     __kvm_tlb_flush_local_all() and now only flushing the current CPU
>     context.
>     - The call to update_vmid() will be done with preemption disabled
>     as the new algo requires to store information per-CPU.
>     - The TLBs associated to EL1 will be flushed when booting a CPU to
>     deal with stale information. This was previously done on the
>     allocation of the first VMID of a new generation.
> 
> Signed-off-by: Julien Grall <julien.grall@arm.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  arch/arm64/include/asm/kvm_asm.h      |   4 +-
>  arch/arm64/include/asm/kvm_host.h     |   6 +-
>  arch/arm64/include/asm/kvm_mmu.h      |   3 +-
>  arch/arm64/kvm/Makefile               |   2 +-
>  arch/arm64/kvm/arm.c                  | 115 +++++++-------------------
>  arch/arm64/kvm/hyp/nvhe/hyp-main.c    |   6 +-
>  arch/arm64/kvm/hyp/nvhe/mem_protect.c |   3 +-
>  arch/arm64/kvm/hyp/nvhe/tlb.c         |  10 +--
>  arch/arm64/kvm/hyp/vhe/tlb.c          |  10 +--
>  arch/arm64/kvm/mmu.c                  |   1 -
>  10 files changed, 52 insertions(+), 108 deletions(-)

[...]

> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 75a7e8071012..d96284da8571 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -70,9 +70,7 @@ int kvm_reset_vcpu(struct kvm_vcpu *vcpu);
>  void kvm_arm_vcpu_destroy(struct kvm_vcpu *vcpu);
>  
>  struct kvm_vmid {
> -	/* The VMID generation used for the virt. memory system */
> -	u64    vmid_gen;
> -	u32    vmid;
> +	atomic64_t id;

Maybe a typedef would be better if this is the only member of the structure?

> diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> index 4b60c0056c04..a02c4877a055 100644
> --- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> +++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> @@ -106,8 +106,7 @@ int kvm_host_prepare_stage2(void *mem_pgt_pool, void *dev_pgt_pool)
>  	mmu->pgd_phys = __hyp_pa(host_kvm.pgt.pgd);
>  	mmu->arch = &host_kvm.arch;
>  	mmu->pgt = &host_kvm.pgt;
> -	mmu->vmid.vmid_gen = 0;
> -	mmu->vmid.vmid = 0;
> +	atomic64_set(&mmu->vmid.id, 0);

I think this is the first atomic64 use in the EL2 object, which may pull in
some fatal KCSAN instrumentation. Quentin, have you run into this before?

Might be simple just to zero-initialise mmu for now, if it isn't already.

> diff --git a/arch/arm64/kvm/hyp/nvhe/tlb.c b/arch/arm64/kvm/hyp/nvhe/tlb.c
> index 83dc3b271bc5..42df9931ed9a 100644
> --- a/arch/arm64/kvm/hyp/nvhe/tlb.c
> +++ b/arch/arm64/kvm/hyp/nvhe/tlb.c
> @@ -140,10 +140,10 @@ void __kvm_flush_cpu_context(struct kvm_s2_mmu *mmu)
>  	__tlb_switch_to_host(&cxt);
>  }
>  
> -void __kvm_flush_vm_context(void)
> +void __kvm_tlb_flush_local_all(void)
>  {
> -	dsb(ishst);
> -	__tlbi(alle1is);
> +	dsb(nshst);
> +	__tlbi(alle1);
>  
>  	/*
>  	 * VIPT and PIPT caches are not affected by VMID, so no maintenance
> @@ -155,7 +155,7 @@ void __kvm_flush_vm_context(void)
>  	 *
>  	 */
>  	if (icache_is_vpipt())
> -		asm volatile("ic ialluis");
> +		asm volatile("ic iallu" : : );
>  
> -	dsb(ish);
> +	dsb(nsh);

Hmm, I'm wondering whether having this local stuff really makes sense for
VMIDs. For ASIDs, where rollover can be frequent and TLBI could result in
IPI on 32-bit, the local option was important, but here rollover is less
frequent, DVM is relied upon to work and the cost of a hypercall is
significant with nVHE.

So I do think you could simplify patch 2 slightly to drop the
flush_pending and just issue inner-shareable invalidation on rollover.
With that, it might also make it straightforward to clear active_asids
when scheduling out a vCPU, which would solve the other problem I mentioned
about unnecessarily reserving a bunch of the VMID space.

Will
