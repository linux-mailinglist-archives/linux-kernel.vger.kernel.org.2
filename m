Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2E7F39254B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 05:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234580AbhE0DQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 23:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234421AbhE0DQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 23:16:03 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151B6C061574;
        Wed, 26 May 2021 20:14:31 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id q7so5769683lfr.6;
        Wed, 26 May 2021 20:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=j7J02/0KYhO5KiEG8+co4Zy+SjxnsnUObkhu4sHTn5w=;
        b=hCvwNoMIrr2svojaUFfm66AXBO4j4RwKdgR/MzKMa7M7/KbxtJssJ/N8YLo/dW7XhX
         QKiK0TiN0PTKbZv9b8hul659+MU6gXGuhL2VSOxu7U6XhbpLfLKFzA/EvGRGkHNz8qL6
         Z15rTN5ld5ljbVEiToFeieZUtK3G04zGR82BWhRkf3s8fDJcV+Qy3rDuC7mD46x58n6N
         cc5+kkN/2ORVHhfEUkiw8hZAJuwypkcO2/D3FBZXaukVKizdpaqXnnFTlEi9cYdfBTCj
         wns6uAkB14Fge/AK0NYdtlgm9l7t6pi47pPeIaLKaBYgPkvO0jPU0S9KpttfqlGsxPTq
         Ugtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=j7J02/0KYhO5KiEG8+co4Zy+SjxnsnUObkhu4sHTn5w=;
        b=Ou19tLLFJZBSNh+W6acyZMiWjvRHbgZC8Plpk0NO8GT+ZCs30zAjytxjHRxRhV0YrJ
         8yCdFQ6mGOm5lPy9IhX9ZIzyxEDSFsfV8R45l9iv7yOaYcCFqRgjHXV9OkcdiEbTGaiC
         LmaJEO41dg4vcK9y4Ta1bIu4KH6Dxn9p6ZrzXPFyVEBLGMBdag1G5aOuoYY86/KJ58Yo
         dTUAqhZ+cT33EKT4v5tqwLsrcfEqHU+D3VZJJKX9lU3NIKJQVImn8LxsJlcUQvRdUvtg
         pU0rPDc9WO7ju4ZYtjP4IB/0+tCKKEX0SdwPLj7Wk0OgLSEs2wbjW/WyvAWddDe/Iwud
         3Smw==
X-Gm-Message-State: AOAM531jJuSpTYWOn9Pf/rPpdV/zzj6o2licPCfhqkc5J4h1kJ7iG5u5
        BRw6WeZBP4Ij+DeG+hY3XAEzMGp/00Hk5ipO+FmntiTo
X-Google-Smtp-Source: ABdhPJwRVW50aFG+Wwsqu1QDG1mWICkFu5IqwfGlLcuseT1A7xEYennm1H3dAWlDnR80sF6Y+7g4YFnvylfrr5D2lg0=
X-Received: by 2002:ac2:5d29:: with SMTP id i9mr852536lfb.638.1622085269309;
 Wed, 26 May 2021 20:14:29 -0700 (PDT)
MIME-Version: 1.0
References: <1622008068-13474-1-git-send-email-u0084500@gmail.com>
 <1622008068-13474-2-git-send-email-u0084500@gmail.com> <YK4oGB5cZ/DhG5vm@sirena.org.uk>
 <CADiBU393NchfrTmgPApNRqSVrTBGT+bs+H+m2UF_H3tSGLyFVQ@mail.gmail.com>
In-Reply-To: <CADiBU393NchfrTmgPApNRqSVrTBGT+bs+H+m2UF_H3tSGLyFVQ@mail.gmail.com>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Thu, 27 May 2021 11:14:17 +0800
Message-ID: <CADiBU3-LjetAkzks4MZKiK=KXK5ziFhF9D13cAjJ4W5gytw74A@mail.gmail.com>
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

HI, Mark:

ChiYuan Huang <u0084500@gmail.com> =E6=96=BC 2021=E5=B9=B45=E6=9C=8826=E6=
=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=8811:04=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> HI:
>
> Mark Brown <broonie@kernel.org> =E6=96=BC 2021=E5=B9=B45=E6=9C=8826=E6=97=
=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=886:50=E5=AF=AB=E9=81=93=EF=BC=9A
> >
> > On Wed, May 26, 2021 at 01:47:48PM +0800, cy_huang wrote:
> >
> > This looks mostly good, a few small issues below:
> >
> > > +static int rt6160_set_suspend_voltage(struct regulator_dev *rdev, in=
t uV)
> > > +{
> > > +     struct rt6160_priv *priv =3D rdev_get_drvdata(rdev);
> > > +     struct regmap *regmap =3D rdev_get_regmap(rdev);
> > > +     unsigned int reg =3D RT6160_REG_VSELH;
> > > +     int vsel;
> > > +
> > > +     vsel =3D regulator_map_voltage_linear(rdev, uV, uV);
> > > +     if (vsel < 0)
> > > +             return vsel;
> > > +
> > > +     if (priv->vsel_active_low)
> > > +             reg =3D RT6160_REG_VSELL;
> > > +
> > > +     return regmap_update_bits(regmap, reg, RT6160_VSEL_MASK, vsel);
> > > +}
> >
> > This seems to just be updating the normal voltage configuration
> > regulator, the suspend mode operations are there for devices that
> > have a hardware suspend mode that's entered as part of the very
> > low level system suspend process.
> >
> There's a independent 'vsel' pin. It depend on user's HW design.
> And that's why there's a 'richtek,vsel_active_low' property.
> Its normal application is to use vsel high active level, and it means
> the opposite level can be used for the suspend voltage
>
> And there're also two voltage registers for vsel level high and low.
> > > +static int rt6160_set_ramp_delay(struct regulator_dev *rdev, int ram=
p_delay)
> > > +{
> > > +     struct regmap *regmap =3D rdev_get_regmap(rdev);
> > > +     unsigned int ramp_value =3D RT6160_RAMPRATE_1VMS;
> > > +
> > > +     switch (ramp_delay) {
> > > +     case 1 ... 1000:
> > > +             ramp_value =3D RT6160_RAMPRATE_1VMS;
> > > +             break;
> >
> > This looks like it could be converted to regulator_set_ramp_delay_regma=
p()
> >
> I didn't notice there's the regulator_set_ramp_delay_regmap API that
> can be used in kernel 5.13.u
> Ack in next.

I review the regulator_set_ramp_delay_regmap API.
If seems I need to fill in the ramp_delay_table by the descend order.
But this chip ramp delay table is designed the ascending value reg bit
field [0 1 2 3] by
the ascending order [1000 2500 5000 10000] uV/uS
Even if I tried to filler in descending order, I also need a inverted opera=
tion.

And I found the regulator_set_ramp_delay_regmap API has some logic error.
From the include/linux/regulator/driver.h, the set_ramp_delay function says=
 to
set the less or equal one ramp delay value.
But your logic will get the larger or equal one from the descending
ramp delay table.

Could you help to check about this?
> > > +static unsigned int rt6160_of_map_mode(unsigned int mode)
> > > +{
> > > +     if (mode =3D=3D RT6160_MODE_FPWM)
> > > +             return REGULATOR_MODE_FAST;
> > > +     else if (mode =3D=3D RT6160_MODE_AUTO)
> > > +             return REGULATOR_MODE_NORMAL;
> > > +
> >
> > This would be more idiomatically written as a switch statement.
> >
> Ack in next. Change the if-else to switch case. Thx.
> > > +     enable_gpio =3D devm_gpiod_get_optional(&i2c->dev, "enable", GP=
IOD_OUT_HIGH);
> > > +     if (IS_ERR(enable_gpio)) {
> > > +             dev_err(&i2c->dev, "Failed to get 'enable' gpio\n");
> > > +             return PTR_ERR(enable_gpio);
> > > +     }
> >
> > There's no other references to enable_gpio?
> >
> The IC is designed for low IQ.
> So from the driver probe, I only need to keep 'enable' pin high.
> Or if user specify the 'enable' gpio, it will block i2c communication,
> register also be reset,
> and add more delay time on enable/disable.
> That's why there's no other references to 'enable' gpio.
> > > +     regmap =3D devm_regmap_init_i2c(i2c, &rt6160_regmap_config);
> > > +     if (IS_ERR(regmap)) {
> > > +             dev_err(&i2c->dev, "Failed to init regmap\n");
> > > +             return PTR_ERR(regmap);
> > > +     }
> >
> > It's better to print the error code to help anyone who runs into
> > issues figure out what's wrong.
> Sure, change it to dev_err(&i2c->dev, "Failed to init regmap (%d)\n",
> PTR_ERR(regmap));
> Ack in next, thx.
