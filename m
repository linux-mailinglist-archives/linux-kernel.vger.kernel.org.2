Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA3E30FB53
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 19:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239055AbhBDSYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 13:24:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239031AbhBDSYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 13:24:10 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854BEC06178B
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 10:23:24 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id e9so2303023pjj.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 10:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jajB5tF8FeIJnHD6r5t0+o0yif7uNCHw33YMW00aC2Y=;
        b=bvjpTD7ovP3I716ttkMU2zpQwtd1B91Pk7OBXvU1TkF4do6Ru1yCKmk+fXekeIUmTF
         szwwSf37WOmeWZejsnU8O9sOYU4oSpH92pX5b0r3x/3fKFS/rOwgqTlro8I2rBo0J1OM
         RTdNWrVYb3RS3XhaOq41MQ0YK896/IJl5BmlpDBRCfSimybF5TN0I22OsNNW3WjzfCMB
         ceCTvLHqMbJlox3lri0/9kJGqdQ+/gaIxt0gY9IZi2oDp+5VU6Dt1a3K2qNLtJQbr/6L
         pAc0eUgXUymQggHk9JOauk+teJaea2FkLN1vIC44ASXqEi9PIWv4PvC4a9klLfyJsx1i
         5itA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jajB5tF8FeIJnHD6r5t0+o0yif7uNCHw33YMW00aC2Y=;
        b=Qqkk9wR104/EKyLblGfSwApG5E6ALbmPEcpbk5YdqetZYoLNlHV1SAwgi+EXniffdM
         4e+8HbjNbafdKIpgB050WXpTAVObXgbr0UbIQHPx4mk3sMbqS3C3gzGFwDR3tjnJCo12
         ELw8Lg2ZKgQ2z4q8FUHw1+fkX9XH926KKpOoWVm3zG6TZrGmfSrqfKapjL2ZU9GFZCg2
         EUfuNwTCVYEn4jfYR5Ujmg7FzrQ8PJsLLj7kwY1pEuJTQPEqWG6RzRNaSd89kW00vCnT
         q8qQRb5p1j8fEZ4bQNCK4p3QL+3bZtXGItoBJ0RW8u64w7qVvr9Y+Hs8jJlcnYlpkhvR
         n6EQ==
X-Gm-Message-State: AOAM530CpVkYoKWzs2HzSJCVvSwvhT3Swv1xvcM9RhBrMyVjH96SKSn+
        adF+lP4EZ3ZNMM8NdyfLZN7V+OzttJcpYsuceTN2zw==
X-Google-Smtp-Source: ABdhPJzYYBY84KNvQ91nyQzD71E3vFx+LRzscvSnt0dXZw4tXAq7Fv/Xr76gOXc4tiV6UEHVb6FzvKBPMOEb2HrbxhE=
X-Received: by 2002:a17:902:26a:b029:da:af47:77c7 with SMTP id
 97-20020a170902026ab02900daaf4777c7mr641577plc.10.1612463003852; Thu, 04 Feb
 2021 10:23:23 -0800 (PST)
MIME-Version: 1.0
References: <6c65bcef-d4e7-25fa-43cf-2c435bb61bb9@collabora.com>
 <CAMj1kXHMw5hMuV5VapcTeok3WJu1B79=Z3Xho0qda0nCqBFERA@mail.gmail.com>
 <20210204100601.GT1463@shell.armlinux.org.uk> <CAMj1kXFog3=5zD7+P=cRfRLj1xfD1h1kU58iifASBSXkRe-E6g@mail.gmail.com>
 <c0037472-75c8-6cf9-6ecf-e671fce9d636@collabora.com> <46373679-a149-8a3d-e914-780e4c6ff8be@collabora.com>
 <CAMj1kXEshuPTrKvN4LpXQMftHJG+yH8+fgU7uVc6GYn0qd8-xA@mail.gmail.com>
 <7c685184-8688-9319-075b-66133cb0b0c3@collabora.com> <CAMj1kXH_CCYyd5zNVRL=KWpBXtsKamV7Bfg=O1YWBJL0f_eXLQ@mail.gmail.com>
 <CAKwvOd=ziPWHmBiPtW3h2VYLZ-CTMp4=aEonmMLM7c=Y0SeG1Q@mail.gmail.com> <20210204181216.GB2989696@localhost>
In-Reply-To: <20210204181216.GB2989696@localhost>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 4 Feb 2021 10:23:12 -0800
Message-ID: <CAKwvOd=UYuKPp6rO7aWGFEsc9yLa_UCLnAL-vwqzi_5sZg7O3g@mail.gmail.com>
Subject: Re: next/master bisection: baseline.login on rk3288-rock2-square
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Nicolas Pitre <nico@fluxnic.net>,
        "kernelci-results@groups.io" <kernelci-results@groups.io>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 4, 2021 at 10:12 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Thu, Feb 04, 2021 at 10:06:08AM -0800, 'Nick Desaulniers' via Clang Built Linux wrote:
> > On Thu, Feb 4, 2021 at 8:02 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > On Thu, 4 Feb 2021 at 16:53, Guillaume Tucker
> > > <guillaume.tucker@collabora.com> wrote:
> > > >
> > > > On 04/02/2021 15:42, Ard Biesheuvel wrote:
> > > > > On Thu, 4 Feb 2021 at 12:32, Guillaume Tucker
> > > > > <guillaume.tucker@collabora.com> wrote:
> > > > >>
> > > > >> Essentially:
> > > > >>
> > > > >>   make -j18 ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- LLVM=1 CC="ccache clang" zImage
> >
> > This command should link with BFD (and assemble with GAS; it's only
> > using clang as the compiler.
>
> I think you missed the 'LLVM=1' before CC="ccache clang". That should
> use all of the LLVM utilities minus the integrated assembler while
> wrapping clang with ccache.

You're right, I missed `LLVM=1`. Adding `LD=ld.bfd` I think should
permit fallback to BFD.
-- 
Thanks,
~Nick Desaulniers
