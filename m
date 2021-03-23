Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34C943461A2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 15:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232271AbhCWOju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 10:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232114AbhCWOjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 10:39:46 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8912C061574;
        Tue, 23 Mar 2021 07:39:45 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a7so27492989ejs.3;
        Tue, 23 Mar 2021 07:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=V6TF0pCFzbOODVjdLf1LtgnKym8Qtx42MSS/T18zWtA=;
        b=Qj6G9MQJ20s2swVq31gWGifZ4ST/lWgnfE31e3AMWI6xsZz67EeW+MdYM77OBtRpEF
         HijGtai7Vi5ceFEW9G2KFTlV4d0NODmDH8qXWmuwYKywWYJJrEhNEYkJ3xzBmc175Yus
         9x6e0IXVI+aMx2O0zELlS4IwNtjQo+GSs+On9wOQKpidVRFk+BQrHJnebBrd4ovBnW1q
         7m252U7ux9yNgvO01EMiPtyl5EvuI/wfZPMECym5u+tu60dpETa1LWYHMK82TeCwQ/a0
         8zgGZBd1GfgXanoBvdvzOR7OTgZo7LA6Jak6NTj0YkZM/ubkGg1vNLEKRYx63wQ8tcfW
         O+qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=V6TF0pCFzbOODVjdLf1LtgnKym8Qtx42MSS/T18zWtA=;
        b=mJZXtw4KO8l+/n/YjdUygAZ+MZUDY+vfCvsIL6TRzrqcrm02k5Arg2gRqUzZg1RgJv
         Fck3K80KoT2qfcF+CPui/Ae67DcoOPmJRvaI6+D6Cpr046NZQreUb83NqjhmENB4N/H6
         xvJVUBBZwox13Bk0urKwNeOR8q1VEcOTg+u769KVkrEtOPeDLpv0zzGyfwOY3Gv6/5G9
         wKT9xNG5SiBeBsJqwou9QXUUFfYB3QxfYhOeTGRxvzkrg7NYqS15wrQZkWP2cVbO2b0X
         R3vp5WDjr7PPkZJneh2m9t+PduSukodwugccPtJ/bQCmvI7ZmiVFfvepBb2ZyFvADBB9
         UxeA==
X-Gm-Message-State: AOAM530QAHUCN1WOIkKRNI8jj4KVrXUFWltEh/jqGOn2WV5Iz3EEP3t7
        au896RrSckkjXVqdpS+/4aFUqBKVppG7pJkx+I8=
X-Google-Smtp-Source: ABdhPJykr1xWsHhljU7ES9RLM0hfp2kdeFsTvzaTdor+FCKiEu0eXUhn2KBkvcxPEuP/McdKR1Nmqz171MxOKh3to1s=
X-Received: by 2002:a17:906:7946:: with SMTP id l6mr5147856ejo.500.1616510384472;
 Tue, 23 Mar 2021 07:39:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210308120555.252524-1-adrien.grassein@gmail.com>
 <20210308120555.252524-3-adrien.grassein@gmail.com> <CAG3jFytoE9hWvq2e2Caqn4qP_RuEOnm4r9VQ85ffbAcguSLf+w@mail.gmail.com>
 <CABkfQAGvPy3DzXQnDJqm1q_rOLWR7BQTXb8z05iML3s3Mc8LJw@mail.gmail.com>
 <CAG3jFytmJSjvWp0Bu7MaJ7EVuJov8gbs6cguatoOtTJpXTGVLA@mail.gmail.com>
 <CABkfQAGcSsQ74FtvAK4_awHRXswgBrThKww_xhpmTzordZ5X8w@mail.gmail.com>
 <CAG3jFyvQt=Bv2_Hi8UdOhgznp1gVZwAw8gZv6FnLwHJV4WD6Kw@mail.gmail.com> <CABkfQAGS24AM90veQhGA+=V4S50y7JwzqLMspMaEFptcYpmdMQ@mail.gmail.com>
In-Reply-To: <CABkfQAGS24AM90veQhGA+=V4S50y7JwzqLMspMaEFptcYpmdMQ@mail.gmail.com>
From:   Adrien Grassein <adrien.grassein@gmail.com>
Date:   Tue, 23 Mar 2021 15:39:33 +0100
Message-ID: <CABkfQAFhVx==HiCo5ipTqTahdxWQauweGxqc7tEdCf=gGS8aGw@mail.gmail.com>
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

Le mar. 23 mars 2021 =C3=A0 15:16, Adrien Grassein
<adrien.grassein@gmail.com> a =C3=A9crit :
>
> Le mar. 23 mars 2021 =C3=A0 15:07, Robert Foss <robert.foss@linaro.org> a=
 =C3=A9crit :
