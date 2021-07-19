Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F335E3CE618
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 18:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352413AbhGSQBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 12:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345865AbhGSPFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 11:05:04 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23102C09F5FD
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 07:56:30 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id r18so9265910iot.4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 08:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HuZyqBI8VecIWEXCo/n1pGBHsUOUwnLTjPNhfVWEiOY=;
        b=tvMm++S3Z7x57fvLv2MDf7kScofpvB+ZLhgUm+VbzxvKo4/VVVOK9myCTWZ9QHRI5/
         VAX8lWCy2R8HFUaVZTVTDGVmpvZUKSUARSIKOZhotCYeZn1yKSmK6wieZtYwBV9Bcdaa
         +nqUdzgAf2ra5eMfe5QDzVLWSsJUUWY7oZ/WsQIIUhA8IOOhz+3ccl6DzMRGSZO1vbBq
         mLQgNF5msop7dWuA3gyrbLttIbqedhLh3fvtfyti5/QOeGVsaMlZxV8n8D/RVFs1qbYw
         xiOm99N8ssbZwrNooTj4Nvu9/CmPLSCCFJsbxZJ1c906R5IAvFKz4yslZ31UZocFG6Yz
         uRug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HuZyqBI8VecIWEXCo/n1pGBHsUOUwnLTjPNhfVWEiOY=;
        b=t2BdDbocpc7jUGJ+TLJiES+awI/1r2BdrbpKuSCcbwfPwlPUyMFbbEoVtugcLC2jvn
         3T4riJl1x58EhW1C+lcgMN16YoTwkfBcaoyMpw9K0qeKMJzBO9rLV17KrieRxK1JRkBc
         z56Z3aDjY5qO+n4DaajHc1BTscdrGTLDinHWFnb/9w2K62dVRPz4h4cfYf+oOSS4KADa
         s4QMmBnWx0/G1HOF6CdDUSFqqRznj7mmrVo2sX4zi4A4OaCzgK/54TP78fTIVAF69348
         KpD05u4TURUcVzCOXspgruF5zlfrKKYa45nlcVLkhMjJpxwuOwaneOByBIdzX1OydXfJ
         TbSQ==
X-Gm-Message-State: AOAM530gyQLf1Kh6y2T9xBAewgu8OjNXqZZng7BFdmBgxpy7dyrsXe7U
        4bWVezoyL3bAEj4EjNVMTXjC9AulkVzLexWYlrz1GQ==
X-Google-Smtp-Source: ABdhPJw8Acogs6CFL1FweALTU6/lOaHkkUc95/HwNpa3qUGS2F5qRxoy90LCQC7l9/cSBxPQUKPYuL9z7gO3afm/eKA=
X-Received: by 2002:a05:6602:2e11:: with SMTP id o17mr10320207iow.55.1626708326696;
 Mon, 19 Jul 2021 08:25:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210718203746.7159-1-theobf@usp.br> <CA+U=DspWmrWWsQDFPLycS2y-=8Q7TSn5NYMVgbQ42FccAy0=pw@mail.gmail.com>
In-Reply-To: <CA+U=DspWmrWWsQDFPLycS2y-=8Q7TSn5NYMVgbQ42FccAy0=pw@mail.gmail.com>
From:   =?UTF-8?Q?Th=C3=A9o_Bor=C3=A9m_Fabris?= <theobf@usp.br>
Date:   Mon, 19 Jul 2021 12:24:50 -0300
Message-ID: <CAD5vTa8gnQpZ8B4KQkA=-6Oo-YiN4J7pDp0HoUZgpHN99vJK_g@mail.gmail.com>
Subject: Re: [PATCH] iio: dac: max5821: convert device register to device
 managed function
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Alexandru.

Em seg., 19 de jul. de 2021 =C3=A0s 04:33, Alexandru Ardelean
<ardeleanalex@gmail.com> escreveu:
>
> On Sun, Jul 18, 2021 at 11:42 PM Th=C3=A9o Bor=C3=A9m Fabris <theobf@usp.=
br> wrote:
> >
> > Add a device managed hook, via devm_add_action_or_reset() and
> > max5821_regulator_disable(), to disable voltage regulator on device
> > detach.
> > Replace iio_device_register() by devm_iio_device_register() and remove
> > the max5821_remove() function used to unregister the device and disable=
 the
