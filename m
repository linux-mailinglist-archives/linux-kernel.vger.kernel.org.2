Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D43E53D885F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 08:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233921AbhG1G6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 02:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234451AbhG1G6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 02:58:02 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E16BC061764;
        Tue, 27 Jul 2021 23:58:00 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id z7so915651iog.13;
        Tue, 27 Jul 2021 23:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=T84a7za3PtCwZotVNy8M0LVi79R6z41wn6dqwPakag8=;
        b=jLGbYXWoKDomlhO2O5HjLl194eX2V6L80CtOilsQLxc+faDL9UeowJvBhMFNxnUxD4
         99me1dHs9oVeFwRkWQfAXgyPc2955vxIrEoCDTH0fjaPjRQ9we+0dvwL33g3ig6dF/R3
         zdQjgl+FpJUO0OAwnV9IHTsPFwDi3hDF3+fbb/kebOK4oC4invEI7kUklxdO4xGkLRDf
         XhDZLmqbE6ROW5M+UTqFemTPPyYProwQgcRwT2vywO/gP44vGKOjXSe8ao9BX8v8/EtI
         PyXXR0ZWW6uumi/BM+luTrM29dY15uCkl67eTSNV5Ghym1Cj+SKcUpgTTm6jsWh61b32
         7WDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=T84a7za3PtCwZotVNy8M0LVi79R6z41wn6dqwPakag8=;
        b=VXatq4djijHUJyuU61qKZvSQ+I5poU0pbt0C+vXG2bKkEnUFiRuqMeR3z7wClztQ2r
         pVzncrl2bDMB7eAzI5r01R4I6SBimy1Mu/y9I6kiQ1aWFogIAVelWZC7IfIZAKmD7VRR
         qx8zrJkeprJzXZ2k1+ZNq2PQpUlrVFgx+6zDhtdPxDYFctrAi+LLNE8gm5AuQ78utZAl
         5X7Kir2bRbIqd5acdx+yafrVkKFbrlqvClYRqP/eqiPvzasfvzZYzeugNcFOlHg212zn
         3Eol0ZQ9tbQ8VgwRf0TplSck6sLLD0HxtCM52smwmOWzNWejMrrvegNlm5U9uLCxqxMP
         l5Yg==
X-Gm-Message-State: AOAM533ibYZZotStorNCqJ4AfYmhZ+okAoiu0Fds6YPCUi+AccmsHAsL
        6rfHaviUHRxjVGbGV2q8owu9wLn8ONAq5JJUOic=
X-Google-Smtp-Source: ABdhPJx2vEX9ZJhBfQh536y5B1c97Gpv/dg1xTJ3H/9wNiyz2DVLuPQOrYbcJ31A47ucRUH96ka30wSHcbNNDZ9l7y0=
X-Received: by 2002:a5d:8541:: with SMTP id b1mr10296205ios.105.1627455480004;
 Tue, 27 Jul 2021 23:58:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210615103400.946-1-alistair@alistair23.me> <20210615103400.946-2-alistair@alistair23.me>
 <YMnY7RLW6ml4Tq0g@dell> <CAKmqyKNs+Ebvd5MwtoKfKhNrMJVhTsBLjDhLXRuK8C+gs5MCcQ@mail.gmail.com>
 <YMsTy3QnYzjrFSFg@dell> <CAKmqyKODRkahuUL+SFj8RQYq2rvj=nLgseozAyiwkDmtD8JE+g@mail.gmail.com>
 <YObzzE8y2tyiMg5p@google.com>
In-Reply-To: <YObzzE8y2tyiMg5p@google.com>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Wed, 28 Jul 2021 16:57:34 +1000
Message-ID: <CAKmqyKN-wnTHrRYTxw3R6h=rcrbSUSF0vh3pwvt5ByaDzEiFMQ@mail.gmail.com>
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

