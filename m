Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 282F430F6A9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 16:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237481AbhBDPof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 10:44:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:33110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237534AbhBDPnK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 10:43:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6419464F6C
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 15:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612453348;
        bh=4dX/aXt8PQev+SQRXcQKXWa21f8rZJMURijB1ULwj98=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hoVbiHQUkE4hJSLw20HF/3Kot3RYdBdJynSlKX59zoVbw4SXJBC0N1ndPyw5c1ffl
         jKoZ60ne18UjTPrfa/FBF8UyvyoZ8mIM9sYKquvBcCVcunvgvhyApys+QI4dVwRcwI
         J21SUkyRCoCrU7NYy/toDrfPVM6tECZhJdWktaEt3F+koQpSKz8xrGzR/DFfltMEqc
         fnkhGsywVUVpDEb1lM1IDfs52dtFtLsVAcxiVeGJZkU6myCzlY8gPhk9010iMdrSr4
         xHZuXOUWymzua2p4Ih6sErvt+Fqrf8hUuTH5vnJKkY+MHlfzLKxRxZ+HlQgEZVCbsp
         iqlgNEIAaRSZQ==
Received: by mail-ot1-f48.google.com with SMTP id o12so3766458ote.12
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 07:42:28 -0800 (PST)
X-Gm-Message-State: AOAM531QkRg2nIBHVtRjxQ0hf3FliIlc0/VsQI64RpCPy/zJyiwgRqU6
        yuwN+AKPSf/xcLHjmS86bKMt2/aXYEQqpcco748=
X-Google-Smtp-Source: ABdhPJwD/kbrwmqs2NdZLVcMlXr0lx+ORD/zaYBwCBPO0OLKHj53vdIL0sQ70Cf0CtKjIEN0exZyIjoegkqz25Eoy0g=
X-Received: by 2002:a05:6830:1e2a:: with SMTP id t10mr6205441otr.90.1612453347580;
 Thu, 04 Feb 2021 07:42:27 -0800 (PST)
MIME-Version: 1.0
References: <601b773a.1c69fb81.9f381.a32a@mx.google.com> <6c65bcef-d4e7-25fa-43cf-2c435bb61bb9@collabora.com>
 <CAMj1kXHMw5hMuV5VapcTeok3WJu1B79=Z3Xho0qda0nCqBFERA@mail.gmail.com>
 <20210204100601.GT1463@shell.armlinux.org.uk> <CAMj1kXFog3=5zD7+P=cRfRLj1xfD1h1kU58iifASBSXkRe-E6g@mail.gmail.com>
 <c0037472-75c8-6cf9-6ecf-e671fce9d636@collabora.com> <46373679-a149-8a3d-e914-780e4c6ff8be@collabora.com>
In-Reply-To: <46373679-a149-8a3d-e914-780e4c6ff8be@collabora.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 4 Feb 2021 16:42:15 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEshuPTrKvN4LpXQMftHJG+yH8+fgU7uVc6GYn0qd8-xA@mail.gmail.com>
Message-ID: <CAMj1kXEshuPTrKvN4LpXQMftHJG+yH8+fgU7uVc6GYn0qd8-xA@mail.gmail.com>
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

On Thu, 4 Feb 2021 at 12:32, Guillaume Tucker
<guillaume.tucker@collabora.com> wrote:
>
> On 04/02/2021 10:33, Guillaume Tucker wrote:
> > On 04/02/2021 10:27, Ard Biesheuvel wrote:
> >> On Thu, 4 Feb 2021 at 11:06, Russell King - ARM Linux admin
> >> <linux@armlinux.org.uk> wrote:
> >>>
> >>> On Thu, Feb 04, 2021 at 10:07:58AM +0100, Ard Biesheuvel wrote:
> >>>> On Thu, 4 Feb 2021 at 09:43, Guillaume Tucker
> >>>> <guillaume.tucker@collabora.com> wrote:
> >>>>>
> >>>>> Hi Ard,
> >>>>>
> >>>>> Please see the bisection report below about a boot failure on
> >>>>> rk3288 with next-20210203.  It was also bisected on
> >>>>> imx6q-var-dt6customboard with next-20210202.
> >>>>>
> >>>>> Reports aren't automatically sent to the public while we're
> >>>>> trialing new bisection features on kernelci.org but this one
> >>>>> looks valid.
> >>>>>
> >>>>> The kernel is most likely crashing very early on, so there's
> >>>>> nothing in the logs.  Please let us know if you need some help
> >>>>> with debugging or trying a fix on these platforms.
> >>>>>
> >>>>
> >>>> Thanks for the report.
> >>>
> >>> Ard,
> >>>
> >>> I want to send my fixes branch today which includes your regression
> >>> fix that caused this regression.
> >>>
> >>> As this is proving difficult to fix, I can only drop your fix from
> >>> my fixes branch - and given that this seems to be problematical, I'm
> >>> tempted to revert the original change at this point which should fix
> >>> both of these regressions - and then we have another go at getting rid
> >>> of the set/way instructions during the next cycle.
> >>>
> >>> Thoughts?
> >>>
> >>
> >> Hi Russell,
> >>
> >> If Guillaume is willing to do the experiment, and it fixes the issue,
> >
> > Yes, I'm running some tests with that fix now and should have
> > some results shortly.
>
> Yes it does fix the issue:
>
>   https://lava.collabora.co.uk/scheduler/job/3173819
>
> with Ard's fix applied to this test branch:
>
>   https://gitlab.collabora.com/gtucker/linux/-/commits/next-20210203-ard-fix/
>
>
> +clang +Nick
>
> It's worth mentioning that the issue only happens with kernels
> built with Clang.  As you can see there are several other arm
> platforms failing with clang-11 builds but booting fine with
> gcc-8:
>
>   https://kernelci.org/test/job/next/branch/master/kernel/next-20210203/plan/baseline/
>
> Here's a sample build log:
>
>   https://storage.staging.kernelci.org/gtucker/next-20210203-ard-fix/v5.10-rc4-24722-g58b6c0e507b7-gtucker_single-staging-33/arm/multi_v7_defconfig/clang-11/build.log
>
> Essentially:
>
>   make -j18 ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- LLVM=1 CC="ccache clang" zImage
>
> I believe it should be using the GNU assembler as LLVM_IAS=1 is
> not defined, but there may be something more subtle about it.
>


Do you have a link for a failing zImage built from multi_v7_defconfig?
