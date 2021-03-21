Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10DB13430A3
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 03:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbhCUCUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 22:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbhCUCUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 22:20:16 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F23C061574;
        Sat, 20 Mar 2021 19:20:16 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id d10so4845857ils.5;
        Sat, 20 Mar 2021 19:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6vyPSv5vYHYn7BwH2z2S8KVGWB8bjZkNvfwo/ur6ED8=;
        b=JFoxQ+C2PdvCdNG+q8zxujfGL5zau0nz1Ai+gh1lhBE2NVsUSC9CQYZZVYtD9fjehZ
         5ZjY6id7Q4uJfaYAh7OGicF5XqJPjTPb6ppnO87QS2qP3bbd7peFG4cEbylMMOnJ50RR
         +A8UL1YXs8GujMJX5m470ri1nC03+I934Bkd5ASDqT1KbpVRXoJBbmMol+1OEngdhqY5
         HstkHtZDtz4IbMRsJBx4RD6YxXbYVlRLwEym55ginVMtYUR8pr2U5ARAOE/Ey+lNQGSh
         3yOI8igqdy4N63Wd+CIih0pH9ii4AydctMwUsSRjE7+O5UYkyUzbdNPC9rJ5lO8QkVIt
         /tpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6vyPSv5vYHYn7BwH2z2S8KVGWB8bjZkNvfwo/ur6ED8=;
        b=JINT1IF74MjLL997diMvmtGscRK/BM2Np1o6A4octZTk4pNBDwvg8gXzUNbdXHla0K
         MYJmqAIa5p2ZXlYfbvogcy5aNo93GEtKaQNqT1PSNv7y7Niyj7/hVEPU8Y3oihzzrUXt
         9coCMZAl0NDwfBjCo3GkRCipH/Smddh9mlOcQ3hNo8cb27UchSg8m7xsUQzH3DAMlTUS
         mQNLSbrKPdaPC7HdlPkmBLGUjLZzbCiT9OgGTawXHPXoExA3kro7AqMagBEABmEoNgjp
         3dWRDvhsYHHpLtvzXv/9LmuQry/eyBnlNffr00BmnhdW27SepfAcuPemLxUcTlTtPvxu
         mo3Q==
X-Gm-Message-State: AOAM530GhUuV4kqCUVaTem6+OhpQ19fIXUjIaRvdwpmGW2VvnaZHp3Ss
        rB7wYxGmBbHFHh4aWNjMk+U/ettC/DBnP7h9hZA=
X-Google-Smtp-Source: ABdhPJwB+ggysp6yrrq0C80/e9IylLqFspMTeuU7Z3mpHIRyV8b+1IMRPDfJsV3PFEvRSZODUD7hpYE7hE2agPFVOJo=
X-Received: by 2002:a05:6e02:1748:: with SMTP id y8mr7146482ill.131.1616293215458;
 Sat, 20 Mar 2021 19:20:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210117042539.1609-1-alistair@alistair23.me> <20210117042539.1609-2-alistair@alistair23.me>
 <20210204103126.GA2789116@dell>
In-Reply-To: <20210204103126.GA2789116@dell>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Sat, 20 Mar 2021 22:18:23 -0400
Message-ID: <CAKmqyKOJ251sRUaxUKJ_U=puYRkypPEHAVZOnAKbQtP2skMJBA@mail.gmail.com>
Subject: Re: [PATCH 2/6] mfd: Initial commit of sy7636a
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

On Thu, Feb 4, 2021 at 5:31 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Sat, 16 Jan 2021, Alistair Francis wrote:
>
> > Initial support for the Silergy SY7636A Power Management chip
> > driver.
>
> Please remove "driver", as this is not support for the driver, it *is*
> the driver which supports the chip.

Sorry for the long delay here.

I have addressed your comments.

>
> > Signed-off-by: Alistair Francis <alistair@alistair23.me>
> > ---
> >  drivers/mfd/Kconfig         |  10 ++
> >  drivers/mfd/Makefile        |   2 +
> >  drivers/mfd/sy7636a.c       | 252 ++++++++++++++++++++++++++++++++++++
> >  include/linux/mfd/sy7636a.h |  50 +++++++
> >  4 files changed, 314 insertions(+)
> >  create mode 100644 drivers/mfd/sy7636a.c
> >  create mode 100644 include/linux/mfd/sy7636a.h
> >
> > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > index bdfce7b15621..c8c62d92433c 100644
> > --- a/drivers/mfd/Kconfig
> > +++ b/drivers/mfd/Kconfig
> > @@ -1360,6 +1360,16 @@ config MFD_SYSCON
> >         Select this option to enable accessing system control registers
> >         via regmap.
> >
> > +config MFD_SY7636A
> > +     tristate "Silergy SY7636A Power Management chip driver"
>
> Again, please remove the word "driver" here.
>
> > +     select MFD_CORE
> > +     select REGMAP_I2C
> > +     select REGMAP_IRQ
> > +     depends on I2C=3Dy
> > +     help
> > +       Select this option to enable support for the Silergy SY7636A
> > +       Power Management chip driver.
>
> And again.

