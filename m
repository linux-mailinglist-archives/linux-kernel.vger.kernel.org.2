Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CAA63DEA96
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 12:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235335AbhHCKNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 06:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235105AbhHCKN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 06:13:29 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA12C061764
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 03:13:17 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id l18so24686622wrv.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 03:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CxNOSLpZk+NCcseZZ5AqilU49Vowfd0AhTy9V0q5eIk=;
        b=nPkvKW0N9eVSvE0O8QBY9UMOQpIGUOOK6pHGSIVygcRf1c47Tt05nrcZKnukQVVMLu
         Up5w6VYZLawmnB/ozXBzkjR3IXERH2Wf4YmBYvO81Vc6lJ2LwNJRUBVpC4wFq6Q+h71L
         twUmAbVQ0qLsIYmWuVhj3HCsRV+hmb3u9l6kmxxVqd2d8GPRzNwVbA3aB0Y7LzoaNHK0
         lBBuzO5xoh7ST/f6ZB9cowWMCd4BqVoMm281iV890/c+8lVvfisw8tzwmeG7TBaljV3k
         JB0BvwXds7LRWEIoSbLj0wAovrq9r0rZUjmqW2/1kGNztUPCxudpCDZp/8mXQy/0ypKy
         RX0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CxNOSLpZk+NCcseZZ5AqilU49Vowfd0AhTy9V0q5eIk=;
        b=AwrZKeDxBNEDgDKPddUd7qz4QAQkMY3o5VVjJ1BUi4igY3BhiT3Tha1R7w+nQfWxCv
         zHHOiahmfhxhEshZMdl2H2TCA3jYTMAF0Z+AbLeIIpQf0ELtvbFvTPW1yw8vqt9Ugyq5
         52jeQg6KnNP/DNJ9FhMSCGWhUs70eEP6V3NpMUSrKqTfub0EylAVQ2KGt/c0J9bZeAWi
         EIsod/v7F47ttYBGQwQsWybkTbO0FTdEuHABwqdd8W0tGoj2J9GPgfr9ZfA+SKzlsWG5
         Q7IXt7VgEdE9yjXbTQuggbJ4iHyfQHQrLrA0TDbj4FEfNg+or+RLJjylsMo+xwipImeY
         zW0w==
X-Gm-Message-State: AOAM5303ATyzfuONoOsx3/me2lnKTbY333biqNVbkfVZvHKny2AyeSH/
        Bt2+D6t2JY8jyJwTh49lnkE38Q==
X-Google-Smtp-Source: ABdhPJwcDRZ6JZH6JRv3kOahr9q4++dAatLHvdXSoP4tTVczT1q0ZDj+UbTs9MaxkRfDP3D1VAqq6w==
X-Received: by 2002:adf:fe89:: with SMTP id l9mr23210216wrr.396.1627985595358;
        Tue, 03 Aug 2021 03:13:15 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:754:7d1b:7303:129a])
        by smtp.gmail.com with ESMTPSA id w4sm2177001wrm.24.2021.08.03.03.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 03:13:15 -0700 (PDT)
Date:   Tue, 3 Aug 2021 11:13:12 +0100
From:   Quentin Perret <qperret@google.com>
To:     Fuad Tabba <tabba@google.com>
Cc:     maz@kernel.org, james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, ardb@kernel.org, qwandor@google.com,
        dbrazdil@google.com, kernel-team@android.com
Subject: Re: [PATCH v3 10/21] KVM: arm64: Enable forcing page-level stage-2
 mappings
Message-ID: <YQkWuCVkKWJX81en@google.com>
References: <20210729132818.4091769-1-qperret@google.com>
 <20210729132818.4091769-11-qperret@google.com>
 <CA+EHjTxCvqQ=jmBPJ1N6ShBf=f4J5cjT4pt9akfnqNjQUoqzWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+EHjTxCvqQ=jmBPJ1N6ShBf=f4J5cjT4pt9akfnqNjQUoqzWw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fuad,