> >
> > > > > >
> > > > > > > +static enum drm_connector_status lt8912_check_cable_status(s=
truct lt8912 *lt)
> > > > > > > +{
> > > > > > > +       int ret;
> > > > > > > +       unsigned int reg_val;
> > > > > > > +
> > > > > > > +       ret =3D regmap_read(lt->regmap[I2C_MAIN], 0xC1, &reg_=
val);
> > > > > > > +       if (ret)
> > > > > > > +               return connector_status_unknown;
> > > > > > > +
> > > > > > > +       if (reg_val & BIT(7))
> > > > > > > +               return connector_status_connected;
> > > > > >
> > > > > > Register 0xc0 & BIT(7) - HPD signal after debounce
> > > > > > Register 0xc0 & BIT(6) - HPD signal for TX HPD pad
> > > > >
> > > > > So, if I understand well, I need to write 0xc0 & BIT(6) with 1 to
> > > > > enable the HPD pin.
> > > >
> > > > Ah, sorry about being a bit terse.
> > > >
> > > > Both bit 6 & 7 are read only, and are probably best read after an I=
RQ.
> > >
> > > In my case, IRQ is not triggered at all.
> >
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
> >
> > >
> > > >
> > > > > >
> > > > > > > +
> > > > > > > +static int lt8912_probe(struct i2c_client *client,
> > > > > > > +        const struct i2c_device_id *id)
> > > > > > > +{
> > > > > > > +       static struct lt8912 *lt;
> > > > > > > +       int ret =3D 0;
> > > > > > > +       struct device *dev =3D &client->dev;
> > > > > > > +
> > > > > > > +       lt =3D devm_kzalloc(dev, sizeof(struct lt8912), GFP_K=
ERNEL);
> > > > > > > +       if (!lt)
> > > > > > > +               return -ENOMEM;
> > > > > > > +
> > > > > > > +       lt->dev =3D dev;
> > > > > > > +       lt->i2c_client[0] =3D client;
> > > > > > > +       lt->cable_status =3D connector_status_unknown;
> > > > > > > +       lt->workq =3D create_workqueue("lt8912_workq");
> > > > > >
> > > > > > Looking at [1] and maybe even better [2], I think this polling
> > > > > > approach is the wrong way to go. And with access to documentati=
on, I
> > > > > > think we should be able to sort this out.
> > > > >
> > > > > I neither like the polling approach too. I did it to go on this i=
ssue.
> > > > > I will totally remove it once the HPD issue will be resolved.
> > > > > >
> > > > > > Using the irq driver approach requires the interrupt pin to be
> > > > > > configured. Pin 63 of the lt8912b is the IRQ output pin.
> > > > > >
> > > > > > In order to trigger interrupts based on it, the dt-binding woul=
d need
> > > > > > to be updated[3][4] as well as whichever DTS you're using.
> > > > > >
> > > > >
> > > > > The IRQ part is working well in my DTB. It test it by adding some
> > > > > electronics to emulate the HPD pin on the GPIO expander where the=
 HPD
> > > > > pin is linked.
> > > >
> > > > Looking at the dt-binding patch, it does not seem to list any
> > > > interrupts. So that should be added. I think the irq support from [=
3]
> > > > & [4] can be pretty much copied.
> > > >
> > > > Then we can come back and replace the polling code with the IRQ dri=
ven
> > > > code from [2].
> > >
> > > My board uses a "max7323" GPIO expander and the HPD pin is linked to =
it.
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
> >         interrupts-extended =3D <&max7323 $LT8912B_PIN_14 IRQ_TYPE_EDGE=
_RISING>;
> > }
> >
> > And of course add the corresponding parts from [2] and [3].
> >
> > >
> > >
> > > >
> > > > >
> > > > > >
> > > > > > [1] https://github.com/torvalds/linux/blob/master/drivers/gpu/d=
rm/bridge/analogix/anx7625.c#L1751
> > > > > >
> > > > > > [2] https://github.com/torvalds/linux/blob/v5.11/drivers/gpu/dr=
m/bridge/lontium-lt9611.c#L1160
> > > > > >
> > > > > > [3] https://github.com/torvalds/linux/blob/v5.11/Documentation/=
devicetree/bindings/display/bridge/lontium,lt9611.yaml#L27
> > > > > >
> > > > > > [4] https://github.com/torvalds/linux/blob/v5.11/Documentation/=
devicetree/bindings/display/bridge/lontium,lt9611.yaml#L144
> > >
> > > [5] https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/bri=
dge/display-connector.c#L199
> > > [6] https://github.com/grassead/linux-next/blob/master/arch/arm64/boo=
t/dts/freescale/imx8mq-nitrogen.dts#L37
> > > [7] https://github.com/grassead/linux-next/blob/master/arch/arm64/boo=
t/dts/freescale/imx8mq-nitrogen.dts#L249
> > > [8] https://github.com/grassead/linux-next/blob/master/arch/arm64/boo=
t/dts/freescale/imx8mq-nitrogen.dts#L291
> > >
> > >
> > > Thanks,
>
> Maybe the conclusion is that we cannot have the HPD working.
>
> Thanks,

After a bit of reflexion, I think that the pin 14 may be misconnected.
As the documentation seems unclear about this pin the chip can have
bad information about the read HDMI HPD state and then not generate an
interruption.

So, I guess that there is a way that HPD will never work on my board :(.

With this taken in account, I think that polling the status is the
best (and only) solution to emulate an HPD behaviour.

Thanks again,