> > voltage regulator.
> > Remove i2c_set_clientdata() from the probe function, since
> > i2c_get_clientdata() is not used anymore.
>
> Looks good overall.
> A few comments inline.
>
> >
> > Signed-off-by: Th=C3=A9o Bor=C3=A9m Fabris <theobf@usp.br>
> > ---
> >  drivers/iio/dac/max5821.c | 30 ++++++++++++++++--------------
> >  1 file changed, 16 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/iio/dac/max5821.c b/drivers/iio/dac/max5821.c
> > index bd6e75699a63..44c04ae70b32 100644
> > --- a/drivers/iio/dac/max5821.c
> > +++ b/drivers/iio/dac/max5821.c
> > @@ -294,6 +294,13 @@ static const struct iio_info max5821_info =3D {
> >         .write_raw =3D max5821_write_raw,
> >  };
> >
> > +static void max5821_regulator_disable(void *data)
> > +{
> > +       struct regulator *rdata =3D data;
> > +
> > +       regulator_disable(rdata);
>
> This can be simplified a bit:
>
> static void max5821_regulator_disable(void *reg)
> {
>       regulator_disable(reg);
> }
>
> I used to do explicit casting, but then I also figured that it's not nece=
ssary.
>
Ok.

> > +}
> > +
> >  static int max5821_probe(struct i2c_client *client,
> >                         const struct i2c_device_id *id)
> >  {
> > @@ -306,7 +313,6 @@ static int max5821_probe(struct i2c_client *client,
> >         if (!indio_dev)
> >                 return -ENOMEM;
> >         data =3D iio_priv(indio_dev);
> > -       i2c_set_clientdata(client, indio_dev);
> >         data->client =3D client;
> >         mutex_init(&data->lock);
> >
> > @@ -331,6 +337,14 @@ static int max5821_probe(struct i2c_client *client=
,
> >                 goto error_free_reg;
> >         }
> >
> > +       ret =3D devm_add_action_or_reset(&client->dev, max5821_regulato=
r_disable,
> > +                                      data->vref_reg);
> > +       if (ret) {
> > +               dev_err(&client->dev,
> > +                       "Failed to add action to managed regulator: %d\=
n", ret);
> > +               goto error_disable_reg;
>
> return ret;
>
> devm_add_action_or_reset() should call max5821_regulator_disable() in
> case of error
>
Ok.

> > +       }
> > +
> >         ret =3D regulator_get_voltage(data->vref_reg);
> >         if (ret < 0) {
> >                 dev_err(&client->dev,
> > @@ -346,7 +360,7 @@ static int max5821_probe(struct i2c_client *client,
> >         indio_dev->modes =3D INDIO_DIRECT_MODE;
> >         indio_dev->info =3D &max5821_info;
> >
> > -       return iio_device_register(indio_dev);
> > +       return devm_iio_device_register(&client->dev, indio_dev);
> >
> >  error_disable_reg:
>
> This entire goto block should be removed.
> The idea of using only devm_ functions is to not have these goto statemen=
ts.
>
I thought the action added via devm_add_action (and devres_add) was called =
only
on driver detach, thus the error_disable_reg label would be necessary
to handle the
possible error on regulator_get_voltage. Could you please clarify for
me when does
a driver detach happen?

Thanks for your reply,
Th=C3=A9o

> >         regulator_disable(data->vref_reg);
> > @@ -356,17 +370,6 @@ static int max5821_probe(struct i2c_client *client=
,
> >         return ret;
> >  }
> >
> > -static int max5821_remove(struct i2c_client *client)
> > -{
> > -       struct iio_dev *indio_dev =3D i2c_get_clientdata(client);
> > -       struct max5821_data *data =3D iio_priv(indio_dev);
> > -
> > -       iio_device_unregister(indio_dev);
> > -       regulator_disable(data->vref_reg);
> > -
> > -       return 0;
> > -}
> > -
> >  static const struct i2c_device_id max5821_id[] =3D {
> >         { "max5821", ID_MAX5821 },
> >         { }
> > @@ -386,7 +389,6 @@ static struct i2c_driver max5821_driver =3D {
> >                 .pm     =3D &max5821_pm_ops,
> >         },
> >         .probe          =3D max5821_probe,
> > -       .remove         =3D max5821_remove,
> >         .id_table       =3D max5821_id,
> >  };
> >  module_i2c_driver(max5821_driver);
> > --
> > 2.20.1
> >
