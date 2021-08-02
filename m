Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 698673DD2EC
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 11:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232987AbhHBJ03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 05:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232711AbhHBJ02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 05:26:28 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FFDBC06175F;
        Mon,  2 Aug 2021 02:26:19 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id r6so11207376ioj.8;
        Mon, 02 Aug 2021 02:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=18E76JPhXYFbClr4VqDEwz/5Y+xmxd8uszFiV1cKczI=;
        b=vcZ3rCWgr/hGTW9hCBFa69BmTJdkla2bmIfjp6CzCrtqSYPCMLY1L4OwmxxmnktjAU
         CzpKlLmyq0XvgjV3NqTkYUBFq/lZcES9D21FJLcb/blPwFTReVDhfQ/21Qlwwt25kiGO
         gGKiQfsN8i50OLn4VqcVy2fAJdECF8GukdW3Ce9xgb7wDsTIwmIdew5c6i43w6KuCURa
         bziG9HUXbvdDNOxVA/WQw9BIFMQ8LtDaN1pgYUrcYnIRqm3HoJJ8p8E2nRzmz5G05qaW
         swUD8LdydWiVwz3arsJo3MRwk6GVQVxtIQf6JS+WRGgt2KOzGTWnWSysxKixnZb/G4V9
         1H6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=18E76JPhXYFbClr4VqDEwz/5Y+xmxd8uszFiV1cKczI=;
        b=E7XN0ZvVrumACoPQXWsc0YYSK9CyEOp0+cpbCruCjckUhYvGjB8H1yPva+PSG29bCy
         ndGOEuKlFjLIUr3ifTXNo3+tOesMVNxfD5twhTGJ//ZOb2BYsHrU14uuMBXZo9v708nL
         8F2C6YnR2/r0OGfdt1MLXu2x1vfZKjoHjTkwl7zuLCCywBpZPbJWnlQmDWMvwMq9mhPw
         t+QTS5U7w+nnd8XtTpWyKJsXVtjpOQHe2mj+CvNjiayAJ6MpzIHG0sJ3eBVaxThPbury
         3ILkhxOc/ubClKOTTcI6Hu0vouqe70CNhggEjWBgRwbMXmscw3IhPtIm9iMqOocR1YZX
         1Y1Q==
X-Gm-Message-State: AOAM531F0GBoRhA/DTal7auRCaHaO3uda0AxroV3jkKbLvLwF+VPvCq/
        Xgi8f22VFU0GU4PsQF5Hn8BXrxTc1SULyWlXUrs=
X-Google-Smtp-Source: ABdhPJyYivSeg8liCMlsbBhsEpv5djQAziNQ0KrIelJXmBrzJPacwgNUhrkLnY15W5Rxx+RI80MQDCnUcEXgEF1Mgbg=
X-Received: by 2002:a6b:f101:: with SMTP id e1mr397390iog.118.1627896378556;
 Mon, 02 Aug 2021 02:26:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210708115804.212-1-alistair@alistair23.me> <YPbjZdu7T9wFcvNz@google.com>
In-Reply-To: <YPbjZdu7T9wFcvNz@google.com>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Mon, 2 Aug 2021 19:26:00 +1000
Message-ID: <CAKmqyKO_MEFy-TWy2+3o3+pomQaSQ5WeAcE3Zy-iquas09RfRA@mail.gmail.com>
Subject: Re: [PATCH v7 1/6] mfd: sy7636a: Initial commit
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

