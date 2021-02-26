Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAA30326092
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 10:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbhBZJxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 04:53:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:51562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230188AbhBZJwi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 04:52:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2256064EEE
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 09:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614333117;
        bh=ApJaVYzJeY8MVteoWjvp93/sOHg/735tReQS2Q+OzCA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=D1D7MK9GBenuzDq23SDzmnkg6URzwCPAXfx3GPr4DmE6aIHZGWWueJJzqsIJLHrQW
         3BwpM0vcW2rVpJ0dZB5S73P2SXDEZgEFlmdreULCdwr6h3iejm32AX6kbWaeeV4dsr
         98kx77mS5gzuZQVX3X4BiOn+qEjTUzd786zy+/1ML9O+BoxKL03uBsjFAiPN7vZxvl
         BZm3nYOfZYOMIfykZfzErQROyKdms0P309J8iiijjxiEqZmyg7dC3pdSvK+8gQ2rAM
         vpzCxTEFiCcobt5FKFu/SD+VuPTftv4d5cnWlXoe3GdbUXqzdeGpBgOFwIOEQRrMm8
         pWDcFEcH0qvbg==
Received: by mail-ot1-f53.google.com with SMTP id 40so171651otu.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 01:51:57 -0800 (PST)
X-Gm-Message-State: AOAM532W4B7ic+yHCklXgB40XXbVfTjoW32kg/2ARBuYOIGYJgn+BNdU
        LzjJiNtzCn2luzBsXwrIwDNWwDsDnIeSBnzKYGM=
X-Google-Smtp-Source: ABdhPJwWMFB8RCNioZobpm/xPLgdfIRzTGssxm+clf270OodDNb4DJPh+Y3YNRV/I9WnrOVFWKyxldNGczV4JlasNlQ=
X-Received: by 2002:a9d:6b8b:: with SMTP id b11mr1655619otq.210.1614333116293;
 Fri, 26 Feb 2021 01:51:56 -0800 (PST)
MIME-Version: 1.0
References: <20210225112122.2198845-1-arnd@kernel.org> <CA+icZUUDnKBxkfgOVYDdpA29GnLUTT22mqRNyxQeYmay044ejg@mail.gmail.com>
 <CAK8P3a1QmS6g3cHTR93wWPkKs8vaP6RJEb8nZbTMLX+xphLJRw@mail.gmail.com> <CA+icZUW9Hzm_ZZtLiJu8pVeOmYJMOaXkV4Om_u4yZKYRVWNddA@mail.gmail.com>
In-Reply-To: <CA+icZUW9Hzm_ZZtLiJu8pVeOmYJMOaXkV4Om_u4yZKYRVWNddA@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 26 Feb 2021 10:51:40 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0cyAYqdPg_OoaVVY2Gjn=vtwAyfsVPjZ5qYddiOOc-eA@mail.gmail.com>
Message-ID: <CAK8P3a0cyAYqdPg_OoaVVY2Gjn=vtwAyfsVPjZ5qYddiOOc-eA@mail.gmail.com>
Subject: Re: [PATCH] [RFC] arm64: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Scull <ascull@google.com>,
        David Brazdil <dbrazdil@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 10:05 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> On Fri, Feb 26, 2021 at 9:14 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> > > BTW, is CONFIG_LD_DEAD_CODE_DATA_ELIMINATION=y setable for x86 (64bit)?
> > > ( Did not look or check for it. )
> >
> > No, in mainline, HAVE_LD_DEAD_CODE_DATA_ELIMINATION is currently
> > only selected on MIPS and PowerPC. I only sent experimental patches to
> > enable it on arm64 and m68k, but have not tried booting them. If you
> > select the symbol on x86, you should see similar results.
> >
>
> OK, i see:
>
> $ git grep HAVE_LD_DEAD_CODE_DATA_ELIMINATION arch/mips/
> arch/mips/Kconfig:      select HAVE_LD_DEAD_CODE_DATA_ELIMINATION
>
> $ git grep HAVE_LD_DEAD_CODE_DATA_ELIMINATION arch/powerpc/
> arch/powerpc/Kconfig:   select HAVE_LD_DEAD_CODE_DATA_ELIMINATION
>
> So, I need to add this to arch/x86/Kconfig.
>
> You happen to know if changes to arch/x86/kernel/vmlinux.lds.S
> (sections) are needed?

No idea. I'm still debugging a possible regression on arm64, but both
issues I found for arm64 are specific to that architecture and won't
happen on x86. It's likely that something else breaks though.

> Last question:
> The last days I see a lot of fixes touching inlining with LLVM/Clang v13-git.
> What git tag are you using?
> What are your experiences?
> Pending patches (kernel-side)?
>
> I use:
> $ /opt/llvm-toolchain/bin/clang --version
> dileks clang version 13.0.0 (https://github.com/llvm/llvm-project.git
> c465429f286f50e52a8d2b3b39f38344f3381cce)

This is what I have on the build box:
Ubuntu clang version
13.0.0-++20210223104451+ebca13c66504-1~exp1~20210223095200.234

        Arnd
