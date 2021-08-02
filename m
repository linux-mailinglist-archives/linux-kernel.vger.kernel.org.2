Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95DB13DD309
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 11:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233049AbhHBJhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 05:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233054AbhHBJh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 05:37:28 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB440C061796
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 02:37:19 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 26so5556297oiy.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 02:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FYSKq5I9PT1AOR7++VBDqRUavrD1FqW1zkcq2amkopA=;
        b=BOHy8c6RcwBv7BrZpawuZkaSiILuONkxy7E9exBa18jEkvhpM2mDhoaSYmfLpYlO0y
         3Juy2FnrfJYtsuyXakMsrb5sWy0al+mhdrKckXjGcfenEr/gchY+LziFl5RIqHIzxsn5
         cGEvLMc98cLzLD0XDWyKgBP1BaJX3EnS/FO2xiGeRcuF3Vx1isdKKvzJm5lKbgEHyH0n
         Gng7h7uqoTeoKL1JmenGMRV97O28QlScIg3CUHw4PqXGnqPCp5uJoST3dVmhPN8DLwz0
         skLl/gWCpFZ9aqLuPvoHQftThg7Qag861NVqscxhtJYdZu+C41nY56By2vOYAWeO/D7B
         3ayA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FYSKq5I9PT1AOR7++VBDqRUavrD1FqW1zkcq2amkopA=;
        b=NddI1rn+A8HgRTWHqmKC4bW6Vgls1d6y+o+2zBBD6u19Gkel6PJcWYD/8zM4/jQqdd
         YZfkzE/ML3WU147E30FCFl54z2pdrG4EpMXgGTwVNN/MBoowkn+pGN/mtTG2DkBfXgvx
         95059OMalwCdy2rKOqnGVovGcBE0xjS6VbucHhxqdIr/4ZS//9HNLtQKTgH56E88uq45
         CSOTo6Fp5tPNH+wz5Dglu03Q8zwbGSo1A0xSY4Lqn0ezCZJGOUBUWGu7I6+yHQCViDVj
         0dTnOFK6YB/YFVj2JXvT3Ot5yqR034Rc5jAGr5Cv89B3piSy3K3WfiTa+kJQ8wYyUUa+
         ayYQ==
X-Gm-Message-State: AOAM531t0wQPlHxwvkA9QNIoIOlfnMvEE047GaYsuj38JDI7TU/KbMaX
        4TdelRUwtD/p/C9J1EKPMSmuPodcw16rlMdVAHXicw==
X-Google-Smtp-Source: ABdhPJx7duRBSKr9RK9jF8w3zgG9BJbts+dNEDkZYXg0XR4D+ZuJAK0QB2VUoRu6L16cgXQVWEdqlDJrLx8Fq0oVgEM=
X-Received: by 2002:a05:6808:5a:: with SMTP id v26mr9759822oic.90.1627897039116;
 Mon, 02 Aug 2021 02:37:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210729132818.4091769-1-qperret@google.com> <20210729132818.4091769-4-qperret@google.com>
In-Reply-To: <20210729132818.4091769-4-qperret@google.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Mon, 2 Aug 2021 11:36:42 +0200
Message-ID: <CA+EHjTzrqbyHQyo7X-=MeJXQ5bVcfUz0uiUKVAv_U+aqVNuhYw@mail.gmail.com>
Subject: Re: [PATCH v3 03/21] KVM: arm64: Provide the host_stage2_try() helper macro
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

Hi Quentin.

On Thu, Jul 29, 2021 at 3:28 PM Quentin Perret <qperret@google.com> wrote:
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
>  arch/arm64/kvm/hyp/nvhe/mem_protect.c | 40 +++++++++++++++------------
>  1 file changed, 22 insertions(+), 18 deletions(-)
>
> diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> index d938ce95d3bd..74280a753efb 100644
> --- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> +++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> @@ -208,6 +208,25 @@ static inline int __host_stage2_idmap(u64 start, u64 end,
>                                       prot, &host_s2_pool);
>  }
>
> +/*
> + * The pool has been provided with enough pages to cover all of memory with
> + * page granularity, but it is difficult to know how much of the MMIO range
> + * we will need to cover upfront, so we may need to 'recycle' the pages if we
> + * run out.
> + */

The comment you added in V2 about host_kvm.lock got dropped in favor
asserting that the lock is held.

Reviewed-by: Fuad Tabba <tabba@google.com>

Thanks,
/fuad




> +#define host_stage2_try(fn, ...)                                       \
> +       ({                                                              \
> +               int __ret;                                              \
> +               hyp_assert_lock_held(&host_kvm.lock);                   \
> +               __ret = fn(__VA_ARGS__);                                \
> +               if (__ret == -ENOMEM) {                                 \
> +                       __ret = host_stage2_unmap_dev_all();            \
> +                       if (!__ret)                                     \
> +                               __ret = fn(__VA_ARGS__);                \
> +               }                                                       \
> +               __ret;                                                  \
> +        })
> +
>  static int host_stage2_idmap(u64 addr)
>  {
>         enum kvm_pgtable_prot prot = KVM_PGTABLE_PROT_R | KVM_PGTABLE_PROT_W;
> @@ -223,22 +242,7 @@ static int host_stage2_idmap(u64 addr)
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
> @@ -257,8 +261,8 @@ int __pkvm_mark_hyp(phys_addr_t start, phys_addr_t end)
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
> 2.32.0.432.gabb21c7263-goog
>
