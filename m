Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8D2C43E45C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 16:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbhJ1O6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 10:58:15 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:56153 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbhJ1O6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 10:58:13 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MMoKq-1mPgOb0rpM-00Im5d; Thu, 28 Oct 2021 16:55:45 +0200
Received: by mail-wm1-f46.google.com with SMTP id b82-20020a1c8055000000b0032ccc728d63so5310001wmd.1;
        Thu, 28 Oct 2021 07:55:45 -0700 (PDT)
X-Gm-Message-State: AOAM532/N7g6S5pOl9rEuz5PmvUljnl/3zHmeseFtDFX8NxX3rsHoQt8
        XUIXSKS3Eex1UI5utesIRq2D1HnJz+PFJxHa6d8=
X-Google-Smtp-Source: ABdhPJyG4uqa4KI4PxkZID5NK7baIbLWZaHnCQ9DvZVpGK/tLF/blE/NbR3DQZF6k+qtTHAHzW4lFAsVA+2j3CeEgVo=
X-Received: by 2002:a05:600c:1548:: with SMTP id f8mr5021740wmg.35.1635432944804;
 Thu, 28 Oct 2021 07:55:44 -0700 (PDT)
MIME-Version: 1.0
References: <20211028141938.3530-1-lukas.bulwahn@gmail.com> <20211028141938.3530-10-lukas.bulwahn@gmail.com>
In-Reply-To: <20211028141938.3530-10-lukas.bulwahn@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 28 Oct 2021 16:55:28 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2J3Eufd_LL7qX=0bui_PwkN1WATqrrigia3f6Z8b1tpg@mail.gmail.com>
Message-ID: <CAK8P3a2J3Eufd_LL7qX=0bui_PwkN1WATqrrigia3f6Z8b1tpg@mail.gmail.com>
Subject: Re: [PATCH 09/13] arm: milbeaut: remove select of non-existing PINCTRL_MILBEAUT
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linusw@kernel.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Takao Orito <orito.takao@socionext.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Sugaya Taichi <sugaya.taichi@socionext.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Qp7oa9KsoebkpfHalbn+jCKWAFV+hFejtjblL4QOIJSBoV9mZ3+
 m+JZfRkBDNi9ENKr2Gr05eR3ddkBwH/UQP+5Oc79OUhiXJH+WlrT6N/KfMYXFhNPhbeKqB6
 ZMde5Bvekp/nsdkiOThQFbv+Fp2y4HkreERlLeCYDMpQko6h19/xTZiDkLwV18hoVBEUDr6
 42jQ1HEQx6E2tl53nT3BQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ckdhxfsX8Bg=:LBleLPDK1gU7S73dqytxJP
 55/edOrIuP0rLwNyiEN7MfQ9kiHec4jI4mR56kIAowmamTYvG2osZ5vqj9z4wGAnl3FqHIPj4
 EzGDZcEQPqhPfgPZfW4qTYDZuRyBYshyCiUkCzBMW8wF6NVASu+FhpR9ovSyIW9Bbv7IxiLps
 ivWbgtCWr/sA8//6Wlc5MCOly4mywOkSYiLgYFL1HfpzxyxQbQqnGAkz/dF4qTu45QHlb4aIF
 Bg0O+k9IgMipP2OFlazXonFUczKUes8KWgSWqj5SLUROO4AG8/tNYeOAEJLAbhx0mxbHsn18K
 dSSeN+YidARh/juUa4oTvK57EZCJ9zRxusmw6zgKfrYFDiFS9qNIH5S0SUoDoQ1xm/GTrzByH
 EetOPDRuWa0XFWprLf7N0Ou/hhkItOqLAwc7pHgSI+DeAYjl5aOwqs1QnGR4A/NT6j8MpCIju
 oQj7dC8cwoRj3RMRjD8Pu5MKvK2Frk8f6Txun/AhD1b07cI3Lj1SUav/rH1BLEJMLXjn7zYUq
 qGyBv4LpC1U+CcmG92+6LBUrc9kR9W19b/LQj6V5oQvgw8y8kuC6rv27rDe4pTpNbxp4Gn21j
 QCocsjmORPawwb0xMRalHCZTUHoj5MNw95fTIbBDcCowZU+6R+CzyU8o/q5r9+c4bcz6ZdaiB
 VyHw3mDAC3Qxp8ppP1pCTYrehDloVzbJGsyUiQwexMvPhiUPC6fMU2qPHb8fZKINiQIdZmWM5
 kCAqURjnoB/NSKVhw0TbLX5mJrYcMKkK5KYWgh7V9SdS8iNT2tZYKFbGdubc1FMFhlEBBoEjX
 V4wfgk+d9BXuuLkOezRlzoEbISNV9Sec/v9sTXunrTXcFW2aT57ZLdrfQpmjjgx2DTHk0tJ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2021 at 4:19 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> The patch series "Add basic support for Socionext Milbeaut M10V SoC" (see
> Link) introduced the config ARCH_MILBEAUT_M10V "Milbeaut SC2000/M10V
> platform" in ./arch/arm/mach-milbeaut/ and intended to introduce timer,
> clock, pinctrl and serial controller drivers.
>
> However, during patch submission in March 2019, the introduction of the
> milbeaut pinctrl driver was dropped from v2 to v3 of the patch series.
> Since then, there was no further patch series to add this pinctrl driver
> later on.
>
> Hence, selecting PINCTRL_MILBEAUT in config is simply dangling and
> referring to a non-existing config symbols.
> Fortunately, ./scripts/checkkconfigsymbols.py warns:
>
> PINCTRL_MILBEAUT
> Referencing files: arch/arm/mach-milbeaut/Kconfig
>
> Remove this select of the non-existing PINCTRL_MILBEAUT for now.
>
> Link: https://lore.kernel.org/linux-arm-kernel/1551243056-10521-1-git-send-email-sugaya.taichi@socionext.com/
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

I would take that as an indication that there is no interest in supporting this
platform upstream any more, the version we merged probably never worked
without the rest of the drivers.

I've added the original authors of the other drivers to Cc. Should we remove
all of this?

        Arnd
