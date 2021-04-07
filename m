Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17A7D356822
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 11:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350171AbhDGJez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 05:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233469AbhDGJex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 05:34:53 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A6FC061756
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 02:34:42 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id r20so19879231ljk.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 02:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h+539txFbW0Pn09niSuR12AUgDFwJO18dDRQTGIfQRg=;
        b=X4suFUuVHy8cNq/LvdvedSTeTqjFK109WWaV0X0lvUQJFv0IHEOfovrD+0/lwI4dDH
         MWg+vDjNCB4ZWF1YhE4T3MflWvpj9GKGwiq6pE6uhQbSUYCtLnplhkngpi1EJDnRP+iw
         aQmstdfSyHM47lCvTiTQQ8j/GQ3UjuP+7hX0OaGL244qyVfwN6QTWM0dZNqP9Yw9FIAX
         JTy2U/UHc90AFeHB6vya2gF01eKxW7DzlNIWKjeHQuvUg0ZJKb4S47Pw5UjxZ6ji1vW2
         m1eIvL/5jyhkK3wTdDU/ld9kkgzekxo9QRBTgiqujk69YbJoZunyI/7mkaGBJKrrbJ/w
         jZ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h+539txFbW0Pn09niSuR12AUgDFwJO18dDRQTGIfQRg=;
        b=J+be8/OEwVU5/8LIuGaGVNHb831k/ASRC738jB+SG6ceHdUbZtmriQnCQ5foWaR8v6
         VfaaTyECWGuSogz5ywC8iML3WptexzvHoUqOMSODaB2O0i+jXzRSDS5BW58uYqI0Lyw/
         061FeoGrVlAYgYYFHVfjKLgB8MeYgW+X6e8UYNMvSsYKLiy2ThAYYE4/yVutvaUudySn
         MmTaNQf1TDkpyUQLIrg8Cza3LisWC06jvbKZRNhs8uck0a/u+8GgcQ+AP12jDqZWb+HG
         xiqJInHIiWAuHwiFhTwyuhgUsRtYLmTrNulJnDqg1KbYToODpo323G0JM6W25JxoCkXy
         PGJw==
X-Gm-Message-State: AOAM531oUeSwzmWug67f5dXrlBGTbbv4o0YVhkqzR9KyYqjDmo1iTG+y
        e4KdI3FWDS236KdH+PULHWU+9FbaaXXOFPkeie5SJw==
X-Google-Smtp-Source: ABdhPJxlnkdqMK/eisSOVRUuNuANcJ/SnVakweLcLSGmNKPPcUCvGmUkpNoJexfFYnBUkByls1ndc7mlaBt38YGoUY4=
X-Received: by 2002:a2e:1649:: with SMTP id 9mr1695081ljw.74.1617788080944;
 Wed, 07 Apr 2021 02:34:40 -0700 (PDT)
MIME-Version: 1.0
References: <YGtZeofmBv7hXK+a@Red> <CACRpkdZ_barDrLvD2UBKo+GA-F+g72uMQx8CfRK2YLRodpeyUA@mail.gmail.com>
 <YGxOf8pKN8Ip/kCl@Red>
In-Reply-To: <YGxOf8pKN8Ip/kCl@Red>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 7 Apr 2021 11:34:29 +0200
Message-ID: <CACRpkdYRUXJY_tXamS0vc+RNPDxR2oxdRLbBUk0fmQLp+eYAOA@mail.gmail.com>
Subject: Re: gemini: sl3516: Mainlining of NS 2502
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 6, 2021 at 2:05 PM Corentin Labbe <clabbe.montjoie@gmail.com> wrote:

> You could find photos at http://kernel.montjoie.ovh/gemini/
> There are also photos of another SL3516 SoC based device (a SSI 1328 NAS), but I fail to setup a serial on it, so I keep it for later.

Yeah it is clearly an RTL82111 at least, so this should be possible
to get going.

