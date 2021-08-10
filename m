Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 449323E5240
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 06:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236362AbhHJEeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 00:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236201AbhHJEeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 00:34:18 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE538C0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 21:33:45 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id be20so8222837oib.8
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 21:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cQhQ4g0b+StAgKyBzdORBwFX2ucPHOc+kfHRCheLhoA=;
        b=YlAZ0VivTdAuYGTr3KTr04F8uMb7DD5hFkmTyPZ+jrc9DKjYY/AeaJBfQMN5WuJIJa
         o+B5+5lZtnituTtcQB9HKAW9n9x16WIOYFpU54a6D21eq3S1Ay0VX2YKFdyBP1IUlA9R
         9JNzSCQdgbi2v7O1+0rpjJI2a/Ic6mTjYk5PX3IG6uyzl48f5xu5a2G/Oip3HbT9O31f
         1Bde2HIq4eTedJSHbYoq2RFutiV1r6CLBt4V7UaLJt0vn5ctrAVGwosh2K+dVbdhZZ/S
         Ul/CNXWyx3dKxtD06G+yZG0hIna6wBy1UozpLEc1V9MMhq+UPu79/kSOJOa4VoK0bhwJ
         HHOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cQhQ4g0b+StAgKyBzdORBwFX2ucPHOc+kfHRCheLhoA=;
        b=rBe7AIO8LZc3RcWnhB/tnOOUCPbfkzVtjwUIYU6Pn6MEtJJxJlcz/16fqTx3hHtqro
         9uZo/iAYNheDXnBqzSYEGdeCjRoxSVoT9SUxkVcxxh6xYD/pguulKTAakSvbuI59JJe9
         71Q7QFgbSViroxBT9jSiE43lhjoSPFAtVnnFg48PMA8JmOAbq3IMkgWjgVCdMu2rjpF0
         IemIu9g9ymtqgL/loWeAjioECwEuC/xaubnUnb9AJvub9PgfPZjtIzHaPHe3JW3v35ld
         iyQu7bKls5vzi9Gg8Nzvvz+t46XABz7bMNkzmOD9A1NwWyXINR5bNaoOWTI6pH08KKeR
         GpEw==
X-Gm-Message-State: AOAM530nXtFjExh0cPoFOp6MlbxSMohoZRBeDCmTB74BwY2Yi8vmlEjW
        pd3ueP3PGebq2YTzVuVRT48xQaSgPrgJwfIN3besSA==
X-Google-Smtp-Source: ABdhPJxPylrWdRDWMvgMslG3gsofleyn+Az1XvJHNyjlTh+3sOcmrTve+yz3Z0Caa8pywASu+4BxscTgewaS8UqgvsE=
X-Received: by 2002:aca:d11:: with SMTP id 17mr1979594oin.67.1628570024104;
 Mon, 09 Aug 2021 21:33:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210809152448.1810400-1-qperret@google.com> <20210809152448.1810400-11-qperret@google.com>
In-Reply-To: <20210809152448.1810400-11-qperret@google.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Tue, 10 Aug 2021 06:33:07 +0200
Message-ID: <CA+EHjTyiMjPxQTTxWJ2Nd46bkCnh=6Yj01EGpx9QYEp=J7Bp4w@mail.gmail.com>
Subject: Re: [PATCH v4 10/21] KVM: arm64: Enable forcing page-level stage-2 mappings
To:     Quentin Perret <qperret@google.com>
Cc:     maz@kernel.org, james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, ardb@kernel.org, qwandor@google.com,
        dbrazdil@google.com, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quentin,

On Mon, Aug 9, 2021 at 5:25 PM Quentin Perret <qperret@google.com> wrote:
>
> Much of the stage-2 manipulation logic relies on being able to destroy
> block mappings if e.g. installing a smaller mapping in the range. The
> rationale for this behaviour is that stage-2 mappings can always be
> re-created lazily. However, this gets more complicated when the stage-2
> page-table is used to store metadata about the underlying pages. In such
> cases, destroying a block mapping may lead to losing part of the state,
> and confuse the user of those metadata (such as the hypervisor in nVHE
> protected mode).
>
> To avoid this, introduce a callback function in the pgtable struct which
> is called during all map operations to determine whether the mappings
> can use blocks, or should be forced to page granularity. This is used by
> the hypervisor when creating the host stage-2 to force page-level
> mappings when using non-default protection attributes.
>
> Signed-off-by: Quentin Perret <qperret@google.com>

Reviewed-by: Fuad Tabba <tabba@google.com>

Thanks,
/fuad


