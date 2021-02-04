Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E226930F4EE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 15:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236610AbhBDO2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 09:28:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:36600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236683AbhBDO0P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 09:26:15 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3865664F65
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 14:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612448733;
        bh=BxmQ59Y5iTuM5QAd/885rVXznjrZbtWASvAyXhFfEG0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=I0lUo4WrceG1kIJQan07JV3GyGA6Gl8t40aUOccOKkAYt0BUOFQ13RfA3Q2Mu143P
         iAZ7WdPuNuEvr1Lqkk3bfhZZhCNlAWb8/tN4HYCFS+J+UjN8STV5uvSXV5GgrlFZCg
         IuKF5nTP4QZPHPZEqucXVeaFAkqkRKx364Vcx+oyxL7uvWTnH+9aJokyc23JBeYDbf
         9uhUATWG1U/wH4xrDk9+L+gm12P9nK1gVTJhSJNqkB9aAzUGeoKFctqg0NXaqzQEPb
         v7gmFkuWA3odfIT+DO+8VLgN/oTQNbhyVtAOaPxYpNlCB1M6F/lvjXiyGCgUhwbpqu
         FF2U13/QAdrwQ==
Received: by mail-ot1-f51.google.com with SMTP id i20so3535682otl.7
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 06:25:33 -0800 (PST)
X-Gm-Message-State: AOAM531BZFZ7m55r/WZlUbm6M4KcGEIVYzFXdwInRyxjeqt4w6mrslEP
        GWfSaWvW4VfIOk46yoibqQ+PcM1fHCdbRxJ44sE=
X-Google-Smtp-Source: ABdhPJwWs5H+6n3g8AjLY6Kwk92TzmmAH5NziCTa1BKm/2RHf7EBuVah6abRutea5O0flo3Xg1XJvL39rGTC3i6OK70=
X-Received: by 2002:a05:6830:1e2a:: with SMTP id t10mr5933685otr.90.1612448732363;
 Thu, 04 Feb 2021 06:25:32 -0800 (PST)
MIME-Version: 1.0
References: <601b773a.1c69fb81.9f381.a32a@mx.google.com> <6c65bcef-d4e7-25fa-43cf-2c435bb61bb9@collabora.com>
 <CAMj1kXHMw5hMuV5VapcTeok3WJu1B79=Z3Xho0qda0nCqBFERA@mail.gmail.com>
 <20210204100601.GT1463@shell.armlinux.org.uk> <CAMj1kXFog3=5zD7+P=cRfRLj1xfD1h1kU58iifASBSXkRe-E6g@mail.gmail.com>
 <20210204104714.GU1463@shell.armlinux.org.uk> <CAMj1kXF6SLXN3HQAG3SyOujX5MPCSrLG-k82iNz=61HjaiEEVw@mail.gmail.com>
 <090003e6f825de1f8460c0e987e14577@kernel.org> <20210204140911.GX1463@shell.armlinux.org.uk>
In-Reply-To: <20210204140911.GX1463@shell.armlinux.org.uk>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 4 Feb 2021 15:25:20 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHf0dNvsrfct6rCxi_yHXcQCqjwJoMa_TD0Fh6xo2zeZQ@mail.gmail.com>
Message-ID: <CAMj1kXHf0dNvsrfct6rCxi_yHXcQCqjwJoMa_TD0Fh6xo2zeZQ@mail.gmail.com>
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

On Thu, 4 Feb 2021 at 15:09, Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Thu, Feb 04, 2021 at 12:26:44PM +0000, Marc Zyngier wrote:
> > I agree. With set/way CMOs, there is no way to reach the PoC if
> > it beyond the system cache, leading to an unbootable kernel.
> > This is actually pretty well documented in the architecture,
> > and it did bite us for the first time on XGene-1, 7 years ago.
>
> That may be, however we still do set/way maintenance to invalidate
> the L1 cache as that is required for ARMv7 to place the cache into
> a known state, as stated by the architecture reference manual.
>

Getting a certain cache at a certain level into a known state is a
valid use of set/way ops, and is simply unnecessary when running under
virtualization, but doesn't do any harm.

Pushing contents of the cache hierarchy to main memory is *not* a
valid use of set/way ops, and so there is no point in pretending that
set/way ops will produce the same results as by-VA ops. Only the by-VA
ops give the architectural guarantees that we rely on for correctness.

> Arguably, that should be done by firmware, but when starting
> secondary CPUs, there are platforms out there which do not bring
> the L1 cache to a defined state. So we are pretty much stuck with
> doing set/way operations during CPU initialisation in the main
> kernel.
>

Indeed. And this is unfortunate, but not the end of the world.

> If ARMv8 decides that this is not supportable, then that's a matter
> for ARMv8 to address without impacting the requirements of ARMv7.
>

I'm not sure what you mean here. The v7 architecture is crystal clear
about the difference between set/way ops (managing a single cache),
and by-VA ops (managing the 'cachedness' state of a memory region).
The semantics are radically different, regardless of v7 vs v8 or
AArch32 vs AArch64.
