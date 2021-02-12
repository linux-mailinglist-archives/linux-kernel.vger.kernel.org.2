Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB6CC31A6CC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 22:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbhBLVWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 16:22:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhBLVWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 16:22:13 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB863C0613D6
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 13:21:33 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id fa16so330675pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 13:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CYGVljwTyH8i7AMEtS7EVdeNyV8alpknPsckcxn4xKQ=;
        b=A2cdLkHxkQ4ic/CF5XJFMsFbfSl1/ZNG0k8SQgcp9+8lS6bjK8OxzpD4it+dbqbF3V
         l4kyNRgEgUBzV747X+PxQ2/i+oDNq9X9/ApxUYJYWDnAWptDRKKWjMvUHij78yc3pVVS
         +oKHWV+dcaD8c9K0uBWOO2lO722vmBm/XZJbE7Y0MPEjR+h08tUpoaL1+RuKXC1RFcF8
         m5bWuu2tTakb3XNpm9XlivAPu6onPrtnvPj0FDmJxDKcHqRvaadIb+zamO8+37bd2JSv
         ttz5S/KsmcZaPishEioLRN/T6BPwT4DopugLEZsF7iGseB//sHZFveNTF2y3ms2eY2E0
         xzFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CYGVljwTyH8i7AMEtS7EVdeNyV8alpknPsckcxn4xKQ=;
        b=lOBPPGEHbnFjQTd0rKaoHLynJ059GqLaH0qpHDgD945EQLq8F3w84zpWpnSxrQ4V9y
         jra6SVjDGt3q4fFVRycvgXY0p2PC7doB3gUlw0Cse8S82ResFQhXAL4K4DHxMTmFsS/n
         x/ljC5QUeLSTcbOuYgyP+A7iiStY+O1UrJtfbUp8iiihacuoxNjcSfckU8aUmmQ2aw37
         x1WYBqY5Wgdsd0d6yINh6QDvO6S07+hrXgvyinqJfS1mMbehLgZbA4tETlDrgYFAatOe
         wsP9+ABffyKYtuuN7KWSMr4grgN8YR80eUAAVHUT6C4icv6ZBmqw4rDbvhGuo+Ie+g3G
         GUeQ==
X-Gm-Message-State: AOAM530TUyNdq6f3j2VW1C/QlC6DxzzJ50cvAVYavMEW1V6p88Millgj
        FqJwMQC74DYNStsiLsU8oyRMgIebWmpphk2XlCugwQ==
X-Google-Smtp-Source: ABdhPJx6SJ8BU/11c1xhpXM+EG9n+aMZUB/idLtD8VLOUAOi2k4yWrYLYKdq1NGiqwfxR60W07rgfJlBIeqA1s0JUtY=
X-Received: by 2002:a17:903:31d1:b029:de:8361:739b with SMTP id
 v17-20020a17090331d1b02900de8361739bmr4400262ple.85.1613164892940; Fri, 12
 Feb 2021 13:21:32 -0800 (PST)
MIME-Version: 1.0
References: <20210211153353.29094-1-vincenzo.frascino@arm.com> <20210211153353.29094-2-vincenzo.frascino@arm.com>
In-Reply-To: <20210211153353.29094-2-vincenzo.frascino@arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 12 Feb 2021 22:21:22 +0100
Message-ID: <CAAeHK+xM1VHvSF_9ELf=_nDwJsUV2S1=LQy-rU-O0oyrNexzXw@mail.gmail.com>
Subject: Re: [PATCH v13 1/7] arm64: mte: Add asynchronous mode support
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

