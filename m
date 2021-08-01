Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE0713DCCB7
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Aug 2021 18:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbhHAQo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 12:44:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:44008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229548AbhHAQo2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 12:44:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 27C9B610CE;
        Sun,  1 Aug 2021 16:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627836260;
        bh=XkN/0HlRnn1J0tNRiBvBaztD4kNQZthcZ1uCFGXTeLA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=m/gZd7Cp2b8pM+E3o/anhcsu16RuMH/nHHFKq5k1cJ67Lj9h6V6g2F0kmPJ9FFHc4
         8iUmpm5hU7KK2AeOmtmbYTa+Pwt7+NjWORkPU6Jc+mSUq9/uqsP5Ugw4Q8oQod5DM0
         +FlAQFxQ+1BVxjgVMvwIGIyt3vsep2ygwS1JMECzvyfaHeZKUzzoQRNi+/vqxBs4up
         RYRJtYX1h4eglfnbCoMbInIOmEUm7XTBmqfgbk9irS1p3U603tsXRci5H6IJlg+88+
         5CbiHd/R/aId8jAsqbabkJCeGW6Or+8pVJkOLcjmjmox8OVn/xYmZSo0ZM19qBs/1/
         jDUiJTIOhH0ng==
Received: by mail-oi1-f171.google.com with SMTP id u10so21234270oiw.4;
        Sun, 01 Aug 2021 09:44:20 -0700 (PDT)
X-Gm-Message-State: AOAM531HAne/Tw5cv3wV1d+zKDRy2x3tGvRCa3Jy6a1/3x2lOQofDQJv
        Hz7MPxzxupWzM0b+VmU2LVDXdetxFCwkhKvsTbc=
X-Google-Smtp-Source: ABdhPJwru+GPIfnxnY+Mb/e0vfuLbQ5kzslJIYdNjhk/2M2TH7OuUaiNedrwBgjnOFdBmPdWejxZjDfhr5+oB2N/bYs=
X-Received: by 2002:aca:d64d:: with SMTP id n74mr8229062oig.47.1627836259302;
 Sun, 01 Aug 2021 09:44:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210730134552.853350-1-bert@biot.com> <20210730134552.853350-5-bert@biot.com>
 <CAK8P3a3OuJ3pMSdEA4Rt3aWvvuX2+_Bg5x7-kZ1++fvvJvgGxA@mail.gmail.com>
In-Reply-To: <CAK8P3a3OuJ3pMSdEA4Rt3aWvvuX2+_Bg5x7-kZ1++fvvJvgGxA@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 1 Aug 2021 18:44:08 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFK+HoouMMBbHxEgm-zQqKa6QMS6keeZmhpXTc4FCy8fQ@mail.gmail.com>
Message-ID: <CAMj1kXFK+HoouMMBbHxEgm-zQqKa6QMS6keeZmhpXTc4FCy8fQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] ARM: Add basic support for EcoNet EN7523 SoC
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Bert Vermeulen <bert@biot.com>, DTML <devicetree@vger.kernel.org>,
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

On Fri, 30 Jul 2021 at 16:48, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, Jul 30, 2021 at 3:45 PM Bert Vermeulen <bert@biot.com> wrote:
> >
> > From: John Crispin <john@phrozen.org>
> >
> > EN7523 is an armv7 based silicon used inside broadband access type devices
> > such as xPON and xDSL. It shares various silicon blocks with MediaTek
> > silicon such as the MT7622.
> >
> > Signed-off-by: John Crispin <john@phrozen.org>
> > Signed-off-by: Bert Vermeulen <bert@biot.com>
>
> It's always nice to see a new SoC family.
>
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -580,6 +580,20 @@ config ARCH_VIRT
> >         select HAVE_ARM_ARCH_TIMER
> >         select ARCH_SUPPORTS_BIG_ENDIAN
> >
> > +config ARCH_ECONET
> > +       bool "Econet SoC Support"
> > +       depends on ARCH_MULTI_V7
> > +       select ARM_AMBA
> > +       select ARM_GIC
> > +       select ARM_GIC_V3
> > +       select ARM_DMA_USE_IOMMU
> > +       select ARM_PSCI
> > +       select HAVE_ARM_ARCH_TIMER
> > +       select IOMMU_DMA
> > +       select COMMON_CLK
> > +       help
> > +         Support for Econet EN7523 SoCs
>
> Given how closely related this probably is to MT7623/MT7622, should this
> perhaps just be part of arch/arm/mach-mediatek? According to
> https://wikidevi.wi-cat.ru/MediaTek#xPON, the older (mips based) MT752x
> chips are apparently just rebranded to EN752x after the business unit
> was spun off, but I guess they are still in the same family.
>
> > diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> > index 173da685a52e..1bff0aa29c07 100644
> > --- a/arch/arm/Makefile
> > +++ b/arch/arm/Makefile
> > @@ -152,6 +152,7 @@ textofs-$(CONFIG_ARCH_MSM8X60) := 0x00208000
> >  textofs-$(CONFIG_ARCH_MSM8960) := 0x00208000
> >  textofs-$(CONFIG_ARCH_MESON) := 0x00208000
> >  textofs-$(CONFIG_ARCH_AXXIA) := 0x00308000
> > +textofs-$(CONFIG_ARCH_ECONET) := 0x00088000
>
> Why is this needed?
>
> Note also the comment directly above it exlaining
> # Text offset. This list is sorted numerically by address in order to
> # provide a means to avoid/resolve conflicts in multi-arch kernels.
>

Yes, please drop this - it is a horrible hack and it's already quite
disappointing that we are stuck with it for the foreseeable future.

So I assume the purpose of this is to protect the first 128k of DRAM
to be protected from being overwritten by the decompressor?

It would be best to move this reserved region elsewhere, but I can
understand that this is no longer an option. So the alternatives are
- omit this window from the /memory node, and rely on Geert's recent
decompressor changes which make it discover the usable memory from the
DT, or
- better would be to use a /memreserve/ here (which you may already
have?), and teach the newly added decompressor code to take those into
account when choosing the target window for decompressing the kernel.

--
Ard.
