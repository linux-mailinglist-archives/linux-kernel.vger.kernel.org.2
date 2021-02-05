Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9AC310AEC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 13:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbhBEMKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 07:10:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:38026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231325AbhBEMGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 07:06:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2902964E56
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 12:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612526766;
        bh=P2H+p6Gfr5Ld3SqtYgJ1Zt+ruHXely3WQO2vo5BEITs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YJ0jINN3UndtAc09R1/m5W6yQod6VQybaicgsbJ5JbCe3CLShg7VaTSW7AU7nmA5T
         +FjNNWUOB5mzuB752GYzKq2Jta4OhnQo6KKSbl5T4s6XM5UdWabZPuPUHrc9LMlIQk
         gp5H7ivYJzOKTk1kIFOBW9nSMbvzCwYs4MpaOfxn8DIfa5czw38jJFuRfPczmgLIj0
         k4twTclMPt/gVy7CCCFb15sNruT/be5mIiH7ilE3kmlulhyYrgak4NIt9zfe38opx1
         f/p1M4ujDScRXoTvogqm3BnAiZf5A2l1N0LyIxHjK6DRh0BspnO7GYM1Jv0lrQ9wAv
         TneEfqSzSNL5w==
Received: by mail-ot1-f43.google.com with SMTP id d7so6652815otf.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 04:06:06 -0800 (PST)
X-Gm-Message-State: AOAM532jSavsanDF1qQ1qj8FvKN7riDwEmVZLJ/YMxybb2QldnLDgH1t
        7Pq5iGEmt2csIOF19YutTuHiZGkqButcpaUsXJU=
X-Google-Smtp-Source: ABdhPJxryu3Yq7cpU51h1yopmAe3Wk82CNlvzZ90+LotN6/4nc0vHmq9Q02/ISQMPbGp8bAdZp9npVsmxnA6aJGvR7I=
X-Received: by 2002:a05:6830:1e2a:: with SMTP id t10mr3220364otr.90.1612526765201;
 Fri, 05 Feb 2021 04:06:05 -0800 (PST)
MIME-Version: 1.0
References: <6c65bcef-d4e7-25fa-43cf-2c435bb61bb9@collabora.com>
 <CAMj1kXHMw5hMuV5VapcTeok3WJu1B79=Z3Xho0qda0nCqBFERA@mail.gmail.com>
 <20210204100601.GT1463@shell.armlinux.org.uk> <CAMj1kXFog3=5zD7+P=cRfRLj1xfD1h1kU58iifASBSXkRe-E6g@mail.gmail.com>
 <c0037472-75c8-6cf9-6ecf-e671fce9d636@collabora.com> <46373679-a149-8a3d-e914-780e4c6ff8be@collabora.com>
 <CAMj1kXEshuPTrKvN4LpXQMftHJG+yH8+fgU7uVc6GYn0qd8-xA@mail.gmail.com>
 <7c685184-8688-9319-075b-66133cb0b0c3@collabora.com> <CAMj1kXH_CCYyd5zNVRL=KWpBXtsKamV7Bfg=O1YWBJL0f_eXLQ@mail.gmail.com>
 <CAKwvOd=ziPWHmBiPtW3h2VYLZ-CTMp4=aEonmMLM7c=Y0SeG1Q@mail.gmail.com>
 <20210204181216.GB2989696@localhost> <CAKwvOd=UYuKPp6rO7aWGFEsc9yLa_UCLnAL-vwqzi_5sZg7O3g@mail.gmail.com>
 <253b2987-c8e9-fcb6-c1b9-81e765c0cc2a@collabora.com> <CAMj1kXFKzEPqG5j2bn5n_3imc9aFyOEHX7CVDdwe2=ugTq=bZQ@mail.gmail.com>
