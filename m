Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAB9730F14F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 11:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235461AbhBDK4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 05:56:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:53362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235378AbhBDK4F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 05:56:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4EB3864F72
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 10:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612436124;
        bh=iVOYJyr/gInCGMuwQ7LepyUha9WX21AN5d8OqnfR7uU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qOtWVjpEAiUSSLXsoyrSjnKcWA56wnfg5Z7L2v++SB2a/rhBNl35GlYhtDkYPZjJs
         7nNyhWIpMTk/fZicthRrKes4oM5F0J6Y9h3laweFtq3sMd9y9eVUTp7Jj7eZUaLsIQ
         OngZ53jrn6HBCpW89NXpIViLkoUR/Rfz2oWZ3RoffC8E4CoKwZGqHVxWQh4I6f8JKV
         LDQb09+nmK5gwOQ3daMw7Zo+JhfmemRyN7J/IQfjSFMLqtoG4qmfhN06tWoXV857nY
         y0YZDJ3rIBwEoTrHDx/whsFqIEKBybxM1pV2OpfXjqvy5+JJn8FJ42pOHaX2hBWkvn
         ODr4iHhIVY2ig==
Received: by mail-oi1-f171.google.com with SMTP id u66so1329548oig.9
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 02:55:24 -0800 (PST)
X-Gm-Message-State: AOAM530ey3b3zl6GdAkwfLjOK53kxfXUsXi1WvGHWTmMLaCIdi4v7uJF
        nUzVPppC1+NgZK5ISPcY96+7CnugfZd6FIhC9CI=
X-Google-Smtp-Source: ABdhPJw4JbNRArUMkqNa7P08Ruf3Tr/UdRMkHpqxhSV9cSbnh0Qa9NdrQXiRZyzMr7GGmJreApH8hXm7DEY/6Qfy3lc=
X-Received: by 2002:aca:ea0b:: with SMTP id i11mr4914161oih.33.1612436123393;
 Thu, 04 Feb 2021 02:55:23 -0800 (PST)
MIME-Version: 1.0
References: <601b773a.1c69fb81.9f381.a32a@mx.google.com> <6c65bcef-d4e7-25fa-43cf-2c435bb61bb9@collabora.com>
 <CAMj1kXHMw5hMuV5VapcTeok3WJu1B79=Z3Xho0qda0nCqBFERA@mail.gmail.com>
 <20210204100601.GT1463@shell.armlinux.org.uk> <CAMj1kXFog3=5zD7+P=cRfRLj1xfD1h1kU58iifASBSXkRe-E6g@mail.gmail.com>
 <20210204104714.GU1463@shell.armlinux.org.uk>
In-Reply-To: <20210204104714.GU1463@shell.armlinux.org.uk>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 4 Feb 2021 11:55:12 +0100
X-Gmail-Original-Message-ID: <CAMj1kXF6SLXN3HQAG3SyOujX5MPCSrLG-k82iNz=61HjaiEEVw@mail.gmail.com>
Message-ID: <CAMj1kXF6SLXN3HQAG3SyOujX5MPCSrLG-k82iNz=61HjaiEEVw@mail.gmail.com>
Subject: Re: next/master bisection: baseline.login on rk3288-rock2-square
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Marc Zyngier <maz@kernel.org>
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

(cc Marc)

On Thu, 4 Feb 2021 at 11:48, Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Thu, Feb 04, 2021 at 11:27:16AM +0100, Ard Biesheuvel wrote:
> > Hi Russell,
> >
> > If Guillaume is willing to do the experiment, and it fixes the issue,
> > it proves that rk3288 is relying on the flush before the MMU is
> > disabled, and so in that case, the fix is trivial, and we can just
> > apply it.
> >
> > If the experiment fails (which would mean rk3288 does not tolerate the
> > cache maintenance being performed after cache off), it is going to be
> > hairy, and so it will definitely take more time.
> >
> > So in the latter case (or if Guillaume does not get back to us), I
> > think reverting my queued fix is the only sane option. But in that
> > case, may I suggest that we queue the revert of the original by-VA
> > change for v5.12 so it gets lots of coverage in -next, and allows us
> > an opportunity to come up with a proper fix in the same timeframe, and
> > backport the revert and the subsequent fix as a pair? Otherwise, we'll
> > end up in the situation where v5.10.x until today has by-va, v5.10.x-y
> > has set/way, and v5.10y+ has by-va again. (I don't think we care about
> > anything before that, given that v5.4 predates any of this)
>
> I'm suggesting dropping your fix (9052/1) and reverting
> "ARM: decompressor: switch to by-VA cache maintenance for v7 cores"
> which gets us to a point where _both_ regressions are fixed.
>

I understand, but we don't know whether doing so might regress other
platforms that were added in the mean time.

> I'm of the opinion that the by-VA patch was incorrect when it was
> merged (it caused a regression), and it's only a performance
> improvement.

It is a correctness improvement, not a performance improvement.

Without that change, the 32-bit ARM kernel cannot boot bare metal on
platforms with a system cache such as 8040 or SynQuacer, and can only
boot under KVM on such systems because of the special handling of
set/way instructions by the host.

The performance issue related to set/way ops under KVM was already
fixed by describing data and unified caches as 1 set and 1 way when
running in 32-bit mode.


> Our attempts so far to fix it are just causing other
> regressions. So, I think it is reasonable to revert both back to a
> known good point which has worked over a decade. If doing so causes
> regressions (which I think is unlikely), then that would be unfortunate
> but alas is a price that's worth paying to get back to a known good
> point - since then we're not stacking regression fixes on top of other
> regression fixes.
>

This is exactly why I am proposing to queue the revert of the original
patch for v5.12, and only backport it to v5.10 and v5.11 once we are
sure it does not break anything else.
