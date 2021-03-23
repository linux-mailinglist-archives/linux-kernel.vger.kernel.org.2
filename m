Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46CF0346107
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 15:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232147AbhCWOIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 10:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232172AbhCWOHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 10:07:54 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD1FC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 07:07:53 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id il9-20020a17090b1649b0290114bcb0d6c2so4945471pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 07:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y5suZ7MtFQiO2esuDP6fUstvejIt/3DWj5wCdeiJAXE=;
        b=PTwjgnJk3BXf+py1vygtF934nMvUyIv/iPhrAV9dGFGXoB+KFQnFjHl7pPFUQ1At2S
         tqMmns1H1w2/bo7YGJGnkJ2Jjd3wxf/L2HoBEl/W2PDepsVQDIASeRrAJCjcUr8aQyY7
         rM0CnlpBNqKAjmwB6oam79Pv3i3kkup0JrYRPVTwIJ7/0XiaUvqJb/Q3IeCk5tTCENG7
         EMo/s0PXZDYqFI+4evzTrh+QcH8uG+7abEDt3+lc6+0j5nOUNrLlH3Hc5BoCSn/R8271
         96ZHWU7GGGOL7v9eSUZHLVQ46yUEiQuuvCUIVMAY3+WY7vY4prHie7t+Xc/ibHLgqhVX
         /WCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y5suZ7MtFQiO2esuDP6fUstvejIt/3DWj5wCdeiJAXE=;
        b=i8v1fvGtTOOo+icrXlLIrCBnXHIGNifAeexhV/SPl9jg2Id5RMBNr1Bzd3LL4pQ/tJ
         cM0gpF1VkmB7YTBrGRKoHDb6vTZzl2fATUGic05M8iW6W8AC3gobvdfhJZmfO7Qojk7E
         mNxIJLCM+Pi0u21+1FZdQqaJLg6IbtvvTzkCCkrfOkYJo+7uTmibyVUw+MAGsSwH/YYQ
         JyZji5ULI7Whb/NZp40YsziP8eA6r0sTZO1jd8zReavnSWXVaNTQhBKk5mVucbk1dAPl
         dFyiyWlvlxywgk2RhH4F28zulbys6z+qjJdPRXcOQVjiN7N1Od4TEZqfxmTR5mk0jXq4
         OMrQ==
X-Gm-Message-State: AOAM532H+8VMt66faa0f08ADTEDKYR3klS9ddukV5NsZn9/lykVfeE7n
        ynGLX/2b86xYRHv0ibsFIbB/cbHoFh9Ylxgc4n/LCQ==
X-Google-Smtp-Source: ABdhPJxuC7iyBO75to72eg1dtT8fn/Wy5EQ8iTyPWPxiku7f7zskF65BXpl8o6+s0GrDzoATrmKJZI7XvGTjvMqa9g4=
X-Received: by 2002:a17:90a:516:: with SMTP id h22mr4483088pjh.222.1616508473133;
 Tue, 23 Mar 2021 07:07:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210308120555.252524-1-adrien.grassein@gmail.com>
 <20210308120555.252524-3-adrien.grassein@gmail.com> <CAG3jFytoE9hWvq2e2Caqn4qP_RuEOnm4r9VQ85ffbAcguSLf+w@mail.gmail.com>
 <CABkfQAGvPy3DzXQnDJqm1q_rOLWR7BQTXb8z05iML3s3Mc8LJw@mail.gmail.com>
 <CAG3jFytmJSjvWp0Bu7MaJ7EVuJov8gbs6cguatoOtTJpXTGVLA@mail.gmail.com> <CABkfQAGcSsQ74FtvAK4_awHRXswgBrThKww_xhpmTzordZ5X8w@mail.gmail.com>
