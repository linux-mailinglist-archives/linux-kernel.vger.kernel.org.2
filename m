Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6B7325FA1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 10:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbhBZJGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 04:06:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbhBZJGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 04:06:17 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE9FC061574
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 01:05:37 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id h18so7423773ils.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 01:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=iJFcEa8Md91qPWXA3MXvjPfvCleZ0GnvsYYC4ySVP+o=;
        b=oA7LpeV2NWTkmefvnjytWUbuioCKdL76JXwpDCmEBWRl5Dxzxtv98QZcdVGF+bqRoY
         LU8FrgQVh0PYoofW1nI5TjZhcw9KMId048a81IMI787u4wdw3vFkzgHo3ClNkN3seChs
         XUfehXx3FDHvRmsWLBYZv6L0C9zZh+TzmK3IPJAherycNB7+QCmyknEGf2m9yPnvzT+Z
         YvjchNOYArIhbHg+EmLTSd53D0fa3HPHLdGV9AbtjoncJ6dKo/ymJonp6rLanQn3Mmy7
         zLvQuq7l7gCW3ejophB6kLamZ3rw0fa8/5fcBzwj/RkegcleIyHxx9lvJ9fCL8l/daqO
         jQ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=iJFcEa8Md91qPWXA3MXvjPfvCleZ0GnvsYYC4ySVP+o=;
        b=bzIRoKqBIXrMqWUV5MfFssi+RWqzbG1M2IajqkQhIanvIRyu72lAiYmu8NPdhntExw
         BVccGZ5wb4ggTAjqIKWcFiWG9pOsIOTgcjdOYxTiJRLh5yQAujNi+3ZXimT8vCfMKNVh
         fgeP20Ql596qEyWa33qnhg/OL0SczmfDeay0DKTKZJd8n+zyONVpdqJhE3S5XNphsqxj
         WH2LhPHIqwQg4xOtxVIhMetgm2yQg+utiI+BQINbejk8diun0NHOIo3vvN6eFcLCHOn/
         er2aLZDIA4yqXh0G8WAObkOhS010nBCKwpbXnpv/YHUpQ/druCiSw5DX/6aavsYv3rQn
         0IBw==
X-Gm-Message-State: AOAM533NYh9Zix0xRbEv1xNDNdRCaO0jrd1o+LP/5kV+U1jOFflG7DXp
        fXdcl4js1XgR+hVsyiB/mDQhZ3r5Vr9mqk7Af4Y=
X-Google-Smtp-Source: ABdhPJxJdT4evrWcbSdoiw3WukuOy3FxkfxhS41IQTGQfZXs8eoE86pLFeaDm5G7ZJzEgbv+Fd9brpgE9VVYgw/ciH8=
X-Received: by 2002:a92:c145:: with SMTP id b5mr1599185ilh.186.1614330336411;
 Fri, 26 Feb 2021 01:05:36 -0800 (PST)
MIME-Version: 1.0
References: <20210225112122.2198845-1-arnd@kernel.org> <CA+icZUUDnKBxkfgOVYDdpA29GnLUTT22mqRNyxQeYmay044ejg@mail.gmail.com>
 <CAK8P3a1QmS6g3cHTR93wWPkKs8vaP6RJEb8nZbTMLX+xphLJRw@mail.gmail.com>
