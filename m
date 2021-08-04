Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 744FE3DFCBB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 10:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236300AbhHDIYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 04:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236279AbhHDIYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 04:24:14 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E68FC0613D5;
        Wed,  4 Aug 2021 01:24:01 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id z7so1474503iog.13;
        Wed, 04 Aug 2021 01:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eb+TKlXCM46Z6tbqcEsEswjl6rovh8B22X0RVpQXd7U=;
        b=vCQAEFqQVzQV/2uc0cXBp8db0kmXGlPSb6MxGgezbVtonLlWfocTd7QymizEDqge54
         dPUJRiPY1DpA5xune/betgMlO2377fzNlTa4ohK3zwFz+SN1z496brHSQjd98K78V7XV
         6BXH5Uec/01ekh0nsqTIWjtYdLI0DrKvvrf441ZXpjTP1MyLItEO7bZ6A24hgy1WbMir
         Ry7xDLdNw0356U8awJICY4GGjrkkw9jQXnnpYxxnMUXFOJkfSaa8PnW6j61Ok0IhIEeC
         XfbIvyV9mkTfSvfjFiWDqv/Cg6xC+t5mdEf+NtCKmbLoB2NiAso896O9FBI9sYCgkReU
         mV+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eb+TKlXCM46Z6tbqcEsEswjl6rovh8B22X0RVpQXd7U=;
        b=Ko3H3kPSWC/JwJGkv1y57xA0viM2v0DfvKApY9KKFTB6iPGNE+XfhrGcAmNhi9EJzX
         CZQHEdghtiylHXnzAgoLBAcn7tOWxwpYfm5ZvYFy87Ny9nPgi7KN9SxnmHfvQ+4mMB1i
         MLlBDEgV83QRHbzKTtnzsRCrU5Ds1F3PGjBlNO4dc2S9ogRPJWKyta0Dab99xpleTchu
         kgHC1CTNuyll1y0yD38QJe4+Fa6+VHRIghvm3Y6rCak+EBCcZd8fXmRUbhYKi6+NpdxW
         qICcK5xSbG4Icm/lEfC4y9JPKqBBpZFoVI3kKbcGZ2SSYgFttbdTMOS9Y13RvPEl1Oxf
         OWmA==
X-Gm-Message-State: AOAM530l6E/JhmTG2rANifKW0/zkUjj90IufbPsO47lCyRdqU5g3USBf
        VQAxBTqxlCWZi01Q7VK9J/Rk8zFNn2cYrYkXbPo=
X-Google-Smtp-Source: ABdhPJyggLddJMxmH+EazD/b2CkCx2eAQUCXI3ipFEEkkszNqgKKJ057F38PpHH5uOWQQ58JJdUTU8a4DS0QQLx2X90=
X-Received: by 2002:a6b:490d:: with SMTP id u13mr86293iob.176.1628065440657;
 Wed, 04 Aug 2021 01:24:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210803084456.198-1-alistair@alistair23.me> <20210803084456.198-2-alistair@alistair23.me>
 <YQlBtQDrVHqh3N5D@google.com>
In-Reply-To: <YQlBtQDrVHqh3N5D@google.com>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Wed, 4 Aug 2021 18:22:00 +1000
Message-ID: <CAKmqyKMZWVx3KqeysUjOc29nuxnwJfZ3wjmWjVwk9tpQ4dkh-A@mail.gmail.com>
Subject: Re: [PATCH v8 02/11] mfd: sy7636a: Initial commit
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

On Tue, Aug 3, 2021 at 11:16 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Tue, 03 Aug 2021, Alistair Francis wrote:
>
> > Initial support for the Silergy SY7636A Power Management chip.
> >
> > Signed-off-by: Alistair Francis <alistair@alistair23.me>
> > ---
> >  drivers/mfd/Kconfig         |  9 +++++
> >  drivers/mfd/Makefile        |  1 +
> >  drivers/mfd/sy7636a.c       | 72 +++++++++++++++++++++++++++++++++++++
> >  include/linux/mfd/sy7636a.h | 45 +++++++++++++++++++++++
> >  4 files changed, 127 insertions(+)
> >  create mode 100644 drivers/mfd/sy7636a.c
> >  create mode 100644 include/linux/mfd/sy7636a.h
> >
> > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > index 6a3fd2d75f96..b82208f0c79c 100644
> > --- a/drivers/mfd/Kconfig
> > +++ b/drivers/mfd/Kconfig
> > @@ -1352,6 +1352,15 @@ config MFD_SYSCON
> >         Select this option to enable accessing system control registers
> >         via regmap.
> >
> > +config MFD_SY7636A
> > +     tristate "Silergy SY7636A Power Management IC"
> > +     select MFD_CORE
> > +     select REGMAP_I2C
> > +     depends on I2C
> > +     help
> > +       Select this option to enable support for the Silergy SY7636A
> > +       Power Management IC.
> > +
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
> > index 000000000000..f3ff93c7395d
> > --- /dev/null
> > +++ b/drivers/mfd/sy7636a.c
> > @@ -0,0 +1,72 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * MFD parent driver for SY7636A chip
> > + *
> > + * Copyright (C) 2021 reMarkable AS - http://www.remarkable.com/
> > + *
> > + * Authors: Lars Ivar Miljeteig <lars.ivar.miljeteig@remarkable.com>
> > + *          Alistair Francis <alistair@alistair23.me>
> > + *
> > + * Based on the lp87565 driver by Keerthy <j-keerthy@ti.com>
> > + */
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
>
> What kind of regulator is 'vcom'? LDO? DCDC?

Both I guess:

"SY7636A is a single-chip power management IC (PMIC) designed for
electronic paper display (EPD) applications. The device supports panel
sizes up to 9.7 inches and larger. The device integrates two
high-efficiency DC-DC boost converters, which are boosted to 25V and
-20V by two charge pumps to provide gate driver power for the panel.
Two tracking LDOs create a =C2=B115V source driver power supply that
supports output currents up to 200mA. SY7636A also provides I2C
interface control for specific panel requirements"

Alistair

>
> > +     { .name =3D "sy7636a-temperature", },
> > +     { .name =3D "sy7636a-thermal", },
> > +};
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Senior Technical Lead - Developer Services
> Linaro.org =E2=94=82 Open source software for Arm SoCs
> Follow Linaro: Facebook | Twitter | Blog