> ---
>  arch/arm64/include/asm/kvm_pgtable.h  | 66 +++++++++++++++++----------
>  arch/arm64/kvm/hyp/nvhe/mem_protect.c | 34 ++++++++++++--
>  arch/arm64/kvm/hyp/pgtable.c          | 29 ++++++++++--
>  3 files changed, 94 insertions(+), 35 deletions(-)
>
> diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
> index 83c5c97d9eac..2c090b0eee77 100644
> --- a/arch/arm64/include/asm/kvm_pgtable.h
> +++ b/arch/arm64/include/asm/kvm_pgtable.h
> @@ -115,25 +115,6 @@ enum kvm_pgtable_stage2_flags {
>         KVM_PGTABLE_S2_IDMAP                    = BIT(1),
>  };
>
> -/**
> - * struct kvm_pgtable - KVM page-table.
> - * @ia_bits:           Maximum input address size, in bits.
> - * @start_level:       Level at which the page-table walk starts.
> - * @pgd:               Pointer to the first top-level entry of the page-table.
> - * @mm_ops:            Memory management callbacks.
> - * @mmu:               Stage-2 KVM MMU struct. Unused for stage-1 page-tables.
> - */
> -struct kvm_pgtable {
> -       u32                                     ia_bits;
> -       u32                                     start_level;
> -       kvm_pte_t                               *pgd;
> -       struct kvm_pgtable_mm_ops               *mm_ops;
> -
> -       /* Stage-2 only */
> -       struct kvm_s2_mmu                       *mmu;
> -       enum kvm_pgtable_stage2_flags           flags;
> -};
> -
>  /**
>   * enum kvm_pgtable_prot - Page-table permissions and attributes.
>   * @KVM_PGTABLE_PROT_X:                Execute permission.
> @@ -149,11 +130,43 @@ enum kvm_pgtable_prot {
>         KVM_PGTABLE_PROT_DEVICE                 = BIT(3),
>  };
>
> -#define PAGE_HYP               (KVM_PGTABLE_PROT_R | KVM_PGTABLE_PROT_W)
> +#define KVM_PGTABLE_PROT_RW    (KVM_PGTABLE_PROT_R | KVM_PGTABLE_PROT_W)
> +#define KVM_PGTABLE_PROT_RWX   (KVM_PGTABLE_PROT_RW | KVM_PGTABLE_PROT_X)
> +
> +#define PKVM_HOST_MEM_PROT     KVM_PGTABLE_PROT_RWX
> +#define PKVM_HOST_MMIO_PROT    KVM_PGTABLE_PROT_RW
> +
> +#define PAGE_HYP               KVM_PGTABLE_PROT_RW
>  #define PAGE_HYP_EXEC          (KVM_PGTABLE_PROT_R | KVM_PGTABLE_PROT_X)
>  #define PAGE_HYP_RO            (KVM_PGTABLE_PROT_R)
>  #define PAGE_HYP_DEVICE                (PAGE_HYP | KVM_PGTABLE_PROT_DEVICE)
>
> +typedef bool (*kvm_pgtable_force_pte_cb_t)(u64 addr, u64 end,
> +                                          enum kvm_pgtable_prot prot);
> +
> +/**
> + * struct kvm_pgtable - KVM page-table.
> + * @ia_bits:           Maximum input address size, in bits.
> + * @start_level:       Level at which the page-table walk starts.
> + * @pgd:               Pointer to the first top-level entry of the page-table.
> + * @mm_ops:            Memory management callbacks.
> + * @mmu:               Stage-2 KVM MMU struct. Unused for stage-1 page-tables.
> + * @flags:             Stage-2 page-table flags.
> + * @force_pte_cb:      Function that returns true if page level mappings must
> + *                     be used instead of block mappings.
> + */
> +struct kvm_pgtable {
> +       u32                                     ia_bits;
> +       u32                                     start_level;
> +       kvm_pte_t                               *pgd;
> +       struct kvm_pgtable_mm_ops               *mm_ops;
> +
> +       /* Stage-2 only */
> +       struct kvm_s2_mmu                       *mmu;
> +       enum kvm_pgtable_stage2_flags           flags;
> +       kvm_pgtable_force_pte_cb_t              force_pte_cb;
> +};
> +
>  /**
>   * enum kvm_pgtable_walk_flags - Flags to control a depth-first page-table walk.
>   * @KVM_PGTABLE_WALK_LEAF:             Visit leaf entries, including invalid
> @@ -246,21 +259,24 @@ int kvm_pgtable_hyp_map(struct kvm_pgtable *pgt, u64 addr, u64 size, u64 phys,
>  u64 kvm_get_vtcr(u64 mmfr0, u64 mmfr1, u32 phys_shift);
>
>  /**
> - * kvm_pgtable_stage2_init_flags() - Initialise a guest stage-2 page-table.
> + * __kvm_pgtable_stage2_init() - Initialise a guest stage-2 page-table.
>   * @pgt:       Uninitialised page-table structure to initialise.
>   * @arch:      Arch-specific KVM structure representing the guest virtual
>   *             machine.
>   * @mm_ops:    Memory management callbacks.
>   * @flags:     Stage-2 configuration flags.
> + * @force_pte_cb: Function that returns true if page level mappings must
> + *             be used instead of block mappings.
>   *
>   * Return: 0 on success, negative error code on failure.
>   */
> -int kvm_pgtable_stage2_init_flags(struct kvm_pgtable *pgt, struct kvm_arch *arch,
> -                                 struct kvm_pgtable_mm_ops *mm_ops,
> -                                 enum kvm_pgtable_stage2_flags flags);
> +int __kvm_pgtable_stage2_init(struct kvm_pgtable *pgt, struct kvm_arch *arch,
> +                             struct kvm_pgtable_mm_ops *mm_ops,
> +                             enum kvm_pgtable_stage2_flags flags,
> +                             kvm_pgtable_force_pte_cb_t force_pte_cb);
>
>  #define kvm_pgtable_stage2_init(pgt, arch, mm_ops) \
> -       kvm_pgtable_stage2_init_flags(pgt, arch, mm_ops, 0)
> +       __kvm_pgtable_stage2_init(pgt, arch, mm_ops, 0, NULL)
>
>  /**
>   * kvm_pgtable_stage2_destroy() - Destroy an unused guest stage-2 page-table.
> diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> index 2148d3968aa5..6fed6772c673 100644
> --- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> +++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> @@ -89,6 +89,8 @@ static void prepare_host_vtcr(void)
>                                           id_aa64mmfr1_el1_sys_val, phys_shift);
>  }
>
> +static bool host_stage2_force_pte_cb(u64 addr, u64 end, enum kvm_pgtable_prot prot);
> +
>  int kvm_host_prepare_stage2(void *pgt_pool_base)
>  {
>         struct kvm_s2_mmu *mmu = &host_kvm.arch.mmu;
> @@ -101,8 +103,9 @@ int kvm_host_prepare_stage2(void *pgt_pool_base)
>         if (ret)
>                 return ret;
>
> -       ret = kvm_pgtable_stage2_init_flags(&host_kvm.pgt, &host_kvm.arch,
> -                                           &host_kvm.mm_ops, KVM_HOST_S2_FLAGS);
> +       ret = __kvm_pgtable_stage2_init(&host_kvm.pgt, &host_kvm.arch,
> +                                       &host_kvm.mm_ops, KVM_HOST_S2_FLAGS,
> +                                       host_stage2_force_pte_cb);
>         if (ret)
>                 return ret;
>
> @@ -270,15 +273,36 @@ static int host_stage2_adjust_range(u64 addr, struct kvm_mem_range *range)
>         return 0;
>  }
>
> +static bool host_stage2_force_pte_cb(u64 addr, u64 end, enum kvm_pgtable_prot prot)
> +{
> +       /*
> +        * Block mappings must be used with care in the host stage-2 as a
> +        * kvm_pgtable_stage2_map() operation targeting a page in the range of
> +        * an existing block will delete the block under the assumption that
> +        * mappings in the rest of the block range can always be rebuilt lazily.
> +        * That assumption is correct for the host stage-2 with RWX mappings
> +        * targeting memory or RW mappings targeting MMIO ranges (see
> +        * host_stage2_idmap() below which implements some of the host memory
> +        * abort logic). However, this is not safe for any other mappings where
> +        * the host stage-2 page-table is in fact the only place where this
> +        * state is stored. In all those cases, it is safer to use page-level
> +        * mappings, hence avoiding to lose the state because of side-effects in
> +        * kvm_pgtable_stage2_map().
> +        */
> +       if (range_is_memory(addr, end))
> +               return prot != PKVM_HOST_MEM_PROT;
> +       else
> +               return prot != PKVM_HOST_MMIO_PROT;
> +}
> +
>  static int host_stage2_idmap(u64 addr)
>  {
> -       enum kvm_pgtable_prot prot = KVM_PGTABLE_PROT_R | KVM_PGTABLE_PROT_W;
>         struct kvm_mem_range range;
>         bool is_memory = find_mem_range(addr, &range);
> +       enum kvm_pgtable_prot prot;
>         int ret;
>
> -       if (is_memory)
> -               prot |= KVM_PGTABLE_PROT_X;
> +       prot = is_memory ? PKVM_HOST_MEM_PROT : PKVM_HOST_MMIO_PROT;
>
>         hyp_spin_lock(&host_kvm.lock);
>         ret = host_stage2_adjust_range(addr, &range);
> diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
> index 2689fcb7901d..e25d829587b9 100644
> --- a/arch/arm64/kvm/hyp/pgtable.c
> +++ b/arch/arm64/kvm/hyp/pgtable.c
> @@ -452,6 +452,8 @@ int kvm_pgtable_hyp_init(struct kvm_pgtable *pgt, u32 va_bits,
>         pgt->start_level        = KVM_PGTABLE_MAX_LEVELS - levels;
>         pgt->mm_ops             = mm_ops;
>         pgt->mmu                = NULL;
> +       pgt->force_pte_cb       = NULL;
> +
>         return 0;
>  }
>
> @@ -489,6 +491,9 @@ struct stage2_map_data {
>         void                            *memcache;
>
>         struct kvm_pgtable_mm_ops       *mm_ops;
> +
> +       /* Force mappings to page granularity */
> +       bool                            force_pte;
>  };
>
>  u64 kvm_get_vtcr(u64 mmfr0, u64 mmfr1, u32 phys_shift)
> @@ -602,6 +607,15 @@ static bool stage2_pte_executable(kvm_pte_t pte)
>         return !(pte & KVM_PTE_LEAF_ATTR_HI_S2_XN);
>  }
>
> +static bool stage2_leaf_mapping_allowed(u64 addr, u64 end, u32 level,
> +                                       struct stage2_map_data *data)
> +{
> +       if (data->force_pte && (level < (KVM_PGTABLE_MAX_LEVELS - 1)))
> +               return false;
> +
> +       return kvm_block_mapping_supported(addr, end, data->phys, level);
> +}
> +
>  static int stage2_map_walker_try_leaf(u64 addr, u64 end, u32 level,
>                                       kvm_pte_t *ptep,
>                                       struct stage2_map_data *data)
> @@ -611,7 +625,7 @@ static int stage2_map_walker_try_leaf(u64 addr, u64 end, u32 level,
>         struct kvm_pgtable *pgt = data->mmu->pgt;
>         struct kvm_pgtable_mm_ops *mm_ops = data->mm_ops;
>
> -       if (!kvm_block_mapping_supported(addr, end, phys, level))
> +       if (!stage2_leaf_mapping_allowed(addr, end, level, data))
>                 return -E2BIG;
>
>         if (kvm_phys_is_valid(phys))
> @@ -655,7 +669,7 @@ static int stage2_map_walk_table_pre(u64 addr, u64 end, u32 level,
>         if (data->anchor)
>                 return 0;
>
> -       if (!kvm_block_mapping_supported(addr, end, data->phys, level))
> +       if (!stage2_leaf_mapping_allowed(addr, end, level, data))
>                 return 0;
>
>         data->childp = kvm_pte_follow(*ptep, data->mm_ops);
> @@ -785,6 +799,7 @@ int kvm_pgtable_stage2_map(struct kvm_pgtable *pgt, u64 addr, u64 size,
>                 .mmu            = pgt->mmu,
>                 .memcache       = mc,
>                 .mm_ops         = pgt->mm_ops,
> +               .force_pte      = pgt->force_pte_cb && pgt->force_pte_cb(addr, addr + size, prot),
>         };
>         struct kvm_pgtable_walker walker = {
>                 .cb             = stage2_map_walker,
> @@ -816,6 +831,7 @@ int kvm_pgtable_stage2_set_owner(struct kvm_pgtable *pgt, u64 addr, u64 size,
>                 .memcache       = mc,
>                 .mm_ops         = pgt->mm_ops,
>                 .owner_id       = owner_id,
> +               .force_pte      = true,
>         };
>         struct kvm_pgtable_walker walker = {
>                 .cb             = stage2_map_walker,
> @@ -1057,9 +1073,11 @@ int kvm_pgtable_stage2_flush(struct kvm_pgtable *pgt, u64 addr, u64 size)
>         return kvm_pgtable_walk(pgt, addr, size, &walker);
>  }
>
> -int kvm_pgtable_stage2_init_flags(struct kvm_pgtable *pgt, struct kvm_arch *arch,
> -                                 struct kvm_pgtable_mm_ops *mm_ops,
> -                                 enum kvm_pgtable_stage2_flags flags)
> +
> +int __kvm_pgtable_stage2_init(struct kvm_pgtable *pgt, struct kvm_arch *arch,
> +                             struct kvm_pgtable_mm_ops *mm_ops,
> +                             enum kvm_pgtable_stage2_flags flags,
> +                             kvm_pgtable_force_pte_cb_t force_pte_cb)
>  {
>         size_t pgd_sz;
>         u64 vtcr = arch->vtcr;
> @@ -1077,6 +1095,7 @@ int kvm_pgtable_stage2_init_flags(struct kvm_pgtable *pgt, struct kvm_arch *arch
>         pgt->mm_ops             = mm_ops;
>         pgt->mmu                = &arch->mmu;
>         pgt->flags              = flags;
> +       pgt->force_pte_cb       = force_pte_cb;
>
>         /* Ensure zeroed PGD pages are visible to the hardware walker */
>         dsb(ishst);
> --
> 2.32.0.605.g8dce9f2422-goog
>