On Thu, Jul 8, 2021 at 10:47 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Thu, 08 Jul 2021, Alistair Francis wrote:
>
> > On Thu, Jun 17, 2021 at 7:20 PM Lee Jones <lee.jones@linaro.org> wrote:
> > >
> > > On Thu, 17 Jun 2021, Alistair Francis wrote:
> > >
> > > > On Wed, Jun 16, 2021 at 8:56 PM Lee Jones <lee.jones@linaro.org> wr=
ote:
> > > > >
> > > > > On Tue, 15 Jun 2021, Alistair Francis wrote:
> > > > >
> > > > > > Initial support for the Silergy SY7636A Power Management chip.
> > > > > >
> > > > > > Signed-off-by: Alistair Francis <alistair@alistair23.me>
> > > > > > ---
> > > > > >  drivers/mfd/Kconfig         |  9 ++++
> > > > > >  drivers/mfd/Makefile        |  1 +
> > > > > >  drivers/mfd/sy7636a.c       | 82 +++++++++++++++++++++++++++++=
++++++++
> > > > > >  include/linux/mfd/sy7636a.h | 47 +++++++++++++++++++++
> > > > > >  4 files changed, 139 insertions(+)
> > > > > >  create mode 100644 drivers/mfd/sy7636a.c
> > > > > >  create mode 100644 include/linux/mfd/sy7636a.h
> > > > > >
> > > > > > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > > > > > index 5c7f2b100191..7d6cf32b1549 100644
> > > > > > --- a/drivers/mfd/Kconfig
> > > > > > +++ b/drivers/mfd/Kconfig
> > > > > > @@ -1339,6 +1339,15 @@ config MFD_SYSCON
> > > > > >         Select this option to enable accessing system control r=
egisters
> > > > > >         via regmap.
> > > > > >
> > > > > > +config MFD_SY7636A
> > > > > > +     tristate "Silergy SY7636A Power Management chip"
> > > > > > +     select MFD_CORE
> > > > > > +     select REGMAP_I2C
> > > > > > +     depends on I2C
> > > > > > +     help
> > > > > > +       Select this option to enable support for the Silergy SY=
7636A
> > > > > > +       Power Management chip.
> > > > > > +
> > > > > >  config MFD_DAVINCI_VOICECODEC
> > > > > >       tristate
> > > > > >       select MFD_CORE
> > > > > > diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> > > > > > index 4f6d2b8a5f76..f95e1e725a95 100644
> > > > > > --- a/drivers/mfd/Makefile
> > > > > > +++ b/drivers/mfd/Makefile
> > > > > > @@ -265,6 +265,7 @@ obj-$(CONFIG_MFD_STMFX)   +=3D stmfx.o
> > > > > >  obj-$(CONFIG_MFD_KHADAS_MCU)         +=3D khadas-mcu.o
> > > > > >  obj-$(CONFIG_MFD_ACER_A500_EC)       +=3D acer-ec-a500.o
> > > > > >
> > > > > > +obj-$(CONFIG_MFD_SY7636A)    +=3D sy7636a.o
> > > > > >  obj-$(CONFIG_SGI_MFD_IOC3)   +=3D ioc3.o
> > > > > >  obj-$(CONFIG_MFD_SIMPLE_MFD_I2C)     +=3D simple-mfd-i2c.o
> > > > > >  obj-$(CONFIG_MFD_INTEL_M10_BMC)   +=3D intel-m10-bmc.o
> > > > > > diff --git a/drivers/mfd/sy7636a.c b/drivers/mfd/sy7636a.c
> > > > > > new file mode 100644
> > > > > > index 000000000000..e08f29ea63f8
> > > > > > --- /dev/null
> > > > > > +++ b/drivers/mfd/sy7636a.c
> > > > > > @@ -0,0 +1,82 @@
> > > > > > +// SPDX-License-Identifier: GPL-2.0+
> > > > > > +//
> > > > >
> > > > > Only the SPDX with C++ style comments please.
> > > > >
> > > > > > +// MFD parent driver for SY7636A chip
> > > > >
> > > > > Drop the MFD part.  It's a Linuxisum that doesn't really exist.
> > > > >
> > > > > > +// Copyright (C) 2021 reMarkable AS - http://www.remarkable.co=
m/
> > > > > > +//
> > > > > > +// Authors: Lars Ivar Miljeteig <lars.ivar.miljeteig@remarkabl=
e.com>
> > > > > > +//          Alistair Francis <alistair@alistair23.me>
> > > > > > +//
> > > > > > +// Based on the lp87565 driver by Keerthy <j-keerthy@ti.com>
> > > > > > +
> > > > > > +#include <linux/interrupt.h>
> > > > > > +#include <linux/mfd/core.h>
> > > > > > +#include <linux/module.h>
> > > > > > +#include <linux/of_device.h>
> > > > > > +
> > > > > > +#include <linux/mfd/sy7636a.h>
> > > > > > +
> > > > > > +static const struct regmap_config sy7636a_regmap_config =3D {
> > > > > > +     .reg_bits =3D 8,
> > > > > > +     .val_bits =3D 8,
> > > > > > +};
> > > > > > +
> > > > > > +static const struct mfd_cell sy7636a_cells[] =3D {
> > > > > > +     { .name =3D "sy7636a-regulator", },
> > > > > > +     { .name =3D "sy7636a-temperature", },
> > > > > > +     { .name =3D "sy7636a-thermal", },
> > > > > > +};
> > > > > > +
> > > > > > +static const struct of_device_id of_sy7636a_match_table[] =3D =
{
> > > > > > +     { .compatible =3D "silergy,sy7636a", },
> > > > > > +     {}
> > > > > > +};
> > > > > > +MODULE_DEVICE_TABLE(of, of_sy7636a_match_table);
> > > > >
> > > > > Hold on.  This driver doesn't really do anything.  If you create =
OF
> > > > > nodes for all the sub-devices, you can use simple-mfd-i2c.
> > > > >
> > > > > Any reason you can't do that?
> > > >
> > > > Just to confirm, you mean something like this?
> > > >
> > > > diff --git a/arch/arm/boot/dts/imx7d-remarkable2.dts
> > > > b/arch/arm/boot/dts/imx7d-remarkable2.dts
> > > > index 9327d1c06c96..3577104b3853 100644
> > > > --- a/arch/arm/boot/dts/imx7d-remarkable2.dts
> > > > +++ b/arch/arm/boot/dts/imx7d-remarkable2.dts
> > > > @@ -382,6 +382,21 @@ epd_pmic: sy7636a@62 {
> > > >                 pinctrl-0 =3D <&pinctrl_epdpmic>;
> > > >                 #thermal-sensor-cells =3D <0>;
> > > >
> > > > +               regulator@0 {
> > > > +                       compatible =3D "sy7636a-regulator";
> > > > +                       reg =3D <0>;
> > > > +               };
> > > > +
> > > > +               temperature@0 {
> > > > +                       compatible =3D "sy7636a-temperature";
> > > > +                       reg =3D <0>;
> > > > +               };
> > > > +
> > > > +               thermal@0 {
> > > > +                       compatible =3D "sy7636a-thermal";
> > > > +                       reg =3D <0>;
> > > > +               };
> > > > +
> > > >                 regulators {
> > > >                         compatible =3D "silergy,sy7636a-regulator";
> > > > diff --git a/drivers/mfd/simple-mfd-i2c.c b/drivers/mfd/simple-mfd-=
i2c.c
> > > > index 87f684cff9a1..622a05318cff 100644
> > > > --- a/drivers/mfd/simple-mfd-i2c.c
> > > > +++ b/drivers/mfd/simple-mfd-i2c.c
> > > > @@ -39,6 +39,7 @@ static int simple_mfd_i2c_probe(struct i2c_client=
 *i2c)
> > > >
> > > >  static const struct of_device_id simple_mfd_i2c_of_match[] =3D {
> > > >         { .compatible =3D "kontron,sl28cpld" },
> > > > +       { .compatible =3D "silergy,sy7636a" },
> > > >         {}
> > > >  };
> > > >  MODULE_DEVICE_TABLE(of, simple_mfd_i2c_of_match);
> > >
> > > Essentially.  Take a look at how the other users are implementing.
> > >
> > > The reg entries look bogus to me though.  Maybe just leave them out?
> >
> > So I tried this and didn't have any luck.
> >
> > After some Kconfig changes to allow it to build, I managed to get it
> > probing, but I never got it to power up. It doesn't seem to be the
> > same.
>
> I need a more technical reason why this is not the correct approach
> for you.  "I can't get it to work" doesn't quite reach the quality
> line I'm afraid.

Yep, so one thing that we need that the simple-mfd-i2c doesn't do is
the epd-pwr-good-gpios GPIO. This is a GPIO line from the mfd that the
regulator uses.

>
> Did you try enabling the debug prints in of_platform_bus_create() and
> friends to see if your devices are probing correctly?

I think I did, but I can have another look and see if I can get it working.

Alistair

>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Senior Technical Lead - Developer Services
> Linaro.org =E2=94=82 Open source software for Arm SoCs
> Follow Linaro: Facebook | Twitter | Blog
