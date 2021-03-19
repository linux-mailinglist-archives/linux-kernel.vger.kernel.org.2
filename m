Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75875341A31
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 11:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbhCSKiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 06:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbhCSKh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 06:37:58 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B238AC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 03:37:57 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id v26so5522980iox.11
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 03:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metormote-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XetcND/DSS37rsPf7W1HM6yIOoKQSJW/Bb3HibrSkvk=;
        b=jwr2nkA/hWL/NtGMBsq5pmmkGBwWc3fgrIBGugqu/X6XxWd01sSDHxErdn8ki4BPz/
         cwtjKOV9H3Bbn6fXkc07+vfgHhWSogEo6SV6fiq07soSz9kIwGufpkVrbgqmr6YUrP+m
         LMws4GQLfxK/YT9p0Tnm5dxm5hWNGUHRpjq4RC9+6n1Oids9myPyswKyJ4TNzIBF4x7O
         CaOF4dhVY7v4hq5b7LWMUh+ez6CZUJbKCYif6ZSLLSjf2n1023nprcwsxIGfBlHt4i35
         qAprsQssYupOpbt+Kmd7mwPKRi5RzWLJcCyZrNcbRrtBi98UE1Qd7Y4fBC+jDIALaYHW
         KsOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XetcND/DSS37rsPf7W1HM6yIOoKQSJW/Bb3HibrSkvk=;
        b=NXV8/SSYhf2gWDix5sfWCi6yo+uT6W7zrTbSjROtmvS8EXZnkUgk9Jbvd+i+DOezxC
         c1+xf2COlLEhw/+ZMQQAIFwO0GhZR9PfIJTfU72R4QQUESO+R7Mw348PTSnQM1mjffzb
         1ha1RCfim7bBSWhZppF4G9Ikmki31npBcqXMCRSxXPPvqHOAlTM5wns/Elu1AZXf9yVP
         OXZvC8tvUycifdsff9+5IysPXSfgqEMmB8g8MQNbRE/PnbRYdN+F/qUqgGK3qS1k+W3i
         5XSqCV1KqosYE5EXDNvGyv0kFL7jJjy4XVziTbf039p1ajliCFDmh/LwcFujrJC/lxi8
         1Czw==
X-Gm-Message-State: AOAM533lWV3i1sn4y/O1VZ6cnmcgDMH03IPImUO1tQhOI19q++Uztttk
        S3ytpufn1hE9Q7vQjPko83Zkxh4xJfGQsyj53lQtwA==
X-Google-Smtp-Source: ABdhPJyFOLwlR8I9Bg1F0fAgTkcLVbi7HmUXzBM9i0OHXXoGTHuh3F0SqSKOAkqWSmcK7VWaUvIp0yq8PXMVkqa1oGI=
X-Received: by 2002:a02:661c:: with SMTP id k28mr691150jac.78.1616150277139;
 Fri, 19 Mar 2021 03:37:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210318212441.69050-1-erik.rosen@metormote.com>
 <20210318212441.69050-3-erik.rosen@metormote.com> <bd7acdcd-2bbc-70f5-d7a6-76a269e8f6a7@roeck-us.net>
In-Reply-To: <bd7acdcd-2bbc-70f5-d7a6-76a269e8f6a7@roeck-us.net>
From:   Erik Rosen <erik.rosen@metormote.com>
Date:   Fri, 19 Mar 2021 11:37:46 +0100
Message-ID: <CA+ui0Hm+zHkpqTDOkT2iR45fH5m2cGyTn2dvsOduxDM55meKZQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] hwmon: (pmbus/tps53679) Add support for TPS53676
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2021 at 12:04 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 3/18/21 2:24 PM, Erik Rosen wrote:
> > Add support for TI TPS53676 controller to the tps53679 pmbus driver
> >
> > The driver uses the USER_DATA_03 register to figure out how many phases=
 are
> > enabled and to which channel they are assigned, and sets the number of =
pages
>
> checkpatch complains about the line length here. Picky, but just move pag=
es
> to the next line.

Sorry, forgot to run checkpath after changing the comment.

