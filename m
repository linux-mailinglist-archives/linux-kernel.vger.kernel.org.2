Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F30623AF16A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 19:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbhFURJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 13:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbhFURJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 13:09:36 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97901C0617AE
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 10:00:59 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso18392064otu.10
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 10:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7puqCBQ7FSoDUv2FN/6JilRVq96no9R3ksBr1fFE67M=;
        b=QAIS+f/ygiR5KNmRAEsA0RegPl4D3sGZlNzQjaU4TaHnEfl+8AgqTwKw5wUjaIJ93V
         wXtTNsGo7DsaWkBkYxuSBi4XuMItrBzNIiru0Leomtrww9nkF8HxBFGReWbS/5qoiSYH
         ioeFdCbX764HPB/K3RIQ4Ku1FDIw5adMtv/mZNN9dmi8BYfdzGA2Z95g7UzZWhJBh1c/
         lff2JdZWqW6uUFvljJZw1GB0hjDkz57t1zPVdVOF4aqQq2DlyjSivv+8xgQFNBpFa2xN
         eb81VmZ+9Ij8dTkg5pnl5yf8UN25X4Cp8qG/I7c67Ji7K3tQv7qUyqeCq2ekYg7R4XdK
         4WvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7puqCBQ7FSoDUv2FN/6JilRVq96no9R3ksBr1fFE67M=;
        b=pLWUKDSWNFWHVoIHCh8XqrTb/KvtaZkMVxedXa7aMuSnGA6BzNf5Cnd06Ahwzi8aAw
         Ud4K1DNa0h5OsJ22/1V0G1Wca5CRbSuxxVhH+Lj7M1Lv0DjtvlvFP6w7qN8gHCptIlGs
         Z/lzBL+iweiLK6f7EAyaAqEA+deG3Vj0BG1rzZ56H8OOtv1lyBSfV3N8X4piJj8dU84Z
         zDBPk4PsE/6rz8JVrm05XnUy5TVmNscZ465w6Wq2zqqLOb0NnkMedhcpcCQew7ycOrwI
         e5aVs6Z6lhcoVPehFFZFVkckYBLr1LZG+cMrmqIWm4aVJVxuOx0LoHCgvFb+FDwjZajg
         oL+Q==
X-Gm-Message-State: AOAM530G1EnuwsRCZPDUUzXBbOecMY5sSLNlLduF4sCBmgMA6IndznpJ
        tLi45/+QujEqJs9JTFXquiOGdddIlY9ILaQTFVUcCA==
X-Google-Smtp-Source: ABdhPJx5t0tgJyoyWVKIhbOSjECBUtWMe5riqH4Otv0qNrOwrNJEhV541OXMIx2d47Sde9zpqYVT5kFY9YH1Srqx8FI=
X-Received: by 2002:a05:6830:1098:: with SMTP id y24mr15324oto.144.1624294857290;
 Mon, 21 Jun 2021 10:00:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210621111716.37157-1-steven.price@arm.com> <20210621111716.37157-3-steven.price@arm.com>
In-Reply-To: <20210621111716.37157-3-steven.price@arm.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Mon, 21 Jun 2021 18:00:20 +0100
Message-ID: <CA+EHjTxgR3LraZ1gyXjwc5YoE5dVOtCfhjELYFH35KzJSuo6EQ@mail.gmail.com>
Subject: Re: [PATCH v17 2/6] KVM: arm64: Introduce MTE VM feature
To:     Steven Price <steven.price@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        qemu-devel@nongnu.org, Dave Martin <Dave.Martin@arm.com>,
        Juan Quintela <quintela@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jun 21, 2021 at 12:18 PM Steven Price <steven.price@arm.com> wrote:
