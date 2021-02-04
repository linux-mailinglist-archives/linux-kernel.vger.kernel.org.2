Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C358430F704
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 17:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237640AbhBDP7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 10:59:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:36006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237279AbhBDPxk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 10:53:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 670C564F53
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 15:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612453978;
        bh=ZdAuZPcoZEaVPzz7ZEgg3fhGai4PUQ1JL1xIyma+bj8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sCT6e0fcfsC2xuIhj9Hw64wKF1Ci2DRexlQUbunRKzT5wD8r5gDYKQ0Zr2yRnQKDw
         aBhrstuqN4PgxGWZOxblI3FFvz2UJuQYMbt0PitwY1j/izLJwDbVX300lcUVFzuxF3
         iKYBFRV9yLepxjZhFqfkwZhM5Vq22jnBT1cuoOqodhUF3dVIsksUCDs5ymqhdO5/yS
         SgKn0akUnQNnZJvAyM4DFZUxp/puzkgRuMUGHN7FOLE2vWJ4MU+Xg+vz3poWv0fzYM
         sVU5idnNsOuxnvxwc0QMDezgBTz/O3RDh4QTldRzvm6yfqmd9PKoKOuPNdj81tGUdM
         j3oclzxhzVcxQ==
Received: by mail-ot1-f49.google.com with SMTP id f6so3828662ots.9
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 07:52:58 -0800 (PST)
X-Gm-Message-State: AOAM532saKP2Xjj/cnvAXkfVIj+tqZJCSUJg9M04ldvFvrFAaIIGg1S0
        dAZyZ90H6JVP5xfhwffZIyW4TsizKGcEbDQRgRQ=
X-Google-Smtp-Source: ABdhPJzqQE6Q6jo0wbQEAD1B1MbGySl458frmN+rD+yLTuJ9X+TZpr3Laj6ontNGf5ubD/30uG+KxnV3neT+y/ACh9s=
X-Received: by 2002:a05:6830:1e2a:: with SMTP id t10mr6237891otr.90.1612453977649;
 Thu, 04 Feb 2021 07:52:57 -0800 (PST)
MIME-Version: 1.0
References: <601b773a.1c69fb81.9f381.a32a@mx.google.com> <6c65bcef-d4e7-25fa-43cf-2c435bb61bb9@collabora.com>
 <CAMj1kXHMw5hMuV5VapcTeok3WJu1B79=Z3Xho0qda0nCqBFERA@mail.gmail.com>
 <20210204100601.GT1463@shell.armlinux.org.uk> <CAMj1kXFog3=5zD7+P=cRfRLj1xfD1h1kU58iifASBSXkRe-E6g@mail.gmail.com>
 <20210204104714.GU1463@shell.armlinux.org.uk> <CAMj1kXF6SLXN3HQAG3SyOujX5MPCSrLG-k82iNz=61HjaiEEVw@mail.gmail.com>
 <090003e6f825de1f8460c0e987e14577@kernel.org> <20210204140911.GX1463@shell.armlinux.org.uk>
 <CAMj1kXHf0dNvsrfct6rCxi_yHXcQCqjwJoMa_TD0Fh6xo2zeZQ@mail.gmail.com> <20210204143618.GY1463@shell.armlinux.org.uk>
In-Reply-To: <20210204143618.GY1463@shell.armlinux.org.uk>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 4 Feb 2021 16:52:46 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHtrJ4dXO6MqBUWm4h3-uAJBRVSYUHWKBdao+ZQ=2B+Kw@mail.gmail.com>
Message-ID: <CAMj1kXHtrJ4dXO6MqBUWm4h3-uAJBRVSYUHWKBdao+ZQ=2B+Kw@mail.gmail.com>
Subject: Re: next/master bisection: baseline.login on rk3288-rock2-square
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Marc Zyngier <maz@kernel.org>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Nicolas Pitre <nico@fluxnic.net>, kernelci-results@groups.io
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Feb 2021 at 15:36, Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Thu, Feb 04, 2021 at 03:25:20PM +0100, Ard Biesheuvel wrote:
> > Pushing contents of the cache hierarchy to main memory is *not* a
> > valid use of set/way ops, and so there is no point in pretending that
> > set/way ops will produce the same results as by-VA ops. Only the by-VA
> > ops give the architectural guarantees that we rely on for correctness.
>
> ... yet we /were/ doing that, and it worked fine for 13 years - from
> 1st June 2007 until the by-VA merge into mainline on the 3rd April
> 2020.
>
> You may be right that it wasn't the most correct way, but it worked
> for those 13 years without issue, and it's only recently that it's
> become a problem, and trying to "fix" that introduced a regression,
> and fixing that regression has caused another regression... and I
> what I'm wondering is how many more regression fixing cycles it's
> going to take - how many regression fixes on top of other regression
> fixes are we going to end up seeing here.
>
> The fact is, we never properly understood why your patch caused the
> regression I was seeing. If we don't understand it, then we can never
> say that we've fixed the problem properly. That is highlighted by the
> fact that fixing the regression I was seeing has caused another
> regression.
>

I agree with all these points.

But as I pointed out, reverting the original by-VA change, which has
been there for almost a year now, has some risks of its own. If we
don't understand the details of how this is broken, how can we be sure
we don't break something else if we revert it again?

So I'm not arguing that reverting the original patch is unreasonable,
just that doing so at this point in the cycle is risky, and that it
would be better to queue the revert for v5.12, and only backport it
after some soak time in -next. And in a sense, reinstating the
cache_clean() before cache_off() already amounts to a partial revert
of the queued fix.
