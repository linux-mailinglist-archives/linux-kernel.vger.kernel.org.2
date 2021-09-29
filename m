Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2901041CC7B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 21:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346521AbhI2TQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 15:16:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:48950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344094AbhI2TQw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 15:16:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 70BFB615E0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 19:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632942911;
        bh=ETVIBJCdRN1TfYcKQkNnuueGnEcX3D8IrbH/5L0TcAI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jg7Lp/OjdNIIv5yzuSGNnO4EL3fe+4lgbjVhXv4JAt7F9PXVtSDaEBUX35F+DfOu1
         yucHsjVP/Ibtk1ZDLO+6iNLN3Xq1Gvnzml87A7uNMQokVS8roM/XcX50ISGjmYzqDy
         LcsPlqUkSWDyQ/2z3Ili1m5Dwjs0LMWWFxXudkJiQzyb4KGhXAb+WTT5BdTUlgyazX
         CmTV2FDMMiWemMpTZYeFG+C5DQ5x4SX3DMazQGsStGsFFmYG7lmNlLUQnmOvdsKqOR
         EIK3lbRedJOTmJX5IBgCSuzq2nopjiUJcXJDWa4lCzxa9XbY/Pmm4jAlFjKmc52OZz
         hqFuL4Iprz3Zw==
Received: by mail-oi1-f176.google.com with SMTP id y201so4228940oie.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 12:15:11 -0700 (PDT)
X-Gm-Message-State: AOAM531z6H3C3ybwOuco49HTZ1hhu6bfWBe/ZrFxjqyTnvIXhJQ7hGCA
        /LQvAJNpz4GP8bE3p/dQeU+vnmzk3g/wuB7jDEM=
X-Google-Smtp-Source: ABdhPJxiKhhBpfeuTFrLolrW2M8w4XaZFpgPAYZyKTdp7CmV3jTWO6U+Sue4YUItGQwimKMgOH77lbaKgbgMHFjvhGA=
X-Received: by 2002:a05:6808:1148:: with SMTP id u8mr1233825oiu.33.1632942910767;
 Wed, 29 Sep 2021 12:15:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210929190810.1597399-1-ndesaulniers@google.com>
In-Reply-To: <20210929190810.1597399-1-ndesaulniers@google.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 29 Sep 2021 21:14:59 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGv-NjinzoQTvZTj5GwcA7bq=c=RxLsVggXrJwJmoaPMw@mail.gmail.com>
Message-ID: <CAMj1kXGv-NjinzoQTvZTj5GwcA7bq=c=RxLsVggXrJwJmoaPMw@mail.gmail.com>
Subject: Re: [PATCH] ARM: mm: proc-macros: ensure *_tlb_fns are 4B aligned
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Fangrui Song <maskray@google.com>,
        Peter Smith <peter.smith@arm.com>,
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
        <u.kleine-koenig@pengutronix.de>,
        Dave Martin <dave.martin@linaro.org>,
        Nicolas Pitre <nico@fluxnic.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Sept 2021 at 21:08, Nick Desaulniers <ndesaulniers@google.com> wrote:
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

I take it this hunk got included by accident?

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

For this part,

Acked-by: Ard Biesheuvel <ardb@kernel.org>
