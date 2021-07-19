Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E99B3CE783
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 19:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236479AbhGSQ1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 12:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346933AbhGSPPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 11:15:21 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F50BC0A0972
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 08:08:41 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id t5so22540166wrw.12
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 08:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=a8uhGfhYBGrAP6AY15zACqkPpBrWI3VTTrOv2cmS9bw=;
        b=qxMQf4yWBnuP80eYB6S3dY73YmBdMFQ6cTY0aKI+ESW/1e75kN5RgILQekP6dbejzr
         741GO5CljZCSiKTf9Kh6uZ1B/NJZrg2Qr6OfGRpAz3uy7Iowrer5DzxpVQ32f1AJ5kLN
         CNsbqd6BQRbHZkVE2U9teouQOLg8OB1DxH2ufo6eu2Zch85kPdAvnqGS/cROpnVK2Lo4
         TFdQR3iAKbJ5FYpo/MGRSTcpWIArfkPVRuKFZNyJfJHcJVHxI1F+k1Rz1OcE4Cvm+kA4
         1goLSFOLZEB3UK1LkuCv5Bn/zB8OhChb4kd9QIGKIRF6rrMYRNz8ligQtliob2Ywyr+B
         tSKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a8uhGfhYBGrAP6AY15zACqkPpBrWI3VTTrOv2cmS9bw=;
        b=XONkkGQI8KgbUHov1ZCe4hQaPxn57Emqt9PozBnpXRKQznAgt5+xcv+JTAaU95uxZ6
         TQs+xAkbE/ytlKKmMnpXdQPfFK+vFW3nDafKJMOktRIUSdQggxZl+TCwz2VNBh8dLOWM
         0luD6KpZY95lr8VcqSNcYtOz38wtwgzO0S1s8kFZCrR+wrfzmQSEfVym04NoO+hgxkUf
         O7ay6Lx74peidSYg7U7o8eP5rZln7MoxgIEA7QJY4jORMHLT3Vrg4aM4S5xZc3BmJh6Y
         18XZABTWol6xs+Uf4Ey9yx8s10CP5MB5gMZ6t8zd2PSM52a+CxUrvDOhvNYhUjwD2PHk
         1miw==
X-Gm-Message-State: AOAM533djWxJPAMR3g5wfNVhZkvgNXmJVoAf0Hw4kqKxPCOD9z629jLt
        ajZkQ1y1Cu+SPVjYhw1xYzZIjg==
X-Google-Smtp-Source: ABdhPJwmzLRmeFXWY1SQ3ExwNVY8oG85HU6VZkNJR2vqcARs3/QewnlyUu4doTp7hMI2o9UKvGRc+w==
X-Received: by 2002:adf:f50e:: with SMTP id q14mr30343704wro.183.1626709000521;
        Mon, 19 Jul 2021 08:36:40 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:83e0:11ac:c870:2b97])
        by smtp.gmail.com with ESMTPSA id e3sm20839691wra.15.2021.07.19.08.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 08:36:40 -0700 (PDT)
Date:   Mon, 19 Jul 2021 16:36:36 +0100
From:   Quentin Perret <qperret@google.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, ardb@kernel.org, qwandor@google.com,
        tabba@google.com, dbrazdil@google.com, kernel-team@android.com
Subject: Re: [PATCH 07/14] KVM: arm64: Enable forcing page-level stage-2
 mappings
Message-ID: <YPWcBGdgaLRFtJf8@google.com>
References: <20210719104735.3681732-1-qperret@google.com>
 <20210719104735.3681732-8-qperret@google.com>
 <87h7gqjs9r.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h7gqjs9r.wl-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 19 Jul 2021 at 15:24:32 (+0100), Marc Zyngier wrote:
