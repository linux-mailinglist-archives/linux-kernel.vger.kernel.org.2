Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9923CFB7B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 16:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239509AbhGTNTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 09:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238928AbhGTNIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 09:08:10 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0B9C061574
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 06:48:46 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 59-20020a9d0ac10000b0290462f0ab0800so21555720otq.11
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 06:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sSKYKbxnVu+G8KsuMx0V0FlK4uTjY08r+UWrZ/z8LHQ=;
        b=utAjJcc9cGMaMXp3rIBJ1ZRTSBKvYt0c86Q62CMxLwEWhTH+xS0N+cbAwxz7Y2TFM4
         dp6GRnKGtA6N6wQuQ+FTqHC5WYixuviEtvzFioOV8p6mJoFir6Qc99xo2H87a8BznM6T
         SmXVeUKSAJ2YxDebBssr4xVaAO78BHlhlYwsMlGNwZ8wmSgRCDB9iH5Ar+9VJBzUU4ga
         7M6VNPrGVXhUCdtAr+Dmzm7WHV7bhTh/T6OMjEb6K2tww/GGztX2oZoTDDfyGdZ24ZfN
         h6PgRlr2wokfmTq8lbrr7qoeplfwRm/eGNhXml8CRF+5rGCpdRCemqSuz/HNtGv1TRK/
         8DJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sSKYKbxnVu+G8KsuMx0V0FlK4uTjY08r+UWrZ/z8LHQ=;
        b=YA5jslb8Gh/8P7BNjm9wFX76X+t79g5EHnIdrqJfk5pXJoQT8D90sZbhODpQDo/+1e
         Aza5IY5g48G1IfF60JUe8gzzL9IUxnJAaPUdMksSR4mDbfSZd9cjNpPzKm9gStsT5ZVe
         PKlHRUi7qKEM4DENet6piY2q7ic2QOwrTjlCS5klGSvZ1DdabZ710XTPMZH+ACcbK6ne
         swwOplzq+MqH6gc7WclX9QbIVXjptwc4JTjtYLPor4AqmOqr8itQaajG6CE8oG3liZgM
         AhN0BVJTQH97ztKXVDGDFTv7HzxmVQqh3Ar3adzueRl3uQw4Y4krf+U0Rv9eOMxaJpdL
         mlRg==
X-Gm-Message-State: AOAM531xoUOdSC1kLYCbKuz6frNaxLxRopcV8Q547BFxEDYHS59AWrky
        YaChYzqEqO/no8etNBwh6M98lAUrU4JTaMkykja5dg==
X-Google-Smtp-Source: ABdhPJwO2Xb6g/ZfTRHpSfHvJvHBkk79kp1jTLisPNfqjoFjNOCC/oC/AfEZFLcKbXu8Y1Xt91MqVh+c+yhVsZgW1nw=
X-Received: by 2002:a05:6830:1455:: with SMTP id w21mr22257855otp.365.1626788926039;
 Tue, 20 Jul 2021 06:48:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210719104735.3681732-1-qperret@google.com> <20210719104735.3681732-9-qperret@google.com>
In-Reply-To: <20210719104735.3681732-9-qperret@google.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Tue, 20 Jul 2021 14:48:09 +0100
Message-ID: <CA+EHjTwmmV6EooG+Ykbso3G6nkjq=sbRzXH3vetazzPF5mO02g@mail.gmail.com>
Subject: Re: [PATCH 08/14] KVM: arm64: Add support for tagging shared pages in page-table
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