On Thu, Feb 11, 2021 at 4:34 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
> MTE provides an asynchronous mode for detecting tag exceptions. In
> particular instead of triggering a fault the arm64 core updates a
> register which is checked by the kernel after the asynchronous tag
> check fault has occurred.
>
> Add support for MTE asynchronous mode.
>
> The exception handling mechanism will be added with a future patch.
>
> Note: KASAN HW activates async mode via kasan.mode kernel parameter.
> The default mode is set to synchronous.
> The code that verifies the status of TFSR_EL1 will be added with a
> future patch.
>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Reviewed-by: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  arch/arm64/include/asm/memory.h    |  3 ++-
>  arch/arm64/include/asm/mte-kasan.h |  9 +++++++--
>  arch/arm64/kernel/mte.c            | 19 ++++++++++++++++---
>  3 files changed, 25 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index c759faf7a1ff..91515383d763 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -243,7 +243,8 @@ static inline const void *__tag_set(const void *addr, u8 tag)
>  }
>
>  #ifdef CONFIG_KASAN_HW_TAGS
> -#define arch_enable_tagging()                  mte_enable_kernel()
> +#define arch_enable_tagging_sync()             mte_enable_kernel_sync()
> +#define arch_enable_tagging_async()            mte_enable_kernel_async()

We need to update KASAN usage of arch_enable_tagging() to
arch_enable_tagging_sync() in this patch as well. Otherwise, this
leaves KASAN broken between this patch and the next one.


>  #define arch_set_tagging_report_once(state)    mte_set_report_once(state)
>  #define arch_init_tags(max_tag)                        mte_init_tags(max_tag)
>  #define arch_get_random_tag()                  mte_get_random_tag()
> diff --git a/arch/arm64/include/asm/mte-kasan.h b/arch/arm64/include/asm/mte-kasan.h
> index 7ab500e2ad17..4acf8bf41cad 100644
> --- a/arch/arm64/include/asm/mte-kasan.h
> +++ b/arch/arm64/include/asm/mte-kasan.h
> @@ -77,7 +77,8 @@ static inline void mte_set_mem_tag_range(void *addr, size_t size, u8 tag)
>         } while (curr != end);
>  }
>
> -void mte_enable_kernel(void);
> +void mte_enable_kernel_sync(void);
> +void mte_enable_kernel_async(void);
>  void mte_init_tags(u64 max_tag);
>
>  void mte_set_report_once(bool state);
> @@ -104,7 +105,11 @@ static inline void mte_set_mem_tag_range(void *addr, size_t size, u8 tag)
>  {
>  }
>
> -static inline void mte_enable_kernel(void)
> +static inline void mte_enable_kernel_sync(void)
> +{
> +}
> +
> +static inline void mte_enable_kernel_async(void)
>  {
>  }
>
> diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
> index a66c2806fc4d..706b7ab75f31 100644
> --- a/arch/arm64/kernel/mte.c
> +++ b/arch/arm64/kernel/mte.c
> @@ -107,13 +107,26 @@ void mte_init_tags(u64 max_tag)
>         write_sysreg_s(SYS_GCR_EL1_RRND | gcr_kernel_excl, SYS_GCR_EL1);
>  }
>
> -void mte_enable_kernel(void)
> +static inline void __mte_enable_kernel(const char *mode, unsigned long tcf)
>  {
>         /* Enable MTE Sync Mode for EL1. */
> -       sysreg_clear_set(sctlr_el1, SCTLR_ELx_TCF_MASK, SCTLR_ELx_TCF_SYNC);
> +       sysreg_clear_set(sctlr_el1, SCTLR_ELx_TCF_MASK, tcf);
>         isb();
> +
> +       pr_info_once("MTE: enabled in %s mode at EL1\n", mode);
> +}
> +
> +void mte_enable_kernel_sync(void)
> +{
> +       __mte_enable_kernel("synchronous", SCTLR_ELx_TCF_SYNC);
> +}
> +EXPORT_SYMBOL_GPL(mte_enable_kernel_sync);
> +
> +void mte_enable_kernel_async(void)
> +{
> +       __mte_enable_kernel("asynchronous", SCTLR_ELx_TCF_ASYNC);
>  }
> -EXPORT_SYMBOL_GPL(mte_enable_kernel);
> +EXPORT_SYMBOL_GPL(mte_enable_kernel_async);
>
>  void mte_set_report_once(bool state)
>  {
> --
> 2.30.0
>
