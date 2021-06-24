Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBE33B31CE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 16:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232146AbhFXO5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 10:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbhFXO5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 10:57:15 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11765C061574
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 07:54:55 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id n20so8934752edv.8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 07:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zDkuOJgh5C+WDvt537xufC47ONbIjJXep0BnGb2gBVw=;
        b=t9RkEIBOrAGkGWMdPyS5yH5Xiwep9OjZjnF0UMNlBoJvK3vwY8+92jPQIVd/nEoHmG
         A7WzPHR7uYwqhi5t7RmUnbqvefir1G1vOQHAsz6autNr++V9sYiUoucE7oyYUNoqhkL+
         TF6We/J0y9R090jUgImLbCsgJbm2j/F/O2Qv7IRQhdLQSkX2Yle0cMRuTE4J+JNMUy/9
         ONkkRYjo9ENONlTY8uRzKNMmE6n4e7+NHv58vJEKfI1ypZPxYP4wiE/pP9sWOxpgb7y7
         swqmpH4OI3qQGEPiK+RASk2EBo4IEs1YD5trfV2oF+3byXgswnzxpDJkh8x03zKet5Q8
         dOAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zDkuOJgh5C+WDvt537xufC47ONbIjJXep0BnGb2gBVw=;
        b=V1Rf1ExmyezdB0E7EsURNieaUR3YaH7r9PTC6U4rkkoDM0CE9thT4p9I8i2Bg0uJ5z
         6VgJP03G6voOWWkBkbfrvfFkjMelVhnw5siXZshpHI5H8qjRI2+hPDgy0o4sukPI5III
         xGHEHMau+f5FxENnLP1JnNj5e2RDq7JmOSPbNuKxbvmhuUgvaPYkQGzrL+S+aLZFi7Az
         tXL6cUBJfbmrgMinQ2zzyiwaPJXbIZ4iuEaeE7wboYsdGIV0pa+Ipirr97mGxOckk2/h
         q5ZyD5FI+s2Cvt/uhiVHWBmpMpB7sY0FMx60BTmJol/B+PNb3lilMRU1Yhn/y4GCBmpq
         zNhw==
X-Gm-Message-State: AOAM532Dxd6FMiYhC2ErnOKwC4ajH7sXP725hRSXj+dj6KpK7D0leaDL
        GZ/L8v7U1Y50bIhkTXW0uaQ9u05IrdvQKeA5Sls=
X-Google-Smtp-Source: ABdhPJz7flfGG4Jo9YL8PvaGhSQvFXCvoM7XYKaKr0PGFS8TRqS5Q+S2stv2YD2ZGvEAzlYAii4X7wQ36jtMzKbV69Q=
X-Received: by 2002:a50:fc90:: with SMTP id f16mr7829930edq.254.1624546493652;
 Thu, 24 Jun 2021 07:54:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210617194154.2397-1-linux.amoon@gmail.com> <20210617194154.2397-7-linux.amoon@gmail.com>
 <CAFBinCCE+6G7QtDoxfbcZVVRf-MDX-epSo=_k_PJZgWX+_Whvg@mail.gmail.com>
 <CANAwSgRqixugUr-t2OheLBVwD=EOkaLqxnGkT-Bx=p_A4Nyr8Q@mail.gmail.com>
 <CAFBinCALsnpbJGEb4LBLd_jy3E8fOZAQaacz-P7ijfkeyYg2dA@mail.gmail.com>
 <CANAwSgRABOyWYJPrrw64Wa6j2D94T4tybn7MHGCTbBowt7UncA@mail.gmail.com> <CAFBinCD91eYNXSqnmDKoAvJHWqqRbXVjnaq9RuRNCnip9kKqkw@mail.gmail.com>
In-Reply-To: <CAFBinCD91eYNXSqnmDKoAvJHWqqRbXVjnaq9RuRNCnip9kKqkw@mail.gmail.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Thu, 24 Jun 2021 20:24:42 +0530
Message-ID: <CANAwSgRzY+699aSS9MVGAJYVR6_0Ni75JPhO9=LKunHQK0p=oA@mail.gmail.com>
Subject: Re: [RFCv1 6/8] phy: amlogic: meson8b-usb2: Use phy reset callback function
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-phy@lists.infradead.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

On Wed, 23 Jun 2021 at 01:42, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Hi Anand,
>
> On Mon, Jun 21, 2021 at 9:16 AM Anand Moon <linux.amoon@gmail.com> wrote:
> [...]
> > Ok Thanks for the inputs. got your point.
> >
> > I was also looking into Amlogic source code for reset. (aml_cbus_update_bits)
> > [0] https://github.com/khadas/linux/blob/khadas-vims-4.9.y/drivers/amlogic/usb/phy/phy-aml-new-usb.c
> > is there some feature to iomap the USB with cbus?
> for that specific code: that's what we do inside drivers/reset/reset-meson.c
> Amlogic's vendor kernel uses an increment of 4 bytes per value, so
> 0x1102 translates to 0x4408
>
> then in mainline's meson8b.dtsi we have:
>     compatible = "amlogic,meson8b-reset";
>     reg = <0x4404 0x9c>;
> as you can see 0x4408 is part of the reset controller node.
>
> next in include/dt-bindings/reset/amlogic,meson8b-reset.h we have:
>     #define RESET_USB_OTG                 34
>
> the register used for reset line 34 is translated using:
>     0x4404 (first register) + 4 (4 * reset line / 32 = 1) = 0x4408
> then the bit inside this register is translated using:
>     reset line % 32 = 2
>
> that's how we express aml_cbus_update_bits(0x1102, 0x1<<2, 0x1<<2); in
> the mainline kernel (by going through the reset subsystem)
>

