Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7D33D89B4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 10:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235338AbhG1IXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 04:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234622AbhG1IXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 04:23:46 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883E6C061757;
        Wed, 28 Jul 2021 01:23:44 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id y9so2023222iox.2;
        Wed, 28 Jul 2021 01:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BHRQe/NXKSWGINsqX/5ht0asDFVZXhpTjaqEyLAp8iQ=;
        b=f4R5h8rHwjNRDcFhQpO+nFnKl7gzDqXaXJphhDFoEMC7ID4QbdjISfxkOGLgyrBPd2
         ELH3IVhzcI00ZbfMFKKTr4S0NaW2VdUP1Ts4/uSf+xVvV4Yr+FQ2SpYQCL0a+QBo2PWY
         D1uhohCp/IrBNMUJ5U1Y5QJQTEnRMl0As5ayGalqYccNdP+SbPjipliMdErda+dSHI2b
         bNx9MX0ni3h1WXFkazqgIZN3zHoyT+rgrwrW6DCKBw2Xe494RkyQRa01y/5CztP8THiL
         zhAqb2Y+yuZMAVKdm1qElqtVU/x8pzfHcQJIjHkIfS24k7/iRrFyrwjoeIQFMii4/wNL
         Px7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BHRQe/NXKSWGINsqX/5ht0asDFVZXhpTjaqEyLAp8iQ=;
        b=s8i6ftYTdLsEmpEmaPw+4n7NRDi/z9ietAaPUT5oxX8tY77xc2NDmTSNt78w/ToAmC
         UKKvgfVJ6wWvHdZzPrC5hlUDG5AIh6vb2JiDxmGD+5pCMzwBJkpDMYmpovnJD6mYTv8/
         Dr0ljdQglzrTxFZOhgAGh5N5aFELxEupXpDsIJf11Nf7p6E4ECCmj9bfFY6wflwI0yQc
         7PEokgGuKOZ7Voen2gyvAQtZ24n33b0mdurHBdJzAGJQGpdZEfMpmkbQODnbZB2RFHCy
         ktCBX4KowCbt6w/kWBjNywggeud5iLi8vSq9EAO3c1qe17QUrkfV7ie3YVbH6f5tTw+F
         fnEg==
X-Gm-Message-State: AOAM532xYzUF7f+p6cOSFiGnis6sq8LPb4GgbGIKidQoEUOMnZsTojqV
        MnYop6QjbgZreMY2BbwMC27JQMgnDjt2fDL1928=
X-Google-Smtp-Source: ABdhPJx11RO5zHDczyDw9MbFyxglT8NFnsb/x0592Aoyb05bjy4rDzl+WEeek+wxwPIjJjX7x/sMngLK2/11/h1ciso=
X-Received: by 2002:a05:6638:25c7:: with SMTP id u7mr25080782jat.26.1627460623965;
 Wed, 28 Jul 2021 01:23:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210708115804.212-1-alistair@alistair23.me> <20210708115804.212-2-alistair@alistair23.me>
 <YPblgabAObekmVZs@google.com>
In-Reply-To: <YPblgabAObekmVZs@google.com>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Wed, 28 Jul 2021 18:23:17 +1000
Message-ID: <CAKmqyKPk5mksq7KK0FOBLLLyw+3o52EjtkqOMe0tMg5OgxOkJw@mail.gmail.com>
Subject: Re: [PATCH v7 2/6] thermal: sy7636a: Add thermal driver for sy7636a
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Alistair Francis <alistair@alistair23.me>,
        Rob Herring <robh+dt@kernel.org>, lgirdwood@gmail.com,
        Mark Brown <broonie@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lars Ivar Miljeteig <lars.ivar.miljeteig@remarkable.no>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2021 at 1:02 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Thu, 08 Jul 2021, Alistair Francis wrote:
>
> > From: Lars Ivar Miljeteig <lars.ivar.miljeteig@remarkable.no>
> >
> > Add thermal driver to enable kernel based polling
> > and shutdown of device for temperatures out of spec
> >
> > Signed-off-by: Alistair Francis <alistair@alistair23.me>
> > ---
> >  drivers/thermal/Kconfig           |   7 ++
> >  drivers/thermal/Makefile          |   1 +
> >  drivers/thermal/sy7636a_thermal.c | 107 ++++++++++++++++++++++++++++++
> >  3 files changed, 115 insertions(+)
> >  create mode 100644 drivers/thermal/sy7636a_thermal.c
> >
> > diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> > index d7f44deab5b1..7112c63d9021 100644
> > --- a/drivers/thermal/Kconfig
> > +++ b/drivers/thermal/Kconfig
> > @@ -450,6 +450,13 @@ depends on (ARCH_STI || ARCH_STM32) && OF
> >  source "drivers/thermal/st/Kconfig"
> >  endmenu
> >
> > +config SY7636A_THERMAL
> > +     tristate "SY7636A thermal management"
> > +     depends on MFD_SY7636A
> > +     help
> > +       Enable the sy7636a thermal driver, which supports the
> > +       temperature sensor embedded in Silabs SY7636A chip.
> > +
> >  source "drivers/thermal/tegra/Kconfig"
> >
> >  config GENERIC_ADC_THERMAL
> > diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> > index 82fc3e616e54..2e1aca8a0a09 100644
> > --- a/drivers/thermal/Makefile
> > +++ b/drivers/thermal/Makefile
> > @@ -51,6 +51,7 @@ obj-$(CONFIG_DA9062_THERMAL)        += da9062-thermal.o
> >  obj-y                                += intel/
> >  obj-$(CONFIG_TI_SOC_THERMAL) += ti-soc-thermal/
> >  obj-y                                += st/
> > +obj-$(CONFIG_SY7636A_THERMAL)        += sy7636a_thermal.o
> >  obj-$(CONFIG_QCOM_TSENS)     += qcom/
> >  obj-y                                += tegra/
> >  obj-$(CONFIG_HISI_THERMAL)     += hisi_thermal.o
> > diff --git a/drivers/thermal/sy7636a_thermal.c b/drivers/thermal/sy7636a_thermal.c
> > new file mode 100644
> > index 000000000000..705a16fb1045
> > --- /dev/null
> > +++ b/drivers/thermal/sy7636a_thermal.c
> > @@ -0,0 +1,107 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +//
> > +// Functions to access SY3686A power management chip temperature
> > +//
> > +// Copyright (C) 2019 reMarkable AS - http://www.remarkable.com/
> > +//
> > +// Authors: Lars Ivar Miljeteig <lars.ivar.miljeteig@remarkable.com>
> > +//          Alistair Francis <alistair@alistair23.me>
> > +
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/thermal.h>
> > +
> > +#include <linux/mfd/sy7636a.h>
> > +
> > +struct sy7636a_data {
> > +     struct sy7636a *sy7636a;
> > +     struct thermal_zone_device *thermal_zone_dev;
> > +};
> > +
> > +static int sy7636a_get_temp(void *arg, int *res)
> > +{
> > +     unsigned int reg_val, mode_ctr;
> > +     int ret;
> > +     struct sy7636a_data *data = arg;
> > +     bool isVoltageActive;
> > +
> > +     ret = regmap_read(data->sy7636a->regmap,
> > +                     SY7636A_REG_OPERATION_MODE_CRL, &mode_ctr);
> > +     if (ret)
> > +             return ret;
> > +
> > +     isVoltageActive = mode_ctr & SY7636A_OPERATION_MODE_CRL_ONOFF;
> > +
> > +     if (!isVoltageActive) {
> > +             ret = regmap_write(data->sy7636a->regmap,
> > +                             SY7636A_REG_OPERATION_MODE_CRL,
> > +                             mode_ctr | SY7636A_OPERATION_MODE_CRL_ONOFF);
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +
> > +     ret = regmap_read(data->sy7636a->regmap,
> > +                     SY7636A_REG_TERMISTOR_READOUT, &reg_val);
> > +     if (ret)
> > +             return ret;
> > +
> > +     if (!isVoltageActive) {
> > +             ret = regmap_write(data->sy7636a->regmap,
> > +                             SY7636A_REG_OPERATION_MODE_CRL,
> > +                             mode_ctr);
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +
> > +     *res = *((signed char*)&reg_val);
> > +     *res *= 1000;
> > +
> > +     return ret;
> > +}
> > +
> > +static const struct thermal_zone_of_device_ops ops = {
> > +     .get_temp       = sy7636a_get_temp,
> > +};
> > +
> > +static int sy7636a_thermal_probe(struct platform_device *pdev)
> > +{
> > +     struct sy7636a *sy7636a = dev_get_drvdata(pdev->dev.parent);
> > +     struct sy7636a_data *data;
> > +
> > +     if (!sy7636a)
> > +             return -EPROBE_DEFER;
>
> How is this possible?

I'm not sure, I have removed this.

>
> > +     data = devm_kzalloc(&pdev->dev, sizeof(struct sy7636a_data), GFP_KERNEL);
>
> sizeof(*data)
>
> > +     if (!data)
> > +             return -ENOMEM;
> > +
> > +     platform_set_drvdata(pdev, data);
> > +
> > +     data->sy7636a = sy7636a;
> > +     data->thermal_zone_dev = devm_thermal_zone_of_sensor_register(
> > +                     pdev->dev.parent,
> > +                     0,
> > +                     data,
>
> Why don't you just pass in your initial ddata?

I'm not sure what you mean, which data?

Alistair
