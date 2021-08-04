Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A08E3DFF70
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 12:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237425AbhHDKfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 06:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235690AbhHDKfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 06:35:52 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32EB2C0613D5;
        Wed,  4 Aug 2021 03:35:39 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id j18so1254121ile.8;
        Wed, 04 Aug 2021 03:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cIkURw95NgBkHCwHJTLshYBEewQNB19HiErM3asNWo8=;
        b=itN2FJzT4BU5qZ+zVxGHQIeJfRqLDoqf8pMrrtNtl9jz9ekRs+xL+kQtT5JUEQMENt
         i3tiOHbGKoGA3eN3RA3I6qudHpfW++32V5ZtONG7NYIHzUtYrZaBpnPCewRElDxmNCkK
         sPpdleAHfdC+adguIqUTZxBHMGqqiiINyq6k3r2MJrYrL7ioV3hnSHwwbAnMjR2/LR0y
         n58g+H7lV5r8kEuu2pQylCIhq+ZTBSo5tLZYoGDqxv9R1ZzwMCJdYb/fvNqZ4uow+Xkm
         LSsgbHEEbLAUyTP9BQD0A6I1XuTmqUo4M3Td6mIrwnVVcX3q7KW4rEStulnzVIaFTq8W
         ehxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cIkURw95NgBkHCwHJTLshYBEewQNB19HiErM3asNWo8=;
        b=ghgrAUX3DOP+jN6D+5wsxGPisMDqB7IwocBHZBZxDF1GH4oB5IZCKPCT4XJJ9n3ebS
         mCms/n/ZpD5zJUtc5Ifr6hDOxGYQb/L4miCTDTUFKExez5XvgkQuQLHCktVaTRJSYzv2
         BaJgMCPJUJ32sa+0SulKMRuO91L5ycJf28OlloxA5t+TazcT7nnweYXZA5HLT+wRundM
         xjVOllKFxtyOkVdZsJ1oTILh/aI7kSJtf+qq9ZzA6ob9bZTaPhBXtkKrKupY5ffX3j/y
         0gY6BSq7NPGd2SoBZgMa61IL0r6/EV5zNU+OjrAnViurKwjzWsOC6yapa/REKykrLp7t
         FqZA==
X-Gm-Message-State: AOAM532YRhir05bHYDkeyITLmCC7UdCx6/QQRVI0v0ZI3F27FwLvc5bA
        fKEoMQ5Y+BldG+lcPkshhoId+Zllc3EhjH5yfxs=
X-Google-Smtp-Source: ABdhPJyyM3kWNuPDOxeOTUndEeJf5r/5yuWapMYkeiy9QIKeuUwV/28sf2whlzrLnEMX5NUYl8a77amm5AiuVz5PcUs=
X-Received: by 2002:a92:c504:: with SMTP id r4mr614549ilg.131.1628073338645;
 Wed, 04 Aug 2021 03:35:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210803084456.198-1-alistair@alistair23.me> <20210803084456.198-2-alistair@alistair23.me>
 <YQlBtQDrVHqh3N5D@google.com> <CAKmqyKMZWVx3KqeysUjOc29nuxnwJfZ3wjmWjVwk9tpQ4dkh-A@mail.gmail.com>
 <YQpYjEc9r8QGUhiD@google.com> <CAKmqyKP79jXdGhMKYzA3ZOkkT6kb2buOSyYuaCS43SK9oe2ACw@mail.gmail.com>
 <YQpr1/PVFqHqs2Zv@google.com>
In-Reply-To: <YQpr1/PVFqHqs2Zv@google.com>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Wed, 4 Aug 2021 20:35:11 +1000
Message-ID: <CAKmqyKMZML59ehsRhc9p5S47HXz+dxQUWj3pLshbf6=towxZfg@mail.gmail.com>
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

