Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5F323C9486
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 01:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237675AbhGNXd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 19:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbhGNXd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 19:33:27 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43CC6C06175F;
        Wed, 14 Jul 2021 16:30:35 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id v1so5470613edt.6;
        Wed, 14 Jul 2021 16:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MmCo10phYZjnbz7riI2lrli8JFJM355EZ/EUboI7RsU=;
        b=My1Ium+lDPZ1IpppOuHRs5Rld6fPeNYboQtih5zVYSNhf8OdDVyrpePQfdoMOrt1r9
         OFI8VVztFDz5MXAi091VMsBMCykOgIgvsbfiyE6RsveTx6CNaybjRu+Cso+cNrcbZBoQ
         EFHV+E8/55eMS1PedK98tgQC5osmTkOTz7dT+QwXUiGc8+ypaY4y7uh7NX+3jdWPTzp5
         7A5oEG+Ys8HJwcG8+awuIx7XeSeo9nZbkTOED098L/GmipR7hR8vSG8CU2kkU4pUnya9
         FHh5ZOthocyuVXCPf++3jMtGkL4G4H3J8uyVK5sl8NbnlRlorb6FUsGpm68WNF5xjVo+
         QGmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MmCo10phYZjnbz7riI2lrli8JFJM355EZ/EUboI7RsU=;
        b=qgCfwuOKk7ruOjfvywWqby2UPoRqBlhLtOGRsP7BxaI2p5Z/aI4IDix8ku6p9BpZhv
         A4BCQZNBhXugGGlGXSqrMjg2DjX1caJKaWjDMgXEuAFwosVKBxN4GexeZc7CVq7WZcQF
         kuRpX4oCqqF9i2/Oy9gwpBpYuKEFBwGbXG6aEc9fGgIwh9luDT0CS4HE2eEua/CdEU0n
         CqeJYKP96aHw1TeGexLdmRHx8/TDVbDv49jlQE53Je8koOxngZhF+eeru4lfVV5cdmPw
         +0j9f9/cewb/JKTWtyOUZR/jZ8UZ1qQ5DahKokr8cUsiz2OvcJbIYK9JmNxP4xOX7MMb
         z7kQ==
X-Gm-Message-State: AOAM531AaZ+F7JCM0N5N3XazBy9+zDztpz6jD8GK7FKtHyCmygC7aT7b
        HMTTehzTIiWb2YumIPFU/0g9fPXGv2+3fADsh8k=
X-Google-Smtp-Source: ABdhPJx0AQ7rkwJFWL2C/MDHijIvmNvm54SQAgQmq5qCp0CnWv4FoADx+pvNp6QTpflL4QPnwnAIjBW8BH4NjkrJEOM=
X-Received: by 2002:a05:6402:190c:: with SMTP id e12mr1132461edz.176.1626305433797;
 Wed, 14 Jul 2021 16:30:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210713055227.1142-1-linux.amoon@gmail.com> <20210713055227.1142-2-linux.amoon@gmail.com>
 <CAFBinCD3ahpNQhP_jWZ3-4nXx8OqZOAANCpTN3BrsULRbYZHVw@mail.gmail.com>
 <CANAwSgTh02qg=cMT8tpHcEfAs5yW2vHQ7tPOkvuKXos_fOmh8A@mail.gmail.com>
 <CAFBinCC-kD-MW+bwqCZH5AjYDhxWa_pN2WEnHuiZpx=RhUdROQ@mail.gmail.com>
 <CANAwSgTf4sjoufrZuK-EjE=+yA8zSoVbqhEyNhJJFBLUCOVZmQ@mail.gmail.com> <CANAwSgR5nNN3D+NZjqNNjyp=rVYE=RG2icnJAc=5F23xSh9Bvg@mail.gmail.com>
In-Reply-To: <CANAwSgR5nNN3D+NZjqNNjyp=rVYE=RG2icnJAc=5F23xSh9Bvg@mail.gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 15 Jul 2021 01:30:23 +0200
Message-ID: <CAFBinCBtZDRH_xTn3hUBbAPNGrut2cbEQOSuEN1vwObP1Ns5qw@mail.gmail.com>
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

On Wed, Jul 14, 2021 at 7:25 PM Anand Moon <linux.amoon@gmail.com> wrote:
[...]
> Can you give these small changes a try,
> $ git diff
> diff --git a/arch/arm/boot/dts/meson8b-odroidc1.dts
> b/arch/arm/boot/dts/meson8b-odroidc1.dts
> index 748f4c6a050a..066523f14074 100644
> --- a/arch/arm/boot/dts/meson8b-odroidc1.dts
> +++ b/arch/arm/boot/dts/meson8b-odroidc1.dts
> @@ -47,8 +47,9 @@ usb_pwr_en: regulator-usb-pwr-en {
>                 /*
>                  * signal name from schematics: PWREN
>                  */
> -               gpio = <&gpio_ao GPIOAO_5 GPIO_ACTIVE_HIGH>;
> +               gpio = <&gpio_ao GPIOAO_5 GPIO_OPEN_DRAIN>;
>                 enable-active-high;
> +               regulator-always-on;
>         };
>
> [alarm@archl-c1e ~]$ sudo cat /sys/kernel/debug/gpio | grep usb
>  gpio-1953 (USB_HUB_RST_N       |usb-hub-reset       ) out hi
>  gpio-1954 (USB_OTG_PWREN       |regulator-usb-pwr-en) out lo
I can reproduce the /sys/kernel/debug/gpio output with this patch

Still USB works for me regardless of whether USB_OTG_PWREN is HIGH or LOW
This is something that is not possible if the regulator is really
connected on the board like you are describing in this patch.
If this .dts change was correct then I would expect that USB is
breaking when inverting the GPIO polarity.

I am using the "inverted GPIO polarity" approach to find the Ethernet
PHY reset GPIO when working on boards for which I don't have the
schematics:
1) make an assumption of which GPIO to use
2) try with GPIO_ACTIVE_LOW -> PHY should be detected
3) change it to GPIO_ACTIVE_HIGH -> PHY should not be found anymore
(because it's in reset)
4) before submitting the board.dts upstream I of course change it back
to GPIO_ACTIVE_LOW

If during step 3) the PHY is still found then I know that it's not the
correct GPIO.
I am seeing the same behavior with this USB regulator. My
interpretation of this is: either you are not using the right GPIO or
the GPIO is not related to &usb1 (or it's PHY).


Best regards,
Martin
