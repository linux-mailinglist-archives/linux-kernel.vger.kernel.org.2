Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 736383C89BC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 19:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239743AbhGNR2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 13:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239684AbhGNR2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 13:28:22 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20EE4C06175F;
        Wed, 14 Jul 2021 10:25:29 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id dj21so4276199edb.0;
        Wed, 14 Jul 2021 10:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HDdCuzsEIRQEbRqLmbLMr2Fppo157cgcX7veAgVnwEU=;
        b=TzmPBxh3FWomK3cu+C3DIxWGyEoanH1pzsFzSntP9kxCNDpVNaQUiFLNee1Box43iM
         ZDUfQ4JNpb+CHvvX2upwIg4eje5SwmM2gXT/44LFl30KM7u6isNs5LMqO9VIke3uOb0g
         cwajO1CNW13jcCD5XQBTIk6dIu9K3zcYHBf+/qnSmWxUfk+IbQaKi6HSjS35dIWesMap
         TcSWXjoLOcwXeIpqQOkzkGnQEzZw35lbiuZLr3OB7Wu7941jqf2+RLiRKkrKFSp+i3Kf
         PHWXqWEFoF5Cn8+OiOVwy7M+BPZs33r5xpHhX5RXa9rdaqSZGO3gfBuw3cqEDQYy2BTU
         hCOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HDdCuzsEIRQEbRqLmbLMr2Fppo157cgcX7veAgVnwEU=;
        b=qm3x/3oG4/3Qg4iBV85Zp4MG0kX8vvYORndxbcPh4Ji2BGasonMSRkii3ThmHH12CA
         DP415q443YIaAaBpjbtNvKoyuGWCCk59TmTVeWtl3ac2grl42L3FDBWKfcrDcX3INkZf
         g2KKsaIWNbO+JdQZF3ESv5abI3egCxwpJXCG09WoJ2WlkwJeCwq3WtkvZ1YAH32S0v1b
         9iX9jChlirRkICMW+pYWvfyrbzIgfa7xDIra/AYK4CYEQVsdrlLcC++zzxTFsOvn8EgH
         iMsQpIF+kz9YACqnXnjXm+0DsFNKTjFdjCN+lIRtJiszi9fa6FUhdPnAST/GQGLuNf8A
         BONg==
X-Gm-Message-State: AOAM532rnqTEPsT085nhmOYPh3stnN9JaMMHwsdDBxmevtS6/y+kS4QF
        YQ5HHLYDhewQZ+bvvro0rvl+bFgqNE2PEjukdV0=
X-Google-Smtp-Source: ABdhPJzcmA22NEs/yt9L3GEI+PYHcmiGVgaPU9Jc2/SrrPTJMDEJEyCfK4ZSeMMHL6UYvAFdyJyUbjgshPbU8UU7qRU=
X-Received: by 2002:aa7:d344:: with SMTP id m4mr15199160edr.184.1626283527708;
 Wed, 14 Jul 2021 10:25:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210713055227.1142-1-linux.amoon@gmail.com> <20210713055227.1142-2-linux.amoon@gmail.com>
 <CAFBinCD3ahpNQhP_jWZ3-4nXx8OqZOAANCpTN3BrsULRbYZHVw@mail.gmail.com>
 <CANAwSgTh02qg=cMT8tpHcEfAs5yW2vHQ7tPOkvuKXos_fOmh8A@mail.gmail.com>
 <CAFBinCC-kD-MW+bwqCZH5AjYDhxWa_pN2WEnHuiZpx=RhUdROQ@mail.gmail.com> <CANAwSgTf4sjoufrZuK-EjE=+yA8zSoVbqhEyNhJJFBLUCOVZmQ@mail.gmail.com>
In-Reply-To: <CANAwSgTf4sjoufrZuK-EjE=+yA8zSoVbqhEyNhJJFBLUCOVZmQ@mail.gmail.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Wed, 14 Jul 2021 22:55:15 +0530
Message-ID: <CANAwSgR5nNN3D+NZjqNNjyp=rVYE=RG2icnJAc=5F23xSh9Bvg@mail.gmail.com>
Subject: Re: [PATCHv1 1/3] ARM: dts: meson8b: odroidc1: Add usb phy power node
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
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

Hi Martin.

