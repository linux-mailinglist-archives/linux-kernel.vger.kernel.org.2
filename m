Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEA273DD30B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 11:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233058AbhHBJhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 05:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233043AbhHBJhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 05:37:47 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F97C06175F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 02:37:38 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 19-20020a9d08930000b02904b98d90c82cso16956176otf.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 02:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ND2xr2Gchr8zIUl07q1TFZItRtPtYYT0O1VElqJbYnw=;
        b=S+vEXTSPVsHG592NB5lLgNE8Ks7GHrf3a+oBPWKhnHO/fynx3Al7qpm3fvsQyLy4Ek
         lbamxkex2aORWFP7PzrHpGgbxm2dWh6lmpQkIsd8lwav6Vsv8n9MyGesHTMhMzPc71DD
         0Y6mLkL/TGynorxYzaCiWslnprs9gu48GvGYYXc9pgLxRlZRcxa4x9srzXQfttVbM659
         M0m/o+Zm4eXkRTPHSk36YWyvYZG2zae9TnRFlLVdwaAPv98hZjH5JAUCo+YDb57p/Olj
         aGk0NXEVFujbG4bXYqrPZuInxzofhbDqYk8yYgT/jS4TaGu+ziJnJkPKtJknkPzqt+fC
         rZjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ND2xr2Gchr8zIUl07q1TFZItRtPtYYT0O1VElqJbYnw=;
        b=YaCNGikCANEr+NUzv6BawllC44R3bKdJw6RAxPW8Oa+Otmut2UUJU5JkmVWf9Kv8a/
         E11a+6PYBg6UzN8bKN5mFDZJu2JseNQ4AJfFuH//7uNlJNnbJZDB7EHMaZeGzHWtp55m
         ucGvWXX7G9jkp5l/MhmjUB5JkbqJAM3TU+APGK11bjevdy/u9YsZH+JEPLf2f6JR9lBR
         xHSNh4RJwnk/FidMxd5zRdJOEb9Ox6G6XSJJHmF/M1T0tamQzSy/vsyyPUxIsjNcLDVF
         4l4Cy/SKADjeOB5ETwf7+4nLGvLmF7GdnUkyoLV/gWB5LQKp+KbDxVRAqTTCiq0fn+LR
         m8qQ==
X-Gm-Message-State: AOAM532JkFnz6FPFkaxpkPJC5OZOxp1qXOFuI0I/iyuzR9CfVWWQKGMm
        b+mo4IFmb3FlWNS+mPc+UrLi+iapmkiCQJ6yj7Hq4g==
X-Google-Smtp-Source: ABdhPJzjahBOfTcU+7lCaW+sLnpsSLRxbwaVqHbBKLyebX5eYH8Qjb6azpeyh0oAvOvCzvsH0Or5DvwNQzUTC0YHsag=
X-Received: by 2002:a9d:4b02:: with SMTP id q2mr11089669otf.52.1627897057328;
 Mon, 02 Aug 2021 02:37:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210729132818.4091769-1-qperret@google.com> <20210729132818.4091769-7-qperret@google.com>
In-Reply-To: <20210729132818.4091769-7-qperret@google.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Mon, 2 Aug 2021 11:37:01 +0200
Message-ID: <CA+EHjTz20cf78XtAEgTZ4sqaL=N3fY0hd=_=rZge53nUv=vsjQ@mail.gmail.com>
Subject: Re: [PATCH v3 06/21] KVM: arm64: Optimize host memory aborts
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

On Thu, Jul 29, 2021 at 3:28 PM Quentin Perret <qperret@google.com> wrote:
>
> The kvm_pgtable_stage2_find_range() function is used in the host memory
> abort path to try and look for the largest block mapping that can be
> used to map the faulting address. In order to do so, the function
> currently walks the stage-2 page-table and looks for existing
> incompatible mappings within the range of the largest possible block.
> If incompatible mappings are found, it tries the same procedure again,
> but using a smaller block range, and repeats until a matching range is
> found (potentially up to page granularity). While this approach has
> benefits (mostly in the fact that it proactively coalesces host stage-2
> mappings), it can be slow if the ranges are fragmented, and it isn't
> optimized to deal with CPUs faulting on the same IPA as all of them will
> do all the work every time.
>
> To avoid these issues, remove kvm_pgtable_stage2_find_range(), and walk
> the page-table only once in the host_mem_abort() path to find the
> closest leaf to the input address. With this, use the corresponding
> range if it is invalid and not owned by another entity. If a valid leaf
> is found, return -EAGAIN similar to what is done in the
> kvm_pgtable_stage2_map() path to optimize concurrent faults.
>
> Signed-off-by: Quentin Perret <qperret@google.com>

