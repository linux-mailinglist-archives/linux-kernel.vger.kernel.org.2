Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2C1A345C7E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 12:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbhCWLJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 07:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbhCWLJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 07:09:10 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A25C061574;
        Tue, 23 Mar 2021 04:09:10 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id u9so26389164ejj.7;
        Tue, 23 Mar 2021 04:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AthyaDoKKyndv1i/NrrVvhda/enAojvpcI/TJWbKNcA=;
        b=etmj2WE+fgF26Q9xj7+WcJJ4AUtOO+QeRW4yJa6Ql/93WqgpmEPIbFGVYFFGTsmWdm
         lYTMlfMW07XG0VLQ1bXGjLDPOjzJ9vRG0OAPjkUa4TyEicf6SFi3vnwcOXuJyCpDGLIG
         o9coLj5JTM9969JZFuB/RgnVF+8bj5mRs3KT+pkHzekDypJMzXS3qnJpEJlApU5NZQVt
         qAzcWoaI/DDnNWp6syRUNbcURE6x34Ypa/nhpU6NRTFtVwDkKWcSyrTDEge1iQVmaCz3
         qc1Vi8XmEacN814I39MoB7hqUcsueuBrf3xI187jDvWIxiB4rH+aEBHcWRFgjCu330zh
         BMkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AthyaDoKKyndv1i/NrrVvhda/enAojvpcI/TJWbKNcA=;
        b=dlUKtR8q5MAj+b/MKr+3euklV8D660t2PoaGZyRpetInEZIuAQkyojtQq49LMxNkDD
         Hvzx5aOUjPRLA29d0JHodp6kUYSomYLoJGM3snvw5yUJ+fKXHj07xvZ9DrN8uRikRo9C
         OYmhJT0XdVQatJbh5mjRr3npAE5UaW6sy3wjLDOk3BkhD4oocJM0Qd4J0A39tbHqtqi/
         8loYzv8B/oKuNmqCJl9iK6pkzuTMVPpiFOJvLPbmX2eGZO8z2FNoFU/A2EYTn/R3RLA0
         Y3PsODeWyBUtDxFTg3BCTO2FH5NVt8RRYWgvdd5HBqxwpekfL0Af8aYHwbp4LBH5rFNJ
         1TWw==
X-Gm-Message-State: AOAM5334GYGz2geAga/Xb1gjowMnQGsOVBcjKUB3SLip79Z6fsZadXlR
        baxEnsct9vRdmDedzy0C8WEUWHYg4PyaoSBQbGo=
X-Google-Smtp-Source: ABdhPJxwDdq5iXqaWZVGQZFfxnXDVq736giW9rFR/kJcpR1leX3ubItOP8NW/oOY9lhJQBIFuejzXYH9oM6obw9FMyA=
X-Received: by 2002:a17:906:3ac3:: with SMTP id z3mr4498479ejd.106.1616497749061;
 Tue, 23 Mar 2021 04:09:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210308120555.252524-1-adrien.grassein@gmail.com>
 <20210308120555.252524-3-adrien.grassein@gmail.com> <CAG3jFytoE9hWvq2e2Caqn4qP_RuEOnm4r9VQ85ffbAcguSLf+w@mail.gmail.com>
 <CABkfQAGvPy3DzXQnDJqm1q_rOLWR7BQTXb8z05iML3s3Mc8LJw@mail.gmail.com> <CAG3jFytmJSjvWp0Bu7MaJ7EVuJov8gbs6cguatoOtTJpXTGVLA@mail.gmail.com>
In-Reply-To: <CAG3jFytmJSjvWp0Bu7MaJ7EVuJov8gbs6cguatoOtTJpXTGVLA@mail.gmail.com>
From:   Adrien Grassein <adrien.grassein@gmail.com>
Date:   Tue, 23 Mar 2021 12:08:58 +0100
Message-ID: <CABkfQAGcSsQ74FtvAK4_awHRXswgBrThKww_xhpmTzordZ5X8w@mail.gmail.com>
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

Le mar. 23 mars 2021 =C3=A0 11:42, Robert Foss <robert.foss@linaro.org> a =
=C3=A9crit :
>
> On Tue, 23 Mar 2021 at 11:01, Adrien Grassein <adrien.grassein@gmail.com>=
 wrote:
> >
> > Hey Robert,
> >
> > Thanks for the update.
> >
> > Le mar. 23 mars 2021 =C3=A0 10:10, Robert Foss <robert.foss@linaro.org>=
 a =C3=A9crit :