In-Reply-To: <CABkfQAGcSsQ74FtvAK4_awHRXswgBrThKww_xhpmTzordZ5X8w@mail.gmail.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Tue, 23 Mar 2021 15:07:42 +0100
Message-ID: <CAG3jFyvQt=Bv2_Hi8UdOhgznp1gVZwAw8gZv6FnLwHJV4WD6Kw@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] drm/bridge: Introduce LT8912B DSI to HDMI bridge
To:     Adrien Grassein <adrien.grassein@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > >
> > > > > +static enum drm_connector_status lt8912_check_cable_status(struct lt8912 *lt)
> > > > > +{
> > > > > +       int ret;
> > > > > +       unsigned int reg_val;
> > > > > +
> > > > > +       ret = regmap_read(lt->regmap[I2C_MAIN], 0xC1, &reg_val);
> > > > > +       if (ret)
> > > > > +               return connector_status_unknown;
> > > > > +
> > > > > +       if (reg_val & BIT(7))
> > > > > +               return connector_status_connected;
> > > >
> > > > Register 0xc0 & BIT(7) - HPD signal after debounce
> > > > Register 0xc0 & BIT(6) - HPD signal for TX HPD pad
> > >
> > > So, if I understand well, I need to write 0xc0 & BIT(6) with 1 to
> > > enable the HPD pin.
> >
> > Ah, sorry about being a bit terse.
> >
> > Both bit 6 & 7 are read only, and are probably best read after an IRQ.
>
> In my case, IRQ is not triggered at all.

Are you saying that pin 63 never is high, or that an irq/isr routine
isn't getting executed?

> When reading the value of the HPD pin, I always get 1 (and no
> transition occurs when plugging / unplugging a cable).
> The HPD IRQ is done on the HDMI connector driver [5].
> I think a register configuration should be done to enable the IRQ pin
> or maybe there is a nug in electronics.

After looking at the documentation a bit more, I think we can ignore
pin63 and instead have a look at pin14. It is the HDMI TX HPD Control
pin. It has a 100k pull-down, so it should be active high.

I also found some different I2C addresses than what you've used, I
assume the device is available on both addresses.

Chip control registers, address:0x90
CEC control registers, address 0x92

> The HPD pin is linked to a 2.2k pullup resistor (maybe it's wrong)

The datasheet isn't entirely clear about if pin14 has an internal 100k
pull-down, or if they recommend adding a 100k pull-down.

But this does seem like an issue.

>
> >
> > > >
> > > > > +
> > > > > +static int lt8912_probe(struct i2c_client *client,
> > > > > +        const struct i2c_device_id *id)
> > > > > +{
> > > > > +       static struct lt8912 *lt;
> > > > > +       int ret = 0;
> > > > > +       struct device *dev = &client->dev;
> > > > > +
> > > > > +       lt = devm_kzalloc(dev, sizeof(struct lt8912), GFP_KERNEL);
> > > > > +       if (!lt)
> > > > > +               return -ENOMEM;
> > > > > +
> > > > > +       lt->dev = dev;
> > > > > +       lt->i2c_client[0] = client;
> > > > > +       lt->cable_status = connector_status_unknown;
> > > > > +       lt->workq = create_workqueue("lt8912_workq");
> > > >
> > > > Looking at [1] and maybe even better [2], I think this polling
> > > > approach is the wrong way to go. And with access to documentation, I
> > > > think we should be able to sort this out.
> > >
> > > I neither like the polling approach too. I did it to go on this issue.
> > > I will totally remove it once the HPD issue will be resolved.
> > > >
> > > > Using the irq driver approach requires the interrupt pin to be
> > > > configured. Pin 63 of the lt8912b is the IRQ output pin.
> > > >
> > > > In order to trigger interrupts based on it, the dt-binding would need
> > > > to be updated[3][4] as well as whichever DTS you're using.
> > > >
> > >
> > > The IRQ part is working well in my DTB. It test it by adding some
> > > electronics to emulate the HPD pin on the GPIO expander where the HPD
> > > pin is linked.
> >
> > Looking at the dt-binding patch, it does not seem to list any
> > interrupts. So that should be added. I think the irq support from [3]
> > & [4] can be pretty much copied.
> >
> > Then we can come back and replace the polling code with the IRQ driven
> > code from [2].
>
> My board uses a "max7323" GPIO expander and the HPD pin is linked to it.
> I test this GPIO expander by soldering a pull up resistor and an
> interrupt on it and an interrupt was correctly triggered in both
> max7323 driver and hdmi-connector;
> So I guess that my DTB configuration is correct.
> I made my DBT configuration available:
>   - hdmi-connector node: [6]
>   - lt8912b node: |7]
>   - max7323 node: [8].

Looking at [7] I think that you would want to add something like:

hdmi-bridge@48 {
        interrupts-extended = <&max7323 $LT8912B_PIN_14 IRQ_TYPE_EDGE_RISING>;
}

And of course add the corresponding parts from [2] and [3].

>
>
> >
> > >
> > > >
> > > > [1] https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/bridge/analogix/anx7625.c#L1751
> > > >
> > > > [2] https://github.com/torvalds/linux/blob/v5.11/drivers/gpu/drm/bridge/lontium-lt9611.c#L1160
> > > >
> > > > [3] https://github.com/torvalds/linux/blob/v5.11/Documentation/devicetree/bindings/display/bridge/lontium,lt9611.yaml#L27
> > > >
> > > > [4] https://github.com/torvalds/linux/blob/v5.11/Documentation/devicetree/bindings/display/bridge/lontium,lt9611.yaml#L144
>
> [5] https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/bridge/display-connector.c#L199
> [6] https://github.com/grassead/linux-next/blob/master/arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts#L37
> [7] https://github.com/grassead/linux-next/blob/master/arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts#L249
> [8] https://github.com/grassead/linux-next/blob/master/arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts#L291
>
>
> Thanks,
