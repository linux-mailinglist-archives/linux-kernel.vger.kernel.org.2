Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2241D30F0C9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 11:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235558AbhBDKaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 05:30:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:39210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235496AbhBDK2N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 05:28:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BD7CC64F60
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 10:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612434448;
        bh=yCoeut0drLcwrS9n7RZjkMuHTeLRzFjIyZU3UZAnhBo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lu2wo0Mgb2bBt/shUTS/Vkik8Cqu7sQRfketIi3rDVOw9fCKi0JJ70pEOpU+J03il
         zWRvPzvdO/8XP2Qxc+ZbbR6EhYik6wsUj88cmiJKodupyOFrWm1j4q/ixBZD6mc6QI
         rprHDNW1dOodNpF6fkcu+c6QM3oxwHlOhg6jFJ8oFDDDBnGFIzcaPA4muOKKm8seiD
         ZsByMiMpsJj/z/rkTcrDszDb6X2GifyuyyzxkDONYsQ9yZEIx7+zb7Any+Y1Rwmven
         lLGvjjfuiGMKu9N7coIkxIYFVcuDKvdjwSNyDwdK1LgVS+MskAPB5qFx6XNVOiNkI6
         CKojRoVTCneyg==
Received: by mail-oi1-f176.google.com with SMTP id w8so3213176oie.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 02:27:28 -0800 (PST)
X-Gm-Message-State: AOAM531JM/Noc1KSIBXsWAxSOgfTOZWLs0jxg709UW1KdND1G3Ino0dt
        ga3ew+mwz74LcTXR4kBEV94yE40j7z3f8CZofw4=
X-Google-Smtp-Source: ABdhPJwigjuckw6lzAxUnWPqKGLjsgNRFjckF8K+UaZHN2/rxkfrejJp69CGA/HBVSXy2UbChvqQtzOOADZRv1Bh9MY=
X-Received: by 2002:aca:ea0b:: with SMTP id i11mr4865934oih.33.1612434447920;
 Thu, 04 Feb 2021 02:27:27 -0800 (PST)
MIME-Version: 1.0
References: <601b773a.1c69fb81.9f381.a32a@mx.google.com> <6c65bcef-d4e7-25fa-43cf-2c435bb61bb9@collabora.com>
 <CAMj1kXHMw5hMuV5VapcTeok3WJu1B79=Z3Xho0qda0nCqBFERA@mail.gmail.com> <20210204100601.GT1463@shell.armlinux.org.uk>
In-Reply-To: <20210204100601.GT1463@shell.armlinux.org.uk>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 4 Feb 2021 11:27:16 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFog3=5zD7+P=cRfRLj1xfD1h1kU58iifASBSXkRe-E6g@mail.gmail.com>
Message-ID: <CAMj1kXFog3=5zD7+P=cRfRLj1xfD1h1kU58iifASBSXkRe-E6g@mail.gmail.com>
Subject: Re: next/master bisection: baseline.login on rk3288-rock2-square
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Guillaume Tucker <guillaume.tucker@collabora.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Nicolas Pitre <nico@fluxnic.net>,
        "kernelci-results@groups.io" <kernelci-results@groups.io>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Feb 2021 at 11:06, Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Thu, Feb 04, 2021 at 10:07:58AM +0100, Ard Biesheuvel wrote:
> > On Thu, 4 Feb 2021 at 09:43, Guillaume Tucker
> > <guillaume.tucker@collabora.com> wrote:
> > >
> > > Hi Ard,
> > >
> > > Please see the bisection report below about a boot failure on
> > > rk3288 with next-20210203.  It was also bisected on
> > > imx6q-var-dt6customboard with next-20210202.
> > >
> > > Reports aren't automatically sent to the public while we're
> > > trialing new bisection features on kernelci.org but this one
> > > looks valid.
> > >
> > > The kernel is most likely crashing very early on, so there's
> > > nothing in the logs.  Please let us know if you need some help
> > > with debugging or trying a fix on these platforms.
> > >
> >
> > Thanks for the report.
>
> Ard,
>
> I want to send my fixes branch today which includes your regression
> fix that caused this regression.
>
> As this is proving difficult to fix, I can only drop your fix from
> my fixes branch - and given that this seems to be problematical, I'm
> tempted to revert the original change at this point which should fix
> both of these regressions - and then we have another go at getting rid
> of the set/way instructions during the next cycle.
>
> Thoughts?
>

Hi Russell,

If Guillaume is willing to do the experiment, and it fixes the issue,
it proves that rk3288 is relying on the flush before the MMU is
disabled, and so in that case, the fix is trivial, and we can just
apply it.

If the experiment fails (which would mean rk3288 does not tolerate the
cache maintenance being performed after cache off), it is going to be
hairy, and so it will definitely take more time.

So in the latter case (or if Guillaume does not get back to us), I
think reverting my queued fix is the only sane option. But in that
case, may I suggest that we queue the revert of the original by-VA
change for v5.12 so it gets lots of coverage in -next, and allows us
an opportunity to come up with a proper fix in the same timeframe, and
backport the revert and the subsequent fix as a pair? Otherwise, we'll
end up in the situation where v5.10.x until today has by-va, v5.10.x-y
has set/way, and v5.10y+ has by-va again. (I don't think we care about
anything before that, given that v5.4 predates any of this)

But in the end, I'm happy to go along with whatever works best for you.
