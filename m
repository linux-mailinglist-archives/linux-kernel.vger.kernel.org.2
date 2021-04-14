Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B92B335E9FE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 02:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348826AbhDNA1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 20:27:54 -0400
Received: from office2.cesnet.cz ([195.113.144.244]:41778 "EHLO
        office2.cesnet.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237029AbhDNA1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 20:27:53 -0400
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by office2.cesnet.cz (Postfix) with ESMTPSA id 6385B40006E;
        Wed, 14 Apr 2021 02:27:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
        s=office2-2020; t=1618360051;
        bh=Xrh8tKS8gZtzAOSsjKlOd3hjoTP0aCfzPM2EcdNfRrc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc;
        b=NfzDAmAyELPinqXtXdlnADiDJuGvdiRtnYKlHMa0bvDGbzJ531McanNyvzNZiuKON
         ObhF+MiUl8hEFE6VuXTfCXjh5PvevXKwAVCFRssq/msci2tojMtsm/f9pomiWipyKX
         fHTSAFgCIaQSMMuowW0Su3EY0+GYoRdLiP3Yj4rRZ0iue3GpSxznp/ndn6M35cfh3u
         aaLtpBPRIHKDsAhnwBPEJ7QSSMBEzwPxV48CrHNZuPaRAu+1hPQX5HGzYfAjOwXMTO
         FTW7EiBzfByBDJdhjo+C9pSUMtw3w/PSnGIHVk7Z12gxoij5dWmqnhUhCEz2SvAq82
         BCHBfe2ZGClpg==
Received: by mail-pj1-f44.google.com with SMTP id k23-20020a17090a5917b02901043e35ad4aso11556957pji.3;
        Tue, 13 Apr 2021 17:27:31 -0700 (PDT)
X-Gm-Message-State: AOAM530D6LbXZrI/tIcThgo0mgF5L7BraKTo2bL/6u29J5ttyOIXqgje
        0fDa1DUiC9qyYQrwsF9vfmRsAPsPl6+3khlUM1Q=
X-Google-Smtp-Source: ABdhPJwLhBMeg9FXEUOjirSBOK8uvB4H7N+/vrwvt9vDufiJbH90SXNW+qgOglDHRN1V33K+GYpKwggbLpp4UsWHIxE=
X-Received: by 2002:a17:90a:318d:: with SMTP id j13mr456020pjb.174.1618360049620;
 Tue, 13 Apr 2021 17:27:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210329143833.1047539-1-kubernat@cesnet.cz> <20210413104233.1857736-1-kubernat@cesnet.cz>
 <43c5cc02-d2ad-ceee-7709-190681b81ae7@roeck-us.net>
In-Reply-To: <43c5cc02-d2ad-ceee-7709-190681b81ae7@roeck-us.net>
From:   =?UTF-8?B?VsOhY2xhdiBLdWJlcm7DoXQ=?= <kubernat@cesnet.cz>
Date:   Wed, 14 Apr 2021 02:27:18 +0200
X-Gmail-Original-Message-ID: <CABKa3no8r6iSe_yCDnzG6yDuHGR5=UOGL26FGUmbGox-4hEntA@mail.gmail.com>
Message-ID: <CABKa3no8r6iSe_yCDnzG6yDuHGR5=UOGL26FGUmbGox-4hEntA@mail.gmail.com>
Subject: Re: [PATCH v4] hwmon: Add driver for fsp-3y PSUs and PDUs
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C3=BAt 13. 4. 2021 v 16:59 odes=C3=ADlatel Guenter Roeck <linux@roeck-us.n=
et> napsal:
>
> On 4/13/21 3:42 AM, V=C3=A1clav Kubern=C3=A1t wrote:
> > This patch adds support for these devices:
> > - YH-5151E - the PDU
> > - YM-2151E - the PSU
> >
> > The device datasheet says that the devices support PMBus 1.2, but in my
> > testing, a lot of the commands aren't supported and if they are, they
> > sometimes behave strangely or inconsistently. For example, writes to th=
e
> > PAGE command requires using PEC, otherwise the write won't work and the
> > page won't switch, even though, the standard says that PEC is opiotnal.
>
> optional

Done.

>
> > On the other hand, writes the SMBALERT don't require PEC. Because of
>
> s/writes the/writes to/ ?

Done.

>
> > this, the driver is mostly reverse engineered with the help of a tool
> > called pmbus_peek written by David Brownell (and later adopted by my
> > colleague Jan Kundr=C3=A1t).
> >
> > The device also has some sort of a timing issue when switching pages,
> > which is explained further in the code.
> >
> > Because of this, the driver support is limited. It exposes only the
> > values, that have been tested to work correctly.
> >
>
> You might want to add those details into the driver code, below the
> copyright line. It would be more valuable there than in the commit log.
>

Done.

> > Signed-off-by: V=C3=A1clav Kubern=C3=A1t <kubernat@cesnet.cz>
> > ---
> >  Documentation/hwmon/fsp-3y.rst |  26 ++++
>
> Needs to be added to index.rst.

Done.

>
> >  drivers/hwmon/pmbus/Kconfig    |  10 ++
> >  drivers/hwmon/pmbus/Makefile   |   1 +
> >  drivers/hwmon/pmbus/fsp-3y.c   | 239 +++++++++++++++++++++++++++++++++
> >  4 files changed, 276 insertions(+)
> >  create mode 100644 Documentation/hwmon/fsp-3y.rst
> >  create mode 100644 drivers/hwmon/pmbus/fsp-3y.c
> >
> > diff --git a/Documentation/hwmon/fsp-3y.rst b/Documentation/hwmon/fsp-3=
y.rst
> > new file mode 100644
> > index 000000000000..68a547021846
> > --- /dev/null
> > +++ b/Documentation/hwmon/fsp-3y.rst
> > @@ -0,0 +1,26 @@
> > +Kernel driver fsp3y
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +Supported devices:
> > +  * 3Y POWER YH-5151E
> > +  * 3Y POWER YM-2151E
> > +
> > +Author: V=C3=A1clav Kubern=C3=A1t <kubernat@cesnet.cz>
> > +
> > +Description
> > +-----------
> > +This driver implements limited support for two 3Y POWER devices.
> > +
> > +Sysfs entries
> > +-------------
> > +in1_input            input voltage
> > +in2_input            12V output voltage
> > +in3_input            5V output voltage
> > +curr1_input          input current
> > +curr2_input          12V output current
> > +curr3_input          5V output current
> > +fan1_input           fan rpm
> > +temp1_input          temperature 1
> > +temp2_input          temperature 2
> > +temp3_input          temperature 3
> > +power1_input         input power
> > +power2_input         output power
> > diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
> > index 03606d4298a4..9d12d446396c 100644
> > --- a/drivers/hwmon/pmbus/Kconfig
> > +++ b/drivers/hwmon/pmbus/Kconfig
> > @@ -56,6 +56,16 @@ config SENSORS_BEL_PFE
> >         This driver can also be built as a module. If so, the module wi=
ll
> >         be called bel-pfe.
> >
> > +config SENSORS_FSP_3Y
> > +     tristate "FSP/3Y-Power power supplies"
> > +     help
> > +       If you say yes here you get hardware monitoring support for
> > +       FSP/3Y-Power hot-swap power supplies.
> > +       Supported models: YH-5151E, YM-2151E
> > +
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
> > index 000000000000..2185ab119fd2
> > --- /dev/null
> > +++ b/drivers/hwmon/pmbus/fsp-3y.c
> > @@ -0,0 +1,239 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Hardware monitoring driver for FSP 3Y-Power PSUs
> > + *
> > + * Copyright (c) 2021 V=C3=A1clav Kubern=C3=A1t, CESNET
> > + */
> > +
> > +#include <linux/delay.h>
> > +#include <linux/i2c.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include "pmbus.h"
> > +
> > +#define YM2151_PAGE_12V_LOG  0x00
> > +#define YM2151_PAGE_12V_REAL 0x00
> > +#define YM2151_PAGE_5VSB_LOG 0x01
> > +#define YM2151_PAGE_5VSB_REAL        0x20
> > +#define YH5151E_PAGE_12V_LOG 0x00
> > +#define YH5151E_PAGE_12V_REAL        0x00
> > +#define YH5151E_PAGE_5V_LOG  0x01
> > +#define YH5151E_PAGE_5V_REAL 0x10
> > +#define YH5151E_PAGE_3V3_LOG 0x02
> > +#define YH5151E_PAGE_3V3_REAL        0x11
> > +
> > +enum chips {
> > +     ym2151e,
> > +     yh5151e
> > +};
> > +
> > +struct fsp3y_data {
> > +     struct pmbus_driver_info info;
> > +     int chip;
> > +     int page;
> > +};
> > +
> > +#define to_fsp3y_data(x) container_of(x, struct fsp3y_data, info)
> > +
> > +static int page_log_to_page_real(int page_log, enum chips chip)
> > +{
> > +     switch (chip) {
> > +     case ym2151e:
> > +             switch (page_log) {
> > +             case YM2151_PAGE_12V_LOG:
> > +                     return YM2151_PAGE_12V_REAL;
> > +             case YM2151_PAGE_5VSB_LOG:
> > +                     return YM2151_PAGE_5VSB_REAL;
> > +             }
> > +             return -EINVAL;
> > +     case yh5151e:
> > +             switch (page_log) {
> > +             case YH5151E_PAGE_12V_LOG:
> > +                     return YH5151E_PAGE_12V_REAL;
> > +             case YH5151E_PAGE_5V_LOG:
> > +                     return YH5151E_PAGE_5V_LOG;
> > +             case YH5151E_PAGE_3V3_LOG:
> > +                     return YH5151E_PAGE_3V3_REAL;
> > +             }
> > +             return -EINVAL;
> > +     }
> > +
> > +     return -EINVAL;
> > +}
> > +
> > +static int set_page(struct i2c_client *client, int page_log)
> > +{
> > +     const struct pmbus_driver_info *info =3D pmbus_get_driver_info(cl=
ient);
> > +     struct fsp3y_data *data =3D to_fsp3y_data(info);
> > +     int rv;
> > +     int page_real;
> > +
> > +     if (page_log < 0)
> > +             return 0;
> > +
> > +     page_real =3D page_log_to_page_real(page_log, data->chip);
> > +     if (page_real < 0)
> > +             return page_real;
> > +
> > +     if (data->page !=3D page_real) {
> > +             rv =3D i2c_smbus_write_byte_data(client, PMBUS_PAGE, page=
_real);
> > +             if (rv < 0)
> > +                     return rv;
> > +
> > +             data->page =3D page_real;
> > +
> > +             /* Testing showed that the device has a timing issue. Aft=
er
>
> Somehow network subsystem multi-line alignments slipped in.
> Not in hwmon, please. I cringe at those; it makes my brain focus on the
> comment (because it is asynchronous) instead of the code.
>

Done.

> > +              * setting a page, it takes a while, before the device ac=
tually
> > +              * gives the correct values from the correct page. 20 ms =
was
> > +              * tested to be enough to not give wrong values (15 ms wa=
sn't
> > +              * enough)
> > +              */
> > +             usleep_range(20000, 30000);
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
> > +     /* This masks commands which weren't tested to work correctly. So=
me of the masked commands
> > +      * return either 0xFFFF. These would probably get tagged as inval=
id by pmbus_core. Other
>
> s/either// ?

Done.

>
> > +      * ones do return values, which might be useful (that is, they ar=
e not 0xFFFF), but their
>
> s/values,/values/

Done.

>
> > +      * encoding is unknown, and so they are unsupported.
> > +      */
> > +     switch (reg) {
> > +     case PMBUS_READ_FAN_SPEED_1:
> > +     case PMBUS_READ_IIN:
> > +     case PMBUS_READ_IOUT:
> > +     case PMBUS_READ_PIN:
> > +     case PMBUS_READ_POUT:
> > +     case PMBUS_READ_TEMPERATURE_1:
> > +     case PMBUS_READ_TEMPERATURE_2:
> > +     case PMBUS_READ_TEMPERATURE_3:
> > +     case PMBUS_READ_VIN:
> > +     case PMBUS_READ_VOUT:
> > +     case PMBUS_STATUS_WORD:
> > +             break;
> > +     default:
> > +             return -ENXIO;
> > +     }
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
> > +             .pages =3D 2,
> > +             .func[YM2151_PAGE_12V_LOG] =3D
> > +                     PMBUS_HAVE_VOUT | PMBUS_HAVE_IOUT |
> > +                     PMBUS_HAVE_PIN | PMBUS_HAVE_POUT  |
> > +                     PMBUS_HAVE_TEMP | PMBUS_HAVE_TEMP2 |
> > +                     PMBUS_HAVE_VIN | PMBUS_HAVE_IIN |
> > +                     PMBUS_HAVE_FAN12,
> > +             .func[YM2151_PAGE_5VSB_LOG] =3D
> > +                     PMBUS_HAVE_VOUT | PMBUS_HAVE_IOUT,
> > +                     PMBUS_HAVE_IIN,
> > +             .read_word_data =3D fsp3y_read_word_data,
> > +             .read_byte_data =3D fsp3y_read_byte_data,
> > +     },
> > +     [yh5151e] =3D {
> > +             .pages =3D 3,
> > +             .func[YH5151E_PAGE_12V_LOG] =3D
> > +                     PMBUS_HAVE_VOUT | PMBUS_HAVE_IOUT |
> > +                     PMBUS_HAVE_POUT  |
> > +                     PMBUS_HAVE_TEMP | PMBUS_HAVE_TEMP2 | PMBUS_HAVE_T=
EMP3,
> > +             .func[YH5151E_PAGE_5V_LOG] =3D
> > +                     PMBUS_HAVE_VOUT | PMBUS_HAVE_IOUT |
> > +                     PMBUS_HAVE_POUT,
> > +             .func[YH5151E_PAGE_3V3_LOG] =3D
> > +                     PMBUS_HAVE_VOUT | PMBUS_HAVE_IOUT |
> > +                     PMBUS_HAVE_POUT,
> > +             .read_word_data =3D fsp3y_read_word_data,
> > +             .read_byte_data =3D fsp3y_read_byte_data,
> > +     }
> > +};
> > +
> > +static int fsp3y_detect(struct i2c_client *client)
> > +{
> > +     int rv;
> > +     u8 buf[I2C_SMBUS_BLOCK_MAX];
> > +
> > +     rv =3D i2c_smbus_read_block_data(client, PMBUS_MFR_MODEL, buf);
> > +     if (rv < 0)
> > +             return rv;
> > +
> > +     if (rv =3D=3D 8 && !strncmp(buf, "YM-2151E", strlen("YM-2151E")))
> > +             return ym2151e;
> > +     else if (rv =3D=3D 8 && !strncmp(buf, "YH-5151E", strlen("YH-5151=
E")))
> > +             return yh5151e;
>
> better
>         if (rv =3D=3D 8) {
>                 /* rest of check */
>         }
>

Done.

> > +
> > +     dev_err(&client->dev, "Unsupported model %.*s\n", rv, buf);
>
> Sorry I didn't notice before. This assumes that the buffer is zero-termin=
ated,
> which may not be the case. For this to work, add another byte to the buff=
er
> (u8 buf[I2C_SMBUS_BLOCK_MAX + 1];), and add
>         buf[rv] =3D '\0';
>
> You could actually do that before checking the returned strings and then =
just
> use strcmp() for the model comparisons, without bothering about the retur=
n
> length.
>

Done.

> > +     return -ENODEV;
> > +}
> > +
> > +static const struct i2c_device_id fsp3y_id[] =3D {
> > +     {"ym2151e", ym2151e},
> > +     {"yh5151e", yh5151e}
> > +};
> > +
> > +static int fsp3y_probe(struct i2c_client *client)
> > +{
> > +     struct fsp3y_data *data;
> > +     const struct i2c_device_id *id;
> > +     int rv;
> > +
> > +     data =3D devm_kzalloc(&client->dev, sizeof(struct fsp3y_data), GF=
P_KERNEL);
> > +     if (!data)
> > +             return -ENOMEM;
> > +
> > +     data->chip =3D fsp3y_detect(client);
> > +     if (data->chip < 0)
> > +             return data->chip;
> > +
> > +     id =3D i2c_match_id(fsp3y_id, client);
> > +     if (data->chip !=3D id->driver_data)
> > +             dev_warn(&client->dev, "Device mismatch: Configured %s (%=
d), detected %d\n", id->name, (int)id->driver_data, data->chip);
> > +
> > +     rv =3D i2c_smbus_read_byte_data(client, PMBUS_PAGE);
> > +     if (rv < 0)
> > +             return rv;
> > +     data->page =3D rv;
> > +
> > +     data->info =3D fsp3y_info[data->chip];
> > +
> > +     return pmbus_do_probe(client, &data->info);
> > +}
> > +
> > +MODULE_DEVICE_TABLE(i2c, pmbus_id);
> > +
> > +/* This is the driver that will be inserted */
>
> Nit: Useless comment
>

Done.

> > +static struct i2c_driver fsp3y_driver =3D {
> > +     .driver =3D {
> > +                .name =3D "fsp3y",
> > +                },
> > +     .probe_new =3D fsp3y_probe,
> > +     .id_table =3D fsp3y_id
> > +};
> > +
> > +module_i2c_driver(fsp3y_driver);
> > +
> > +MODULE_AUTHOR("V=C3=A1clav Kubern=C3=A1t");
> > +MODULE_DESCRIPTION("PMBus driver for FSP/3Y-Power power supplies");
> > +MODULE_LICENSE("GPL");
> >
>