On Wed, 14 Jul 2021 at 17:29, Anand Moon <linux.amoon@gmail.com> wrote:
>
> Hi Martin,
>
> On Wed, 14 Jul 2021 at 02:05, Martin Blumenstingl
> <martin.blumenstingl@googlemail.com> wrote:
> >
> > Hi Anand,
> >
> > On Tue, Jul 13, 2021 at 8:45 PM Anand Moon <linux.amoon@gmail.com> wrote:
> > >
> > > Hi Martin,
> > >
> > > Thanks for reviewing the changes,
> > >
> > > On Tue, 13 Jul 2021 at 20:35, Martin Blumenstingl
> > > <martin.blumenstingl@googlemail.com> wrote:
> > > >
> > > > Hi Anand,
> > > >
> > > > On Tue, Jul 13, 2021 at 7:53 AM Anand Moon <linux.amoon@gmail.com> wrote:
> > > > >
> > > > > Add missing usb phy power node for phy mode fix below warning.
> > > > >
> > > > > [    1.253149] phy phy-c1108820.phy.0: Looking up phy-supply from device tree
> > > > > [    1.253166] phy phy-c1108820.phy.0: Looking up phy-supply property
> > > > >                 in node /soc/cbus@c1100000/phy@8820 failed
> > > > I did some testing on my own Odroid-C1+ and this patch is not doing
> > > > anything for me.
> > > > more information below.
> > > Some device node for USB will have
> > The mistake I made before is considering USB VBUS as PHY power supply.
> > I believe the USB PHY is actually powered by the AVDD18_USB_ADC and
> > USB33_VDDIOH signals. See the S905 datasheet [0], page 25
> > These are 1.8V and 3.3V signals while you are adding a 5V regulator.
> >
> OK, thanks.
> > [...]
> > > > > +               /*
> > > > > +                * signal name from schematics: USB_POWER
> > > > > +                */
> > > > Just a few lines below you're saying that the name from the schematics is PWREN
> > > > If this patch is getting another round then please clarify the actual
> > > > signal name, or name both signals if the schematics is actually using
> > > > both names.
> > > >
> > > As per the schematics.
> > > PWREN ---> GPIOAO.BIT5      gpio pin control
> > > USB_POWER ---> P5V0          power source regulator.
> > ah, thanks for clarifying this
> > my suggestion is to put that exact paragraph into the comment to avoid confusion
> >
> > [...]
> > > > Can you please give this a try on your Odroid-C1 as well?
> > > > The conclusion from my own testing is that GPIOAO_5 doesn't seem to be
> > > > related to USB1 (host-only) because if it was then inverting the
> > > > polarity (from active high to active low) should result in a change.
> > > >
> > >
> > > Ok I have modified as per above but not changes in gpio polarity
> > > from active high to active low. see below.
> > >
> > > # Odroid C1
> > > [alarm@archl-c1e ~]$ sudo cat /sys/kernel/debug/gpio | grep USB
> > >  gpio-1953 (USB_HUB_RST_N       |usb-hub-reset       ) out hi
> > >  gpio-1954 (USB_OTG_PWREN       |regulator-usbp_pwr_e) out hi
> > >
> > > # Odroid C2
> > > [alarm@archl-c2lm ~]$  sudo cat /sys/kernel/debug/gpio | grep usb
> > >  gpio-501 (USB HUB nRESET      |usb-hub-reset       ) out hi
> > >  gpio-502 (USB OTG Power En    |regulator-usb-pwrs  ) out hi
> > that's strange, my result is different
> >
> >   gpio = <&gpio_ao GPIOAO_5 GPIO_ACTIVE_HIGH>;
> >   enable-active-high;
> > gives me:
> >   # grep USB_OTG_PWREN /sys/kernel/debug/gpio
> >   gpio-418 (USB_OTG_PWREN       |regulator-usb-pwr-en) out hi
> >
> >   gpio = <&gpio_ao GPIOAO_5 GPIO_ACTIVE_LOW>;
> > gives me:
> >   # grep USB_OTG_PWREN /sys/kernel/debug/gpio
> >   gpio-418 (USB_OTG_PWREN       |regulator-usb-pwr-en) out lo ACTIVE LOW
> This gpio pin number dose not match the gpio pin on Odroid c1+, see below.
> >
> > Did you remove the "enable-active-high;" in your "active low" test?
> No
> > GPIO polarity for regulators is managed with that flag, not just with
> > GPIO_ACTIVE_{HIGH,LOW}
>
> It's just with changes the following, below
> +++ b/arch/arm/boot/dts/meson8b-odroidc1.dts
> @@ -47,7 +47,7 @@ usb_pwr_en: regulator-usb-pwr-en {
>                 /*
>                  * signal name from schematics: PWREN
>                  */
> -               gpio = <&gpio_ao GPIOAO_5 GPIO_ACTIVE_HIGH>;
> +               gpio = <&gpio_ao GPIOAO_5 GPIO_ACTIVE_LOW>;
>                 enable-active-high;
>         };
>

Can you give these small changes a try,
$ git diff
diff --git a/arch/arm/boot/dts/meson8b-odroidc1.dts
b/arch/arm/boot/dts/meson8b-odroidc1.dts
index 748f4c6a050a..066523f14074 100644
--- a/arch/arm/boot/dts/meson8b-odroidc1.dts
+++ b/arch/arm/boot/dts/meson8b-odroidc1.dts
@@ -47,8 +47,9 @@ usb_pwr_en: regulator-usb-pwr-en {
                /*
                 * signal name from schematics: PWREN
                 */
-               gpio = <&gpio_ao GPIOAO_5 GPIO_ACTIVE_HIGH>;
+               gpio = <&gpio_ao GPIOAO_5 GPIO_OPEN_DRAIN>;
                enable-active-high;
+               regulator-always-on;
        };

[alarm@archl-c1e ~]$ sudo cat /sys/kernel/debug/gpio | grep usb
 gpio-1953 (USB_HUB_RST_N       |usb-hub-reset       ) out hi
 gpio-1954 (USB_OTG_PWREN       |regulator-usb-pwr-en) out lo

Thanks
-Anand
