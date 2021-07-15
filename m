Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 769B23C9C9B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 12:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241300AbhGOK1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 06:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbhGOK1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 06:27:07 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE8CC06175F;
        Thu, 15 Jul 2021 03:24:13 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id hc15so8448304ejc.4;
        Thu, 15 Jul 2021 03:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3O5J6rqGF6JMDu06boGyrc4Tj9mnTxeHjN3XsbyGvrs=;
        b=q6ZL3uQIevdhZUbDj15RHAlCF1aS0Duaxre+LA3t4f29x1/wHfR62boo6p5nebMWzc
         m8N6n2foBvI4j5z4tsNI+rfuAr585Spa2jGvsS2v2zJ/8D5cA1WWs6g7yrV9V2pcUxQl
         kfxe5qWaqfDfdovV5Va4lTP5m7SO6YcVYZmSv5HPu3HxUT1U8OUCqEHfJK+9jwT0nyzr
         L/N7hGA/7ZPQ+tN7udZKDr9hqxq621/SD+olWyJz4RDnkAIBgeqdBpIkRy5XydnuLq/v
         UJx/KfGe9+32bvVzdaiLNmBQd7N4re2dgjMjnZoN5kknEvEniBsSp7Hc76d8u7w8gkQc
         oVBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3O5J6rqGF6JMDu06boGyrc4Tj9mnTxeHjN3XsbyGvrs=;
        b=B9BqjLkQ9yHggoYMoOnmZNlT3K99+sHpvizsLz7qq5Iht98aPIfZpWZKL/I2zbDqqI
         hSt6UzlXoH6puGmJGnXMBn+UkugezPsOKfWTg+cAehpezpbxdWUYK57k0IRknD3evLYf
         rddUjLX3yvfT5uZD/k/nXrDwQcb7zRNoWmQCRKO6oEP0hVzmJKi1bHX3jD79qKjnQwm/
         WV+BVPKXKCnAQKe/3ZeR1gSDQTjtfo/1N+8PVIts45B/HNxULugsiwM0/jiX31AJvkiV
         3HTTKisE0t/cXoCY9Sc3PlSOHMWCrK5epij1oLYG44l/kTgYXdZvliY3xNfhPr9503AB
         nnTg==
X-Gm-Message-State: AOAM531ODBvIwbSiQN4R/6tt3Gc+UkWWPFBiR583Q6cCeFU62NBXzMWa
        zI/EqLm95ChP4N9d6LAEHAXBtw8xvN0vA2NA9u0=
X-Google-Smtp-Source: ABdhPJylikKFjvKIyxFG5Ozacn86GpWtIUI198XuwTYlxY4CemQ1wYGJNseEMr5sYfAje7CcLtrI9SVLi3YgKnYSYsM=
X-Received: by 2002:a17:907:3c16:: with SMTP id gh22mr4844903ejc.158.1626344652261;
 Thu, 15 Jul 2021 03:24:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210713055227.1142-1-linux.amoon@gmail.com> <20210713055227.1142-2-linux.amoon@gmail.com>
 <CAFBinCD3ahpNQhP_jWZ3-4nXx8OqZOAANCpTN3BrsULRbYZHVw@mail.gmail.com>
 <CANAwSgTh02qg=cMT8tpHcEfAs5yW2vHQ7tPOkvuKXos_fOmh8A@mail.gmail.com>
 <CAFBinCC-kD-MW+bwqCZH5AjYDhxWa_pN2WEnHuiZpx=RhUdROQ@mail.gmail.com>
 <CANAwSgTf4sjoufrZuK-EjE=+yA8zSoVbqhEyNhJJFBLUCOVZmQ@mail.gmail.com>
 <CANAwSgR5nNN3D+NZjqNNjyp=rVYE=RG2icnJAc=5F23xSh9Bvg@mail.gmail.com> <CAFBinCBtZDRH_xTn3hUBbAPNGrut2cbEQOSuEN1vwObP1Ns5qw@mail.gmail.com>
In-Reply-To: <CAFBinCBtZDRH_xTn3hUBbAPNGrut2cbEQOSuEN1vwObP1Ns5qw@mail.gmail.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Thu, 15 Jul 2021 15:54:01 +0530
Message-ID: <CANAwSgTowgbjLm56oH553ji8G8SiLVKyb3oaQzrR=hAp5t78Zw@mail.gmail.com>
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

Hi Martin,

On Thu, 15 Jul 2021 at 05:00, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Hi Anand,
>
> On Wed, Jul 14, 2021 at 7:25 PM Anand Moon <linux.amoon@gmail.com> wrote:
> [...]
> > Can you give these small changes a try,
> > $ git diff
> > diff --git a/arch/arm/boot/dts/meson8b-odroidc1.dts
> > b/arch/arm/boot/dts/meson8b-odroidc1.dts
> > index 748f4c6a050a..066523f14074 100644
> > --- a/arch/arm/boot/dts/meson8b-odroidc1.dts
> > +++ b/arch/arm/boot/dts/meson8b-odroidc1.dts
> > @@ -47,8 +47,9 @@ usb_pwr_en: regulator-usb-pwr-en {
> >                 /*
> >                  * signal name from schematics: PWREN
> >                  */
> > -               gpio = <&gpio_ao GPIOAO_5 GPIO_ACTIVE_HIGH>;
> > +               gpio = <&gpio_ao GPIOAO_5 GPIO_OPEN_DRAIN>;
> >                 enable-active-high;
> > +               regulator-always-on;
> >         };
> >
> > [alarm@archl-c1e ~]$ sudo cat /sys/kernel/debug/gpio | grep usb
> >  gpio-1953 (USB_HUB_RST_N       |usb-hub-reset       ) out hi
> >  gpio-1954 (USB_OTG_PWREN       |regulator-usb-pwr-en) out lo
> I can reproduce the /sys/kernel/debug/gpio output with this patch
>
> Still USB works for me regardless of whether USB_OTG_PWREN is HIGH or LOW
> This is something that is not possible if the regulator is really
> connected on the board like you are describing in this patch.
> If this .dts change was correct then I would expect that USB is
> breaking when inverting the GPIO polarity.
>
> I am using the "inverted GPIO polarity" approach to find the Ethernet
> PHY reset GPIO when working on boards for which I don't have the
> schematics:
Thanks for the hint,
> 1) make an assumption of which GPIO to use
> 2) try with GPIO_ACTIVE_LOW -> PHY should be detected
> 3) change it to GPIO_ACTIVE_HIGH -> PHY should not be found anymore
> (because it's in reset)
> 4) before submitting the board.dts upstream I of course change it back
> to GPIO_ACTIVE_LOW

Yes I am going to changes this to GPIO_ACTIVE_LOW in the next version.
These dts changes just assist in power through PHY to USB ports.
After going through the previous email I got this working see below.

[alarm@archl-c1e linux-amlogic-5.y-devel]$ sudo cat
/sys/kernel/debug/gpio | grep usb
 gpio-1953 (USB_HUB_RST_N       |usb-hub-reset       ) out hi
 gpio-1954 (USB_OTG_PWREN       |regulator-usb-pwr-en) out lo ACTIVE LOW

>
> If during step 3) the PHY is still found then I know that it's not the
> correct GPIO.
> I am seeing the same behavior with this USB regulator. My
> interpretation of this is: either you are not using the right GPIO or
> the GPIO is not related to &usb1 (or it's PHY).
>
With reference to the schematic  odroid-c1+_rev0.4_20160226
section USB HOST POWER ---- MP62551DGT-LF-Z
Both USB POWER and PWREN help control the power to USB Ports.

>
> Best regards,
> Martin

Thanks
-Anand
