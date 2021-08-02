Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC5963DDB96
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 16:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234624AbhHBOxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 10:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234456AbhHBOxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 10:53:36 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4687DC0613D5
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 07:53:27 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id gs8so31255276ejc.13
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 07:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E6FWmVZfDjLa3Evt0Fn+50V6XguYMilIcMj6+S8hDhM=;
        b=oqcZv0fOKw49s1dfDkn3QFtKKh7kUyBUbZ8eUoFgJ8Wew0rRh0D53TByBe7u1Ny/Tj
         rb3WFV1VdhGjk1pcruAVZ06h17QB8sUxhevCi8xak9Z0Ap0gUaM19wLcNfV3aj1tT4ls
         dmbSsjIPjjl1kvegq73ZdqYxSiXVKOjJaFAc+SPfwWX5Oqh81C38ksHRFoV44ner6ZNI
         eQLlk7/f0CdxexEgNQJEsQIgc/GEoN4UrvzsjQi4CqiQo/X0mQDk1xSmt/6bPj/UXoJ8
         dZhPBljGPMHWCY+wJVDL7dAnrjNFKP6Sm682gzLvtxgaXxjHJ1sETrB/tRrSQlnnrfqV
         KO1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E6FWmVZfDjLa3Evt0Fn+50V6XguYMilIcMj6+S8hDhM=;
        b=pL7SP+BHY+zzmrwIwcAp5gQc2wNmwHxxYxfyeBnc4nThaQZq7xnQ09k9ejtsI/wjYG
         wuhEmkUY6lYAD12qFr8U5ULBUdnbuAjFMxy21JrBLFTQEc0rownxdHFhIIyLvALSx+0T
         LnCJJE0t6RPdeGtSO/jLO1J9kHMyMxpBVv9bvE46qfcVKpTxkUJz/nEa+zvD2x5gq+WM
         AauE/ez9inMJwYTWu9xmMoPbanTO0M7cAeASlWml5ucUX5DUftMUsRh/PXcbZLSvJLz1
         ATX12tqRKpYW7CNzmeEHorXo0706zcquZRS/iSHbdRrXOEcNH96LMnzlhIcHIrl4/kzI
         91JQ==
X-Gm-Message-State: AOAM5309kJs/6b5uBXvWBlwMdKN+/DtDN7eav4Zn5EDDnIfW6Dg2OWHh
        UbbLuqP33x3uFSJb3dWJe9+Ubqr8oD1/h3jdYKUDrA==
X-Google-Smtp-Source: ABdhPJwPorqtqpze/8XQ3IeLdPsZ4jw4SoXKq7dwTegBWGeXoiFEXZRNPE+1Z17aC6tvi1oLm0ZA4BY5mG/BOH9M7fQ=
X-Received: by 2002:a17:906:cd1a:: with SMTP id oz26mr15845091ejb.101.1627916005678;
 Mon, 02 Aug 2021 07:53:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210729132818.4091769-1-qperret@google.com> <20210729132818.4091769-17-qperret@google.com>
In-Reply-To: <20210729132818.4091769-17-qperret@google.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Mon, 2 Aug 2021 16:52:49 +0200
Message-ID: <CA+EHjTwL+grX__03SfeDdxeppjSovEZhKRvqjmA_4kSBwsjswg@mail.gmail.com>
Subject: Re: [PATCH v3 16/21] KVM: arm64: Enable retrieving protections
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

On Thu, Jul 29, 2021 at 3:29 PM Quentin Perret <qperret@google.com> wrote:
>
> Introduce helper functions in the KVM stage-2 and stage-1 page-table
> manipulation library allowing to retrieve the enum kvm_pgtable_prot of a
> PTE. This will be useful to implement custom walkers outside of
> pgtable.c.
>
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/include/asm/kvm_pgtable.h | 20 +++++++++++++++
>  arch/arm64/kvm/hyp/pgtable.c         | 37 ++++++++++++++++++++++++++++
>  2 files changed, 57 insertions(+)
>
> diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
> index d5ca9b6ce241..7ff9f52239ba 100644
> --- a/arch/arm64/include/asm/kvm_pgtable.h
> +++ b/arch/arm64/include/asm/kvm_pgtable.h
> @@ -505,4 +505,24 @@ int kvm_pgtable_walk(struct kvm_pgtable *pgt, u64 addr, u64 size,
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
> index 1915489bb127..a6eda8f23cb6 100644
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
> +               prot |= KVM_PGTABLE_PROT_R | KVM_PGTABLE_PROT_W;

nit: why not use the freshly minted KVM_PGTABLE_PROT_RW?

Thanks,
/fuad


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
> 2.32.0.432.gabb21c7263-goog
>
