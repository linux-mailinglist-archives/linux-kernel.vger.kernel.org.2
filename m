Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE4CF3AA673
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 00:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234172AbhFPWEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 18:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233188AbhFPWEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 18:04:23 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E19DC061574;
        Wed, 16 Jun 2021 15:02:16 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id d9so865463ioo.2;
        Wed, 16 Jun 2021 15:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NikDp6q2vZyMWxVs5+WTfA2YvFZy7dXOJMsJLWLolUw=;
        b=IM/omgH/wFzMaMvfVrjiYToVsbSlRKPm7w+zoGzoQ7dEtnY+HjOuaE0xaXvptBiQFs
         if+kFninVspO/gflCmp10qvfcczKtJrSSlCiGDrYNXUTR/OWnu0A3kHMGWosud/BcPrr
         Re5zNa5IEk1e/WU8M2qUJA6mL6Fn+XJ48BAHwiLHEdW2gB8bFwk6J4J4i0GNKwMblGia
         JcbOl8hBURIuuwFBGaDBSAnblFyQianPwa6kJL0KzvDXV/O/0V2k1S+KocVp+hNYHwQG
         DbmUecwcZdqKRtY1xmvXOsJhSPrsXvu4GK+/Lkm/+Rr2YD/8mrSuWqhGP5htWDWZRYST
         rL0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NikDp6q2vZyMWxVs5+WTfA2YvFZy7dXOJMsJLWLolUw=;
        b=k6Cyw8BlBdiir6za4wh2COzZGhXyc05Zmzqnwrxf7YC7cnnHGD4QxwIGiBNfGPc6+d
         j+VwnlHf66VkRt44rCuAA8A/HkE9H4Mt2+Ep0eaYaJaju/uheeQIO5sKMuPpdVCzDQIw
         41UzGiemETxxvoziJzbPZSLxTu5Bll+hqOgGQa7ao9BYxCUJgP4W2Q0HZfnMyUa+pIqW
         x3FgAMLnGSmXUas2f/MntiD/e7SPfD30GVmwh9xYBiSYMFCdtfiUxbYJQLy5q+OVg1a5
         aTY/EOhFiKJCLEji7g+w/9zZ3AWgiNvJMrpL4rSBVffeb0IwEjkTaSiJ22syFFsdLldL
         qq3A==
X-Gm-Message-State: AOAM531exM1okgHIvxWCRn99oBTxOrBWledvOPrwdc6RgVXbXzWs0D9j
        ty6LkH/uyqN5nuX28xY1bkzYEwBMLhMKlDi5ZX8=
X-Google-Smtp-Source: ABdhPJwWLOHsyoArTJcDaDx+PHflZxO+RIAGsF4Akqd4ncxQHlVNlZRcBZpw1d04CxXrnqIIHxTIrdDDpX2N4c+y6CI=
X-Received: by 2002:a05:6602:722:: with SMTP id g2mr1154673iox.118.1623880935595;
 Wed, 16 Jun 2021 15:02:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210615103400.946-1-alistair@alistair23.me> <20210615103400.946-2-alistair@alistair23.me>
 <YMnY7RLW6ml4Tq0g@dell>
In-Reply-To: <YMnY7RLW6ml4Tq0g@dell>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Thu, 17 Jun 2021 08:01:49 +1000
Message-ID: <CAKmqyKNs+Ebvd5MwtoKfKhNrMJVhTsBLjDhLXRuK8C+gs5MCcQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/5] mfd: sy7636a: Initial commit
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