On Mon, Jul 19, 2021 at 11:47 AM Quentin Perret <qperret@google.com> wrote:
>
> The hypervisor will soon be in charge of tracking ownership of all
> memory pages in the system. The current page-tracking infrastructure at
> EL2 only allows binary states: a page is either owned or not by an
> entity. But a number of use-cases will require more complex states for
> pages that are shared between two entities (host, hypervisor, or guests).
>
> In preparation for supporting these use-cases, introduce in the KVM
> page-table library some infrastructure allowing to tag shared pages
> using ignored bits (a.k.a. software bits) in PTEs.
>
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/include/asm/kvm_pgtable.h |  5 +++++
>  arch/arm64/kvm/hyp/pgtable.c         | 25 +++++++++++++++++++++++++
>  2 files changed, 30 insertions(+)
>
> diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
> index dd72653314c7..f6d3d5c8910d 100644
> --- a/arch/arm64/include/asm/kvm_pgtable.h
> +++ b/arch/arm64/include/asm/kvm_pgtable.h
> @@ -81,6 +81,8 @@ enum kvm_pgtable_stage2_flags {
>   * @KVM_PGTABLE_PROT_W:                Write permission.
>   * @KVM_PGTABLE_PROT_R:                Read permission.
>   * @KVM_PGTABLE_PROT_DEVICE:   Device attributes.
> + * @KVM_PGTABLE_STATE_SHARED:  Page shared with another entity.
> + * @KVM_PGTABLE_STATE_BORROWED:        Page borrowed from another entity.
>   */
>  enum kvm_pgtable_prot {
>         KVM_PGTABLE_PROT_X                      = BIT(0),
> @@ -88,6 +90,9 @@ enum kvm_pgtable_prot {
>         KVM_PGTABLE_PROT_R                      = BIT(2),
>
>         KVM_PGTABLE_PROT_DEVICE                 = BIT(3),
> +
> +       KVM_PGTABLE_STATE_SHARED                = BIT(4),
> +       KVM_PGTABLE_STATE_BORROWED              = BIT(5),
>  };
>
>  #define KVM_PGTABLE_PROT_RW    (KVM_PGTABLE_PROT_R | KVM_PGTABLE_PROT_W)
> diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
> index 5bdbe7a31551..51598b79dafc 100644
> --- a/arch/arm64/kvm/hyp/pgtable.c
> +++ b/arch/arm64/kvm/hyp/pgtable.c
> @@ -211,6 +211,29 @@ static kvm_pte_t kvm_init_invalid_leaf_owner(u8 owner_id)
>         return FIELD_PREP(KVM_INVALID_PTE_OWNER_MASK, owner_id);
>  }
>
> +static kvm_pte_t pte_ignored_bit_prot(enum kvm_pgtable_prot prot)
> +{
> +       kvm_pte_t ignored_bits = 0;
> +
> +       /*
> +        * Ignored bits 0 and 1 are reserved to track the memory ownership
> +        * state of each page:
> +        *   00: The page is owned solely by the page-table owner.
> +        *   01: The page is owned by the page-table owner, but is shared
> +        *       with another entity.
> +        *   10: The page is shared with, but not owned by the page-table owner.
> +        *   11: Reserved for future use (lending).
> +        */
> +       if (prot & KVM_PGTABLE_STATE_SHARED) {
> +               if (prot & KVM_PGTABLE_STATE_BORROWED)
> +                       ignored_bits |= BIT(1);
> +               else
> +                       ignored_bits |= BIT(0);
> +       }

This might tie in to Marc's comments for using enums, but
consolidating the translation between prot and ignored/software bits
in one place would be good: thinking about patch 10 as well, where you
get the prot from the ignored bits. Even though you have documented
it, I'm finding the part where a field can be borrowed and shared as
opposed to being only shared not very intuitive, and I need to reread
the comment here to remember the difference while going through the
code.

You also mention lending as potentially reserved for the future, but I
think that lending is the other side of borrowing (depends on who's
doing the giving/taking). I wonder if in this case it would be clearer
to describe it in terms of whether it's exclusively owned vs owned but
shared (for the owner), and just shared for the sharer...

Thanks,
/fuad


> +       return FIELD_PREP(KVM_PTE_LEAF_ATTR_IGNORED, ignored_bits);
> +}
> +
>  static int kvm_pgtable_visitor_cb(struct kvm_pgtable_walk_data *data, u64 addr,
>                                   u32 level, kvm_pte_t *ptep,
>                                   enum kvm_pgtable_walk_flags flag)
> @@ -357,6 +380,7 @@ static int hyp_set_prot_attr(enum kvm_pgtable_prot prot, kvm_pte_t *ptep)
>         attr |= FIELD_PREP(KVM_PTE_LEAF_ATTR_LO_S1_AP, ap);
>         attr |= FIELD_PREP(KVM_PTE_LEAF_ATTR_LO_S1_SH, sh);
>         attr |= KVM_PTE_LEAF_ATTR_LO_S1_AF;
> +       attr |= pte_ignored_bit_prot(prot);
>         *ptep = attr;
>
>         return 0;
> @@ -558,6 +582,7 @@ static int stage2_set_prot_attr(struct kvm_pgtable *pgt, enum kvm_pgtable_prot p
>
>         attr |= FIELD_PREP(KVM_PTE_LEAF_ATTR_LO_S2_SH, sh);
>         attr |= KVM_PTE_LEAF_ATTR_LO_S2_AF;
> +       attr |= pte_ignored_bit_prot(prot);
>         *ptep = attr;
>
>         return 0;
> --
> 2.32.0.402.g57bb445576-goog
>
