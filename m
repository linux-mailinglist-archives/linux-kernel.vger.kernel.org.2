Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37CA342BAAA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 10:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234103AbhJMImx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 04:42:53 -0400
Received: from mail-ua1-f49.google.com ([209.85.222.49]:40530 "EHLO
        mail-ua1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbhJMImw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 04:42:52 -0400
Received: by mail-ua1-f49.google.com with SMTP id e2so2951392uax.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 01:40:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o21Xh9J32kqeXX2sLP/uoO24jfsRO3XxpHv3HTju++o=;
        b=NOFYlFfKub/V8iRn1VApQrzyD8sE9bF7ygRwEGtzjiYczDdox4KZ8z3ZZXUecAyU0C
         gesQlxUINhxU0P1P4Qmw+jpBjBEwQ5xCesVgysZJ/PKt0VzVscHhcYWa6LuWZID/EmV8
         LVSlNDBkV8DRDBl8B/ar95mI6mZ4UtzzWz/GAS0mfXcP8sg7OuUFAdlTcChO+aiqH6hA
         zj5iStrtNKrZZZoAoYvdnBUD0CN/zyszSoisgBCw1QnxNrRXzLJekXQK9T3C2A8sGPnl
         GICG0mzVSkzpR3kY+VduB9XbM1Iw8qw7jxiAPDzP7tARsrQPxJoUU/JtV0K4J582Yxz2
         Zm6Q==
X-Gm-Message-State: AOAM532TXIfRfP0Zzcb4MNbLWsKfKaYASETk7VWpB4qaMj3McvF67Izp
        kNyBCbrRhV48gwtyNsEHO2ir4i47sEzbNatW4RU=
X-Google-Smtp-Source: ABdhPJxdOrt/NeqKBbobPgR/QYlFFRT0/HBYQPl2x39gYkEt6ihDnKgmOShnK7VIgbiDKv3BhBEH9IjpXBj5pvbVWW0=
X-Received: by 2002:ab0:58c1:: with SMTP id r1mr27617670uac.89.1634114449054;
 Wed, 13 Oct 2021 01:40:49 -0700 (PDT)
MIME-Version: 1.0
References: <20211003030357.32456-1-rdunlap@infradead.org> <96c810cb-f7e3-d9ff-9713-7ec007ebb599@microchip.com>
In-Reply-To: <96c810cb-f7e3-d9ff-9713-7ec007ebb599@microchip.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 13 Oct 2021 10:40:37 +0200
Message-ID: <CAMuHMdUyo-sFzo3CA9WwycZFp=pVYLJeJfEWRT48EVhSZGL3rw@mail.gmail.com>
Subject: Re: [PATCH] ASoC: atmel: add COMPILE_TEST for SND_ATMEL_SOC_PDC
To:     Codrin Ciubotariu <Codrin.Ciubotariu@microchip.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Codrin,

On Wed, Oct 13, 2021 at 10:15 AM <Codrin.Ciubotariu@microchip.com> wrote:
> On 03.10.2021 06:03, Randy Dunlap wrote:
> > Geert pointed out that since sound/soc has the soc_dummy_driver for
> > NO_DMA platforms, it is possible (desirable) to have drivers that
> > depend on HAS_DMA to alternately depend on COMPILE_TEST.
> >
> > This means that SND_ATMEL_SOC_PDC can depend on HAS_DMA || COMPIE_TEST.
> >
> > Fixes: 6c5c659dfe3f ("ASoC: atmel: ATMEL drivers don't need HAS_DMA")
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Cc: Liam Girdwood <lgirdwood@gmail.com>
> > Cc: Mark Brown <broonie@kernel.org>
> > Cc: alsa-devel@alsa-project.org
> > Cc: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> > ---
> >   sound/soc/atmel/Kconfig |    1 +
> >   1 file changed, 1 insertion(+)
> >
> > --- linux-next-20211001.orig/sound/soc/atmel/Kconfig
> > +++ linux-next-20211001/sound/soc/atmel/Kconfig
> > @@ -11,6 +11,7 @@ if SND_ATMEL_SOC
> >
> >   config SND_ATMEL_SOC_PDC
> >          bool
> > +       depends on HAS_DMA || COMPILE_TEST
>
> SND_ATMEL_SOC_PDC compiles fine without HAS_DMA, so I don't understand
> the need for this...

Does it work without DMA support?
If not, it doesn't make much sense to offer this option to the user, unless
the user is compile-testing.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
