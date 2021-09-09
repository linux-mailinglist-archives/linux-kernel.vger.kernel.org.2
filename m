Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 501C140460E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 09:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351207AbhIIHXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 03:23:45 -0400
Received: from mail-vs1-f52.google.com ([209.85.217.52]:45034 "EHLO
        mail-vs1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232549AbhIIHXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 03:23:42 -0400
Received: by mail-vs1-f52.google.com with SMTP id c28so242870vsh.11
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 00:22:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H+v9d+F4bPXyUIm8JGEVsogxeJe3xHOqeC0XMGmz7YE=;
        b=AXw8YVcOEo5ij/CsYsTRm8ztk5kDmz+0lXfXj0QGttm/3oDyEjN91rU3X0aoNVZhyn
         lGkn9ynOC0pjXkEYqHoWflDRzmQDwFp2OxDks6sEhY1WJintOn8zRHBO57Ho97ttpwPr
         ROXQxVloxn4GeH8MKwl8XavEil0ZtO28ZeUP4P6EDtD7pcuU0r7SEiwYmDCQw/fnL0bj
         Dt1SwoaB03yRGLp9ROOqxpuRjzhIloQDb6rb1gR14ldcy0Aa69lpb4Loy2CYgx67q0Th
         gCUm0pAxfrsEGCVo4TOxQ0o9VJ9LECCmdi8YJJdPbgYrA0zS0ZxJOT7HzeqpG532CYPD
         nQCA==
X-Gm-Message-State: AOAM533gF4ZmIGRWPWUgaOPONSvt86C1WNQvX0J89IGKFM4lhjF30iKs
        UBCWks3zEsYGLnUU7zGMFuTu9KY/s+1FHW1Y86s=
X-Google-Smtp-Source: ABdhPJykTjIN3pE9TsAbMpbP3TTqT1MAxeOy9g6mTRjOzKkl8dmcBEB1NsgVKqbiG1dFvptnf51LnAoJDd9zdC/P1yI=
X-Received: by 2002:a67:3289:: with SMTP id y131mr621870vsy.37.1631172151478;
 Thu, 09 Sep 2021 00:22:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210707214752.3831-1-rdunlap@infradead.org> <fca8f952-2be0-5c57-d60d-5c4f025abc4d@microchip.com>
 <49495ab9-5039-f332-2895-1a79c034f58d@infradead.org> <CAMuHMdU=ODKZJ0OOsuCeJnTWuM3fP5DE7coSzB=fvAbxPQWDcg@mail.gmail.com>
 <a94c9788-0415-ffe3-9dd4-e6ed8d7ee96a@infradead.org> <CAMuHMdWUcaC-xiW0UiVdTpx-R=e_i8eHSNc8JF_wqbcO6FynWw@mail.gmail.com>
 <f5cf4155-785f-9ec7-1f59-be5c92911b0a@infradead.org>
In-Reply-To: <f5cf4155-785f-9ec7-1f59-be5c92911b0a@infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 9 Sep 2021 09:22:19 +0200
Message-ID: <CAMuHMdXcmW27KhQEgxmVSDgR8GDnb_5mYNPYepa15F_tKqk9-A@mail.gmail.com>
Subject: Re: [PATCH v3] ASoC: atmel: ATMEL drivers don't need HAS_DMA
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Codrin.Ciubotariu@microchip.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, mirq-linux@rere.qmqm.pl,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On Wed, Sep 8, 2021 at 10:14 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> On 9/6/21 12:14 AM, Geert Uytterhoeven wrote:
> > On Fri, Sep 3, 2021 at 9:53 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> >> On 9/2/21 9:44 AM, Geert Uytterhoeven wrote:
> >>> On Thu, Jul 8, 2021 at 6:51 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> >>>> On 7/8/21 1:19 AM, Codrin.Ciubotariu@microchip.com wrote:
> >>>>> On 08.07.2021 00:47, Randy Dunlap wrote:
> >>>>>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >>>>>>
> >>>>>> On a config (such as arch/sh/) which does not set HAS_DMA when MMU
> >>>>>> is not set, several ATMEL ASoC drivers select symbols that cause
> >>>>>> kconfig warnings. There is one "depends on HAS_DMA" which is no longer
> >>>>>> needed. Dropping it eliminates the kconfig warnings and still builds
> >>>>>> with no problems reported.
> >>>>>>
> >>>>>> Fix the following kconfig warnings:
> >>>>>>
> >>>>>> WARNING: unmet direct dependencies detected for SND_ATMEL_SOC_PDC
> >>>>>>      Depends on [n]: SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_ATMEL_SOC [=m] && HAS_DMA [=n]
> >>>>>>      Selected by [m]:
> >>>>>>      - SND_ATMEL_SOC_SSC [=m] && SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_ATMEL_SOC [=m]
> >>>>>>      - SND_ATMEL_SOC_SSC_PDC [=m] && SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_ATMEL_SOC [=m] && ATMEL_SSC [=m]
> >>>>>>
> >>>>>> WARNING: unmet direct dependencies detected for SND_ATMEL_SOC_SSC_PDC
> >>>>>>      Depends on [n]: SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_ATMEL_SOC [=m] && ATMEL_SSC [=m] && HAS_DMA [=n]
> >>>>>>      Selected by [m]:
> >>>>>>      - SND_AT91_SOC_SAM9G20_WM8731 [=m] && SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_ATMEL_SOC [=m] && (ARCH_AT91 || COMPILE_TEST [=y]) && ATMEL_SSC [=m] && SND_SOC_I2C_AND_SPI [=m]
> >>>>>>
> >>>>>> WARNING: unmet direct dependencies detected for SND_ATMEL_SOC_SSC
> >>>>>>      Depends on [n]: SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_ATMEL_SOC [=m] && HAS_DMA [=n]
> >>>>>>      Selected by [m]:
> >>>>>>      - SND_ATMEL_SOC_SSC_DMA [=m] && SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_ATMEL_SOC [=m] && ATMEL_SSC [=m]
> >>>>>>
> >>>>>> WARNING: unmet direct dependencies detected for SND_ATMEL_SOC_SSC_DMA
> >>>>>>      Depends on [n]: SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_ATMEL_SOC [=m] && ATMEL_SSC [=m] && HAS_DMA [=n]
> >>>>>>      Selected by [m]:
> >>>>>>      - SND_ATMEL_SOC_WM8904 [=m] && SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_ATMEL_SOC [=m] && (ARCH_AT91 || COMPILE_TEST [=y]) && ATMEL_SSC [=m] && I2C [=m]
> >>>>>>      - SND_AT91_SOC_SAM9X5_WM8731 [=m] && SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_ATMEL_SOC [=m] && (ARCH_AT91 || COMPILE_TEST [=y]) && ATMEL_SSC [=m] && SND_SOC_I2C_AND_SPI [=m]
> >>>>>>
> >>>>>> Fixes: 3951e4aae2ce ("ASoC: atmel-pcm: dma support based on pcm dmaengine")
> >>>>>> Fixes: 18291410557f ("ASoC: atmel: enable SOC_SSC_PDC and SOC_SSC_DMA in Kconfig")
> >>>>>> Fixes: 061981ff8cc8 ("ASoC: atmel: properly select dma driver state")
> >>>>>
> >>>>> I am not sure about these fixes tags. As Alexandre mentioned, it looks
> >>>>> like the reason for HAS_DMA in the first place was the COMPILE_TEST with
> >>>>> m32r arch. I dig a bit, and, if any, I think we should use:
> >>>>> Fixes: eb17726b00b3 ("m32r: add simple dma")
> >>>>> since this commit adds dummy DMA support for m32r and seems to fix the
> >>>>> HAS_DMA dependency.
> >>>>
> >>>> Ah, I forgot to update the Fixes: tag(s).
> >>>>
> >>>> I won't disagree with your Fixes: suggestion (good digging) but
> >>>> I would probably have used 8d7d11005e930:
> >>>>     ASoC: atmel: fix build failure
> >>>> which is the commit that added "depends on HAS_DMA".
> >>>
> >>> M32r was not the only platform NO_DMA, so I guess the build would
> >>> have failed for the others, too (e.g. Sun-3).
> >>>
> >>> So the real fix was probably commit f29ab49b5388b2f8 ("dma-mapping:
> >>> Convert NO_DMA get_dma_ops() into a real dummy"), or one of the
> >>> related commits adding dummies to subsystems.
> >>
> >> Does this mean that some other actions are needed here?
> >> E.g. revert + a different kind of fix?
> >
> > While we can now compile drivers using DMA features on NO_DMA
> > platforms, thanks to the dummies, it does mean many of these drivers
> > cannot work on such platforms.  So I think it makes sense to replace
> > "depends on HAS_DMA" by "depends on HAS_DMA || COMPILE_TEST" if DMA
> > is not optional to the driver.
>
> Hi Geert,
>
> Is this what you had in mind?  It seems to work with my (limited)
> testing.

Yes. And also for other symbols for drivers that now compile fine
if !HAS_DMA, thanks to the dummies.

> --- linux-next-20210907.orig/sound/soc/atmel/Kconfig
> +++ linux-next-20210907/sound/soc/atmel/Kconfig
> @@ -11,6 +11,7 @@ if SND_ATMEL_SOC
>
>   config SND_ATMEL_SOC_PDC
>         bool
> +       depends on HAS_DMA || COMPILE_TEST
>
>   config SND_ATMEL_SOC_DMA
>         bool

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