On Wed, Aug 4, 2021 at 8:28 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Wed, 04 Aug 2021, Alistair Francis wrote:
>
> > On Wed, Aug 4, 2021 at 7:06 PM Lee Jones <lee.jones@linaro.org> wrote:
> > >
> > > On Wed, 04 Aug 2021, Alistair Francis wrote:
> > >
> > > > On Tue, Aug 3, 2021 at 11:16 PM Lee Jones <lee.jones@linaro.org> wr=
ote:
> > > > >
> > > > > On Tue, 03 Aug 2021, Alistair Francis wrote:
> > > > >
> > > > > > Initial support for the Silergy SY7636A Power Management chip.
> > > > > >
> > > > > > Signed-off-by: Alistair Francis <alistair@alistair23.me>
> > > > > > ---
> > > > > >  drivers/mfd/Kconfig         |  9 +++++
> > > > > >  drivers/mfd/Makefile        |  1 +
> > > > > >  drivers/mfd/sy7636a.c       | 72 +++++++++++++++++++++++++++++=
++++++++
> > > > > >  include/linux/mfd/sy7636a.h | 45 +++++++++++++++++++++++
> > > > > >  4 files changed, 127 insertions(+)
> > > > > >  create mode 100644 drivers/mfd/sy7636a.c
> > > > > >  create mode 100644 include/linux/mfd/sy7636a.h
> > > > > >
> > > > > > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > > > > > index 6a3fd2d75f96..b82208f0c79c 100644
> > > > > > --- a/drivers/mfd/Kconfig
> > > > > > +++ b/drivers/mfd/Kconfig
> > > > > > @@ -1352,6 +1352,15 @@ config MFD_SYSCON
> > > > > >         Select this option to enable accessing system control r=
egisters
> > > > > >         via regmap.
> > > > > >
> > > > > > +config MFD_SY7636A
> > > > > > +     tristate "Silergy SY7636A Power Management IC"
> > > > > > +     select MFD_CORE
> > > > > > +     select REGMAP_I2C
> > > > > > +     depends on I2C
> > > > > > +     help
> > > > > > +       Select this option to enable support for the Silergy SY=
7636A
> > > > > > +       Power Management IC.
> > > > > > +
> > > > > >  config MFD_DAVINCI_VOICECODEC
> > > > > >       tristate
> > > > > >       select MFD_CORE
> > > > > > diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> > > > > > index 8116c19d5fd4..cbe581e87fa9 100644
> > > > > > --- a/drivers/mfd/Makefile
> > > > > > +++ b/drivers/mfd/Makefile
> > > > > > @@ -266,6 +266,7 @@ obj-$(CONFIG_MFD_KHADAS_MCU)      +=3D khad=
as-mcu.o
> > > > > >  obj-$(CONFIG_MFD_ACER_A500_EC)       +=3D acer-ec-a500.o
> > > > > >  obj-$(CONFIG_MFD_QCOM_PM8008)        +=3D qcom-pm8008.o
> > > > > >
> > > > > > +obj-$(CONFIG_MFD_SY7636A)    +=3D sy7636a.o
> > > > > >  obj-$(CONFIG_SGI_MFD_IOC3)   +=3D ioc3.o
> > > > > >  obj-$(CONFIG_MFD_SIMPLE_MFD_I2C)     +=3D simple-mfd-i2c.o
> > > > > >  obj-$(CONFIG_MFD_INTEL_M10_BMC)   +=3D intel-m10-bmc.o
> > > > > > diff --git a/drivers/mfd/sy7636a.c b/drivers/mfd/sy7636a.c
> > > > > > new file mode 100644
> > > > > > index 000000000000..f3ff93c7395d
> > > > > > --- /dev/null
> > > > > > +++ b/drivers/mfd/sy7636a.c
> > > > > > @@ -0,0 +1,72 @@
> > > > > > +// SPDX-License-Identifier: GPL-2.0+
> > > > > > +/*
> > > > > > + * MFD parent driver for SY7636A chip
> > > > > > + *
> > > > > > + * Copyright (C) 2021 reMarkable AS - http://www.remarkable.co=
m/
> > > > > > + *
> > > > > > + * Authors: Lars Ivar Miljeteig <lars.ivar.miljeteig@remarkabl=
e.com>
> > > > > > + *          Alistair Francis <alistair@alistair23.me>
> > > > > > + *
> > > > > > + * Based on the lp87565 driver by Keerthy <j-keerthy@ti.com>
> > > > > > + */
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
> > > > >
> > > > > What kind of regulator is 'vcom'? LDO? DCDC?
> > > >
> > > > Both I guess:
> > > >
> > > > "SY7636A is a single-chip power management IC (PMIC) designed for
> > > > electronic paper display (EPD) applications. The device supports pa=
nel
> > > > sizes up to 9.7 inches and larger. The device integrates two
> > > > high-efficiency DC-DC boost converters, which are boosted to 25V an=
d
> > > > -20V by two charge pumps to provide gate driver power for the panel=
.
> > > > Two tracking LDOs create a =C2=B115V source driver power supply tha=
t
> > > > supports output currents up to 200mA. SY7636A also provides I2C
> > > > interface control for specific panel requirements"
> > >
> > > Is there a datasheet I could look at?
> >
> > I have managed to find this:
> >
> > https://www.silergy.com/cn/productsview/SY7636ARMC
> >
> > which is in Chinese. The datasheet is behind a login page unfortunately=
.
>
> Where did the snippet above come from then?

It's the translation of the above link.

>
> What documentation are you working to?

It's based on the vendor driver and then testing on hardware.

Alistair

>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Senior Technical Lead - Developer Services
> Linaro.org =E2=94=82 Open source software for Arm SoCs
> Follow Linaro: Facebook | Twitter | Blog