In-Reply-To: <CAMj1kXFKzEPqG5j2bn5n_3imc9aFyOEHX7CVDdwe2=ugTq=bZQ@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 5 Feb 2021 13:05:54 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGrABn7KxSPxTo3pWJEk3fNsN-zBBHZkbVfg7gTavL_pQ@mail.gmail.com>
Message-ID: <CAMj1kXGrABn7KxSPxTo3pWJEk3fNsN-zBBHZkbVfg7gTavL_pQ@mail.gmail.com>
Subject: Re: next/master bisection: baseline.login on rk3288-rock2-square
To:     Guillaume Tucker <guillaume.tucker@collabora.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        "kernelci-results@groups.io" <kernelci-results@groups.io>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Nicolas Pitre <nico@fluxnic.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Feb 2021 at 09:21, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Thu, 4 Feb 2021 at 22:31, Guillaume Tucker
> <guillaume.tucker@collabora.com> wrote:
> >
> > On 04/02/2021 18:23, Nick Desaulniers wrote:
> > > On Thu, Feb 4, 2021 at 10:12 AM Nathan Chancellor <nathan@kernel.org> wrote:
> > >>
> > >> On Thu, Feb 04, 2021 at 10:06:08AM -0800, 'Nick Desaulniers' via Clang Built Linux wrote:
> > >>> On Thu, Feb 4, 2021 at 8:02 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> > >>>>
> > >>>> On Thu, 4 Feb 2021 at 16:53, Guillaume Tucker
> > >>>> <guillaume.tucker@collabora.com> wrote:
> > >>>>>
> > >>>>> On 04/02/2021 15:42, Ard Biesheuvel wrote:
> > >>>>>> On Thu, 4 Feb 2021 at 12:32, Guillaume Tucker
> > >>>>>> <guillaume.tucker@collabora.com> wrote:
> > >>>>>>>
> > >>>>>>> Essentially:
> > >>>>>>>
> > >>>>>>>   make -j18 ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- LLVM=1 CC="ccache clang" zImage
> > >>>
> > >>> This command should link with BFD (and assemble with GAS; it's only
> > >>> using clang as the compiler.
> > >>
> > >> I think you missed the 'LLVM=1' before CC="ccache clang". That should
> > >> use all of the LLVM utilities minus the integrated assembler while
> > >> wrapping clang with ccache.
> > >
> > > You're right, I missed `LLVM=1`. Adding `LD=ld.bfd` I think should
> > > permit fallback to BFD.
> >
> > That was close, except we're cross-compiling with GCC for arm.
> > So I've now built a plain next-20210203 (without Ard's fix) using
> > this command line:
> >
> >     make LD=arm-linux-gnueabihf-ld.bfd -j18 ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- LLVM=1 CC="ccache clang" zImage
> >
> > I'm using a modified Docker image gtucker/kernelci-build-clang-11
> > with the very latest LLVM 11 and gcc-8-arm-linux-gnueabihf
> > packages added to be able to use the GNU linker.  BTW I guess we
> > should enable this kind of hybrid build setup on kernelci.org as
> > well.
> >
> > Full build log + kernel binaries can be found here:
> >
> >     https://storage.staging.kernelci.org/gtucker/next-20210203-ard-fix/v5.10-rc4-24722-g58b6c0e507b7-gtucker_single-staging-41/arm/multi_v7_defconfig/clang-11/
> >
> > And this booted fine, which confirms it's really down to how
> > ld.lld puts together the kernel image.  Does it actually solve
> > the debate whether this is an issue to fix in the assembly code
> > or at link time?
> >
> > Full test job details for the record:
> >
> >     https://lava.collabora.co.uk/scheduler/job/3176004
> >
>
>
> So the issue appears to be in the way the linker generates the
> _kernel_bss_size symbol, which obviously has an impact, given that the
> queued fix takes it into account in the cache_clean operation.
>
> On GNU ld, I see
>
>    479: 00065e14     0 NOTYPE  GLOBAL DEFAULT  ABS _kernel_bss_size
>
> whereas n LLVM ld.lld, I see
>
>    433: c1c86e98     0 NOTYPE  GLOBAL DEFAULT  ABS _kernel_bss_size
>
> and adding this value may cause the cache clean to operate on unmapped
> addresses, or cause the addition to wrap and not perform a cache clean
> at all.
>
> AFAICT, this also breaks the appended DTB case in LLVM, so this needs
> a separate fix in any case.

I pushed a combined branch of torvalds/master, rmk/fixes (still
containing my 9052/1 fix) and this patch to my for-kernelci branch

https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/

Guillaume,

It seems there is no Clang-11 coverage there, right? Mind giving this
branch a spin? If this fixes the regressions, we can get these queued
up.

Thanks,
Ard.
