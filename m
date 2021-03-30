Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0FE034DF62
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 05:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbhC3Dbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 23:31:43 -0400
Received: from office2.cesnet.cz ([195.113.144.244]:35798 "EHLO
        office2.cesnet.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbhC3Dbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 23:31:36 -0400
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by office2.cesnet.cz (Postfix) with ESMTPSA id CAF6B40006C;
        Tue, 30 Mar 2021 05:31:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
        s=office2-2020; t=1617075094;
        bh=LP1PSoXZTfQf04wWkDNv+jCILYRKUJALSw2+oo2Ff2A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc;
        b=A8KcF5caNFi0XGeNwvcjD3E0TK7kIw/7BnddjsFK3KLCL6+mO34QOCRwg4IC3FO79
         g1Z5JVkQLG87gapCoteju87Idqck0S3g0jgPsMwCX7wVKSHO3zjErKoA2hiaOASlbq
         WB7m5BkEZ4IS4l/x+b6OjrG+bwTr1D6K/F+C6PuftsrA1uaJg3zckxL8YyX6ZZr+9C
         57/IK0JOz528qU/LG5xhZh+JjfudxFZh9/9XX0Z61+HsX+XT1Rbg7LL3GC/Gj/nBQV
         6oL03FX2D/voUdoMh6UvxHsznixOm0T+qiOmkTTqPtCg4OEVS5y3kB2GPfL3gqx1Bv
         k1Ef27Vqe3ZUA==
Received: by mail-lj1-f179.google.com with SMTP id f26so18252014ljp.8;
        Mon, 29 Mar 2021 20:31:34 -0700 (PDT)
X-Gm-Message-State: AOAM532Hj7C8ku+RpLc41Y1RjNUvloE5SxUHTs8Uzk+aBv2ApIqKrQ9s
        Fa+Zus3m1aYpZaod+udras0Yfzi53Regufg4A84=
X-Google-Smtp-Source: ABdhPJziACrlIuF6Qj0OF/9ttdrWKQAGEg1bNO1Bxuw2hCueA4/rB3zTR1yhdSxLqXkA8jWC2uB0++0uSHaegeYF75A=
X-Received: by 2002:a2e:b4b1:: with SMTP id q17mr19847747ljm.497.1617075093600;
 Mon, 29 Mar 2021 20:31:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210329143833.1047539-1-kubernat@cesnet.cz> <a5e4ad25-1395-0df5-a128-d0fdb98cc1ea@roeck-us.net>
In-Reply-To: <a5e4ad25-1395-0df5-a128-d0fdb98cc1ea@roeck-us.net>
From:   =?UTF-8?B?VsOhY2xhdiBLdWJlcm7DoXQ=?= <kubernat@cesnet.cz>
Date:   Tue, 30 Mar 2021 05:31:22 +0200
X-Gmail-Original-Message-ID: <CABKa3nrgjC3ZxG8vCAfBYGE382iDADUS4MTYu6YdHipqH-+QuQ@mail.gmail.com>
Message-ID: <CABKa3nrgjC3ZxG8vCAfBYGE382iDADUS4MTYu6YdHipqH-+QuQ@mail.gmail.com>
Subject: Re: [PATCH] hwmon: Add driver for fsp-3y PSUs and PDUs
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

Thank you for the review.

po 29. 3. 2021 v 19:47 odes=C3=ADlatel Guenter Roeck <linux@roeck-us.net> n=
apsal:
>
> On 3/29/21 7:38 AM, V=C3=A1clav Kubern=C3=A1t wrote:
> > After some testing, I have found out there is a timing issue with this
> > device. After setting page, the device doesn't immediately react and
> > gives values from the previous page for some time. This is why there
> > needs to be a delay between pmbus_set_page and the actual read.
> >
> > Also, a lot of the standard commands don't work with the devices, so
> > they are filtered out in the custom read function.
> >
>
> This is not an appropriate patch description. Describe the driver here,
> not the workarounds / quirks. The reason for the delay should be a
> comment in the patch, not in the patch description.
>
> Also, "don't work" is inappropriate (and, again, does not belong into
> the patch description). It is perfectly appropriate for the core
> to try those commands to see if they are supported. The only reason
> to mask them out would be that the device reacts badly to seeing
> them. If that is the case, "don't work" should be replaced with
> a more detailed comment in the code. Describe what happens, and why
> the commands needs to be caught.
>
>
> What might be useful is a note indicating if you have a manual for
> those power supplies available, or if the driver is based on reverse
> engineering.
>

I will rework the commit message in a V2 patch.

> > Signed-off-by: V=C3=A1clav Kubern=C3=A1t <kubernat@cesnet.cz>
> > ---
> >  drivers/hwmon/pmbus/Kconfig  |   9 ++
> >  drivers/hwmon/pmbus/Makefile |   1 +
> >  drivers/hwmon/pmbus/fsp-3y.c | 164 +++++++++++++++++++++++++++++++++++
>
> Documentation/hwmon/fsp-3y.rst is missing.
>
> >  3 files changed, 174 insertions(+)
> >  create mode 100644 drivers/hwmon/pmbus/fsp-3y.c
> >
> > diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
> > index 03606d4298a4..66d1655b6750 100644
> > --- a/drivers/hwmon/pmbus/Kconfig
> > +++ b/drivers/hwmon/pmbus/Kconfig
> > @@ -56,6 +56,15 @@ config SENSORS_BEL_PFE
> >         This driver can also be built as a module. If so, the module wi=
ll
> >         be called bel-pfe.
> >
> > +config SENSORS_FSP_3Y
> > +     tristate "FSP/3Y-Power power supplies"
> > +     help
> > +       If you say yes here you get hardware monitoring support for
> > +       FSP/3Y-Power hot-swap power supplies.
> > +
>
> This should list the supported models - if not here, then at least in the
> (missing) documentation.
>

Okay.

> > +       This driver can also be built as a module. If so, the module wi=
ll
> > +       be called fsp-3y.
> > +
> >  config SENSORS_IBM_CFFPS
> >       tristate "IBM Common Form Factor Power Supply"
> >       depends on LEDS_CLASS
> > diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefil=
e
> > index 6a4ba0fdc1db..bfe218ad898f 100644
> > --- a/drivers/hwmon/pmbus/Makefile
> > +++ b/drivers/hwmon/pmbus/Makefile
> > @@ -8,6 +8,7 @@ obj-$(CONFIG_SENSORS_PMBUS)   +=3D pmbus.o
> >  obj-$(CONFIG_SENSORS_ADM1266)        +=3D adm1266.o
> >  obj-$(CONFIG_SENSORS_ADM1275)        +=3D adm1275.o
> >  obj-$(CONFIG_SENSORS_BEL_PFE)        +=3D bel-pfe.o
> > +obj-$(CONFIG_SENSORS_FSP_3Y) +=3D fsp-3y.o
> >  obj-$(CONFIG_SENSORS_IBM_CFFPS)      +=3D ibm-cffps.o
> >  obj-$(CONFIG_SENSORS_INSPUR_IPSPS) +=3D inspur-ipsps.o
> >  obj-$(CONFIG_SENSORS_IR35221)        +=3D ir35221.o
> > diff --git a/drivers/hwmon/pmbus/fsp-3y.c b/drivers/hwmon/pmbus/fsp-3y.=
c
> > new file mode 100644
> > index 000000000000..7f3c3de3a1e6
> > --- /dev/null
> > +++ b/drivers/hwmon/pmbus/fsp-3y.c
> > @@ -0,0 +1,164 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Hardware monitoring driver for FSP 3Y-Power PSUs
> > + *
> > + * Copyright (c) 2021 V=C3=A1clav Kubern=C3=A1t, CESNET
> > + */
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/delay.h>
> > +#include <linux/i2c.h>
>
> Alphabetic include file order, please.
>
> > +#include "pmbus.h"
> > +
> > +#define YM2151_PAGE_12V              0x00
> > +#define YM2151_PAGE_5V               0x20
> > +#define YH5151E_PAGE_12V     0x00
> > +#define YH5151E_PAGE_5V              0x10
> > +#define YH5151E_PAGE_3V3     0x11
> > +
> > +enum chips {
> > +     ym2151e,
> > +     yh5151e
> > +};
> > +
> > +static int set_page(struct i2c_client *client, int page)
> > +{
> > +     int rv;
> > +
> > +     rv =3D i2c_smbus_read_byte_data(client, PMBUS_PAGE);
> > +
> Please no empty line here.
>
> You might want to consider caching the current page to avoid having to re=
ad it
> for each access, similar to the code implemented in the pmbus core.
>

This was actually what I wanted to do at first, but I wasn't able to
get i2c_set_clientdata to work. Later I found out that it is because
pmbus_do_probe uses sets it own data. What do you think I should use
to cache the page?

> > +     if (rv < 0)
> > +             return rv;
> > +
> > +     if (rv !=3D page) {
> > +             rv =3D pmbus_set_page(client, page, 0xff);
> > +             if (rv < 0)
> > +                     return rv;
> > +
> > +             msleep(20);
>
> Please use usleep_range(), and make sure that this huge delay is actually=
 needed.
>

As is written in the original commit message, the devices have some
kind of timing issues and this delay really is needed. I have tested
smaller delays (10ms), they are compared to no delay, but I would
still sometimes get wrong values. I will move this explanation into
the code.

> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int fsp3y_read_byte_data(struct i2c_client *client, int page, i=
nt reg)
> > +{
> > +     int rv;
> > +
> > +     rv =3D set_page(client, page);
> > +     if (rv < 0)
> > +             return rv;
> > +
> > +     return i2c_smbus_read_byte_data(client, reg);
> > +}
> > +
> > +static int fsp3y_read_word_data(struct i2c_client *client, int page, i=
nt phase, int reg)
> > +{
> > +     int rv;
> > +
> > +     if (reg >=3D PMBUS_VIRT_BASE)
> > +             return -ENXIO;
> > +
> > +     switch (reg) {
> > +     case PMBUS_OT_WARN_LIMIT:
> > +     case PMBUS_OT_FAULT_LIMIT:
> > +     case PMBUS_UT_WARN_LIMIT:
> > +     case PMBUS_UT_FAULT_LIMIT:
> > +     case PMBUS_VIN_UV_WARN_LIMIT:
> > +     case PMBUS_VIN_UV_FAULT_LIMIT:
> > +     case PMBUS_VIN_OV_FAULT_LIMIT:
> > +     case PMBUS_VIN_OV_WARN_LIMIT:
> > +     case PMBUS_IOUT_OC_WARN_LIMIT:
> > +     case PMBUS_IOUT_UC_FAULT_LIMIT:
> > +     case PMBUS_IOUT_OC_FAULT_LIMIT:
> > +     case PMBUS_IIN_OC_WARN_LIMIT:
> > +     case PMBUS_IIN_OC_FAULT_LIMIT:
> > +     case PMBUS_VOUT_UV_WARN_LIMIT:
> > +     case PMBUS_VOUT_UV_FAULT_LIMIT:
> > +     case PMBUS_VOUT_OV_WARN_LIMIT:
> > +     case PMBUS_VOUT_OV_FAULT_LIMIT:
> > +     case PMBUS_MFR_VIN_MIN:
> > +     case PMBUS_MFR_VIN_MAX:
> > +     case PMBUS_MFR_IIN_MAX:
> > +     case PMBUS_MFR_VOUT_MIN:
> > +     case PMBUS_MFR_VOUT_MAX:
> > +     case PMBUS_MFR_IOUT_MAX:
> > +     case PMBUS_MFR_PIN_MAX:
> > +     case PMBUS_POUT_MAX:
> > +     case PMBUS_POUT_OP_WARN_LIMIT:
> > +     case PMBUS_POUT_OP_FAULT_LIMIT:
> > +     case PMBUS_MFR_MAX_TEMP_1:
> > +     case PMBUS_MFR_MAX_TEMP_2:
> > +     case PMBUS_MFR_MAX_TEMP_3:
> > +     case PMBUS_MFR_POUT_MAX:
> > +             return -ENXIO;
> > +     }
>
> If that many commands indeed cause trouble (ie cause the device
> to get into a bad state), it might be better to list the _supported_
> commands instead of the unsupported ones. There is no guarantee
> that the core won't start to send other commands to the device
> in the future.
>
> The underlying question is if those commands are indeed not supported,
> or if they report values in an unexpected format (ie not linear11).
> The data format that is auto-selected below (because it is not specified)
> is "linear". Is this what the device actually uses ? If not, just disabli=
ng
> reading the limits without explanation what exactly "does not work" is
> inappropriate.
>

The reason I masked these commands is because when I was reading from
the associated files, I would get weird values (like -500). But it's
not like the commands confuse the device. If you think it isn't a good
idea to mask them like that, I'm fine with removing the masking.

> > +
> > +     rv =3D set_page(client, page);
> > +     if (rv < 0)
> > +             return rv;
> > +
> > +     return i2c_smbus_read_word_data(client, reg);
> > +}
> > +
> > +struct pmbus_driver_info fsp3y_info[] =3D {
> > +     [ym2151e] =3D {
> > +             .pages =3D 0x21,
> > +             .func[YM2151_PAGE_12V] =3D
> > +                     PMBUS_HAVE_VOUT | PMBUS_HAVE_IOUT |
> > +                     PMBUS_HAVE_PIN | PMBUS_HAVE_POUT  |
> > +                     PMBUS_HAVE_TEMP | PMBUS_HAVE_TEMP2 |
> > +                     PMBUS_HAVE_VIN | PMBUS_HAVE_IIN |
> > +                     PMBUS_HAVE_FAN12,
> > +             .func[YM2151_PAGE_5V] =3D
> > +                     PMBUS_HAVE_VOUT | PMBUS_HAVE_IOUT,
> > +                     PMBUS_HAVE_IIN,
>
> It doesn't really make sense to claim support for 0x21 =3D 33
> pages, especially since the pmbus core (and the pmbus standard)
> only supports 32 pages. Since page handling is all local anyway,
> I would suggest  to claim two pages and map the logical page
> to the physical page in the set_page command.
>
> How does this work (compile) anyway ? .func[] array size
> is 32, meaning .func[0x20] goes beyond the end of the array.
> The compiler should complain about that.
>
> Wait, how does this even instantiate ? The PMBus core
> should reject a page count larger than 32, and pmbus_do_probe()
> should return -ENODEV. How did you test this code ?
>

Sorry, I forgot I was building this patch on top of another patch
(written by my colleague), which increases the page limit. The pmbus
specification does say that pages 0x00 through 0x1F are "reserved
specifically for multiple outputs on a device with a single physical
address", but it does not say that there is a page limit. Anyway, The
PSU really does use the 0x20 page. Either way, I'm fine with doing a
mapping between a logical a page and physical, if you decide you don't
want to change the page limit.

> > +             .read_word_data =3D fsp3y_read_word_data,
> > +             .read_byte_data =3D fsp3y_read_byte_data,
> > +     },
> > +     [yh5151e] =3D {
> > +             .pages =3D 0x12,
>
> Same as above.
>
> > +             .func[YH5151E_PAGE_12V] =3D
> > +                     PMBUS_HAVE_VOUT | PMBUS_HAVE_IOUT |
> > +                     PMBUS_HAVE_POUT  |
> > +                     PMBUS_HAVE_TEMP | PMBUS_HAVE_TEMP2 | PMBUS_HAVE_T=
EMP3,
> > +             .func[YH5151E_PAGE_5V] =3D
> > +                     PMBUS_HAVE_VOUT | PMBUS_HAVE_IOUT |
> > +                     PMBUS_HAVE_POUT,
> > +             .func[YH5151E_PAGE_3V3] =3D
> > +                     PMBUS_HAVE_VOUT | PMBUS_HAVE_IOUT |
> > +                     PMBUS_HAVE_POUT,
> > +             .read_word_data =3D fsp3y_read_word_data,
> > +             .read_byte_data =3D fsp3y_read_byte_data,
> > +     }
> > +};
> > +
> > +static int fsp3y_probe(struct i2c_client *client,
> > +                    const struct i2c_device_id *id)
> > +{
>
> This vendor sells dozens of different power supplies. Apparently
> they do not have compatible PMBus attributes (or at least the pages
> are not compatible to each other). Given that, I think there should
> be a model validation here.

How should I go about doing model validation? I'm already using
i2c_device_id to differentiate between the PDU and the PSU, but I
suppose, that's not the best thing. Maybe I should use an identify
function in pmbus_driver_info?

>
> This is even more important since an earlier discussion suggests that
> at least some of the 3Y power supplies use LINEAR11 instead of LINEAR16
> for output voltages (eg YH5301-1EAR, FSP550-50ERS). We need to ensure
> that affected power supplies are not enabled with this driver, and that
> the enabled power supplies have been tested and are not only confirmed
> to work and report correct data.
>


> > +     return pmbus_do_probe(client, &fsp3y_info[id->driver_data]);
> > +}
> > +
> > +static const struct i2c_device_id pmbus_id[] =3D {
> > +     {"fsp3y_ym2151e", ym2151e},
> > +     {"fsp3y_yh5151e", yh5151e},> +  {}
> > +};
> > +
> > +MODULE_DEVICE_TABLE(i2c, pmbus_id);
> > +
> > +/* This is the driver that will be inserted */
> > +static struct i2c_driver fsp3y_driver =3D {
> > +     .driver =3D {
> > +                .name =3D "fsp3y",
> > +                },
> > +     .probe =3D fsp3y_probe,
>
> Please use the .probe_new callback.
>
> > +     .id_table =3D pmbus_id
> > +};
> > +
> > +module_i2c_driver(fsp3y_driver);
> > +
> > +MODULE_AUTHOR("V=C3=A1clav Kubern=C3=A1t");
> > +MODULE_DESCRIPTION("PMBus driver for FSP/3Y-Power power supplies");
> > +MODULE_LICENSE("GPL");
> >
>

V=C3=A1clav
