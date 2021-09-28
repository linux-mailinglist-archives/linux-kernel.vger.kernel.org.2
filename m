Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B25F41B4E6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 19:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241988AbhI1RWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 13:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241944AbhI1RWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 13:22:37 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3081CC06161C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 10:20:57 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id b15so93792275lfe.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 10:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oovrzJURHWJ6qCmrUM9JSWjLkbl3a0JTJO2dczu7GzA=;
        b=Ok+ALmAEK+cZnQ6LuSSxPh+ShUTJqGCiOvmoU/FE8+AFDbt3w2xhf+OJV+wicegC6O
         zU2DU4rpLyA0i2Uy7MMceYMncHY/4DZIXQRThvvvLyG/WcXtf+4JNsa58sUAo+1aj/mX
         ON0HnvzkhDxEhQLZSLEsq4CHpc1tpzlgy0y2FlvYGd1Ocrkzy5HD82giCejK//R+7hGc
         2LZXlfyICmNNA6D/mQkr26WrfwwJpQotDXTrg9YhgOu16u0AqgkKz6M5PqcrV+1Auksa
         BIEPMAbqdhZe9qWJWdZokywf9Qi+0eW8StkBU5rPa+QxgyIrvn+v+bk9IsszNjTqpzbV
         L+IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oovrzJURHWJ6qCmrUM9JSWjLkbl3a0JTJO2dczu7GzA=;
        b=of2kTKoPqzPPJNrh90oPgRfoQmqSE9+1luu8bhHzLVI5hdaTg1OmaOz3LX84kBiD7g
         AU780y18A/zf9i1KBGd+HSWxyryNtnU1KDGmLS6t67+x87MBFXZb+YIUR6/mcfoXv/qq
         d68W7mmCS1FhRdNzI3RHHaYqGnfBfaef2i/DOpY7U0F2TSbaRjJBS5WVszWkpembh6d7
         Fjqq6A0LWr4rdVwrGPoXfxv5EDI+cjWk1TKcdr749nL5iJS8IKFVivdBwrA3GawRVPSV
         ddByO6vQg5bE2lAQlmfW9DA/Ynqz5l4cgUL9dOK1cWwqTvpHfgEUn1T4wmxyIOkCtjr9
         XClw==
X-Gm-Message-State: AOAM530BW8tR4l/u4cIF//urqNLSktiAvB06Mc9HveMKWuiOahvgcynt
        3n0zSfI69A26+1XjZshu0fbAyIzXAKg7vkD/71Fa7mtGF+4vBg==
X-Google-Smtp-Source: ABdhPJwui+sJR23H1nkOUy19dPvbUaqlhgFcXDNU9AQv+t/weNik7LllxBjVxzZsr61RZATSJV00S+5+8Lx+VKX9mTg=
X-Received: by 2002:a05:6512:b0c:: with SMTP id w12mr6917372lfu.240.1632849654306;
 Tue, 28 Sep 2021 10:20:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210928154143.2106903-1-arnd@kernel.org> <20210928154143.2106903-15-arnd@kernel.org>
In-Reply-To: <20210928154143.2106903-15-arnd@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 28 Sep 2021 10:20:42 -0700
Message-ID: <CAKwvOdmhZiOQ1h6_qfOxTKkzoA+Go8BCp-GEUZ6LNQpd0cimzA@mail.gmail.com>
Subject: Re: [PATCH 14/14] [RFC] ARM: forbid ftrace with clang and thumb2_kernel
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev,
        Peter Smith <Peter.Smith@arm.com>,
        Kristof Beyls <Kristof.Beyls@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 8:42 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> clang fails to build kernels with THUMB2 and FUNCTION_TRACER
> enabled when there is any inline asm statement containing
> the frame pointer register r7:
>
> arch/arm/mach-versatile/dcscb.c:95:2: error: inline asm clobber list contains reserved registers: R7 [-Werror,-Winline-asm]

^ This file no longer exists in tree?

> arch/arm/mach-exynos/mcpm-exynos.c:154:2: error: inline asm clobber list contains reserved registers: R7 [-Werror,-Winline-asm]
> arch/arm/probes/kprobes/actions-thumb.c:449:3: error: inline asm clobber list contains reserved registers: R7 [-Werror,-Winline-asm]
>
> Apparently gcc should also have warned about this, and the
> configuration is actually invalid, though there is some
> disagreement on the bug trackers about this.
>
> Link: https://bugs.llvm.org/show_bug.cgi?id=45826
> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=94986
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  arch/arm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 0d4f3e2d50ad..7ea95bb40004 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -91,7 +91,7 @@ config ARM
>         select HAVE_FAST_GUP if ARM_LPAE
>         select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
>         select HAVE_FUNCTION_GRAPH_TRACER if !THUMB2_KERNEL && !CC_IS_CLANG
> -       select HAVE_FUNCTION_TRACER if !XIP_KERNEL
> +       select HAVE_FUNCTION_TRACER if !XIP_KERNEL && !(THUMB2_KERNEL && CC_IS_CLANG)
>         select HAVE_GCC_PLUGINS
>         select HAVE_HW_BREAKPOINT if PERF_EVENTS && (CPU_V6 || CPU_V6K || CPU_V7)
>         select HAVE_IRQ_TIME_ACCOUNTING
> --
> 2.29.2
>
>


-- 
Thanks,
~Nick Desaulniers
