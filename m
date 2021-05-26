Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC455391B18
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 17:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235232AbhEZPFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 11:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233472AbhEZPFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 11:05:49 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80CE0C061574;
        Wed, 26 May 2021 08:04:17 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id r5so3033515lfr.5;
        Wed, 26 May 2021 08:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KX3mTJcobyHBIRoKcg4YudqAe4oQ4LVZkBgHwMBLcTs=;
        b=RkHMB7GpLI3Ptu1yH+DydH3Y9tzPjzR/GFBb9HEJwGUwpJUNe3LS1mKeoNw6TsDHH/
         cHI3frc4wwcmM17ZBkeoQNCy457/hILrlUWmXVKS7nmatJt4ZB5kj/4pLvcQXam7krg3
         pMmG+ATXI3oO5fIv3cAqfCoAoyIu5IQ/NWPD0s0QkJFErlGUPAatmLtdS9Ku6eNqI+t3
         VkZq5QIFDefFYdFWIlX4GpCtyd9WnplNFwe4qWguWqFTYjUNR1fMU2pKezrbtmdmGUoZ
         nygjStaLJIMdTXWZntJ5yvNZpjUhOu0VJ8e5sPmVxfxcg4oUWRtmF84XKI+NylYu7KyQ
         pa6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KX3mTJcobyHBIRoKcg4YudqAe4oQ4LVZkBgHwMBLcTs=;
        b=q5VrRK2psZNIBDROPuVjmNbhNEgjTv2l22cFWt9cRVJMxSEYlueb2OeMGRK2YBpy+Q
         6aBiYM6rKNctPkvSyhFVcGsDO72mZnunm832YFpDR+XDGxyIJPm25DlI+/5cgZXpOd0L
         kEInaxqZ25vWw2KK3Vi0RZ9W8GLc8TR2V0hxxd2aE4hB57VyEKYGoIf4FYpKDtxQBtf2
         QzHRA6fa2zlXs1SeFPuKD0V60CzcqY5wtq6wQn9aWuZMGuz8oWXFkGv2Ein5+hvMJ/zm
         NQCDWIT3SqNiFAO0K8viuhbu+rYDM6uvLwGQUjLm/+MVM/H5GC0Le/27J8eM0r24O0fC
         r7Ww==
X-Gm-Message-State: AOAM532rqZkJFItKs+0ElKdx5wXOFa121dG2dwmChahWE0eeL1G/pv4q
        IewGFQTh3Ub/IsRzvNj93PGQ1qy1REWkrwhDeJcWkw+Xc+E=
X-Google-Smtp-Source: ABdhPJy3ZBLNOjbMpjCn4a0MBF0VNId/zr/BBgE8aLdGWjaN41TIVcXKGBZUcgtGtJmTWnJsiRFoocDy1iFt5xfK6KA=
X-Received: by 2002:ac2:533a:: with SMTP id f26mr2466714lfh.424.1622041455695;
 Wed, 26 May 2021 08:04:15 -0700 (PDT)
MIME-Version: 1.0
References: <1622008068-13474-1-git-send-email-u0084500@gmail.com>
 <1622008068-13474-2-git-send-email-u0084500@gmail.com> <YK4oGB5cZ/DhG5vm@sirena.org.uk>
In-Reply-To: <YK4oGB5cZ/DhG5vm@sirena.org.uk>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Wed, 26 May 2021 23:04:03 +0800
Message-ID: <CADiBU393NchfrTmgPApNRqSVrTBGT+bs+H+m2UF_H3tSGLyFVQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] regulator: rt6160: Add support for Richtek RT6160
To:     Mark Brown <broonie@kernel.org>
Cc:     lgirdwood@gmail.com, Rob Herring <robh+dt@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        cy_huang <cy_huang@richtek.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI:

Mark Brown <broonie@kernel.org> =E6=96=BC 2021=E5=B9=B45=E6=9C=8826=E6=97=
=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=886:50=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Wed, May 26, 2021 at 01:47:48PM +0800, cy_huang wrote:
>
> This looks mostly good, a few small issues below:
>
> > +static int rt6160_set_suspend_voltage(struct regulator_dev *rdev, int =
uV)
> > +{
> > +     struct rt6160_priv *priv =3D rdev_get_drvdata(rdev);
> > +     struct regmap *regmap =3D rdev_get_regmap(rdev);
> > +     unsigned int reg =3D RT6160_REG_VSELH;
> > +     int vsel;
> > +
> > +     vsel =3D regulator_map_voltage_linear(rdev, uV, uV);
> > +     if (vsel < 0)
> > +             return vsel;
> > +
> > +     if (priv->vsel_active_low)
> > +             reg =3D RT6160_REG_VSELL;
> > +
> > +     return regmap_update_bits(regmap, reg, RT6160_VSEL_MASK, vsel);
> > +}
>
> This seems to just be updating the normal voltage configuration
> regulator, the suspend mode operations are there for devices that
> have a hardware suspend mode that's entered as part of the very
> low level system suspend process.
>
There's a independent 'vsel' pin. It depend on user's HW design.
And that's why there's a 'richtek,vsel_active_low' property.
Its normal application is to use vsel high active level, and it means
the opposite level can be used for the suspend voltage

And there're also two voltage registers for vsel level high and low.
> > +static int rt6160_set_ramp_delay(struct regulator_dev *rdev, int ramp_=
delay)
> > +{
> > +     struct regmap *regmap =3D rdev_get_regmap(rdev);
> > +     unsigned int ramp_value =3D RT6160_RAMPRATE_1VMS;
> > +
> > +     switch (ramp_delay) {
> > +     case 1 ... 1000:
> > +             ramp_value =3D RT6160_RAMPRATE_1VMS;
> > +             break;
>
> This looks like it could be converted to regulator_set_ramp_delay_regmap(=
)
>
I didn't notice there's the regulator_set_ramp_delay_regmap API that
can be used in kernel 5.13.
Ack in next.
> > +static unsigned int rt6160_of_map_mode(unsigned int mode)
> > +{
> > +     if (mode =3D=3D RT6160_MODE_FPWM)
> > +             return REGULATOR_MODE_FAST;
> > +     else if (mode =3D=3D RT6160_MODE_AUTO)
> > +             return REGULATOR_MODE_NORMAL;
> > +
>
> This would be more idiomatically written as a switch statement.
>
Ack in next. Change the if-else to switch case. Thx.
> > +     enable_gpio =3D devm_gpiod_get_optional(&i2c->dev, "enable", GPIO=
D_OUT_HIGH);
> > +     if (IS_ERR(enable_gpio)) {
> > +             dev_err(&i2c->dev, "Failed to get 'enable' gpio\n");
> > +             return PTR_ERR(enable_gpio);
> > +     }
>
> There's no other references to enable_gpio?
>
The IC is designed for low IQ.
So from the driver probe, I only need to keep 'enable' pin high.
Or if user specify the 'enable' gpio, it will block i2c communication,
register also be reset,
and add more delay time on enable/disable.
That's why there's no other references to 'enable' gpio.
> > +     regmap =3D devm_regmap_init_i2c(i2c, &rt6160_regmap_config);
> > +     if (IS_ERR(regmap)) {
> > +             dev_err(&i2c->dev, "Failed to init regmap\n");
> > +             return PTR_ERR(regmap);
> > +     }
>
> It's better to print the error code to help anyone who runs into
> issues figure out what's wrong.
Sure, change it to dev_err(&i2c->dev, "Failed to init regmap (%d)\n",
PTR_ERR(regmap));
Ack in next, thx.
