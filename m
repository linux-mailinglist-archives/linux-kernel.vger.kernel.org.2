Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12664424217
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 18:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239338AbhJFQD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 12:03:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:39430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239332AbhJFQD0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 12:03:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2E502610CC
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 16:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633536094;
        bh=ZlaiC0n6P5r9j8bdKPC7sgApMtJMYoiumv6YMDwMIYE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cRq8b+GkF+Z16Yxq4pCkXjHpb0Lt1XIkRzLrmviXQKI457GNdGL32P6BZBGwT2wFx
         V+Cp3cOEpmbSOOZ7v+bOmFVH2e7O3pVLtvdL7fvlcyGwmzxwJsq9wyZ/WwxcLD5ysa
         BTfXJrs8lGHwVmbMrmugHv4jrgQb56nTCz58JACf5xYejs7dwfz3JQxcoinR80V1by
         I1b9uSO4ZqnF/ErYvzn2Q5VImQWROOBe4CD+/iN1IEYzJRxxi6RVqFkxIJGQVMrflM
         sGaZZNfdi5RifYwlmvvtF4rINu2UMNGMjs1NsIlklSZCGIUBVg+Me/WsHpXjxUFyLA
         2EJs8sai5pFBw==
Received: by mail-ot1-f52.google.com with SMTP id j11-20020a9d190b000000b00546fac94456so3669943ota.6
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 09:01:34 -0700 (PDT)
X-Gm-Message-State: AOAM532Sf3jKVygQ0gtcIcKpNBZtJF+G1LDo8qCu/F8ESxzoEcR7N6ut
        cg1VTjxvanPmHbPKDx2mlv3Tu03BAb+tMbrlYSI=
X-Google-Smtp-Source: ABdhPJyZQ57EKW43tv7SPSNvfHisRpT/RfL8WcMrAs9oQM6KMMZU8HVVF10G0DOUcga9tCV5zpzCtvKLo6ZGqAckfAU=
X-Received: by 2002:a05:6830:3189:: with SMTP id p9mr19970544ots.147.1633536093391;
 Wed, 06 Oct 2021 09:01:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210928154143.2106903-1-arnd@kernel.org> <20210928154143.2106903-7-arnd@kernel.org>
In-Reply-To: <20210928154143.2106903-7-arnd@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 6 Oct 2021 18:01:22 +0200
X-Gmail-Original-Message-ID: <CAMj1kXF-iJj2cg=M8BD96OE8ozA_vB8yEN+f8HvRHY=VYb0pwg@mail.gmail.com>
Message-ID: <CAMj1kXF-iJj2cg=M8BD96OE8ozA_vB8yEN+f8HvRHY=VYb0pwg@mail.gmail.com>
Subject: Re: [PATCH 06/14] ARM: disallow CONFIG_THUMB with ARMv4
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Sept 2021 at 17:42, Arnd Bergmann <arnd@kernel.org> wrote:
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
> that a kernel supporting both ARMv4 and a later CPU architecture cannot
> run THUMB binaries.
>

I had a quick look, and it seems that the only way to handle this
correctly is to emit the BX instructions, and use code patching to
change them into 'mov pc, <reg>' if the runtime detected CPU is not
Thumb capable. The usual approach (emitting 'tst <reg>, #1; moveq pc,
<reg>; bx lr') is not feasible here, since we run out of space in the
kuser helper slots.

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

> This turned up while build-testing with clang; for some reason,
> gcc never triggered the problem.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
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
