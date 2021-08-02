Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F67C3DD350
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 11:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233169AbhHBJvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 05:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232699AbhHBJvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 05:51:00 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09C1C06175F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 02:50:50 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id u25so23443820oiv.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 02:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b8yWPewOpxEQv7YrShVluvsDfJILeyLSFc02MK8M4Jg=;
        b=mMdp1X5UVpP6BtslW98Pmn4WGS1V9KMePYP8jFuWMlGsfFdVwyUBDVmyVKhoK/mgiz
         DYwQ1Zg2pcEy3GWarwo8/Wed2E+Ds2XfD0k14pt9t/GSwknmApk7fsT4ggMBI0LtK40b
         Jim8WOzKtRLSorL6DSdLgzRXLObY2uvcZY2A4HHPYVmPQdSDgVGU33VbgB12AmY7lKxK
         uGy4Axny7H1i0ytJLGPNUs1yHBUJeNlpy+9D26T3VDLPFM9/uyNQgkRjZ56JOdWuJsCB
         0NYIK0SLGxShbXLtxVLRbCeCUI7mEUBhQHjpTRIB2JVaG2fZSVG2fviPN34iILOIFOPi
         JDxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b8yWPewOpxEQv7YrShVluvsDfJILeyLSFc02MK8M4Jg=;
        b=ujPZH1/irC1JY9WTHjSBYG1Spt2VevLEuPhmabf7DoKMPg4YIKyhkVgCGobz2vF5UP
         2tGE6fOaoywG3pGvmeXi849AppN7WLi1beJRBW6H+pFjSoCCT2A7CmNJ4/DCl6Txl6Gi
         7f6h6bW/YbTgG1sR6uqq/iZAJ9aTTUlNgQdgkWER0FC1ZWFlCJ/+3Kzj9iAExELfzj96
         8GNiuKGY/h4TPJgn8zn2xFPTJZBMXwn881rv6bCj9Zc9blXeWA4easYsXtXAiOCyLcRY
         IR189hV5QKeqoipj8qYPq9kQIiTiQpprC9aI/PAHPTSeX/aODoB+gEOetcXsZMy55LtX
         k1Kw==
X-Gm-Message-State: AOAM531ExUrltCEqPUHWuyqkif44O7iceg8nXUFPHCKRE0vtv6lI/6Ih
        ew4WdYlnLs5Lx8//TTpnlyvhVyJ9uNih7OixbNP54A==
X-Google-Smtp-Source: ABdhPJzkv07umAxyH1yzoI9pdizT6IMTPQXJOtx/ojWMS2eL8ogaXJ4KJCr2SDpEzW1Kb2Mrr8zYqtsaHVWwT/ZBeiE=
X-Received: by 2002:aca:2102:: with SMTP id 2mr9817151oiz.67.1627897849884;
 Mon, 02 Aug 2021 02:50:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210729132818.4091769-1-qperret@google.com> <20210729132818.4091769-10-qperret@google.com>
In-Reply-To: <20210729132818.4091769-10-qperret@google.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Mon, 2 Aug 2021 11:50:13 +0200
Message-ID: <CA+EHjTzYP3W4w3-EufkxWrFtGuCs6=SuO9XegAGAAp46EDF1VQ@mail.gmail.com>
Subject: Re: [PATCH v3 09/21] KVM: arm64: Tolerate re-creating hyp mappings to
 set software bits
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
> The current hypervisor stage-1 mapping code doesn't allow changing an
> existing valid mapping. Relax this condition by allowing changes that
> only target software bits, as that will soon be needed to annotate shared
> pages.
>
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/kvm/hyp/pgtable.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
> index 1ee1168ac32d..2689fcb7901d 100644
> --- a/arch/arm64/kvm/hyp/pgtable.c
> +++ b/arch/arm64/kvm/hyp/pgtable.c
> @@ -362,6 +362,21 @@ static int hyp_set_prot_attr(enum kvm_pgtable_prot prot, kvm_pte_t *ptep)
>         return 0;
>  }
>
> +static bool hyp_pte_needs_update(kvm_pte_t old, kvm_pte_t new)
> +{
> +       /*
> +        * Tolerate KVM recreating the exact same mapping, or changing software
> +        * bits if the existing mapping was valid.
> +        */
> +       if (old == new)
> +               return false;

The added comment clarifies the rationale here. Thanks.

Reviewed-by: Fuad Tabba <tabba@google.com>

/fuad



/fuad

> +       if (!kvm_pte_valid(old))
> +               return true;
> +
> +       return !WARN_ON((old ^ new) & ~KVM_PTE_LEAF_ATTR_HI_SW);
> +}
> +
>  static bool hyp_map_walker_try_leaf(u64 addr, u64 end, u32 level,
>                                     kvm_pte_t *ptep, struct hyp_map_data *data)
>  {
> @@ -371,9 +386,8 @@ static bool hyp_map_walker_try_leaf(u64 addr, u64 end, u32 level,
>         if (!kvm_block_mapping_supported(addr, end, phys, level))
>                 return false;
>
> -       /* Tolerate KVM recreating the exact same mapping */
>         new = kvm_init_valid_leaf_pte(phys, data->attr, level);
> -       if (old != new && !WARN_ON(kvm_pte_valid(old)))
> +       if (hyp_pte_needs_update(old, new))
>                 smp_store_release(ptep, new);
>
>         data->phys += granule;
> --
> 2.32.0.432.gabb21c7263-goog
>
