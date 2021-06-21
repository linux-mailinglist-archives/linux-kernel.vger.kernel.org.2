Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD9E3AE3F3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 09:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbhFUHSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 03:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbhFUHSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 03:18:17 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA65DC061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 00:16:03 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id nd37so27071276ejc.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 00:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VE3Ea4BPCkopgR+SceHAr1CcKWEjirXXxv6I5VlDKz0=;
        b=qbSM3/qKaTaSN0EQ3YLpVscDDK+ngUMX3KIPIhHAP2PDiU8+Wf/6ujNs24RvtsqRUp
         4Y5NmxXeJLO5c6sx2iIU8Tm6wuXCC0njxNS68hxYMn37lIUiZLtPxhfw4f8mUi/yYLrC
         fpt0OPlfU7LlZt4Gp1eVkJAUp707ANoNxcyseCOSyJUKlCsRZFMusrUL1cdm8j7RU7bF
         A+sutLhNIfN/oLkQvp82MU7wZ1kIVsbV2Gk4TbwwBGJe6t2deLkDm4DAS6i1ctjn1b5W
         BKh/mU1llpRav2+8kIaYKmFkL5/8VW9fKdyzvm/JTqw3L+BpY6hqOkfIKqJRqLkLpCZr
         DjCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VE3Ea4BPCkopgR+SceHAr1CcKWEjirXXxv6I5VlDKz0=;
        b=fKLAkXW0z4XRNmo2iM378ooCTqlasuu1COK0MK7lsAuhB6YpGQqDaZBiF34fMr+c0+
         8YFRLEeZa8UMwWcoSXrwqV2lEbSigpYrwvCbASWTd996MpiDel55Vd7Dh9uIzpaDJwTT
         jgldqwNbNzhp/6+mxOp5qJ+PmlaO/58lSNFZuhh8HsvL9i5h9pYVKQt0w+S/ff1zN6wL
         8YSY8a3Ptwmi7tZpkEcJiz10mmrmBnMAlz+9tthP67a+YCKuBqmWT62hyIonfsLfIc/L
         j8LzxFd/4+/V48iz2n8QDKDiiPpvHLri2O0Av/aWrgePv+efGA42tDSnbRBOv+VtnHOo
         oQUg==
X-Gm-Message-State: AOAM530+PQP4Y8SZOu7U6qDAlDIH4cnOeFAcsFk8lB9HgTE4HzcWRShj
        BlqwmtDZdCMYmf/eCenHwDHIPGe8VqQ3TfnCbIk=
X-Google-Smtp-Source: ABdhPJwlhXn1ZUS4AdM5ajJYAe3cfRVYfAgGzqYz3WTPupXpBrrnVxTMG5QmLY1S1tVt2GhIwlmiJFWoIa91wRifW6I=
X-Received: by 2002:a17:907:7789:: with SMTP id ky9mr6329024ejc.191.1624259762466;
 Mon, 21 Jun 2021 00:16:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210617194154.2397-1-linux.amoon@gmail.com> <20210617194154.2397-7-linux.amoon@gmail.com>
 <CAFBinCCE+6G7QtDoxfbcZVVRf-MDX-epSo=_k_PJZgWX+_Whvg@mail.gmail.com>
 <CANAwSgRqixugUr-t2OheLBVwD=EOkaLqxnGkT-Bx=p_A4Nyr8Q@mail.gmail.com> <CAFBinCALsnpbJGEb4LBLd_jy3E8fOZAQaacz-P7ijfkeyYg2dA@mail.gmail.com>
In-Reply-To: <CAFBinCALsnpbJGEb4LBLd_jy3E8fOZAQaacz-P7ijfkeyYg2dA@mail.gmail.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Mon, 21 Jun 2021 12:45:51 +0530
Message-ID: <CANAwSgRABOyWYJPrrw64Wa6j2D94T4tybn7MHGCTbBowt7UncA@mail.gmail.com>
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

Hi Martin

Thanks for your review comments.

On Sat, 19 Jun 2021 at 01:36, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Hi Anand,
>
> On Fri, Jun 18, 2021 at 5:33 PM Anand Moon <linux.amoon@gmail.com> wrote:
> [...]
> > > For shared resets (like the one we have here) reset_control_reset will
> > > only trigger the reset line once until all drivers using that reset
> > > line are unloaded.
> > > So effectively this new phy_ops.reset callback will be a no-op.
> >
> > I know his register is shared between two USB IPs,
> > but I have not observed any issues.
> have you checked at which point we're then actually triggering the reset?
> I assume that you will find that the reset is only triggered for the
> very first power_on/init call - which makes this patch effectively a
> no-op (yes, we're calling reset_control_reset then, but that doesn't
> mean that a reset is triggered on hardware level - see
> drivers/reset/core.c at around line 346).
>
Ok Thanks for the inputs. got your point.

