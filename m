Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0684A3E5253
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 06:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237160AbhHJEjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 00:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237046AbhHJEja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 00:39:30 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10707C0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 21:39:09 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id r16-20020a0568304190b02904f26cead745so20303840otu.10
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 21:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UMFQDtJfJF2Z8IAcGX8deSauImQlRu6R2zUBaKg66SA=;
        b=uJUvnv9Oa0JSABisOkmc0JRxljR5Q0vxiz6uz6OXOs86o2qR7n0ZqyJWwjWimiKr+A
         tZHzy8oOwrvz906N5j9vfQr/ZoEX7M/NfFMB1gAPlGGAUrLI3oflIVG2KqbaqaxirAdI
         UAqcpepluxv/L2G6zLmPCSdoj0tqhFbLJra790uZ50D4Lxv11y7Wmw5usBPtOBPeASmB
         Gm4jh1Dc5D6A4oN+mR4BCXxzfwfV/8XZOe9/z8jNAWQDO2+9E/OcGZ4iws4hlECSA4HZ
         a0fVANXJHO/mnDkt0OpRRr9sXIczLflr1G/uJPiVPPDNUOnIcn6JQht945WV5Y+PiQxi
         NQDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UMFQDtJfJF2Z8IAcGX8deSauImQlRu6R2zUBaKg66SA=;
        b=ONGOSErhAoXsbKKXav8wxVGtCjcUmMWUDkt2xzGsHmPNtO+RnX27p3spp0nbDKtXKo
         nO7K4hrz4rfqdIPt0wWWYUGByhRroYTUMX1WDHnJgTq5LWqqdx4JHS6q3pxEL6gM0A6h
         fWaLOXFinjCDtTUa1Bsq7QYVOvytLzk5y6av5zHj7JhPTMLOoMxkyxxwh189bn3gP+UN
         RM6ojMJYmjRyM+tELyBJzvDys0Xs3QBYWzXN9iM87PLl0RpErMwb3g1DLDEsnvMq4atG
         iNR14ziawXw5CtV7w/Cj+c9KLcIVyPUJAHIgDe9XEQrw5qbaXZjlsBf0K6sRdGaq+d+5
         XfZg==
X-Gm-Message-State: AOAM530FRaug5bsq4j8TYImiC6N02eFpLBsceE+apbgJX+ZD5jUQkS1t
        uz/q1L5yRnUJ+VuEnWJIIYj+rY+5lM1gSOwarPpPJA==
X-Google-Smtp-Source: ABdhPJyvS+1AkGsFP795ybM9ve5pjpgbh+8MfOJDVjge/he7hS4eAwhQnNLI3hx8Ydr4zJzaZPT0XAoiSitu2dAt6Ao=
X-Received: by 2002:a9d:2609:: with SMTP id a9mr3296708otb.365.1628570348246;
 Mon, 09 Aug 2021 21:39:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210809152448.1810400-1-qperret@google.com> <20210809152448.1810400-17-qperret@google.com>
In-Reply-To: <20210809152448.1810400-17-qperret@google.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Tue, 10 Aug 2021 06:38:32 +0200
Message-ID: <CA+EHjTyRKnAhE3joW_VNOL51qJToaR=20KhkKXm98bpvymBX6g@mail.gmail.com>
Subject: Re: [PATCH v4 16/21] KVM: arm64: Enable retrieving protections
 attributes of PTEs
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
> Introduce helper functions in the KVM stage-2 and stage-1 page-table
> manipulation library allowing to retrieve the enum kvm_pgtable_prot of a
> PTE. This will be useful to implement custom walkers outside of
> pgtable.c.
>
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---

Reviewed-by: Fuad Tabba <tabba@google.com>

Thanks,
/fuad