On Wed, Jul 21, 2021 at 12:53 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Thu, 08 Jul 2021, Alistair Francis wrote:
>
> > Initial support for the Silergy SY7636A Power Management chip.
> >
> > Signed-off-by: Alistair Francis <alistair@alistair23.me>
> > ---
> >  drivers/mfd/Kconfig         |  9 +++++
> >  drivers/mfd/Makefile        |  1 +
> >  drivers/mfd/sy7636a.c       | 81 +++++++++++++++++++++++++++++++++++++
> >  include/linux/mfd/sy7636a.h | 47 +++++++++++++++++++++
> >  4 files changed, 138 insertions(+)
> >  create mode 100644 drivers/mfd/sy7636a.c
> >  create mode 100644 include/linux/mfd/sy7636a.h
> >
> > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > index 6a3fd2d75f96..7b59aa0fd3f2 100644
> > --- a/drivers/mfd/Kconfig
> > +++ b/drivers/mfd/Kconfig
> > @@ -1352,6 +1352,15 @@ config MFD_SYSCON
> >         Select this option to enable accessing system control registers
> >         via regmap.
> >
> > +config MFD_SY7636A
> > +     tristate "Silergy SY7636A Power Management chip"
>
> s/chip/IC/
>
> > +     select MFD_CORE
> > +     select REGMAP_I2C
> > +     depends on I2C
> > +     help
> > +       Select this option to enable support for the Silergy SY7636A
> > +       Power Management chip.
>
> As above.
>
> >  config MFD_DAVINCI_VOICECODEC
> >       tristate
> >       select MFD_CORE
> > diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> > index 8116c19d5fd4..cbe581e87fa9 100644
> > --- a/drivers/mfd/Makefile
> > +++ b/drivers/mfd/Makefile
> > @@ -266,6 +266,7 @@ obj-$(CONFIG_MFD_KHADAS_MCU)      +=3D khadas-mcu.o
> >  obj-$(CONFIG_MFD_ACER_A500_EC)       +=3D acer-ec-a500.o
> >  obj-$(CONFIG_MFD_QCOM_PM8008)        +=3D qcom-pm8008.o
> >
> > +obj-$(CONFIG_MFD_SY7636A)    +=3D sy7636a.o
> >  obj-$(CONFIG_SGI_MFD_IOC3)   +=3D ioc3.o
> >  obj-$(CONFIG_MFD_SIMPLE_MFD_I2C)     +=3D simple-mfd-i2c.o
> >  obj-$(CONFIG_MFD_INTEL_M10_BMC)   +=3D intel-m10-bmc.o
> > diff --git a/drivers/mfd/sy7636a.c b/drivers/mfd/sy7636a.c
> > new file mode 100644
> > index 000000000000..345892e11221
> > --- /dev/null
> > +++ b/drivers/mfd/sy7636a.c
> > @@ -0,0 +1,81 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +//
> > +// MFD parent driver for SY7636A chip
> > +//
> > +// Copyright (C) 2021 reMarkable AS - http://www.remarkable.com/
> > +//
> > +// Authors: Lars Ivar Miljeteig <lars.ivar.miljeteig@remarkable.com>
> > +//          Alistair Francis <alistair@alistair23.me>
>
> Only C++ comments for the SPDX please.
>
> > +// Based on the lp87565 driver by Keerthy <j-keerthy@ti.com>
> > +
> > +#include <linux/interrupt.h>
> > +#include <linux/mfd/core.h>
> > +#include <linux/module.h>
> > +#include <linux/of_device.h>
> > +
> > +#include <linux/mfd/sy7636a.h>
> > +
> > +static const struct regmap_config sy7636a_regmap_config =3D {
> > +     .reg_bits =3D 8,
> > +     .val_bits =3D 8,
> > +};
> > +
> > +static const struct mfd_cell sy7636a_cells[] =3D {
> > +     { .name =3D "sy7636a-regulator", },
> > +     { .name =3D "sy7636a-temperature", },
> > +     { .name =3D "sy7636a-thermal", },
> > +};
>
> If you put these in the Device Tree, you can use "simple-mfd-i2c"
>
> > +static const struct of_device_id of_sy7636a_match_table[] =3D {
> > +     { .compatible =3D "silergy,sy7636a", },
> > +     {}
> > +};
> > +MODULE_DEVICE_TABLE(of, of_sy7636a_match_table);
>
> Place this near the i2c_device_id table please.
>
> > +static int sy7636a_probe(struct i2c_client *client,
> > +                      const struct i2c_device_id *ids)
> > +{
> > +     struct sy7636a *sy7636a;
>
> Please call this ddata.
>
> > +     int ret;
> > +
> > +     sy7636a =3D devm_kzalloc(&client->dev, sizeof(*sy7636a), GFP_KERN=
EL);
> > +     if (!sy7636a)
> > +             return -ENOMEM;
> > +
> > +     sy7636a->dev =3D &client->dev;
>
> What are you using 'dev' for?
>
> You can normally just use 'dev->parent' from the child device.

I didn't realise that, I have removed `dev`.

>
> > +     sy7636a->regmap =3D devm_regmap_init_i2c(client, &sy7636a_regmap_=
config);
> > +     if (IS_ERR(sy7636a->regmap)) {
> > +             ret =3D PTR_ERR(sy7636a->regmap);
> > +             dev_err(sy7636a->dev,
> > +                     "Failed to initialize register map: %d\n", ret);
> > +             return ret;
> > +     }
> > +
> > +     i2c_set_clientdata(client, sy7636a);
> > +
> > +     return devm_mfd_add_devices(sy7636a->dev, PLATFORM_DEVID_AUTO,
> > +                                     sy7636a_cells, ARRAY_SIZE(sy7636a=
_cells),
> > +                                     NULL, 0, NULL);
> > +}
> > +
> > +static const struct i2c_device_id sy7636a_id_table[] =3D {
> > +     { "sy7636a", 0 },
> > +     { },
> > +};
> > +MODULE_DEVICE_TABLE(i2c, sy7636a_id_table);
>
> Use probe_new below, then you can omit this table.
>
> > +static struct i2c_driver sy7636a_driver =3D {
> > +     .driver =3D {
> > +             .name   =3D "sy7636a",
> > +             .of_match_table =3D of_sy7636a_match_table,
> > +     },
> > +     .probe =3D sy7636a_probe,
> > +     .id_table =3D sy7636a_id_table,
> > +};
> > +module_i2c_driver(sy7636a_driver);
> > +
> > +MODULE_AUTHOR("Lars Ivar Miljeteig <lars.ivar.miljeteig@remarkable.com=
>");
> > +MODULE_DESCRIPTION("Silergy SY7636A Multi-Function Device Driver");
> > +MODULE_LICENSE("GPL v2");
> > diff --git a/include/linux/mfd/sy7636a.h b/include/linux/mfd/sy7636a.h
> > new file mode 100644
> > index 000000000000..b6845a3572b8
> > --- /dev/null
> > +++ b/include/linux/mfd/sy7636a.h
> > @@ -0,0 +1,47 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * Functions to access SY3686A power management chip.
> > + *
> > + * Copyright (C) 2021 reMarkable AS - http://www.remarkable.com/
> > + */
> > +
> > +#ifndef __MFD_SY7636A_H
> > +#define __MFD_SY7636A_H
> > +
> > +#include <linux/i2c.h>
> > +#include <linux/regmap.h>
> > +#include <linux/regulator/driver.h>
> > +#include <linux/regulator/machine.h>
> > +
> > +#define SY7636A_REG_OPERATION_MODE_CRL               0x00
> > +#define SY7636A_OPERATION_MODE_CRL_VCOMCTL   BIT(6)
> > +#define SY7636A_OPERATION_MODE_CRL_ONOFF     BIT(7)
> > +#define SY7636A_REG_VCOM_ADJUST_CTRL_L               0x01
> > +#define SY7636A_REG_VCOM_ADJUST_CTRL_H               0x02
> > +#define SY7636A_REG_VCOM_ADJUST_CTRL_MASK    0x01ff
> > +#define SY7636A_REG_VLDO_VOLTAGE_ADJULST_CTRL        0x03
> > +#define SY7636A_REG_POWER_ON_DELAY_TIME              0x06
> > +#define SY7636A_REG_FAULT_FLAG                       0x07
> > +#define SY7636A_FAULT_FLAG_PG                        BIT(0)
> > +#define SY7636A_REG_TERMISTOR_READOUT                0x08
> > +
> > +#define SY7636A_REG_MAX                              0x08
> > +
> > +#define VCOM_MIN             0
> > +#define VCOM_MAX             5000
> > +
> > +#define VCOM_ADJUST_CTRL_MASK        0x1ff
> > +// Used to shift the high byte
> > +#define VCOM_ADJUST_CTRL_SHIFT       8
> > +// Used to scale from VCOM_ADJUST_CTRL to mv
> > +#define VCOM_ADJUST_CTRL_SCAL        10000
> > +
> > +#define FAULT_FLAG_SHIFT     1
> > +
> > +struct sy7636a {
> > +     struct device *dev;
> > +     struct regmap *regmap;
> > +     struct gpio_desc *pgood_gpio;
>
> This looks unused?

It is used in the syy636a-regulator

Alistair

>
> > +};
> > +
> > +#endif /* __LINUX_MFD_SY7636A_H */
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Senior Technical Lead - Developer Services
> Linaro.org =E2=94=82 Open source software for Arm SoCs
> Follow Linaro: Facebook | Twitter | Blog
