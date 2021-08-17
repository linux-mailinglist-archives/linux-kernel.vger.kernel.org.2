Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B30E3EF1A1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 20:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbhHQSSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 14:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbhHQSSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 14:18:08 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485ECC061764
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 11:17:35 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id k5so15215840lfu.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 11:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eDdv2rzwUMD4SObVyB6gkvhjez+GHyH9zfR8+Ve+7sM=;
        b=h0gfcuKUZFJy/L3rm/JRdVw4fII5RbW6t/pPv+iGWr1OvJZV0bUBeEgyGeAuI+oeeY
         6ijS1h459OkiMhxigAhtRwEXafFri4e7eu5aSHPSL/L1eSUT/I2VNLUT4J0pcsM5KjXK
         zqghdhL4PnjoHlVns9RDc0S1k0AY/3h5dPrSv508/Z8HDWRzVylizKwyve7kxB+bHOfc
         c/4mYHaf34GZO+7akOXjOjnGrxve+6yeu3kyPwVyI9lMgqzHsXzB3rXAnFWnD+OUYgdz
         SvmNNT5CDMEPNpZvSPDlQZSIHou68vJNqHOK75PyZfQten1qpPFrP6gfNpC9nrA14IAy
         VwfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eDdv2rzwUMD4SObVyB6gkvhjez+GHyH9zfR8+Ve+7sM=;
        b=CJOruteMr370WOOtEf+wYFQ9MC9IX7QqhJu/hKbLSZeoZ3CGkj6IWM8CYD4ZTXHWHC
         NkU9hKrhvQbHYyGdLJM2bfWMrx1H0voFKG6VuQsY57GHr8a/peK2e5bDV9Pm1IOR7je+
         mOPsnp6nlOPKPochWHPN0Ej/TWf2+j3wmKZ+bC7NU5t2uOPAbIikCHsgsx8zhUx+mCFN
         HVunzqQl7kJ5U0/+d/+xSABTc9E2Dbi+lKreV1Ydc61wSTA2ffsjp0Cd2E+QXuOQnvKt
         VJIfGqntsShRUHRvKlvcoZ4pCM4r3OwM7xnZu3i3SbXqHvqeeY9mCDoizimkDgBBrNoT
         UAdA==
X-Gm-Message-State: AOAM530fJgLr4PqX3f4MiCZbSEW4czZlNEIX5lSILwd9arvMMk63/Juf
        skjDuxGFlT8ZU5jUZv6HJ7FmAy69cgErybJiWVgBBW0M9imkOA==
X-Google-Smtp-Source: ABdhPJy8lHGHx0AqTwGSS2oLj2pWbnBFsdGk5RXnwUvOEEmg9PDuBSckubnBjrrTN8JdO3h9nP36CvU2zdiMyH2lg4I=
X-Received: by 2002:a19:7117:: with SMTP id m23mr3507570lfc.73.1629224253295;
 Tue, 17 Aug 2021 11:17:33 -0700 (PDT)
MIME-Version: 1.0
References: <269701460.117528.1629210189833@office.mailbox.org> <796036867.117557.1629210288168@office.mailbox.org>
In-Reply-To: <796036867.117557.1629210288168@office.mailbox.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 17 Aug 2021 11:17:21 -0700
Message-ID: <CAKwvOdkYgC4pU0Ta+vS-UkyAYFTkg8MaLuR+OAsSX63_BY+1vA@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86, Makefile: Add new generic x86-64 settings v2/v3/v4
To:     torvic9@mailbox.org
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>,
        "graysky@archlinux.us" <graysky@archlinux.us>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2021 at 7:24 AM torvic9 via Clang Built Linux
