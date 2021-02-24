Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 935433240C6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 16:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238661AbhBXPZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 10:25:39 -0500
Received: from conssluserg-04.nifty.com ([210.131.2.83]:57985 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236765AbhBXOsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 09:48:04 -0500
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 11OEkvNd027539
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 23:46:57 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 11OEkvNd027539
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1614178018;
        bh=FSKQZpS/ikcO9vE4GV4mQvcieWr9RwJuDZCas6zVt0w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tgp1j9Fi/hbZJzCKpnwFHT5DU39ilgdBOzohBG40/NNaGO/xsWt90BlDB7ANgQLsP
         L6jdrBq97M0sTYsNkEQQJLDi0pcO43CC7ldtw3IKXyQErFITNAEeVbGWnZpPPGLoOt
         PrAbo+QE4OvOo3EaLiXX68u+KHICWVkuAZu5Y2477pYVdnz0ROF/fFLw5mmaWgueMI
         gDSp1fT2HwmnsTHSADb61bv9DOpM8iY9n68rjc7E78RylQH18nXBdxCk6U/FWNEHF3
         OJqOPmGwanHT8gUTnnWIX0ULu6j/8CS9KisJnJxccKEJf78YeAdxgohFrQr9EI8MjK
         hH36bwNwZwHEA==
X-Nifty-SrcIP: [209.85.210.180]
Received: by mail-pf1-f180.google.com with SMTP id q20so1458675pfu.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 06:46:57 -0800 (PST)
X-Gm-Message-State: AOAM533ISM1Uvbb3h+j8SMxELVNie/I/YXQ/s0x778v5kX6/J8q+X8J3
        4FgRuT7YeJ8NQBLClemESecx4AUyXM5Wfn751zM=
X-Google-Smtp-Source: ABdhPJwfGzHDn8uj1UvtvtqUnjmypZZ0Rn19oziygqKVXjq6PWjvcVXwgys2w/lmStVkaufmNF4u3XTdZnmO7gtFe1w=
X-Received: by 2002:a63:575e:: with SMTP id h30mr28816331pgm.7.1614178016481;
 Wed, 24 Feb 2021 06:46:56 -0800 (PST)
MIME-Version: 1.0
References: <YDUibKAt5tpA1Hxs@gunter> <CAHk-=wipCbbXswcFvnrGae01H54dY1+XoaL+9YaiU71zGzko3Q@mail.gmail.com>
 <CAHk-=wh8vHL43v7GWK9MWrWitSmOmrEw1B0AJD9CrhBc4FvpxA@mail.gmail.com>
 <CAHk-=wiuoRKa=F3txoVHvnca+H=7gJyL3SFYwd3549v-sa0+QQ@mail.gmail.com>
 <20210223200130.GA8059@lst.de> <CAHk-=wj27tmZBzFRTZTAEPd6eRBzP5xCkQM+1cuSx7vzv8K4=g@mail.gmail.com>
 <CAHk-=whudLzx0zmn+xLDmC1su6DF4oMQT6uEgjDEq0RsHRsDwA@mail.gmail.com>
 <20210224075220.GA546@lst.de> <YDZfGFhgZl0xBlZl@gunter>
In-Reply-To: <YDZfGFhgZl0xBlZl@gunter>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 24 Feb 2021 23:46:19 +0900
X-Gmail-Original-Message-ID: <CAK7LNASjyTjqoJG=EtPFTUzYv2v96qYBaaymSirS2HLGoRLpGA@mail.gmail.com>
Message-ID: <CAK7LNASjyTjqoJG=EtPFTUzYv2v96qYBaaymSirS2HLGoRLpGA@mail.gmail.com>
Subject: Re: [GIT PULL] Modules updates for v5.12
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?=EF=BF=BCMiroslav_Benes?= <mbenes@suse.cz>,
        Emil Velikov <emil.l.velikov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 24, 2021 at 11:13 PM Jessica Yu <jeyu@kernel.org> wrote:
>
> +++ Christoph Hellwig [24/02/21 08:52 +0100]:
> >On Tue, Feb 23, 2021 at 12:07:39PM -0800, Linus Torvalds wrote:
> >> On Tue, Feb 23, 2021 at 12:03 PM Linus Torvalds
> >> <torvalds@linux-foundation.org> wrote:
> >> >
> >> > This is unacceptably slow. If that symbol trimming takes 30% of the
> >> > whole kernel build time, it needs to be fixed or removed.
> >>
> >> I think I'm going to mark TRIM_UNUSED_KSYMS as "depends on BROKEN".
> >> There's no way I can accept that horrible overhead, and the rationale
> >> for that config option is questionable at best,
> >
> >I think it is pretty useful for embedded setups.
> >
> >BROKEN seems pretty strong for something that absolutely works as
> >intendended.  I guess to make you (and possibly others) not grumpy
> >we just need to ensure it doesn't get pulled in by allmodconfig.
> >
> >So maybe just invert the symbol, default the KEEP_UNUSED_SYMBOL, and
> >add a message to the helptext explaining the slowdown?
>
> Hm, something like this maybe? (untested)



I prefer a one-liner, 'depends on !COMPILE_TEST'.
!COMPILE_TEST is not super elegant, but
it is used in several spaces.



Inverting the CONFIG option is just a workaround.
A patch with many changes is not worth it.








> ---
>  From 08bc08229fc3801b1a580a07ce7ff3e806b3fe90 Mon Sep 17 00:00:00 2001
> From: Jessica Yu <jeyu@kernel.org>
> Date: Wed, 24 Feb 2021 14:54:09 +0100
> Subject: [PATCH] Kconfig: invert TRIM_UNUSED_SYMBOLS option and rename it to
>   KEEP_UNUSED_SYMBOLS
>
> Removing CONFIG_UNUSED_SYMBOLS (commit 367948220fce "module: remove
> EXPORT_UNUSED_SYMBOL*") unhid the CONFIG_TRIM_UNUSED_SYMBOLS option and
> therefore it now gets automatically enabled with allyesconfig.
>
> To prevent allyesconfig from enabling TRIM_UNUSED_SYMBOLS (which is known
> to slow build times), invert the config option and name it
> KEEP_UNUSED_SYMBOLS, which does the same thing as TRIM_UNUSED_SYMBOLS=n.
> That way, allyesconfig will keep the previous behavior of not trimming
> symbols.
>
> Signed-off-by: Jessica Yu <jeyu@kernel.org>
> ---
>   Makefile                            |  4 ++--
>   arch/mips/configs/generic_defconfig |  2 +-
>   include/asm-generic/export.h        |  2 +-
>   include/linux/export.h              |  2 +-
>   init/Kconfig                        | 21 +++++++++++----------
>   kernel/livepatch/Kconfig            |  2 +-
>   scripts/Makefile.build              |  2 +-
>   7 files changed, 18 insertions(+), 17 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index b18dbc634690..23f50521e97f 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1164,7 +1164,7 @@ vmlinux-deps := $(KBUILD_LDS) $(KBUILD_VMLINUX_OBJS) $(KBUILD_VMLINUX_LIBS)
>
>   # Recurse until adjust_autoksyms.sh is satisfied
>   PHONY += autoksyms_recursive
> -ifdef CONFIG_TRIM_UNUSED_KSYMS
> +ifndef CONFIG_KEEP_UNUSED_KSYMS
>   # For the kernel to actually contain only the needed exported symbols,
>   # we have to build modules as well to determine what those symbols are.
>   # (this can be evaluated only once include/config/auto.conf has been included)
> @@ -1175,7 +1175,7 @@ autoksyms_recursive: descend modules.order
>           "$(MAKE) -f $(srctree)/Makefile vmlinux"
>   endif
>
> -autoksyms_h := $(if $(CONFIG_TRIM_UNUSED_KSYMS), include/generated/autoksyms.h)
> +autoksyms_h := $(if $(CONFIG_KEEP_UNUSED_KSYMS),,include/generated/autoksyms.h)
>
>   quiet_cmd_autoksyms_h = GEN     $@
>         cmd_autoksyms_h = mkdir -p $(dir $@); \
> diff --git a/arch/mips/configs/generic_defconfig b/arch/mips/configs/generic_defconfig
> index 714169e411cf..d46da28ea032 100644
> --- a/arch/mips/configs/generic_defconfig
> +++ b/arch/mips/configs/generic_defconfig
> @@ -29,7 +29,7 @@ CONFIG_MIPS_O32_FP64_SUPPORT=y
>   CONFIG_JUMP_LABEL=y
>   CONFIG_MODULES=y
>   CONFIG_MODULE_UNLOAD=y
> -CONFIG_TRIM_UNUSED_KSYMS=y
> +CONFIG_KEEP_UNUSED_KSYMS=n
>   CONFIG_NET=y
>   CONFIG_PACKET=y
>   CONFIG_UNIX=y
> diff --git a/include/asm-generic/export.h b/include/asm-generic/export.h
> index 07a36a874dca..06d401464195 100644
> --- a/include/asm-generic/export.h
> +++ b/include/asm-generic/export.h
> @@ -57,7 +57,7 @@ __kstrtab_\name:
>   #endif
>   .endm
>
> -#if defined(CONFIG_TRIM_UNUSED_KSYMS)
> +#if !defined(CONFIG_KEEP_UNUSED_KSYMS)
>
>   #include <linux/kconfig.h>
>   #include <generated/autoksyms.h>
> diff --git a/include/linux/export.h b/include/linux/export.h
> index 6271a5d9c988..449f7d15e580 100644
> --- a/include/linux/export.h
> +++ b/include/linux/export.h
> @@ -118,7 +118,7 @@ struct kernel_symbol {
>    */
>   #define __EXPORT_SYMBOL(sym, sec, ns)
>
> -#elif defined(CONFIG_TRIM_UNUSED_KSYMS)
> +#elif !defined(CONFIG_KEEP_UNUSED_KSYMS)
>
>   #include <generated/autoksyms.h>
>
> diff --git a/init/Kconfig b/init/Kconfig
> index ba8bd5256980..db5d00bfc239 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -2272,29 +2272,30 @@ config MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS
>
>           If unsure, say N.
>
> -config TRIM_UNUSED_KSYMS
> -       bool "Trim unused exported kernel symbols"
> -       depends on BROKEN
> +config KEEP_UNUSED_KSYMS
> +       bool "Keep unused exported kernel symbols"
> +       default y
>         help
>           The kernel and some modules make many symbols available for
>           other modules to use via EXPORT_SYMBOL() and variants. Depending
>           on the set of modules being selected in your kernel configuration,
>           many of those exported symbols might never be used.
>
> -         This option allows for unused exported symbols to be dropped from
> -         the build. In turn, this provides the compiler more opportunities
> -         (especially when using LTO) for optimizing the code and reducing
> -         binary size.  This might have some security advantages as well.
> +         This option allows for unused exported symbols to be kept in the
> +         build. Say N when you want to trim unused symbols from the build,
> +         which provides the compiler more opportunities (especially when using LTO)
> +         for optimizing the code and reducing binary size. This might have some
> +         security advantages as well.
>
> -         If unsure, or if you need to build out-of-tree modules, say N.
> +         If unsure, or if you need to build out-of-tree modules, say Y.
>
>   config UNUSED_KSYMS_WHITELIST
>         string "Whitelist of symbols to keep in ksymtab"
> -       depends on TRIM_UNUSED_KSYMS
> +       depends on !KEEP_UNUSED_KSYMS
>         default "scripts/lto-used-symbollist.txt" if LTO_CLANG
>         help
>           By default, all unused exported symbols will be un-exported from the
> -         build when TRIM_UNUSED_KSYMS is selected.
> +         build when KEEP_UNUSED_KSYMS is not selected.
>
>           UNUSED_KSYMS_WHITELIST allows to whitelist symbols that must be kept
>           exported at all times, even in absence of in-tree users. The value to
> diff --git a/kernel/livepatch/Kconfig b/kernel/livepatch/Kconfig
> index 53d51ed619a3..df8ebb7984e1 100644
> --- a/kernel/livepatch/Kconfig
> +++ b/kernel/livepatch/Kconfig
> @@ -11,7 +11,7 @@ config LIVEPATCH
>         depends on SYSFS
>         depends on KALLSYMS_ALL
>         depends on HAVE_LIVEPATCH
> -       depends on !TRIM_UNUSED_KSYMS
> +       depends on KEEP_UNUSED_KSYMS
>         help
>           Say Y here if you want to support kernel live patching.
>           This option has no runtime impact until a kernel "patch"
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 3f6bf0ea7c0e..e5e95a6948a7 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -242,7 +242,7 @@ objtool_dep = $(objtool_obj)                                        \
>               $(wildcard include/config/orc/unwinder.h          \
>                          include/config/stack/validation.h)
>
> -ifdef CONFIG_TRIM_UNUSED_KSYMS
> +ifndef CONFIG_KEEP_UNUSED_KSYMS
>   cmd_gen_ksymdeps = \
>         $(CONFIG_SHELL) $(srctree)/scripts/gen_ksymdeps.sh $@ >> $(dot-target).cmd
>


--
Best Regards
Masahiro Yamada