> > >                 syscon: syscon@40000000 {
> > >                         pinctrl {
> > >                                 /*
> > >                                  * gpio0agrp cover line 0-4
> > >                                  * gpio0bgrp cover line 5
> > >                                  */
> > >                                 gpio0_default_pins: pinctrl-gpio0 {
> > >                                         mux {
> > >                                                 function = "gpio0";
> > >                                                 groups = "gpio0agrp",
> > >                                                 "gpio0bgrp";
> > >                                         };
> > >                                 };
> >
> > Change groups to
> >
> > groups = "gpio0agrp", "gpio0bgrp", "gpio0hgrp";
> >
> > So you mux in group h which is where the GPIO 21, 22 go out
> > to the MDIO on 3516 IIUC. The right mux out is pretty important,
> > if you have vendor source code, please share so I can check how
> > they set it up.
>
> No change, probably due to all pinctrl-gemini 40000000.syscon:pinctrl: could not map pin config for "R8 GMAC0 RXDV"
> Please see http://kernel.montjoie.ovh/gemini/bootlog6.txt , I have added some pr_info in gmac.
> I have put in the directory, the final dtb which I use.

All this is wrong too:
pinctrl-gemini 40000000.syscon:pinctrl: could not map pin config for
"R8 GMAC0 RXDV"
pinctrl-gemini 40000000.syscon:pinctrl: could not map pin config for
"U11 GMAC1 RXDV"
(...)

This is because we copied the DT config from a 3512 device rather than
3516 ... totally different pins. :/ R8 is the pin on 3512 so they all need
to change to e.g. from "R8 GMAC0 RXDV" to "V8 GMAC0 RXDV".

We need to come up with something unique for this device.

The code for mux is in drivers/pinctrl/pinctrl-gemini.c but can be a bit
terse. This file contains both 3512 and 3516 drivers so check closely
that you are looking at the right variant. The right pin names are in
the array gemini_3516_pins[].

The tricky thing is that I have never seen a SL3516 connected directly to
a simple phy like 82111. They all connect to some kind of switch chip...
So we need to figure out the muxing and pin config for this set-up.

This is what the DIR-685 is using for GMAC0:

                                pinctrl-gmii {
                                        mux {
                                                function = "gmii";
                                                groups = "gmii_gmac0_grp";
                                        };
                                        conf0 {
                                                pins = "V8 GMAC0
RXDV", "T10 GMAC1 RXDV",
                                                     "Y7 GMAC0 RXC",
"Y11 GMAC1 RXC",
                                                     "T8 GMAC0 TXEN",
"W11 GMAC1 TXEN",
                                                     "U8 GMAC0 TXC",
"V11 GMAC1 TXC",
                                                     "W8 GMAC0 RXD0",
"V9 GMAC0 RXD1",
                                                     "Y8 GMAC0 RXD2",
"U9 GMAC0 RXD3",
                                                     "T7 GMAC0 TXD0",
"U6 GMAC0 TXD1",
                                                     "V7 GMAC0 TXD2",
"U7 GMAC0 TXD3",
                                                     "Y12 GMAC1 RXD0",
"V12 GMAC1 RXD1",
                                                     "T11 GMAC1 RXD2",
"W12 GMAC1 RXD3",
                                                     "U10 GMAC1 TXD0",
"Y10 GMAC1 TXD1",
                                                     "W10 GMAC1 TXD2",
"T9 GMAC1 TXD3";
                                                skew-delay = <7>;
                                        };
                                        /* Set up drive strength on
GMAC0 to 16 mA */
                                        conf1 {
                                                groups = "gmii_gmac0_grp";
                                                drive-strength = <16>;
                                        };
                                };

But maybe your device is using GMAC1? I would try GMAC0 first anyway.

> The vendor source could be found at https://www.edimax.com/edimax/mw/cufiles/files/download/OpenSourceCode/transfer/Wireless/NAS/NAS-GPL-source.zip

Normally the kernel should be setting up device resources and
config under arch/arm/mach-sl2312 (never mind the ASIC number...)
but Storlink have hacked the kernel all over the place so the
relevant parts can be hard to find.

The interesting stuff relating to pin control appears when
you grep for SL2312_GLOBAL_BASE.

When the kernel boots some essentials are set up
already in init/main.c (hacky!). But it seems to be the same
as in all Storlink devices.

This part in drivers/net/sl2312_emac.c looks quite interesting:

#ifdef CONFIG_SL3516_ASIC
{
    unsigned int    val;

    /* set GMAC global register */
    val = readl(GMAC_GLOBAL_BASE_ADDR+0x10);
    val = val | 0x005a0000;
    writel(val,GMAC_GLOBAL_BASE_ADDR+0x10);
    writel(0x07f007f0,GMAC_GLOBAL_BASE_ADDR+0x1c);
    writel(0x77770000,GMAC_GLOBAL_BASE_ADDR+0x20);
    writel(0x77770000,GMAC_GLOBAL_BASE_ADDR+0x24);
        val = readl(GMAC_GLOBAL_BASE_ADDR+0x04);
        if((val&(1<<20))==0){           // GMAC1 enable
                val = readl(GMAC_GLOBAL_BASE_ADDR+0x30);
                val = (val & 0xe7ffffff) | 0x08000000;
                writel(val,GMAC_GLOBAL_BASE_ADDR+0x30);
        }

}
#endif

So we need to verify that this corresponds to what you set
up in your device tree (I do it by reading the data sheets and
coparing to the pinctrl-gemini.c code and defines...)

Then we have this:

/* define GPIO pin for MDC/MDIO */

// for gemini ASIC
#ifdef CONFIG_SL3516_ASIC
#define H_MDC_PIN           22
#define H_MDIO_PIN          21
#define G_MDC_PIN           22
#define G_MDIO_PIN          21
#else
(...)

This seems to correspond to your device tree so OK...

But it's annoying that we can't communicate with it.
This is usually because some other device is
"shading" the GPIO lines, i.e. hiding it.

drivers/net/sl_switch.c is not used on your platform (Vitesse switch)
and is a leftover from the Storlink reference design.

> > > BUT neither ethernet nor USB works.
> >
> > For USB try this patch:
> > https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git/commit/?h=gemini-usb&id=cbaf6cdf770b90de5f10bfa5112c679f1dffe948
> >
>
> One of the USB port is now working.

Hey nice! :D

The USB patch is not very widely tested, so it may need some shaping
up.

> Note that I have also started to work on the gemini crypto driver.

I saw some nice debug prints! :D

I always wanted to get that to work, nice that you're working on
it!

Yours,
Linus Walleij
