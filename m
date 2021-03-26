Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D37D34AE52
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 19:14:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbhCZSNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 14:13:47 -0400
Received: from mail-vs1-f43.google.com ([209.85.217.43]:40596 "EHLO
        mail-vs1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbhCZSNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 14:13:39 -0400
Received: by mail-vs1-f43.google.com with SMTP id l4so3137874vsc.7;
        Fri, 26 Mar 2021 11:13:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FDpqcQgTexarvW+AT636FmF/lPMTzTe04W+T1jW+7WY=;
        b=LA+y++mQJC182oHN/6nOA2hX6LvJr81afBKOSnUWuAT+VcePtCy91SYEFR1Y1ZatE6
         yhnubzbkPu4BjmYXPeTzS25sDazqgWB62y9i7w+8OtB2hY89tl+Ct3dv2fOIX1mIYt+v
         6uouHXFSSQrWuE2d1B3u4GAfY21xInbsJlKjAMm2mTFZlO4c2Aiq31wBhGAP4Emtbp5F
         IXtGvLNmT/O/LX61ovveusb6kBfuLEmEEEfCpzbxPqsCZRMmgB26/BWikj0+zsSfwbDf
         54axCkF7j4E6pCZ3g2tbXr4gJfsglmxDzkVWno8NCbTueS1k9dA0be+lDbZfZmWhLHvd
         PrSQ==
X-Gm-Message-State: AOAM532E0ADpLWXbYiH7aQiseneQEVgDWCmYedndAiPAWC2EGYTtp+yK
        k/pTNlw7XTmpc3XW1BJh8a6miEExt9cShnQHC6g=
X-Google-Smtp-Source: ABdhPJxOzCTasDp54zylzJyaz+KFDObMiEEDXS/K/2M7pd/hbZzjLAFykziFdC6wbj75KFCkmxdJUdWyQChRhj6q8Hw=
X-Received: by 2002:a67:f7c6:: with SMTP id a6mr9632169vsp.42.1616782418388;
 Fri, 26 Mar 2021 11:13:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210325185749.27984-1-nsaenz@kernel.org> <161678217156.3012082.17482478610662557764@swboyd.mtv.corp.google.com>
In-Reply-To: <161678217156.3012082.17482478610662557764@swboyd.mtv.corp.google.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 26 Mar 2021 19:13:26 +0100
Message-ID: <CAMuHMdXLB=g0vCaNVSsO+6qC6UPpbrordsjx+=ZLEAV2MAaE-Q@mail.gmail.com>
Subject: Re: [PATCH] clk: bcm: rpi: Don't register as OF provider if !dev->np
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Maxime Ripard <maxime@cerno.tech>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2021 at 7:09 PM Stephen Boyd <sboyd@kernel.org> wrote:
> Quoting Nicolas Saenz Julienne (2021-03-25 11:57:48)
> > There are two ways clk-raspberrypi might be registered: through
> > device-tree or through an explicit platform device registration. The
> > latter happens after firmware/raspberrypi's probe, and it's limited to
> > RPi3s, which solely use the ARM clock to scale CPU's frequency. That
> > clock is matched with cpu0's device thanks to the ARM clock being
> > registered as a clkdev.
> >
> > In that scenario, don't register the device as an OF clock provider, as
> > it makes no sense and will cause trouble.
>
> What sort of trouble?

A crash
https://lore.kernel.org/linux-acpi/d24bebc5-0f78-021f-293f-e58defa32531@samsung.com/

> > Fixes: d4b4f1b6b97e ("clk: bcm: rpi: Add DT provider for the clocks")
> > Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Signed-off-by: Nicolas Saenz Julienne <nsaenz@kernel.org>
> > ---
> >  drivers/clk/bcm/clk-raspberrypi.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-raspberrypi.c
> > index f89b9cfc4309..27e85687326f 100644
> > --- a/drivers/clk/bcm/clk-raspberrypi.c
> > +++ b/drivers/clk/bcm/clk-raspberrypi.c
> > @@ -337,10 +337,12 @@ static int raspberrypi_clk_probe(struct platform_device *pdev)
> >         if (ret)
> >                 return ret;
> >
> > -       ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
> > -                                         clk_data);
> > -       if (ret)
> > -               return ret;
> > +       if (dev->of_node) {
>
> Can you add a comment to the code indicating the problem this is fixing?
> I fear that we'll look back on this later and simply remove this if
> condition because it's "redundant". Better to have some code comment so
> we don't have to look up git history to figure out that we only call
> this when the of node is populated. I'm not sure I understand what goes
> wrong though. Won't the absence of dev->of_node mean the provider
> doesn't do anything?


Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
