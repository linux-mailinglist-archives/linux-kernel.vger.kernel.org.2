Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3913DFF67
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 12:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237344AbhHDK27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 06:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237263AbhHDK25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 06:28:57 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52F5C0613D5
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 03:28:44 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id l11-20020a7bcf0b0000b0290253545c2997so1144184wmg.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 03:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=pibRPync781Rey72XckhyktXKaHhuUD/jjwvrwByLTU=;
        b=AEqHZY4Ua0OTOVBBOyyctVU3kaNOKXvJEV44OSQquvmFrUofuT2FpdlBiK08kbucTc
         Ovrxx3a7PVozVuKm15Wk0qmCd68nfsRgd8ucTo4ww+skdi3BjnMneI5tXFgleCS6b4Jw
         cIml3EmLHJHkyZIXemSIIGIB4PNaMdnuR4R14QIqFAznVnkeG11d4VWoIaR2sS6OrAUF
         VmL+7pcM0bDjkM2+VKG2gkhKrFu1W460axDVG0BWexKJhWRXxrBpGpJ7NfFVWhbEa1cU
         8eIMpC8W1LDjHcFZJyiyY5nGCfc3I3uGGFjn8/WraEGhNB0UbybhT/23vO3wk0agUw27
         bTRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=pibRPync781Rey72XckhyktXKaHhuUD/jjwvrwByLTU=;
        b=cXMeYEGoFq+LOKkWCyAxbfevZFv7otbJwGiTypu4uFf+68l8OXuT6Qzds/FOroTxik
         tShRLyJSIvkswHA+XZ5dcEXX1Kg1xE3pOCbYnowbgRpsVld6vhXOOK/qWjoHpWP8EXa7
         wV7sdZp5FCjK+du6t8WRPHvgS6nbA6RClvE+9hwOI9mrK2dW3k+06MOxvoU0Q9Infboi
         CyDwpH3Mi0nRug08CSavQSOML4GYBdISu8OswI7MeWescuKI2R5bYldEqTyEZ8AMw9vU
         9JRc9jWapK9xjEUWKctKN8LIAF9PLf0mYuMvitm24D+Pl7Ef6ulds5DGPbhIXRmYBhOC
         iRBw==
X-Gm-Message-State: AOAM530RRgq8sWN0C2PaFCqJKwcVVShKno7uVdw+UqqCMZ2j8Td+hp+/
        3sVthBxJbtKUUZmM9MIgtoZ88A==
X-Google-Smtp-Source: ABdhPJyLL5+IQyQOwrQ3rdoeJ3/iG50sinQci9T23YfmDnbK/M6bQLaxlT/KON9NUBIJ1Yl5G07Ezw==
X-Received: by 2002:a7b:cf12:: with SMTP id l18mr9004049wmg.130.1628072922530;
        Wed, 04 Aug 2021 03:28:42 -0700 (PDT)
Received: from google.com ([109.180.115.228])
        by smtp.gmail.com with ESMTPSA id q14sm1930131wrs.8.2021.08.04.03.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 03:28:41 -0700 (PDT)
Date:   Wed, 4 Aug 2021 11:28:39 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Alistair Francis <alistair23@gmail.com>
Cc:     Alistair Francis <alistair@alistair23.me>,
        Rob Herring <robh+dt@kernel.org>, lgirdwood@gmail.com,
        Mark Brown <broonie@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 02/11] mfd: sy7636a: Initial commit
Message-ID: <YQpr1/PVFqHqs2Zv@google.com>
References: <20210803084456.198-1-alistair@alistair23.me>
 <20210803084456.198-2-alistair@alistair23.me>
 <YQlBtQDrVHqh3N5D@google.com>
 <CAKmqyKMZWVx3KqeysUjOc29nuxnwJfZ3wjmWjVwk9tpQ4dkh-A@mail.gmail.com>
 <YQpYjEc9r8QGUhiD@google.com>
 <CAKmqyKP79jXdGhMKYzA3ZOkkT6kb2buOSyYuaCS43SK9oe2ACw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKmqyKP79jXdGhMKYzA3ZOkkT6kb2buOSyYuaCS43SK9oe2ACw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Aug 2021, Alistair Francis wrote:

> On Wed, Aug 4, 2021 at 7:06 PM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > On Wed, 04 Aug 2021, Alistair Francis wrote:
> >
> > > On Tue, Aug 3, 2021 at 11:16 PM Lee Jones <lee.jones@linaro.org> wrote:
> > > >
> > > > On Tue, 03 Aug 2021, Alistair Francis wrote:
> > > >
> > > > > Initial support for the Silergy SY7636A Power Management chip.
> > > > >
> > > > > Signed-off-by: Alistair Francis <alistair@alistair23.me>
> > > > > ---
> > > > >  drivers/mfd/Kconfig         |  9 +++++
> > > > >  drivers/mfd/Makefile        |  1 +
> > > > >  drivers/mfd/sy7636a.c       | 72 +++++++++++++++++++++++++++++++++++++
> > > > >  include/linux/mfd/sy7636a.h | 45 +++++++++++++++++++++++
> > > > >  4 files changed, 127 insertions(+)
> > > > >  create mode 100644 drivers/mfd/sy7636a.c
> > > > >  create mode 100644 include/linux/mfd/sy7636a.h
> > > > >
> > > > > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > > > > index 6a3fd2d75f96..b82208f0c79c 100644
> > > > > --- a/drivers/mfd/Kconfig
> > > > > +++ b/drivers/mfd/Kconfig
> > > > > @@ -1352,6 +1352,15 @@ config MFD_SYSCON
> > > > >         Select this option to enable accessing system control registers
> > > > >         via regmap.
> > > > >
> > > > > +config MFD_SY7636A
> > > > > +     tristate "Silergy SY7636A Power Management IC"
> > > > > +     select MFD_CORE
> > > > > +     select REGMAP_I2C
> > > > > +     depends on I2C
> > > > > +     help
> > > > > +       Select this option to enable support for the Silergy SY7636A
> > > > > +       Power Management IC.
> > > > > +
> > > > >  config MFD_DAVINCI_VOICECODEC
> > > > >       tristate
> > > > >       select MFD_CORE
> > > > > diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> > > > > index 8116c19d5fd4..cbe581e87fa9 100644
> > > > > --- a/drivers/mfd/Makefile
> > > > > +++ b/drivers/mfd/Makefile
> > > > > @@ -266,6 +266,7 @@ obj-$(CONFIG_MFD_KHADAS_MCU)      += khadas-mcu.o
> > > > >  obj-$(CONFIG_MFD_ACER_A500_EC)       += acer-ec-a500.o
> > > > >  obj-$(CONFIG_MFD_QCOM_PM8008)        += qcom-pm8008.o
> > > > >
> > > > > +obj-$(CONFIG_MFD_SY7636A)    += sy7636a.o
> > > > >  obj-$(CONFIG_SGI_MFD_IOC3)   += ioc3.o
> > > > >  obj-$(CONFIG_MFD_SIMPLE_MFD_I2C)     += simple-mfd-i2c.o
> > > > >  obj-$(CONFIG_MFD_INTEL_M10_BMC)   += intel-m10-bmc.o
> > > > > diff --git a/drivers/mfd/sy7636a.c b/drivers/mfd/sy7636a.c
> > > > > new file mode 100644
> > > > > index 000000000000..f3ff93c7395d
> > > > > --- /dev/null
> > > > > +++ b/drivers/mfd/sy7636a.c
> > > > > @@ -0,0 +1,72 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0+
> > > > > +/*
> > > > > + * MFD parent driver for SY7636A chip
> > > > > + *
> > > > > + * Copyright (C) 2021 reMarkable AS - http://www.remarkable.com/
> > > > > + *
> > > > > + * Authors: Lars Ivar Miljeteig <lars.ivar.miljeteig@remarkable.com>
> > > > > + *          Alistair Francis <alistair@alistair23.me>
> > > > > + *
> > > > > + * Based on the lp87565 driver by Keerthy <j-keerthy@ti.com>
> > > > > + */
> > > > > +
> > > > > +#include <linux/interrupt.h>
> > > > > +#include <linux/mfd/core.h>
> > > > > +#include <linux/module.h>
> > > > > +#include <linux/of_device.h>
> > > > > +
> > > > > +#include <linux/mfd/sy7636a.h>
> > > > > +
> > > > > +static const struct regmap_config sy7636a_regmap_config = {
> > > > > +     .reg_bits = 8,
> > > > > +     .val_bits = 8,
> > > > > +};
> > > > > +
> > > > > +static const struct mfd_cell sy7636a_cells[] = {
> > > > > +     { .name = "sy7636a-regulator", },
> > > >
> > > > What kind of regulator is 'vcom'? LDO? DCDC?
> > >
> > > Both I guess:
> > >
> > > "SY7636A is a single-chip power management IC (PMIC) designed for
> > > electronic paper display (EPD) applications. The device supports panel
> > > sizes up to 9.7 inches and larger. The device integrates two
> > > high-efficiency DC-DC boost converters, which are boosted to 25V and
> > > -20V by two charge pumps to provide gate driver power for the panel.
> > > Two tracking LDOs create a ±15V source driver power supply that
> > > supports output currents up to 200mA. SY7636A also provides I2C
> > > interface control for specific panel requirements"
> >
> > Is there a datasheet I could look at?
> 
> I have managed to find this:
> 
> https://www.silergy.com/cn/productsview/SY7636ARMC
> 
> which is in Chinese. The datasheet is behind a login page unfortunately.

Where did the snippet above come from then?

What documentation are you working to?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