> On Mon, 19 Jul 2021 11:47:28 +0100,
> Quentin Perret <qperret@google.com> wrote:
> > 
> > Much of the stage-2 manipulation logic relies on being able to destroy
> > block mappings if e.g. installing a smaller mapping in the range. The
> > rationale for this behaviour is that stage-2 mappings can always be
> > re-created lazily. However, this gets more complicated when the stage-2
> > page-table is used to store metadata about the underlying pages. In such
> > a case, destroying a block mapping may lead to losing part of the
> > state, and confuse the user of those metadata (such as the hypervisor in
> > nVHE protected mode).
> > 
> > To fix this, introduce a callback function in the pgtable struct which
> > is called during all map operations to determine whether the mappings
> > can us blocks, or should be forced to page-granularity level. This is
> 
> nit: use?

Ack.

> > used by the hypervisor when creating the host stage-2 to force
> > page-level mappings when using non-default protection attributes.
> > 
> > Signed-off-by: Quentin Perret <qperret@google.com>
> > ---
> >  arch/arm64/include/asm/kvm_pgtable.h  | 63 +++++++++++++++++----------
> >  arch/arm64/kvm/hyp/nvhe/mem_protect.c | 16 +++++--
> >  arch/arm64/kvm/hyp/pgtable.c          | 20 +++++++--
> >  3 files changed, 69 insertions(+), 30 deletions(-)
> > 
> > diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
> > index af62203d2f7a..dd72653314c7 100644
> > --- a/arch/arm64/include/asm/kvm_pgtable.h
> > +++ b/arch/arm64/include/asm/kvm_pgtable.h
> > @@ -75,25 +75,6 @@ enum kvm_pgtable_stage2_flags {
> >  	KVM_PGTABLE_S2_IDMAP			= BIT(1),
> >  };
> >  
> > -/**
> > - * struct kvm_pgtable - KVM page-table.
> > - * @ia_bits:		Maximum input address size, in bits.
> > - * @start_level:	Level at which the page-table walk starts.
> > - * @pgd:		Pointer to the first top-level entry of the page-table.
> > - * @mm_ops:		Memory management callbacks.
> > - * @mmu:		Stage-2 KVM MMU struct. Unused for stage-1 page-tables.
> > - */
> > -struct kvm_pgtable {
> > -	u32					ia_bits;
> > -	u32					start_level;
> > -	kvm_pte_t				*pgd;
> > -	struct kvm_pgtable_mm_ops		*mm_ops;
> > -
> > -	/* Stage-2 only */
> > -	struct kvm_s2_mmu			*mmu;
> > -	enum kvm_pgtable_stage2_flags		flags;
> > -};
> > -
> >  /**
> >   * enum kvm_pgtable_prot - Page-table permissions and attributes.
> >   * @KVM_PGTABLE_PROT_X:		Execute permission.
> > @@ -109,11 +90,41 @@ enum kvm_pgtable_prot {
> >  	KVM_PGTABLE_PROT_DEVICE			= BIT(3),
> >  };
> >  
> > -#define PAGE_HYP		(KVM_PGTABLE_PROT_R | KVM_PGTABLE_PROT_W)
> > +#define KVM_PGTABLE_PROT_RW	(KVM_PGTABLE_PROT_R | KVM_PGTABLE_PROT_W)
> > +#define KVM_PGTABLE_PROT_RWX	(KVM_PGTABLE_PROT_RW | KVM_PGTABLE_PROT_X)
> > +
> > +#define PAGE_HYP		KVM_PGTABLE_PROT_RW
> >  #define PAGE_HYP_EXEC		(KVM_PGTABLE_PROT_R | KVM_PGTABLE_PROT_X)
> >  #define PAGE_HYP_RO		(KVM_PGTABLE_PROT_R)
> >  #define PAGE_HYP_DEVICE		(PAGE_HYP | KVM_PGTABLE_PROT_DEVICE)
> >  
> > +typedef bool (*kvm_pgtable_want_pte_cb_t)(u64 addr, u64 end,
> > +					  enum kvm_pgtable_prot prot);
> > +
> > +/**
> > + * struct kvm_pgtable - KVM page-table.
> > + * @ia_bits:		Maximum input address size, in bits.
> > + * @start_level:	Level at which the page-table walk starts.
> > + * @pgd:		Pointer to the first top-level entry of the page-table.
> > + * @mm_ops:		Memory management callbacks.
> > + * @mmu:		Stage-2 KVM MMU struct. Unused for stage-1 page-tables.
> > + * @flags:		Stage-2 page-table flags.
> > + * @want_pte_cb:	Callback function used during map operations to decide
> > + *			whether block mappings can be used to map the given IPA
> > + *			range.
> > + */
> > +struct kvm_pgtable {
> > +	u32					ia_bits;
> > +	u32					start_level;
> > +	kvm_pte_t				*pgd;
> > +	struct kvm_pgtable_mm_ops		*mm_ops;
> > +
> > +	/* Stage-2 only */
> > +	struct kvm_s2_mmu			*mmu;
> > +	enum kvm_pgtable_stage2_flags		flags;
> > +	kvm_pgtable_want_pte_cb_t		want_pte_cb;
> > +};
> 
> nit: does this whole definition really need to move around?