<clang-built-linux@googlegroups.com> wrote:
>
> Add new generic x86-64 CPU tunings introduced with recent versions of
> gcc and clang, as documented in x86-64-psABI [1].
>
> This is taken straight from graysky's CPU optimization patch with minor
> modifications [2].
>
> [1] https://gitlab.com/x86-psABIs/x86-64-ABI/-/commit/77566eb03bc6a326811cb7e9a6b9396884b67c7c
> [2] https://github.com/graysky2/kernel_compiler_patch
>
> Signed-off-by: Tor Vic <torvic9@mailbox.org>
> ---
>  arch/x86/Kconfig.cpu  | 26 +++++++++++++++++++++++++-
>  arch/x86/Makefile.cpu |  6 ++++++
>  2 files changed, 31 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
> index 814fe0d349b0..a2c872aa5a0b 100644
> --- a/arch/x86/Kconfig.cpu
> +++ b/arch/x86/Kconfig.cpu
> @@ -294,6 +294,30 @@ config GENERIC_CPU
>           Generic x86-64 CPU.
>           Run equally well on all x86-64 CPUs.
>
> +config GENERIC_CPU_V2
> +       bool "Generic-x86-64-v2"
> +       depends on ( CC_IS_GCC && GCC_VERSION > 110000 ) || ( CC_IS_CLANG && CLANG_VERSION >= 120000 )

Can we stick with either > or >=, but at least be consistent? Also,
there's unnecessary whitespace inside the parens that could be
removed.

> +       depends on X86_64
> +       help
> +         Generic x86-64 CPU.
> +         Run equally well on all x86-64 CPUs with min support of x86-64-v2.
> +
> +config GENERIC_CPU_V3
> +       bool "Generic-x86-64-v3"
> +       depends on ( CC_IS_GCC && GCC_VERSION > 110000 ) || ( CC_IS_CLANG && CLANG_VERSION >= 120000 )
> +       depends on X86_64
> +       help
> +         Generic x86-64-v3 CPU with v3 instructions.
> +         Run equally well on all x86-64 CPUs with min support of x86-64-v3.
> +
> +config GENERIC_CPU_V4
> +       bool "Generic-x86-64-v4"
> +       depends on ( CC_IS_GCC && GCC_VERSION > 110000 ) || ( CC_IS_CLANG && CLANG_VERSION >= 120000 )
> +       depends on X86_64
> +       help
> +         Generic x86-64 CPU with v4 instructions.
> +         Run equally well on all x86-64 CPUs with min support of x86-64-v4.
> +
>  endchoice
>
>  config X86_GENERIC
> @@ -318,7 +342,7 @@ config X86_INTERNODE_CACHE_SHIFT
>  config X86_L1_CACHE_SHIFT
>         int
>         default "7" if MPENTIUM4 || MPSC
> -       default "6" if MK7 || MK8 || MPENTIUMM || MCORE2 || MATOM || MVIAC7 || X86_GENERIC || GENERIC_CPU
> +       default "6" if MK7 || MK8 || MPENTIUMM || MCORE2 || MATOM || MVIAC7 || X86_GENERIC || GENERIC_CPU || GENERIC_CPU_V2 || GENERIC_CPU_V3 || GENERIC_CPU_V4
>         default "4" if MELAN || M486SX || M486 || MGEODEGX1
>         default "5" if MWINCHIP3D || MWINCHIPC6 || MCRUSOE || MEFFICEON || MCYRIXIII || MK6 || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || M586 || MVIAC3_2 || MGEODE_LX
>
> diff --git a/arch/x86/Makefile.cpu b/arch/x86/Makefile.cpu
> index fb407ae94d90..f190feefe964 100644
> --- a/arch/x86/Makefile.cpu
> +++ b/arch/x86/Makefile.cpu
> @@ -10,3 +10,9 @@ cflags-$(CONFIG_MCORE2) += \
>  cflags-$(CONFIG_MATOM) += $(call cc-option,-march=atom) \
>         $(call cc-option,-mtune=atom,$(call cc-option,-mtune=generic))
>  cflags-$(CONFIG_GENERIC_CPU) += $(call cc-option,-mtune=generic)
> +
> +# New generic x86-64 CPU options.
> +# Don't call the compiler, we have Kconfig compiler checks for these.

You'd be surprised how quickly using time-relative words like "New"
bitrot. My copy of "Modern C++" already doesn't feel very "modern" for
example.  I'd just drop the comment block here; we don't need a
comment every time we skip cc-option checks.  Thanks for the patches!

> +cflags-$(CONFIG_GENERIC_CPU_V2) += -march=x86-64-v2
> +cflags-$(CONFIG_GENERIC_CPU_V3) += -march=x86-64-v3
> +cflags-$(CONFIG_GENERIC_CPU_V4) += -march=x86-64-v4
> --
-- 
Thanks,
~Nick Desaulniers
