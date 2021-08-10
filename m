Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D20393E527E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 06:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236956AbhHJE5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 00:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236942AbhHJE5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 00:57:49 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08BCAC0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 21:57:28 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id r16-20020a0568304190b02904f26cead745so20343441otu.10
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 21:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rVo6ZQuC84j17R2aTBYBkB+HNRftpnKp0JVkBVBb+Xo=;
        b=tWwOQaCGeIhZEXalvrP8HHqUNQA7VeVYHyJdvmsOYLUjqOXyTpN1ag9+s50Z49HT1t
         5TSSKXW6E9QWVKJGZLcv0+h6jmARLq+oQUTnarMT2np609QOaWwUBvEqIAZO/CLVpLuf
         CkOyqb3YY9qFPExPbXjIPRQCQq+m1lXeRO1yY63bHghiFWk899JO1LD7MVAKCoWd6+gS
         Y8QHYxbMmdjIK16lruHAgnhDYgHd6Aj0Ip4PsPmNBoDY+NayNNUjv2LEZatnwxos2v4b
         bMAKuQZ4P2vRkmN2AMC2sggG+VMNeZECBNIXqWOgfDpGSBpYIuoaOYggYTYQQADQec9w
         +8SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rVo6ZQuC84j17R2aTBYBkB+HNRftpnKp0JVkBVBb+Xo=;
        b=hAusHUvzU6Oj7rSeUyRzgdaHkP72L0Olc9ixpt33xDFbHLMEv5W39CdGRI26IY3Kui
         x8rP0dUxImeqEnSq4EzzezxFv8bFKLOtLJQY3s9ZfRx2sNDEVy/ONViDeAhbegIs7lKn
         Y7B5ym/Hi9V1w8MJSeNYqXrXiL28Fo5ZS5at7tS9juTj2hmmQvYGss1SXXVT0NmPdl09
         YndPI0VDonPjEO82bbag3Eg+nwYZwP3GqtasVGvXSTludIU+ETv5yJlzFE1HLwvakMjQ
         aTDSz0x6EWSghyK4Qq5HAMlODkLj5C4sJkpeWgHqY9zKuMflrAOfe+fMu8s8ojkuOzM8
         MMpA==
X-Gm-Message-State: AOAM531EfVVOf+7snow8PLluvBIn/6Hy28C1YiQhtBEKpYttd3IwML2n
        wPjU9tG2UTc/8xPgAJJGM882BLYV9sxghKxDwsQy7Q==
X-Google-Smtp-Source: ABdhPJxvMM/sO0bA73bPjTe9IGxtJ/FmOSrcFeKX+ao6BaoN6NuD2s6Ca2nNmbdJHjaVARDvNLL+9vQBw5MoRxiMgTI=
X-Received: by 2002:a05:6830:1095:: with SMTP id y21mr9482008oto.144.1628571447257;
 Mon, 09 Aug 2021 21:57:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210809152448.1810400-1-qperret@google.com> <20210809152448.1810400-12-qperret@google.com>
In-Reply-To: <20210809152448.1810400-12-qperret@google.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Tue, 10 Aug 2021 06:56:51 +0200
Message-ID: <CA+EHjTxu57SbJdp45k7Rnp14pSaakg7L9eYOtCr1ohXnj19JGw@mail.gmail.com>
Subject: Re: [PATCH v4 11/21] KVM: arm64: Allow populating software bits
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
> Introduce infrastructure allowing to manipulate software bits in stage-1
> and stage-2 page-tables using additional entries in the kvm_pgtable_prot
> enum.
>
> This is heavily inspired by Marc's implementation of a similar feature
> in the NV patch series, but adapted to allow stage-1 changes as well:
>
>   https://lore.kernel.org/kvmarm/20210510165920.1913477-56-maz@kernel.org/
>
> Suggested-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---

Reviewed-by: Fuad Tabba <tabba@google.com>

Thanks,
/fuad

