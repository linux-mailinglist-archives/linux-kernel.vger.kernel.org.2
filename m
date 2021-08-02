Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA9F53DD23C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 10:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbhHBIqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 04:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232709AbhHBIqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 04:46:12 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1DFC06175F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 01:46:02 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id m20-20020a05600c4f54b029024e75a15716so10497246wmq.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 01:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=LtciZxp17HmQgiYPvS7Iz8YEieUC8YD4X+GP7Ju1Ha4=;
        b=HRsdiXIIkwCowPTVIIqo3ZeWlvN8bUQE0S3t2derX3IX+S0ZdcqaaRQ4I/6rXXRrE6
         zJsSKFpTpGGa1JcIFgGyBQewTUMJCFoAUz41TyrGwjN7QcExYKZGo3eYyhHdBkn9610i
         06V9c38SgzHEi3+81Lc/rtbOMUBhZYeg5fsom6CvkZvEsM0oz5xAFCEagt7VthDcKtJP
         IRAnhNTd9Zops5aXdIiMHNjfc2qxgWZE4e+fYohoPkUcosKFx18IGyhQCLDM1Rqcz/rd
         O4TtkjWwSEE1GVyuj8+zqH316vt2gR859VfungKjShxvgB5kvO3KS1bn0Vduion3QyUe
         GOYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=LtciZxp17HmQgiYPvS7Iz8YEieUC8YD4X+GP7Ju1Ha4=;
        b=YPT8XuO5s27jFMj2cGcV204pSdQ2jRZpgCbLT7pXlOKiyvuPFUpD9B3wr9y+G/TsTK
         PFW9KIgO83hd/KR/fDq+0u09YyPF8F4HReJpW/gyBVPV2mHcqej7O8HoJCFKeqMXluQZ
         BB8Jv4msxRbo60gWyXlFi3gMWuKYF787KGUPBvmQwVkob8fnu5d+OicTgzmJJcLLuRiP
         QvfeOnFS3J4lhdqTrlLhxGju8yBPylIV4F3PIpLZb/un6YkvA0K7wcRoSkSp6lKd0dTV
         /PQHILLWaEmv/6P7SopOBJXSjKD2t3dMIBZarahY1k4+RWxBWC9JhVI0Csey9Zyf4Kva
         9yJg==
X-Gm-Message-State: AOAM532IxkOvWtTHZK0hsA3Rz7n9bDlqFYKLn7f1+PbWn5gKRAEg+TmH
        Eo/wKcC6g4pFbo1MQnBH8AWDTw==
X-Google-Smtp-Source: ABdhPJz3pu2dHxQGkDCWH16ushT5GrFzHuzVtjxGH5KCxBV5Awy22EJ4s/38sj+4YJG5NnuuPgUuGw==
X-Received: by 2002:a05:600c:3590:: with SMTP id p16mr14418119wmq.75.1627893960817;
        Mon, 02 Aug 2021 01:46:00 -0700 (PDT)
Received: from google.com ([109.180.115.228])
        by smtp.gmail.com with ESMTPSA id s14sm9361259wmc.25.2021.08.02.01.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 01:46:00 -0700 (PDT)
Date:   Mon, 2 Aug 2021 09:45:58 +0100
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
Message-ID: <YQewxp9UKpgmWF6Z@google.com>
References: <20210615103400.946-1-alistair@alistair23.me>
 <20210615103400.946-2-alistair@alistair23.me>
 <YMnY7RLW6ml4Tq0g@dell>
 <CAKmqyKNs+Ebvd5MwtoKfKhNrMJVhTsBLjDhLXRuK8C+gs5MCcQ@mail.gmail.com>
 <YMsTy3QnYzjrFSFg@dell>
 <CAKmqyKODRkahuUL+SFj8RQYq2rvj=nLgseozAyiwkDmtD8JE+g@mail.gmail.com>
 <YObzzE8y2tyiMg5p@google.com>
 <CAKmqyKN-wnTHrRYTxw3R6h=rcrbSUSF0vh3pwvt5ByaDzEiFMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKmqyKN-wnTHrRYTxw3R6h=rcrbSUSF0vh3pwvt5ByaDzEiFMQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jul 2021, Alistair Francis wrote:

