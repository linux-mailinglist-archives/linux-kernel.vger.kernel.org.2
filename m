Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71BA93CFBAE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 16:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237694AbhGTNbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 09:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239483AbhGTNSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 09:18:32 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47B2C0613AB
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 06:57:56 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id h9so24597438oih.4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 06:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z54CTZ7m1ybOAaQslMS3Yzi7pwB2B73X0p7oLSu85mA=;
        b=RoH7jW88EdEt7Zcg9ZAb1d4Bp5ahB/RWZA0yBQYnLk8mVoTqhNfvVkxPYb5ejv86Gy
         4T4vuSwRZi9fabkvECsfWgswUgwFGZBdRmDUmF3jjLIMbrFlpX60Ra3slAseSlqOc8gT
         wQTG+OAT0P0Ue9KVpTNUoikCqkex3E0sr3nWPog/XK/t+6g/E3GIPtZQUiDecQ9u2Rms
         9+jRIZ4eiWxhM/1hhVvcz63NYSQovi+AQeGs9ilkvM7hYiWJ2o/Jr2Ft7S3tmviu/Tnn
         kluG2NVyuOHWY3GXx6uErJwdt1d0NLeSviJ/nrHi50LyNstUOzp3NaBq4ydzGjt0GHSe
         Fxyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z54CTZ7m1ybOAaQslMS3Yzi7pwB2B73X0p7oLSu85mA=;
        b=rmzgxrPIBXIdOOhviBsgjhlpvzbFZo/ZRbOCbNG0f3qetQ8o0emDsdETpxsTMirBM/
         43oXgpGF1GVXEa5bj0CulDrLNsd0Wb6jS8+YW2ALy6LwkXO4f99aZF5avNV3dJ29X4Bp
         5e0mm8F9QLOVQIPF0Nb+ztK67b8MAjBtlKs9+amodhhtwEctxrDHOVyz9KMcr1yShJFy
         HaYOeoxoubfh7n/6OLiHNW+yteLiBKSY45khLCnXkd0kAH4p/0Ei9g3iuhuwQi1hVQpU
         ES4Bi0az/FHlXq9NMFppJH/QAB3FpP53yus7ssOpjpQGwQSjeB/lxskFswPaKcI8+3Ik
         GsnA==
X-Gm-Message-State: AOAM533tK1kudFaQa1km2xQ3o2wUGi9aR6HcUQZ0dyjz5gKY7cjKAuYC
        0T4cTXUVwf0IpvAEDPix67f/n6QDzWZIVnRGUvHtBg==
X-Google-Smtp-Source: ABdhPJxkbl1jK/kwdgT8I4sKUxzm7eCYwuuEYGAnfVuHj/oT/zlMVBdDpQ6GDUnClK1MlQCp3VfruvMZU3I7IwoRwHY=
X-Received: by 2002:aca:cf8e:: with SMTP id f136mr25218634oig.67.1626789475645;
 Tue, 20 Jul 2021 06:57:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210719104735.3681732-1-qperret@google.com> <20210719104735.3681732-2-qperret@google.com>
In-Reply-To: <20210719104735.3681732-2-qperret@google.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Tue, 20 Jul 2021 14:57:19 +0100
Message-ID: <CA+EHjTwL7M=Proo62mE5UFsGiYSGcNF2Pa7s9YOe5fiVVdRx-A@mail.gmail.com>
Subject: Re: [PATCH 01/14] KVM: arm64: Provide the host_stage2_try() helper macro
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
> We currently unmap all MMIO mappings from the host stage-2 to recycle
> the pages whenever we run out. In order to make this pattern easy to
> re-use from other places, factor the logic out into a dedicated macro.
> While at it, apply the macro for the kvm_pgtable_stage2_set_owner()
> calls. They're currently only called early on and are guaranteed to
> succeed, but making them robust to the -ENOMEM case doesn't hurt and
> will avoid painful debugging sessions later on.
>
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/kvm/hyp/nvhe/mem_protect.c | 38 ++++++++++++++-------------
>  1 file changed, 20 insertions(+), 18 deletions(-)
>
> diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> index d938ce95d3bd..56f2117c877b 100644
> --- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> +++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> @@ -208,6 +208,23 @@ static inline int __host_stage2_idmap(u64 start, u64 end,
>                                       prot, &host_s2_pool);
>  }
>
> +/*
> + * The pool has been provided with enough pages to cover all of memory with
> + * page granularity, but it is difficult to know how much of the MMIO range
> + * we will need to cover upfront, so we may need to 'recycle' the pages if we
> + * run out.
> + */
> +#define host_stage2_try(fn, ...)                                       \
> +       ({                                                              \
> +               int __ret = fn(__VA_ARGS__);                            \
> +               if (__ret == -ENOMEM) {                                 \
> +                       __ret = host_stage2_unmap_dev_all();            \
> +                       if (!__ret)                                     \
> +                               __ret = fn(__VA_ARGS__);                \
> +               }                                                       \
> +               __ret;                                                  \
> +        })

I think it might be good to document that this macro expects the
host_kvm.lock to be held.

Thanks,
/fuad

>  static int host_stage2_idmap(u64 addr)
>  {
>         enum kvm_pgtable_prot prot = KVM_PGTABLE_PROT_R | KVM_PGTABLE_PROT_W;
> @@ -223,22 +240,7 @@ static int host_stage2_idmap(u64 addr)
>         if (ret)
>                 goto unlock;
>
> -       ret = __host_stage2_idmap(range.start, range.end, prot);
> -       if (ret != -ENOMEM)
> -               goto unlock;
> -
> -       /*
> -        * The pool has been provided with enough pages to cover all of memory
> -        * with page granularity, but it is difficult to know how much of the
> -        * MMIO range we will need to cover upfront, so we may need to 'recycle'
> -        * the pages if we run out.
> -        */
> -       ret = host_stage2_unmap_dev_all();
> -       if (ret)
> -               goto unlock;
> -
> -       ret = __host_stage2_idmap(range.start, range.end, prot);
> -
> +       ret = host_stage2_try(__host_stage2_idmap, range.start, range.end, prot);
>  unlock:
>         hyp_spin_unlock(&host_kvm.lock);
>
> @@ -257,8 +259,8 @@ int __pkvm_mark_hyp(phys_addr_t start, phys_addr_t end)
>                 return -EINVAL;
>
>         hyp_spin_lock(&host_kvm.lock);
> -       ret = kvm_pgtable_stage2_set_owner(&host_kvm.pgt, start, end - start,
> -                                          &host_s2_pool, pkvm_hyp_id);
> +       ret = host_stage2_try(kvm_pgtable_stage2_set_owner, &host_kvm.pgt,
> +                             start, end - start, &host_s2_pool, pkvm_hyp_id);
>         hyp_spin_unlock(&host_kvm.lock);
>
>         return ret != -EAGAIN ? ret : 0;
> --
> 2.32.0.402.g57bb445576-goog
>
