Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14EC6346145
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 15:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbhCWOSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 10:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbhCWOQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 10:16:27 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC928C061765;
        Tue, 23 Mar 2021 07:16:22 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id l4so27347549ejc.10;
        Tue, 23 Mar 2021 07:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MlOooBXSewsLualNMgvU6D6sRFXHNUQ608epm4QPvWs=;
        b=K6BNGvZE4HLcVpDQArNpA/XFtjuJcUNCbBXwd5VC/WYL8x1S6irIL+c6wRlJzU6vl4
         nxHShgvd5SESFS+yvIZR5iGl8D5qzSHsyf9Q0lfypAQhTYo8UR35gu6tuotjRLHyvVtl
         VdhidD4P+skXtaVujXXEMg1GjBvVnsK/cCYhfA8kZ6q6d7ZBuWn5h57ZfqZJ9ct6mPyr
         513IKg5Yp9Q/GaFyflvxz5zuFY4KI9/ajF0XLuiRe6wj09+3GSAzj41RMOUFwU301OJx
         R4BxhDhguT/ew75EwTIVu8Ou5N4JxzQo6y4/4j/CFtuJqctB+5NmvV8wB2ed+Ye8JyMh
         0IZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MlOooBXSewsLualNMgvU6D6sRFXHNUQ608epm4QPvWs=;
        b=lrgBX2mQwYtCEK95sjefS1PEHv41PjZ9qhv/Nvrmh26lZGVka/g2Di1QVsLMUB/uI7
         PlUqaL9aon5edEYeWz1LjcJKX1KQVtNKRkjQSuwY9S+wmUV62+IozMf/MZYn5GSWouKS
         B8ldMAoJ7u2PI/lMPx64vfPGUVQlVhjJlDtjs3jLnxGcomFGJvcWtad2dlpFbqvoLKZn
         /PZUY1+febQaTrlYyJffdzWeh7KtCrC6O09uuivPTpodLryVbFDGH6fhk5ddp0tQZDoz
         UBZS7FphNcxXwHnDCjcpu9yqjsTNoKAW7AWpCIKBlstLxscTRVap0NfHOIUAOfgWECd4
         bgKA==
X-Gm-Message-State: AOAM531Ok6bA0j1XUDC64OePU6rnRVn3ltKvQDA/B8uTE0dhNluN+rmz
        MQHXuoKkHGnt9EPcmNFiE0hLtYZHAv2/pV4LwqY=
X-Google-Smtp-Source: ABdhPJwj/plMO91rQ93L+RbYk+zwPDyZuqAWjLpcugqv3a8iDsleVbcDFezMkCTAwZZ2q4REVXVVyQK8ZLqJtOp5GhA=
X-Received: by 2002:a17:907:7785:: with SMTP id ky5mr4965121ejc.133.1616508981333;
 Tue, 23 Mar 2021 07:16:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210308120555.252524-1-adrien.grassein@gmail.com>
 <20210308120555.252524-3-adrien.grassein@gmail.com> <CAG3jFytoE9hWvq2e2Caqn4qP_RuEOnm4r9VQ85ffbAcguSLf+w@mail.gmail.com>
 <CABkfQAGvPy3DzXQnDJqm1q_rOLWR7BQTXb8z05iML3s3Mc8LJw@mail.gmail.com>
 <CAG3jFytmJSjvWp0Bu7MaJ7EVuJov8gbs6cguatoOtTJpXTGVLA@mail.gmail.com>
 <CABkfQAGcSsQ74FtvAK4_awHRXswgBrThKww_xhpmTzordZ5X8w@mail.gmail.com> <CAG3jFyvQt=Bv2_Hi8UdOhgznp1gVZwAw8gZv6FnLwHJV4WD6Kw@mail.gmail.com>