>
> > and phases accordingly.
> >
> > Signed-off-by: Erik Rosen <erik.rosen@metormote.com>
> > ---
> >  Documentation/hwmon/tps53679.rst | 13 +++++++--
> >  drivers/hwmon/pmbus/Kconfig      |  4 +--
> >  drivers/hwmon/pmbus/tps53679.c   | 49 +++++++++++++++++++++++++++++++-
> >  3 files changed, 61 insertions(+), 5 deletions(-)
> >
> > diff --git a/Documentation/hwmon/tps53679.rst b/Documentation/hwmon/tps=
53679.rst
> > index c7c589e49789..3b9561648c24 100644
> > --- a/Documentation/hwmon/tps53679.rst
> > +++ b/Documentation/hwmon/tps53679.rst
> > @@ -19,6 +19,14 @@ Supported chips:
> >
> >      Datasheet: https://www.ti.com/lit/gpn/TPS53667
> >
> > +  * Texas Instruments TPS53676
> > +
> > +    Prefix: 'tps53676'
> > +
> > +    Addresses scanned: -
> > +
> > +    Datasheet: https://www.ti.com/lit/gpn/TPS53676
> > +
> >    * Texas Instruments TPS53679
> >
> >      Prefix: 'tps53679'
> > @@ -136,7 +144,7 @@ power1_input              Measured input power.
> >  power[N]_label               "pout[1-2]".
> >
> >                       - TPS53647, TPS53667: N=3D2
> > -                     - TPS53679, TPS53681, TPS53588: N=3D2,3
> > +                     - TPS53676, TPS53679, TPS53681, TPS53588: N=3D2,3
> >
> >  power[N]_input               Measured output power.
> >
> > @@ -156,10 +164,11 @@ curr[N]_label           "iout[1-2]" or "iout1.[0-=
5]".
> >
> >                       The first digit is the output channel, the second
> >                       digit is the phase within the channel. Per-phase
> > -                     telemetry supported on TPS53681 only.
> > +                     telemetry supported on TPS53676 and TPS53681 only=
.
> >
> >                       - TPS53647, TPS53667: N=3D2
> >                       - TPS53679, TPS53588: N=3D2,3
> > +                     - TPS53676: N=3D2-8
> >                       - TPS53681: N=3D2-9
> >
> >  curr[N]_input                Measured output current.
> > diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
> > index 32d2fc850621..35956a9227d8 100644
> > --- a/drivers/hwmon/pmbus/Kconfig
> > +++ b/drivers/hwmon/pmbus/Kconfig
> > @@ -257,10 +257,10 @@ config SENSORS_TPS40422
> >         be called tps40422.
> >
> >  config SENSORS_TPS53679
> > -     tristate "TI TPS53647, TPS53667, TPS53679, TPS53681, TPS53688"
> > +     tristate "TI TPS53647, TPS53667, TPS53676, TPS53679, TPS53681, TP=
S53688"
> >       help
> >         If you say yes here you get hardware monitoring support for TI
> > -       TPS53647, TPS53667, TPS53679, TPS53681, and TPS53688.
> > +       TPS53647, TPS53667, TPS53676, TPS53679, TPS53681, and TPS53688.
> >
> >         This driver can also be built as a module. If so, the module wi=
ll
> >         be called tps53679.
> > diff --git a/drivers/hwmon/pmbus/tps53679.c b/drivers/hwmon/pmbus/tps53=
679.c
> > index ba838fa311c3..d8e5f71ff162 100644
> > --- a/drivers/hwmon/pmbus/tps53679.c
> > +++ b/drivers/hwmon/pmbus/tps53679.c
> > @@ -16,11 +16,14 @@
> >  #include "pmbus.h"
> >
> >  enum chips {
> > -     tps53647, tps53667, tps53679, tps53681, tps53688
> > +     tps53647, tps53667, tps53676, tps53679, tps53681, tps53688
> >  };
> >
> >  #define TPS53647_PAGE_NUM            1
> >
> > +#define TPS53676_USER_DATA_03                0xb3
> > +#define TPS53676_MAX_PHASES          7
> > +
> >  #define TPS53679_PROT_VR12_5MV               0x01 /* VR12.0 mode, 5-mV=
 DAC */
