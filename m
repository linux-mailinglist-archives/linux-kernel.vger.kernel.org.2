Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70CC9330A37
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 10:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbhCHJW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 04:22:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhCHJWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 04:22:34 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091E2C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 01:22:34 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id j4-20020a05600c4104b029010c62bc1e20so3339731wmi.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 01:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0wn1k12IObBSAf32SE0KCqTitXtW5mNtKdHhq2mOrMY=;
        b=UdRjEZ2y6pnaUSwljPzU1frw+Av+eepQnydTG1sfSUQ/WaiMD0IrLaGLoA6rqQrxZa
         2k7rr2uLKxYo+5qlPaoThG4a28OqN2NHbf5EkhztI9G5UcDeqLRzf/QB4RRcqEVR0vF6
         s0fsQe/kG3ecUR1bf7tjhzcYuscmPBb9D97iap1bf410sQHlzp7u4H2C2ztK285IHHfK
         eeqNNg4XxvE66e485ATKuBrFnbgZbIY0LoUPcslm/h3Y04nnkp8FRcEsjLITDej4diTR
         ONMFgKQlyiwEYuFPG6uzaBLp8oVfznFmGWHPtjzADrVEXLhADvRqV80POCb+Ew/NRseP
         2Y9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0wn1k12IObBSAf32SE0KCqTitXtW5mNtKdHhq2mOrMY=;
        b=nCvacN8hi0dSxgajZEFwHr9euntusQlb7a3zo9ZuqVA/mfEws9Iqbi0w0H6a1TsgE3
         LHNQm3pmad89IQIIMZhiK0xRmwT/5TrusAqvX7IHnfFyDG5Erfc1RV8nstdYfyn3NsVo
         YlOmPhahXIX2AjWH8o60QvIneky3grdgoVjR4HefTWJh+ZzgeR/K9ue7epMcotuWbNeq
         3UGhq1fkHdMhSUg8p89BeGk2I4kSvAUVYA/CwO1uGEogBNAuZyL2uX/TVMchA3T4Ls6r
         cbIAVUlu16DA8LZSgEyKKyYRjSmzRpQs6aKjem/q6tDXOsR9K13WP+x6cmIT9AfNlcyp
         6vTQ==
X-Gm-Message-State: AOAM531SlXWFlAnhujLDrpZ3lVLEYLuUMphZslXIiAVV1Ac572PHuAYp
        JpWG3MAjC97ISzI3A2UUU8mRrg==
X-Google-Smtp-Source: ABdhPJyMErNCpwJzHXC9mGTwvukOJHoTjnF/kwwK2qvIdfnrM8hS13ZPhAjSaVANxFQ/Rkz7cO8Maw==
X-Received: by 2002:a1c:c282:: with SMTP id s124mr20813818wmf.99.1615195352531;
        Mon, 08 Mar 2021 01:22:32 -0800 (PST)
Received: from google.com (230.69.233.35.bc.googleusercontent.com. [35.233.69.230])
        by smtp.gmail.com with ESMTPSA id u23sm17816348wmn.26.2021.03.08.01.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 01:22:32 -0800 (PST)
Date:   Mon, 8 Mar 2021 09:22:29 +0000
From:   Quentin Perret <qperret@google.com>
To:     Will Deacon <will@kernel.org>
Cc:     catalin.marinas@arm.com, maz@kernel.org, james.morse@arm.com,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
        android-kvm@google.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, tabba@google.com,
        mark.rutland@arm.com, dbrazdil@google.com, mate.toth-pal@arm.com,
        seanjc@google.com, robh+dt@kernel.org
Subject: Re: [PATCH v3 29/32] KVM: arm64: Wrap the host with a stage 2
Message-ID: <YEXs1cOlmhHg4u8x@google.com>
References: <20210302150002.3685113-1-qperret@google.com>
 <20210302150002.3685113-30-qperret@google.com>
 <20210305192905.GE23633@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210305192905.GE23633@willie-the-truck>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 05 Mar 2021 at 19:29:06 (+0000), Will Deacon wrote:
