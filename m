Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 338ED423D99
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 14:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238494AbhJFMVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 08:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238124AbhJFMVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 08:21:12 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56FDC061749
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 05:19:20 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id r9so2642665ile.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 05:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P+psjcpEfkkPYUD4niLYpNlBdseGbXQDj/wP/GbAAbI=;
        b=iPCsObQh1Qb6sjXgSc32HBWHNLkxmqosQsTG6EeZCajkyjddStX6MT8IrYRyEk3en7
         SWLGoJvdaBRi0iLPe+6zEQqUsGc46is7b2tzNwTpZA4NYO+lKnzKURCpL/00oYltYVR6
         2vt+DqUdcXylA4F7xhDLPUWJfTCC2hIa5y/bPdLUrcgnaMJacIk0npMf8/9dK9Y+/gT2
         8G83H9YL5Ftn13r8CzUG9bwXzcFQmdDXFOk06Na2XoDxwVFSmGjXGcVjMGNw5i5C3WYn
         izURSr3D56fADnJnhGjiBDn2n56YOhGMv7qhq+CHdQNUXo52n+lNcvj4Nu2+OmaMLeGr
         HqNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P+psjcpEfkkPYUD4niLYpNlBdseGbXQDj/wP/GbAAbI=;
        b=j+5OzXCNicVfkOxN59eWlXtDTjzV4Qtq/lpIdm2eBiFTBMqNT1zYKP9BTFgIxLg0wj
         V4TujMjTlFSjJPw9b94aTxRH5el1cZeA645by0J1qTCSl+dY4/KFmcZlcoXGRE7L2TCl
         gK4cG6g8FrxV3iqUYpPoRQnkhVFdQQ7rKZLdkfEe0LsB/Fmm0qN98aN9Mn6ZmS9v0v2T
         bCVoRBG9fJnXYUKapj/AHLAkA4qkAxOIT/0MQeIYclT95l6iJHFi8etN0v4yVofMa7de
         gRRuHyuD6YAh6rCBJ0RjgFrTQTLhBS5X/0OI9+EgrYJ8ZfvxRDbMy5JbgwRPn/zpQxif
         MQrQ==
X-Gm-Message-State: AOAM531JXTCZ2+2AraJpRkDrBijz8ANEN87omKJhNKc3XWRBX/jy46Sp
        NsGUEHpKbzY2beUtyJfdDmaxDVqRoJcvx7l1QKA=
X-Google-Smtp-Source: ABdhPJwgu+B33miryU/mYpWpLmu6glpBTHKo91ePOLfd3l4M7XcpWVm6eBMDX3f8XSBuC8xtP6X/RBgjSB1NqqRgm+E=
X-Received: by 2002:a05:6e02:bf1:: with SMTP id d17mr7028913ilu.81.1633522760314;
 Wed, 06 Oct 2021 05:19:20 -0700 (PDT)
