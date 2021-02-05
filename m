Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC3A310691
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 09:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbhBEIWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 03:22:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:51244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231705AbhBEIWc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 03:22:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8792E64FC4
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 08:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612513309;
        bh=rsgRIu/tvrvOwTftz1wZ70xC7b3dwy15C7K3SpnV89w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AqRQWFJfjCFeb7FUX0HIPN9GbRdQmfHw83fulDIk4mk1AGLLOD44h9Dlw2Xo2qMre
         oWowLBMl0aBWcHM5PjiJjqSQv2ZuM7+q2Dn6ZMw7lWvCualSF301mkM49imkj/dTky
         Za/ct6SRDzEtW8qJmpIT/lTvrB6wWfnurEeQFh25BPcdIOxClUuy+XzHX1BMfsAkBi
         m23tVYyjD0k8sfoeTOoRQAFbqsXJ2aodkHZFvjm2VvHBdsNt0gfcyfg6nJ+vtT4nZz
         7kiEQHfenwZC0kd8ncBqft4wLyEXcNW5xAmpsYe1ihvFdioUetAHZyd1YzOx6kAAXe
         VUxEM0p+e9nTw==
Received: by mail-oi1-f174.google.com with SMTP id y199so4659880oia.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 00:21:49 -0800 (PST)
X-Gm-Message-State: AOAM5326HTqBvnld7v/dsXOkp+hrZIWRJEF5fffjSD9Eqh8PO51ynlXT
        tpIRtM54bNecuKdkOtyaSuVgQ1KOqmFS5bJfDwA=
X-Google-Smtp-Source: ABdhPJxK6Fv9qVP05016l+93dXRzK5UMll6W3BnwPgBy7DfTlXtBf0AvHu3ba+EUMdxxXIgGixUjHkdO1+IU5lGSh6w=
X-Received: by 2002:aca:b6c1:: with SMTP id g184mr2381863oif.47.1612513308661;
 Fri, 05 Feb 2021 00:21:48 -0800 (PST)
MIME-Version: 1.0
References: <6c65bcef-d4e7-25fa-43cf-2c435bb61bb9@collabora.com>
 <CAMj1kXHMw5hMuV5VapcTeok3WJu1B79=Z3Xho0qda0nCqBFERA@mail.gmail.com>
 <20210204100601.GT1463@shell.armlinux.org.uk> <CAMj1kXFog3=5zD7+P=cRfRLj1xfD1h1kU58iifASBSXkRe-E6g@mail.gmail.com>
 <c0037472-75c8-6cf9-6ecf-e671fce9d636@collabora.com> <46373679-a149-8a3d-e914-780e4c6ff8be@collabora.com>
 <CAMj1kXEshuPTrKvN4LpXQMftHJG+yH8+fgU7uVc6GYn0qd8-xA@mail.gmail.com>
 <7c685184-8688-9319-075b-66133cb0b0c3@collabora.com> <CAMj1kXH_CCYyd5zNVRL=KWpBXtsKamV7Bfg=O1YWBJL0f_eXLQ@mail.gmail.com>
 <CAKwvOd=ziPWHmBiPtW3h2VYLZ-CTMp4=aEonmMLM7c=Y0SeG1Q@mail.gmail.com>
 <20210204181216.GB2989696@localhost> <CAKwvOd=UYuKPp6rO7aWGFEsc9yLa_UCLnAL-vwqzi_5sZg7O3g@mail.gmail.com>
 <253b2987-c8e9-fcb6-c1b9-81e765c0cc2a@collabora.com>
In-Reply-To: <253b2987-c8e9-fcb6-c1b9-81e765c0cc2a@collabora.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 5 Feb 2021 09:21:37 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFKzEPqG5j2bn5n_3imc9aFyOEHX7CVDdwe2=ugTq=bZQ@mail.gmail.com>
Message-ID: <CAMj1kXFKzEPqG5j2bn5n_3imc9aFyOEHX7CVDdwe2=ugTq=bZQ@mail.gmail.com>
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

On Thu, 4 Feb 2021 at 22:31, Guillaume Tucker
<guillaume.tucker@collabora.com> wrote:
>
> On 04/02/2021 18:23, Nick Desaulniers wrote:
> > On Thu, Feb 4, 2021 at 10:12 AM Nathan Chancellor <nathan@kernel.org> wrote:
> >>
> >> On Thu, Feb 04, 2021 at 10:06:08AM -0800, 'Nick Desaulniers' via Clang Built Linux wrote:
> >>> On Thu, Feb 4, 2021 at 8:02 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> >>>>
> >>>> On Thu, 4 Feb 2021 at 16:53, Guillaume Tucker
> >>>> <guillaume.tucker@collabora.com> wrote:
> >>>>>
> >>>>> On 04/02/2021 15:42, Ard Biesheuvel wrote:
> >>>>>> On Thu, 4 Feb 2021 at 12:32, Guillaume Tucker
> >>>>>> <guillaume.tucker@collabora.com> wrote:
> >>>>>>>
> >>>>>>> Essentially:
> >>>>>>>
> >>>>>>>   make -j18 ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- LLVM=1 CC="ccache clang" zImage
> >>>
> >>> This command should link with BFD (and assemble with GAS; it's only
> >>> using clang as the compiler.
> >>
> >> I think you missed the 'LLVM=1' before CC="ccache clang". That should
> >> use all of the LLVM utilities minus the integrated assembler while
> >> wrapping clang with ccache.
> >
> > You're right, I missed `LLVM=1`. Adding `LD=ld.bfd` I think should
> > permit fallback to BFD.
>
> That was close, except we're cross-compiling with GCC for arm.
> So I've now built a plain next-20210203 (without Ard's fix) using
> this command line:
>
>     make LD=arm-linux-gnueabihf-ld.bfd -j18 ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- LLVM=1 CC="ccache clang" zImage
>
> I'm using a modified Docker image gtucker/kernelci-build-clang-11
> with the very latest LLVM 11 and gcc-8-arm-linux-gnueabihf
> packages added to be able to use the GNU linker.  BTW I guess we
> should enable this kind of hybrid build setup on kernelci.org as
> well.
>
> Full build log + kernel binaries can be found here:
>
>     https://storage.staging.kernelci.org/gtucker/next-20210203-ard-fix/v5.10-rc4-24722-g58b6c0e507b7-gtucker_single-staging-41/arm/multi_v7_defconfig/clang-11/
>
> And this booted fine, which confirms it's really down to how
> ld.lld puts together the kernel image.  Does it actually solve
> the debate whether this is an issue to fix in the assembly code
> or at link time?
>
> Full test job details for the record:
>
>     https://lava.collabora.co.uk/scheduler/job/3176004
>


So the issue appears to be in the way the linker generates the
_kernel_bss_size symbol, which obviously has an impact, given that the
queued fix takes it into account in the cache_clean operation.

On GNU ld, I see

   479: 00065e14     0 NOTYPE  GLOBAL DEFAULT  ABS _kernel_bss_size

whereas n LLVM ld.lld, I see

   433: c1c86e98     0 NOTYPE  GLOBAL DEFAULT  ABS _kernel_bss_size

and adding this value may cause the cache clean to operate on unmapped
addresses, or cause the addition to wrap and not perform a cache clean
at all.

AFAICT, this also breaks the appended DTB case in LLVM, so this needs
a separate fix in any case.
