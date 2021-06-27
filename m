Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E60FC3B551A
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jun 2021 22:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbhF0UJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 16:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbhF0UJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 16:09:47 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7248CC061574
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jun 2021 13:07:21 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id yy20so17808100ejb.6
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jun 2021 13:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4GZy7C/9sgJCYlkJRGJmqppC27IF56G6yPi0fir+u+U=;
        b=de4EKYnhin6OAMnO4NukNewMbCn4Zn1bjZgwVULo2pw+OtuWKDioNaQhBcWfz8B6cl
         oycpWnt9HXe1QFrQq64XdbXJzCoUK3FQeGs9srdADy379zwTm+DqZRwoGpcnAfewgdL5
         gTdfcnqTAkI3Zg82deaEmUuV0dbKEcf7mydBk02Cj4C/044Q1OhbaZMFJ4vclbT4LBNA
         y8iQn2mFj2Jvf26lrUhkSL/zS6WLpwvtCkfCvqI/0pwVU5b5lvPTSyFcIWqbChg0l8wp
         mqokW+gvWBt7e3CjvhgjWR6UrLn4bwXZ5E99FuwMZTWVjoVcBRNrNqQLAii68EyCyh8Z
         6qEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4GZy7C/9sgJCYlkJRGJmqppC27IF56G6yPi0fir+u+U=;
        b=IGxAaC2Cn8OSItH8FR3ep/vOpPlP99pEXzfDiA4UKaSSIW2o1lSEDwwJqC4cH69ppN
         IgvQ5NvWEKwpWbrpsGIWTPs83MvDIDlNXWCa9nUQoGNNSxacz27Zw/cJeqqRObtGLkl+
         5G7g/xgUIRiVUF1khjW0OeJqDmyIdNG8/722BKc5x2Adlg72thBTmGhysUzRBLSY1SEn
         rGpyKGXY80LNv6MlrI+o7qC+V/KrWYeOfbf/wME0yw7SApcglqqfq6fRqyTlUnNVK1cK
         o4m0SR1kqw3YUcRCxqxVsrx2P6SPtYSgegVh2BS+44DUbzlX68coGgjRV4iKuIm1ivDN
         ZoEg==
X-Gm-Message-State: AOAM5307dG2NywwmMYlRKe4M6MMZIE1zBqaWiUuL34mRivg1HNMFQFH+
        VuPASBh7Ua1A+Kh+qDwy5+UbKU8SUDNQ2vAfblA=
X-Google-Smtp-Source: ABdhPJz3tOQ8PoogIkkWY4d9SpFZHJZzPxU5NFlcG/A9Se/KywrauH1fHDuTX8VG/enLAVqFiT0qZLkI6kfBd0EyAuo=
X-Received: by 2002:a17:907:1dd9:: with SMTP id og25mr20771185ejc.108.1624824440004;
 Sun, 27 Jun 2021 13:07:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210617194154.2397-1-linux.amoon@gmail.com> <20210617194154.2397-7-linux.amoon@gmail.com>
 <CAFBinCCE+6G7QtDoxfbcZVVRf-MDX-epSo=_k_PJZgWX+_Whvg@mail.gmail.com>
 <CANAwSgRqixugUr-t2OheLBVwD=EOkaLqxnGkT-Bx=p_A4Nyr8Q@mail.gmail.com>
 <CAFBinCALsnpbJGEb4LBLd_jy3E8fOZAQaacz-P7ijfkeyYg2dA@mail.gmail.com>
 <CANAwSgRABOyWYJPrrw64Wa6j2D94T4tybn7MHGCTbBowt7UncA@mail.gmail.com>
 <CAFBinCD91eYNXSqnmDKoAvJHWqqRbXVjnaq9RuRNCnip9kKqkw@mail.gmail.com> <CANAwSgRzY+699aSS9MVGAJYVR6_0Ni75JPhO9=LKunHQK0p=oA@mail.gmail.com>
In-Reply-To: <CANAwSgRzY+699aSS9MVGAJYVR6_0Ni75JPhO9=LKunHQK0p=oA@mail.gmail.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Mon, 28 Jun 2021 01:37:08 +0530
Message-ID: <CANAwSgQktfn9Q=PJhx5Uq0UQ2dHqJwjKu1RWyb2k=-dA9=+BSQ@mail.gmail.com>
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

