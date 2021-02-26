Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9362325EBB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 09:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbhBZIPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 03:15:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:51750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229482AbhBZIPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 03:15:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7190664EE4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 08:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614327266;
        bh=Eo2tKPNmvmbEpnYKsR3W4TzcmK2bAwkJr9OFxHhNTPA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=n9feerzoyPz2GZ1ZWK1yrvTGwB6yEs646LEEIwgf7C/AxiSw1HkJ1UDS5DTSU0HaK
         NCEi76biGLZq5PjDczGLDUlR7SS8FIkYe9iMBhaFws0nHm0zqpl1G+NZIyd7sE3jrJ
         AaBUM0fFJX7gyDd8VLBJj3w+NTejzSr0+sshpbmViDOyvorzt5+QeL4PMYnfeUEDcf
         tYq6O0Exx8b0A8jSP36lVis0LRaxGCR2l/1qRqY1tKXx19wxa2LQvHdRcms1Q/5Tgr
         tkScCnD7bSzEa7OeB8kUsp9STZtsg/pHAH3NB51aFPpksHpjFGIC7A2/FTqkk3M4Vt
         s0kyF7vWlYF4Q==
Received: by mail-oi1-f176.google.com with SMTP id d20so8933944oiw.10
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 00:14:26 -0800 (PST)
X-Gm-Message-State: AOAM5323JYA6G7ACulX377qr4aKZ1PjFNylGWUMFwsql3uJvTCSYRpnl
        d/54TXPw8jB5ssHeD3y481bhCZnEeIWtmLEQS/4=
X-Google-Smtp-Source: ABdhPJzKfPEDoJuQo8Zs6R2bVcnz5F6nl0/rf60VZJ1iVoxVaQpBMnDHAU0IhDLZCa06jnEc6nzP5E4WZDvA54/7xEg=
X-Received: by 2002:aca:4a47:: with SMTP id x68mr1202138oia.67.1614327265563;
 Fri, 26 Feb 2021 00:14:25 -0800 (PST)
MIME-Version: 1.0
References: <20210225112122.2198845-1-arnd@kernel.org> <CA+icZUUDnKBxkfgOVYDdpA29GnLUTT22mqRNyxQeYmay044ejg@mail.gmail.com>
In-Reply-To: <CA+icZUUDnKBxkfgOVYDdpA29GnLUTT22mqRNyxQeYmay044ejg@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 26 Feb 2021 09:14:09 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1QmS6g3cHTR93wWPkKs8vaP6RJEb8nZbTMLX+xphLJRw@mail.gmail.com>
Message-ID: <CAK8P3a1QmS6g3cHTR93wWPkKs8vaP6RJEb8nZbTMLX+xphLJRw@mail.gmail.com>
Subject: Re: [PATCH] [RFC] arm64: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
To:     Sedat Dilek <sedat.dilek@gmail.com>
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
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 1:36 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Thu, Feb 25, 2021 at 12:21 PM Arnd Bergmann <arnd@kernel.org> wrote:
> >
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > When looking at kernel size optimizations, I found that arm64
> > does not currently support HAVE_LD_DEAD_CODE_DATA_ELIMINATION,
> > which enables the --gc-sections flag to the linker.
> >
> > I see that for a defconfig build with llvm, there are some
> > notable improvements from enabling this, in particular when
> > combined with the recently added CONFIG_LTO_CLANG_THIN
> > and CONFIG_TRIM_UNUSED_KSYMS:
> >
> >    text    data     bss     dec     hex filename
> > 16570322 10998617 506468 28075407 1ac658f defconfig/vmlinux
> > 16318793 10569913 506468 27395174 1a20466 trim_defconfig/vmlinux
> > 16281234 10984848 504291 27770373 1a7be05 gc_defconfig/vmlinux
> > 16029705 10556880 504355 27090940 19d5ffc gc+trim_defconfig/vmlinux
> > 17040142 11102945 504196 28647283 1b51f73 thinlto_defconfig/vmlinux
> > 16788613 10663201 504196 27956010 1aa932a thinlto+trim_defconfig/vmlinux
> > 16347062 11043384 502499 27892945 1a99cd1 gc+thinlto_defconfig/vmlinux
> > 15759453 10532792 502395 26794640 198da90 gc+thinlto+trim_defconfig/vmlinux
> >
>
> Thanks for the numbers.
> Does CONFIG_TRIM_UNUSED_KSYMS=y have an impact to the build-time (and
> disc-usage - negative way means longer/bigger)?
> Do you have any build-time for the above numbers?

They are in the mailing list archive I linked to:

==== defconfig ====
     332.001786355 seconds time elapsed
    8599.464163000 seconds user
     676.919635000 seconds sys
==== trim_defconfig ====
     448.378576012 seconds time elapsed
   10735.489271000 seconds user
     964.006504000 seconds sys
==== gc_defconfig ====
     324.347492236 seconds time elapsed
    8465.785800000 seconds user
     614.899797000 seconds sys
==== gc+trim_defconfig ====
     429.188875620 seconds time elapsed
   10203.759658000 seconds user
     871.307973000 seconds sys
==== thinlto_defconfig ====
     389.793540200 seconds time elapsed
    9491.665320000 seconds user
     664.858109000 seconds sys
==== thinlto+trim_defconfig ====
     580.431820561 seconds time elapsed
   11429.515538000 seconds user
    1056.985745000 seconds sys
==== gc+thinlto_defconfig ====
     389.484364525 seconds time elapsed
    9473.831980000 seconds user
     675.057675000 seconds sys
==== gc+thinlto+trim_defconfig ====
     580.824912807 seconds time elapsed
   11433.650337000 seconds user
    1049.845569000 seconds sys

So HAVE_LD_DEAD_CODE_DATA_ELIMINATION is a small improvement
on build time (since it can spend less time linking), while
CONFIG_TRIM_UNUSED_KSYMS slows it down quite a bit. Combining
CONFIG_TRIM_UNUSED_KSYMS with CONFIG_THINLTO is really
slow because here most of the time is spent in the final link (especially
when you have many CPU cores to do the earlier bits quickly), but then
it does the link twice.

> BTW, is CONFIG_LD_DEAD_CODE_DATA_ELIMINATION=y setable for x86 (64bit)?
> ( Did not look or check for it. )

No, in mainline, HAVE_LD_DEAD_CODE_DATA_ELIMINATION is currently
only selected on MIPS and PowerPC. I only sent experimental patches to
enable it on arm64 and m68k, but have not tried booting them. If you
select the symbol on x86, you should see similar results.

       Arnd
