Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 805573E527C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 06:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236911AbhHJE5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 00:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233230AbhHJE5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 00:57:11 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CBD8C0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 21:56:49 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id e13-20020a9d63cd0000b02904fa42f9d275so9829690otl.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 21:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mxeliMxH5RLFkPOnb9VsFpY7z4s/EY26/y2zKcYFTKM=;
        b=bVgvBw5b7c+dnqH9Mqa8QCUVGtdlkSzsJdLu8tgceEC8aichoBtE9PmOu7p2DgHM/b
         Kg3vuLFLb8vLj2+1Uy5FN/4DASs1PxiRhu3EwFF/6FQDKASEhmcdz9yTTSGvH4NbmizX
         pVd6NBGKtdNZbROLtLmKdHU7uYasf6BWB0RZf85go1IgfV3Od2wkYyFTGOHg5RvSNmDs
         ABT95AgjkumKr5rgI78ZQr7ONkZwHeX5V5aUn4IV+ZmzafkNsOszHE4lgKZRsySe5qqP
         Vx8zx5mPT6nLUfgEGyNsDWQcWtkgpaLTePlxsMAIS++oDe/4mutz19DbGmQLmhn22LYb
         qdmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mxeliMxH5RLFkPOnb9VsFpY7z4s/EY26/y2zKcYFTKM=;
        b=mLJWUws8wmRk5WrE8Zw0ZRgt0Za3Xa/lCfcqgYH2JBjbSSlF0pJYyT0iBSc1xdkjci
         ph2SRVxv80AC7USNTWE5xtywfIzihmK+zRVr5K7MaUkxNdkzsiBvi1P67NW5PLw9OJz8
         dM0ZUC8ZMj/TCLag2uCT7kvfNSBmP6mYHTv8ibFasjJf9MhaY/RoNSF29Ht5Nq9vITaA
         oIYnvj4UYJvFYL/nFfDzYN880VgfC0EXAJUMKmxlR9GVEqz4ctIfsCbnC18dBLra6u0p
         Bpt0qrwLdKYakv8PXr56uLRf1a9b+EYgRWihAhROJlS0nCzuEtT00F78Lnx1B60LPWor
         kGFg==
X-Gm-Message-State: AOAM533viLYrusAxVm+RtHXBqxu8QrQ0N7HtLwquxVdkfOk2ioA4V3M8
        4+YMckHk+NfLf6jwu7frOBDz10fHhX2T+N+RNO82PQ==
X-Google-Smtp-Source: ABdhPJxj6p0KnGyA4aW6SVCeVdmvEmXsuvlbMJKaWVWtf3r2Eo7FyUh+gAsfwiu9BiPHdssNSgxFG1JxZLzy2B1wzSc=
X-Received: by 2002:a9d:7359:: with SMTP id l25mr1020479otk.52.1628571408731;
 Mon, 09 Aug 2021 21:56:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210809152448.1810400-1-qperret@google.com> <20210809152448.1810400-6-qperret@google.com>
In-Reply-To: <20210809152448.1810400-6-qperret@google.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Tue, 10 Aug 2021 06:56:12 +0200
Message-ID: <CA+EHjTzu=_-ZBZYUWiz7T328UYsNsHEfAqxnSRvO5s52t-g2Bw@mail.gmail.com>
Subject: Re: [PATCH v4 05/21] KVM: arm64: Expose page-table helpers
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
> The KVM pgtable API exposes the kvm_pgtable_walk() function to allow
> the definition of walkers outside of pgtable.c. However, it is not easy
> to implement any of those walkers without some of the low-level helpers.
> Move some of them to the header file to allow re-use from other places.
>
> Signed-off-by: Quentin Perret <qperret@google.com>

Reviewed-by: Fuad Tabba <tabba@google.com>

Thanks,
/fuad

