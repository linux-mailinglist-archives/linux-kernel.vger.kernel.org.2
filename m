Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC4E33D0A9F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 10:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237121AbhGUHuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 03:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235919AbhGUHlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 03:41:01 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18BEAC061574
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 01:21:17 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id f12-20020a056830204cb029048bcf4c6bd9so1338640otp.8
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 01:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4ljbr/BjAQXHoSjfnU/poMdQSYUhBIQOTVvbtplVbjY=;
        b=maSbKwVEYZFFrT24oXzJTzTOFffLltJ2yi6OgUCQHiqvRT85jX60r2L6xt7dT0MY5R
         /fGwK9XK8BJcx5IsZrxvnVhoXBjAAz5SG2EfRDTEMXvDD28Z6wGxqmQS4hDMZnRGrmkN
         bl/nkg4ZmCQEAg87r9gh994HwjiJdxV17bIpUWA9vyfq119CW6Sa0ePvxWqdHa8SGAJX
         P25ELNgH8iHrF1XL/XmGI5I/04pPt1Ro4pb/xyUVMtmmrPFmuLWE6p2CasMElZueQDRD
         iQ10xmDmbi+QaWVpgQ2bzpEKjMk93cEH11VC1GjuehVWtk3pbPKhydBEhZw2TYUIgh4L
         tJBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4ljbr/BjAQXHoSjfnU/poMdQSYUhBIQOTVvbtplVbjY=;
        b=uhWK9L5dNmn5z4s597SKOOHV4YPf5W0vdfxssUIm5M39xtlaP8kbHOOzdjgkufWTZv
         DwuURrTyBv6+gTqQvgE4tPzeg9chGh0WGBO8cskhXbABbS6vqflulxCZyXz4G+qjPh4S
         ryN4xZQArmZ+s1Cmu/bjHHWT26ULjyPvuHyysdSNpOmv+U52yzXbkd9YwQ0eiuF16b74
         oIXkiIahXVEE5k11XgnsyXm51DLGqW8YMx24/ue9uzv+/RK7+Uvuu6DuiAd2B0azzsse
         a5NKQC5P5IsoIq55cTFkORgHfE4DG4x1yWrObWxLLyv/ZrGHhT0dwFe/UU58qCIlret2
         JgBQ==
X-Gm-Message-State: AOAM531XBZEQ06K6IsFLgTvE4JLVlzXTUXzHRUz9KyG8CJYpNhuuHZV7
        2lfUaPYfjsfQNgYrNv7DGcEz9Sg0wYQeFtUNU9dRDQ==
X-Google-Smtp-Source: ABdhPJyyehspCNVbLKAckLKJrrmnVHUkrdP6T8Euhhbd/dhCTqA37omyVRmpregC0z9MvGHlZQwyoWvs7UCHgaemIh8=
X-Received: by 2002:a9d:4b02:: with SMTP id q2mr14525860otf.52.1626855676138;
 Wed, 21 Jul 2021 01:21:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210719104735.3681732-1-qperret@google.com> <20210719104735.3681732-12-qperret@google.com>
In-Reply-To: <20210719104735.3681732-12-qperret@google.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Wed, 21 Jul 2021 09:20:39 +0100
Message-ID: <CA+EHjTwGCZY8CzM_zBQ6yWCTVu_B-GZFvvHPBUqRW-jr4LDE2A@mail.gmail.com>
Subject: Re: [PATCH 11/14] KVM: arm64: Expose kvm_pte_valid() helper
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
> The KVM pgtable API exposes the kvm_pgtable_walk() function to allow
> the definition of walkers outside of pgtable.c. However, it is not easy
> to implement any of those walkers without some of the low-level helpers,
> such as kvm_pte_valid(). Make it static inline, and move it to the
> header file to allow its re-use in other places.
>
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/include/asm/kvm_pgtable.h | 7 +++++++
>  arch/arm64/kvm/hyp/pgtable.c         | 6 ------
>  2 files changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
> index 1aa49d6aabb7..8240c881ae1e 100644
> --- a/arch/arm64/include/asm/kvm_pgtable.h
> +++ b/arch/arm64/include/asm/kvm_pgtable.h
> @@ -25,6 +25,13 @@ static inline u64 kvm_get_parange(u64 mmfr0)
>
>  typedef u64 kvm_pte_t;
>
> +#define KVM_PTE_VALID                  BIT(0)
> +

I don't know if there's a better solution for this, but having the
KVM_PTE_VALID by itself here, with the rest remaining in pgtable.c
might be confusing. I see that you probably don't want to move them
all here because they are internal to pgtable.c.

Thanks,
/fuad

> +static inline bool kvm_pte_valid(kvm_pte_t pte)
> +{
> +       return pte & KVM_PTE_VALID;
> +}
> +
>  /**
>   * struct kvm_pgtable_mm_ops - Memory management callbacks.
>   * @zalloc_page:               Allocate a single zeroed memory page.
> diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
> index c7120797404a..e0ae57dca827 100644
> --- a/arch/arm64/kvm/hyp/pgtable.c
> +++ b/arch/arm64/kvm/hyp/pgtable.c
> @@ -11,7 +11,6 @@
>  #include <asm/kvm_pgtable.h>
>  #include <asm/stage2_pgtable.h>
>
> -#define KVM_PTE_VALID                  BIT(0)
>
>  #define KVM_PTE_TYPE                   BIT(1)
>  #define KVM_PTE_TYPE_BLOCK             0
> @@ -135,11 +134,6 @@ static u32 kvm_pgd_pages(u32 ia_bits, u32 start_level)
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
> --
> 2.32.0.402.g57bb445576-goog
>