On Monday 02 Aug 2021 at 11:49:28 (+0200), Fuad Tabba wrote:
> On Thu, Jul 29, 2021 at 3:28 PM Quentin Perret <qperret@google.com> wrote:
> >
> > Much of the stage-2 manipulation logic relies on being able to destroy
> > block mappings if e.g. installing a smaller mapping in the range. The
> > rationale for this behaviour is that stage-2 mappings can always be
> > re-created lazily. However, this gets more complicated when the stage-2
> > page-table is used to store metadata about the underlying pages. In such
> > cases, destroying a block mapping may lead to losing part of the state,
> > and confuse the user of those metadata (such as the hypervisor in nVHE
> > protected mode).
> >
> > To avoid this, introduce a callback function in the pgtable struct which
> > is called during all map operations to determine whether the mappings
> > can use blocks, or should be forced to page granularity. This is used by
> > the hypervisor when creating the host stage-2 to force page-level
> > mappings when using non-default protection attributes.
> >
> > Signed-off-by: Quentin Perret <qperret@google.com>
> > ---
> >  arch/arm64/include/asm/kvm_pgtable.h  | 65 ++++++++++++++++-----------
> >  arch/arm64/kvm/hyp/nvhe/mem_protect.c | 30 +++++++++++--
> >  arch/arm64/kvm/hyp/pgtable.c          | 29 +++++++++---
> >  3 files changed, 91 insertions(+), 33 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
> > index 83c5c97d9eac..ba7dcade2798 100644
> > --- a/arch/arm64/include/asm/kvm_pgtable.h
> > +++ b/arch/arm64/include/asm/kvm_pgtable.h
> > @@ -115,25 +115,6 @@ enum kvm_pgtable_stage2_flags {
> >         KVM_PGTABLE_S2_IDMAP                    = BIT(1),
> >  };
> >
> > -/**
> > - * struct kvm_pgtable - KVM page-table.
> > - * @ia_bits:           Maximum input address size, in bits.
> > - * @start_level:       Level at which the page-table walk starts.
> > - * @pgd:               Pointer to the first top-level entry of the page-table.
> > - * @mm_ops:            Memory management callbacks.
> > - * @mmu:               Stage-2 KVM MMU struct. Unused for stage-1 page-tables.
> > - */
> > -struct kvm_pgtable {
> > -       u32                                     ia_bits;
> > -       u32                                     start_level;
> > -       kvm_pte_t                               *pgd;
> > -       struct kvm_pgtable_mm_ops               *mm_ops;
> > -
> > -       /* Stage-2 only */
> > -       struct kvm_s2_mmu                       *mmu;
> > -       enum kvm_pgtable_stage2_flags           flags;
> > -};
> > -
> >  /**
> >   * enum kvm_pgtable_prot - Page-table permissions and attributes.
> >   * @KVM_PGTABLE_PROT_X:                Execute permission.
> > @@ -149,11 +130,41 @@ enum kvm_pgtable_prot {
> >         KVM_PGTABLE_PROT_DEVICE                 = BIT(3),
> >  };
> >
> > -#define PAGE_HYP               (KVM_PGTABLE_PROT_R | KVM_PGTABLE_PROT_W)
> > +#define KVM_PGTABLE_PROT_RW    (KVM_PGTABLE_PROT_R | KVM_PGTABLE_PROT_W)
> > +#define KVM_PGTABLE_PROT_RWX   (KVM_PGTABLE_PROT_RW | KVM_PGTABLE_PROT_X)
> > +
> > +#define PAGE_HYP               KVM_PGTABLE_PROT_RW
> >  #define PAGE_HYP_EXEC          (KVM_PGTABLE_PROT_R | KVM_PGTABLE_PROT_X)
> >  #define PAGE_HYP_RO            (KVM_PGTABLE_PROT_R)
> >  #define PAGE_HYP_DEVICE                (PAGE_HYP | KVM_PGTABLE_PROT_DEVICE)
> 
> I wonder if it would be useful to add a couple of other aliases for
> default memory and default mmio protections, e.g.,
> 
> #define  KVM_PGTABLE_PROT_MEM KVM_PGTABLE_PROT_RWX
> #define  KVM_PGTABLE_PROT_MMIO KVM_PGTABLE_PROT_RW
> 
> I think that using these below, e.g., host_stage2_force_pte_cb(),
> might make it clearer and answer comments you had in earlier patches
> about why "RWX" for memory.

Sure I can add something. I'll probably call them something else than
KVM_PGTABLE_PROT_{MEM,MMIO} though, just to make it clear this is all
specific to the host stage-2 stuff and not a general requirement of the
pgtable code to map things like this.

> >
> > +typedef bool (*kvm_pgtable_force_pte_cb_t)(u64 addr, u64 end,
> > +                                          enum kvm_pgtable_prot prot);
> > +
> > +/**
> > + * struct kvm_pgtable - KVM page-table.
> > + * @ia_bits:           Maximum input address size, in bits.
> > + * @start_level:       Level at which the page-table walk starts.
> > + * @pgd:               Pointer to the first top-level entry of the page-table.
> > + * @mm_ops:            Memory management callbacks.
> > + * @mmu:               Stage-2 KVM MMU struct. Unused for stage-1 page-tables.
> > + * @flags:             Stage-2 page-table flags.
> > + * @force_pte_cb:      Callback function used during map operations to decide
> > + *                     whether block mappings can be used to map the given IPA
> > + *                     range.
> > + */
> 
> nit: I think it might be clearer (and probably not longer) to rephrase
> to describe in terms of the return value of the callback, e.g., "...
> function that returns true if page level mappings must be used instead
> of block mappings."