> ---
>  arch/arm64/include/asm/kvm_pgtable.h | 40 ++++++++++++++++++++++++++++
>  arch/arm64/kvm/hyp/pgtable.c         | 39 ---------------------------
>  2 files changed, 40 insertions(+), 39 deletions(-)
>
> diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
> index 082b9d65f40b..6938eac72c1f 100644
> --- a/arch/arm64/include/asm/kvm_pgtable.h
> +++ b/arch/arm64/include/asm/kvm_pgtable.h
> @@ -25,6 +25,46 @@ static inline u64 kvm_get_parange(u64 mmfr0)
>
>  typedef u64 kvm_pte_t;
>
> +#define KVM_PTE_VALID                  BIT(0)
> +
> +#define KVM_PTE_ADDR_MASK              GENMASK(47, PAGE_SHIFT)
> +#define KVM_PTE_ADDR_51_48             GENMASK(15, 12)
> +
> +static inline bool kvm_pte_valid(kvm_pte_t pte)
> +{
> +       return pte & KVM_PTE_VALID;
> +}
> +
> +static inline u64 kvm_pte_to_phys(kvm_pte_t pte)
> +{
> +       u64 pa = pte & KVM_PTE_ADDR_MASK;
> +
> +       if (PAGE_SHIFT == 16)
> +               pa |= FIELD_GET(KVM_PTE_ADDR_51_48, pte) << 48;
> +
> +       return pa;
> +}
> +
> +static inline u64 kvm_granule_shift(u32 level)
> +{
> +       /* Assumes KVM_PGTABLE_MAX_LEVELS is 4 */
> +       return ARM64_HW_PGTABLE_LEVEL_SHIFT(level);
> +}
> +
> +static inline u64 kvm_granule_size(u32 level)
> +{
> +       return BIT(kvm_granule_shift(level));
> +}
> +
> +static inline bool kvm_level_supports_block_mapping(u32 level)
> +{
> +       /*
> +        * Reject invalid block mappings and don't bother with 4TB mappings for
> +        * 52-bit PAs.
> +        */
> +       return !(level == 0 || (PAGE_SIZE != SZ_4K && level == 1));
> +}
> +
>  /**
>   * struct kvm_pgtable_mm_ops - Memory management callbacks.
>   * @zalloc_page:               Allocate a single zeroed memory page.
> diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
> index 78f36bd5df6c..49d768b92997 100644
> --- a/arch/arm64/kvm/hyp/pgtable.c
> +++ b/arch/arm64/kvm/hyp/pgtable.c
> @@ -11,16 +11,12 @@
>  #include <asm/kvm_pgtable.h>
>  #include <asm/stage2_pgtable.h>
>
> -#define KVM_PTE_VALID                  BIT(0)
>
>  #define KVM_PTE_TYPE                   BIT(1)
>  #define KVM_PTE_TYPE_BLOCK             0
>  #define KVM_PTE_TYPE_PAGE              1
>  #define KVM_PTE_TYPE_TABLE             1
>
> -#define KVM_PTE_ADDR_MASK              GENMASK(47, PAGE_SHIFT)
> -#define KVM_PTE_ADDR_51_48             GENMASK(15, 12)
> -
>  #define KVM_PTE_LEAF_ATTR_LO           GENMASK(11, 2)
>
>  #define KVM_PTE_LEAF_ATTR_LO_S1_ATTRIDX        GENMASK(4, 2)
> @@ -61,17 +57,6 @@ struct kvm_pgtable_walk_data {
>         u64                             end;
>  };
>
> -static u64 kvm_granule_shift(u32 level)
> -{
> -       /* Assumes KVM_PGTABLE_MAX_LEVELS is 4 */
> -       return ARM64_HW_PGTABLE_LEVEL_SHIFT(level);
> -}
> -
> -static u64 kvm_granule_size(u32 level)
> -{
> -       return BIT(kvm_granule_shift(level));
> -}
> -
>  #define KVM_PHYS_INVALID (-1ULL)
>
>  static bool kvm_phys_is_valid(u64 phys)
> @@ -79,15 +64,6 @@ static bool kvm_phys_is_valid(u64 phys)
>         return phys < BIT(id_aa64mmfr0_parange_to_phys_shift(ID_AA64MMFR0_PARANGE_MAX));
>  }
>
> -static bool kvm_level_supports_block_mapping(u32 level)
> -{
> -       /*
> -        * Reject invalid block mappings and don't bother with 4TB mappings for
> -        * 52-bit PAs.
> -        */
> -       return !(level == 0 || (PAGE_SIZE != SZ_4K && level == 1));
> -}
> -
>  static bool kvm_block_mapping_supported(u64 addr, u64 end, u64 phys, u32 level)
>  {
>         u64 granule = kvm_granule_size(level);
> @@ -135,11 +111,6 @@ static u32 kvm_pgd_pages(u32 ia_bits, u32 start_level)
>         return __kvm_pgd_page_idx(&pgt, -1ULL) + 1;
>  }
>
> -static bool kvm_pte_valid(kvm_pte_t pte)
> -{
> -       return pte & KVM_PTE_VALID;
> -}
> -
>  static bool kvm_pte_table(kvm_pte_t pte, u32 level)
>  {
>         if (level == KVM_PGTABLE_MAX_LEVELS - 1)
> @@ -151,16 +122,6 @@ static bool kvm_pte_table(kvm_pte_t pte, u32 level)
>         return FIELD_GET(KVM_PTE_TYPE, pte) == KVM_PTE_TYPE_TABLE;
>  }
>
> -static u64 kvm_pte_to_phys(kvm_pte_t pte)
> -{
> -       u64 pa = pte & KVM_PTE_ADDR_MASK;
> -
> -       if (PAGE_SHIFT == 16)
> -               pa |= FIELD_GET(KVM_PTE_ADDR_51_48, pte) << 48;
> -
> -       return pa;
> -}
> -
>  static kvm_pte_t kvm_phys_to_pte(u64 pa)
>  {
>         kvm_pte_t pte = pa & KVM_PTE_ADDR_MASK;
> --
> 2.32.0.605.g8dce9f2422-goog
>
