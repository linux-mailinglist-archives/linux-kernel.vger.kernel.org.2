Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 785F730F725
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 17:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237745AbhBDQD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 11:03:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:39614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237644AbhBDQCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 11:02:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6259664F65
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 16:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612454523;
        bh=r0dnY1/IlEAw6Aq17al1Q5lMtbG4W5X7rvYEXptsJTc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ORS9NMx8699vtEpJ9ex8Wz8po6mSNG42pk81hiYgtTCpLF/BiJeCXEZDB/2tYsmSi
         9dieNDtF5TDdDtH3Q3XAAw9iGZ+WN3kcrUibWc1vflx1xuDMjUrF0BYI1s/3CXqz/3
         9UV//wfM1MQp7qHZT15tAju22Z0mQwihNgngVH2ZZNqBXGh3WatocfFOxtUMLfHqKn
         Om9P7y1nk/uV/rz+wJjh4cw+2xVVwk2J3N1MwRvmjRsxenZj2lNvlWUil/4R6djGOX
         qcWNrM8+h1lF8e1Yrd/FJufIsFrC2E0yEsEDF9zAbGGMeAr9+O8vDxBlB7gbjXOsPC
         B7UoDfB51QOYQ==
Received: by mail-oi1-f182.google.com with SMTP id m13so4174783oig.8
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 08:02:03 -0800 (PST)
X-Gm-Message-State: AOAM530yQfnOuQ2NFblQzoZZEtaGe4IhMZvQGJcyy7h51YoSFQbuikjl
        ghTNdv9DsE4yMfV4GgvlmlZCBzApsj2W+0LsgVM=
X-Google-Smtp-Source: ABdhPJy2a3CVG9Yb/DS2t3GezqE7fAzkRMhcW1055huIJVpcg29LkecNNiNoJYcqScUc9hmRK2rxTS7XABG0XI0wOZY=
X-Received: by 2002:aca:b6c1:: with SMTP id g184mr56997oif.47.1612454522711;
 Thu, 04 Feb 2021 08:02:02 -0800 (PST)
MIME-Version: 1.0
References: <601b773a.1c69fb81.9f381.a32a@mx.google.com> <6c65bcef-d4e7-25fa-43cf-2c435bb61bb9@collabora.com>
 <CAMj1kXHMw5hMuV5VapcTeok3WJu1B79=Z3Xho0qda0nCqBFERA@mail.gmail.com>
 <20210204100601.GT1463@shell.armlinux.org.uk> <CAMj1kXFog3=5zD7+P=cRfRLj1xfD1h1kU58iifASBSXkRe-E6g@mail.gmail.com>
 <c0037472-75c8-6cf9-6ecf-e671fce9d636@collabora.com> <46373679-a149-8a3d-e914-780e4c6ff8be@collabora.com>
 <CAMj1kXEshuPTrKvN4LpXQMftHJG+yH8+fgU7uVc6GYn0qd8-xA@mail.gmail.com> <7c685184-8688-9319-075b-66133cb0b0c3@collabora.com>
In-Reply-To: <7c685184-8688-9319-075b-66133cb0b0c3@collabora.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 4 Feb 2021 17:01:51 +0100
X-Gmail-Original-Message-ID: <CAMj1kXH_CCYyd5zNVRL=KWpBXtsKamV7Bfg=O1YWBJL0f_eXLQ@mail.gmail.com>
Message-ID: <CAMj1kXH_CCYyd5zNVRL=KWpBXtsKamV7Bfg=O1YWBJL0f_eXLQ@mail.gmail.com>
Subject: Re: next/master bisection: baseline.login on rk3288-rock2-square
To:     Guillaume Tucker <guillaume.tucker@collabora.com>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Nicolas Pitre <nico@fluxnic.net>,
        "kernelci-results@groups.io" <kernelci-results@groups.io>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Feb 2021 at 16:53, Guillaume Tucker