MIME-Version: 1.0
References: <20211004202253.27857-1-vincenzo.frascino@arm.com> <20211004202253.27857-5-vincenzo.frascino@arm.com>
In-Reply-To: <20211004202253.27857-5-vincenzo.frascino@arm.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Wed, 6 Oct 2021 14:19:09 +0200
Message-ID: <CA+fCnZeL48oLd8bbWgxomc6WnS4e53a7K6SwBpKBJND4f03f7A@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] arm64: mte: Add asymmetric mode support
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 4, 2021 at 10:23 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
> MTE provides an asymmetric mode for detecting tag exceptions. In
> particular, when such a mode is present, the CPU triggers a fault
> on a tag mismatch during a load operation and asynchronously updates
> a register when a tag mismatch is detected during a store operation.
>
> Add support for MTE asymmetric mode.
>
> Note: If the CPU does not support MTE asymmetric mode the kernel falls
> back on synchronous mode which is the default for kasan=on.
>
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  arch/arm64/include/asm/memory.h    |  1 +
>  arch/arm64/include/asm/mte-kasan.h |  5 +++++
>  arch/arm64/kernel/mte.c            | 33 +++++++++++++++++++++++++++++-
>  3 files changed, 38 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index f1745a843414..1b9a1e242612 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -243,6 +243,7 @@ static inline const void *__tag_set(const void *addr, u8 tag)
>  #ifdef CONFIG_KASAN_HW_TAGS
>  #define arch_enable_tagging_sync()             mte_enable_kernel_sync()
>  #define arch_enable_tagging_async()            mte_enable_kernel_async()
> +#define arch_enable_tagging_asymm()            mte_enable_kernel_asymm()
>  #define arch_force_async_tag_fault()           mte_check_tfsr_exit()
>  #define arch_get_random_tag()                  mte_get_random_tag()
>  #define arch_get_mem_tag(addr)                 mte_get_mem_tag(addr)
> diff --git a/arch/arm64/include/asm/mte-kasan.h b/arch/arm64/include/asm/mte-kasan.h
> index 22420e1f8c03..478b9bcf69ad 100644
> --- a/arch/arm64/include/asm/mte-kasan.h
> +++ b/arch/arm64/include/asm/mte-kasan.h
> @@ -130,6 +130,7 @@ static inline void mte_set_mem_tag_range(void *addr, size_t size, u8 tag,
>
>  void mte_enable_kernel_sync(void);
>  void mte_enable_kernel_async(void);
> +void mte_enable_kernel_asymm(void);
>
>  #else /* CONFIG_ARM64_MTE */
>
> @@ -161,6 +162,10 @@ static inline void mte_enable_kernel_async(void)
>  {
>  }
>
> +static inline void mte_enable_kernel_asymm(void)
> +{
> +}
> +
>  #endif /* CONFIG_ARM64_MTE */
>
>  #endif /* __ASSEMBLY__ */
> diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
> index e5e801bc5312..b6ad6b861c25 100644
> --- a/arch/arm64/kernel/mte.c
> +++ b/arch/arm64/kernel/mte.c
> @@ -26,7 +26,12 @@
>  static DEFINE_PER_CPU_READ_MOSTLY(u64, mte_tcf_preferred);
>
>  #ifdef CONFIG_KASAN_HW_TAGS
> -/* Whether the MTE asynchronous mode is enabled. */
> +/*
> + * The MTE asynchronous and asymmetric mode have the same
> + * behavior for the store operations.
> + *
> + * Whether the MTE asynchronous or asymmetric mode is enabled.
> + */
>  DEFINE_STATIC_KEY_FALSE(mte_async_mode);
>  EXPORT_SYMBOL_GPL(mte_async_mode);
>  #endif
> @@ -137,6 +142,32 @@ void mte_enable_kernel_async(void)
>         if (!system_uses_mte_async_mode())
>                 static_branch_enable(&mte_async_mode);
>  }
> +
> +void mte_enable_kernel_asymm(void)
> +{
> +       if (cpus_have_cap(ARM64_MTE_ASYMM)) {
> +               __mte_enable_kernel("asymmetric", SCTLR_ELx_TCF_ASYMM);
> +
> +               /*
> +                * MTE asymm mode behaves as async mode for store
> +                * operations. The mode is set system wide by the
> +                * first PE that executes this function.
> +                *
> +                * Note: If in future KASAN acquires a runtime switching
> +                * mode in between sync and async, this strategy needs
> +                * to be reviewed.
> +                */
> +               if (!system_uses_mte_async_mode())
> +                       static_branch_enable(&mte_async_mode);

Using this variable and function here still looks confusing. Maybe
naming the variable mte_async_or_asymm_mode? Or
mte_async_fault_possible similarly to KASAN?


> +       } else {
> +               /*
> +                * If the CPU does not support MTE asymmetric mode the
> +                * kernel falls back on synchronous mode which is the
> +                * default for kasan=on.
> +                */
> +               mte_enable_kernel_sync();
> +       }
> +}
>  #endif
>
>  #ifdef CONFIG_KASAN_HW_TAGS
> --
> 2.33.0
>