Works for me, thanks for the suggestion.

> > +struct kvm_pgtable {
> > +       u32                                     ia_bits;
> > +       u32                                     start_level;
> > +       kvm_pte_t                               *pgd;
> > +       struct kvm_pgtable_mm_ops               *mm_ops;
> > +
> > +       /* Stage-2 only */
> > +       struct kvm_s2_mmu                       *mmu;
> > +       enum kvm_pgtable_stage2_flags           flags;
> > +       kvm_pgtable_force_pte_cb_t              force_pte_cb;
> > +};
> > +
> >  /**
> >   * enum kvm_pgtable_walk_flags - Flags to control a depth-first page-table walk.
> >   * @KVM_PGTABLE_WALK_LEAF:             Visit leaf entries, including invalid
> > @@ -246,21 +257,25 @@ int kvm_pgtable_hyp_map(struct kvm_pgtable *pgt, u64 addr, u64 size, u64 phys,
> >  u64 kvm_get_vtcr(u64 mmfr0, u64 mmfr1, u32 phys_shift);
> >
> >  /**
> > - * kvm_pgtable_stage2_init_flags() - Initialise a guest stage-2 page-table.
> > + * __kvm_pgtable_stage2_init() - Initialise a guest stage-2 page-table.
> >   * @pgt:       Uninitialised page-table structure to initialise.
> >   * @arch:      Arch-specific KVM structure representing the guest virtual
> >   *             machine.
> >   * @mm_ops:    Memory management callbacks.
> >   * @flags:     Stage-2 configuration flags.
> > + * @force_pte_cb: Callback function used during map operations to decide
> > + *             whether block mappings can be used to map the given IPA
> > + *             range.
> 
> nit: same nit as above with describing the callback in terms of its return value
> 
> >   *
> >   * Return: 0 on success, negative error code on failure.
> >   */
> > -int kvm_pgtable_stage2_init_flags(struct kvm_pgtable *pgt, struct kvm_arch *arch,
> > -                                 struct kvm_pgtable_mm_ops *mm_ops,
> > -                                 enum kvm_pgtable_stage2_flags flags);
> > +int __kvm_pgtable_stage2_init(struct kvm_pgtable *pgt, struct kvm_arch *arch,
> > +                             struct kvm_pgtable_mm_ops *mm_ops,
> > +                             enum kvm_pgtable_stage2_flags flags,
> > +                             kvm_pgtable_force_pte_cb_t force_pte_cb);
> >
> >  #define kvm_pgtable_stage2_init(pgt, arch, mm_ops) \
> > -       kvm_pgtable_stage2_init_flags(pgt, arch, mm_ops, 0)
> > +       __kvm_pgtable_stage2_init(pgt, arch, mm_ops, 0, NULL)
> >
> >  /**
> >   * kvm_pgtable_stage2_destroy() - Destroy an unused guest stage-2 page-table.
> > diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> > index 2148d3968aa5..70c57d2c3024 100644
> > --- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> > +++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> > @@ -89,6 +89,7 @@ static void prepare_host_vtcr(void)
> >                                           id_aa64mmfr1_el1_sys_val, phys_shift);
> >  }
> >
> > +static bool host_stage2_force_pte_cb(u64 addr, u64 end, enum kvm_pgtable_prot prot);
> 
> nit: newline
> 
> >  int kvm_host_prepare_stage2(void *pgt_pool_base)
> >  {
> >         struct kvm_s2_mmu *mmu = &host_kvm.arch.mmu;
> > @@ -101,8 +102,9 @@ int kvm_host_prepare_stage2(void *pgt_pool_base)
> >         if (ret)
> >                 return ret;
> >
> > -       ret = kvm_pgtable_stage2_init_flags(&host_kvm.pgt, &host_kvm.arch,
> > -                                           &host_kvm.mm_ops, KVM_HOST_S2_FLAGS);
> > +       ret = __kvm_pgtable_stage2_init(&host_kvm.pgt, &host_kvm.arch,
> > +                                       &host_kvm.mm_ops, KVM_HOST_S2_FLAGS,
> > +                                       host_stage2_force_pte_cb);
> >         if (ret)
> >                 return ret;
> >
> > @@ -270,9 +272,31 @@ static int host_stage2_adjust_range(u64 addr, struct kvm_mem_range *range)
> >         return 0;
> >  }
> >
> > +static bool host_stage2_force_pte_cb(u64 addr, u64 end, enum kvm_pgtable_prot prot)
> > +{
> > +       /*
> > +        * Block mappings must be used with care in the host stage-2 as a
> > +        * kvm_pgtable_stage2_map() operation targeting a page in the range of
> > +        * an existing block will delete the block under the assumption that
> > +        * mappings in the rest of the block range can always be rebuilt lazily.
> > +        * That assumption is correct for the host stage-2 with RWX mappings
> > +        * targeting memory or RW mappings targeting MMIO ranges (see
> > +        * host_stage2_idmap() below which implements some of the host memory
> > +        * abort logic). However, this is not safe for any other mappings where
> > +        * the host stage-2 page-table is in fact the only place where this
> > +        * state is stored. In all those cases, it is safer to use page-level
> > +        * mappings, hence avoiding to lose the state because of side-effects in
> > +        * kvm_pgtable_stage2_map().
> > +        */
> > +       if (range_is_memory(addr, end))
> > +               return prot != KVM_PGTABLE_PROT_RWX;
> > +       else
> > +               return prot != KVM_PGTABLE_PROT_RW;
> > +}
> 
> Just checking, I don't think that it's possible for the range to be
> big enough to somehow include both memory and mmio, neither now nor in
> future use cases, is it?

