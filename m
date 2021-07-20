Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 202B93CF7C4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 12:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236909AbhGTJkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 05:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236843AbhGTJjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 05:39:01 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F7AC0613DE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 03:17:41 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so21092670otl.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 03:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3nSJt2wVIh6BPso+/5eEugChhl7K9J9KvL28I6hU2Mc=;
        b=GYmt8m/9xcpbfJpN+JDFmpyQSiDjQCb2/C4Arok72cqv+29SFuIJytkUrLba4/h+yJ
         S5kStZCpS/bjSyihG7MOnHe7cl6OnFiucpWXpykGdrB5sdipCaSB8Mr5r8RirOqjZZeX
         WfF7zxiBwr002UhhGIDgI6mfde7vtmlHyoxITYCgpo+UD9UFYM0WB12yJrweVBTL9JJt
         bEw/vodpV8o7GOxQZeTw4s2MTq7awvaU+7ls6ue7g6ggbra4UyhNdyVorfiugB4gZXt0
         KDuYdgE0NQotaJA/LI0UIW72g3iiFByxEIuPoaA0jns92tBXCSepKXSLpZanvY6KzDIP
         fHeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3nSJt2wVIh6BPso+/5eEugChhl7K9J9KvL28I6hU2Mc=;
        b=ZoPjEBxeDcE77jriaxQCcaQyz4zffuK1inm5FqRwTz/OVz2bxVujoZRWAbh1db3/CQ
         6gEFW/5ZeRGLJ9wj7DW7UhWBtz4BpZA3lI3L1RF5m7Wif45RdIJaKxq7HOgkXLSKfrOv
         O2AIbQcoMvNdU1+K7yTFXo74ndZ/rvyI4/UH8WHLxFQ8sZVaP/nQLLUB/Pvr3hbxrv2A
         u9m4/AKMZZ+HZlxl5j1G5eIeZ76aVMBUHTfYraSk5DYble7QzCgkW2QUvENPaSaAkECZ
         7XXvKVDyDrdezM5GbJbd6/KJAiFVfFI0dDQSG4pAKoCqjcsImXz/b1Yp+rELrPUz+Ei2
         poNA==
X-Gm-Message-State: AOAM532zxPqCvLEEO38RLm5j2OKlbz3lYFQ/CL+QF3pDr17PuckgERCx
        x1KcIoLzkMoO5+2yD+LA/94DIyT3koJLv/x3cfo3VA==
X-Google-Smtp-Source: ABdhPJwvdbge9dFU6ODLriZxUOU3MC1qOuSsWZfB9Ag10DwHavakZNHULRmsBxP5cWZD1feem6Z/2nFZ3dkKu0EzFlA=
X-Received: by 2002:a9d:600a:: with SMTP id h10mr21242926otj.144.1626776260256;
 Tue, 20 Jul 2021 03:17:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210719104735.3681732-1-qperret@google.com> <20210719104735.3681732-7-qperret@google.com>
In-Reply-To: <20210719104735.3681732-7-qperret@google.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Tue, 20 Jul 2021 11:17:03 +0100
Message-ID: <CA+EHjTzjT2iv=9jsTNquSAD-_AWqpyCKVPiuCBWGzpxcAkWf9w@mail.gmail.com>
Subject: Re: [PATCH 06/14] KVM: arm64: Tolerate re-creating hyp mappings to
 set ignored bits
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
> The current hypervisor stage-1 mapping code doesn't allow changing an
> existing valid mapping. Relax this condition by allowing changes that
> only target ignored bits, as that will soon be needed to annotate shared
> pages.
>
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/kvm/hyp/pgtable.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
> index a0ac8c2bc174..34cf67997a82 100644
> --- a/arch/arm64/kvm/hyp/pgtable.c
> +++ b/arch/arm64/kvm/hyp/pgtable.c
> @@ -362,6 +362,17 @@ static int hyp_set_prot_attr(enum kvm_pgtable_prot prot, kvm_pte_t *ptep)
>         return 0;
>  }
>
> +static bool hyp_pte_needs_update(kvm_pte_t old, kvm_pte_t new)
> +{
> +       if (old == new)
> +               return false;
> +
> +       if (!kvm_pte_valid(old))
> +               return true;
> +
> +       return !WARN_ON((old ^ new) & ~KVM_PTE_LEAF_ATTR_IGNORED);

Wouldn't this return false if both ignored and non-ignored bits were
different, or is that not possible (judging by the WARN_ON)? If it is,
then it would need an update, wouldn't it?

Thanks,
/fuad


> +}
> +
>  static bool hyp_map_walker_try_leaf(u64 addr, u64 end, u32 level,
>                                     kvm_pte_t *ptep, struct hyp_map_data *data)
>  {
> @@ -371,9 +382,12 @@ static bool hyp_map_walker_try_leaf(u64 addr, u64 end, u32 level,
>         if (!kvm_block_mapping_supported(addr, end, phys, level))
>                 return false;
>
> -       /* Tolerate KVM recreating the exact same mapping */
> +       /*
> +        * Tolerate KVM recreating the exact same mapping, or changing ignored
> +        * bits.
> +        */
>         new = kvm_init_valid_leaf_pte(phys, data->attr, level);
> -       if (old != new && !WARN_ON(kvm_pte_valid(old)))
> +       if (hyp_pte_needs_update(old, new))
>                 smp_store_release(ptep, new);
>
>         data->phys += granule;
> --
> 2.32.0.402.g57bb445576-goog
>