I was also looking into Amlogic source code for reset. (aml_cbus_update_bits)
[0] https://github.com/khadas/linux/blob/khadas-vims-4.9.y/drivers/amlogic/usb/phy/phy-aml-new-usb.c
is there some feature to iomap the USB with cbus?

> [...]
> > > > -       priv->reset = devm_reset_control_get_optional_shared(&pdev->dev, NULL);
> > > > +       priv->reset = devm_reset_control_get_optional_shared(&pdev->dev, "phy");
> > > I think this breaks compatibility with existing .dtbs and our
> > > dt-bindings (as we're not documenting a "reset-names" property).
> > > What is the goal of this one?
> > >
> >
> > OK, If we pass NULL over here there is the possibility
> > USB phy will not get registered.
> I don't understand why - with NULL everything is working fine for me.
> Also no matter which name you give to the reset line (in reset-names),
> it will be the same reset line in all cases. If it's the same reset
> line before and after: why is this needed?
>
I need to investigate this reset feature. With my setup with current changes
after I update the below.
-       priv->reset = devm_reset_control_get_optional_shared(&pdev->dev, "phy");
+       priv->reset = devm_reset_control_get_optional_shared(&pdev->dev, NULL);
        if (PTR_ERR(priv->reset) == -EPROBE_DEFER)
                return PTR_ERR(priv->reset);

Reset will break the USB initialization, see below output.

[    1.265403] dwc2 c9040000.usb: mapped PA c9040000 to VA (ptrval)
[    1.265540] dwc2 c9040000.usb: Looking up vusb_d-supply from device tree
[    1.265554] dwc2 c9040000.usb: Looking up vusb_d-supply property in
node /soc/usb@c9040000 failed
[    1.265585] dwc2 c9040000.usb: supply vusb_d not found, using dummy regulator
[    1.265717] dwc2 c9040000.usb: Looking up vusb_a-supply from device tree
[    1.265730] dwc2 c9040000.usb: Looking up vusb_a-supply property in
node /soc/usb@c9040000 failed
[    1.265752] dwc2 c9040000.usb: supply vusb_a not found, using dummy regulator
[    1.265812] dwc2 c9040000.usb: registering common handler for irq35
[    1.265867] dwc2 c9040000.usb: Looking up vbus-supply from device tree
[    1.265880] dwc2 c9040000.usb: Looking up vbus-supply property in
node /soc/usb@c9040000 failed
[    1.267066] dwc2 c9040000.usb: Core Release: 3.10a (snpsid=4f54310a)
[    1.270983] dwc2 c9040000.usb: dwc2_core_reset: HANG! Soft Reset
timeout GRSTCTL_CSFTRST
[    1.271319] dwc2: probe of c9040000.usb failed with error -16
[    1.273296] dwc2 c90c0000.usb: mapped PA c90c0000 to VA (ptrval)
[    1.273426] dwc2 c90c0000.usb: Looking up vusb_d-supply from device tree
[    1.273440] dwc2 c90c0000.usb: Looking up vusb_d-supply property in
node /soc/usb@c90c0000 failed
[    1.273471] dwc2 c90c0000.usb: supply vusb_d not found, using dummy regulator
[    1.273607] dwc2 c90c0000.usb: Looking up vusb_a-supply from device tree
[    1.273621] dwc2 c90c0000.usb: Looking up vusb_a-supply property in
node /soc/usb@c90c0000 failed
[    1.273641] dwc2 c90c0000.usb: supply vusb_a not found, using dummy regulator
[    1.273700] dwc2 c90c0000.usb: registering common handler for irq36
[    1.273750] dwc2 c90c0000.usb: Looking up vbus-supply from device tree
[    1.273762] dwc2 c90c0000.usb: Looking up vbus-supply property in
node /soc/usb@c90c0000 failed
[    1.274966] dwc2 c90c0000.usb: Core Release: 3.10a (snpsid=4f54310a)
[    1.278888] dwc2 c90c0000.usb: dwc2_core_reset: HANG! Soft Reset
timeout GRSTCTL_CSFTRST
[    1.279224] dwc2: probe of c90c0000.usb failed with error -16



>
> Best regards,
> Martin

Thanks
-Anand
