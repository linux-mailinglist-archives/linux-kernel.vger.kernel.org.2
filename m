Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93C3C3AD34F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 22:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232792AbhFRUD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 16:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbhFRUD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 16:03:56 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26147C061574
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 13:01:46 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id w21so10169081edv.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 13:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6QTjBFDFCa5wxgzXV7/ZQNMNegFSSiirJH3DOi2Mowg=;
        b=U4p6NUo6NxmDTnbo2R00GUSqOPKE+qjZt8Klk6p9jMVaMwcujnDAhKDocwfnPzjfJa
         7g7w/VxyBj/G+S2lqjPNd6lGwHp+FU2Y5YP4kz3a1mSzGjEodtZYT0xRNXqcrcl0Yfbh
         4DIUFApCND6+hnkPtPI4EX3/vYFjEr9GZqkub0TOYThSX2LFzdV1N/Z2jWVwxZRff5KA
         CsLl3WMtOMbXaUpK4GcJAr0ade4BluXa7DFCladX8l9jkgHBncxIm0YbcCQbfN1EBXZL
         HOBjx9yl9ur6YHWnH+V4yYyeIY0kzAKwZ8bLmxcUQ5Gbp9KDiwLdv7YlVywxo0jogVlQ
         PpPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6QTjBFDFCa5wxgzXV7/ZQNMNegFSSiirJH3DOi2Mowg=;
        b=r2ApAgIcaPe3yFyegFGDWy5fDssUHFUWptgGOqjkRNJiuQ8Gg+hp/9aAgSUkil8VwQ
         SQOx3czBYdieX/AiM8jeH3Wy/HBrK15UfETdBlr03QLmrsFyUGBK/xeF0JjntJU6KfVx
         8BXJUt88Rg/HGVotvaVTudSqqgIwxs2XfX8HtFh8gLTNWqZ91Un4rl0QnktM8fyOALvP
         8rOKxDBGs+x+LWmSp7B/JvuPtRFA9u9bKsPnu68PeGFirr1cGrAat/IjKq+piL8o7RrF
         LyJcu9l/eX4jQ3TRBJ90XEevdblWIHmKXQv3UIycvLWhPoxzvBkCn38ZQA9UXEhUwxvc
         2C7A==
X-Gm-Message-State: AOAM533Kjxuhi252JfBcGMkdwd8YIVqVGwmxquWwFXwZRsKwCVAP9qDQ
        H5550NvQhFlNzq+XOimk3n/57idTgjzdbkKKAr8=
X-Google-Smtp-Source: ABdhPJxohO1/4OynRMCvyD6kNQVy6NdX8sknWeZm6xSBJ9r5JVQ2eHpMXAwyt9cYBeaA1M2EVrmvSxABcvi/4z9tMjc=
X-Received: by 2002:a05:6402:3581:: with SMTP id y1mr7253865edc.143.1624046504688;
 Fri, 18 Jun 2021 13:01:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210617194154.2397-1-linux.amoon@gmail.com> <20210617194154.2397-5-linux.amoon@gmail.com>
 <CAFBinCB1rrmJ5=M0tSGS_47BarFcrs2Kz5qFzrHw8+OEYxX3DA@mail.gmail.com> <CANAwSgQVgKUoTpfaJyfxdphqc6M=Oq6jj5zZ7An9St7PdzQHYA@mail.gmail.com>
In-Reply-To: <CANAwSgQVgKUoTpfaJyfxdphqc6M=Oq6jj5zZ7An9St7PdzQHYA@mail.gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 18 Jun 2021 22:01:33 +0200
Message-ID: <CAFBinCDpQybqD96CCMBDKYUXEYCABr0QMfxFH1AWrXP12UxxMg@mail.gmail.com>
Subject: Re: [RFCv1 4/8] phy: amlogic: meson8b-usb2: Use phy set_mode callback function
To:     Anand Moon <linux.amoon@gmail.com>
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

Hi Anand,

On Fri, Jun 18, 2021 at 3:19 PM Anand Moon <linux.amoon@gmail.com> wrote:
[...]
> > I suggest dropping this patch until we know for sure if and which
> > registers need to be updated based on the DR mode.
>
> Yes, I have observed this, Can you give these small changes a try?
> With the below changes, I got the  PHY_MODE_USB_DEVICE support working.
first of all: sorry that I have not linked my source of information previously:
- Meson8b: [0]
- Meson8 and Meson8m2: [1]

Unfortunately I don't have any datasheet or "better documentation" of
how the registers should be programmed.
This is why I am a bit defensive when I am asked to change something
there - as I simply have no way of knowing if the changes are good or
not. I can only tell whether they're "identical" or "different" from
what the vendor kernel does.

[...]
> +       case PHY_MODE_USB_DEVICE:
> +       case PHY_MODE_USB_OTG:
> +               regmap_update_bits(priv->regmap, REG_ADP_BC,
> +                                  REG_ADP_BC_DCD_ENABLE,
> +                                  REG_ADP_BC_DCD_ENABLE);
> +
> +               udelay(ACA_ENABLE_COMPLETE_TIME);
> +
> +               regmap_read(priv->regmap, REG_ADP_BC, &reg);
> +               if (reg & REG_ADP_BC_ACA_PIN_FLOAT) {
> +                       dev_warn(&phy->dev, "USB ID detect failed!\n");
> +                       return -EINVAL;
> +               }
> +               regmap_update_bits(priv->regmap, REG_ADP_BC,
> +                                  REG_ADP_BC_ID_PULLUP, REG_ADP_BC_ID_PULLUP);
> +               break;
According to the vendor kernel this should only be applied to
"host-only" USB_PORT_IDX_B (which is usb1 in the mainline .dtsi).
Based on that I think it's not correct to apply this for DEVICE and OTG modes.

The vendor kernel does not configure REG_ADP_BC_ID_PULLUP anywhere.
Also DCD_ENABLE is only ever set to 0 (while you are enabling it now), see [2].

As mentioned before: all I can say about this patch is that it
programs the registers differently than the vendor kernel does.
From your description I am not sure if you are now getting different
behavior on Odroid-C1 with this patch (compared to what we had
before).


Best regards,
Martin


[0] https://github.com/endlessm/linux-meson/blob/03393bb8e8478626e03ee93b0a2a225d6de242b5/arch/arm/mach-meson8b/usbclock.c#L120
[1] https://github.com/endlessm/linux-meson/blob/03393bb8e8478626e03ee93b0a2a225d6de242b5/arch/arm/mach-meson8/usbclock.c#L120
[2] https://github.com/endlessm/linux-meson/blob/d6e13c220931110fe676ede6da69fc61a7cb04b6/drivers/amlogic/usb/dwc_otg/310/dwc_otg_pcd.c#L71
