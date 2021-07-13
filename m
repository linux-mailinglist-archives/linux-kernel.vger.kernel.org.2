Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC93A3C7811
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 22:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235459AbhGMUiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 16:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235322AbhGMUiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 16:38:20 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD41C0613DD;
        Tue, 13 Jul 2021 13:35:29 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id ec55so10087165edb.1;
        Tue, 13 Jul 2021 13:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lz1iNRVmJl/8c02nO6mcAo+x0LUik5FJFjS42Nicby8=;
        b=I93Jw38f4suLZLxrcS11ROvBezOGU4JjFfcwHEGortMfxkTfN8UAqSPN2szzMQAE1d
         er50D8stbzEiVr8XMg/kJF9abJbF/jEILEq+03llk6uLCKV4l6mvLKVURuLRWX5jDO1N
         6lZUTJqBPyMJnqbGgBCap5EmeHutNScznEb6M3SAf+4+1tCA2UZ+C1I0JvqBECH2O2uo
         Habw2ErqzBpxlKBIy5n7bDd40kv1SiqUqkdD5kFy2Ri+Ds5oprwISZsx66w577mnLpwx
         f7wx0iZY+ozU/lpPvIjZdZkdG8/gJ2Z613VMV3zROZv0ZkbAXj2hjH/7wovNCCu/34CS
         zeFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lz1iNRVmJl/8c02nO6mcAo+x0LUik5FJFjS42Nicby8=;
        b=UJQ9KD9DmIZUtSURh1qVG+qIwgBGHvQKhfhyej2E4Gy78gKc6wdPAc/XcginK+zOl1
         bIZgzMT3KB1R0oNQN73dER/obU7FwLog3z19PhSYfBiPNf0QAXnkB4ypE0cx+3JjUSF4
         z2PoeCJZyQOdeKQqg38XxsiqDHPy4FplnBrkC+gLJsKHs6ygmV6AhqM0izx/Cazq6reh
         6hEOZkaw8F7HLNV3EpIGfBjuT5zXg7gVHuRvxKd759aKlbCCctsuh3mBF37xqWbp0ZWX
         FEOjHZJCIXRI6H1D7F4U1TqQaC5dYz9u6jXfM9bHVILfid+jr5vJNf+Dpe/4es/pi4yV
         /IWg==
X-Gm-Message-State: AOAM5305IB9FPIO3KbbP16SWYs8bDCHqkkGO/NVHgAqrtjT1vdt7K0Yi
        tAiXaJ5g5a+cAOHqnCVcdeRHsY+3pKYVadsfpSo=
X-Google-Smtp-Source: ABdhPJxtOwqdJeTKPSUanACIrHdPw1eVvCe+a/6kJEv5H4LVBcI1ek6HLhA0gFT9a/FkLDXR9ho5PMGWfIoQ2V5HXnU=
X-Received: by 2002:a05:6402:190c:: with SMTP id e12mr8137065edz.176.1626208528146;
 Tue, 13 Jul 2021 13:35:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210713055227.1142-1-linux.amoon@gmail.com> <20210713055227.1142-2-linux.amoon@gmail.com>
 <CAFBinCD3ahpNQhP_jWZ3-4nXx8OqZOAANCpTN3BrsULRbYZHVw@mail.gmail.com> <CANAwSgTh02qg=cMT8tpHcEfAs5yW2vHQ7tPOkvuKXos_fOmh8A@mail.gmail.com>
In-Reply-To: <CANAwSgTh02qg=cMT8tpHcEfAs5yW2vHQ7tPOkvuKXos_fOmh8A@mail.gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 13 Jul 2021 22:35:17 +0200
Message-ID: <CAFBinCC-kD-MW+bwqCZH5AjYDhxWa_pN2WEnHuiZpx=RhUdROQ@mail.gmail.com>
Subject: Re: [PATCHv1 1/3] ARM: dts: meson8b: odroidc1: Add usb phy power node
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     linux-phy@lists.infradead.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Matt Corallo <oc2udbzfd@mattcorallo.com>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Emiliano Ingrassia <ingrassia@epigenesys.com>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anand,