The alternative is to move (or forward declare) enum kvm_pgtable_prot
higher up in the file, but I have no strong opinion, so whatever you
prefer will work for me.

> > +
> >  /**
> >   * struct kvm_mem_range - Range of Intermediate Physical Addresses
> >   * @start:	Start of the range.
> > @@ -216,21 +227,25 @@ int kvm_pgtable_hyp_map(struct kvm_pgtable *pgt, u64 addr, u64 size, u64 phys,
> >  u64 kvm_get_vtcr(u64 mmfr0, u64 mmfr1, u32 phys_shift);
> >  
> >  /**
> > - * kvm_pgtable_stage2_init_flags() - Initialise a guest stage-2 page-table.
> > + * kvm_pgtable_stage2_init_full() - Initialise a guest stage-2 page-table.
> >   * @pgt:	Uninitialised page-table structure to initialise.
> >   * @arch:	Arch-specific KVM structure representing the guest virtual
> >   *		machine.
> >   * @mm_ops:	Memory management callbacks.
> >   * @flags:	Stage-2 configuration flags.
> > + * @want_pte_cb: Callback function used during map operations to decide
> > + *		whether block mappings can be used to map the given IPA
> > + *		range.
> >   *
> >   * Return: 0 on success, negative error code on failure.
> >   */
> > -int kvm_pgtable_stage2_init_flags(struct kvm_pgtable *pgt, struct kvm_arch *arch,
> > +int kvm_pgtable_stage2_init_full(struct kvm_pgtable *pgt, struct kvm_arch *arch,
> >  				  struct kvm_pgtable_mm_ops *mm_ops,
> > -				  enum kvm_pgtable_stage2_flags flags);
> > +				  enum kvm_pgtable_stage2_flags flags,
> > +				  kvm_pgtable_want_pte_cb_t want_pte_cb);
> >  
> >  #define kvm_pgtable_stage2_init(pgt, arch, mm_ops) \
> > -	kvm_pgtable_stage2_init_flags(pgt, arch, mm_ops, 0)
> > +	kvm_pgtable_stage2_init_full(pgt, arch, mm_ops, 0, NULL)
> 
> nit: in general, we use __foo() as the primitive for foo(), rather
> than foo_with_icing_on_top().

Sure.