> On Thu, Jul 8, 2021 at 10:47 PM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > On Thu, 08 Jul 2021, Alistair Francis wrote:
> >
> > > On Thu, Jun 17, 2021 at 7:20 PM Lee Jones <lee.jones@linaro.org> wrote:
> > > >
> > > > On Thu, 17 Jun 2021, Alistair Francis wrote:
> > > >
> > > > > On Wed, Jun 16, 2021 at 8:56 PM Lee Jones <lee.jones@linaro.org> wrote:
> > > > > >
> > > > > > On Tue, 15 Jun 2021, Alistair Francis wrote:
> > > > > >
> > > > > > > Initial support for the Silergy SY7636A Power Management chip.
> > > > > > >
> > > > > > > Signed-off-by: Alistair Francis <alistair@alistair23.me>
> > > > > > > ---
> > > > > > >  drivers/mfd/Kconfig         |  9 ++++
> > > > > > >  drivers/mfd/Makefile        |  1 +
> > > > > > >  drivers/mfd/sy7636a.c       | 82 +++++++++++++++++++++++++++++++++++++
> > > > > > >  include/linux/mfd/sy7636a.h | 47 +++++++++++++++++++++
> > > > > > >  4 files changed, 139 insertions(+)
> > > > > > >  create mode 100644 drivers/mfd/sy7636a.c
> > > > > > >  create mode 100644 include/linux/mfd/sy7636a.h
> > > > > > >
> > > > > > > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > > > > > > index 5c7f2b100191..7d6cf32b1549 100644
> > > > > > > --- a/drivers/mfd/Kconfig
> > > > > > > +++ b/drivers/mfd/Kconfig
> > > > > > > @@ -1339,6 +1339,15 @@ config MFD_SYSCON
> > > > > > >         Select this option to enable accessing system control registers
> > > > > > >         via regmap.
> > > > > > >
> > > > > > > +config MFD_SY7636A
> > > > > > > +     tristate "Silergy SY7636A Power Management chip"
> > > > > > > +     select MFD_CORE
> > > > > > > +     select REGMAP_I2C
> > > > > > > +     depends on I2C
> > > > > > > +     help
> > > > > > > +       Select this option to enable support for the Silergy SY7636A
> > > > > > > +       Power Management chip.
> > > > > > > +
> > > > > > >  config MFD_DAVINCI_VOICECODEC
> > > > > > >       tristate
> > > > > > >       select MFD_CORE
> > > > > > > diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> > > > > > > index 4f6d2b8a5f76..f95e1e725a95 100644
> > > > > > > --- a/drivers/mfd/Makefile
> > > > > > > +++ b/drivers/mfd/Makefile
> > > > > > > @@ -265,6 +265,7 @@ obj-$(CONFIG_MFD_STMFX)   += stmfx.o
> > > > > > >  obj-$(CONFIG_MFD_KHADAS_MCU)         += khadas-mcu.o
> > > > > > >  obj-$(CONFIG_MFD_ACER_A500_EC)       += acer-ec-a500.o
> > > > > > >
> > > > > > > +obj-$(CONFIG_MFD_SY7636A)    += sy7636a.o
> > > > > > >  obj-$(CONFIG_SGI_MFD_IOC3)   += ioc3.o
> > > > > > >  obj-$(CONFIG_MFD_SIMPLE_MFD_I2C)     += simple-mfd-i2c.o
> > > > > > >  obj-$(CONFIG_MFD_INTEL_M10_BMC)   += intel-m10-bmc.o
> > > > > > > diff --git a/drivers/mfd/sy7636a.c b/drivers/mfd/sy7636a.c
> > > > > > > new file mode 100644
> > > > > > > index 000000000000..e08f29ea63f8
> > > > > > > --- /dev/null
> > > > > > > +++ b/drivers/mfd/sy7636a.c
> > > > > > > @@ -0,0 +1,82 @@
> > > > > > > +// SPDX-License-Identifier: GPL-2.0+
> > > > > > > +//
> > > > > >
> > > > > > Only the SPDX with C++ style comments please.
> > > > > >
> > > > > > > +// MFD parent driver for SY7636A chip
> > > > > >
> > > > > > Drop the MFD part.  It's a Linuxisum that doesn't really exist.
> > > > > >
> > > > > > > +// Copyright (C) 2021 reMarkable AS - http://www.remarkable.com/
> > > > > > > +//
> > > > > > > +// Authors: Lars Ivar Miljeteig <lars.ivar.miljeteig@remarkable.com>
> > > > > > > +//          Alistair Francis <alistair@alistair23.me>
> > > > > > > +//
> > > > > > > +// Based on the lp87565 driver by Keerthy <j-keerthy@ti.com>
> > > > > > > +
> > > > > > > +#include <linux/interrupt.h>
> > > > > > > +#include <linux/mfd/core.h>
> > > > > > > +#include <linux/module.h>
> > > > > > > +#include <linux/of_device.h>
> > > > > > > +
> > > > > > > +#include <linux/mfd/sy7636a.h>
> > > > > > > +
> > > > > > > +static const struct regmap_config sy7636a_regmap_config = {
> > > > > > > +     .reg_bits = 8,
> > > > > > > +     .val_bits = 8,
> > > > > > > +};
> > > > > > > +
> > > > > > > +static const struct mfd_cell sy7636a_cells[] = {
> > > > > > > +     { .name = "sy7636a-regulator", },
> > > > > > > +     { .name = "sy7636a-temperature", },
> > > > > > > +     { .name = "sy7636a-thermal", },
> > > > > > > +};
> > > > > > > +
> > > > > > > +static const struct of_device_id of_sy7636a_match_table[] = {
> > > > > > > +     { .compatible = "silergy,sy7636a", },
> > > > > > > +     {}
> > > > > > > +};
> > > > > > > +MODULE_DEVICE_TABLE(of, of_sy7636a_match_table);
> > > > > >
> > > > > > Hold on.  This driver doesn't really do anything.  If you create OF
> > > > > > nodes for all the sub-devices, you can use simple-mfd-i2c.
> > > > > >
> > > > > > Any reason you can't do that?
> > > > >
> > > > > Just to confirm, you mean something like this?
> > > > >
> > > > > diff --git a/arch/arm/boot/dts/imx7d-remarkable2.dts
> > > > > b/arch/arm/boot/dts/imx7d-remarkable2.dts
> > > > > index 9327d1c06c96..3577104b3853 100644
> > > > > --- a/arch/arm/boot/dts/imx7d-remarkable2.dts
> > > > > +++ b/arch/arm/boot/dts/imx7d-remarkable2.dts
> > > > > @@ -382,6 +382,21 @@ epd_pmic: sy7636a@62 {
> > > > >                 pinctrl-0 = <&pinctrl_epdpmic>;
> > > > >                 #thermal-sensor-cells = <0>;
> > > > >
> > > > > +               regulator@0 {
> > > > > +                       compatible = "sy7636a-regulator";
> > > > > +                       reg = <0>;
> > > > > +               };
> > > > > +
> > > > > +               temperature@0 {
> > > > > +                       compatible = "sy7636a-temperature";
> > > > > +                       reg = <0>;
> > > > > +               };
> > > > > +
> > > > > +               thermal@0 {
> > > > > +                       compatible = "sy7636a-thermal";
> > > > > +                       reg = <0>;
> > > > > +               };
> > > > > +
> > > > >                 regulators {
> > > > >                         compatible = "silergy,sy7636a-regulator";
> > > > > diff --git a/drivers/mfd/simple-mfd-i2c.c b/drivers/mfd/simple-mfd-i2c.c
> > > > > index 87f684cff9a1..622a05318cff 100644
> > > > > --- a/drivers/mfd/simple-mfd-i2c.c
> > > > > +++ b/drivers/mfd/simple-mfd-i2c.c
> > > > > @@ -39,6 +39,7 @@ static int simple_mfd_i2c_probe(struct i2c_client *i2c)
> > > > >
> > > > >  static const struct of_device_id simple_mfd_i2c_of_match[] = {
> > > > >         { .compatible = "kontron,sl28cpld" },
> > > > > +       { .compatible = "silergy,sy7636a" },
> > > > >         {}
> > > > >  };
> > > > >  MODULE_DEVICE_TABLE(of, simple_mfd_i2c_of_match);
> > > >
> > > > Essentially.  Take a look at how the other users are implementing.
> > > >
> > > > The reg entries look bogus to me though.  Maybe just leave them out?
> > >
> > > So I tried this and didn't have any luck.
> > >
> > > After some Kconfig changes to allow it to build, I managed to get it
> > > probing, but I never got it to power up. It doesn't seem to be the
> > > same.
> >
> > I need a more technical reason why this is not the correct approach
> > for you.  "I can't get it to work" doesn't quite reach the quality
> > line I'm afraid.
> 
> Yep, so one thing that we need that the simple-mfd-i2c doesn't do is
> the epd-pwr-good-gpios GPIO. This is a GPIO line from the mfd that the
> regulator uses.

Can this be obtained from anywhere else?

Like in the regulator driver for instance.

> > Did you try enabling the debug prints in of_platform_bus_create() and
> > friends to see if your devices are probing correctly?
> 
> I think I did, but I can have another look and see if I can get it working.
> 
> Alistair
> 
> >

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