In-Reply-To: <CAK8P3a1QmS6g3cHTR93wWPkKs8vaP6RJEb8nZbTMLX+xphLJRw@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 26 Feb 2021 10:05:25 +0100
Message-ID: <CA+icZUW9Hzm_ZZtLiJu8pVeOmYJMOaXkV4Om_u4yZKYRVWNddA@mail.gmail.com>
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
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 9:14 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Fri, Feb 26, 2021 at 1:36 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >
> > On Thu, Feb 25, 2021 at 12:21 PM Arnd Bergmann <arnd@kernel.org> wrote:
> > >
> > > From: Arnd Bergmann <arnd@arndb.de>
> > >
> > > When looking at kernel size optimizations, I found that arm64
> > > does not currently support HAVE_LD_DEAD_CODE_DATA_ELIMINATION,
> > > which enables the --gc-sections flag to the linker.
> > >
> > > I see that for a defconfig build with llvm, there are some
> > > notable improvements from enabling this, in particular when
> > > combined with the recently added CONFIG_LTO_CLANG_THIN
> > > and CONFIG_TRIM_UNUSED_KSYMS:
> > >
> > >    text    data     bss     dec     hex filename
> > > 16570322 10998617 506468 28075407 1ac658f defconfig/vmlinux
> > > 16318793 10569913 506468 27395174 1a20466 trim_defconfig/vmlinux
> > > 16281234 10984848 504291 27770373 1a7be05 gc_defconfig/vmlinux
> > > 16029705 10556880 504355 27090940 19d5ffc gc+trim_defconfig/vmlinux
> > > 17040142 11102945 504196 28647283 1b51f73 thinlto_defconfig/vmlinux
> > > 16788613 10663201 504196 27956010 1aa932a thinlto+trim_defconfig/vmlinux
> > > 16347062 11043384 502499 27892945 1a99cd1 gc+thinlto_defconfig/vmlinux
> > > 15759453 10532792 502395 26794640 198da90 gc+thinlto+trim_defconfig/vmlinux
> > >
> >
> > Thanks for the numbers.
> > Does CONFIG_TRIM_UNUSED_KSYMS=y have an impact to the build-time (and
> > disc-usage - negative way means longer/bigger)?
> > Do you have any build-time for the above numbers?
>
> They are in the mailing list archive I linked to:
>
> ==== defconfig ====
>      332.001786355 seconds time elapsed
>     8599.464163000 seconds user
>      676.919635000 seconds sys
> ==== trim_defconfig ====
>      448.378576012 seconds time elapsed
>    10735.489271000 seconds user
>      964.006504000 seconds sys
> ==== gc_defconfig ====
>      324.347492236 seconds time elapsed
>     8465.785800000 seconds user
>      614.899797000 seconds sys
> ==== gc+trim_defconfig ====
>      429.188875620 seconds time elapsed
>    10203.759658000 seconds user
>      871.307973000 seconds sys
> ==== thinlto_defconfig ====
>      389.793540200 seconds time elapsed
>     9491.665320000 seconds user
>      664.858109000 seconds sys
> ==== thinlto+trim_defconfig ====
>      580.431820561 seconds time elapsed
>    11429.515538000 seconds user
>     1056.985745000 seconds sys
> ==== gc+thinlto_defconfig ====
>      389.484364525 seconds time elapsed
>     9473.831980000 seconds user
>      675.057675000 seconds sys
> ==== gc+thinlto+trim_defconfig ====
>      580.824912807 seconds time elapsed
>    11433.650337000 seconds user
>     1049.845569000 seconds sys
>

Thanks for the numbers Arnd.

> So HAVE_LD_DEAD_CODE_DATA_ELIMINATION is a small improvement
> on build time (since it can spend less time linking), while
> CONFIG_TRIM_UNUSED_KSYMS slows it down quite a bit. Combining
> CONFIG_TRIM_UNUSED_KSYMS with CONFIG_THINLTO is really
> slow because here most of the time is spent in the final link (especially
> when you have many CPU cores to do the earlier bits quickly), but then
> it does the link twice.
>

My first pre-v5.12-rc1 kernel-build was with Clang-ThinLTO enabled.
But with the next ones I jumped to Sami's Clang-CFI.

> > BTW, is CONFIG_LD_DEAD_CODE_DATA_ELIMINATION=y setable for x86 (64bit)?
> > ( Did not look or check for it. )
>
> No, in mainline, HAVE_LD_DEAD_CODE_DATA_ELIMINATION is currently
> only selected on MIPS and PowerPC. I only sent experimental patches to
> enable it on arm64 and m68k, but have not tried booting them. If you
> select the symbol on x86, you should see similar results.
>

OK, i see:

$ git grep HAVE_LD_DEAD_CODE_DATA_ELIMINATION arch/mips/
arch/mips/Kconfig:      select HAVE_LD_DEAD_CODE_DATA_ELIMINATION

$ git grep HAVE_LD_DEAD_CODE_DATA_ELIMINATION arch/powerpc/
arch/powerpc/Kconfig:   select HAVE_LD_DEAD_CODE_DATA_ELIMINATION

So, I need to add this to arch/x86/Kconfig.

You happen to know if changes to arch/x86/kernel/vmlinux.lds.S
(sections) are needed?

Last question:
The last days I see a lot of fixes touching inlining with LLVM/Clang v13-git.
What git tag are you using?
What are your experiences?
Pending patches (kernel-side)?

I use:
$ /opt/llvm-toolchain/bin/clang --version
dileks clang version 13.0.0 (https://github.com/llvm/llvm-project.git
c465429f286f50e52a8d2b3b39f38344f3381cce)
Target: x86_64-unknown-linux-gnu
Thread model: posix
InstalledDir: /opt/llvm-toolchain/bin

My LLVM toolchain is ThinLTO+PGO optimized for Linux-kernel builds.

- Sedat -
