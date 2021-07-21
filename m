Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8CB3D0CEE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 13:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237655AbhGUKNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 06:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239801AbhGUKH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 06:07:26 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F39C0613DD
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 03:46:31 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id b24-20020a9d60d80000b02904d14e47202cso1649075otk.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 03:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7lJAFvcjFDxSgk/vkHpYq2yeu+6Zn/sTj2rc7X9M9nU=;
        b=eZ0Qx+nDEK46aRTYT687jST7ULuil5H1nMXJ5xQbqZ7sHwCdShLdGjKnLwuajBUqaI
         C1iH1AzEWviiCDZvCotTjUVxhPRzZ09UQKU+SDyvJpcXO0CXw4TiidGE7CkLqJ+so8vf
         v6t99JHSy8iYHbO3VliujJMF2fhIkF9JBmLhnTSqXVOrOsX9pjbaMiqddYxiwO2B2+ee
         tjwxcoR5T89IryHyKxEbAA/JSALJgBat+EEKjgu0w7DdRFnDs85HtebCYS6ivlwhItqQ
         hrNn+J+OeTyu6UARRoaNqPcEZyGK6EixMoFjThLJ2/ba2hKPwkIKB5U/QXrsSvesZcG1
         gYiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7lJAFvcjFDxSgk/vkHpYq2yeu+6Zn/sTj2rc7X9M9nU=;
        b=iKnHsv+0Y/3LGOQ/fllI8uKdNgywV5dKiTLxhZFbxEL0rm1IGol0KRpRU7/uYN6LoJ
         umdz1shSsj9AZBquy2UrDze427X5RQDob7s/iTh8sMEOi2Sg1TOpZja0pwS9fyyqttkQ
         9fuj2IADFBbvS/gBdOLUntNfKtU6d8qCw6nvw2qsF5Y2Sp5f53n0VyILy8QDBePiGMV5
         88al3Tgg22J7bK2WIYiDufN3k5T6vq/TkmTbjVzl1FKsHMXr6c4Ob/LqZ+DyeY6FUcDW
         GgUbte95f6N9dZU2nJbWA/tWvdU4Sqq4I9Hcalso8LwhnhDXBtCe/jQWnMvP9ju2bTWz
         xvag==
X-Gm-Message-State: AOAM5317foB7TRJX4FxcQMsO7ibSX4m88zXoZA+eaYynwbkP4p2vHOmF
        JDLqutCrFkx8S/9sp4/j9wqB1v0m9LDrurL3t6LQFA==
X-Google-Smtp-Source: ABdhPJzcshieu8Dzd22Ad1u9ApbpQS9c2D6BVui4kgt8j0A/QaJhDu4uboy6sXNBDRjl6yZadgZqB0ruwbawk/YjT0A=
X-Received: by 2002:a9d:600a:: with SMTP id h10mr25212239otj.144.1626864390244;
 Wed, 21 Jul 2021 03:46:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210719104735.3681732-1-qperret@google.com> <20210719104735.3681732-14-qperret@google.com>
In-Reply-To: <20210719104735.3681732-14-qperret@google.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Wed, 21 Jul 2021 11:45:53 +0100
Message-ID: <CA+EHjTzpoX+rLQHwUbR3BVY_XJEWERiG4AGk7SW6GDtDFC_cuQ@mail.gmail.com>
Subject: Re: [PATCH 13/14] KVM: arm64: Restrict hyp stage-1 manipulation in
 protected mode
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

