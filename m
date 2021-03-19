Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3C0D342421
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 19:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbhCSSJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 14:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbhCSSJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 14:09:08 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38AB2C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 11:09:08 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id w37so11348981lfu.13
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 11:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wuZyAZ3JnSH71+O2rOQSNjgWBlPwFLx0QGqENzzRt1Y=;
        b=WZPkxBhuxRsAx+6pPD260n4G1MPazcwQOg7ern0mx2r+f/GbkTbGm9yAP/nJAJHM/Q
         LLYMgEOoT3fT8t9Ic45pvQ5z4GM9Sf/TdGEHFt4fMsxkvltq7bnJ2Te2YS/oxYxSEvjH
         DwmZPZw7By5T/97M8cGS8HEW1Noz7BISsl0eZWNGokUnDchhwz6G/aLN+Tmf8RS3dES2
         GEKWm2ygbnGUDB/AbWWKGrYYyWU83X9ROyv3F2dvc3PYx5qWkJ0maaIsS7Mn2uVkucfq
         U+sbXoQ5zuj+1Nan4/aAd4YbZE9GHjX/g7A0HNXWY/JrCm1DWSbd9e4PMamfy2gRl9jf
         88Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wuZyAZ3JnSH71+O2rOQSNjgWBlPwFLx0QGqENzzRt1Y=;
        b=Qqsms4hUMroeOuxOyAQiro4gYUInnftuRa0HESjiC2BMkFjseoIso6ljbXrujy3xF0
         Vi8j6oPLWGkDuwit4uD3rLQjgG5DExQOpYjvzP63KtgPbly1AvH9OjtxXhrpnCOXrPJW
         MVEhpUbNDAevcIK4lHhcS3P7ddjlj3gOCaSy2KeF5jAs9sXxMsyR+Ukuj5zccV6CVbsE
         ITuN4dRZU0p3LbScOdxM6xOBNa8pRwvhUHBHEcWNZb5jx3sDZrJ0zek9gbRq25rawy/V
         CfkPdBIFx/RHiVkzHS7jA0pvTv2Ac/H+N1ci10tMScZd2A9P0UZZFcqMAn74mooYWwJo
         41kQ==
X-Gm-Message-State: AOAM531KTQ7wPGl+5lHNqgpkYs/MIcqYGPGilkzdN7v35Dt6je7AkLNF
        7j70Af0lNmyyE1Mg4ubNoQqpWqkheqjmKrPg1heGVQ==
X-Google-Smtp-Source: ABdhPJy3Jr9yI0SKHAkqxj1Juh6tv3KqeT0+FHrj9cLEc6TjswCE14y0fjTv8zPZxEeTD21jdo7zcaBZ0+aHB/8NLeE=
X-Received: by 2002:a05:6512:34c3:: with SMTP id w3mr1457103lfr.437.1616177346474;
 Fri, 19 Mar 2021 11:09:06 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYseDSQ2Vgg5Cb=8HHdpm56aeVQH0Vdx7JK1SktGpRRkgw@mail.gmail.com>
 <CAK8P3a3Za8N2-Hs02nG0CcGJ+RcTrR0UqDOesd8E6PmhYRR2_A@mail.gmail.com>
 <ebf12838-4525-a525-93bd-2229927e50ca@physik.fu-berlin.de> <CAK8P3a2WCYxG4-4x49Uc-+pXPciY5EsDqmNcEfufcXZp6Q3+MQ@mail.gmail.com>
In-Reply-To: <CAK8P3a2WCYxG4-4x49Uc-+pXPciY5EsDqmNcEfufcXZp6Q3+MQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 19 Mar 2021 11:08:55 -0700
Message-ID: <CAKwvOd=TYuzcXK056nn4M4i475op=mvgNJA894FYH0gLSXY_PQ@mail.gmail.com>
Subject: Re: sparc: clang: error: unknown argument: '-mno-fpu'
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        sparclinux <sparclinux@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2021 at 4:56 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, Mar 19, 2021 at 12:38 PM John Paul Adrian Glaubitz
> <glaubitz@physik.fu-berlin.de> wrote:
> > On 3/19/21 12:31 PM, Arnd Bergmann wrote:
> > > On Fri, Mar 19, 2021 at 8:36 AM Naresh Kamboju
> > > <naresh.kamboju@linaro.org> wrote:
> > >>
> > >> Linux mainline master build breaks for sparc defconfig.
> > >> There are multiple errors / warnings with clang-12 and clang-11 and 10.
> > >>  - sparc (defconfig) with clang-12, clang-11 and clang-10
> > >>  - sparc (tinyconfig) with clang-12, clang-11 and clang-10
> > >>  - sparc (allnoconfig) with clang-12, clang-11 and clang-10
> > >>
> > >> make --silent --keep-going --jobs=8
> > >> O=/home/tuxbuild/.cache/tuxmake/builds/1/tmp ARCH=sparc
> > >> CROSS_COMPILE=sparc64-linux-gnu- 'HOSTCC=sccache clang' 'CC=sccache
> > >> clang'
> > >
> > > I don't think anyone has successfully built a sparc kernel with clang,
> > > and I don't
> > > think it's worth trying either, given how little upstream work the
> > > sparc port sees overall.
> >
> > We'll get there. There are some other SPARC-related clang bugs that need
> > to be squashed first. We have made quite some improvements and it's actually
> > maintained by the community. Of course, we don't have a commercial backer
> > but that shouldn't be necessary for open source to work.
>
> I meant there is no point for Naresh to do it as part of his build
> testing with tuxmake.
> If someone else gets it working, they can tell Naresh to try again, but until
> then, I'd limit clang regression testing to x86, arm, powerpc, s390, mips, riscv
> and arc.

We definitely cannot yet build arc.
$ cmake ... -DLLVM_EXPERIMENTAL_TARGETS_TO_BUILD="ARC"
$ ARCH=arc CROSS_COMPILE=arc-linux-gnu- make LLVM=1 -j72 defconfig vmlinux
...
clang-13: error: unknown argument: '-mmedium-calls'
clang-13: error: unknown argument: '-fsection-anchors'
clang-13: error: unknown argument: '-mlock'
clang-13: error: unknown argument: '-mswape'
clang-13: error: unknown argument: '-mno-sdata'
clang-13: error: unknown argument: '-fcall-used-gp'


-- 
Thanks,
~Nick Desaulniers