Reviewing the code it seems to work as described, with the lock
assertion ensuring that the caller knows which lock to hold.

Reviewed-by: Fuad Tabba <tabba@google.com>

Thanks,
/fuad


> ---
>  arch/arm64/include/asm/kvm_pgtable.h  | 30 -----------
>  arch/arm64/kvm/hyp/nvhe/mem_protect.c | 45 +++++++++++++++-
>  arch/arm64/kvm/hyp/pgtable.c          | 74 ---------------------------
>  3 files changed, 44 insertions(+), 105 deletions(-)
>
> diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
> index 6938eac72c1f..83c5c97d9eac 100644
> --- a/arch/arm64/include/asm/kvm_pgtable.h
> +++ b/arch/arm64/include/asm/kvm_pgtable.h
> @@ -154,16 +154,6 @@ enum kvm_pgtable_prot {
>  #define PAGE_HYP_RO            (KVM_PGTABLE_PROT_R)
>  #define PAGE_HYP_DEVICE                (PAGE_HYP | KVM_PGTABLE_PROT_DEVICE)
>
> -/**
> - * struct kvm_mem_range - Range of Intermediate Physical Addresses
> - * @start:     Start of the range.
> - * @end:       End of the range.
> - */
> -struct kvm_mem_range {
> -       u64 start;
> -       u64 end;
> -};
> -
>  /**
>   * enum kvm_pgtable_walk_flags - Flags to control a depth-first page-table walk.
>   * @KVM_PGTABLE_WALK_LEAF:             Visit leaf entries, including invalid
> @@ -490,24 +480,4 @@ int kvm_pgtable_walk(struct kvm_pgtable *pgt, u64 addr, u64 size,
>   */
>  int kvm_pgtable_get_leaf(struct kvm_pgtable *pgt, u64 addr,
>                          kvm_pte_t *ptep, u32 *level);
> -
> -/**
> - * kvm_pgtable_stage2_find_range() - Find a range of Intermediate Physical
> - *                                  Addresses with compatible permission
> - *                                  attributes.
> - * @pgt:       Page-table structure initialised by kvm_pgtable_stage2_init*().
> - * @addr:      Address that must be covered by the range.
> - * @prot:      Protection attributes that the range must be compatible with.
> - * @range:     Range structure used to limit the search space at call time and
> - *             that will hold the result.
> - *
> - * The offset of @addr within a page is ignored. An IPA is compatible with @prot
> - * iff its corresponding stage-2 page-table entry has default ownership and, if
> - * valid, is mapped with protection attributes identical to @prot.
> - *
> - * Return: 0 on success, negative error code on failure.
> - */
> -int kvm_pgtable_stage2_find_range(struct kvm_pgtable *pgt, u64 addr,
> -                                 enum kvm_pgtable_prot prot,
> -                                 struct kvm_mem_range *range);
>  #endif /* __ARM64_KVM_PGTABLE_H__ */
> diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> index 74280a753efb..2148d3968aa5 100644
> --- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> +++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> @@ -159,6 +159,11 @@ static int host_stage2_unmap_dev_all(void)
>         return kvm_pgtable_stage2_unmap(pgt, addr, BIT(pgt->ia_bits) - addr);
>  }
>
> +struct kvm_mem_range {
> +       u64 start;
> +       u64 end;
> +};
> +
>  static bool find_mem_range(phys_addr_t addr, struct kvm_mem_range *range)
>  {
>         int cur, left = 0, right = hyp_memblock_nr;
> @@ -227,6 +232,44 @@ static inline int __host_stage2_idmap(u64 start, u64 end,
>                 __ret;                                                  \
>          })
>
> +static inline bool range_included(struct kvm_mem_range *child,
> +                                 struct kvm_mem_range *parent)
> +{
> +       return parent->start <= child->start && child->end <= parent->end;
> +}
> +
> +static int host_stage2_adjust_range(u64 addr, struct kvm_mem_range *range)
> +{
> +       struct kvm_mem_range cur;
> +       kvm_pte_t pte;
> +       u32 level;
> +       int ret;
> +
> +       hyp_assert_lock_held(&host_kvm.lock);
> +       ret = kvm_pgtable_get_leaf(&host_kvm.pgt, addr, &pte, &level);
> +       if (ret)
> +               return ret;
> +
> +       if (kvm_pte_valid(pte))
> +               return -EAGAIN;
> +
> +       if (pte)
> +               return -EPERM;
> +
> +       do {
> +               u64 granule = kvm_granule_size(level);
> +               cur.start = ALIGN_DOWN(addr, granule);
> +               cur.end = cur.start + granule;
> +               level++;
> +       } while ((level < KVM_PGTABLE_MAX_LEVELS) &&
> +                       !(kvm_level_supports_block_mapping(level) &&
> +                         range_included(&cur, range)));
> +
> +       *range = cur;
> +
> +       return 0;
> +}
> +
>  static int host_stage2_idmap(u64 addr)
>  {
>         enum kvm_pgtable_prot prot = KVM_PGTABLE_PROT_R | KVM_PGTABLE_PROT_W;
> @@ -238,7 +281,7 @@ static int host_stage2_idmap(u64 addr)
>                 prot |= KVM_PGTABLE_PROT_X;
>
>         hyp_spin_lock(&host_kvm.lock);
> -       ret = kvm_pgtable_stage2_find_range(&host_kvm.pgt, addr, prot, &range);
> +       ret = host_stage2_adjust_range(addr, &range);
>         if (ret)
>                 goto unlock;
>
> diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
> index 49d768b92997..4dff2ad39ee4 100644
> --- a/arch/arm64/kvm/hyp/pgtable.c
> +++ b/arch/arm64/kvm/hyp/pgtable.c
> @@ -1102,77 +1102,3 @@ void kvm_pgtable_stage2_destroy(struct kvm_pgtable *pgt)
>         pgt->mm_ops->free_pages_exact(pgt->pgd, pgd_sz);
>         pgt->pgd = NULL;
>  }
> -
> -#define KVM_PTE_LEAF_S2_COMPAT_MASK    (KVM_PTE_LEAF_ATTR_S2_PERMS | \
> -                                        KVM_PTE_LEAF_ATTR_LO_S2_MEMATTR | \
> -                                        KVM_PTE_LEAF_ATTR_S2_IGNORED)
> -
> -static int stage2_check_permission_walker(u64 addr, u64 end, u32 level,
> -                                         kvm_pte_t *ptep,
> -                                         enum kvm_pgtable_walk_flags flag,
> -                                         void * const arg)
> -{
> -       kvm_pte_t old_attr, pte = *ptep, *new_attr = arg;
> -
> -       /*
> -        * Compatible mappings are either invalid and owned by the page-table
> -        * owner (whose id is 0), or valid with matching permission attributes.
> -        */
> -       if (kvm_pte_valid(pte)) {
> -               old_attr = pte & KVM_PTE_LEAF_S2_COMPAT_MASK;
> -               if (old_attr != *new_attr)
> -                       return -EEXIST;
> -       } else if (pte) {
> -               return -EEXIST;
> -       }
> -
> -       return 0;
> -}
> -
> -int kvm_pgtable_stage2_find_range(struct kvm_pgtable *pgt, u64 addr,
> -                                 enum kvm_pgtable_prot prot,
> -                                 struct kvm_mem_range *range)
> -{
> -       kvm_pte_t attr;
> -       struct kvm_pgtable_walker check_perm_walker = {
> -               .cb             = stage2_check_permission_walker,
> -               .flags          = KVM_PGTABLE_WALK_LEAF,
> -               .arg            = &attr,
> -       };
> -       u64 granule, start, end;
> -       u32 level;
> -       int ret;
> -
> -       ret = stage2_set_prot_attr(pgt, prot, &attr);
> -       if (ret)
> -               return ret;
> -       attr &= KVM_PTE_LEAF_S2_COMPAT_MASK;
> -
> -       for (level = pgt->start_level; level < KVM_PGTABLE_MAX_LEVELS; level++) {
> -               granule = kvm_granule_size(level);
> -               start = ALIGN_DOWN(addr, granule);
> -               end = start + granule;
> -
> -               if (!kvm_level_supports_block_mapping(level))
> -                       continue;
> -
> -               if (start < range->start || range->end < end)
> -                       continue;
> -
> -               /*
> -                * Check the presence of existing mappings with incompatible
> -                * permissions within the current block range, and try one level
> -                * deeper if one is found.
> -                */
> -               ret = kvm_pgtable_walk(pgt, start, granule, &check_perm_walker);
> -               if (ret != -EEXIST)
> -                       break;
> -       }
> -
> -       if (!ret) {
> -               range->start = start;
> -               range->end = end;
> -       }
> -
> -       return ret;
> -}
> --
> 2.32.0.432.gabb21c7263-goog
>