I removed "driver" from all of these.

>
> >  config MFD_DAVINCI_VOICECODEC
> >       tristate
> >       select MFD_CORE
> > diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> > index 14fdb188af02..1fa1e635f506 100644
> > --- a/drivers/mfd/Makefile
> > +++ b/drivers/mfd/Makefile
> > @@ -265,6 +265,8 @@ obj-$(CONFIG_MFD_ROHM_BD718XX)    +=3D rohm-bd718x7=
.o
> >  obj-$(CONFIG_MFD_STMFX)      +=3D stmfx.o
> >  obj-$(CONFIG_MFD_KHADAS_MCU)         +=3D khadas-mcu.o
> >
> > +obj-$(CONFIG_MFD_SY7636A)    +=3D sy7636a.o
> > +
>
> Why does this have to be segregated?

Fixed

>
> >  obj-$(CONFIG_SGI_MFD_IOC3)   +=3D ioc3.o
> >  obj-$(CONFIG_MFD_SIMPLE_MFD_I2C)     +=3D simple-mfd-i2c.o
> >  obj-$(CONFIG_MFD_INTEL_M10_BMC)   +=3D intel-m10-bmc.o
> > diff --git a/drivers/mfd/sy7636a.c b/drivers/mfd/sy7636a.c
> > new file mode 100644
> > index 000000000000..39aac965d854
> > --- /dev/null
> > +++ b/drivers/mfd/sy7636a.c
> > @@ -0,0 +1,252 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * MFD driver for SY7636A chip
>
> "Parent driver".
>
> > + * Copyright (C) 2019 reMarkable AS - http://www.remarkable.com/
>
> This is quite out of date.  Please update.

I don't own this copyright, so I would rather not change it.

>
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
> This test is replaced by the SPDX header above.

Removed.

>
> > + * Based on the lp87565 driver by Keerthy <j-keerthy@ti.com>
> > + */
> > +
> > +#include <linux/interrupt.h>
> > +#include <linux/mfd/core.h>
> > +#include <linux/module.h>
> > +#include <linux/of_device.h>
> > +#include <linux/regmap.h>
> > +#include <linux/sysfs.h>
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
> > +
> > +static const struct of_device_id of_sy7636a_match_table[] =3D {
> > +     { .compatible =3D "silergy,sy7636a", },
> > +     {}
> > +};
> > +MODULE_DEVICE_TABLE(of, of_sy7636a_match_table);
>
> Please move this to where it is used i.e. at the bottom of the file.

Done.

>
> > +static const char * const states[] =3D {
> > +     "no fault event",
> > +     "UVP at VP rail",
> > +     "UVP at VN rail",
> > +     "UVP at VPOS rail",
> > +     "UVP at VNEG rail",
> > +     "UVP at VDDH rail",
> > +     "UVP at VEE rail",
> > +     "SCP at VP rail",
> > +     "SCP at VN rail",
> > +     "SCP at VPOS rail",
> > +     "SCP at VNEG rail",
> > +     "SCP at VDDH rail",
> > +     "SCP at VEE rail",
> > +     "SCP at V COM rail",
> > +     "UVLO",
> > +     "Thermal shutdown",
> > +};
> > +
> > +int get_vcom_voltage_mv(struct regmap *regmap)
> > +{
> > +     int ret;
> > +     unsigned int val, val_h;
> > +
> > +     ret =3D regmap_read(regmap, SY7636A_REG_VCOM_ADJUST_CTRL_L, &val)=
;
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D regmap_read(regmap, SY7636A_REG_VCOM_ADJUST_CTRL_H, &val_=
h);
> > +     if (ret)
> > +             return ret;
> > +
> > +     val |=3D (val_h << 8);
>
> Please define the shifts and masks.
>
> > +     return (val & 0x1FF) * 10;
>
> What's 10?
>
> > +}
> > +
> > +int set_vcom_voltage_mv(struct regmap *regmap, unsigned int vcom)
> > +{
> > +     int ret;
> > +     unsigned int val;
> > +
> > +     if (vcom < 0 || vcom > 5000)
>
> Please define min/max values.
>
> > +             return -EINVAL;
> > +
> > +     val =3D (unsigned int)(vcom / 10) & 0x1ff;
>
> As above.

I have used defines for all of these.

>
> > +     ret =3D regmap_write(regmap, SY7636A_REG_VCOM_ADJUST_CTRL_L, val)=
;
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D regmap_write(regmap, SY7636A_REG_VCOM_ADJUST_CTRL_H, val =
>> 8);
> > +     if (ret)
> > +             return ret;
> > +
> > +     return 0;
> > +}
>
> Who calls these?

