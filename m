Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6B03AAF95
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 11:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbhFQJW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 05:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbhFQJWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 05:22:24 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC77C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 02:20:15 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id r9so5896801wrz.10
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 02:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Gg51Q69vrN78iTSnv1/PsihkpNXe4WPLDinOYLcaROs=;
        b=qWH4u6RrabufIDV68j4RR4vPjqayf56RX6DeizHWxExOv3eczT7/5G5eKSrhteSBMC
         XhmVVaIVT/elM+UqYM2LG4nsFJVe9+9cpeG2/Cks7+L/Ph6U082RlEXC1QgBO/7t69ca
         viVUwT0KhKy9fQP5MRewnYlpz7C+IVZlQj6rJ/zASyowndGxweWyz6iDuilMbBmxiyUI
         ENGJTWEBXnX+ddv8JmRcQvHP7StZjxvRRM2y5h6oKl/zbfz4axNUCXfCCgX8eEMdfxB5
         UHAiYeZmvKrUW2WdbrvcoSBgggSugUO1NeqwGzw/TeZy3jopBSyrq0QrzYlRn4Y80tUC
         rajQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Gg51Q69vrN78iTSnv1/PsihkpNXe4WPLDinOYLcaROs=;
        b=GHq2j76vdSMknhKr4usARJ6LQ8T0NL77TbawVZzNmeMxxUi6qLs4nvF0YEpa0TbTTJ
         zBAIayhFiXuRARgEjlVsK4RPj6TJWWPaLMtMDncffuM9H6CTDRZCfV2NV9HMgjyOB1ow
         Ocyy7RTePSHbE/6ZigOZZLJeviRAJ2Vy25EjiiZMEVRcfgysrXnQWnXqCAkeq9KTy62C
         Hx6KiHXjJsBaF3a05D7+1BqYxGAU4Fo+HqW3ezTzFYWKkyfo6e2NV2r1KE9tu+Ey/GI8
         n86obJDRvi3jp+cmQjbCuPzoXbxY4aO81I2yLJHB7mEdkTY2vab5Tm/z3QSIuSV+eiId
         bd3w==
X-Gm-Message-State: AOAM532Wp51ZTgdUzulKxB/GSXa9FZQEEIwgQysy+B5lh6VGH2VHDs35
        Fb5xyW3I6ydlIybHlwE0bQhwKw==
X-Google-Smtp-Source: ABdhPJxq93DYMrfuYvKb9tchO3VMLFI9awrucbrsw0UT/oQEHi6hN6pr4j61x7bI1vBVyWlSHHOLfA==
X-Received: by 2002:adf:cd8d:: with SMTP id q13mr4376313wrj.78.1623921614314;
        Thu, 17 Jun 2021 02:20:14 -0700 (PDT)
Received: from dell ([91.110.221.170])
        by smtp.gmail.com with ESMTPSA id k16sm4000285wmr.42.2021.06.17.02.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 02:20:13 -0700 (PDT)
Date:   Thu, 17 Jun 2021 10:20:11 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Alistair Francis <alistair23@gmail.com>
Cc:     Alistair Francis <alistair@alistair23.me>,
        Rob Herring <robh+dt@kernel.org>, lgirdwood@gmail.com,
        Mark Brown <broonie@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 2/5] mfd: sy7636a: Initial commit
Message-ID: <YMsTy3QnYzjrFSFg@dell>
References: <20210615103400.946-1-alistair@alistair23.me>
 <20210615103400.946-2-alistair@alistair23.me>
 <YMnY7RLW6ml4Tq0g@dell>
 <CAKmqyKNs+Ebvd5MwtoKfKhNrMJVhTsBLjDhLXRuK8C+gs5MCcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKmqyKNs+Ebvd5MwtoKfKhNrMJVhTsBLjDhLXRuK8C+gs5MCcQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jun 2021, Alistair Francis wrote:

> On Wed, Jun 16, 2021 at 8:56 PM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > On Tue, 15 Jun 2021, Alistair Francis wrote:
> >
> > > Initial support for the Silergy SY7636A Power Management chip.
> > >
> > > Signed-off-by: Alistair Francis <alistair@alistair23.me>
> > > ---
> > >  drivers/mfd/Kconfig         |  9 ++++
> > >  drivers/mfd/Makefile        |  1 +
> > >  drivers/mfd/sy7636a.c       | 82 +++++++++++++++++++++++++++++++++++++
> > >  include/linux/mfd/sy7636a.h | 47 +++++++++++++++++++++
> > >  4 files changed, 139 insertions(+)
> > >  create mode 100644 drivers/mfd/sy7636a.c
> > >  create mode 100644 include/linux/mfd/sy7636a.h
> > >
> > > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > > index 5c7f2b100191..7d6cf32b1549 100644
> > > --- a/drivers/mfd/Kconfig
> > > +++ b/drivers/mfd/Kconfig
> > > @@ -1339,6 +1339,15 @@ config MFD_SYSCON
> > >         Select this option to enable accessing system control registers
> > >         via regmap.
> > >
> > > +config MFD_SY7636A
> > > +     tristate "Silergy SY7636A Power Management chip"
> > > +     select MFD_CORE
> > > +     select REGMAP_I2C
> > > +     depends on I2C
> > > +     help
> > > +       Select this option to enable support for the Silergy SY7636A
> > > +       Power Management chip.
> > > +
> > >  config MFD_DAVINCI_VOICECODEC
> > >       tristate
> > >       select MFD_CORE
> > > diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> > > index 4f6d2b8a5f76..f95e1e725a95 100644
> > > --- a/drivers/mfd/Makefile
> > > +++ b/drivers/mfd/Makefile
> > > @@ -265,6 +265,7 @@ obj-$(CONFIG_MFD_STMFX)   += stmfx.o
> > >  obj-$(CONFIG_MFD_KHADAS_MCU)         += khadas-mcu.o
> > >  obj-$(CONFIG_MFD_ACER_A500_EC)       += acer-ec-a500.o
> > >
> > > +obj-$(CONFIG_MFD_SY7636A)    += sy7636a.o
> > >  obj-$(CONFIG_SGI_MFD_IOC3)   += ioc3.o
> > >  obj-$(CONFIG_MFD_SIMPLE_MFD_I2C)     += simple-mfd-i2c.o
> > >  obj-$(CONFIG_MFD_INTEL_M10_BMC)   += intel-m10-bmc.o
> > > diff --git a/drivers/mfd/sy7636a.c b/drivers/mfd/sy7636a.c
> > > new file mode 100644
> > > index 000000000000..e08f29ea63f8
> > > --- /dev/null
> > > +++ b/drivers/mfd/sy7636a.c
> > > @@ -0,0 +1,82 @@
> > > +// SPDX-License-Identifier: GPL-2.0+
> > > +//
> >
> > Only the SPDX with C++ style comments please.
> >
> > > +// MFD parent driver for SY7636A chip
> >
> > Drop the MFD part.  It's a Linuxisum that doesn't really exist.
> >
> > > +// Copyright (C) 2021 reMarkable AS - http://www.remarkable.com/
> > > +//
> > > +// Authors: Lars Ivar Miljeteig <lars.ivar.miljeteig@remarkable.com>
> > > +//          Alistair Francis <alistair@alistair23.me>
> > > +//
> > > +// Based on the lp87565 driver by Keerthy <j-keerthy@ti.com>
> > > +
> > > +#include <linux/interrupt.h>
> > > +#include <linux/mfd/core.h>
> > > +#include <linux/module.h>
> > > +#include <linux/of_device.h>
> > > +
> > > +#include <linux/mfd/sy7636a.h>
> > > +
> > > +static const struct regmap_config sy7636a_regmap_config = {
> > > +     .reg_bits = 8,
> > > +     .val_bits = 8,
> > > +};
> > > +
> > > +static const struct mfd_cell sy7636a_cells[] = {
> > > +     { .name = "sy7636a-regulator", },
> > > +     { .name = "sy7636a-temperature", },
> > > +     { .name = "sy7636a-thermal", },
> > > +};
> > > +
> > > +static const struct of_device_id of_sy7636a_match_table[] = {
> > > +     { .compatible = "silergy,sy7636a", },
> > > +     {}
> > > +};
> > > +MODULE_DEVICE_TABLE(of, of_sy7636a_match_table);
> >
> > Hold on.  This driver doesn't really do anything.  If you create OF
> > nodes for all the sub-devices, you can use simple-mfd-i2c.
> >
> > Any reason you can't do that?
> 
> Just to confirm, you mean something like this?
> 
> diff --git a/arch/arm/boot/dts/imx7d-remarkable2.dts
> b/arch/arm/boot/dts/imx7d-remarkable2.dts
> index 9327d1c06c96..3577104b3853 100644
> --- a/arch/arm/boot/dts/imx7d-remarkable2.dts
> +++ b/arch/arm/boot/dts/imx7d-remarkable2.dts
> @@ -382,6 +382,21 @@ epd_pmic: sy7636a@62 {
>                 pinctrl-0 = <&pinctrl_epdpmic>;
>                 #thermal-sensor-cells = <0>;
> 
> +               regulator@0 {
> +                       compatible = "sy7636a-regulator";
> +                       reg = <0>;
> +               };
> +
> +               temperature@0 {
> +                       compatible = "sy7636a-temperature";
> +                       reg = <0>;
> +               };
> +
> +               thermal@0 {
> +                       compatible = "sy7636a-thermal";
> +                       reg = <0>;
> +               };
> +
>                 regulators {
>                         compatible = "silergy,sy7636a-regulator";
> diff --git a/drivers/mfd/simple-mfd-i2c.c b/drivers/mfd/simple-mfd-i2c.c
> index 87f684cff9a1..622a05318cff 100644
> --- a/drivers/mfd/simple-mfd-i2c.c
> +++ b/drivers/mfd/simple-mfd-i2c.c
> @@ -39,6 +39,7 @@ static int simple_mfd_i2c_probe(struct i2c_client *i2c)
> 
>  static const struct of_device_id simple_mfd_i2c_of_match[] = {
>         { .compatible = "kontron,sl28cpld" },
> +       { .compatible = "silergy,sy7636a" },
>         {}
>  };
>  MODULE_DEVICE_TABLE(of, simple_mfd_i2c_of_match);

Essentially.  Take a look at how the other users are implementing.

The reg entries look bogus to me though.  Maybe just leave them out?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