> On Tue, Mar 02, 2021 at 02:59:59PM +0000, Quentin Perret wrote:
> > +static __always_inline void __load_host_stage2(void)
> > +{
> > +	if (static_branch_likely(&kvm_protected_mode_initialized))
> > +		__load_stage2(&host_kvm.arch.mmu, host_kvm.arch.vtcr);
> > +	else
> > +		write_sysreg(0, vttbr_el2);
> 
> I realise you've just moved the code, but why is this needed? All we've
> done is point the stage-2 ttb at 0x0 (i.e. we haven't disabled anything).

Right, but that is also used for tlb maintenance operations, e.g.
__tlb_switch_to_host() and friends.

> > +#endif /* __KVM_NVHE_MEM_PROTECT__ */
> > diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
> > index e204ea77ab27..ce49795324a7 100644
> > --- a/arch/arm64/kvm/hyp/nvhe/Makefile
> > +++ b/arch/arm64/kvm/hyp/nvhe/Makefile
> > @@ -14,7 +14,7 @@ lib-objs := $(addprefix ../../../lib/, $(lib-objs))
> >  
> >  obj-y := timer-sr.o sysreg-sr.o debug-sr.o switch.o tlb.o hyp-init.o host.o \
> >  	 hyp-main.o hyp-smp.o psci-relay.o early_alloc.o stub.o page_alloc.o \
> > -	 cache.o cpufeature.o setup.o mm.o
> > +	 cache.o cpufeature.o setup.o mm.o mem_protect.o
> >  obj-y += ../vgic-v3-sr.o ../aarch32.o ../vgic-v2-cpuif-proxy.o ../entry.o \
> >  	 ../fpsimd.o ../hyp-entry.o ../exception.o ../pgtable.o
> >  obj-y += $(lib-objs)
> > diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-init.S b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
> > index f312672d895e..6fa01b04954f 100644
> > --- a/arch/arm64/kvm/hyp/nvhe/hyp-init.S
> > +++ b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
> > @@ -119,6 +119,7 @@ alternative_else_nop_endif
> >  
> >  	/* Invalidate the stale TLBs from Bootloader */
> >  	tlbi	alle2
> > +	tlbi	vmalls12e1
> >  	dsb	sy
> >  
> >  	/*
> > diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> > index ae6503c9be15..f47028d3fd0a 100644
> > --- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> > +++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> > @@ -13,6 +13,7 @@
> >  #include <asm/kvm_hyp.h>
> >  #include <asm/kvm_mmu.h>
> >  
> > +#include <nvhe/mem_protect.h>
> >  #include <nvhe/mm.h>
> >  #include <nvhe/trap_handler.h>
> >  
> > @@ -151,6 +152,10 @@ static void handle___pkvm_create_private_mapping(struct kvm_cpu_context *host_ct
> >  	cpu_reg(host_ctxt, 1) = __pkvm_create_private_mapping(phys, size, prot);
> >  }
> >  
> > +static void handle___pkvm_prot_finalize(struct kvm_cpu_context *host_ctxt)
> > +{
> > +	cpu_reg(host_ctxt, 1) = __pkvm_prot_finalize();
> > +}
> >  typedef void (*hcall_t)(struct kvm_cpu_context *);
> >  
> >  #define HANDLE_FUNC(x)	[__KVM_HOST_SMCCC_FUNC_##x] = (hcall_t)handle_##x
> > @@ -174,6 +179,7 @@ static const hcall_t host_hcall[] = {
> >  	HANDLE_FUNC(__pkvm_cpu_set_vector),
> >  	HANDLE_FUNC(__pkvm_create_mappings),
> >  	HANDLE_FUNC(__pkvm_create_private_mapping),
> > +	HANDLE_FUNC(__pkvm_prot_finalize),
> >  };
> >  
> >  static void handle_host_hcall(struct kvm_cpu_context *host_ctxt)
> > @@ -226,6 +232,11 @@ void handle_trap(struct kvm_cpu_context *host_ctxt)
> >  	case ESR_ELx_EC_SMC64:
> >  		handle_host_smc(host_ctxt);
> >  		break;
> > +	case ESR_ELx_EC_IABT_LOW:
> > +		fallthrough;
> > +	case ESR_ELx_EC_DABT_LOW:
> > +		handle_host_mem_abort(host_ctxt);
> > +		break;
> >  	default:
> >  		hyp_panic();
> >  	}
> > diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> > new file mode 100644
> > index 000000000000..2252ad1a8945
> > --- /dev/null
> > +++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> > @@ -0,0 +1,213 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (C) 2020 Google LLC
> > + * Author: Quentin Perret <qperret@google.com>
> > + */
> > +
> > +#include <linux/kvm_host.h>
> > +#include <asm/kvm_cpufeature.h>
> > +#include <asm/kvm_emulate.h>
> > +#include <asm/kvm_hyp.h>
> > +#include <asm/kvm_mmu.h>
> > +#include <asm/kvm_pgtable.h>
> > +#include <asm/stage2_pgtable.h>
> > +
> > +#include <hyp/switch.h>
> > +
> > +#include <nvhe/gfp.h>
> > +#include <nvhe/memory.h>
> > +#include <nvhe/mem_protect.h>
> > +#include <nvhe/mm.h>
> > +
> > +extern unsigned long hyp_nr_cpus;
> > +struct host_kvm host_kvm;
> > +
> > +struct hyp_pool host_s2_mem;
> > +struct hyp_pool host_s2_dev;
> > +
> > +static void *host_s2_zalloc_pages_exact(size_t size)
> > +{
> > +	return hyp_alloc_pages(&host_s2_mem, get_order(size));
> > +}
> > +
> > +static void *host_s2_zalloc_page(void *pool)
> > +{
> > +	return hyp_alloc_pages(pool, 0);
> > +}
> > +
> > +static int prepare_s2_pools(void *mem_pgt_pool, void *dev_pgt_pool)
> > +{
> > +	unsigned long nr_pages, pfn;
> > +	int ret;
> > +
> > +	pfn = hyp_virt_to_pfn(mem_pgt_pool);
> > +	nr_pages = host_s2_mem_pgtable_pages();
> > +	ret = hyp_pool_init(&host_s2_mem, pfn, nr_pages, 0);
> > +	if (ret)
> > +		return ret;
> > +
> > +	pfn = hyp_virt_to_pfn(dev_pgt_pool);
> > +	nr_pages = host_s2_dev_pgtable_pages();
> > +	ret = hyp_pool_init(&host_s2_dev, pfn, nr_pages, 0);
> > +	if (ret)
> > +		return ret;
> > +
> > +	host_kvm.mm_ops.zalloc_pages_exact = host_s2_zalloc_pages_exact;
> > +	host_kvm.mm_ops.zalloc_page = host_s2_zalloc_page;
> > +	host_kvm.mm_ops.phys_to_virt = hyp_phys_to_virt;
> > +	host_kvm.mm_ops.virt_to_phys = hyp_virt_to_phys;
> > +	host_kvm.mm_ops.page_count = hyp_page_count;
> > +	host_kvm.mm_ops.get_page = hyp_get_page;
> > +	host_kvm.mm_ops.put_page = hyp_put_page;
> 
> Same comment I had earlier on about struct initialisation -- I think you
> can use the same trict here for the host_kvm.mm_ops.

+1

> > +
> > +	return 0;
> > +}
> > +
> > +static void prepare_host_vtcr(void)
> > +{
> > +	u32 parange, phys_shift;
> > +	u64 mmfr0, mmfr1;
> > +
> > +	mmfr0 = arm64_ftr_reg_id_aa64mmfr0_el1.sys_val;
> > +	mmfr1 = arm64_ftr_reg_id_aa64mmfr1_el1.sys_val;
> > +
> > +	/* The host stage 2 is id-mapped, so use parange for T0SZ */
> > +	parange = kvm_get_parange(mmfr0);
> > +	phys_shift = id_aa64mmfr0_parange_to_phys_shift(parange);
> > +
> > +	host_kvm.arch.vtcr = kvm_get_vtcr(mmfr0, mmfr1, phys_shift);
> > +}
> > +
> > +int kvm_host_prepare_stage2(void *mem_pgt_pool, void *dev_pgt_pool)
> > +{
> > +	struct kvm_s2_mmu *mmu = &host_kvm.arch.mmu;
> > +	int ret;
> > +
> > +	prepare_host_vtcr();
> > +	hyp_spin_lock_init(&host_kvm.lock);
> > +
> > +	ret = prepare_s2_pools(mem_pgt_pool, dev_pgt_pool);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = kvm_pgtable_stage2_init(&host_kvm.pgt, &host_kvm.arch,
> > +				      &host_kvm.mm_ops);
> > +	if (ret)
> > +		return ret;
> > +
> > +	mmu->pgd_phys = __hyp_pa(host_kvm.pgt.pgd);
> > +	mmu->arch = &host_kvm.arch;
> > +	mmu->pgt = &host_kvm.pgt;
> > +	mmu->vmid.vmid_gen = 0;
> > +	mmu->vmid.vmid = 0;
> > +
> > +	return 0;
> > +}
> > +
> > +int __pkvm_prot_finalize(void)
> > +{
> > +	struct kvm_s2_mmu *mmu = &host_kvm.arch.mmu;
> > +	struct kvm_nvhe_init_params *params = this_cpu_ptr(&kvm_init_params);
> > +
> > +	params->vttbr = kvm_get_vttbr(mmu);
> > +	params->vtcr = host_kvm.arch.vtcr;
> > +	params->hcr_el2 |= HCR_VM;
> > +	if (cpus_have_const_cap(ARM64_HAS_STAGE2_FWB))
> > +		params->hcr_el2 |= HCR_FWB;
> > +	kvm_flush_dcache_to_poc(params, sizeof(*params));
> > +
> > +	write_sysreg(params->hcr_el2, hcr_el2);
> > +	__load_stage2(&host_kvm.arch.mmu, host_kvm.arch.vtcr);
> 
> AFAICT, there's no ISB here. Do we need one before the TLB invalidation?

You mean for the ARM64_WORKAROUND_SPECULATIVE_AT case? __load_stage2()
should already add one for me no?

> > +	__tlbi(vmalls12e1is);
> > +	dsb(ish);
> 
> Given that the TLB is invalidated on the boot path, please can you add
> a comment here about the stale entries which you need to invalidate?

Sure -- that is for HCR bits cached in TLBs for VMID 0. Thinking about
it I could probably reduce the tlbi scope as well.

> Also, does this need to be inner-shareable? I thought this function ran on
> each CPU.

Hmm, correct, nsh should do.

> > +	isb();
> > +
> > +	return 0;
> > +}
> > +
> > +static void host_stage2_unmap_dev_all(void)
> > +{
> > +	struct kvm_pgtable *pgt = &host_kvm.pgt;
> > +	struct memblock_region *reg;
> > +	u64 addr = 0;
> > +	int i;
> > +
> > +	/* Unmap all non-memory regions to recycle the pages */
> > +	for (i = 0; i < hyp_memblock_nr; i++, addr = reg->base + reg->size) {
> > +		reg = &hyp_memory[i];
> > +		kvm_pgtable_stage2_unmap(pgt, addr, reg->base - addr);
> > +	}
> > +	kvm_pgtable_stage2_unmap(pgt, addr, ULONG_MAX);
> 
> Is this just going to return -ERANGE?

Hrmpf, yes, that wants BIT(pgt->ia_bits) I think. And that wants testing
as well, clearly.

> > +static int host_stage2_idmap(u64 addr)
> > +{
> > +	enum kvm_pgtable_prot prot = KVM_PGTABLE_PROT_R | KVM_PGTABLE_PROT_W;
> > +	struct kvm_mem_range range;
> > +	bool is_memory = find_mem_range(addr, &range);
> > +	struct hyp_pool *pool = is_memory ? &host_s2_mem : &host_s2_dev;
> > +	int ret;
> > +
> > +	if (is_memory)
> > +		prot |= KVM_PGTABLE_PROT_X;
> > +
> > +	hyp_spin_lock(&host_kvm.lock);
> > +	ret = kvm_pgtable_stage2_idmap_greedy(&host_kvm.pgt, addr, prot,
> > +					      &range, pool);
> > +	if (is_memory || ret != -ENOMEM)
> > +		goto unlock;
> > +	host_stage2_unmap_dev_all();
> > +	ret = kvm_pgtable_stage2_idmap_greedy(&host_kvm.pgt, addr, prot,
> > +					      &range, pool);
> 
> I find this _really_ hard to reason about, as range is passed by reference
> and we don't reset it after the first call returns -ENOMEM for an MMIO
> mapping. Maybe some commentary on why it's still valid here?

Sure, I'll add something. FWIW, that is intended -- -ENOMEM can only be
caused by the call to kvm_pgtable_stage2_map() which leaves the range
untouched. So, as long as we don't release the lock, the range returned
by the first call to kvm_pgtable_stage2_idmap_greedy() should still be
valid. I suppose I could call kvm_pgtable_stage2_map() directly the
second time to make it obvious but I thought this would expose the
internal of kvm_pgtable_stage2_idmap_greedy() a little bit too much.

Thanks,
Quentin
