Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0D732B731
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 12:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383151AbhCCKum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 05:50:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237495AbhCCAYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 19:24:01 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F54C061788
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 16:21:58 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id k2so18357108ioh.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 16:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kpiUQP6yqizB0jZgYrPrualAhkks3FicXbCdjJrCNNI=;
        b=JEvgf94g+fjRu1svrWxoW3y9J+S5tOEbgbJXGdDJl1PWUxn1YlWfjwRvmPeukn2TVa
         giAB/pZo759K97elLC/vrpzIYKW2dx4Xwwwl0URbhOEfzFq47YOeTrG0SeNH4zR2RkFC
         TZVjtzHLbgXyRmHLo99X4zp0sHOZBzQ2w9TJ55IO0gniGnyDXnPmnmrVKRuK5yQR+bsO
         QNtvUEyloSG5G7Aii2kk5ik8ADdEQmw8VHW10wUrowoTljiRfjFQVmzy0rmeYsAScTf1
         a2+KFdK81sUFsBRU2vDg8rYXC6p+o77ZwLGC7eOTn2CLyv5DSZolgF/WB43EIdXKBAm9
         GEaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kpiUQP6yqizB0jZgYrPrualAhkks3FicXbCdjJrCNNI=;
        b=exIQHVUy62iXUdLih18EZ7x3oGC193pmOx1cOO2xZFQbGjLQOGGSo/74cOd6vj/xnd
         yfoO9HccrBSAj8AJOoNSzVQrcrgNVq301ykqG4kLLim4xE12zASPnGDnhZ4sbvjcdrSk
         vLyLKNnGo10Y3lhyM32ucdUTcdIdBx7lYcirmsSum+37RXxVLGFV8jc5yMnlQbM0if4t
         ElJZgoOpxpdg2dTzAS6nzaabtoiLdirap12Szd6MY8IuQkxBkj8LEmLb/qNmysLptEoI
         NvRqZZrdc2fIb/m+mbfJDE2X6tlIohlBYcgqrUSAfnNgh/a88ja66vmv1xyFBshMjPZm
         TcLw==
X-Gm-Message-State: AOAM530p3LKDMS/s8qQ3uRHRQjhg6Do5JS4qYcQUCKt7aJE/oHpoFtTe
        cntAMTIf5S7b8PvE4Y7FBC9H8sIzH03UeJ2M+pOcZA==
X-Google-Smtp-Source: ABdhPJx1jQBeJwmYJm/bvo2lepkA0zfkgW3Z7yCjNddmFWlCIVwbfydJbuwYPv8H78iyxd7Ka4EvGGJugMa2R4fdxE8=
X-Received: by 2002:a05:6602:2e95:: with SMTP id m21mr15664266iow.9.1614730917421;
 Tue, 02 Mar 2021 16:21:57 -0800 (PST)
MIME-Version: 1.0
References: <20210302184540.2829328-1-seanjc@google.com> <20210302184540.2829328-4-seanjc@google.com>
In-Reply-To: <20210302184540.2829328-4-seanjc@google.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Tue, 2 Mar 2021 16:21:46 -0800
Message-ID: <CANgfPd95G-01ObzeKeMTUu0yXBJ=0+ZGQwr_5WCNH-NmR03f9w@mail.gmail.com>
Subject: Re: [PATCH 03/15] KVM: x86/mmu: Ensure MMU pages are available when
 allocating roots
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 2, 2021 at 10:46 AM Sean Christopherson <seanjc@google.com> wrote:
>
> Hold the mmu_lock for write for the entire duration of allocating and
> initializing an MMU's roots.  This ensures there are MMU pages available
> and thus prevents root allocations from failing.  That in turn fixes a
> bug where KVM would fail to free valid PAE roots if a one of the later
> roots failed to allocate.
>
> Note, KVM still leaks the PAE roots if the lm_root allocation fails.
> This will be addressed in a future commit.
>
> Cc: Ben Gardon <bgardon@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Ben Gardon <bgardon@google.com>

Very tidy cleanup!