> >  #define TPS53679_PROT_VR12_5_10MV    0x02 /* VR12.5 mode, 10-mV DAC */
> >  #define TPS53679_PROT_VR13_10MV              0x04 /* VR13.0 mode, 10-m=
V DAC */
> > @@ -143,6 +146,43 @@ static int tps53681_identify(struct i2c_client *cl=
ient,
> >                                           TPS53681_DEVICE_ID);
> >  }
> >
> > +static int tps53676_identify(struct i2c_client *client,
> > +                          struct pmbus_driver_info *info)
> > +{
> > +     u8 buf[I2C_SMBUS_BLOCK_MAX];
> > +     int phases_a =3D 0, phases_b =3D 0;
> > +     int i, ret;
> > +
> > +     ret =3D i2c_smbus_read_block_data(client, PMBUS_IC_DEVICE_ID, buf=
);
> > +     if (ret < 0)
> > +             return ret;
> > +     if (strncmp("TI\x53\x67\x60", buf, 5)) {
>
> Someone should have a serious talk with the chip designer.

It's like; "Gee, I have this great idea how to save 2 bytes by using
this amazing
new hybrid ascii/binary format I just invented"

>
> > +             dev_err(&client->dev, "Unexpected device ID: %s\n", buf);
> > +             return -ENODEV;
> > +     }
> > +
> > +     ret =3D i2c_smbus_read_block_data(client, TPS53676_USER_DATA_03, =
buf);
> > +     if (ret < 0)
> > +             return ret;
>
> You'll probably want to add a check to ensure that ret >=3D TPS53676_MAX_=
PHASES * 2 + 1
> or maybe =3D=3D 24.

Yes; and if it's not equal to 24 something probably went wrong, so
I'll check f=C3=B6r that.

>
> > +     for (i =3D 0; i < 2 * TPS53676_MAX_PHASES; i +=3D 2) {
> > +             if (buf[i + 1] & 0x80) {
> > +                     if (buf[i] & 0x08)
> > +                             phases_b++;
> > +                     else
> > +                             phases_a++;
> > +             }
> > +     }
> > +
> > +     info->format[PSC_VOLTAGE_OUT] =3D linear;
> > +     info->pages =3D 1;
> > +     info->phases[0] =3D phases_a;
> > +     if (phases_b > 0) {
> > +             info->pages =3D 2;
> > +             info->phases[1] =3D phases_b;
> > +     }
> > +     return 0;
> > +}
> > +
> >  static int tps53681_read_word_data(struct i2c_client *client, int page=
,
> >                                  int phase, int reg)
> >  {
> > @@ -183,6 +223,7 @@ static struct pmbus_driver_info tps53679_info =3D {
> >       .pfunc[3] =3D PMBUS_HAVE_IOUT,
> >       .pfunc[4] =3D PMBUS_HAVE_IOUT,
> >       .pfunc[5] =3D PMBUS_HAVE_IOUT,
> > +     .pfunc[6] =3D PMBUS_HAVE_IOUT,
> >  };
> >
> >  static int tps53679_probe(struct i2c_client *client)
> > @@ -206,6 +247,9 @@ static int tps53679_probe(struct i2c_client *client=
)
> >               info->pages =3D TPS53647_PAGE_NUM;
> >               info->identify =3D tps53679_identify;
> >               break;
> > +     case tps53676:
> > +             info->identify =3D tps53676_identify;
> > +             break;
> >       case tps53679:
> >       case tps53688:
> >               info->pages =3D TPS53679_PAGE_NUM;
> > @@ -227,9 +271,11 @@ static int tps53679_probe(struct i2c_client *clien=
t)
> >  static const struct i2c_device_id tps53679_id[] =3D {
> >       {"tps53647", tps53647},
> >       {"tps53667", tps53667},
> > +     {"tps53676", tps53676},
> >       {"tps53679", tps53679},
> >       {"tps53681", tps53681},
> >       {"tps53688", tps53688},
> > +     {"bmr474", tps53676},
>
> Please move to the top for alphabetic order.

Ok, was a bit uncertain about that...

>
> >       {}
> >  };
> >
> > @@ -238,6 +284,7 @@ MODULE_DEVICE_TABLE(i2c, tps53679_id);
> >  static const struct of_device_id __maybe_unused tps53679_of_match[] =
=3D {
> >       {.compatible =3D "ti,tps53647", .data =3D (void *)tps53647},
> >       {.compatible =3D "ti,tps53667", .data =3D (void *)tps53667},
> > +     {.compatible =3D "ti,tps53676", .data =3D (void *)tps53676},
> >       {.compatible =3D "ti,tps53679", .data =3D (void *)tps53679},
> >       {.compatible =3D "ti,tps53681", .data =3D (void *)tps53681},
> >       {.compatible =3D "ti,tps53688", .data =3D (void *)tps53688},
> >
>
