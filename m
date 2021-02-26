Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93CDA325B01
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 01:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbhBZAgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 19:36:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbhBZAgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 19:36:53 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB60C061574
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 16:36:13 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id o11so21267iob.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 16:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=zSQkfXYILeFIsnw9KPEpR0PnZSHnbzsSZbKt0dU2Xn4=;
        b=Sd2TROa1mctfXj+UUVvMkeau6EdMtkXhi9JcWQa1ABoOk15mmQEdyYhU+yxe/qx6s9
         zp8p2HujWwDhdWUEeEB3fi5JHzUGeIGl/H/55kyI7XzRbVz5fSqE8bVGYnod2vvjJrlf
         x+0M7U2kJ/8v7oli95zqvEhfSHLYixt9T3XaHT4xjIMH98zWyMx9qKwoZYEJJVj/8PyR
         +JAsUJ53DqavDuoq3j1i1c16JjNXDpeTOH0UsZoGICAO41H3fAJlq3vhAB+j7AGKOFkp
         dbg+hXP55ZUefNxzbfLNYByV6X39QrDFgiuoLXPjArU66RoRoHjI/n7D/LpakwAnSztL
         ZDLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=zSQkfXYILeFIsnw9KPEpR0PnZSHnbzsSZbKt0dU2Xn4=;
        b=Yss5fLUsTdQ1GrNxmfdEStjFkpPmaKqo+jsCYAKM7oxLYiKU+Q4tIMOLAQ+B+FgUJ4
         ViURU6Wny04ZH3/4fiRpfMtBS2vYLkUvtgCeTUTmBTGbI7QpjxVrxI7viWjIsBEd5sIh
         qFh8hb1UrZBSQ8Uu7EJrlBO3LE1QL4B2D2qsfyb2nsIRgkN4cUNHJqKHUZ866vmGgyzw
         qvIiCwYQZDeYyClaBHTo+18N3ONpwAmt1WyI7fwxRMhiGTqHEfPn8nnFEWho9V+0T05O
         y/rLn9NPk3wCtQ8R+G6Cuhb9EJKpKulU2arWwL2IwMi3uACNnT3nDTgkB+yqq2E3PpQM
         CJYA==
X-Gm-Message-State: AOAM5334knY6JTZtUUjlBMPQm8dnbUN3yILr/HXWLZfzqcX2WYv3bI8P
        3BHfOfkww6Cb1u90DxKse3w/r4u4A5/Ipkud6Yc=
X-Google-Smtp-Source: ABdhPJy+HgJo8xZYh16y+XIWLiocSWn6g+3sgej1nJA5g8zRH7hTxPUUiakJxfGih26J0RCMxq0pOstjqZSE5Nxb+QU=
X-Received: by 2002:a02:b890:: with SMTP id p16mr399359jam.138.1614299773124;
 Thu, 25 Feb 2021 16:36:13 -0800 (PST)
MIME-Version: 1.0
References: <20210225112122.2198845-1-arnd@kernel.org>
In-Reply-To: <20210225112122.2198845-1-arnd@kernel.org>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 26 Feb 2021 01:36:02 +0100
Message-ID: <CA+icZUUDnKBxkfgOVYDdpA29GnLUTT22mqRNyxQeYmay044ejg@mail.gmail.com>
Subject: Re: [PATCH] [RFC] arm64: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Scull <ascull@google.com>,
        David Brazdil <dbrazdil@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 12:21 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> When looking at kernel size optimizations, I found that arm64
> does not currently support HAVE_LD_DEAD_CODE_DATA_ELIMINATION,
> which enables the --gc-sections flag to the linker.
>
> I see that for a defconfig build with llvm, there are some
> notable improvements from enabling this, in particular when
> combined with the recently added CONFIG_LTO_CLANG_THIN
> and CONFIG_TRIM_UNUSED_KSYMS:
>
>    text    data     bss     dec     hex filename
> 16570322 10998617 506468 28075407 1ac658f defconfig/vmlinux
> 16318793 10569913 506468 27395174 1a20466 trim_defconfig/vmlinux
> 16281234 10984848 504291 27770373 1a7be05 gc_defconfig/vmlinux
> 16029705 10556880 504355 27090940 19d5ffc gc+trim_defconfig/vmlinux
> 17040142 11102945 504196 28647283 1b51f73 thinlto_defconfig/vmlinux
> 16788613 10663201 504196 27956010 1aa932a thinlto+trim_defconfig/vmlinux
> 16347062 11043384 502499 27892945 1a99cd1 gc+thinlto_defconfig/vmlinux
> 15759453 10532792 502395 26794640 198da90 gc+thinlto+trim_defconfig/vmlinux
>

Thanks for the numbers.
Does CONFIG_TRIM_UNUSED_KSYMS=y have an impact to the build-time (and
disc-usage - negative way means longer/bigger)?
Do you have any build-time for the above numbers?

BTW, is CONFIG_LD_DEAD_CODE_DATA_ELIMINATION=y setable for x86 (64bit)?
( Did not look or check for it. )

- Sedat -

> I needed a small change to the linker script to get clean randconfig
> builds, but I have not done any meaningful boot testing on it to
> see if it works. If there are no regressions, I wonder whether this
> should be autmatically done for LTO builds, given that it improves
> both kernel size and compile speed.
>
> Link: https://lore.kernel.org/lkml/CAK8P3a05VZ9hSKRzVTxTn+1nf9E+gqebJWTj6N23nfm+ELHt9A@mail.gmail.com/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm64/Kconfig              | 1 +
>  arch/arm64/kernel/vmlinux.lds.S | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index b94a678afce4..75e13cc52928 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -2,6 +2,7 @@
>  config ARM64
>         def_bool y
>         select ACPI_CCA_REQUIRED if ACPI
> +       select HAVE_LD_DEAD_CODE_DATA_ELIMINATION
>         select ACPI_GENERIC_GSI if ACPI
>         select ACPI_GTDT if ACPI
>         select ACPI_IORT if ACPI
> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> index bad2b9eaab22..926cdb597a45 100644
> --- a/arch/arm64/kernel/vmlinux.lds.S
> +++ b/arch/arm64/kernel/vmlinux.lds.S
> @@ -217,7 +217,7 @@ SECTIONS
>                 INIT_CALLS
>                 CON_INITCALL
>                 INIT_RAM_FS
> -               *(.init.altinstructions .init.bss .init.bss.*)  /* from the EFI stub */
> +               *(.init.altinstructions .init.data.* .init.bss .init.bss.*)     /* from the EFI stub */
>         }
>         .exit.data : {
>                 EXIT_DATA
> --
> 2.29.2
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20210225112122.2198845-1-arnd%40kernel.org.
