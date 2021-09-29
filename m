Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07A4541CC22
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 20:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346353AbhI2SyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 14:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346078AbhI2SyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 14:54:06 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC2FC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 11:52:24 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id x27so14929992lfu.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 11:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XRmGnlRvtNOeHtwOVOG8aQf7ZqqfjZr/UrlT6xJCshY=;
        b=ouvL1PrG01tFgjQ4aVDHTeUVJZ68s9IQbFf+IsLJdd6MCc939SLpWSW/e2x4ZZst1r
         NwyK2gaCY4ddAMU7AZiXEnHD2ogx/+y/MbhrpI000YAR8dF061+zGO/vjNQXiZQttEb/
         k/if5rEj6+3jWrd5ulbBVfXZuR9NrySejc8XLCaJl5srRFbgA32LsNdTnQ6/qr2IYyL6
         0lpCXPt7tF+no44k7uf2cUjgpt+u33utaaHNqif8qJbaDn0RPs2Rhxpn+Yp3jBeyBkf8
         kptTY8ozbK86smYJt+q5JPplyNZvMOwLTUu7pHrzyTN69QhfAMoNODwC5B0Lmicv32Cj
         9znw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XRmGnlRvtNOeHtwOVOG8aQf7ZqqfjZr/UrlT6xJCshY=;
        b=5u+JXjnQvmoV1n0qZ+gWro2Zoz7b0emFG4EkJnjoIb++5Q+9ek7TqPR1FpHfTkc3am
         yVRpGYkUoebsAFDd728J5jq4YYdOUcNfBKj7HNR1b/XtQO6t2l7as6O+bKzt8Il4NkZX
         DczNfBRmNPH59hDOIYzcWU/NHGznsEvp+illXExfnXlnfz9fTdaaYa3iLtS3C/RCd7uF
         vgpqvmDNh6vRrHRxA2f7BBSBrhdtwB9KGm34FAiogSpP6Kiw0aaSLxSCIB57GnTVTxLp
         sJK5Y0B55O+S7JH4x8vT9WHIyJxff1m3fD840PI6yG+G+XAPHD1X61RbPOK7cLbPxtv3
         DrGg==
X-Gm-Message-State: AOAM533fxLamJUftlFkmpCcIYk0n04bazAlaPr+oDyq/JffZxiSs1uQY
        awCZojAQ3MlwD2jjeA5r5mRdDZbbpWA1KCaGdtwt8w==
X-Google-Smtp-Source: ABdhPJzQp606ZVarTh/9VWVFUDoxcP61zHZNFofvpjTDSYc0fZf7i/XrM23ixzGm7yk+pc3qYx9jh9vWjuurzAtRAAo=
X-Received: by 2002:a05:6512:110a:: with SMTP id l10mr1245290lfg.550.1632941542741;
 Wed, 29 Sep 2021 11:52:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210928154143.2106903-1-arnd@kernel.org> <20210928154143.2106903-7-arnd@kernel.org>
In-Reply-To: <20210928154143.2106903-7-arnd@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 29 Sep 2021 11:52:11 -0700
Message-ID: <CAKwvOdngJj-b=MJ2-Bik6dQGoambMZxGdZyVeO0O5KkaMhhU3Q@mail.gmail.com>
Subject: Re: [PATCH 06/14] ARM: disallow CONFIG_THUMB with ARMv4
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev,
        David Spickett <david.spickett@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 8:42 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> We can currently build a multi-cpu enabled kernel that allows both ARMv4
> and ARMv5 CPUs, and also supports THUMB mode in user space.
>
> However, returning to user space in this configuration with the usr_ret
> macro requires the use of the 'bx' instruction, which is refused by
> the assembler:
>
> arch/arm/kernel/entry-armv.S: Assembler messages:
> arch/arm/kernel/entry-armv.S:937: Error: selected processor does not support `bx lr' in ARM mode
> arch/arm/kernel/entry-armv.S:960: Error: selected processor does not support `bx lr' in ARM mode
> arch/arm/kernel/entry-armv.S:1003: Error: selected processor does not support `bx lr' in ARM mode
> <instantiation>:2:2: note: instruction requires: armv4t
>  bx lr
>
> While it would be possible to handle this correctly in principle, doing so
> seems to not be worth it, if we can simply avoid the problem by enforcing

does `mov pc, lr` work here, with a preprocessor guard on CPU_32v4? Or
better yet...

If `ret` is just an assembler macro
(arch/arm/include/asm/assembler.h#L449), then perhaps always just
using `ret` would be preferable here? In that case, it looks like
`usr_ret` could be outright replaced with just expansions of `ret`?

Just spitballing ideas; like you said, maybe not worth fixing.

> that a kernel supporting both ARMv4 and a later CPU architecture cannot
> run THUMB binaries.
>
> This turned up while build-testing with clang; for some reason,
> gcc never triggered the problem.

I suspect this is a Clang's integrated assembler vs GAS difference
(compiler irrelevant); clang's assembler is more strict that `bx lr`
requires armvt (CPU_32v4T).  Though I can reproduce that exact message
in local testing with GAS:

$ cat foo.s
bx lr
$ arm-linux-gnueabi-as -march=armv4 -c foo.s
foo.s: Assembler messages:
foo.s:1: Error: selected processor does not support `bx lr' in ARM mode
$ arm-linux-gnueabi-as -march=armv4t -c foo.s
$ arm-linux-gnueabi-objdump -dr a.out
...
00000000 <.text>:
   0:   e12fff1e        bx      lr
                        0: R_ARM_V4BX   *ABS*

The `<instantiation>:2:2` makes me think of inline asm.

>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  arch/arm/mm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
> index 82aa990c4180..58afba346729 100644
> --- a/arch/arm/mm/Kconfig
> +++ b/arch/arm/mm/Kconfig
> @@ -675,7 +675,7 @@ config ARM_PV_FIXUP
>
>  config ARM_THUMB
>         bool "Support Thumb user binaries" if !CPU_THUMBONLY && EXPERT
> -       depends on CPU_THUMB_CAPABLE
> +       depends on CPU_THUMB_CAPABLE && !CPU_32v4
>         default y
>         help
>           Say Y if you want to include kernel support for running user space
> --
> 2.29.2
>


-- 
Thanks,
~Nick Desaulniers
