Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6FFF34622F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 16:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbhCWPBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 11:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbhCWPAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 11:00:49 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EBF7C061763
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 08:00:49 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id m7so11975940pgj.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 08:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x7AmA6dVL4Uomok+LQD5NOio4s5orKuHbvfqIV4hfj8=;
        b=VnsAco01vDvrufVSTj/lR+0ae5jyGdwPni3bAIkArdK82hlOCaylfx933K4b81d7gn
         xcTvvUcSKuQexyUhbi30RMiECKyp34U3TQ7Yoi4BwppSj950tljHX+K4uknVyeKeVOSy
         eqUny6sUMuiM2KuSt+GlSTUxUNbq1NZ4ZNNpcHLSKQ2v61V2e69o4e691v+bVkWVxxwt
         5c0TjhL9jSw/RsaOUQ4EaUABc1Zq7t79ztW4zGdYwide+ZJsvVuI5Rf/2Jt5ev7E1k2O
         mD8DsJcCotEzQamgZQHzvAJaZs/Wkuy5yJVyA22bi6bfcFaDVMEn3xdyclUc6DEZDkHS
         pJ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x7AmA6dVL4Uomok+LQD5NOio4s5orKuHbvfqIV4hfj8=;
        b=RnxEVkmCf57J9E6oMXJKOTbnW5/me9+tahqhSlSEajx/1++Y+pmpoZfrqnw3SZ/Qp9
         me3bfk5XmoQG7sv19QPRsLAOiWILKpyA6ZEnueQ+60mVWmoKnQDYQ4pMyphHSLOoM9EH
         7kSJ+xz6yIc12hGF+bc4fjTtqRd/8pScZWOSVZzkWh6GRFy+QAYTs/+WDPQt3sVHTD4i
         l/VzT7zIup3auiy9GVcj8hylYvtYu0xaF13vZnY8mxjCQaHyWVKuVC3EQ9l/W1HCmaWb
         nMWtTW1ArAlqfMjyAYf0moi5d5AgAG3ncl8p+yFkPxhMDy5IkP/rq6nRgTdEoLeYzCOQ
         AwEQ==
X-Gm-Message-State: AOAM531khRkYc5dJE3rtfLri+9ULnq6uWQP6CoFf1a1xqGpNFWMNPHnF
        COFEvh9lSVAWVXI9/HaBsOpZQIwHyKQPntZjTd1aIA==
X-Google-Smtp-Source: ABdhPJy7UIdeWmbcH+IFDMPFslFgqzbA2np3gsVPm4W0SPBkNK3+dviSChZ6rxLszEJgsAXA9kWd1KDprzInlizKJw8=
X-Received: by 2002:a05:6a00:b54:b029:207:2a04:7b05 with SMTP id
 p20-20020a056a000b54b02902072a047b05mr5345565pfo.12.1616511648426; Tue, 23
 Mar 2021 08:00:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210308120555.252524-1-adrien.grassein@gmail.com>
 <20210308120555.252524-3-adrien.grassein@gmail.com> <CAG3jFytoE9hWvq2e2Caqn4qP_RuEOnm4r9VQ85ffbAcguSLf+w@mail.gmail.com>
 <CABkfQAGvPy3DzXQnDJqm1q_rOLWR7BQTXb8z05iML3s3Mc8LJw@mail.gmail.com>
 <CAG3jFytmJSjvWp0Bu7MaJ7EVuJov8gbs6cguatoOtTJpXTGVLA@mail.gmail.com>
 <CABkfQAGcSsQ74FtvAK4_awHRXswgBrThKww_xhpmTzordZ5X8w@mail.gmail.com>
 <CAG3jFyvQt=Bv2_Hi8UdOhgznp1gVZwAw8gZv6FnLwHJV4WD6Kw@mail.gmail.com> <CABkfQAGS24AM90veQhGA+=V4S50y7JwzqLMspMaEFptcYpmdMQ@mail.gmail.com>
In-Reply-To: <CABkfQAGS24AM90veQhGA+=V4S50y7JwzqLMspMaEFptcYpmdMQ@mail.gmail.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Tue, 23 Mar 2021 16:00:37 +0100
Message-ID: <CAG3jFytY26tdktwE+iorKjM1EDsdAFxo9MBhxsJHoCNLSRsM_g@mail.gmail.com>
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

> > Are you saying that pin 63 never is high, or that an irq/isr routine
> > isn't getting executed?
> >
> > > When reading the value of the HPD pin, I always get 1 (and no
> > > transition occurs when plugging / unplugging a cable).
> > > The HPD IRQ is done on the HDMI connector driver [5].
> > > I think a register configuration should be done to enable the IRQ pin
> > > or maybe there is a nug in electronics.
> >
> > After looking at the documentation a bit more, I think we can ignore
> > pin63 and instead have a look at pin14. It is the HDMI TX HPD Control
> > pin. It has a 100k pull-down, so it should be active high.
>
> pin63 is always active high.
> pin14 is connected to the HDMI logic (pin 19 of the HDMI connector)
> with a 100k pull-down.

Thanks, that makes sense. pin14 is connected directly to the physical connector.

