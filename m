Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9CAE4016E0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 09:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240005AbhIFHQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 03:16:08 -0400
Received: from mail-vs1-f41.google.com ([209.85.217.41]:38599 "EHLO
        mail-vs1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233040AbhIFHQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 03:16:07 -0400
Received: by mail-vs1-f41.google.com with SMTP id a25so4778970vso.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 00:15:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/+lyTeHgpCDp3c3yF7GwweZe7fgOgOOdi97EH6LIddw=;
        b=TiKHjKnIxNgep226+7uYyLr3q0DW9hWIl+cI8n1b6Dnt9bRziZmx59QwOIlMZycKS2
         m6fH2o8xXZtYce0cnG4HicH4oCR8yIyzf7uR652UW2JsxXWn+qy3N2oAbQ8x8dTDgxVP
         uy/Dgn49R/7Tw6Vg+mOjetVE5UTyTzlspDjS951Lkfz8sBw5pZZFYW3XvyENS7MmFEV7
         jg67dJmwwuTpICdnohk7JBWs0b97M1HOXwjHz4QGfEMjW0DkAhu+jO4z/JqxFXvrdTCH
         AKzAWgVlthHnGVl3ilHOUdW1c++bmfylJXPSFkzT3hIJGH55zraICz2dVjZdobSbOMSf
         y8Qg==
X-Gm-Message-State: AOAM530X+vWEON902KAvbcVL6jizuN0+1dNekVfp3n4VgEniEh2C2GkY
        9ebYkoM5zFeaQDt6WPtJy3RLuZGNLwQeD+0QOcQ=
X-Google-Smtp-Source: ABdhPJwDpp3xUZ2EsTWxY2yM2j8OGQRBQBLh7qYKrpDBshgnN16v17gxVhZqfEOQtWVH48ARuasK7mk5BVbe27a+EU0=
X-Received: by 2002:a67:efd6:: with SMTP id s22mr5165647vsp.50.1630912502493;
 Mon, 06 Sep 2021 00:15:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210707214752.3831-1-rdunlap@infradead.org> <fca8f952-2be0-5c57-d60d-5c4f025abc4d@microchip.com>
 <49495ab9-5039-f332-2895-1a79c034f58d@infradead.org> <CAMuHMdU=ODKZJ0OOsuCeJnTWuM3fP5DE7coSzB=fvAbxPQWDcg@mail.gmail.com>
 <a94c9788-0415-ffe3-9dd4-e6ed8d7ee96a@infradead.org>
In-Reply-To: <a94c9788-0415-ffe3-9dd4-e6ed8d7ee96a@infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 6 Sep 2021 09:14:51 +0200
Message-ID: <CAMuHMdWUcaC-xiW0UiVdTpx-R=e_i8eHSNc8JF_wqbcO6FynWw@mail.gmail.com>
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

On Fri, Sep 3, 2021 at 9:53 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> On 9/2/21 9:44 AM, Geert Uytterhoeven wrote:
> > On Thu, Jul 8, 2021 at 6:51 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> >> On 7/8/21 1:19 AM, Codrin.Ciubotariu@microchip.com wrote:
> >>> On 08.07.2021 00:47, Randy Dunlap wrote:
> >>>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >>>>
> >>>> On a config (such as arch/sh/) which does not set HAS_DMA when MMU
> >>>> is not set, several ATMEL ASoC drivers select symbols that cause
> >>>> kconfig warnings. There is one "depends on HAS_DMA" which is no longer
> >>>> needed. Dropping it eliminates the kconfig warnings and still builds
> >>>> with no problems reported.
> >>>>
> >>>> Fix the following kconfig warnings:
> >>>>
> >>>> WARNING: unmet direct dependencies detected for SND_ATMEL_SOC_PDC
> >>>>     Depends on [n]: SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_ATMEL_SOC [=m] && HAS_DMA [=n]
> >>>>     Selected by [m]:
> >>>>     - SND_ATMEL_SOC_SSC [=m] && SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_ATMEL_SOC [=m]
> >>>>     - SND_ATMEL_SOC_SSC_PDC [=m] && SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_ATMEL_SOC [=m] && ATMEL_SSC [=m]
> >>>>
> >>>> WARNING: unmet direct dependencies detected for SND_ATMEL_SOC_SSC_PDC
> >>>>     Depends on [n]: SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_ATMEL_SOC [=m] && ATMEL_SSC [=m] && HAS_DMA [=n]
> >>>>     Selected by [m]:
> >>>>     - SND_AT91_SOC_SAM9G20_WM8731 [=m] && SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_ATMEL_SOC [=m] && (ARCH_AT91 || COMPILE_TEST [=y]) && ATMEL_SSC [=m] && SND_SOC_I2C_AND_SPI [=m]
> >>>>
> >>>> WARNING: unmet direct dependencies detected for SND_ATMEL_SOC_SSC
> >>>>     Depends on [n]: SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_ATMEL_SOC [=m] && HAS_DMA [=n]
> >>>>     Selected by [m]:
> >>>>     - SND_ATMEL_SOC_SSC_DMA [=m] && SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_ATMEL_SOC [=m] && ATMEL_SSC [=m]
> >>>>
> >>>> WARNING: unmet direct dependencies detected for SND_ATMEL_SOC_SSC_DMA
> >>>>     Depends on [n]: SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_ATMEL_SOC [=m] && ATMEL_SSC [=m] && HAS_DMA [=n]
> >>>>     Selected by [m]:
> >>>>     - SND_ATMEL_SOC_WM8904 [=m] && SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_ATMEL_SOC [=m] && (ARCH_AT91 || COMPILE_TEST [=y]) && ATMEL_SSC [=m] && I2C [=m]
> >>>>     - SND_AT91_SOC_SAM9X5_WM8731 [=m] && SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_ATMEL_SOC [=m] && (ARCH_AT91 || COMPILE_TEST [=y]) && ATMEL_SSC [=m] && SND_SOC_I2C_AND_SPI [=m]
> >>>>
> >>>> Fixes: 3951e4aae2ce ("ASoC: atmel-pcm: dma support based on pcm dmaengine")
> >>>> Fixes: 18291410557f ("ASoC: atmel: enable SOC_SSC_PDC and SOC_SSC_DMA in Kconfig")
> >>>> Fixes: 061981ff8cc8 ("ASoC: atmel: properly select dma driver state")
> >>>
> >>> I am not sure about these fixes tags. As Alexandre mentioned, it looks
> >>> like the reason for HAS_DMA in the first place was the COMPILE_TEST with
> >>> m32r arch. I dig a bit, and, if any, I think we should use:
> >>> Fixes: eb17726b00b3 ("m32r: add simple dma")
> >>> since this commit adds dummy DMA support for m32r and seems to fix the
> >>> HAS_DMA dependency.
> >>
> >> Ah, I forgot to update the Fixes: tag(s).
> >>
> >> I won't disagree with your Fixes: suggestion (good digging) but
> >> I would probably have used 8d7d11005e930:
> >>    ASoC: atmel: fix build failure
> >> which is the commit that added "depends on HAS_DMA".
> >
> > M32r was not the only platform NO_DMA, so I guess the build would
> > have failed for the others, too (e.g. Sun-3).
> >
> > So the real fix was probably commit f29ab49b5388b2f8 ("dma-mapping:
> > Convert NO_DMA get_dma_ops() into a real dummy"), or one of the
> > related commits adding dummies to subsystems.
>
> Hi Geert,
> Does this mean that some other actions are needed here?
> E.g. revert + a different kind of fix?

While we can now compile drivers using DMA features on NO_DMA
platforms, thanks to the dummies, it does mean many of these drivers
cannot work on such platforms.  So I think it makes sense to replace
"depends on HAS_DMA" by "depends on HAS_DMA || COMPILE_TEST" if DMA
is not optional to the driver.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
