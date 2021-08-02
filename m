Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96EC53DD341
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 11:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233086AbhHBJs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 05:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbhHBJs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 05:48:26 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6FF7C06175F;
        Mon,  2 Aug 2021 02:48:16 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id h1so19551310iol.9;
        Mon, 02 Aug 2021 02:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7VJN9coUj641Ea95F5lMRABO7Nnq6GDbggtDm5h+bTU=;
        b=phRrON+jhVbtuRpte9+NLBqqEXzfNMKPaJ8X9NwnL2GM3tXiblf8T8liO+HpiDc8a8
         9Q04yecQwEvyIibJ0qXD8wxjck6xGiRErLjqUzTi3kpPPkNCSMFFWxLzSEAAlu39IHf4
         gKxoSbjiDyoM2rNk5itPlH+IlL3vn6OV5WHNqm9tclj58ZkUJwawB9GxpRt6ZOplQhN2
         sYZ36R06dTVk/lvWMVtm0xWP7cfsqznY69g5RRv9g3hVxSnjtxvVqTq8+gj3nhi9fdPg
         OSwK2gUqMFa4ewRPOO3gXXevDsExBXYWFsY/fVxJbqiwLpphL0setaAq/RWaMjurjsgq
         0fbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7VJN9coUj641Ea95F5lMRABO7Nnq6GDbggtDm5h+bTU=;
        b=LTNEIPLdPwN8pil2NtpxQ/7sK5hcu+fCBxvnMxJ/1GcWMI3xqZ3KbGdKMdOOND+3Il
         YBWRaHxmUJBHsswzkbOXJx+eDTgo+apmfbSQqCG7pE13u+54CjR99irO1TK9eEzFtXlO
         koYBz5NoGhP1JLoU2my15JAqXOI+iUP0+KPiY7ppIkbJo/QV9ibOKc2LE1s03uvA21zs
         SJLkjUX7O9T4B2EMlqCfDP27yDdk6aYD417To8Ty4YjxCKj3qw8qoNvih7BuasOZ7uW2
         P94kDHIccNIgEy3TBtGJy19CBAsCRZduQlWL+zo7YZ1xe0AE2eRPF4J2xwGg/CN7wNOB
         0tsw==
X-Gm-Message-State: AOAM532cMnQUtMVk320Q+Ml41XyCCisNYBFN/fXiiTdJJJ79eP4ZM+tO
        ToKUoJsmgJvK14dnQjs4vfM+TRlG+5+YyqgswHU=
X-Google-Smtp-Source: ABdhPJzZzxnHU0Xpc6eJrlt8pb4p3ErTsBmKgl+ERCpTdiWfQ7o3KolLyU71hpDs9sntTqcKFl7GNQXoUmlsbFVto+8=
X-Received: by 2002:a05:6638:418f:: with SMTP id az15mr14310888jab.8.1627897696239;
 Mon, 02 Aug 2021 02:48:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210708115804.212-1-alistair@alistair23.me> <20210708115804.212-3-alistair@alistair23.me>
 <YPbkz/qpgWe8rvi5@google.com>
In-Reply-To: <YPbkz/qpgWe8rvi5@google.com>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Mon, 2 Aug 2021 19:48:00 +1000
Message-ID: <CAKmqyKNSciaX6TZ=PTe2qtchJzMHw-2Dxw2dRSpFiphOvGx5gA@mail.gmail.com>
Subject: Re: [PATCH v7 3/6] hwmon: sy7636a: Add temperature driver for sy7636a
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Alistair Francis <alistair@alistair23.me>,
        Rob Herring <robh+dt@kernel.org>, lgirdwood@gmail.com,
        Mark Brown <broonie@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2021 at 12:59 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Thu, 08 Jul 2021, Alistair Francis wrote:
>
> > This is a multi-function device to interface with the sy7636a
> > EPD PMIC chip from Silergy.
> >
> > Signed-off-by: Alistair Francis <alistair@alistair23.me>
> > ---
> >  arch/arm/configs/imx_v6_v7_defconfig |   1 +
> >  drivers/hwmon/Kconfig                |  10 +++
> >  drivers/hwmon/Makefile               |   1 +
> >  drivers/hwmon/sy7636a-hwmon.c        | 106 +++++++++++++++++++++++++++
> >  4 files changed, 118 insertions(+)
> >  create mode 100644 drivers/hwmon/sy7636a-hwmon.c
> >
> > diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/im=
x_v6_v7_defconfig
> > index cd80e85d37cf..e9c0be5629c6 100644
> > --- a/arch/arm/configs/imx_v6_v7_defconfig
> > +++ b/arch/arm/configs/imx_v6_v7_defconfig
> > @@ -227,6 +227,7 @@ CONFIG_RN5T618_POWER=3Dm
> >  CONFIG_SENSORS_MC13783_ADC=3Dy
> >  CONFIG_SENSORS_GPIO_FAN=3Dy
> >  CONFIG_SENSORS_IIO_HWMON=3Dy
> > +CONFIG_SENSORS_SY7636A=3Dy
> >  CONFIG_THERMAL_STATISTICS=3Dy
> >  CONFIG_THERMAL_WRITABLE_TRIPS=3Dy
> >  CONFIG_CPU_THERMAL=3Dy
> > diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> > index e3675377bc5d..6cae12de59cd 100644
> > --- a/drivers/hwmon/Kconfig
> > +++ b/drivers/hwmon/Kconfig
> > @@ -1631,6 +1631,16 @@ config SENSORS_SIS5595
> >         This driver can also be built as a module. If so, the module
> >         will be called sis5595.
> >
> > +config SENSORS_SY7636A
> > +     tristate "Silergy SY7636A"
> > +     depends on I2C
> > +     help
> > +       If you say yes here you get support for the thermistor readout =
of
> > +       the Silergy SY7636A PMIC.
> > +
> > +       This driver can also be built as a module.  If so, the module
> > +       will be called sy7636a-hwmon.
> > +
> >  config SENSORS_DME1737
> >       tristate "SMSC DME1737, SCH311x and compatibles"
> >       depends on I2C && !PPC
> > diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> > index d712c61c1f5e..8b2e09e25b24 100644
> > --- a/drivers/hwmon/Makefile
> > +++ b/drivers/hwmon/Makefile
> > @@ -180,6 +180,7 @@ obj-$(CONFIG_SENSORS_SMSC47M1)    +=3D smsc47m1.o
> >  obj-$(CONFIG_SENSORS_SMSC47M192)+=3D smsc47m192.o
> >  obj-$(CONFIG_SENSORS_SPARX5) +=3D sparx5-temp.o
> >  obj-$(CONFIG_SENSORS_STTS751)        +=3D stts751.o
> > +obj-$(CONFIG_SENSORS_SY7636A)        +=3D sy7636a-hwmon.o
> >  obj-$(CONFIG_SENSORS_AMC6821)        +=3D amc6821.o
> >  obj-$(CONFIG_SENSORS_TC74)   +=3D tc74.o
> >  obj-$(CONFIG_SENSORS_THMC50) +=3D thmc50.o
> > diff --git a/drivers/hwmon/sy7636a-hwmon.c b/drivers/hwmon/sy7636a-hwmo=
n.c
> > new file mode 100644
> > index 000000000000..4edbee99b693
> > --- /dev/null
> > +++ b/drivers/hwmon/sy7636a-hwmon.c
> > @@ -0,0 +1,106 @@
> > +/*
> > + * Functions to access SY3686A power management chip temperature
> > + *
> > + * Copyright (C) 2019 reMarkable AS - http://www.remarkable.com/
> > + *
> > + * Author: Lars Ivar Miljeteig <lars.ivar.miljeteig@remarkable.com>
> > + *
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public License as
> > + * published by the Free Software Foundation version 2.
> > + *
> > + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> > + * kind, whether express or implied; without even the implied warranty
> > + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
>
> The long form isn't usually accepted anymore.
>
> Please replace with SPDX.
>
> > + */
> > +
> > +
> > +#include <linux/module.h>
> > +#include <linux/init.h>
> > +#include <linux/slab.h>
> > +#include <linux/jiffies.h>
> > +#include <linux/hwmon.h>
> > +#include <linux/hwmon-sysfs.h>
> > +#include <linux/err.h>
> > +#include <linux/sysfs.h>
> > +#include <linux/platform_device.h>
> > +
> > +#include <linux/mfd/sy7636a.h>
> > +
> > +struct sy7636a_data {
> > +     struct sy7636a *sy7636a;
> > +     struct device *hwmon_dev;
> > +};
> > +
> > +static ssize_t show_temp(struct device *dev,
> > +     struct device_attribute *attr, char *buf)
> > +{
> > +     unsigned int reg_val;
> > +     signed char temp;
> > +     int ret;
> > +     struct sy7636a_data *data =3D dev_get_drvdata(dev);
> > +
> > +     ret =3D regmap_read(data->sy7636a->regmap,
> > +                     SY7636A_REG_TERMISTOR_READOUT, &reg_val);
> > +     if (ret)
> > +             return ret;
> > +
> > +     temp =3D *((signed char*)&reg_val);
>
> Whoa!  What's going on here?
>
> You also need to run checkpatch.pl.
>
> > +     return snprintf(buf, PAGE_SIZE, "%d\n", temp);
> > +}
> > +
> > +static SENSOR_DEVICE_ATTR(temp0, S_IRUGO, show_temp, NULL, 0);
> > +
> > +static struct attribute *sy7636a_attrs[] =3D {
> > +     &sensor_dev_attr_temp0.dev_attr.attr,
> > +     NULL
> > +};
> > +
> > +ATTRIBUTE_GROUPS(sy7636a);
> > +
> > +static int sy7636a_sensor_probe(struct platform_device *pdev)
> > +{
> > +     struct sy7636a *sy7636a =3D dev_get_drvdata(pdev->dev.parent);
> > +     struct sy7636a_data *data;
> > +     int err;
> > +
> > +     if (!sy7636a)
> > +             return -EPROBE_DEFER;
> > +
> > +     data =3D devm_kzalloc(&pdev->dev, sizeof(struct sy7636a_data), GF=
P_KERNEL);
>
> Where is this used, outside of this function?

Removed.

>
> Not sure I see a good reason for having it around?
>
> > +     if (!data) {
> > +             return -ENOMEM;
> > +     }
> > +
> > +     data->sy7636a =3D sy7636a;
> > +     data->hwmon_dev =3D devm_hwmon_device_register_with_groups(&pdev-=
>dev,
>
> Why is this being stored into a struct?

Good point, removed.

>
> > +                     "sy7636a_temperature", data, sy7636a_groups);
> > +     if (IS_ERR(data->hwmon_dev)) {
> > +             err =3D PTR_ERR(data->hwmon_dev);
> > +             dev_err(&pdev->dev, "Unable to register hwmon device, ret=
urned %d", err);
> > +             return err;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct platform_device_id sy7636a_sensor_id[] =3D {
> > +     { "sy7636a-temperature", 0},
> > +     { },
> > +};
> > +MODULE_DEVICE_TABLE(platform, sy7636a_sensor_id);
> > +
> > +static struct platform_driver sy7636a_sensor_driver =3D {
> > +     .probe =3D sy7636a_sensor_probe,
> > +     .id_table =3D sy7636a_sensor_id,
>
> What does this do?

Removed

Alistair

>
> Where is the 'device' being registered?
>
> > +     .driver =3D {
> > +             .name =3D "sy7636a-temperature",
> > +     },
> > +};
> > +module_platform_driver(sy7636a_sensor_driver);
> > +
> > +MODULE_DESCRIPTION("SY7636A sensor driver");
> > +MODULE_LICENSE("GPL");
> > +
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Senior Technical Lead - Developer Services
> Linaro.org =E2=94=82 Open source software for Arm SoCs
> Follow Linaro: Facebook | Twitter | Blog