On Mon, Jul 19, 2021 at 11:48 AM Quentin Perret <qperret@google.com> wrote:
>
> The host kernel is currently able to change EL2 stage-1 mappings without
> restrictions thanks to the __pkvm_create_mappings() hypercall. But in a
> world where the host is no longer part of the TCB, this clearly poses a
> problem.
>
> To fix this, introduce a new hypercall to allow the host to share a
> range of physical memory with the hypervisor, and remove the
> __pkvm_create_mappings() variant. The new hypercall implements
> ownership and permission checks before allowing the sharing operation,
> and it annotates the shared pages in the hypervisor stage-1 and host
> stage-2 page-tables.
>
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/include/asm/kvm_asm.h              |   2 +-
>  arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |   1 +
>  arch/arm64/kvm/hyp/include/nvhe/mm.h          |   2 -
>  arch/arm64/kvm/hyp/nvhe/hyp-main.c            |  12 +-
>  arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 105 ++++++++++++++++++
>  arch/arm64/kvm/hyp/nvhe/mm.c                  |   4 +-
>  arch/arm64/kvm/mmu.c                          |  14 ++-
>  7 files changed, 124 insertions(+), 16 deletions(-)
>
> diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
> index 9f0bf2109be7..78db818ae2c9 100644
> --- a/arch/arm64/include/asm/kvm_asm.h
> +++ b/arch/arm64/include/asm/kvm_asm.h
> @@ -59,7 +59,7 @@
>  #define __KVM_HOST_SMCCC_FUNC___vgic_v3_save_aprs              13
>  #define __KVM_HOST_SMCCC_FUNC___vgic_v3_restore_aprs           14
>  #define __KVM_HOST_SMCCC_FUNC___pkvm_init                      15
> -#define __KVM_HOST_SMCCC_FUNC___pkvm_create_mappings           16
> +#define __KVM_HOST_SMCCC_FUNC___pkvm_host_share_hyp            16
>  #define __KVM_HOST_SMCCC_FUNC___pkvm_create_private_mapping    17
>  #define __KVM_HOST_SMCCC_FUNC___pkvm_cpu_set_vector            18
>  #define __KVM_HOST_SMCCC_FUNC___pkvm_prot_finalize             19
> diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> index b39047463075..f37e4d3b831b 100644
> --- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> +++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> @@ -22,6 +22,7 @@ extern struct host_kvm host_kvm;
>
>  int __pkvm_prot_finalize(void);
>  int __pkvm_mark_hyp(phys_addr_t start, phys_addr_t end);
> +int __pkvm_host_share_hyp(phys_addr_t start, phys_addr_t end);
>
>  int host_stage2_idmap_locked(u64 start, u64 end, enum kvm_pgtable_prot prot);
>  int kvm_host_prepare_stage2(void *pgt_pool_base);
> diff --git a/arch/arm64/kvm/hyp/include/nvhe/mm.h b/arch/arm64/kvm/hyp/include/nvhe/mm.h
> index c76d7136ed9b..c9a8f535212e 100644
> --- a/arch/arm64/kvm/hyp/include/nvhe/mm.h
> +++ b/arch/arm64/kvm/hyp/include/nvhe/mm.h
> @@ -24,8 +24,6 @@ int hyp_back_vmemmap(phys_addr_t phys, unsigned long size, phys_addr_t back);
>  int pkvm_cpu_set_vector(enum arm64_hyp_spectre_vector slot);
>  int pkvm_create_mappings(void *from, void *to, enum kvm_pgtable_prot prot);
>  int pkvm_create_mappings_locked(void *from, void *to, enum kvm_pgtable_prot prot);
> -int __pkvm_create_mappings(unsigned long start, unsigned long size,
> -                          unsigned long phys, enum kvm_pgtable_prot prot);
>  unsigned long __pkvm_create_private_mapping(phys_addr_t phys, size_t size,
>                                             enum kvm_pgtable_prot prot);
>
> diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> index 1632f001f4ed..f05ecbd382d0 100644
> --- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> +++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> @@ -140,14 +140,12 @@ static void handle___pkvm_cpu_set_vector(struct kvm_cpu_context *host_ctxt)
>         cpu_reg(host_ctxt, 1) = pkvm_cpu_set_vector(slot);
>  }
>
> -static void handle___pkvm_create_mappings(struct kvm_cpu_context *host_ctxt)
> +static void handle___pkvm_host_share_hyp(struct kvm_cpu_context *host_ctxt)
>  {
> -       DECLARE_REG(unsigned long, start, host_ctxt, 1);
> -       DECLARE_REG(unsigned long, size, host_ctxt, 2);
> -       DECLARE_REG(unsigned long, phys, host_ctxt, 3);
> -       DECLARE_REG(enum kvm_pgtable_prot, prot, host_ctxt, 4);
> +       DECLARE_REG(phys_addr_t, start, host_ctxt, 1);
> +       DECLARE_REG(phys_addr_t, end, host_ctxt, 2);
>
> -       cpu_reg(host_ctxt, 1) = __pkvm_create_mappings(start, size, phys, prot);
> +       cpu_reg(host_ctxt, 1) = __pkvm_host_share_hyp(start, end);
>  }
>
>  static void handle___pkvm_create_private_mapping(struct kvm_cpu_context *host_ctxt)
> @@ -193,7 +191,7 @@ static const hcall_t host_hcall[] = {
>         HANDLE_FUNC(__vgic_v3_restore_aprs),
>         HANDLE_FUNC(__pkvm_init),
>         HANDLE_FUNC(__pkvm_cpu_set_vector),
> -       HANDLE_FUNC(__pkvm_create_mappings),
> +       HANDLE_FUNC(__pkvm_host_share_hyp),
>         HANDLE_FUNC(__pkvm_create_private_mapping),
>         HANDLE_FUNC(__pkvm_prot_finalize),
>         HANDLE_FUNC(__pkvm_mark_hyp),
> diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> index 6f28edf58407..20b3cb3fdc67 100644
> --- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> +++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> @@ -262,6 +262,111 @@ static int host_stage2_idmap(u64 addr)
>         return ret;
>  }
>
> +static int hyp_range_is_shared_walker(u64 addr, u64 end, u32 level,
> +                                     kvm_pte_t *ptep,
> +                                     enum kvm_pgtable_walk_flags flag,
> +                                     void * const arg)
> +{
> +       enum kvm_pgtable_prot prot;
> +       kvm_pte_t pte = *ptep;
> +
> +       if (!kvm_pte_valid(pte))
> +               return -EPERM;
> +
> +       prot = kvm_pgtable_hyp_pte_prot(pte);
> +       if (!prot)
> +               return -EPERM;
nit: is this check necessary?

> +       /* Check that the page has been shared with the hypervisor before */
> +       if (prot != (PAGE_HYP | KVM_PGTABLE_STATE_SHARED | KVM_PGTABLE_STATE_BORROWED))
> +               return -EPERM;
> +
> +       return 0;
> +}
> +
> +static int hyp_range_is_shared(phys_addr_t start, phys_addr_t end)
> +{
> +       struct kvm_pgtable_walker walker = {
> +               .cb = hyp_range_is_shared_walker,
> +               .flags = KVM_PGTABLE_WALK_LEAF,
> +       };
> +
> +       return kvm_pgtable_walk(&pkvm_pgtable, (u64)__hyp_va(start),
> +                               end - start, &walker);
> +}
> +
> +static int check_host_share_hyp_walker(u64 addr, u64 end, u32 level,

nit: It seems the convention is usually addr,size or start,end. Here
you're using addr,end.

> +                                      kvm_pte_t *ptep,
> +                                      enum kvm_pgtable_walk_flags flag,
> +                                      void * const arg)
> +{
> +       enum kvm_pgtable_prot prot;
> +       kvm_pte_t pte = *ptep;
> +
> +       /* If invalid, only allow to share pristine pages */
> +       if (!kvm_pte_valid(pte))
> +               return pte ? -EPERM : 0;
> +
> +       prot = kvm_pgtable_stage2_pte_prot(pte);
> +       if (!prot)
> +               return -EPERM;
> +
> +       /* Cannot share a page that is not owned */
> +       if (prot & KVM_PGTABLE_STATE_BORROWED)
> +               return -EPERM;
> +
> +       /* Cannot share a page with restricted access */
> +       if ((prot & KVM_PGTABLE_PROT_RWX) ^ KVM_PGTABLE_PROT_RWX)
nit: isn't this clearer as

if ((prot & KVM_PGTABLE_PROT_RWX) != KVM_PGTABLE_PROT_RWX)


> +               return -EPERM;
> +
> +       /* Allow double-sharing (requires cross-checking the hyp stage-1) */
> +       if (prot & KVM_PGTABLE_STATE_SHARED)
> +               return hyp_range_is_shared(addr, addr + 1);

Why addr+1, rather than end?

> +
> +       return 0;
> +}
> +
> +static int check_host_share_hyp(phys_addr_t start, phys_addr_t end)
> +{
> +       struct kvm_pgtable_walker walker = {
> +               .cb = check_host_share_hyp_walker,
> +               .flags = KVM_PGTABLE_WALK_LEAF,
> +       };
> +
> +       return kvm_pgtable_walk(&host_kvm.pgt, start, end - start, &walker);
> +}
> +
> +int __pkvm_host_share_hyp(phys_addr_t start, phys_addr_t end)
> +{
> +       enum kvm_pgtable_prot prot;
> +       int ret;
> +
> +       if (!range_is_memory(start, end))
> +               return -EINVAL;
> +
> +       hyp_spin_lock(&host_kvm.lock);
> +       hyp_spin_lock(&pkvm_pgd_lock);
> +
> +       ret = check_host_share_hyp(start, end);
> +       if (ret)
> +               goto unlock;
> +
> +       prot = KVM_PGTABLE_PROT_RWX | KVM_PGTABLE_STATE_SHARED;
> +       ret = host_stage2_idmap_locked(start, end, prot);

Just for me to understand this better. The id mapping here, which
wasn't taking place before this patch, is for tracking, right?

Thanks,
/fuad


> +       if (ret && ret != -EAGAIN)
> +               goto unlock;
> +
> +       prot = PAGE_HYP | KVM_PGTABLE_STATE_SHARED | KVM_PGTABLE_STATE_BORROWED;
> +       ret = pkvm_create_mappings_locked(__hyp_va(start), __hyp_va(end), prot);
> +       /* XXX - undo host stage-2 changes if ret != 0 */
> +
> +unlock:
> +       hyp_spin_unlock(&pkvm_pgd_lock);
> +       hyp_spin_unlock(&host_kvm.lock);
> +
> +       return ret;
> +}
> +
>  int __pkvm_mark_hyp(phys_addr_t start, phys_addr_t end)
>  {
>         int ret;
> diff --git a/arch/arm64/kvm/hyp/nvhe/mm.c b/arch/arm64/kvm/hyp/nvhe/mm.c
> index dde22e2a322a..95f6c34a38ec 100644
> --- a/arch/arm64/kvm/hyp/nvhe/mm.c
> +++ b/arch/arm64/kvm/hyp/nvhe/mm.c
> @@ -23,8 +23,8 @@ u64 __io_map_base;
>  struct memblock_region hyp_memory[HYP_MEMBLOCK_REGIONS];
>  unsigned int hyp_memblock_nr;
>
> -int __pkvm_create_mappings(unsigned long start, unsigned long size,
> -                         unsigned long phys, enum kvm_pgtable_prot prot)
> +static int __pkvm_create_mappings(unsigned long start, unsigned long size,
> +                                 unsigned long phys, enum kvm_pgtable_prot prot)
>  {
>         int err;
>
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index 0625bf2353c2..2158d1e00acd 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -259,10 +259,8 @@ static int __create_hyp_mappings(unsigned long start, unsigned long size,
>  {
>         int err;
>
> -       if (!kvm_host_owns_hyp_mappings()) {
> -               return kvm_call_hyp_nvhe(__pkvm_create_mappings,
> -                                        start, size, phys, prot);
> -       }
> +       if (WARN_ON(!kvm_host_owns_hyp_mappings()))
> +               return -EINVAL;
>
>         mutex_lock(&kvm_hyp_pgd_mutex);
>         err = kvm_pgtable_hyp_map(hyp_pgtable, start, size, phys, prot);
> @@ -302,6 +300,14 @@ int create_hyp_mappings(void *from, void *to, enum kvm_pgtable_prot prot)
>         if (is_kernel_in_hyp_mode())
>                 return 0;
>
> +       if (!kvm_host_owns_hyp_mappings()) {
> +               if (WARN_ON(prot != PAGE_HYP))
> +                       return -EPERM;
> +               return kvm_call_hyp_nvhe(__pkvm_host_share_hyp,
> +                                        kvm_kaddr_to_phys(from),
> +                                        kvm_kaddr_to_phys(to));
> +       }
> +
>         start = start & PAGE_MASK;
>         end = PAGE_ALIGN(end);
>
> --
> 2.32.0.402.g57bb445576-goog
>
