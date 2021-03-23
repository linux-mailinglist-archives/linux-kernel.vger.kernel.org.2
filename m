Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA84345B94
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 11:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbhCWKBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 06:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbhCWKBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 06:01:24 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDC9C061574;
        Tue, 23 Mar 2021 03:01:24 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id kt15so16576085ejb.12;
        Tue, 23 Mar 2021 03:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nj4YcCb7xjYVbxlcwxxDQrqQ71mTXMPHZgfWFiKufYI=;
        b=Vwnf9gIIyfDs4RawhTaywxnMirJTfyjnqOrLX2NEQ3rhT8n/yMvtszcac60vbIREjo
         poQKz2Y604m2WZTdvoRefkvHJ9O9DZ9kE2CFeeBKpVDVEsZePKSyoSWvJr6d04m3wgDJ
         8JIcCxyYxl7mC0dfGVm7jUsibRu0Rgo4Q2JWBLgglZisNRE1IuUoaHSIHrCgaOw5JakA
         K51rnUknIWtg7Ej5zEMMNboAB9llNqHQ15QMokSpR7X2Qyds8+j5GR7dtOnFnYxBI7JI
         8BunhCHS571+8CkvdDjlRl10vsT7TGYENTq0E1m3T6fkW66BMO5W5n9tqQsLr8GSf2fU
         3AMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nj4YcCb7xjYVbxlcwxxDQrqQ71mTXMPHZgfWFiKufYI=;
        b=czdMpBiNYDzAznsSpuulnWl3lchbiwxhhplmX/X9q3Q8eb6SK8WI/wP/6Mm8+bYh6F
         tGrSy44FxdoHbdNqg9F+UNxe3hU8UX7BiCgSpmqBXqrQ1QRqzLNLyvyzFIcOM2XQaEKf
         Z/prNn1cEFKRGYgaW5xGnLWPQ+tzk8Z+V2no2w0e+guY5usuzI+EqzzGRt8jfdW7eBn5
         +aRZ56+RsFXHr7EvOA4m4ArP7hwkfbmadgYulSJFg47RPUiZZOuvBv7bT90LEeT74v0o
         Fv+u9RYgDUvA6GLQsd2yonTqbOL022JgZXPNaM3ygUUtgxDdUZmHUa6vv16REWxgn8Sb
         mQuA==
X-Gm-Message-State: AOAM531xRnGZP9ygobrZee04AN/tnXPgbEdysP5uczkGQJH3niz/mc1b
        dTf5dgYiBJeee/5zEWSFsAdU3L2+b+qagOG0QPk=
X-Google-Smtp-Source: ABdhPJx0yvU4tb0BcWmW3MEpF/P3YjS9itwZH71QHOPG67k7RMfo5h3+ymT/wvQgYmGv6Vmbu15NqNphFtzHRPrl3kU=
X-Received: by 2002:a17:906:a8a:: with SMTP id y10mr4250922ejf.288.1616493683238;
 Tue, 23 Mar 2021 03:01:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210308120555.252524-1-adrien.grassein@gmail.com>
 <20210308120555.252524-3-adrien.grassein@gmail.com> <CAG3jFytoE9hWvq2e2Caqn4qP_RuEOnm4r9VQ85ffbAcguSLf+w@mail.gmail.com>
In-Reply-To: <CAG3jFytoE9hWvq2e2Caqn4qP_RuEOnm4r9VQ85ffbAcguSLf+w@mail.gmail.com>
From:   Adrien Grassein <adrien.grassein@gmail.com>
Date:   Tue, 23 Mar 2021 11:01:12 +0100
Message-ID: <CABkfQAGvPy3DzXQnDJqm1q_rOLWR7BQTXb8z05iML3s3Mc8LJw@mail.gmail.com>
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

Hey Robert,

Thanks for the update.

Le mar. 23 mars 2021 =C3=A0 10:10, Robert Foss <robert.foss@linaro.org> a =
=C3=A9crit :
>
> Hey Adrien,
>
> Sorry about the slow reply, but I just received the documentation from
> the vendor. So let's dig in to the HPD issue.

No problem :)
>
> > +static enum drm_connector_status lt8912_check_cable_status(struct lt89=
12 *lt)
> > +{
> > +       int ret;
> > +       unsigned int reg_val;
> > +
> > +       ret =3D regmap_read(lt->regmap[I2C_MAIN], 0xC1, &reg_val);
> > +       if (ret)
> > +               return connector_status_unknown;
> > +
> > +       if (reg_val & BIT(7))
> > +               return connector_status_connected;
>
> Register 0xc0 & BIT(7) - HPD signal after debounce
> Register 0xc0 & BIT(6) - HPD signal for TX HPD pad

So, if I understand well, I need to write 0xc0 & BIT(6) with 1 to
enable the HPD pin.
>
> > +
> > +static int lt8912_probe(struct i2c_client *client,
> > +        const struct i2c_device_id *id)
> > +{
> > +       static struct lt8912 *lt;
> > +       int ret =3D 0;
> > +       struct device *dev =3D &client->dev;
> > +
> > +       lt =3D devm_kzalloc(dev, sizeof(struct lt8912), GFP_KERNEL);
> > +       if (!lt)
> > +               return -ENOMEM;
> > +
> > +       lt->dev =3D dev;
> > +       lt->i2c_client[0] =3D client;
> > +       lt->cable_status =3D connector_status_unknown;
> > +       lt->workq =3D create_workqueue("lt8912_workq");
>
> Looking at [1] and maybe even better [2], I think this polling
> approach is the wrong way to go. And with access to documentation, I
> think we should be able to sort this out.

I neither like the polling approach too. I did it to go on this issue.
I will totally remove it once the HPD issue will be resolved.
>
> Using the irq driver approach requires the interrupt pin to be
> configured. Pin 63 of the lt8912b is the IRQ output pin.
>
> In order to trigger interrupts based on it, the dt-binding would need
> to be updated[3][4] as well as whichever DTS you're using.
>

The IRQ part is working well in my DTB. It test it by adding some
electronics to emulate the HPD pin on the GPIO expander where the HPD
pin is linked.

>
> [1] https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/bridge/=
analogix/anx7625.c#L1751
>
> [2] https://github.com/torvalds/linux/blob/v5.11/drivers/gpu/drm/bridge/l=
ontium-lt9611.c#L1160
>
> [3] https://github.com/torvalds/linux/blob/v5.11/Documentation/devicetree=
/bindings/display/bridge/lontium,lt9611.yaml#L27
>
> [4] https://github.com/torvalds/linux/blob/v5.11/Documentation/devicetree=
/bindings/display/bridge/lontium,lt9611.yaml#L144

Thanks a lot,
Adrien
