Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03BA33E45EB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 14:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233802AbhHIMuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 08:50:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:36142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233365AbhHIMuA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 08:50:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 29B396103B;
        Mon,  9 Aug 2021 12:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628513380;
        bh=HiL45mc8BBJf4XGJxHdRi692t4yfB8rW7Eu6+7IFQIY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XjV5BsQ79iGc6KjcbzdbTkF4g5CznHUMf1isFQkc5qmnLcMe0/f2WtEtHJoBPmofO
         fXZ5COLMo/c2l9veslFtXsRmNiCYZSG5dCj7qeZCKQ5KFXnwM1tKAUcsLPvyV1gz47
         jxDAJ1PDbw3TRdVQ9Y1uvBYgFio8vqFPtA1+LL/W4rAaQO22dKKw6rOMR7WOJ8R7Ff
         nsx9lkymQ842eJKIAx7szc0tyu1bBfJWSRGjNmRmQTHjpg+UUAr9A4IEaEncllU357
         y/0L08sHgB+qYFv8g5/Fk2/pnwaxxuUPNDdjg5mOYlCebNxhVpiY8gkIDBpUfXmo/7
         Ewc4f/LK82HmQ==
Received: by mail-ot1-f52.google.com with SMTP id v24-20020a0568300918b02904f3d10c9742so14435162ott.4;
        Mon, 09 Aug 2021 05:49:40 -0700 (PDT)
X-Gm-Message-State: AOAM533cRBIwZ1n0Ck88F2augbgu+AXw9J7aPsbpSSYCcHQGwAOXoPxV
        Ki5nwCWQ9QLi5WaX92JrB8Cplq2edU4roPga+Tw=
X-Google-Smtp-Source: ABdhPJwYbKYfkJ7LlR5zDO3AgHbE+zPpStJL+ozb6ycoMhStYzCkKrUlSrMFFtS4MDFkai4LqE8KFKaSDZqSZEHyHGo=
X-Received: by 2002:a9d:5cb:: with SMTP id 69mr16831515otd.90.1628513379474;
 Mon, 09 Aug 2021 05:49:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210730134552.853350-1-bert@biot.com> <20210730134552.853350-5-bert@biot.com>
 <CAK8P3a3OuJ3pMSdEA4Rt3aWvvuX2+_Bg5x7-kZ1++fvvJvgGxA@mail.gmail.com>
 <1e3070fe-b5da-0acc-f50b-b0986a1045cd@biot.com> <CAMuHMdWni=2ggV7dQiy-nfF1nOmKferbZOCkLp0kDsvMNfwF2Q@mail.gmail.com>
In-Reply-To: <CAMuHMdWni=2ggV7dQiy-nfF1nOmKferbZOCkLp0kDsvMNfwF2Q@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 9 Aug 2021 14:49:28 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFUpb6JYndtX9LPpr-dOFQ2-m7n0z70+7Bh-JHhnfoMpw@mail.gmail.com>
Message-ID: <CAMj1kXFUpb6JYndtX9LPpr-dOFQ2-m7n0z70+7Bh-JHhnfoMpw@mail.gmail.com>
Subject: Re: [PATCH 4/5] ARM: Add basic support for EcoNet EN7523 SoC
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Bert Vermeulen <bert@biot.com>, Arnd Bergmann <arnd@arndb.de>,
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
        Viresh Kumar <viresh.kumar@linaro.org>,
        Felix Fietkau <nbd@nbd.name>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Aug 2021 at 14:46, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hoi Bert,
>
> On Wed, Aug 4, 2021 at 6:43 PM Bert Vermeulen <bert@biot.com> wrote:
> > On 7/30/21 4:48 PM, Arnd Bergmann wrote:
> > > On Fri, Jul 30, 2021 at 3:45 PM Bert Vermeulen <bert@biot.com> wrote:
> > >> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> > >> index 173da685a52e..1bff0aa29c07 100644
> > >> --- a/arch/arm/Makefile
> > >> +++ b/arch/arm/Makefile
> > >> @@ -152,6 +152,7 @@ textofs-$(CONFIG_ARCH_MSM8X60) := 0x00208000
> > >>  textofs-$(CONFIG_ARCH_MSM8960) := 0x00208000
> > >>  textofs-$(CONFIG_ARCH_MESON) := 0x00208000
> > >>  textofs-$(CONFIG_ARCH_AXXIA) := 0x00308000
> > >> +textofs-$(CONFIG_ARCH_ECONET) := 0x00088000
> > >
> > > Why is this needed?
> > >
> > > Note also the comment directly above it exlaining
> > > # Text offset. This list is sorted numerically by address in order to
> > > # provide a means to avoid/resolve conflicts in multi-arch kernels.
> >
> > I didn't make that patch, but it turns out it's needed to get PSCI working;
> > detection hangs without it. That makes no sense to me, but I'll examine further.
>
> Probably PSCI relies on the memory contents at the start of RAM not
> being overwritten?
> Does it help if you remove the first 512 KiB from the /memory node

I /think/ we rely on the first memblock being mappable using section
mappings, so it might be better to remove the first 1 MB (or 2 MB in
case the platform is LPAE capable). Note that this memory is discarded
in any case, so this change is not as costly as it may seem.


> (which should be declared in en7523-evb.dts instead of en7523.dtsi
> BTW)?
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