On Thu, 24 Jun 2021 at 20:24, Anand Moon <linux.amoon@gmail.com> wrote:
>
> Hi Martin,
>
> On Wed, 23 Jun 2021 at 01:42, Martin Blumenstingl
> <martin.blumenstingl@googlemail.com> wrote:
> >
> > Hi Anand,
> >
> > On Mon, Jun 21, 2021 at 9:16 AM Anand Moon <linux.amoon@gmail.com> wrote:
> > [...]
> > > Ok Thanks for the inputs. got your point.
> > >
> > > I was also looking into Amlogic source code for reset. (aml_cbus_update_bits)
> > > [0] https://github.com/khadas/linux/blob/khadas-vims-4.9.y/drivers/amlogic/usb/phy/phy-aml-new-usb.c
> > > is there some feature to iomap the USB with cbus?
> > for that specific code: that's what we do inside drivers/reset/reset-meson.c
> > Amlogic's vendor kernel uses an increment of 4 bytes per value, so
> > 0x1102 translates to 0x4408
> >
> > then in mainline's meson8b.dtsi we have:
> >     compatible = "amlogic,meson8b-reset";
> >     reg = <0x4404 0x9c>;
> > as you can see 0x4408 is part of the reset controller node.
> >
> > next in include/dt-bindings/reset/amlogic,meson8b-reset.h we have:
> >     #define RESET_USB_OTG                 34
> >
> > the register used for reset line 34 is translated using:
> >     0x4404 (first register) + 4 (4 * reset line / 32 = 1) = 0x4408
> > then the bit inside this register is translated using:
> >     reset line % 32 = 2
> >
> > that's how we express aml_cbus_update_bits(0x1102, 0x1<<2, 0x1<<2); in
> > the mainline kernel (by going through the reset subsystem)
> >
>
> Thank you very much for clearing my long-standing doubt on *reset
> logic* on Amlogic SoC.
>
> > [...]
> > > > > > > -       priv->reset = devm_reset_control_get_optional_shared(&pdev->dev, NULL);
> > > > > > > +       priv->reset = devm_reset_control_get_optional_shared(&pdev->dev, "phy");
> > > > > > I think this breaks compatibility with existing .dtbs and our
> > > > > > dt-bindings (as we're not documenting a "reset-names" property).
> > > > > > What is the goal of this one?
> > > > > >
> > > > >
> > > > > OK, If we pass NULL over here there is the possibility
> > > > > USB phy will not get registered.
> > > > I don't understand why - with NULL everything is working fine for me.
> > > > Also no matter which name you give to the reset line (in reset-names),
> > > > it will be the same reset line in all cases. If it's the same reset
> > > > line before and after: why is this needed?
> > > >
> > > I need to investigate this reset feature. With my setup with current changes
> > > after I update the below.
> > > -       priv->reset = devm_reset_control_get_optional_shared(&pdev->dev, "phy");
> > > +       priv->reset = devm_reset_control_get_optional_shared(&pdev->dev, NULL);
> > >         if (PTR_ERR(priv->reset) == -EPROBE_DEFER)
> > >                 return PTR_ERR(priv->reset);
> > >
> > > Reset will break the USB initialization, see below output.
> > interesting, I have not seen that USB problem before and neither is
> > Kernel CI seeing it: [0]
> > Is it only happening with this patch or did you also see it before?
> >
> Yes, it could happen with this patch but It could be also linked to
> reorder the phy configuration.
> See below logs, when core reset fails on USB PHY no USB is getting registered.
>
> [    1.267620] dwc2 c9040000.usb: mapped PA c9040000 to VA (ptrval)
> [    1.267768] dwc2 c9040000.usb: Looking up vusb_d-supply from device tree
> [    1.267783] dwc2 c9040000.usb: Looking up vusb_d-supply property in
> node /soc/usb@c9040000 failed
> [    1.267814] dwc2 c9040000.usb: supply vusb_d not found, using dummy regulator
> [    1.267940] dwc2 c9040000.usb: Looking up vusb_a-supply from device tree
> [    1.267954] dwc2 c9040000.usb: Looking up vusb_a-supply property in
> node /soc/usb@c9040000 failed
> [    1.267975] dwc2 c9040000.usb: supply vusb_a not found, using dummy regulator
> [    1.268037] dwc2 c9040000.usb: registering common handler for irq35
> [    1.268090] dwc2 c9040000.usb: Looking up vbus-supply from device tree
> [    1.268102] dwc2 c9040000.usb: Looking up vbus-supply property in
> node /soc/usb@c9040000 failed
> [    1.269267] dwc2 c9040000.usb: Core Release: 3.10a (snpsid=4f54310a)
> [    1.273185] dwc2 c9040000.usb: dwc2_core_reset: HANG! Soft Reset
> timeout GRSTCTL_CSFTRST
> [    1.273510] dwc2: probe of c9040000.usb failed with error -16
> [    1.275474] dwc2 c90c0000.usb: mapped PA c90c0000 to VA (ptrval)
> [    1.275603] dwc2 c90c0000.usb: Looking up vusb_d-supply from device tree
> [    1.275617] dwc2 c90c0000.usb: Looking up vusb_d-supply property in
> node /soc/usb@c90c0000 failed
> [    1.275646] dwc2 c90c0000.usb: supply vusb_d not found, using dummy regulator
> [    1.275784] dwc2 c90c0000.usb: Looking up vusb_a-supply from device tree
> [    1.275798] dwc2 c90c0000.usb: Looking up vusb_a-supply property in
> node /soc/usb@c90c0000 failed
> [    1.275819] dwc2 c90c0000.usb: supply vusb_a not found, using dummy regulator
> [    1.275877] dwc2 c90c0000.usb: registering common handler for irq36
> [    1.275930] dwc2 c90c0000.usb: Looking up vbus-supply from device tree
> [    1.275942] dwc2 c90c0000.usb: Looking up vbus-supply property in
> node /soc/usb@c90c0000 failed
> [    1.277125] dwc2 c90c0000.usb: Core Release: 3.10a (snpsid=4f54310a)
> [    1.281042] dwc2 c90c0000.usb: dwc2_core_reset: HANG! Soft Reset
> timeout GRSTCTL_CSFTRST
 > [    1.281353] dwc2: probe of c90c0000.usb failed with error -16
 >

Sorry for the delay.
We could switch the reset logic to
*devm_reset_control_get_optional_exclusive* as below
to fix the reset line, since both the dwc2 c90c0000.usb and c9040000.usb
will have their own context to reset control register, it means the
reset line is not share
between two USB PHY nodes.

-       priv->reset = devm_reset_control_get_optional_shared(&pdev->dev, NULL);
+       priv->reset = devm_reset_control_get_optional_exclusive(&pdev->dev,
+                                                               "reset");

> >
> > Best regards,
> > Martin
> >
> >
> > [0] https://storage.staging.kernelci.org/next/master/next-20210617/arm/multi_v7_defconfig+ltp-ima/gcc-8/lab-baylibre/baseline-meson8b-odroidc1.html

Thanks
-Anand
