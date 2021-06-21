Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6FD3AE3FF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 09:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbhFUHXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 03:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbhFUHXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 03:23:04 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7FCC061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 00:20:50 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id hq39so14640ejc.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 00:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c+vUa1UJEeV1Fh7yDKg8NRJV7NdKihQmk+VqSoLdyls=;
        b=IBCbfCu2aVToYUBGsB3mk6ZzTcO1+EH5TzeGBu+qs+lR9jet/M56aMR+DLm1aCA4/r
         3VWDQgWXSF9EUqg2A90ImiN2xJ+8xZF6rdEkCdLdse1n8hYDW4BOrh/R3uL6DsbjA5PI
         WYX9Tn9Vk47w+EPDC25Qi86hSBgpxl++WfnKHYU83gX066L6gS2NRYTl5S5C2m3uVlKJ
         7J8+ni7Lycj/x1Aml4Nm7ZQrNJ6fRsY5eoxnhhMLu4wwfF4dFq5Ou5vqr0SQqeufYvXH
         WalN4szoBpN/ZsA0gPEgViHEihMW5wjbH2r2YsdC6kFBrhI9EV6oHKYFdx0wmvXYdT39
         qFvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c+vUa1UJEeV1Fh7yDKg8NRJV7NdKihQmk+VqSoLdyls=;
        b=gYU1a+bqwhYn3v7k0zkIZc4deIAkRKiiezTkGGGiAdcvyZZoGVcq7lBo/NLJy+n6h4
         Q0OnOUoYL8zzmuTyI6ZV5NrtO5oPouxj9Hk28nNvp0N5RqvwtrgfGZEIpmxCpVt/3aRM
         FscYlTusomgzGl+lCsIKsze1tW3zV3u2xoLKJ/Kxwzr3qF0jQqqpYKY5l847pHaTW1PD
         Ou+irTAlLjyAiy+dLNqEL/VB96t+4MCJL7XG4+93n9wwzQSz/5WFDmK/WzokPhFAjSwK
         bKLPWZmU6YIuHkH/L9Xx9iGgJquccMrQziNL16krakmPyrVE1FEQqVAk1CwspDnlCWXr
         3jkQ==
X-Gm-Message-State: AOAM532JEOjbGnWyItMBHcBZyo56Eq/WvJZWT4v2Xqu2n47j5z8Lbj3L
        6fvznty17AHxViAl6u5IYj2XQ6yKaWI7Lnpux5s=
X-Google-Smtp-Source: ABdhPJwqVaVz7oYbyjo8YPm/cHzc9kY/RLwkhcnBJ0YDnWvcOUPBi2NcPjXu7d1xZVjKLJI0/io3de4kP7XnO6l0spY=
X-Received: by 2002:a17:907:2625:: with SMTP id aq5mr7670564ejc.373.1624260048564;
 Mon, 21 Jun 2021 00:20:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210617194154.2397-1-linux.amoon@gmail.com> <20210617194154.2397-5-linux.amoon@gmail.com>
 <CAFBinCB1rrmJ5=M0tSGS_47BarFcrs2Kz5qFzrHw8+OEYxX3DA@mail.gmail.com>
 <CANAwSgQVgKUoTpfaJyfxdphqc6M=Oq6jj5zZ7An9St7PdzQHYA@mail.gmail.com> <CAFBinCDpQybqD96CCMBDKYUXEYCABr0QMfxFH1AWrXP12UxxMg@mail.gmail.com>
In-Reply-To: <CAFBinCDpQybqD96CCMBDKYUXEYCABr0QMfxFH1AWrXP12UxxMg@mail.gmail.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Mon, 21 Jun 2021 12:50:37 +0530
Message-ID: <CANAwSgTd1zq_gHbVZesLY=e3DRRGgn_o5omuDo9Lub4FavOtbQ@mail.gmail.com>
Subject: Re: [RFCv1 4/8] phy: amlogic: meson8b-usb2: Use phy set_mode callback function
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