>
> Add a new VM feature 'KVM_ARM_CAP_MTE' which enables memory tagging
> for a VM. This will expose the feature to the guest and automatically
> tag memory pages touched by the VM as PG_mte_tagged (and clear the tag
> storage) to ensure that the guest cannot see stale tags, and so that
> the tags are correctly saved/restored across swap.
>
> Actually exposing the new capability to user space happens in a later
> patch.
>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
>  arch/arm64/include/asm/kvm_emulate.h |  3 ++
>  arch/arm64/include/asm/kvm_host.h    |  3 ++
>  arch/arm64/kvm/hyp/exception.c       |  3 +-
>  arch/arm64/kvm/mmu.c                 | 64 +++++++++++++++++++++++++++-
>  arch/arm64/kvm/sys_regs.c            |  7 +++
>  include/uapi/linux/kvm.h             |  1 +
>  6 files changed, 79 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
> index 01b9857757f2..fd418955e31e 100644
> --- a/arch/arm64/include/asm/kvm_emulate.h
> +++ b/arch/arm64/include/asm/kvm_emulate.h
> @@ -84,6 +84,9 @@ static inline void vcpu_reset_hcr(struct kvm_vcpu *vcpu)
>         if (cpus_have_const_cap(ARM64_MISMATCHED_CACHE_TYPE) ||
>             vcpu_el1_is_32bit(vcpu))
>                 vcpu->arch.hcr_el2 |= HCR_TID2;
> +
> +       if (kvm_has_mte(vcpu->kvm))
> +               vcpu->arch.hcr_el2 |= HCR_ATA;
>  }
>
>  static inline unsigned long *vcpu_hcr(struct kvm_vcpu *vcpu)
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 7cd7d5c8c4bc..afaa5333f0e4 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -132,6 +132,8 @@ struct kvm_arch {
>
>         u8 pfr0_csv2;
>         u8 pfr0_csv3;
> +       /* Memory Tagging Extension enabled for the guest */
> +       bool mte_enabled;
>  };

nit: newline before the comment/new member

