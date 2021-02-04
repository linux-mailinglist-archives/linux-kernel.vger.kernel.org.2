Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9929430FABF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 19:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238808AbhBDSH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 13:07:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238783AbhBDSHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 13:07:00 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69249C0613D6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 10:06:20 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id u11so2157956plg.13
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 10:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WDOXCpI6LRDhCjEBnTMAPXA3jx1S5SnX36Tq38QJKqc=;
        b=vQn1IKJ8SHiqalhUxz9gd8Ce9r8txR6E1S8stHIC0r1yCfteGAaKCVwBcEY4gq73gD
         WSAtlc+DE4yudPwpEsRr3TvsT/jT7UFzoTZ/7eVzaU2jRj8RLcZlot3YsxNNOUmsM6vk
         MY9zPWp69ktWPALeVea+AHdabsu32iteadgOHqlvRSh52kpXVL8YvtW7lM2xWPsRJSS/
         52c0eoziCn66QGF1C1F67WUeMtOjjbSOi6FB2bJcpjHimZ7mJEd0uCRwv2/mNUeVkCpu
         DNUrPczpw0qTLSsBgsNIqgQat0ilgnrc5tdMzq9z77uiFexuQuE/XThy15IoF/z8bKG4
         1Ixw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WDOXCpI6LRDhCjEBnTMAPXA3jx1S5SnX36Tq38QJKqc=;
        b=EWyxWipaLPxLUUG+w2ePIt3KpLJJVsF25kBzEVf6MMa6YZLgwoHV5jInBTrips6tS9
         MitYIlUbze9xpZgQC6PzfdjpQ0oxQzhthcnpvHwDmoX7glzXrGf+f0Fn+AMypjJgxJGK
         tK2NkVvF/wutceIS1Z0P0t3BWJdzuvLxZN3FyANrnD1V4kox9IeM65Da78TWnhQNBrYE
         jbZIRQxHfsgKA9RbwAscDYxaeOPi9P018XTQ2N0r43b2RqCEz7ymA40g4kWKkGF4V+Lb
         3lP52/Z6B6qjSboKuo1gka8xJbGYlpFwVdrj3w6LTLU64rClodbB5KSxK1ktPnwK7Q7y
         rF5w==
X-Gm-Message-State: AOAM5325zOZ5C/atvvqatLHiLsCwi+fQGIHBjH+RXXe0HFi8Kewy5Tyx
        m8J1Fot7luk9JIBtacsPQoVs0n+m3Vog1CYOtmPdCA==
X-Google-Smtp-Source: ABdhPJzcuEq6hEtGp/RuA1WuUUG66DlnCD5yVofYabzLuUce6XNWRGFHcbfZ4lO45gClZ9SymdQU9MCXPdAEiXr1pYI=
X-Received: by 2002:a17:902:26a:b029:da:af47:77c7 with SMTP id
 97-20020a170902026ab02900daaf4777c7mr579374plc.10.1612461979711; Thu, 04 Feb
 2021 10:06:19 -0800 (PST)
MIME-Version: 1.0
References: <601b773a.1c69fb81.9f381.a32a@mx.google.com> <6c65bcef-d4e7-25fa-43cf-2c435bb61bb9@collabora.com>
 <CAMj1kXHMw5hMuV5VapcTeok3WJu1B79=Z3Xho0qda0nCqBFERA@mail.gmail.com>
 <20210204100601.GT1463@shell.armlinux.org.uk> <CAMj1kXFog3=5zD7+P=cRfRLj1xfD1h1kU58iifASBSXkRe-E6g@mail.gmail.com>
 <c0037472-75c8-6cf9-6ecf-e671fce9d636@collabora.com> <46373679-a149-8a3d-e914-780e4c6ff8be@collabora.com>
 <CAMj1kXEshuPTrKvN4LpXQMftHJG+yH8+fgU7uVc6GYn0qd8-xA@mail.gmail.com>
 <7c685184-8688-9319-075b-66133cb0b0c3@collabora.com> <CAMj1kXH_CCYyd5zNVRL=KWpBXtsKamV7Bfg=O1YWBJL0f_eXLQ@mail.gmail.com>
In-Reply-To: <CAMj1kXH_CCYyd5zNVRL=KWpBXtsKamV7Bfg=O1YWBJL0f_eXLQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 4 Feb 2021 10:06:08 -0800
Message-ID: <CAKwvOd=ziPWHmBiPtW3h2VYLZ-CTMp4=aEonmMLM7c=Y0SeG1Q@mail.gmail.com>
Subject: Re: next/master bisection: baseline.login on rk3288-rock2-square
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Guillaume Tucker <guillaume.tucker@collabora.com>,
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

On Thu, Feb 4, 2021 at 8:02 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Thu, 4 Feb 2021 at 16:53, Guillaume Tucker
> <guillaume.tucker@collabora.com> wrote:
> >
> > On 04/02/2021 15:42, Ard Biesheuvel wrote:
> > > On Thu, 4 Feb 2021 at 12:32, Guillaume Tucker
> > > <guillaume.tucker@collabora.com> wrote:
> > >>
> > >> Essentially:
> > >>
> > >>   make -j18 ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- LLVM=1 CC="ccache clang" zImage

This command should link with BFD (and assemble with GAS; it's only
using clang as the compiler.

>
> To be honest, I am slightly annoyed that a change that works fine with
> GCC but does not work with Clang version
>
> 11.1.0-++20210130110826+3a8282376b6c-1~exp1~20210130221445.158
>
> (where exp means experimental, I suppose) is the reason for this
> discussion, especially because the change is in asm code. Is it
> possible to build with Clang but use the GNU linker?

rk3288 might be the last 32b ARM platform ChromeOS uses. "veyron"
-- 
Thanks,
~Nick Desaulniers
