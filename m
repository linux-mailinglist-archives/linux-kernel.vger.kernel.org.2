Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2EC345C1A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 11:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbhCWKm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 06:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbhCWKme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 06:42:34 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1682C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 03:42:34 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id a22-20020a17090aa516b02900c1215e9b33so11995891pjq.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 03:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oMvMOVIe+KU4qjnJSB+FFaD+jlcKrEz6x5eQRXRwwRI=;
        b=vfDRr9dLtgwajRZGiE6ZTC+K+UbG3v8Bjrr35GBxq491Aiq80BSsEOv/TLmKhLI2RP
         fhrx+2/V1r779BvbKgOQTcrgv5syb6qISCe50pZyKExoBQF3tFhhDFBzYiCcI2FnfEZy
         4NCNaK72KZ+PihDt5FlcIVRqVJ4VOlTjnG3cU1mW4j5+3kfZ9ghPPZGxFCxAhc8wDy3K
         etgt8Bh38ixtJnPyGKEuy99WvyLARXYYdoM37RbzYClLwywgeD7P6Nuf5XAGm+CmX9zR
         DHY6xtOuVPRdwvPV0fBlr2wrD3PZ4rGHamjZe5t30mZhj/0kZVTXspdT58nC+2JGyWSJ
         Ecjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oMvMOVIe+KU4qjnJSB+FFaD+jlcKrEz6x5eQRXRwwRI=;
        b=hvcrXPl+Rfu2ocF75o39w4XP8wo9y5QslduqKdbF+VLThnisPD5eR94TB9XkiloWtp
         HIyo1l5+R9NIowIeYQP5hNNdKnPxJ/yWZPqCnRTcBIk2aAARs3zxxSLEZPy2guT4TjX6
         BXzn+tjMGvd1CmdxCqGs+ju9pyEzh6Mk5wG1egNQ0FkGrFzNgWF5po9mtaCee4VaM+Dh
         U25Y4QfJkW80R27A61UiSnVCJ5IZ04m8htkBbDF34T2z50UYeS4f1BLQFTatrSlWArqO
         a++wnKQdO0VLss9T40agGQsANIlXmTjxUulN07eovXzr1Ac5upvL9flLT3Ub5t4c0mD3
         tnjA==
X-Gm-Message-State: AOAM533GVg6VOnV0z1fYgHVv3NYhtjWb++ged/W77/87kCvOJ/V/UW9R
        wq9ZExbzor+qzm2DFZ6XR7TcMvkoksFnZXY2g6XV5w==
X-Google-Smtp-Source: ABdhPJzRh+arBWIbSBRi7xCksNcb/8or1R21ANpA1lUfvc8SPGjzUr89S/mzolqQ2jQU+cBUiIU1E0XmrwmFbQduOtk=
X-Received: by 2002:a17:90a:be07:: with SMTP id a7mr4016666pjs.75.1616496154215;
 Tue, 23 Mar 2021 03:42:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210308120555.252524-1-adrien.grassein@gmail.com>
 <20210308120555.252524-3-adrien.grassein@gmail.com> <CAG3jFytoE9hWvq2e2Caqn4qP_RuEOnm4r9VQ85ffbAcguSLf+w@mail.gmail.com>
 <CABkfQAGvPy3DzXQnDJqm1q_rOLWR7BQTXb8z05iML3s3Mc8LJw@mail.gmail.com>
In-Reply-To: <CABkfQAGvPy3DzXQnDJqm1q_rOLWR7BQTXb8z05iML3s3Mc8LJw@mail.gmail.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Tue, 23 Mar 2021 11:42:23 +0100
Message-ID: <CAG3jFytmJSjvWp0Bu7MaJ7EVuJov8gbs6cguatoOtTJpXTGVLA@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Mar 2021 at 11:01, Adrien Grassein <adrien.grassein@gmail.com> w=
rote:
>
> Hey Robert,
>
> Thanks for the update.
>
> Le mar. 23 mars 2021 =C3=A0 10:10, Robert Foss <robert.foss@linaro.org> a=
 =C3=A9crit :
> >
> > Hey Adrien,
> >
> > Sorry about the slow reply, but I just received the documentation from
> > the vendor. So let's dig in to the HPD issue.
>
> No problem :)
> >
> > > +static enum drm_connector_status lt8912_check_cable_status(struct lt=
8912 *lt)
> > > +{
> > > +       int ret;
> > > +       unsigned int reg_val;
> > > +
> > > +       ret =3D regmap_read(lt->regmap[I2C_MAIN], 0xC1, &reg_val);
> > > +       if (ret)
> > > +               return connector_status_unknown;
> > > +
> > > +       if (reg_val & BIT(7))
> > > +               return connector_status_connected;
> >
> > Register 0xc0 & BIT(7) - HPD signal after debounce
> > Register 0xc0 & BIT(6) - HPD signal for TX HPD pad
>
> So, if I understand well, I need to write 0xc0 & BIT(6) with 1 to
> enable the HPD pin.

Ah, sorry about being a bit terse.

Both bit 6 & 7 are read only, and are probably best read after an IRQ.

> >
> > > +
> > > +static int lt8912_probe(struct i2c_client *client,
> > > +        const struct i2c_device_id *id)
> > > +{
> > > +       static struct lt8912 *lt;
> > > +       int ret =3D 0;
> > > +       struct device *dev =3D &client->dev;
> > > +
> > > +       lt =3D devm_kzalloc(dev, sizeof(struct lt8912), GFP_KERNEL);
> > > +       if (!lt)
> > > +               return -ENOMEM;
> > > +
> > > +       lt->dev =3D dev;
> > > +       lt->i2c_client[0] =3D client;
> > > +       lt->cable_status =3D connector_status_unknown;
> > > +       lt->workq =3D create_workqueue("lt8912_workq");
> >
> > Looking at [1] and maybe even better [2], I think this polling
> > approach is the wrong way to go. And with access to documentation, I
> > think we should be able to sort this out.
>
> I neither like the polling approach too. I did it to go on this issue.
> I will totally remove it once the HPD issue will be resolved.
> >
> > Using the irq driver approach requires the interrupt pin to be
> > configured. Pin 63 of the lt8912b is the IRQ output pin.
> >
> > In order to trigger interrupts based on it, the dt-binding would need
> > to be updated[3][4] as well as whichever DTS you're using.
> >
>
> The IRQ part is working well in my DTB. It test it by adding some
> electronics to emulate the HPD pin on the GPIO expander where the HPD
> pin is linked.

Looking at the dt-binding patch, it does not seem to list any
interrupts. So that should be added. I think the irq support from [3]
& [4] can be pretty much copied.

Then we can come back and replace the polling code with the IRQ driven
code from [2].

>
> >
> > [1] https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/bridg=
e/analogix/anx7625.c#L1751
> >
> > [2] https://github.com/torvalds/linux/blob/v5.11/drivers/gpu/drm/bridge=
/lontium-lt9611.c#L1160
> >
> > [3] https://github.com/torvalds/linux/blob/v5.11/Documentation/devicetr=
ee/bindings/display/bridge/lontium,lt9611.yaml#L27
> >
> > [4] https://github.com/torvalds/linux/blob/v5.11/Documentation/devicetr=
ee/bindings/display/bridge/lontium,lt9611.yaml#L144