That really shouldn't be the case no -- the host_stage2_idmap() function
tries hard to respect that, so I figured as long as these two are
consistent we should be fine.

> > +
> >  static int host_stage2_idmap(u64 addr)
> >  {
> > -       enum kvm_pgtable_prot prot = KVM_PGTABLE_PROT_R | KVM_PGTABLE_PROT_W;
> > +       enum kvm_pgtable_prot prot = KVM_PGTABLE_PROT_RW;
> >         struct kvm_mem_range range;
> >         bool is_memory = find_mem_range(addr, &range);
> >         int ret;
> > diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
> > index 2689fcb7901d..bcc02e6e0f62 100644
> > --- a/arch/arm64/kvm/hyp/pgtable.c
> > +++ b/arch/arm64/kvm/hyp/pgtable.c
> > @@ -452,6 +452,8 @@ int kvm_pgtable_hyp_init(struct kvm_pgtable *pgt, u32 va_bits,
> >         pgt->start_level        = KVM_PGTABLE_MAX_LEVELS - levels;
> >         pgt->mm_ops             = mm_ops;
> >         pgt->mmu                = NULL;
> > +       pgt->force_pte_cb       = NULL;
> > +
> >         return 0;
> >  }
> >
> > @@ -489,6 +491,9 @@ struct stage2_map_data {
> >         void                            *memcache;
> >
> >         struct kvm_pgtable_mm_ops       *mm_ops;
> > +
> > +       /* Force mappings to page granularity */
> > +       bool                            force_pte;
> >  };
> >
> >  u64 kvm_get_vtcr(u64 mmfr0, u64 mmfr1, u32 phys_shift)
> > @@ -602,6 +607,15 @@ static bool stage2_pte_executable(kvm_pte_t pte)
> >         return !(pte & KVM_PTE_LEAF_ATTR_HI_S2_XN);
> >  }
> >
> > +static bool stage2_block_mapping_allowed(u64 addr, u64 end, u32 level,
> > +                                        struct stage2_map_data *data)
> > +{
> > +       if (data->force_pte && (level < (KVM_PGTABLE_MAX_LEVELS - 1)))
> > +               return false;
> 
> I'm not sure I understand why checking the level is necessary. Can
> there be block mapping at the last possible level?

That's probably just a matter of naming, but this function is in fact
called at every level, just like kvm_block_mapping_supported() was
before. And we rely on it returning true at the last level, so I need to
do that check here.

Maybe renaming this stage2_leaf_mapping_allowed() would clarify?

Thanks,
Quentin
