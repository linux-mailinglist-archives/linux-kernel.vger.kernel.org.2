Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67F7C41CC5D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 21:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346470AbhI2TMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 15:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346211AbhI2TMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 15:12:44 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4510C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 12:11:02 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id x27so14897507lfa.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 12:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+X1e0IkE1xycXJllhY8KH7nR5VMuinY4y1av7l1HO2E=;
        b=A6vTFI4GI0ABykrmrvQxmVnV6LIcD2XbocmDVJPyqJqCCkhdVhgtV4RJpw5TUR6q7R
         ta4T11QBaFri6MrJzm/8mYHvcn+MSX8cNpzWJb3eGJ0GtAc1ZFDAOgk00ROI3AXZQ0Bz
         CRC9H5HNAeU4DtNL9R5ovr04qSAFh1kkBid0QPFf7vJz/m7oICWEx5OAxWhMc4HNWJ83
         F7TfeMsEii0xY+t2PYhJcBBuv16Y8LWfbevubhHQ9pZ6bJIf31AVg4cqm/KVenTMdkB9
         fn1DvLrGKBj2ntmJjjvY2EjrOlGeGjWe3v5uywCxa90OAtOduI3cCbjwHhFkhZMZhij5
         hmWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+X1e0IkE1xycXJllhY8KH7nR5VMuinY4y1av7l1HO2E=;
        b=cvmDEC8B77U2u3Nux5oypFQK5NP0Sj3g1bTjeUwdPcMO4NThGHEzoZKw2niZIYVgQt
         jLP426EXEIbwVT7ng2THb8exFntjW8WJ+y01Rj2rXf57p+mASFJBtzWUQf/Ar0plVkJF
         jQrsZH5fi1BJWHeeObpfv++0lzDQMAKhuVIZIWp2QQJzq4JuqvMlcTqNMLwAK+STH4pw
         xo3WGY6K4r+Gqi7/Upn08eXcVXJ9pKEJ/dkqHCQNuhz1o5MB5q2e9nGU72J1cyGoFPDj
         leWNdaKsLi1ntZB70u5vPV9JOVXKVdBc8B0hqwkuxCSX38uzM7BJ+Xu3v5VQmr60+7YR
         uIQQ==
X-Gm-Message-State: AOAM532Ty9BhMOr/v1eZooWsAOt3Q6BVYwh+kKP4gmdMP4gMUO81Dd79
        QAmZVrpfuu+H+eAe0q5aU8frZwv0P6cmRLv1i6loBA==
X-Google-Smtp-Source: ABdhPJxlhvutNtxglq5AM66fAlkeMwumou7oMgak1HMc9PDnF6UJ0qPx3zipOdVHjdoRpOCOwVUaiI/TZ+we3UwGbEI=
X-Received: by 2002:a05:6512:110a:: with SMTP id l10mr1328642lfg.550.1632942660850;
 Wed, 29 Sep 2021 12:11:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210929190810.1597399-1-ndesaulniers@google.com>
In-Reply-To: <20210929190810.1597399-1-ndesaulniers@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 29 Sep 2021 12:10:49 -0700
Message-ID: <CAKwvOd=v+1H4CrDDFENGiUx=9-Q3ieMsA9P7G270pSpW1jC-Yw@mail.gmail.com>
Subject: Re: [PATCH] ARM: mm: proc-macros: ensure *_tlb_fns are 4B aligned
To:     linux-arm-kernel@lists.infradead.org
Cc:     Fangrui Song <maskray@google.com>,
        Peter Smith <Peter.Smith@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Nicolas Pitre <nico@fluxnic.net>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Dave Martin <dave.martin@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Dave (Dave, I got a bounceback on your linaro.org email address.
Consider sending a patch updating the .mailmap)

On Wed, Sep 29, 2021 at 12:08 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> QEMU 6.1.0 is more correct about trapping on misaligned accesses. A
> kernel built with CONFIG_THUMB2_KERNEL=y and using clang as the
> assembler could generate non-naturally-aligned v7wbi_tlb_fns which
> results in a boot failure. The original commit adding the macro missed
> the .align directive on this data.
>
> Fixes: 66a625a88174 ("ARM: mm: proc-macros: Add generic proc/cache/tlb struct definition macros")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1447
> Link: https://lore.kernel.org/all/0699da7b-354f-aecc-a62f-e25693209af4@linaro.org/
> Debugged-by: Ard Biesheuvel <ardb@kernel.org>
> Debugged-by: Nathan Chancellor <nathan@kernel.org>
> Debugged-by: Richard Henderson <richard.henderson@linaro.org>
> Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>  arch/arm/Kconfig          | 1 +
>  arch/arm/mm/proc-macros.S | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index fc196421b2ce..b760dd45b734 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -92,6 +92,7 @@ config ARM
>         select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
>         select HAVE_FUNCTION_GRAPH_TRACER if !THUMB2_KERNEL && !CC_IS_CLANG
>         select HAVE_FUNCTION_TRACER if !XIP_KERNEL
> +       select HAVE_FUTEX_CMPXCHG if FUTEX
>         select HAVE_GCC_PLUGINS
>         select HAVE_HW_BREAKPOINT if PERF_EVENTS && (CPU_V6 || CPU_V6K || CPU_V7)
>         select HAVE_IRQ_TIME_ACCOUNTING
> diff --git a/arch/arm/mm/proc-macros.S b/arch/arm/mm/proc-macros.S
> index e2c743aa2eb2..d9f7dfe2a7ed 100644
> --- a/arch/arm/mm/proc-macros.S
> +++ b/arch/arm/mm/proc-macros.S
> @@ -340,6 +340,7 @@ ENTRY(\name\()_cache_fns)
>
>  .macro define_tlb_functions name:req, flags_up:req, flags_smp
>         .type   \name\()_tlb_fns, #object
> +       .align 2
>  ENTRY(\name\()_tlb_fns)
>         .long   \name\()_flush_user_tlb_range
>         .long   \name\()_flush_kern_tlb_range
> --
> 2.33.0.685.g46640cef36-goog
>


-- 
Thanks,
~Nick Desaulniers