On Sat, 19 Jun 2021 at 01:31, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Hi Anand,
>
> On Fri, Jun 18, 2021 at 3:19 PM Anand Moon <linux.amoon@gmail.com> wrote:
> [...]
> > > I suggest dropping this patch until we know for sure if and which
> > > registers need to be updated based on the DR mode.
> >
> > Yes, I have observed this, Can you give these small changes a try?
> > With the below changes, I got the  PHY_MODE_USB_DEVICE support working.
> first of all: sorry that I have not linked my source of information previously:
> - Meson8b: [0]
> - Meson8 and Meson8m2: [1]
>
> Unfortunately I don't have any datasheet or "better documentation" of
> how the registers should be programmed.
> This is why I am a bit defensive when I am asked to change something
> there - as I simply have no way of knowing if the changes are good or
> not. I can only tell whether they're "identical" or "different" from
> what the vendor kernel does.
>
> [...]
> > +       case PHY_MODE_USB_DEVICE:
> > +       case PHY_MODE_USB_OTG:
> > +               regmap_update_bits(priv->regmap, REG_ADP_BC,
> > +                                  REG_ADP_BC_DCD_ENABLE,
> > +                                  REG_ADP_BC_DCD_ENABLE);
> > +
> > +               udelay(ACA_ENABLE_COMPLETE_TIME);
> > +
> > +               regmap_read(priv->regmap, REG_ADP_BC, &reg);
> > +               if (reg & REG_ADP_BC_ACA_PIN_FLOAT) {
> > +                       dev_warn(&phy->dev, "USB ID detect failed!\n");
> > +                       return -EINVAL;
> > +               }
> > +               regmap_update_bits(priv->regmap, REG_ADP_BC,
> > +                                  REG_ADP_BC_ID_PULLUP, REG_ADP_BC_ID_PULLUP);
> > +               break;
> According to the vendor kernel this should only be applied to
> "host-only" USB_PORT_IDX_B (which is usb1 in the mainline .dtsi).
> Based on that I think it's not correct to apply this for DEVICE and OTG modes.
>
> The vendor kernel does not configure REG_ADP_BC_ID_PULLUP anywhere.
> Also DCD_ENABLE is only ever set to 0 (while you are enabling it now), see [2].
>
> As mentioned before: all I can say about this patch is that it
> programs the registers differently than the vendor kernel does.
> From your description I am not sure if you are now getting different
> behavior on Odroid-C1 with this patch (compared to what we had
> before).
>

In order to enable USB phy we probably need to do a little bit
differently than the vendor kernel.
Yes I have observed many configuration parameters are missing.

OTG port on Odroid C1+ and Odroid C2 server two purposes
1 > It could act as USB host port.
2 > It could be used as USB power on the devices, just like Raspberry pi.
      What I meant is we need some driver code to protect the power to SbC.

So depending on the mode, it gets configured host mode or PCD mode,
I am not completely sure right now.
So I saw your work on extcon, that's the reason I would like to void
any changes PHY right now.

I observe some failures like below.
[    6.013859] dwc2 c9000000.usb: DWC OTG HCD URB Dequeue
[    6.013897] dwc2 c9000000.usb: Called usb_hcd_giveback_urb()
[    6.013902] dwc2 c9000000.usb:   urb->status = -115

Still investigating this issue,

>
> Best regards,
> Martin
>
Yes, I will go through the features for debugging in the future.
>
> [0] https://github.com/endlessm/linux-meson/blob/03393bb8e8478626e03ee93b0a2a225d6de242b5/arch/arm/mach-meson8b/usbclock.c#L120
> [1] https://github.com/endlessm/linux-meson/blob/03393bb8e8478626e03ee93b0a2a225d6de242b5/arch/arm/mach-meson8/usbclock.c#L120
> [2] https://github.com/endlessm/linux-meson/blob/d6e13c220931110fe676ede6da69fc61a7cb04b6/drivers/amlogic/usb/dwc_otg/310/dwc_otg_pcd.c#L71

Thanks
-Anand