>
>  struct kvm_vcpu_fault_info {
> @@ -769,6 +771,7 @@ bool kvm_arm_vcpu_is_finalized(struct kvm_vcpu *vcpu);
>  #define kvm_arm_vcpu_sve_finalized(vcpu) \
>         ((vcpu)->arch.flags & KVM_ARM64_VCPU_SVE_FINALIZED)
>
> +#define kvm_has_mte(kvm) (system_supports_mte() && (kvm)->arch.mte_enabled)
>  #define kvm_vcpu_has_pmu(vcpu)                                 \
>         (test_bit(KVM_ARM_VCPU_PMU_V3, (vcpu)->arch.features))
>
> diff --git a/arch/arm64/kvm/hyp/exception.c b/arch/arm64/kvm/hyp/exception.c
> index 11541b94b328..0418399e0a20 100644
> --- a/arch/arm64/kvm/hyp/exception.c
> +++ b/arch/arm64/kvm/hyp/exception.c
> @@ -112,7 +112,8 @@ static void enter_exception64(struct kvm_vcpu *vcpu, unsigned long target_mode,
>         new |= (old & PSR_C_BIT);
>         new |= (old & PSR_V_BIT);
>
> -       // TODO: TCO (if/when ARMv8.5-MemTag is exposed to guests)
> +       if (kvm_has_mte(vcpu->kvm))
> +               new |= PSR_TCO_BIT;
>
>         new |= (old & PSR_DIT_BIT);
>
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index c10207fed2f3..52326b739357 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -822,6 +822,45 @@ transparent_hugepage_adjust(struct kvm_memory_slot *memslot,
>         return PAGE_SIZE;
>  }
>
> +/*
> + * The page will be mapped in stage 2 as Normal Cacheable, so the VM will be
> + * able to see the page's tags and therefore they must be initialised first. If
> + * PG_mte_tagged is set, tags have already been initialised.
> + *
> + * The race in the test/set of the PG_mte_tagged flag is handled by:
> + * - preventing VM_SHARED mappings in a memslot with MTE preventing two VMs
> + *   racing to santise the same page
> + * - mmap_lock protects between a VM faulting a page in and the VMM performing
> + *   an mprotect() to add VM_MTE
> + */
> +static int sanitise_mte_tags(struct kvm *kvm, kvm_pfn_t pfn,
> +                            unsigned long size)
> +{
> +       unsigned long i, nr_pages = size >> PAGE_SHIFT;
> +       struct page *page;
> +
> +       if (!kvm_has_mte(kvm))
> +               return 0;
> +
> +       /*
> +        * pfn_to_online_page() is used to reject ZONE_DEVICE pages
> +        * that may not support tags.
> +        */
> +       page = pfn_to_online_page(pfn);
> +
> +       if (!page)
> +               return -EFAULT;
> +
> +       for (i = 0; i < nr_pages; i++, page++) {
> +               if (!test_bit(PG_mte_tagged, &page->flags)) {
> +                       mte_clear_page_tags(page_address(page));
> +                       set_bit(PG_mte_tagged, &page->flags);
> +               }
> +       }
> +
> +       return 0;
> +}
> +
>  static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>                           struct kvm_memory_slot *memslot, unsigned long hva,
>                           unsigned long fault_status)
> @@ -971,8 +1010,18 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>         if (writable)
>                 prot |= KVM_PGTABLE_PROT_W;
>
> -       if (fault_status != FSC_PERM && !device)
> +       if (fault_status != FSC_PERM && !device) {
> +               /* Check the VMM hasn't introduced a new VM_SHARED VMA */
> +               if (kvm_has_mte(kvm) && vma->vm_flags & VM_SHARED) {
> +                       ret = -EFAULT;
> +                       goto out_unlock;
> +               }
> +               ret = sanitise_mte_tags(kvm, pfn, vma_pagesize);
> +               if (ret)
> +                       goto out_unlock;
> +

nit: Would it make sense to bring in sanitise_mte_tags under the
kvm_has_mte. I know that a check is done in kvm_has_mte as well, but
since you're already checking, it might make the code a bit clearer.

>                 clean_dcache_guest_page(pfn, vma_pagesize);
> +       }
>
>         if (exec_fault) {
>                 prot |= KVM_PGTABLE_PROT_X;
> @@ -1168,12 +1217,17 @@ bool kvm_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range)
>  bool kvm_set_spte_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
>  {
>         kvm_pfn_t pfn = pte_pfn(range->pte);
> +       int ret;
>
>         if (!kvm->arch.mmu.pgt)
>                 return false;
>
>         WARN_ON(range->end - range->start != 1);
>
> +       ret = sanitise_mte_tags(kvm, pfn, PAGE_SIZE);
> +       if (ret)
> +               return false;
> +
>         /*
>          * We've moved a page around, probably through CoW, so let's treat it
>          * just like a translation fault and clean the cache to the PoC.
> @@ -1381,6 +1435,14 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
>                 if (!vma)
>                         break;
>
> +               /*
> +                * VM_SHARED mappings are not allowed with MTE to avoid races
> +                * when updating the PG_mte_tagged page flag, see
> +                * sanitise_mte_tags for more details.
> +                */
> +               if (kvm_has_mte(kvm) && vma->vm_flags & VM_SHARED)
> +                       return -EINVAL;
> +
>                 /*
>                  * Take the intersection of this VMA with the memory region
>                  */
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 1a7968ad078c..36f67f8deae1 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -1047,6 +1047,13 @@ static u64 read_id_reg(const struct kvm_vcpu *vcpu,
>                 break;
>         case SYS_ID_AA64PFR1_EL1:
>                 val &= ~FEATURE(ID_AA64PFR1_MTE);
> +               if (kvm_has_mte(vcpu->kvm)) {
> +                       u64 pfr, mte;
> +
> +                       pfr = read_sanitised_ftr_reg(SYS_ID_AA64PFR1_EL1);

nit: why reread the sanitized register? wouldn't it be clearer to
rework the masking of the val and the check for kvm_has_mte?

Cheers,
/fuad



> +                       mte = cpuid_feature_extract_unsigned_field(pfr, ID_AA64PFR1_MTE_SHIFT);
> +                       val |= FIELD_PREP(FEATURE(ID_AA64PFR1_MTE), mte);
> +               }
>                 break;
>         case SYS_ID_AA64ISAR1_EL1:
>                 if (!vcpu_has_ptrauth(vcpu))
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 79d9c44d1ad7..d4da58ddcad7 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -1083,6 +1083,7 @@ struct kvm_ppc_resize_hpt {
>  #define KVM_CAP_SGX_ATTRIBUTE 196
>  #define KVM_CAP_VM_COPY_ENC_CONTEXT_FROM 197
>  #define KVM_CAP_PTP_KVM 198
> +#define KVM_CAP_ARM_MTE 199
>
>  #ifdef KVM_CAP_IRQ_ROUTING
>
> --
> 2.20.1
>
> _______________________________________________
> kvmarm mailing list
> kvmarm@lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
