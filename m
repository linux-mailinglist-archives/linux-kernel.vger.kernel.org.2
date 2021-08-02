Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE0753DD196
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 09:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232621AbhHBHzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 03:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232500AbhHBHzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 03:55:47 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7123EC06175F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 00:55:37 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id k38-20020a05600c1ca6b029025af5e0f38bso2007895wms.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 00:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=zsrnDkQfZTvSoNItnxGGgjbQR3fDzAS4w38XtgmLpSM=;
        b=U3T1tMEe2YgBhbZrOCBVzUYlSXTMLiEfLv9MmH2Ax9q+VY6qoLivpJ28dBL3QHPdgm
         xjQXqPb5u7PZAZswGIe4O4VcsP4Iho1cy12w9ShRvLIe87vQ3x8XiobUitH3Efl3fKsq
         t5hoTUDudq66g2uMueAx173VThgFYMNkibDIAG/R5xhDgygLOlBf0m0crTH4E2toOxdF
         540qdpweqX8/ZBrMH2JuJoNj5D7YTs2o3HibjJt4tjgT5vSnN5nL2N3vhNy9LbeVTGGB
         68CtraPoLN0/810ponbWH1sqkrRJVaGv7NM6cBOfSvPuzpjbbskyyKOkd5gKkz3q9SkE
         HXSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=zsrnDkQfZTvSoNItnxGGgjbQR3fDzAS4w38XtgmLpSM=;
        b=uAqGcG1FeymHr0+MUARsZ7LOuoY85eigF0D+1jrnKbpSRIBE6Lutc4H3kVo0OSO6Uu
         ymjR4/4KpUiyEYwDCwES3z3KZJn/NX/a506Q72zD5rimShNEAkKF4aNbvpdt16xtGkdM
         79IUHg5qvWUpUY9K3EUJO/8+IR1f8Uj1z53+50BcjK7j7bXs69Tnx9oWC21Re1KqOf7K
         67q3qY5dIXE7IDhZJqfFkCaON9CA37FTHhpyF+n16m5bEfZByb8SY0/hBN0rAO5ABQbQ
         2GaM0mmx9pXE2iKclsflBlZlMIayrSAT4ynoSIs4f/gaF3XdVXrxae+slUkgwzwyQtUT
         RHXA==
X-Gm-Message-State: AOAM531tooMopXDlsK15zLnR0q6DSq02Dwzb5INAF4rVFjCWptTn5XIi
        et/6AugdJiFXF4P56FAizJzhjw==
X-Google-Smtp-Source: ABdhPJwiBYc7HSXAAZH8bdn44lEd1fkHfse82ZRr5szRfghZgxf9+ScEOFZACiwotlwVKSn/Av1Eyg==
X-Received: by 2002:a1c:4487:: with SMTP id r129mr6512912wma.62.1627890936051;
        Mon, 02 Aug 2021 00:55:36 -0700 (PDT)
Received: from google.com ([109.180.115.228])
        by smtp.gmail.com with ESMTPSA id a2sm10340846wrn.95.2021.08.02.00.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 00:55:35 -0700 (PDT)
Date:   Mon, 2 Aug 2021 08:55:33 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Alistair Francis <alistair23@gmail.com>
Cc:     Alistair Francis <alistair@alistair23.me>,
        Rob Herring <robh+dt@kernel.org>, lgirdwood@gmail.com,
        Mark Brown <broonie@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lars Ivar Miljeteig <lars.ivar.miljeteig@remarkable.no>
Subject: Re: [PATCH v7 2/6] thermal: sy7636a: Add thermal driver for sy7636a
Message-ID: <YQek9afLXShHl2YI@google.com>
References: <20210708115804.212-1-alistair@alistair23.me>
 <20210708115804.212-2-alistair@alistair23.me>
 <YPblgabAObekmVZs@google.com>
 <CAKmqyKPk5mksq7KK0FOBLLLyw+3o52EjtkqOMe0tMg5OgxOkJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKmqyKPk5mksq7KK0FOBLLLyw+3o52EjtkqOMe0tMg5OgxOkJw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jul 2021, Alistair Francis wrote:

> On Wed, Jul 21, 2021 at 1:02 AM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > On Thu, 08 Jul 2021, Alistair Francis wrote:
> >
> > > From: Lars Ivar Miljeteig <lars.ivar.miljeteig@remarkable.no>
> > >
> > > Add thermal driver to enable kernel based polling
> > > and shutdown of device for temperatures out of spec
> > >
> > > Signed-off-by: Alistair Francis <alistair@alistair23.me>
> > > ---
> > >  drivers/thermal/Kconfig           |   7 ++
> > >  drivers/thermal/Makefile          |   1 +
> > >  drivers/thermal/sy7636a_thermal.c | 107 ++++++++++++++++++++++++++++++
> > >  3 files changed, 115 insertions(+)
> > >  create mode 100644 drivers/thermal/sy7636a_thermal.c
> > >
> > > diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> > > index d7f44deab5b1..7112c63d9021 100644
> > > --- a/drivers/thermal/Kconfig
> > > +++ b/drivers/thermal/Kconfig
> > > @@ -450,6 +450,13 @@ depends on (ARCH_STI || ARCH_STM32) && OF
> > >  source "drivers/thermal/st/Kconfig"
> > >  endmenu
> > >
> > > +config SY7636A_THERMAL
> > > +     tristate "SY7636A thermal management"
> > > +     depends on MFD_SY7636A
> > > +     help
> > > +       Enable the sy7636a thermal driver, which supports the
> > > +       temperature sensor embedded in Silabs SY7636A chip.
> > > +
> > >  source "drivers/thermal/tegra/Kconfig"
> > >
> > >  config GENERIC_ADC_THERMAL
> > > diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> > > index 82fc3e616e54..2e1aca8a0a09 100644
> > > --- a/drivers/thermal/Makefile
> > > +++ b/drivers/thermal/Makefile
> > > @@ -51,6 +51,7 @@ obj-$(CONFIG_DA9062_THERMAL)        += da9062-thermal.o
> > >  obj-y                                += intel/
> > >  obj-$(CONFIG_TI_SOC_THERMAL) += ti-soc-thermal/
> > >  obj-y                                += st/
> > > +obj-$(CONFIG_SY7636A_THERMAL)        += sy7636a_thermal.o
> > >  obj-$(CONFIG_QCOM_TSENS)     += qcom/
> > >  obj-y                                += tegra/
> > >  obj-$(CONFIG_HISI_THERMAL)     += hisi_thermal.o
> > > diff --git a/drivers/thermal/sy7636a_thermal.c b/drivers/thermal/sy7636a_thermal.c
> > > new file mode 100644
> > > index 000000000000..705a16fb1045
> > > --- /dev/null
> > > +++ b/drivers/thermal/sy7636a_thermal.c
> > > @@ -0,0 +1,107 @@
> > > +// SPDX-License-Identifier: GPL-2.0+
> > > +//
> > > +// Functions to access SY3686A power management chip temperature
> > > +//
> > > +// Copyright (C) 2019 reMarkable AS - http://www.remarkable.com/
> > > +//
> > > +// Authors: Lars Ivar Miljeteig <lars.ivar.miljeteig@remarkable.com>
> > > +//          Alistair Francis <alistair@alistair23.me>
> > > +
> > > +#include <linux/module.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/thermal.h>
> > > +
> > > +#include <linux/mfd/sy7636a.h>
> > > +
> > > +struct sy7636a_data {
> > > +     struct sy7636a *sy7636a;
> > > +     struct thermal_zone_device *thermal_zone_dev;
> > > +};
> > > +
> > > +static int sy7636a_get_temp(void *arg, int *res)
> > > +{
> > > +     unsigned int reg_val, mode_ctr;
> > > +     int ret;
> > > +     struct sy7636a_data *data = arg;
> > > +     bool isVoltageActive;
> > > +
> > > +     ret = regmap_read(data->sy7636a->regmap,
> > > +                     SY7636A_REG_OPERATION_MODE_CRL, &mode_ctr);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     isVoltageActive = mode_ctr & SY7636A_OPERATION_MODE_CRL_ONOFF;
> > > +
> > > +     if (!isVoltageActive) {
> > > +             ret = regmap_write(data->sy7636a->regmap,
> > > +                             SY7636A_REG_OPERATION_MODE_CRL,
> > > +                             mode_ctr | SY7636A_OPERATION_MODE_CRL_ONOFF);
> > > +             if (ret)
> > > +                     return ret;
> > > +     }
> > > +
> > > +     ret = regmap_read(data->sy7636a->regmap,
> > > +                     SY7636A_REG_TERMISTOR_READOUT, &reg_val);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     if (!isVoltageActive) {
> > > +             ret = regmap_write(data->sy7636a->regmap,
> > > +                             SY7636A_REG_OPERATION_MODE_CRL,
> > > +                             mode_ctr);
> > > +             if (ret)
> > > +                     return ret;
> > > +     }
> > > +
> > > +     *res = *((signed char*)&reg_val);
> > > +     *res *= 1000;
> > > +
> > > +     return ret;
> > > +}
> > > +
> > > +static const struct thermal_zone_of_device_ops ops = {
> > > +     .get_temp       = sy7636a_get_temp,
> > > +};
> > > +
> > > +static int sy7636a_thermal_probe(struct platform_device *pdev)
> > > +{
> > > +     struct sy7636a *sy7636a = dev_get_drvdata(pdev->dev.parent);
> > > +     struct sy7636a_data *data;
> > > +
> > > +     if (!sy7636a)
> > > +             return -EPROBE_DEFER;
> >
> > How is this possible?
> 
> I'm not sure, I have removed this.
> 
> >
> > > +     data = devm_kzalloc(&pdev->dev, sizeof(struct sy7636a_data), GFP_KERNEL);
> >
> > sizeof(*data)
> >
> > > +     if (!data)
> > > +             return -ENOMEM;
> > > +
> > > +     platform_set_drvdata(pdev, data);
> > > +
> > > +     data->sy7636a = sy7636a;
> > > +     data->thermal_zone_dev = devm_thermal_zone_of_sensor_register(
> > > +                     pdev->dev.parent,
> > > +                     0,
> > > +                     data,
> >
> > Why don't you just pass in your initial ddata?
> 
> I'm not sure what you mean, which data?

sy7636a

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
