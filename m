Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A752E334923
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 21:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbhCJUvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 15:51:03 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:17789 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231759AbhCJUur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 15:50:47 -0500
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 12AKoKhL021570
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 05:50:20 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 12AKoKhL021570
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1615409420;
        bh=vkspD6XwG9rG1Ytw7ZTJwsuuvU9BzfeWtF/EO7NZxcw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jlhT/zXInqDRocnQcd25cXigTXn4U2J5+fAzdADlEzZd8eepQGJbU0DMgasu75Hb3
         fVtK6bUOAVx2Lkl4r/V+Pk3w2jX8bgv2ZVEC/crxRxYxnM+O7n7SC1zS87ne/jIQEM
         keGpGgtFrPrXKTgpuZBGBAmFBjraOrSOLnpXIYfsTdDSuP1bC/KX25rhezxpcYXPKd
         BGPTu7oa2OJ486rB99VUBeSblueGjmfLBKADwgOXEb5TVNIVb0AWwcKXRShWJA5VQi
         SWHgbK9Bqt+MupI3DMfVj4O8oXB43BuUxBQ+NVAf5u6v5i7TzCK3C81GCwS0dTIXhC
         JTHbbVDp9bdwQ==
X-Nifty-SrcIP: [209.85.214.177]
Received: by mail-pl1-f177.google.com with SMTP id u18so9069771plc.12
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 12:50:20 -0800 (PST)
X-Gm-Message-State: AOAM531eZcYnIHnPLsUoIboab+hIRmHOWQrTMdywJaYuBem55a15rv5y
        Wl40TBMvu/m2VfjsfKRQJZQB27SL3h94+pqYCa0=
X-Google-Smtp-Source: ABdhPJzQ1MlUUYOx6ctKUbbI1vw5urT2osjwH23aqKEtVncC4vqvQPiS/CeJIOS6U2Zq/jZ8U8KtjFAkVIBOLG1H3Pk=
X-Received: by 2002:a17:902:8ec9:b029:e6:c5e:cf18 with SMTP id
 x9-20020a1709028ec9b02900e60c5ecf18mr4523952plo.47.1615409419575; Wed, 10 Mar
 2021 12:50:19 -0800 (PST)
MIME-Version: 1.0
References: <20210225112122.2198845-1-arnd@kernel.org> <20210226211323.arkvjnr4hifxapqu@google.com>
 <CAK8P3a2bLKe3js4SKeZoGp8B51+rpW6G3KvpbJ5=y83sxHSu6g@mail.gmail.com> <1614559739.p25z5x88wl.astroid@bobo.none>
In-Reply-To: <1614559739.p25z5x88wl.astroid@bobo.none>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 11 Mar 2021 05:49:42 +0900
X-Gmail-Original-Message-ID: <CAK7LNATUSJ5T6bs-aA3sMQgXKWfcyWJLDfhmteBhQ5FuUR52Zg@mail.gmail.com>
Message-ID: <CAK7LNATUSJ5T6bs-aA3sMQgXKWfcyWJLDfhmteBhQ5FuUR52Zg@mail.gmail.com>
Subject: Re: [PATCH] [RFC] arm64: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Arnd Bergmann <arnd@kernel.org>, Fangrui Song <maskray@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Scull <ascull@google.com>,
        Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        David Brazdil <dbrazdil@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>, Nicolas Pitre <nico@fluxnic.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 1, 2021 at 10:11 AM Nicholas Piggin <npiggin@gmail.com> wrote:
>
> Excerpts from Arnd Bergmann's message of February 27, 2021 7:49 pm:
> > On Fri, Feb 26, 2021 at 10:13 PM 'Fangrui Song' via Clang Built Linux
> > <clang-built-linux@googlegroups.com> wrote:
> >>
> >> For folks who are interested in --gc-sections on metadata sections,
> >> I want to bring you awareness of the implication of __start_/__stop_ symbols and C identifier name sections.
> >> You can see https://github.com/ClangBuiltLinux/linux/issues/1307 for a summary.
> >> (Its linked blog article has some examples.)
> >>
> >> In the kernel linker scripts, most C identifier name sections begin with double-underscore __.
> >> Some are surrounded by `KEEP(...)`, some are not.
> >>
> >> * A `KEEP` keyword has GC root semantics and makes ld --gc-sections ineffectful.
> >> * Without `KEEP`, __start_/__stop_ references from a live input section
> >>    can unnecessarily retain all the associated C identifier name input
> >>    sections. The new ld.lld option `-z start-stop-gc` can defeat this rule.
> >>
> >> As an example, a __start___jump_table reference from a live section
> >> causes all `__jump_table` input section to be retained, even if you
> >> change `KEEP(__jump_table)` to `(__jump_table)`.
> >> (If you change the symbol name from `__start_${section}` to something
> >> else (e.g. `__start${section}`), the rule will not apply.)
> >
> > I suspect the __start_* symbols are cargo-culted by many developers
> > copying stuff around between kernel linker scripts, that's certainly how I
> > approach making changes to it normally without a deeper understanding
> > of how the linker actually works or what the different bits of syntax mean
> > there.
> >
> > I see the original vmlinux.lds linker script showed up in linux-2.1.23, and
> > it contained
> >
> > +  . = ALIGN(16);               /* Exception table */
> > +  __start___ex_table = .;
> > +  __ex_table : { *(__ex_table) }
> > +  __stop___ex_table = .;
> > +
> > +  __start___ksymtab = .;       /* Kernel symbol table */
> > +  __ksymtab : { *(__ksymtab) }
> > +  __stop___ksymtab = .;
> >
> > originally for arch/sparc, and shortly afterwards for i386. The magic
> > __ex_table section was first used in linux-2.1.7 without a linker
> > script. It's probably a good idea to try cleaning these up by using
> > non-magic start/stop symbols for all sections, and relying on KEEP()
> > instead where needed.
> >
> >> There are a lot of KEEP usage. Perhaps some can be dropped to facilitate
> >> ld --gc-sections.
> >
> > I see a lot of these were added by Nick Piggin (added to Cc) in this commit:
> >
> > commit 266ff2a8f51f02b429a987d87634697eb0d01d6a
> > Author: Nicholas Piggin <npiggin@gmail.com>
> > Date:   Wed May 9 22:59:58 2018 +1000
> >
> >     kbuild: Fix asm-generic/vmlinux.lds.h for LD_DEAD_CODE_DATA_ELIMINATION
> >
> >     KEEP more tables, and add the function/data section wildcard to more
> >     section selections.
> >
> >     This is a little ad-hoc at the moment, but kernel code should be moved
> >     to consistently use .text..x (note: double dots) for explicit sections
> >     and all references to it in the linker script can be made with
> >     TEXT_MAIN, and similarly for other sections.
> >
> >     For now, let's see if major architectures move to enabling this option
> >     then we can do some refactoring passes. Otherwise if it remains unused
> >     or superseded by LTO, this may not be required.
> >
> >     Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> >     Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> >
> > which apparently was intentionally cautious.
> >
> > Unlike what Nick expected in his submission, I now think the annotations
> > will be needed for LTO just like they are for --gc-sections.
>
> Yeah I wasn't sure exactly what LTO looks like or how it would work.
> I thought perhaps LTO might be able to find dead code with circular /
> back references, we could put references from the code back to these
> tables or something so they would be kept without KEEP. I don't know, I
> was handwaving!
>
> I managed to get powerpc (and IIRC x86?) working with gc sections with
> those KEEP annotations, but effectiveness of course is far worse than
> what Nicolas was able to achieve with all his techniques and tricks.
>
> But yes unless there is some other mechanism to handle these tables,
> then KEEP probably has to stay. I suggest this wants a very explicit and
> systematic way to handle it (maybe with some toolchain support) rather
> than trying to just remove things case by case and see what breaks.
>
> I don't know if Nicolas is still been working on his shrinking patches
> recenty but he probably knows more than anyone about this stuff.
>
> Thanks,
> Nick
>


I tested LD_DEAD_CODE_DATA_ELIMINATION for the latest kernel.

I added an unused function, this_func_is_unused(),
then built the ppc kernel with LD_DEAD_CODE_DATA_ELIMINATION.

It remained in vmlinux.


masahiro@oscar:~/ref/linux$ echo  'void this_func_is_unused(void) {}'
>>  kernel/cpu.c
masahiro@oscar:~/ref/linux$ export
CROSS_COMPILE=/home/masahiro/tools/powerpc-10.1.0/bin/powerpc-linux-
masahiro@oscar:~/ref/linux$ make ARCH=powerpc  defconfig
masahiro@oscar:~/ref/linux$ ./scripts/config  -e EXPERT
masahiro@oscar:~/ref/linux$ ./scripts/config  -e LD_DEAD_CODE_DATA_ELIMINATION
masahiro@oscar:~/ref/linux$
~/tools/powerpc-10.1.0/bin/powerpc-linux-nm -n  vmlinux | grep
this_func
c000000000170560 T .this_func_is_unused
c000000001d8d560 D this_func_is_unused
masahiro@oscar:~/ref/linux$ grep DEAD_CODE_ .config
CONFIG_HAVE_LD_DEAD_CODE_DATA_ELIMINATION=y
CONFIG_LD_DEAD_CODE_DATA_ELIMINATION=y


If I remember correctly,
LD_DEAD_CODE_DATA_ELIMINATION dropped unused functions
when I tried it last time.


I also tried arm64 with a HAVE_LD_DEAD_CODE_DATA_ELIMINATION hack.
The result was the same.



Am I missing something?



-- 
Best Regards
Masahiro Yamada
