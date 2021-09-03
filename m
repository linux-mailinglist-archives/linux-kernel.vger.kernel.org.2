Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23389400448
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 19:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349790AbhICRsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 13:48:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:43896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229789AbhICRsY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 13:48:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CB5E4610F9;
        Fri,  3 Sep 2021 17:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630691243;
        bh=GHPzr9KnRPIHt8M4CiAcDe/rlIXPuUPBCeZTgZ5vpIQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=c3CYMEUbv15YTiTAMOAltio0RwKJ9DpXmmhtIvrga36APhG0IAGJItdZ1cEzzosDW
         HqtMQZBKd2n857R7HUdbp9lnmAFDdIyDOuOSZTqvvtK3SozaG0A8EoSzYW1AshwgJk
         s7oUKeQtqCEy7fxTmOFfUD4t2I1Kgcut6D7WjtA6ZAyMpODKLQX7yC/IHSkdfWftle
         vSVC+Un7bVTgdsDfqDH0YctarxpA8THtIUF7LzKoXtcmnQBwqxzd6/GYLepexCPRpq
         vRNpFqg8Ma4f+0yUJ0wXOFFa5OlHQ9sJOvokuIWmJnkUxAzT1S+SxcfYia+F8z9TmU
         xxKnOg8TEOGuA==
Received: by mail-oi1-f169.google.com with SMTP id w144so106866oie.13;
        Fri, 03 Sep 2021 10:47:23 -0700 (PDT)
X-Gm-Message-State: AOAM5329qerYbnEpHa0mHOEH3mWxK4xyhHMAArJoDBImI2woIAo2MYGp
        AK0YnqqAgfrl3lTijLJPDr42v6ZxIwCLBbCbUyQ=
X-Google-Smtp-Source: ABdhPJy6C2mSGLCYvOgLLumuIFftDtf2mI3ojWp06p8qQ2pdtqK0tyt/TnAtFrwSR5JrtP1FIXgulu5bxTnZi49tjwk=
X-Received: by 2002:a54:418e:: with SMTP id 14mr29159oiy.174.1630691242892;
 Fri, 03 Sep 2021 10:47:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210730134552.853350-1-bert@biot.com> <20210730134552.853350-5-bert@biot.com>
 <CAK8P3a3OuJ3pMSdEA4Rt3aWvvuX2+_Bg5x7-kZ1++fvvJvgGxA@mail.gmail.com>
 <CAMj1kXFK+HoouMMBbHxEgm-zQqKa6QMS6keeZmhpXTc4FCy8fQ@mail.gmail.com> <7d3e2c5b-931c-1f82-77a3-fc51268f1986@nbd.name>
In-Reply-To: <7d3e2c5b-931c-1f82-77a3-fc51268f1986@nbd.name>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 3 Sep 2021 19:47:12 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHGfTSv+95NJF1BPS76M6-6FF9GQk24L2LLG9Epx4FpfA@mail.gmail.com>
Message-ID: <CAMj1kXHGfTSv+95NJF1BPS76M6-6FF9GQk24L2LLG9Epx4FpfA@mail.gmail.com>
Subject: Re: [PATCH 4/5] ARM: Add basic support for EcoNet EN7523 SoC
To:     Felix Fietkau <nbd@nbd.name>
Cc:     Arnd Bergmann <arnd@arndb.de>, Bert Vermeulen <bert@biot.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        John Crispin <john@phrozen.org>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Mike Rapoport <rppt@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Sept 2021 at 18:20, Felix Fietkau <nbd@nbd.name> wrote:
>
>
> On 2021-08-01 18:44, Ard Biesheuvel wrote:
> > On Fri, 30 Jul 2021 at 16:48, Arnd Bergmann <arnd@arndb.de> wrote:
> >>
> >> Why is this needed?
> >>
> >> Note also the comment directly above it exlaining
> >> # Text offset. This list is sorted numerically by address in order to
> >> # provide a means to avoid/resolve conflicts in multi-arch kernels.
> >>
> >
> > Yes, please drop this - it is a horrible hack and it's already quite
> > disappointing that we are stuck with it for the foreseeable future.
> >
> > So I assume the purpose of this is to protect the first 128k of DRAM
> > to be protected from being overwritten by the decompressor?
> >
> > It would be best to move this reserved region elsewhere, but I can
> > understand that this is no longer an option. So the alternatives are
> > - omit this window from the /memory node, and rely on Geert's recent
> > decompressor changes which make it discover the usable memory from the
> > DT, or
> > - better would be to use a /memreserve/ here (which you may already
> > have?), and teach the newly added decompressor code to take those into
> > account when choosing the target window for decompressing the kernel.
> I looked into this issue myself and found that this approach has a
> significant drawback: 2 MiB of RAM is permanently wasted for something
> that only needs to be preserved during boot time.
>

How so? If that memory region carries your PSCI implementation, it
should be preserved permanently. So at least the 512k are permanently
reserved.

> If the first 256 or 512 KiB of RAM are reserved in the decompressor, it
> means that the first 2 MiB need to be reserved, because that's the
> granularity for the kernel page mapping when the MMU is turned on.
>

Indeed.

> If we reserve it, we also need to need to take it out of the physical
> RAM address range, so there's no way to reclaim it later.
>
> On the other hand, with the simple textofs solution, I believe it gets
> freed in a late initcall, making it usable.
>
> So what's the right approach to deal with this?
>

The right solution here is to fix your firmware/bootloader so that the
PSCI reserved region is moved to the top of memory. Adding more
TEXT_OFFSET hacks is really not the right approach here.