> ---
>  arch/x86/kvm/mmu/mmu.c     | 41 ++++++++++++--------------------------
>  arch/x86/kvm/mmu/tdp_mmu.c | 23 +++++----------------
>  2 files changed, 18 insertions(+), 46 deletions(-)
>
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 2ed3fac1244e..1f129001a30c 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -2398,6 +2398,9 @@ static int make_mmu_pages_available(struct kvm_vcpu *vcpu)
>  {
>         unsigned long avail = kvm_mmu_available_pages(vcpu->kvm);
>
> +       /* Ensure all four PAE roots can be allocated in a single pass. */
> +       BUILD_BUG_ON(KVM_MIN_FREE_MMU_PAGES < 4);
> +

For a second I thought that this should be 5 since a page is needed to
hold the 4 PAE roots, but that page is allocated at vCPU creation and
reused, so no need to check for it here.

>         if (likely(avail >= KVM_MIN_FREE_MMU_PAGES))
>                 return 0;
>
> @@ -3220,16 +3223,9 @@ static hpa_t mmu_alloc_root(struct kvm_vcpu *vcpu, gfn_t gfn, gva_t gva,
>  {
>         struct kvm_mmu_page *sp;
>
> -       write_lock(&vcpu->kvm->mmu_lock);
> -
> -       if (make_mmu_pages_available(vcpu)) {
> -               write_unlock(&vcpu->kvm->mmu_lock);
> -               return INVALID_PAGE;
> -       }
>         sp = kvm_mmu_get_page(vcpu, gfn, gva, level, direct, ACC_ALL);
>         ++sp->root_count;
>
> -       write_unlock(&vcpu->kvm->mmu_lock);
>         return __pa(sp->spt);
>  }
>
> @@ -3241,16 +3237,10 @@ static int mmu_alloc_direct_roots(struct kvm_vcpu *vcpu)
>
>         if (is_tdp_mmu_enabled(vcpu->kvm)) {
>                 root = kvm_tdp_mmu_get_vcpu_root_hpa(vcpu);
> -
> -               if (!VALID_PAGE(root))
> -                       return -ENOSPC;
>                 vcpu->arch.mmu->root_hpa = root;
>         } else if (shadow_root_level >= PT64_ROOT_4LEVEL) {
>                 root = mmu_alloc_root(vcpu, 0, 0, shadow_root_level,
>                                       true);
> -
> -               if (!VALID_PAGE(root))
> -                       return -ENOSPC;

There's so much going on in mmu_alloc_root that removing this check
makes me nervous, but I think it should be safe.
I checked though the function because I was worried it might yield
somewhere in there, which could result in the page cache being emptied
and the allocation failing, but I don't think mmu_alloc_root this
function will yield.

>                 vcpu->arch.mmu->root_hpa = root;
>         } else if (shadow_root_level == PT32E_ROOT_LEVEL) {
>                 for (i = 0; i < 4; ++i) {
> @@ -3258,8 +3248,6 @@ static int mmu_alloc_direct_roots(struct kvm_vcpu *vcpu)
>
>                         root = mmu_alloc_root(vcpu, i << (30 - PAGE_SHIFT),
>                                               i << 30, PT32_ROOT_LEVEL, true);
> -                       if (!VALID_PAGE(root))
> -                               return -ENOSPC;
>                         vcpu->arch.mmu->pae_root[i] = root | PT_PRESENT_MASK;
>                 }
>                 vcpu->arch.mmu->root_hpa = __pa(vcpu->arch.mmu->pae_root);
> @@ -3294,8 +3282,6 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
>
>                 root = mmu_alloc_root(vcpu, root_gfn, 0,
>                                       vcpu->arch.mmu->shadow_root_level, false);
> -               if (!VALID_PAGE(root))
> -                       return -ENOSPC;
>                 vcpu->arch.mmu->root_hpa = root;
>                 goto set_root_pgd;
>         }
> @@ -3325,6 +3311,7 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
>
>         for (i = 0; i < 4; ++i) {
>                 MMU_WARN_ON(VALID_PAGE(vcpu->arch.mmu->pae_root[i]));
> +
>                 if (vcpu->arch.mmu->root_level == PT32E_ROOT_LEVEL) {
>                         pdptr = vcpu->arch.mmu->get_pdptr(vcpu, i);
>                         if (!(pdptr & PT_PRESENT_MASK)) {
> @@ -3338,8 +3325,6 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
>
>                 root = mmu_alloc_root(vcpu, root_gfn, i << 30,
>                                       PT32_ROOT_LEVEL, false);
> -               if (!VALID_PAGE(root))
> -                       return -ENOSPC;
>                 vcpu->arch.mmu->pae_root[i] = root | pm_mask;
>         }
>         vcpu->arch.mmu->root_hpa = __pa(vcpu->arch.mmu->pae_root);
> @@ -3373,14 +3358,6 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
>         return 0;
>  }
>
> -static int mmu_alloc_roots(struct kvm_vcpu *vcpu)
> -{
> -       if (vcpu->arch.mmu->direct_map)
> -               return mmu_alloc_direct_roots(vcpu);
> -       else
> -               return mmu_alloc_shadow_roots(vcpu);
> -}
> -
>  void kvm_mmu_sync_roots(struct kvm_vcpu *vcpu)
>  {
>         int i;
> @@ -4822,7 +4799,15 @@ int kvm_mmu_load(struct kvm_vcpu *vcpu)
>         r = mmu_topup_memory_caches(vcpu, !vcpu->arch.mmu->direct_map);
>         if (r)
>                 goto out;
> -       r = mmu_alloc_roots(vcpu);
> +       write_lock(&vcpu->kvm->mmu_lock);
> +       if (make_mmu_pages_available(vcpu))
> +               r = -ENOSPC;
> +       else if (vcpu->arch.mmu->direct_map)
> +               r = mmu_alloc_direct_roots(vcpu);
> +       else
> +               r = mmu_alloc_shadow_roots(vcpu);
> +       write_unlock(&vcpu->kvm->mmu_lock);
> +
>         kvm_mmu_sync_roots(vcpu);
>         if (r)
>                 goto out;
> diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
> index 70226e0875fe..50ef757c5586 100644
> --- a/arch/x86/kvm/mmu/tdp_mmu.c
> +++ b/arch/x86/kvm/mmu/tdp_mmu.c
> @@ -137,22 +137,21 @@ static struct kvm_mmu_page *alloc_tdp_mmu_page(struct kvm_vcpu *vcpu, gfn_t gfn,
>         return sp;
>  }
>
> -static struct kvm_mmu_page *get_tdp_mmu_vcpu_root(struct kvm_vcpu *vcpu)
> +hpa_t kvm_tdp_mmu_get_vcpu_root_hpa(struct kvm_vcpu *vcpu)
>  {
>         union kvm_mmu_page_role role;
>         struct kvm *kvm = vcpu->kvm;
>         struct kvm_mmu_page *root;
>
> +       lockdep_assert_held_write(&kvm->mmu_lock);
> +
>         role = page_role_for_level(vcpu, vcpu->arch.mmu->shadow_root_level);
>
> -       write_lock(&kvm->mmu_lock);
> -
>         /* Check for an existing root before allocating a new one. */
>         for_each_tdp_mmu_root(kvm, root) {
>                 if (root->role.word == role.word) {
>                         kvm_mmu_get_root(kvm, root);
> -                       write_unlock(&kvm->mmu_lock);
> -                       return root;
> +                       goto out;
>                 }
>         }
>
> @@ -161,19 +160,7 @@ static struct kvm_mmu_page *get_tdp_mmu_vcpu_root(struct kvm_vcpu *vcpu)
>
>         list_add(&root->link, &kvm->arch.tdp_mmu_roots);
>
> -       write_unlock(&kvm->mmu_lock);
> -
> -       return root;
> -}
> -
> -hpa_t kvm_tdp_mmu_get_vcpu_root_hpa(struct kvm_vcpu *vcpu)
> -{
> -       struct kvm_mmu_page *root;
> -
> -       root = get_tdp_mmu_vcpu_root(vcpu);
> -       if (!root)
> -               return INVALID_PAGE;
> -
> +out:
>         return __pa(root->spt);
>  }
>
> --
> 2.30.1.766.gb4fecdf3b7-goog
>