In-Reply-To: <CAG3jFyvQt=Bv2_Hi8UdOhgznp1gVZwAw8gZv6FnLwHJV4WD6Kw@mail.gmail.com>
From:   Adrien Grassein <adrien.grassein@gmail.com>
Date:   Tue, 23 Mar 2021 15:16:10 +0100
Message-ID: <CABkfQAGS24AM90veQhGA+=V4S50y7JwzqLMspMaEFptcYpmdMQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] drm/bridge: Introduce LT8912B DSI to HDMI bridge
To:     Robert Foss <robert.foss@linaro.org>
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
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mar. 23 mars 2021 =C3=A0 15:07, Robert Foss <robert.foss@linaro.org> a =
=C3=A9crit :
>
> > > > >
> > > > > > +static enum drm_connector_status lt8912_check_cable_status(str=
uct lt8912 *lt)
> > > > > > +{
> > > > > > +       int ret;
> > > > > > +       unsigned int reg_val;
> > > > > > +
> > > > > > +       ret =3D regmap_read(lt->regmap[I2C_MAIN], 0xC1, &reg_va=
l);
> > > > > > +       if (ret)
> > > > > > +               return connector_status_unknown;
> > > > > > +
> > > > > > +       if (reg_val & BIT(7))
> > > > > > +               return connector_status_connected;
> > > > >
> > > > > Register 0xc0 & BIT(7) - HPD signal after debounce
> > > > > Register 0xc0 & BIT(6) - HPD signal for TX HPD pad
> > > >
> > > > So, if I understand well, I need to write 0xc0 & BIT(6) with 1 to
> > > > enable the HPD pin.
> > >
> > > Ah, sorry about being a bit terse.
> > >
> > > Both bit 6 & 7 are read only, and are probably best read after an IRQ=
.
> >
> > In my case, IRQ is not triggered at all.
>
> Are you saying that pin 63 never is high, or that an irq/isr routine
> isn't getting executed?
>
> > When reading the value of the HPD pin, I always get 1 (and no
> > transition occurs when plugging / unplugging a cable).
> > The HPD IRQ is done on the HDMI connector driver [5].
> > I think a register configuration should be done to enable the IRQ pin
> > or maybe there is a nug in electronics.
>
> After looking at the documentation a bit more, I think we can ignore
> pin63 and instead have a look at pin14. It is the HDMI TX HPD Control
> pin. It has a 100k pull-down, so it should be active high.

pin63 is always active high.
pin14 is connected to the HDMI logic (pin 19 of the HDMI connector)
with a 100k pull-down.

>
> I also found some different I2C addresses than what you've used, I
> assume the device is available on both addresses.
>
> Chip control registers, address:0x90
> CEC control registers, address 0x92
>
Strange, configuration seems to be working well with the address used
in my driver.

> > The HPD pin is linked to a 2.2k pullup resistor (maybe it's wrong)
>
> The datasheet isn't entirely clear about if pin14 has an internal 100k
> pull-down, or if they recommend adding a 100k pull-down.
>
> But this does seem like an issue.

pin14 can't be used directly. I guess it's used by the internal logic
of the chip to generate the HPD (pin63) signal.
>
> >
> > >
> > > > >
> > > > > > +
> > > > > > +static int lt8912_probe(struct i2c_client *client,
> > > > > > +        const struct i2c_device_id *id)
> > > > > > +{
> > > > > > +       static struct lt8912 *lt;
> > > > > > +       int ret =3D 0;
> > > > > > +       struct device *dev =3D &client->dev;
> > > > > > +
> > > > > > +       lt =3D devm_kzalloc(dev, sizeof(struct lt8912), GFP_KER=
NEL);
> > > > > > +       if (!lt)
> > > > > > +               return -ENOMEM;
> > > > > > +
> > > > > > +       lt->dev =3D dev;
> > > > > > +       lt->i2c_client[0] =3D client;
> > > > > > +       lt->cable_status =3D connector_status_unknown;
> > > > > > +       lt->workq =3D create_workqueue("lt8912_workq");
> > > > >
> > > > > Looking at [1] and maybe even better [2], I think this polling
> > > > > approach is the wrong way to go. And with access to documentation=
, I
> > > > > think we should be able to sort this out.
> > > >
> > > > I neither like the polling approach too. I did it to go on this iss=
ue.
> > > > I will totally remove it once the HPD issue will be resolved.
> > > > >
> > > > > Using the irq driver approach requires the interrupt pin to be
> > > > > configured. Pin 63 of the lt8912b is the IRQ output pin.
> > > > >
> > > > > In order to trigger interrupts based on it, the dt-binding would =
need
> > > > > to be updated[3][4] as well as whichever DTS you're using.
> > > > >
> > > >
> > > > The IRQ part is working well in my DTB. It test it by adding some
> > > > electronics to emulate the HPD pin on the GPIO expander where the H=
PD
> > > > pin is linked.
> > >
> > > Looking at the dt-binding patch, it does not seem to list any
> > > interrupts. So that should be added. I think the irq support from [3]
> > > & [4] can be pretty much copied.
> > >
> > > Then we can come back and replace the polling code with the IRQ drive=
n
> > > code from [2].
> >
> > My board uses a "max7323" GPIO expander and the HPD pin is linked to it=
.
> > I test this GPIO expander by soldering a pull up resistor and an
> > interrupt on it and an interrupt was correctly triggered in both
> > max7323 driver and hdmi-connector;
> > So I guess that my DTB configuration is correct.
> > I made my DBT configuration available:
> >   - hdmi-connector node: [6]
> >   - lt8912b node: |7]
> >   - max7323 node: [8].
>
> Looking at [7] I think that you would want to add something like:
>
> hdmi-bridge@48 {
>         interrupts-extended =3D <&max7323 $LT8912B_PIN_14 IRQ_TYPE_EDGE_R=
ISING>;
> }
>
> And of course add the corresponding parts from [2] and [3].
>
> >
> >
> > >
> > > >
> > > > >
> > > > > [1] https://github.com/torvalds/linux/blob/master/drivers/gpu/drm=
/bridge/analogix/anx7625.c#L1751
> > > > >
> > > > > [2] https://github.com/torvalds/linux/blob/v5.11/drivers/gpu/drm/=
bridge/lontium-lt9611.c#L1160
> > > > >
> > > > > [3] https://github.com/torvalds/linux/blob/v5.11/Documentation/de=
vicetree/bindings/display/bridge/lontium,lt9611.yaml#L27
> > > > >
> > > > > [4] https://github.com/torvalds/linux/blob/v5.11/Documentation/de=
vicetree/bindings/display/bridge/lontium,lt9611.yaml#L144
> >
> > [5] https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/bridg=
e/display-connector.c#L199
> > [6] https://github.com/grassead/linux-next/blob/master/arch/arm64/boot/=
dts/freescale/imx8mq-nitrogen.dts#L37
> > [7] https://github.com/grassead/linux-next/blob/master/arch/arm64/boot/=
dts/freescale/imx8mq-nitrogen.dts#L249
> > [8] https://github.com/grassead/linux-next/blob/master/arch/arm64/boot/=
dts/freescale/imx8mq-nitrogen.dts#L291
> >
> >
> > Thanks,

Maybe the conclusion is that we cannot have the HPD working.

Thanks,