On Tue, Jul 13, 2021 at 8:45 PM Anand Moon <linux.amoon@gmail.com> wrote:
>
> Hi Martin,
>
> Thanks for reviewing the changes,
>
> On Tue, 13 Jul 2021 at 20:35, Martin Blumenstingl
> <martin.blumenstingl@googlemail.com> wrote:
> >
> > Hi Anand,
> >
> > On Tue, Jul 13, 2021 at 7:53 AM Anand Moon <linux.amoon@gmail.com> wrote:
> > >
> > > Add missing usb phy power node for phy mode fix below warning.
> > >
> > > [    1.253149] phy phy-c1108820.phy.0: Looking up phy-supply from device tree
> > > [    1.253166] phy phy-c1108820.phy.0: Looking up phy-supply property
> > >                 in node /soc/cbus@c1100000/phy@8820 failed
> > I did some testing on my own Odroid-C1+ and this patch is not doing
> > anything for me.
> > more information below.
> Some device node for USB will have
The mistake I made before is considering USB VBUS as PHY power supply.
I believe the USB PHY is actually powered by the AVDD18_USB_ADC and
USB33_VDDIOH signals. See the S905 datasheet [0], page 25
These are 1.8V and 3.3V signals while you are adding a 5V regulator.

[...]
> > > +               /*
> > > +                * signal name from schematics: USB_POWER
> > > +                */
> > Just a few lines below you're saying that the name from the schematics is PWREN
> > If this patch is getting another round then please clarify the actual
> > signal name, or name both signals if the schematics is actually using
> > both names.
> >
> As per the schematics.
> PWREN ---> GPIOAO.BIT5      gpio pin control
> USB_POWER ---> P5V0          power source regulator.
ah, thanks for clarifying this
my suggestion is to put that exact paragraph into the comment to avoid confusion

[...]
> > Can you please give this a try on your Odroid-C1 as well?
> > The conclusion from my own testing is that GPIOAO_5 doesn't seem to be
> > related to USB1 (host-only) because if it was then inverting the
> > polarity (from active high to active low) should result in a change.
> >
>
> Ok I have modified as per above but not changes in gpio polarity
> from active high to active low. see below.
>
> # Odroid C1
> [alarm@archl-c1e ~]$ sudo cat /sys/kernel/debug/gpio | grep USB
>  gpio-1953 (USB_HUB_RST_N       |usb-hub-reset       ) out hi
>  gpio-1954 (USB_OTG_PWREN       |regulator-usbp_pwr_e) out hi
>
> # Odroid C2
> [alarm@archl-c2lm ~]$  sudo cat /sys/kernel/debug/gpio | grep usb
>  gpio-501 (USB HUB nRESET      |usb-hub-reset       ) out hi
>  gpio-502 (USB OTG Power En    |regulator-usb-pwrs  ) out hi
that's strange, my result is different

  gpio = <&gpio_ao GPIOAO_5 GPIO_ACTIVE_HIGH>;
  enable-active-high;
gives me:
  # grep USB_OTG_PWREN /sys/kernel/debug/gpio
  gpio-418 (USB_OTG_PWREN       |regulator-usb-pwr-en) out hi

  gpio = <&gpio_ao GPIOAO_5 GPIO_ACTIVE_LOW>;
gives me:
  # grep USB_OTG_PWREN /sys/kernel/debug/gpio
  gpio-418 (USB_OTG_PWREN       |regulator-usb-pwr-en) out lo ACTIVE LOW

Did you remove the "enable-active-high;" in your "active low" test?
GPIO polarity for regulators is managed with that flag, not just with
GPIO_ACTIVE_{HIGH,LOW}

[...]
> > >  &usb1_phy {
> > >         status = "okay";
> > > +       phy-supply = <&usb_pwr_en>;
> > From the schematics it seems that this is not the PHY supply (which I
> > admittedly have used incorrectly for VBUS before).
> > In the schematics that I have (odroid-c1+_rev0.4_20150615.pdf) it
> > seems to be enabling VBUS.
> > So in that case a vbus-supply property should be used inside &usb1 instead.
> >
> As per the debug log I have added this since core phy looking for this property
Let's discuss the results with different polarities first, then we can
also discuss the rest.


Best regards,
Martin
