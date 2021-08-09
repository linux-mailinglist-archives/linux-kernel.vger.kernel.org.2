Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38B593E45E3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 14:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233267AbhHIMqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 08:46:35 -0400
Received: from mail-ua1-f48.google.com ([209.85.222.48]:33343 "EHLO
        mail-ua1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbhHIMqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 08:46:34 -0400
Received: by mail-ua1-f48.google.com with SMTP id x21so2959416uau.0;
        Mon, 09 Aug 2021 05:46:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a+wHcKoZEavteV2xb7DM8Ck7atCZBnc8fVS0VNjsMas=;
        b=Eb9KO5LuTC6OgVaUnjckBCIoq9Nzu8JZrIMyZjkvnZPP7LIX485MJ6Aph5YY9anfye
         H3coE/9FCVkVJg7yW0s7F9AnYZ3dDXeqwuW/1iB5WPoMDE0fxNs03w0tVeI2p9W0Ynz0
         2IRh0JPIgNwnGiNYzk432jAJTkveuZZ25Gue7jhCt1Lq4QZ1c8NjtthXegkgJ0xsROo4
         yOfdO47AcbK63n/9XyFbXPz9nZnCho0YVvPOlJEXNZKNhHRCveO3B/SqqFUecBEWZKo5
         JVckJITV5qJs2qaxg83taiqdERKe94TMOuyjrzrUYaiRR/2g0j2+ypOXu3cShIDvw214
         FbVA==
X-Gm-Message-State: AOAM532/Lae7TN5ATwB4xScPHOXvaA/d+DsZoFiDRZO4hoXMZAP3Cz0F
        4lHZJxsgrb7S3B9u+Mr1kj9tv6QpbHBdsDZVhfo=
X-Google-Smtp-Source: ABdhPJw+AsNB9Y3ZhPiEE9DCk+0/AVv0O+PLJ/pHslFfgEwq0/RayiPR2IrJRL1q9LUX44InJN+PvSAjudjNcVxLA+o=
X-Received: by 2002:ab0:60c9:: with SMTP id g9mr15622021uam.100.1628513173766;
 Mon, 09 Aug 2021 05:46:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210730134552.853350-1-bert@biot.com> <20210730134552.853350-5-bert@biot.com>
 <CAK8P3a3OuJ3pMSdEA4Rt3aWvvuX2+_Bg5x7-kZ1++fvvJvgGxA@mail.gmail.com> <1e3070fe-b5da-0acc-f50b-b0986a1045cd@biot.com>
In-Reply-To: <1e3070fe-b5da-0acc-f50b-b0986a1045cd@biot.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 9 Aug 2021 14:46:02 +0200
Message-ID: <CAMuHMdWni=2ggV7dQiy-nfF1nOmKferbZOCkLp0kDsvMNfwF2Q@mail.gmail.com>
Subject: Re: [PATCH 4/5] ARM: Add basic support for EcoNet EN7523 SoC
To:     Bert Vermeulen <bert@biot.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        John Crispin <john@phrozen.org>,
        Ard Biesheuvel <ardb@kernel.org>,
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

Hoi Bert,

On Wed, Aug 4, 2021 at 6:43 PM Bert Vermeulen <bert@biot.com> wrote:
> On 7/30/21 4:48 PM, Arnd Bergmann wrote:
> > On Fri, Jul 30, 2021 at 3:45 PM Bert Vermeulen <bert@biot.com> wrote:
> >> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> >> index 173da685a52e..1bff0aa29c07 100644
> >> --- a/arch/arm/Makefile
> >> +++ b/arch/arm/Makefile
> >> @@ -152,6 +152,7 @@ textofs-$(CONFIG_ARCH_MSM8X60) := 0x00208000
> >>  textofs-$(CONFIG_ARCH_MSM8960) := 0x00208000
> >>  textofs-$(CONFIG_ARCH_MESON) := 0x00208000
> >>  textofs-$(CONFIG_ARCH_AXXIA) := 0x00308000
> >> +textofs-$(CONFIG_ARCH_ECONET) := 0x00088000
> >
> > Why is this needed?
> >
> > Note also the comment directly above it exlaining
> > # Text offset. This list is sorted numerically by address in order to
> > # provide a means to avoid/resolve conflicts in multi-arch kernels.
>
> I didn't make that patch, but it turns out it's needed to get PSCI working;
> detection hangs without it. That makes no sense to me, but I'll examine further.

Probably PSCI relies on the memory contents at the start of RAM not
being overwritten?
Does it help if you remove the first 512 KiB from the /memory node
(which should be declared in en7523-evb.dts instead of en7523.dtsi
BTW)?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