Thank you very much for clearing my long-standing doubt on *reset
logic* on Amlogic SoC.

> [...]
> > > > > > -       priv->reset = devm_reset_control_get_optional_shared(&pdev->dev, NULL);
> > > > > > +       priv->reset = devm_reset_control_get_optional_shared(&pdev->dev, "phy");
> > > > > I think this breaks compatibility with existing .dtbs and our
> > > > > dt-bindings (as we're not documenting a "reset-names" property).
> > > > > What is the goal of this one?
> > > > >
> > > >
> > > > OK, If we pass NULL over here there is the possibility
> > > > USB phy will not get registered.
> > > I don't understand why - with NULL everything is working fine for me.
> > > Also no matter which name you give to the reset line (in reset-names),
> > > it will be the same reset line in all cases. If it's the same reset
> > > line before and after: why is this needed?
> > >
> > I need to investigate this reset feature. With my setup with current changes
> > after I update the below.
> > -       priv->reset = devm_reset_control_get_optional_shared(&pdev->dev, "phy");
> > +       priv->reset = devm_reset_control_get_optional_shared(&pdev->dev, NULL);
> >         if (PTR_ERR(priv->reset) == -EPROBE_DEFER)
> >                 return PTR_ERR(priv->reset);
> >
> > Reset will break the USB initialization, see below output.
> interesting, I have not seen that USB problem before and neither is
> Kernel CI seeing it: [0]
> Is it only happening with this patch or did you also see it before?
>
Yes, it could happen with this patch but It could be also linked to
reorder the phy configuration.
See below logs, when core reset fails on USB PHY no USB is getting registered.

[    1.267620] dwc2 c9040000.usb: mapped PA c9040000 to VA (ptrval)
[    1.267768] dwc2 c9040000.usb: Looking up vusb_d-supply from device tree
[    1.267783] dwc2 c9040000.usb: Looking up vusb_d-supply property in
node /soc/usb@c9040000 failed
[    1.267814] dwc2 c9040000.usb: supply vusb_d not found, using dummy regulator
[    1.267940] dwc2 c9040000.usb: Looking up vusb_a-supply from device tree
[    1.267954] dwc2 c9040000.usb: Looking up vusb_a-supply property in
node /soc/usb@c9040000 failed
[    1.267975] dwc2 c9040000.usb: supply vusb_a not found, using dummy regulator
[    1.268037] dwc2 c9040000.usb: registering common handler for irq35
[    1.268090] dwc2 c9040000.usb: Looking up vbus-supply from device tree
[    1.268102] dwc2 c9040000.usb: Looking up vbus-supply property in
node /soc/usb@c9040000 failed
[    1.269267] dwc2 c9040000.usb: Core Release: 3.10a (snpsid=4f54310a)
[    1.273185] dwc2 c9040000.usb: dwc2_core_reset: HANG! Soft Reset
timeout GRSTCTL_CSFTRST
[    1.273510] dwc2: probe of c9040000.usb failed with error -16
[    1.275474] dwc2 c90c0000.usb: mapped PA c90c0000 to VA (ptrval)
[    1.275603] dwc2 c90c0000.usb: Looking up vusb_d-supply from device tree
[    1.275617] dwc2 c90c0000.usb: Looking up vusb_d-supply property in
node /soc/usb@c90c0000 failed
[    1.275646] dwc2 c90c0000.usb: supply vusb_d not found, using dummy regulator
[    1.275784] dwc2 c90c0000.usb: Looking up vusb_a-supply from device tree
[    1.275798] dwc2 c90c0000.usb: Looking up vusb_a-supply property in
node /soc/usb@c90c0000 failed
[    1.275819] dwc2 c90c0000.usb: supply vusb_a not found, using dummy regulator
[    1.275877] dwc2 c90c0000.usb: registering common handler for irq36
[    1.275930] dwc2 c90c0000.usb: Looking up vbus-supply from device tree
[    1.275942] dwc2 c90c0000.usb: Looking up vbus-supply property in
node /soc/usb@c90c0000 failed
[    1.277125] dwc2 c90c0000.usb: Core Release: 3.10a (snpsid=4f54310a)
[    1.281042] dwc2 c90c0000.usb: dwc2_core_reset: HANG! Soft Reset
timeout GRSTCTL_CSFTRST
[    1.281353] dwc2: probe of c90c0000.usb failed with error -16

>
> Best regards,
> Martin
>
>
> [0] https://storage.staging.kernelci.org/next/master/next-20210617/arm/multi_v7_defconfig+ltp-ima/gcc-8/lab-baylibre/baseline-meson8b-odroidc1.html