>  arch/arm64/include/asm/kvm_pgtable.h | 20 +++++++++++++++
>  arch/arm64/kvm/hyp/pgtable.c         | 37 ++++++++++++++++++++++++++++
>  2 files changed, 57 insertions(+)
>
> diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
> index ff9d52f8073a..f1651e0153ad 100644
> --- a/arch/arm64/include/asm/kvm_pgtable.h
> +++ b/arch/arm64/include/asm/kvm_pgtable.h
> @@ -506,4 +506,24 @@ int kvm_pgtable_walk(struct kvm_pgtable *pgt, u64 addr, u64 size,
>   */
>  int kvm_pgtable_get_leaf(struct kvm_pgtable *pgt, u64 addr,
>                          kvm_pte_t *ptep, u32 *level);
> +
> +/**
> + * kvm_pgtable_stage2_pte_prot() - Retrieve the protection attributes of a
> + *                                stage-2 Page-Table Entry.
> + * @pte:       Page-table entry
> + *
> + * Return: protection attributes of the page-table entry in the enum
> + *        kvm_pgtable_prot format.
> + */
> +enum kvm_pgtable_prot kvm_pgtable_stage2_pte_prot(kvm_pte_t pte);
> +
> +/**
> + * kvm_pgtable_hyp_pte_prot() - Retrieve the protection attributes of a stage-1
> + *                             Page-Table Entry.
> + * @pte:       Page-table entry
> + *
> + * Return: protection attributes of the page-table entry in the enum
> + *        kvm_pgtable_prot format.
> + */
> +enum kvm_pgtable_prot kvm_pgtable_hyp_pte_prot(kvm_pte_t pte);
>  #endif /* __ARM64_KVM_PGTABLE_H__ */
> diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
> index cff744136044..f8ceebe4982e 100644
> --- a/arch/arm64/kvm/hyp/pgtable.c
> +++ b/arch/arm64/kvm/hyp/pgtable.c
> @@ -363,6 +363,26 @@ static int hyp_set_prot_attr(enum kvm_pgtable_prot prot, kvm_pte_t *ptep)
>         return 0;
>  }
>
> +enum kvm_pgtable_prot kvm_pgtable_hyp_pte_prot(kvm_pte_t pte)
> +{
> +       enum kvm_pgtable_prot prot = pte & KVM_PTE_LEAF_ATTR_HI_SW;
> +       u32 ap;
> +
> +       if (!kvm_pte_valid(pte))
> +               return prot;
> +
> +       if (!(pte & KVM_PTE_LEAF_ATTR_HI_S1_XN))
> +               prot |= KVM_PGTABLE_PROT_X;
> +
> +       ap = FIELD_GET(KVM_PTE_LEAF_ATTR_LO_S1_AP, pte);
> +       if (ap == KVM_PTE_LEAF_ATTR_LO_S1_AP_RO)
> +               prot |= KVM_PGTABLE_PROT_R;
> +       else if (ap == KVM_PTE_LEAF_ATTR_LO_S1_AP_RW)
> +               prot |= KVM_PGTABLE_PROT_RW;
> +
> +       return prot;
> +}
> +
>  static bool hyp_pte_needs_update(kvm_pte_t old, kvm_pte_t new)
>  {
>         /*
> @@ -565,6 +585,23 @@ static int stage2_set_prot_attr(struct kvm_pgtable *pgt, enum kvm_pgtable_prot p
>         return 0;
>  }
>
> +enum kvm_pgtable_prot kvm_pgtable_stage2_pte_prot(kvm_pte_t pte)
> +{
> +       enum kvm_pgtable_prot prot = pte & KVM_PTE_LEAF_ATTR_HI_SW;
> +
> +       if (!kvm_pte_valid(pte))
> +               return prot;
> +
> +       if (pte & KVM_PTE_LEAF_ATTR_LO_S2_S2AP_R)
> +               prot |= KVM_PGTABLE_PROT_R;
> +       if (pte & KVM_PTE_LEAF_ATTR_LO_S2_S2AP_W)
> +               prot |= KVM_PGTABLE_PROT_W;
> +       if (!(pte & KVM_PTE_LEAF_ATTR_HI_S2_XN))
> +               prot |= KVM_PGTABLE_PROT_X;
> +
> +       return prot;
> +}
> +
>  static bool stage2_pte_needs_update(kvm_pte_t old, kvm_pte_t new)
>  {
>         if (!kvm_pte_valid(old) || !kvm_pte_valid(new))
> --
> 2.32.0.605.g8dce9f2422-goog
>