On Wed, Jun 16, 2021 at 8:56 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Tue, 15 Jun 2021, Alistair Francis wrote:
>
> > Initial support for the Silergy SY7636A Power Management chip.
> >
> > Signed-off-by: Alistair Francis <alistair@alistair23.me>
> > ---
> >  drivers/mfd/Kconfig         |  9 ++++
> >  drivers/mfd/Makefile        |  1 +
> >  drivers/mfd/sy7636a.c       | 82 +++++++++++++++++++++++++++++++++++++
> >  include/linux/mfd/sy7636a.h | 47 +++++++++++++++++++++
> >  4 files changed, 139 insertions(+)
> >  create mode 100644 drivers/mfd/sy7636a.c
> >  create mode 100644 include/linux/mfd/sy7636a.h
> >
> > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > index 5c7f2b100191..7d6cf32b1549 100644
> > --- a/drivers/mfd/Kconfig
> > +++ b/drivers/mfd/Kconfig
> > @@ -1339,6 +1339,15 @@ config MFD_SYSCON
> >         Select this option to enable accessing system control registers
> >         via regmap.
> >
> > +config MFD_SY7636A
> > +     tristate "Silergy SY7636A Power Management chip"
> > +     select MFD_CORE
> > +     select REGMAP_I2C
> > +     depends on I2C
> > +     help
> > +       Select this option to enable support for the Silergy SY7636A
> > +       Power Management chip.
> > +
> >  config MFD_DAVINCI_VOICECODEC
> >       tristate
> >       select MFD_CORE
> > diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> > index 4f6d2b8a5f76..f95e1e725a95 100644
> > --- a/drivers/mfd/Makefile
> > +++ b/drivers/mfd/Makefile
> > @@ -265,6 +265,7 @@ obj-$(CONFIG_MFD_STMFX)   +=3D stmfx.o
> >  obj-$(CONFIG_MFD_KHADAS_MCU)         +=3D khadas-mcu.o
> >  obj-$(CONFIG_MFD_ACER_A500_EC)       +=3D acer-ec-a500.o
> >
> > +obj-$(CONFIG_MFD_SY7636A)    +=3D sy7636a.o
> >  obj-$(CONFIG_SGI_MFD_IOC3)   +=3D ioc3.o
> >  obj-$(CONFIG_MFD_SIMPLE_MFD_I2C)     +=3D simple-mfd-i2c.o
> >  obj-$(CONFIG_MFD_INTEL_M10_BMC)   +=3D intel-m10-bmc.o
> > diff --git a/drivers/mfd/sy7636a.c b/drivers/mfd/sy7636a.c
> > new file mode 100644
> > index 000000000000..e08f29ea63f8
> > --- /dev/null
> > +++ b/drivers/mfd/sy7636a.c
> > @@ -0,0 +1,82 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +//
>
> Only the SPDX with C++ style comments please.
>
> > +// MFD parent driver for SY7636A chip
>
> Drop the MFD part.  It's a Linuxisum that doesn't really exist.
>
> > +// Copyright (C) 2021 reMarkable AS - http://www.remarkable.com/
> > +//
> > +// Authors: Lars Ivar Miljeteig <lars.ivar.miljeteig@remarkable.com>
> > +//          Alistair Francis <alistair@alistair23.me>
> > +//
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
> > +
> > +static const struct of_device_id of_sy7636a_match_table[] =3D {
> > +     { .compatible =3D "silergy,sy7636a", },
> > +     {}
> > +};
> > +MODULE_DEVICE_TABLE(of, of_sy7636a_match_table);
>
> Hold on.  This driver doesn't really do anything.  If you create OF
> nodes for all the sub-devices, you can use simple-mfd-i2c.
>
> Any reason you can't do that?

Just to confirm, you mean something like this?

diff --git a/arch/arm/boot/dts/imx7d-remarkable2.dts
b/arch/arm/boot/dts/imx7d-remarkable2.dts
index 9327d1c06c96..3577104b3853 100644
--- a/arch/arm/boot/dts/imx7d-remarkable2.dts
+++ b/arch/arm/boot/dts/imx7d-remarkable2.dts
@@ -382,6 +382,21 @@ epd_pmic: sy7636a@62 {
                pinctrl-0 =3D <&pinctrl_epdpmic>;
                #thermal-sensor-cells =3D <0>;

+               regulator@0 {
+                       compatible =3D "sy7636a-regulator";
+                       reg =3D <0>;
+               };
+
+               temperature@0 {
+                       compatible =3D "sy7636a-temperature";
+                       reg =3D <0>;
+               };
+
+               thermal@0 {
+                       compatible =3D "sy7636a-thermal";
+                       reg =3D <0>;
+               };
+
                regulators {
                        compatible =3D "silergy,sy7636a-regulator";
diff --git a/drivers/mfd/simple-mfd-i2c.c b/drivers/mfd/simple-mfd-i2c.c
index 87f684cff9a1..622a05318cff 100644
--- a/drivers/mfd/simple-mfd-i2c.c
+++ b/drivers/mfd/simple-mfd-i2c.c
@@ -39,6 +39,7 @@ static int simple_mfd_i2c_probe(struct i2c_client *i2c)

 static const struct of_device_id simple_mfd_i2c_of_match[] =3D {
        { .compatible =3D "kontron,sl28cpld" },
+       { .compatible =3D "silergy,sy7636a" },
        {}
 };
 MODULE_DEVICE_TABLE(of, simple_mfd_i2c_of_match);

Alistair

>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Senior Technical Lead - Developer Services
> Linaro.org =E2=94=82 Open source software for Arm SoCs
> Follow Linaro: Facebook | Twitter | Blog
