Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53A1930FB11
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 19:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238463AbhBDSOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 13:14:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:41410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238914AbhBDSMf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 13:12:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B981B64E27;
        Thu,  4 Feb 2021 18:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612462339;
        bh=x8hI02Op/2ti8scBYxHtyyHU2C3voD9ZrVdcRQhFOk0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GFniNQHRCPa11vLLhb2Z0q2vkyoAACvcuprHkIRrM9sZp2Ai0n1ABY8Ch9ZOK2W3L
         X6pWHEw6Udi2kuYl1SDc9ff13WAn8hygMv8t3xUpkjglotx5POYECt7URsOeLYEJeX
         qPNViy2UFMAke5BMLtIdUoByPf0tzESO7xLrtMTEtL2veMln+86qQHHyHVAZWsWorY
         IEt/CEPAEjXIMXhdCtZol0JrtyHS/V93BqOCnHwVaGY0V2jmysk73mFPTHqIJf5Onz
         Ui184gXo+kHwSL3HnWiTjQ5xXZyZDoInQR7oitu7DnWG/o0bnVEtDr+SZLAVwnXxTA
         VW6JOE+Jb/KSQ==
Date:   Thu, 4 Feb 2021 11:12:16 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
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
Subject: Re: next/master bisection: baseline.login on rk3288-rock2-square
Message-ID: <20210204181216.GB2989696@localhost>
References: <6c65bcef-d4e7-25fa-43cf-2c435bb61bb9@collabora.com>
 <CAMj1kXHMw5hMuV5VapcTeok3WJu1B79=Z3Xho0qda0nCqBFERA@mail.gmail.com>
 <20210204100601.GT1463@shell.armlinux.org.uk>
 <CAMj1kXFog3=5zD7+P=cRfRLj1xfD1h1kU58iifASBSXkRe-E6g@mail.gmail.com>
 <c0037472-75c8-6cf9-6ecf-e671fce9d636@collabora.com>
 <46373679-a149-8a3d-e914-780e4c6ff8be@collabora.com>
 <CAMj1kXEshuPTrKvN4LpXQMftHJG+yH8+fgU7uVc6GYn0qd8-xA@mail.gmail.com>
 <7c685184-8688-9319-075b-66133cb0b0c3@collabora.com>
 <CAMj1kXH_CCYyd5zNVRL=KWpBXtsKamV7Bfg=O1YWBJL0f_eXLQ@mail.gmail.com>
 <CAKwvOd=ziPWHmBiPtW3h2VYLZ-CTMp4=aEonmMLM7c=Y0SeG1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOd=ziPWHmBiPtW3h2VYLZ-CTMp4=aEonmMLM7c=Y0SeG1Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04, 2021 at 10:06:08AM -0800, 'Nick Desaulniers' via Clang Built Linux wrote:
> On Thu, Feb 4, 2021 at 8:02 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Thu, 4 Feb 2021 at 16:53, Guillaume Tucker
> > <guillaume.tucker@collabora.com> wrote:
> > >
> > > On 04/02/2021 15:42, Ard Biesheuvel wrote:
> > > > On Thu, 4 Feb 2021 at 12:32, Guillaume Tucker
> > > > <guillaume.tucker@collabora.com> wrote:
> > > >>
> > > >> Essentially:
> > > >>
> > > >>   make -j18 ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- LLVM=1 CC="ccache clang" zImage
> 
> This command should link with BFD (and assemble with GAS; it's only
> using clang as the compiler.

I think you missed the 'LLVM=1' before CC="ccache clang". That should
use all of the LLVM utilities minus the integrated assembler while
wrapping clang with ccache.

Cheers,
Nathan