> > >
> > > Hey Adrien,
> > >
> > > Sorry about the slow reply, but I just received the documentation fro=
m
> > > the vendor. So let's dig in to the HPD issue.
> >
> > No problem :)
> > >
> > > > +static enum drm_connector_status lt8912_check_cable_status(struct =
lt8912 *lt)
> > > > +{
> > > > +       int ret;
> > > > +       unsigned int reg_val;
> > > > +
> > > > +       ret =3D regmap_read(lt->regmap[I2C_MAIN], 0xC1, &reg_val);
> > > > +       if (ret)
> > > > +               return connector_status_unknown;
> > > > +
> > > > +       if (reg_val & BIT(7))
> > > > +               return connector_status_connected;
> > >
> > > Register 0xc0 & BIT(7) - HPD signal after debounce
> > > Register 0xc0 & BIT(6) - HPD signal for TX HPD pad
> >
> > So, if I understand well, I need to write 0xc0 & BIT(6) with 1 to
> > enable the HPD pin.
>
> Ah, sorry about being a bit terse.
>
> Both bit 6 & 7 are read only, and are probably best read after an IRQ.

In my case, IRQ is not triggered at all.
When reading the value of the HPD pin, I always get 1 (and no
transition occurs when plugging / unplugging a cable).
The HPD IRQ is done on the HDMI connector driver [5].
I think a register configuration should be done to enable the IRQ pin
or maybe there is a nug in electronics.
The HPD pin is linked to a 2.2k pullup resistor (maybe it's wrong)

>
> > >
> > > > +
> > > > +static int lt8912_probe(struct i2c_client *client,
> > > > +        const struct i2c_device_id *id)
> > > > +{
> > > > +       static struct lt8912 *lt;
> > > > +       int ret =3D 0;
> > > > +       struct device *dev =3D &client->dev;
> > > > +
> > > > +       lt =3D devm_kzalloc(dev, sizeof(struct lt8912), GFP_KERNEL)=
;
> > > > +       if (!lt)
> > > > +               return -ENOMEM;
> > > > +
> > > > +       lt->dev =3D dev;
> > > > +       lt->i2c_client[0] =3D client;
> > > > +       lt->cable_status =3D connector_status_unknown;
> > > > +       lt->workq =3D create_workqueue("lt8912_workq");
> > >
> > > Looking at [1] and maybe even better [2], I think this polling
> > > approach is the wrong way to go. And with access to documentation, I
> > > think we should be able to sort this out.
> >
> > I neither like the polling approach too. I did it to go on this issue.
> > I will totally remove it once the HPD issue will be resolved.
> > >
> > > Using the irq driver approach requires the interrupt pin to be
> > > configured. Pin 63 of the lt8912b is the IRQ output pin.
> > >
> > > In order to trigger interrupts based on it, the dt-binding would need
> > > to be updated[3][4] as well as whichever DTS you're using.
> > >
> >
> > The IRQ part is working well in my DTB. It test it by adding some
> > electronics to emulate the HPD pin on the GPIO expander where the HPD
> > pin is linked.
>
> Looking at the dt-binding patch, it does not seem to list any
> interrupts. So that should be added. I think the irq support from [3]
> & [4] can be pretty much copied.
>
> Then we can come back and replace the polling code with the IRQ driven
> code from [2].

My board uses a "max7323" GPIO expander and the HPD pin is linked to it.
I test this GPIO expander by soldering a pull up resistor and an
interrupt on it and an interrupt was correctly triggered in both
max7323 driver and hdmi-connector;
So I guess that my DTB configuration is correct.
I made my DBT configuration available:
  - hdmi-connector node: [6]
  - lt8912b node: |7]
  - max7323 node: [8].


>
> >
> > >
> > > [1] https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/bri=
dge/analogix/anx7625.c#L1751
> > >
> > > [2] https://github.com/torvalds/linux/blob/v5.11/drivers/gpu/drm/brid=
ge/lontium-lt9611.c#L1160
> > >
> > > [3] https://github.com/torvalds/linux/blob/v5.11/Documentation/device=
tree/bindings/display/bridge/lontium,lt9611.yaml#L27
> > >
> > > [4] https://github.com/torvalds/linux/blob/v5.11/Documentation/device=
tree/bindings/display/bridge/lontium,lt9611.yaml#L144

[5] https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/bridge/di=
splay-connector.c#L199
[6] https://github.com/grassead/linux-next/blob/master/arch/arm64/boot/dts/=
freescale/imx8mq-nitrogen.dts#L37
[7] https://github.com/grassead/linux-next/blob/master/arch/arm64/boot/dts/=
freescale/imx8mq-nitrogen.dts#L249
[8] https://github.com/grassead/linux-next/blob/master/arch/arm64/boot/dts/=
freescale/imx8mq-nitrogen.dts#L291


Thanks,