>
> >
> > I also found some different I2C addresses than what you've used, I
> > assume the device is available on both addresses.
> >
> > Chip control registers, address:0x90
> > CEC control registers, address 0x92
> >
> Strange, configuration seems to be working well with the address used
> in my driver.

Some chips support alternative addresses, I guess we can assume that
is the case here.

>
> > > The HPD pin is linked to a 2.2k pullup resistor (maybe it's wrong)
> >
> > The datasheet isn't entirely clear about if pin14 has an internal 100k
> > pull-down, or if they recommend adding a 100k pull-down.
> >
> > But this does seem like an issue.
>
> pin14 can't be used directly. I guess it's used by the internal logic
> of the chip to generate the HPD (pin63) signal.

Ack. Ok, false alert with pin14 then.

> >
> > >
> > > >
> > > > > >
> > > > > > > +
> > > > > > > +static int lt8912_probe(struct i2c_client *client,
> > > > > > > +        const struct i2c_device_id *id)
> > > > > > > +{
> > > > > > > +       static struct lt8912 *lt;
> > > > > > > +       int ret = 0;
> > > > > > > +       struct device *dev = &client->dev;
> > > > > > > +
> > > > > > > +       lt = devm_kzalloc(dev, sizeof(struct lt8912), GFP_KERNEL);
> > > > > > > +       if (!lt)
> > > > > > > +               return -ENOMEM;
> > > > > > > +
> > > > > > > +       lt->dev = dev;
> > > > > > > +       lt->i2c_client[0] = client;
> > > > > > > +       lt->cable_status = connector_status_unknown;
> > > > > > > +       lt->workq = create_workqueue("lt8912_workq");
> > > > > >
> > > > > > Looking at [1] and maybe even better [2], I think this polling
> > > > > > approach is the wrong way to go. And with access to documentation, I
> > > > > > think we should be able to sort this out.
> > > > >
> > > > > I neither like the polling approach too. I did it to go on this issue.
> > > > > I will totally remove it once the HPD issue will be resolved.
> > > > > >
> > > > > > Using the irq driver approach requires the interrupt pin to be
> > > > > > configured. Pin 63 of the lt8912b is the IRQ output pin.
> > > > > >
> > > > > > In order to trigger interrupts based on it, the dt-binding would need
> > > > > > to be updated[3][4] as well as whichever DTS you're using.
> > > > > >
> > > > >
> > > > > The IRQ part is working well in my DTB. It test it by adding some
> > > > > electronics to emulate the HPD pin on the GPIO expander where the HPD
> > > > > pin is linked.
> > > >
> > > > Looking at the dt-binding patch, it does not seem to list any
> > > > interrupts. So that should be added. I think the irq support from [3]
> > > > & [4] can be pretty much copied.
> > > >
> > > > Then we can come back and replace the polling code with the IRQ driven
> > > > code from [2].
> > >
> > > My board uses a "max7323" GPIO expander and the HPD pin is linked to it.
> > > I test this GPIO expander by soldering a pull up resistor and an
> > > interrupt on it and an interrupt was correctly triggered in both
> > > max7323 driver and hdmi-connector;
> > > So I guess that my DTB configuration is correct.
> > > I made my DBT configuration available:
> > >   - hdmi-connector node: [6]
> > >   - lt8912b node: |7]
> > >   - max7323 node: [8].
> >
> > Looking at [7] I think that you would want to add something like:
> >
> > hdmi-bridge@48 {
> >         interrupts-extended = <&max7323 $LT8912B_PIN_14 IRQ_TYPE_EDGE_RISING>;
> > }

Ok, so pin63 is the output from lt8912b we should be listening to.
And looking at lt9611 it seems to be low=active, so IRQ_TYPE_EDGE_FALLING.

         interrupts-extended = <&max7323 $LT8912B_PIN_63 IRQ_TYPE_EDGE_FALLING>;


> >
> > And of course add the corresponding parts from [2] and [3].
> >
> > >
> > >
> > > >
> > > > >
> > > > > >
> > > > > > [1] https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/bridge/analogix/anx7625.c#L1751
> > > > > >
> > > > > > [2] https://github.com/torvalds/linux/blob/v5.11/drivers/gpu/drm/bridge/lontium-lt9611.c#L1160
> > > > > >
> > > > > > [3] https://github.com/torvalds/linux/blob/v5.11/Documentation/devicetree/bindings/display/bridge/lontium,lt9611.yaml#L27
> > > > > >
> > > > > > [4] https://github.com/torvalds/linux/blob/v5.11/Documentation/devicetree/bindings/display/bridge/lontium,lt9611.yaml#L144
> > >
> > > [5] https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/bridge/display-connector.c#L199
> > > [6] https://github.com/grassead/linux-next/blob/master/arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts#L37
> > > [7] https://github.com/grassead/linux-next/blob/master/arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts#L249
> > > [8] https://github.com/grassead/linux-next/blob/master/arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts#L291
> > >
> > >
> > > Thanks,
>
> Maybe the conclusion is that we cannot have the HPD working.

If we can read bit7 @ 0xC1, all that we are missing is getting the
interrupt to fire after a HPD event.