They sysfs store and show functions.

>
> > +static ssize_t state_show(struct device *dev, struct device_attribute =
*attr,
> > +             char *buf)
> > +{
> > +     int ret;
> > +     unsigned int val;
> > +     struct sy7636a *sy7636a =3D dev_get_drvdata(dev);
> > +
> > +     ret =3D regmap_read(sy7636a->regmap, SY7636A_REG_FAULT_FLAG, &val=
);
> > +     if (ret) {
> > +             dev_err(sy7636a->dev, "Failed to read from device\n");
> > +             return ret;
> > +     }
> > +
> > +     val =3D val >> 1;
>
> Why 1?

I used a define here to make it clearer

>
> > +     if (val >=3D ARRAY_SIZE(states)) {
> > +             dev_err(sy7636a->dev, "Unexpected value read from device:=
 %u\n", val);
> > +             return -EINVAL;
> > +     }
> > +
> > +     return snprintf(buf, PAGE_SIZE, "%s\n", states[val]);
> > +}
> > +static DEVICE_ATTR(state, 0444, state_show, NULL);
>
> You need to document new sysfs entries.

I'm not sure how to document this. Do you mind pointing out an example
I can use?

>
> > +static ssize_t power_good_show(struct device *dev, struct device_attri=
bute *attr,
> > +             char *buf)
> > +{
> > +     int ret;
> > +     unsigned int val;
> > +     struct sy7636a *sy7636a =3D dev_get_drvdata(dev);
> > +
> > +     ret =3D regmap_read(sy7636a->regmap, SY7636A_REG_FAULT_FLAG, &val=
);
> > +     if (ret) {
> > +             dev_err(sy7636a->dev, "Failed to read from device\n");
> > +             return ret;
> > +     }
> > +
> > +     val &=3D 0x01;
> > +
> > +     return snprintf(buf, PAGE_SIZE, "%s\n", val ? "ON" : "OFF");
>
> Doesn't 0 just mean "no fault event"?

The LSB is reserved, so we don't clear that.

>
> > +}
> > +static DEVICE_ATTR(power_good, 0444, power_good_show, NULL);
> > +
> > +static ssize_t vcom_show(struct device *dev, struct device_attribute *=
attr,
> > +             char *buf)
> > +{
> > +     int ret;
> > +     struct sy7636a *sy7636a =3D dev_get_drvdata(dev);
> > +
> > +     ret =3D get_vcom_voltage_mv(sy7636a->regmap);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     return snprintf(buf, PAGE_SIZE, "%d\n", -ret);
> > +}
> > +
>
> Remove this line please.
>
> > +static ssize_t vcom_store(struct device *dev,
> > +             struct device_attribute *attr, const char *buf, size_t co=
unt)
> > +{
> > +     int ret;
> > +     int vcom;
> > +     struct sy7636a *sy7636a =3D dev_get_drvdata(dev);
> > +
> > +     ret =3D kstrtoint(buf, 0, &vcom);
> > +     if (ret)
> > +             return ret;
> > +
> > +     if (vcom > 0 || vcom < -5000)
> > +             return -EINVAL;
> > +
> > +     ret =3D set_vcom_voltage_mv(sy7636a->regmap, (unsigned int)(-vcom=
));
> > +     if (ret)
> > +             return ret;
> > +
> > +     return count;
> > +}
> > +static DEVICE_ATTR(vcom, 0644, vcom_show, vcom_store);
> > +
> > +static struct attribute *sy7636a_sysfs_attrs[] =3D {
> > +     &dev_attr_state.attr,
> > +     &dev_attr_power_good.attr,
> > +     &dev_attr_vcom.attr,
> > +     NULL,
> > +};
>
> These all look like power options?  Do they really belong here?

From what I can tell I think they do. Let me know if you don't think so.

>
> > +static const struct attribute_group sy7636a_sysfs_attr_group =3D {
> > +     .attrs =3D sy7636a_sysfs_attrs,
> > +};
> > +
> > +static int sy7636a_probe(struct i2c_client *client,
> > +                      const struct i2c_device_id *ids)
> > +{
> > +     struct sy7636a *sy7636a;
> > +     int ret;
> > +
> > +     sy7636a =3D devm_kzalloc(&client->dev, sizeof(struct sy7636a), GF=
P_KERNEL);
>
> sizeof(*sy7636a)
>
> > +     if (sy7636a =3D=3D NULL)
>
> if (!sy7636a)
>
> > +             return -ENOMEM;
> > +
> > +     sy7636a->dev =3D &client->dev;
> > +
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
> > +     ret =3D sysfs_create_group(&client->dev.kobj, &sy7636a_sysfs_attr=
_group);
> > +     if (ret) {
> > +             dev_err(sy7636a->dev, "Failed to create sysfs attributes\=
n");
> > +             return ret;
> > +     }
> > +
> > +     ret =3D devm_mfd_add_devices(sy7636a->dev, PLATFORM_DEVID_AUTO,
> > +                                     sy7636a_cells, ARRAY_SIZE(sy7636a=
_cells),
> > +                                     NULL, 0, NULL);
> > +     if (ret) {
> > +             dev_err(sy7636a->dev, "Failed to add mfd devices\n");
>
> "Failed to add child devices"
>
> > +             sysfs_remove_group(&client->dev.kobj, &sy7636a_sysfs_attr=
_group);
> > +             return ret;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct i2c_device_id sy7636a_id_table[] =3D {
> > +     { "sy7636a", 0 },
> > +     { },
> > +};
> > +MODULE_DEVICE_TABLE(i2c, sy7636a_id_table);
>
> If you use .probe2, you can omit this table.
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
>
> s/Multi-Function Device Driver/Power Management Chip/
>
> > +MODULE_LICENSE("GPL v2");
> > diff --git a/include/linux/mfd/sy7636a.h b/include/linux/mfd/sy7636a.h
> > new file mode 100644
> > index 000000000000..642789c4d0a9
> > --- /dev/null
> > +++ b/include/linux/mfd/sy7636a.h
> > @@ -0,0 +1,50 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * Functions to access SY3686A power management chip.
> > + *
> > + * Copyright (C) 2019 reMarkable AS - http://www.remarkable.com/
> > + *
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public License as
> > + * published by the Free Software Foundation version 2.
> > + *
> > + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> > + * kind, whether express or implied; without even the implied warranty
> > + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + */
>
> Same issues as mentioned above.
>
> > +#ifndef __LINUX_MFD_SY7636A_H
> > +#define __LINUX_MFD_SY7636A_H
>
> Just MFD is fine.
>
> > +#include <linux/i2c.h>
> > +#include <linux/regulator/driver.h>
> > +#include <linux/regulator/machine.h>
> > +#include <linux/regmap.h>
>
> Alphabetical.
>
> > +#define SY7636A_REG_OPERATION_MODE_CRL 0x00
> > +#define SY7636A_OPERATION_MODE_CRL_VCOMCTL (1 << 6)
> > +#define SY7636A_OPERATION_MODE_CRL_ONOFF (1 << 7)
> > +#define SY7636A_REG_VCOM_ADJUST_CTRL_L 0x01
> > +#define SY7636A_REG_VCOM_ADJUST_CTRL_H 0x02
> > +#define SY7636A_REG_VCOM_ADJUST_CTRL_MASK 0x01ff
> > +#define SY7636A_REG_VLDO_VOLTAGE_ADJULST_CTRL 0x03
> > +#define SY7636A_REG_POWER_ON_DELAY_TIME 0x06
> > +#define SY7636A_REG_FAULT_FLAG 0x07
> > +#define SY7636A_FAULT_FLAG_PG (1 << 0)
> > +#define SY7636A_REG_TERMISTOR_READOUT 0x08
>
> Tab out the values please.
>
> Use BIT()
>
> > +#define SY7636A_REG_MAX 0x08
> > +
> > +struct sy7636a {
> > +     struct device *dev;
> > +     struct regmap *regmap;
> > +     unsigned int vcom;
>
> Where is this used?
>
> > +     struct gpio_desc *pgood_gpio;
>
> Where is this used?
>
> > +     struct mutex reglock;
>
> Where is this used?

I have removed these.

>
> > +};
> > +
> > +int get_vcom_voltage_mv(struct regmap *regmap);
> > +int set_vcom_voltage_mv(struct regmap *regmap, unsigned int vcom);
>
> What calls these?

I have just made these internal to the driver.


Alistair

>
> > +#endif /* __LINUX_MFD_SY7636A_H */
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Senior Technical Lead - Developer Services
> Linaro.org =E2=94=82 Open source software for Arm SoCs
> Follow Linaro: Facebook | Twitter | Blog
