Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 322CC3DFD9A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 11:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236904AbhHDJGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 05:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235528AbhHDJGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 05:06:37 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE67C0613D5
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 02:06:24 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id b128so753165wmb.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 02:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=fek9tYBlhdhrU7dCmsbkvE0PWz8UZbll5VrIM672nLw=;
        b=qCxNXYwBUKEgmfv41Ksy/hwAem0tvjMgzmuQAwi3cD1IVi0UFPTbjxha/HquFzLUNN
         CmNwRv0nMnX4Fddu97WKuM/Wug3vmSK9HP0ahFala585VZhcL/Tp3Gye6yM3i1og8gF8
         H57JriY1pHxhpkIbroqpbjcrkxPNueURI7osd20cpkGDJk+pqIGI04IyU+HIj+22XuQC
         Pcr6pCK/KewwUYV48gXUWpAQDQSZLQB+vp6IgrNNfaVhrYCk7FM7Vj6rgzTeF+ToAJz9
         fKMvcvkxHqzbvCtFv/J6daI/kFXvWxj9bupukm4/cdmXMi5W2Y7/Jqk5c7NAZ2HVN6fG
         Nwdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=fek9tYBlhdhrU7dCmsbkvE0PWz8UZbll5VrIM672nLw=;
        b=nqnTFjuBwP8q9HthgsmuIKfVBpronQ2Av9hSeByWgpb8cWzow5Wa5OTIt+RsH7Fyhm
         enqTkKGenDl+HBFmC0d9aRplsfBhwDNwkT4nRROYbsWGxQCx3dwxTqpxxOQpGIxufZrL
         9TKmGJuQBBvgEohBv8mU3WI+wP4mUaHy51lTZIg8Rr0V3MXcoyPZdTDxD4MwbfelymaT
         44dH2fYswAulrHUb2OFTQsaM0WGVUCoVwh7XwsEzWJb9tEXSMMcAVmEr5bIqRwGtRs2f
         vr9hflXbT28nNdDhrcx4xK64ziEA+wFUPx1xEPagjUj0KkZVde2yzpSgIWOxCY9UtNui
         f11g==
X-Gm-Message-State: AOAM5309ZSc16WqPFdxj4P+2IMQtLJFRwEppTEUEdw53XFxnZOY0Tryp
        cmrmEf6gCqXs9l2Cl+e8JZ5FiA==
X-Google-Smtp-Source: ABdhPJzpqeyUylpo53QNk/g+chsU22g7uFH0HcgoAZxydKAbFerMz9+IvN0IlEDazdbo+iAIZssnmw==
X-Received: by 2002:a05:600c:4eca:: with SMTP id g10mr14925508wmq.16.1628067983266;
        Wed, 04 Aug 2021 02:06:23 -0700 (PDT)
Received: from google.com ([109.180.115.228])
        by smtp.gmail.com with ESMTPSA id m14sm1697269wrs.56.2021.08.04.02.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 02:06:22 -0700 (PDT)
Date:   Wed, 4 Aug 2021 10:06:20 +0100
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
Message-ID: <YQpYjEc9r8QGUhiD@google.com>
References: <20210803084456.198-1-alistair@alistair23.me>
 <20210803084456.198-2-alistair@alistair23.me>
 <YQlBtQDrVHqh3N5D@google.com>
 <CAKmqyKMZWVx3KqeysUjOc29nuxnwJfZ3wjmWjVwk9tpQ4dkh-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKmqyKMZWVx3KqeysUjOc29nuxnwJfZ3wjmWjVwk9tpQ4dkh-A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Aug 2021, Alistair Francis wrote:

> On Tue, Aug 3, 2021 at 11:16 PM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > On Tue, 03 Aug 2021, Alistair Francis wrote:
> >
> > > Initial support for the Silergy SY7636A Power Management chip.
> > >
> > > Signed-off-by: Alistair Francis <alistair@alistair23.me>
> > > ---
> > >  drivers/mfd/Kconfig         |  9 +++++
> > >  drivers/mfd/Makefile        |  1 +
> > >  drivers/mfd/sy7636a.c       | 72 +++++++++++++++++++++++++++++++++++++
> > >  include/linux/mfd/sy7636a.h | 45 +++++++++++++++++++++++
> > >  4 files changed, 127 insertions(+)
> > >  create mode 100644 drivers/mfd/sy7636a.c
> > >  create mode 100644 include/linux/mfd/sy7636a.h
> > >
> > > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > > index 6a3fd2d75f96..b82208f0c79c 100644
> > > --- a/drivers/mfd/Kconfig
> > > +++ b/drivers/mfd/Kconfig
> > > @@ -1352,6 +1352,15 @@ config MFD_SYSCON
> > >         Select this option to enable accessing system control registers
> > >         via regmap.
> > >
> > > +config MFD_SY7636A
> > > +     tristate "Silergy SY7636A Power Management IC"
> > > +     select MFD_CORE
> > > +     select REGMAP_I2C
> > > +     depends on I2C
> > > +     help
> > > +       Select this option to enable support for the Silergy SY7636A
> > > +       Power Management IC.
> > > +
> > >  config MFD_DAVINCI_VOICECODEC
> > >       tristate
> > >       select MFD_CORE
> > > diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> > > index 8116c19d5fd4..cbe581e87fa9 100644
> > > --- a/drivers/mfd/Makefile
> > > +++ b/drivers/mfd/Makefile
> > > @@ -266,6 +266,7 @@ obj-$(CONFIG_MFD_KHADAS_MCU)      += khadas-mcu.o
> > >  obj-$(CONFIG_MFD_ACER_A500_EC)       += acer-ec-a500.o
> > >  obj-$(CONFIG_MFD_QCOM_PM8008)        += qcom-pm8008.o
> > >
> > > +obj-$(CONFIG_MFD_SY7636A)    += sy7636a.o
> > >  obj-$(CONFIG_SGI_MFD_IOC3)   += ioc3.o
> > >  obj-$(CONFIG_MFD_SIMPLE_MFD_I2C)     += simple-mfd-i2c.o
> > >  obj-$(CONFIG_MFD_INTEL_M10_BMC)   += intel-m10-bmc.o
> > > diff --git a/drivers/mfd/sy7636a.c b/drivers/mfd/sy7636a.c
> > > new file mode 100644
> > > index 000000000000..f3ff93c7395d
> > > --- /dev/null
> > > +++ b/drivers/mfd/sy7636a.c
> > > @@ -0,0 +1,72 @@
> > > +// SPDX-License-Identifier: GPL-2.0+
> > > +/*
> > > + * MFD parent driver for SY7636A chip
> > > + *
> > > + * Copyright (C) 2021 reMarkable AS - http://www.remarkable.com/
> > > + *
> > > + * Authors: Lars Ivar Miljeteig <lars.ivar.miljeteig@remarkable.com>
> > > + *          Alistair Francis <alistair@alistair23.me>
> > > + *
> > > + * Based on the lp87565 driver by Keerthy <j-keerthy@ti.com>
> > > + */
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
> >
> > What kind of regulator is 'vcom'? LDO? DCDC?
> 
> Both I guess:
> 
> "SY7636A is a single-chip power management IC (PMIC) designed for
> electronic paper display (EPD) applications. The device supports panel
> sizes up to 9.7 inches and larger. The device integrates two
> high-efficiency DC-DC boost converters, which are boosted to 25V and
> -20V by two charge pumps to provide gate driver power for the panel.
> Two tracking LDOs create a ±15V source driver power supply that
> supports output currents up to 200mA. SY7636A also provides I2C
> interface control for specific panel requirements"

Is there a datasheet I could look at?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