>  arch/arm64/include/asm/kvm_pgtable.h | 12 +++++++++++-
>  arch/arm64/kvm/hyp/pgtable.c         |  5 +++++
>  2 files changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
> index 2c090b0eee77..ff9d52f8073a 100644
> --- a/arch/arm64/include/asm/kvm_pgtable.h
> +++ b/arch/arm64/include/asm/kvm_pgtable.h
> @@ -121,6 +121,10 @@ enum kvm_pgtable_stage2_flags {
>   * @KVM_PGTABLE_PROT_W:                Write permission.
>   * @KVM_PGTABLE_PROT_R:                Read permission.
>   * @KVM_PGTABLE_PROT_DEVICE:   Device attributes.
> + * @KVM_PGTABLE_PROT_SW0:      Software bit 0.
> + * @KVM_PGTABLE_PROT_SW1:      Software bit 1.
> + * @KVM_PGTABLE_PROT_SW2:      Software bit 2.
> + * @KVM_PGTABLE_PROT_SW3:      Software bit 3.
>   */
>  enum kvm_pgtable_prot {
>         KVM_PGTABLE_PROT_X                      = BIT(0),
> @@ -128,6 +132,11 @@ enum kvm_pgtable_prot {
>         KVM_PGTABLE_PROT_R                      = BIT(2),
>
>         KVM_PGTABLE_PROT_DEVICE                 = BIT(3),
> +
> +       KVM_PGTABLE_PROT_SW0                    = BIT(55),
> +       KVM_PGTABLE_PROT_SW1                    = BIT(56),
> +       KVM_PGTABLE_PROT_SW2                    = BIT(57),
> +       KVM_PGTABLE_PROT_SW3                    = BIT(58),
>  };
>
>  #define KVM_PGTABLE_PROT_RW    (KVM_PGTABLE_PROT_R | KVM_PGTABLE_PROT_W)
> @@ -420,7 +429,8 @@ kvm_pte_t kvm_pgtable_stage2_mkold(struct kvm_pgtable *pgt, u64 addr);
>   * If there is a valid, leaf page-table entry used to translate @addr, then
>   * relax the permissions in that entry according to the read, write and
>   * execute permissions specified by @prot. No permissions are removed, and
> - * TLB invalidation is performed after updating the entry.
> + * TLB invalidation is performed after updating the entry. Software bits cannot
> + * be set or cleared using kvm_pgtable_stage2_relax_perms().
>   *
>   * Return: 0 on success, negative error code on failure.
>   */
> diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
> index e25d829587b9..cff744136044 100644
> --- a/arch/arm64/kvm/hyp/pgtable.c
> +++ b/arch/arm64/kvm/hyp/pgtable.c
> @@ -357,6 +357,7 @@ static int hyp_set_prot_attr(enum kvm_pgtable_prot prot, kvm_pte_t *ptep)
>         attr |= FIELD_PREP(KVM_PTE_LEAF_ATTR_LO_S1_AP, ap);
>         attr |= FIELD_PREP(KVM_PTE_LEAF_ATTR_LO_S1_SH, sh);
>         attr |= KVM_PTE_LEAF_ATTR_LO_S1_AF;
> +       attr |= prot & KVM_PTE_LEAF_ATTR_HI_SW;
>         *ptep = attr;
>
>         return 0;
> @@ -558,6 +559,7 @@ static int stage2_set_prot_attr(struct kvm_pgtable *pgt, enum kvm_pgtable_prot p
>
>         attr |= FIELD_PREP(KVM_PTE_LEAF_ATTR_LO_S2_SH, sh);
>         attr |= KVM_PTE_LEAF_ATTR_LO_S2_AF;
> +       attr |= prot & KVM_PTE_LEAF_ATTR_HI_SW;
>         *ptep = attr;
>
>         return 0;
> @@ -1025,6 +1027,9 @@ int kvm_pgtable_stage2_relax_perms(struct kvm_pgtable *pgt, u64 addr,
>         u32 level;
>         kvm_pte_t set = 0, clr = 0;
>
> +       if (prot & KVM_PTE_LEAF_ATTR_HI_SW)
> +               return -EINVAL;
> +
>         if (prot & KVM_PGTABLE_PROT_R)
>                 set |= KVM_PTE_LEAF_ATTR_LO_S2_S2AP_R;
>
> --
> 2.32.0.605.g8dce9f2422-goog
>