> >  
> >  /**
> >   * kvm_pgtable_stage2_destroy() - Destroy an unused guest stage-2 page-table.
> > diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> > index 58edc62be6f7..cdace80d3e28 100644
> > --- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> > +++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> > @@ -89,6 +89,7 @@ static void prepare_host_vtcr(void)
> >  					  id_aa64mmfr1_el1_sys_val, phys_shift);
> >  }
> >  
> > +static bool host_stage2_want_pte_cb(u64 addr, u64 end, enum kvm_pgtable_prot prot);
> >  int kvm_host_prepare_stage2(void *pgt_pool_base)
> >  {
> >  	struct kvm_s2_mmu *mmu = &host_kvm.arch.mmu;
> > @@ -101,8 +102,9 @@ int kvm_host_prepare_stage2(void *pgt_pool_base)
> >  	if (ret)
> >  		return ret;
> >  
> > -	ret = kvm_pgtable_stage2_init_flags(&host_kvm.pgt, &host_kvm.arch,
> > -					    &host_kvm.mm_ops, KVM_HOST_S2_FLAGS);
> > +	ret = kvm_pgtable_stage2_init_full(&host_kvm.pgt, &host_kvm.arch,
> > +					   &host_kvm.mm_ops, KVM_HOST_S2_FLAGS,
> > +					   host_stage2_want_pte_cb);
> >  	if (ret)
> >  		return ret;
> >  
> > @@ -225,9 +227,17 @@ static inline int __host_stage2_idmap(u64 start, u64 end,
> >  		__ret;							\
> >  	 })
> >  
> > +static bool host_stage2_want_pte_cb(u64 addr, u64 end, enum kvm_pgtable_prot prot)
> > +{
> > +	if (range_is_memory(addr, end))
> > +		return prot != KVM_PGTABLE_PROT_RWX;
> > +	else
> > +		return prot != KVM_PGTABLE_PROT_RW;
> > +}
> 
> This really deserves a comment about *why* you make such decision.
> also find it a bit odd that you use the permissions to decide whether
> to map a block or a not. It feels like the permission is more of a
> side effect than anything else.

The idea is to use page-level mappings for anything that we can't
rebuild lazily in the host stage-2. So the logic in this function
matches exactly what we do in host_stage2_idmap() just below.

And the protection does matter sadly. If for instance we map a large
portion of the host RO, and we use a block mapping for that, then any
subsequent map() call in the block range is likely to have very
undesirable side effects -- we'll forget that the rest of the block
range should be RO and we risk mapping it RW(X) in the mem abort path.

But yes, a comment is very much needed, I'll add something.

> >  static int host_stage2_idmap(u64 addr)
> >  {
> > -	enum kvm_pgtable_prot prot = KVM_PGTABLE_PROT_R | KVM_PGTABLE_PROT_W;
> > +	enum kvm_pgtable_prot prot = KVM_PGTABLE_PROT_RW;
> >  	struct kvm_mem_range range;
> >  	bool is_memory = find_mem_range(addr, &range);
> >  	int ret;
> > diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
> > index 34cf67997a82..5bdbe7a31551 100644
> > --- a/arch/arm64/kvm/hyp/pgtable.c
> > +++ b/arch/arm64/kvm/hyp/pgtable.c
> > @@ -452,6 +452,8 @@ int kvm_pgtable_hyp_init(struct kvm_pgtable *pgt, u32 va_bits,
> >  	pgt->start_level	= KVM_PGTABLE_MAX_LEVELS - levels;
> >  	pgt->mm_ops		= mm_ops;
> >  	pgt->mmu		= NULL;
> > +	pgt->want_pte_cb	= NULL;
> > +
> >  	return 0;
> >  }
> >  
> > @@ -491,6 +493,7 @@ struct stage2_map_data {
> >  	struct kvm_pgtable_mm_ops	*mm_ops;
> >  
> >  	int				ret;
> > +	bool				force_pte;
> 
> OK, so you have *two* mechanisms here: once to decide if a range can
> be mapped as a block or not, and another one to remember the result
> while walking the S2 PTW. This probably deserves some documentation
> and/or patch splitting.

Sure, I'll add a comment.

> >  };
> >  
> >  u64 kvm_get_vtcr(u64 mmfr0, u64 mmfr1, u32 phys_shift)
> > @@ -613,6 +616,9 @@ static int stage2_map_walker_try_leaf(u64 addr, u64 end, u32 level,
> >  	struct kvm_pgtable *pgt = data->mmu->pgt;
> >  	struct kvm_pgtable_mm_ops *mm_ops = data->mm_ops;
> >  
> > +	if (data->force_pte && (level < (KVM_PGTABLE_MAX_LEVELS - 1)))
> > +		return -E2BIG;
> > +
> >  	if (!kvm_block_mapping_supported(addr, end, phys, level))
> >  		return -E2BIG;
> >  
> > @@ -660,6 +666,9 @@ static int stage2_map_walk_table_pre(u64 addr, u64 end, u32 level,
> >  	if (data->anchor)
> >  		return 0;
> >  
> > +	if (data->force_pte && (level < (KVM_PGTABLE_MAX_LEVELS - 1)))
> > +		return 0;
> > +
> >  	if (!kvm_block_mapping_supported(addr, end, data->phys, level))
> 
> There is something in me screaming that kvm_block_mapping_supported()
> should be the point where we check for these things...  Or at least a
> helper function that takes 'data' as a parameter.

I feel like kvm_block_mapping_supported() might be better as-is as a
purely architectural check that we can also use it for e.g. hyp stage-1
stuff, but a new helper function should do.

> 
> >  		return 0;
> >  
> > @@ -791,6 +800,7 @@ int kvm_pgtable_stage2_map(struct kvm_pgtable *pgt, u64 addr, u64 size,
> >  		.memcache	= mc,
> >  		.mm_ops		= pgt->mm_ops,
> >  		.ret		= 0,
> > +		.force_pte	= pgt->want_pte_cb && pgt->want_pte_cb(addr, addr + size, prot),
> 
> Reading this makes me want to rename want_pte_cb() to force_pte_cb()...

No objection from me, I'll rename.

> >  	};
> >  	struct kvm_pgtable_walker walker = {
> >  		.cb		= stage2_map_walker,
> > @@ -826,6 +836,7 @@ int kvm_pgtable_stage2_set_owner(struct kvm_pgtable *pgt, u64 addr, u64 size,
> >  		.mm_ops		= pgt->mm_ops,
> >  		.owner_id	= owner_id,
> >  		.ret		= 0,
> > +		.force_pte	= true,
> >  	};
> >  	struct kvm_pgtable_walker walker = {
> >  		.cb		= stage2_map_walker,
> > @@ -1070,9 +1081,11 @@ int kvm_pgtable_stage2_flush(struct kvm_pgtable *pgt, u64 addr, u64 size)
> >  	return kvm_pgtable_walk(pgt, addr, size, &walker);
> >  }
> >  
> > -int kvm_pgtable_stage2_init_flags(struct kvm_pgtable *pgt, struct kvm_arch *arch,
> > -				  struct kvm_pgtable_mm_ops *mm_ops,
> > -				  enum kvm_pgtable_stage2_flags flags)
> > +
> > +int kvm_pgtable_stage2_init_full(struct kvm_pgtable *pgt, struct kvm_arch *arch,
> > +				 struct kvm_pgtable_mm_ops *mm_ops,
> > +				 enum kvm_pgtable_stage2_flags flags,
> > +				 kvm_pgtable_want_pte_cb_t want_pte_cb)
> >  {
> >  	size_t pgd_sz;
> >  	u64 vtcr = arch->vtcr;
> > @@ -1090,6 +1103,7 @@ int kvm_pgtable_stage2_init_flags(struct kvm_pgtable *pgt, struct kvm_arch *arch
> >  	pgt->mm_ops		= mm_ops;
> >  	pgt->mmu		= &arch->mmu;
> >  	pgt->flags		= flags;
> > +	pgt->want_pte_cb	= want_pte_cb;
> >  
> >  	/* Ensure zeroed PGD pages are visible to the hardware walker */
> >  	dsb(ishst);

Cheers,
Quentin
