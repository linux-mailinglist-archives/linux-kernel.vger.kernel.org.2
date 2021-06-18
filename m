Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 925193AC770
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 11:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbhFRJbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 05:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232691AbhFRJbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 05:31:47 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C37C061574
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 02:29:38 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id j11-20020a9d738b0000b02903ea3c02ded8so9078186otk.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 02:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N/qwmYB+XdX9IWGAxOnGY9FuYF4paO9b0DILqAiiyD4=;
        b=ukSsBJQ1E59E3x8w6/nvtF76OYRFR47kxQSpjcZN3MI9ZL8YorOWl/yPIzCH6S8az+
         K7IbWVot1ZFKlr9W/cVkRjOZeil1SkqOXI+pEuv+dyVO0uxeCHG2516DfBxsEriGBkQu
         1Ou3qFOYOAfSiMN0XwCHtF+0PMfy8QU7vzVOa7S4Nz6bI+/9AWbF9bybNcaFBoXr9v+q
         ZIHb+/6t8OUGw3FhNkONlLbPTaL707jQ/Vr7vGucFY5MAv4CGhJReCIVuUByFZND4sRC
         IyPEoErHPcyrhQ+QPfyN+xIr++MgjHwITJ86CajL0L/rFhipAzAVMGDdWnCgmcVoNOas
         y5yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N/qwmYB+XdX9IWGAxOnGY9FuYF4paO9b0DILqAiiyD4=;
        b=G/R+JqwoEzIy9YD6hzd2XeO90YJ7hHryp+a/ltC1sOuPVzDIb9zreg+UFLnrfYuxJ6
         RqrghkBDDxHkgUmcrvIJHaerZm/G3HDb9Au6MC9xoIpe6Izwwnz9x0GeX21Ho3am0Qf1
         LQ9feN+GB5PW7mK6MbNl0uopQlGI+kPhlaQCe516JNmv0mZ0Tg8mGfElT+E3NR3gFqR2
         t/36rxAnGpwHGmepiITgNiQDfcTjKkTR4anxjr+Gn/bXhfLCEeARS3N+oJg/syDAE3xK
         3mPp+HE6fvaXQnMOw3Qz5qdqChV7TujX5oGzb3nNv4JJ6ZW2zmXRc86WGKlYckfasDB3
         zUUg==
X-Gm-Message-State: AOAM531QmAF8VV0Rmy+8kKAa0pg/sMtvY42mfagQvk0GNjdiHTQ29dkX
        qwPMQWYOV5hMg8vV2cijcpQ4zWYfeB2zzNkwCzcPbw==
X-Google-Smtp-Source: ABdhPJy34bTXMGIWJlSVjHMhTC48jR0vAtQDfnNfPeWsE4KxnDAcP0mvJ7OTC20GbVGyNRrT4alrOBZJO+ruEnem2vo=
X-Received: by 2002:a05:6830:1002:: with SMTP id a2mr8201355otp.144.1624008578100;
 Fri, 18 Jun 2021 02:29:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210617105824.31752-1-wangyanan55@huawei.com> <20210617105824.31752-3-wangyanan55@huawei.com>
In-Reply-To: <20210617105824.31752-3-wangyanan55@huawei.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Fri, 18 Jun 2021 10:29:02 +0100
Message-ID: <CA+EHjTwyQ6t3jy9SQ0bfC6W9Ngju7ysGHpsXu9L2j5qwoRJUfQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/4] KVM: arm64: Introduce mm_ops member for structure stage2_attr_data
To:     Yanan Wang <wangyanan55@huawei.com>
Cc:     Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Quentin Perret <qperret@google.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yanan,

On Thu, Jun 17, 2021 at 11:58 AM Yanan Wang <wangyanan55@huawei.com> wrote:
>
> Also add a mm_ops member for structure stage2_attr_data, since we
> will move I-cache maintenance for guest stage-2 to the permission
> path and as a result will need mm_ops for some callbacks.
>
> Signed-off-by: Yanan Wang <wangyanan55@huawei.com>
> ---
>  arch/arm64/kvm/hyp/pgtable.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
> index c37c1dc4feaf..d99789432b05 100644
> --- a/arch/arm64/kvm/hyp/pgtable.c
> +++ b/arch/arm64/kvm/hyp/pgtable.c
> @@ -861,10 +861,11 @@ int kvm_pgtable_stage2_unmap(struct kvm_pgtable *pgt, u64 addr, u64 size)
>  }
>
>  struct stage2_attr_data {
> -       kvm_pte_t       attr_set;
> -       kvm_pte_t       attr_clr;
> -       kvm_pte_t       pte;
> -       u32             level;
> +       kvm_pte_t                       attr_set;
> +       kvm_pte_t                       attr_clr;
> +       kvm_pte_t                       pte;
> +       u32                             level;
> +       struct kvm_pgtable_mm_ops       *mm_ops;
>  };
>
>  static int stage2_attr_walker(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
> @@ -903,6 +904,7 @@ static int stage2_update_leaf_attrs(struct kvm_pgtable *pgt, u64 addr,
>         struct stage2_attr_data data = {
>                 .attr_set       = attr_set & attr_mask,
>                 .attr_clr       = attr_clr & attr_mask,
> +               .mm_ops         = pgt->mm_ops,
>         };
>         struct kvm_pgtable_walker walker = {
>                 .cb             = stage2_attr_walker,
> --
> 2.23.0

Reviewed-by: Fuad Tabba <tabba@google.com>

Thanks,
/fuad
> _______________________________________________
> kvmarm mailing list
> kvmarm@lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
