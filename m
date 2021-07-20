Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6153D044C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 00:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbhGTV3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 17:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbhGTV2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 17:28:30 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164A3C061766;
        Tue, 20 Jul 2021 15:09:08 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id hd33so208539ejc.9;
        Tue, 20 Jul 2021 15:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9yBLdY7KHxHrlVOjcFhT5on4b0ty5A/PIQKOp8H8sX0=;
        b=Of5GcmXFYsBBYYwA+L8dlDsyNx8xmE73+coBwK7Tw+ci53/8kYSkvDkgDDBRPbvyD1
         0Y3KxVY3h8Ae1p59bRAC1yUmonHZ5rnN6/Sv/YVJKpZ0SqsjgggRL00pHg2vTcV7sQBq
         NsBOB5rILAoCNQ0Drn1vV7yp0ZvzJ4FlrPbxh5Wzkfw3KeiR3CaX11xjlW32LxDurc71
         sZfeRDl6D/eOd3oDJK/hN2Cutp385DgIaBoZij79Kt9UzWdj5pKJfEx8TI1pVZ3NAH4o
         3qiGNMZj2w3aRlz0w6JNxGBbSyaW6/Bo5Z8q8ar9LdgBYbGAqbZkYSwye+Jr3I7fB6dR
         0+EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9yBLdY7KHxHrlVOjcFhT5on4b0ty5A/PIQKOp8H8sX0=;
        b=XkQKDtTjPZxQF+Do0paWLalu+rHYGmt5wOiR//qlBr/3bpo04BGRtz1ALxYzg+dBWB
         rwyEzHCWSs/9klsgsNDHmNGadMf0E0mUgK2fbQ/v8t9HfVqoynEJpuZmTjemiLWIYYK0
         CIY9l5txXxYwPGH9NGCoe0zt5W1xAg9WZ8uu1IHSYgbwkknbez8w90mbaMYLH9aoOFlQ
         PpM6RGJk8sJi+MV2WVnFMT82lXipmdNabsN2kaqMBefYGNCoq/IDjSaZ9Tn5JT3Cfc/5
         NvXuMQ0PFZZ9+rU6wU7itaZtW0FC0ox/iPg3y7wXhbT7WweD77LzauZ196nKN1TmwBM8
         MAdQ==
X-Gm-Message-State: AOAM533tf+bzPOEbRy51gcQGHH+JxVMohhQ84r3w1/4IAic83w/9oH2x
        nzVhSu0sHY9COcufcYPZ57VNbOrRXXsZKAtH+FM=
X-Google-Smtp-Source: ABdhPJwqJT12MjIkIm+nGR/6gUPI783Xejf4KnzDG/n9SAhxLQdAmS4aC0+kTR5vSb9DzeZdy4c9V3+Qx+c6osjThL8=
X-Received: by 2002:a17:906:53d1:: with SMTP id p17mr35539038ejo.208.1626818946563;
 Tue, 20 Jul 2021 15:09:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210629182047.893415-1-martin.blumenstingl@googlemail.com>
 <20210629182047.893415-3-martin.blumenstingl@googlemail.com> <YPaLKwEKcDLWwztM@matsya>
In-Reply-To: <YPaLKwEKcDLWwztM@matsya>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Wed, 21 Jul 2021 00:08:55 +0200
Message-ID: <CAFBinCCJ5DjvjkfjYg7SveDB0bvJ-XV6BwcF_yEeUqxRN9awiQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] phy: amlogic: Add a new driver for the HDMI TX PHY
 on Meson8/8b/8m2
To:     Vinod Koul <vkoul@kernel.org>
Cc:     robh+dt@kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        kishon@ti.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

On Tue, Jul 20, 2021 at 10:37 AM Vinod Koul <vkoul@kernel.org> wrote:
[...]
> > +     if (clk_get_rate(priv->tmds_clk) >= 2970UL * 1000 * 1000)
> > +             hdmi_ctl0 = 0x1e8b;
> > +     else
> > +             hdmi_ctl0 = 0x4d0b;
>
> magic numbers..? I guess these are register offsets, would be better to
> define..
Unfortunately these are register values, not offsets
The only "documentation" I have is:
- documentation for the bits/bit-fields in these registers [0]
- some reference code with magic values from the vendor BSP: [1]

HDMI_CTL0/HDMI_CTL1 (the names from the datasheet) is not very
specific and I could not find any other explanation on what the values
mean.
That's why I cannot offer more than these magic values (same situation
for your finding below).

[...]
> > +     ret = device_property_read_u32_array(&pdev->dev, "reg", reg,
> > +                                          ARRAY_SIZE(reg));
>
> we have reg as single property, why array with 2 entries here?
My thought when Rob requested a "reg" property in the dt-bindings was
that I should use offset and size.
I am not validating the size here, which would be in reg[1].
If it's fine for Rob as well then I'll switch the dt-bindings to just
have the offset inside the reg property.

[...]
> > +static const struct of_device_id phy_meson8_hdmi_tx_of_match[] = {
> > +     { .compatible = "amlogic,meson8-hdmi-tx-phy" },
> > +     { .compatible = "amlogic,meson8b-hdmi-tx-phy" },
> > +     { .compatible = "amlogic,meson8m2-hdmi-tx-phy" },
> > +     { /* sentinel */ }
>
> I see that all three are handled similarly, no difference!
So far this is correct, they're all treated the same.
However, it happened to me (multiple times) in the past that later on
I would spot a difference hidden in the vendor BSP.
One example is commit f004be596c28f9 ("phy: amlogic: meson8b-usb2: Add
a compatible string for Meson8m2").
I know that other parts of the graphics pipeline are different on
Meson8 compared to the other two SoCs (because Meson8b/Meson8m2 have
some reset lines which need to be toggled after updating the video
clocks. these resets don't exist on Meson8).
So I decided to play safe and add compatible strings for every SoC so
I can easily handle any differences in the future (in case I find
any).


Best regards,
Martin


[0] https://dn.odroid.com/S805/Datasheet/S805_Datasheet%20V0.8%2020150126.pdf
[1] https://github.com/endlessm/linux-meson/blob/d6e13c220931110fe676ede6da69fc61a7cb04b6/arch/arm/mach-meson8/hdmi_tx_hw/hdmi_tx_hw.c#L2350-L2381