<guillaume.tucker@collabora.com> wrote:
>
> On 04/02/2021 15:42, Ard Biesheuvel wrote:
> > On Thu, 4 Feb 2021 at 12:32, Guillaume Tucker
> > <guillaume.tucker@collabora.com> wrote:
> >>
> >> On 04/02/2021 10:33, Guillaume Tucker wrote:
> >>> On 04/02/2021 10:27, Ard Biesheuvel wrote:
> >>>> On Thu, 4 Feb 2021 at 11:06, Russell King - ARM Linux admin
> >>>> <linux@armlinux.org.uk> wrote:
> >>>>>
> >>>>> On Thu, Feb 04, 2021 at 10:07:58AM +0100, Ard Biesheuvel wrote:
> >>>>>> On Thu, 4 Feb 2021 at 09:43, Guillaume Tucker
> >>>>>> <guillaume.tucker@collabora.com> wrote:
> >>>>>>>
> >>>>>>> Hi Ard,
> >>>>>>>
> >>>>>>> Please see the bisection report below about a boot failure on
> >>>>>>> rk3288 with next-20210203.  It was also bisected on
> >>>>>>> imx6q-var-dt6customboard with next-20210202.
> >>>>>>>
> >>>>>>> Reports aren't automatically sent to the public while we're
> >>>>>>> trialing new bisection features on kernelci.org but this one
> >>>>>>> looks valid.
> >>>>>>>
> >>>>>>> The kernel is most likely crashing very early on, so there's
> >>>>>>> nothing in the logs.  Please let us know if you need some help
> >>>>>>> with debugging or trying a fix on these platforms.
> >>>>>>>
> >>>>>>
> >>>>>> Thanks for the report.
> >>>>>
> >>>>> Ard,
> >>>>>
> >>>>> I want to send my fixes branch today which includes your regression
> >>>>> fix that caused this regression.
> >>>>>
> >>>>> As this is proving difficult to fix, I can only drop your fix from
> >>>>> my fixes branch - and given that this seems to be problematical, I'm
> >>>>> tempted to revert the original change at this point which should fix
> >>>>> both of these regressions - and then we have another go at getting rid
> >>>>> of the set/way instructions during the next cycle.
> >>>>>
> >>>>> Thoughts?
> >>>>>
> >>>>
> >>>> Hi Russell,
> >>>>
> >>>> If Guillaume is willing to do the experiment, and it fixes the issue,
> >>>
> >>> Yes, I'm running some tests with that fix now and should have
> >>> some results shortly.
> >>
> >> Yes it does fix the issue:
> >>
> >>   https://lava.collabora.co.uk/scheduler/job/3173819
> >>
> >> with Ard's fix applied to this test branch:
> >>
> >>   https://gitlab.collabora.com/gtucker/linux/-/commits/next-20210203-ard-fix/
> >>
> >>
> >> +clang +Nick
> >>
> >> It's worth mentioning that the issue only happens with kernels
> >> built with Clang.  As you can see there are several other arm
> >> platforms failing with clang-11 builds but booting fine with
> >> gcc-8:
> >>
> >>   https://kernelci.org/test/job/next/branch/master/kernel/next-20210203/plan/baseline/
> >>
> >> Here's a sample build log:
> >>
> >>   https://storage.staging.kernelci.org/gtucker/next-20210203-ard-fix/v5.10-rc4-24722-g58b6c0e507b7-gtucker_single-staging-33/arm/multi_v7_defconfig/clang-11/build.log
> >>
> >> Essentially:
> >>
> >>   make -j18 ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- LLVM=1 CC="ccache clang" zImage
> >>
> >> I believe it should be using the GNU assembler as LLVM_IAS=1 is
> >> not defined, but there may be something more subtle about it.
> >>
> >
> >
> > Do you have a link for a failing zImage built from multi_v7_defconfig?
>
> Sure, this one was built from a plain next-20210203:
>
>   http://storage.staging.kernelci.org/gtucker/next-20210203-ard-fix/v5.10-rc4-24722-g58b6c0e507b7-gtucker_single-staging-33/arm/multi_v7_defconfig/clang-11/zImage
>
> You can also find the dtbs, modules and other things in that same
> directory.
>
> For the record, here's the test job that used it:
>
>   https://lava.collabora.co.uk/scheduler/job/3173792
>

Thanks.

That zImage boots fine locally. Unfortunately, I don't have rk3288
hardware to reproduce.

Could you please point me to the list of all the other platforms that
failed to boot this image?

To be honest, I am slightly annoyed that a change that works fine with
GCC but does not work with Clang version

11.1.0-++20210130110826+3a8282376b6c-1~exp1~20210130221445.158

(where exp means experimental, I suppose) is the reason for this
discussion, especially because the change is in asm code. Is it
possible to build with Clang but use the GNU linker?
