Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 724EB39543B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 05:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbhEaDlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 May 2021 23:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbhEaDlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 May 2021 23:41:42 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B5BC061574;
        Sun, 30 May 2021 20:40:02 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id i8-20020a4aa1080000b0290201edd785e7so2495486ool.1;
        Sun, 30 May 2021 20:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mxXYMo3kYoIBlfp//omOxKhPJ2kyxaKYPD0IANQv/KU=;
        b=sYLRZD66eYPYodYjbfx1DTL6jwoHkv9gKAEkWgRxJgBrLBYtU/v5FQsDmM6zJO9ONo
         gvGl6HHGp/a1sWZ44NSI9kyh5de1pH+Z7l8AyjEDb96hZQtPFYCt+rCDFReXjm5eI2N9
         hNMYkHOCNKtHy2bybKvS9fmKab2UB+Gm0ux8zSPFrcDdPVJtOaW3omWMsgCOLMEPAifP
         QCY7jzn5pi+LtaM76zqqdG62kVQ9C8HZwOptnRQTIe8Z39q+T+gXHpvX4wkiplnrhm7/
         7WFy24MT+NGTiUl/+dG+yyCljW3mXsaR9nMoaxbs6Xj41JGxAs4VaghQv8XrTqIVmS+2
         bAGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mxXYMo3kYoIBlfp//omOxKhPJ2kyxaKYPD0IANQv/KU=;
        b=JBI/g4hAf6dmE5JgIw99GJTY/m90MgRt8ashSjwT/SXag/BnxAr36xrA54APAmttH+
         CJuqfK9pkjkogxmYCsg7s8rp0uSGYwKayrIgneuKsoFqAFZBYhLEZGYD356q7yILzY1s
         XYz2fZxxGRY34ddyuIX8SRFYU26pPC0I6Bn5LR22XWKq3FC5B3pzUrwNntyU6Phq542f
         I99BUus1uyaCL8+3zkTd2/zTICS87e7QfFzdrN/2gowpp7Li2mgYmHxIHfHH3fM3kBv9
         3qpl+GSZHSF+DLNscTPiqpUaVH2NW3otgt/7Xz5YGNQufd344UhdVUh0Zq0ti6PtVpmo
         m71w==
X-Gm-Message-State: AOAM531ekMCZLjDlDvySQtklQ/WvAg/ni4Cqv+f7+GB22LnTZzbRMQw9
        e3V2pIPPBzAgxTpAW/A5xUsX0H2Hat2B17EFic0=
X-Google-Smtp-Source: ABdhPJxHaQq7O/4YfTuQPvz65Rn5bpAhlfJl2rVZ+3OrM71kjqwbvZAsfo6GceHMfAi8mYW4i1jeIZObB/ahsdzuojc=
X-Received: by 2002:a4a:ea19:: with SMTP id x25mr13892859ood.1.1622432401560;
 Sun, 30 May 2021 20:40:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210528081300.64759-1-gene.chen.richtek@gmail.com>
 <20210528081300.64759-4-gene.chen.richtek@gmail.com> <62cdd2d18839e16686f35f0cf08080e2cb3b1768.camel@fi.rohmeurope.com>
In-Reply-To: <62cdd2d18839e16686f35f0cf08080e2cb3b1768.camel@fi.rohmeurope.com>
From:   Gene Chen <gene.chen.richtek@gmail.com>
Date:   Mon, 31 May 2021 11:39:50 +0800
Message-ID: <CAE+NS36WuNkQYn8_UvsZaU5Equ9YH+Ya=c_j3cLNhuFnHT_J-g@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] power: supply: mt6360_charger: add MT6360 charger support
To:     "Vaittinen, Matti" <matti.vaittinen@fi.rohmeurope.com>
Cc:     sre@kernel.org, Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>, inux-pm@vger.kernel.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Gene Chen <gene_chen@richtek.com>, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, ChiYuan Huang <cy_huang@richtek.com>,
        benjamin.chao@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 is is

Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com> =E6=96=BC 2021=E5=B9=B4=
5=E6=9C=8828=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=885:47=E5=AF=AB=E9=
=81=93=EF=BC=9A
>
>
> On Fri, 2021-05-28 at 16:13 +0800, Gene Chen wrote:
> > From: Gene Chen <gene_chen@richtek.com>
> >
> > Add basic support for the battery charger for MT6360 PMIC
> >
> > Signed-off-by: Gene Chen <gene_chen@richtek.com>
> > ---
> >  drivers/power/supply/Kconfig          |  11 +
> >  drivers/power/supply/Makefile         |   1 +
> >  drivers/power/supply/mt6360_charger.c | 856
> > ++++++++++++++++++++++++++
> >  3 files changed, 868 insertions(+)
> >  create mode 100644 drivers/power/supply/mt6360_charger.c
> >
> > diff --git a/drivers/power/supply/Kconfig
> > b/drivers/power/supply/Kconfig
> > index e696364126f1..3257b1ad5e36 100644 11
> > --- a/drivers/power/supply/Kconfig
> > +++ b/drivers/power/supply/Kconfig
> > @@ -577,6 +577,17 @@ config CHARGER_MP2629
> >         Battery charger. This driver provides Battery charger power
> > management
> >         functions on the systems.
> >
> > +config CHARGER_MT6360
> > +     tristate "Mediatek MT6360 Charger Driver"
> > +     depends on MFD_MT6360
> > +     depends on REGULATOR
> > +     select LINEAR_RANGES
> > +     help
> > +       Say Y here to enable MT6360 Charger Part.
> > +       The device supports High-Accuracy Voltage/Current Regulation,
> > +       Average Input Current Regulation, Battery Tempature Sensing,
> > +       Over-Temperature Protection, DPDM Detection for BC1.2
> > +
> >  config CHARGER_QCOM_SMBB
> >       tristate "Qualcomm Switch-Mode Battery Charger and Boost"
> >       depends on MFD_SPMI_PMIC || COMPILE_TEST
> > diff --git a/drivers/power/supply/Makefile
> > b/drivers/power/supply/Makefile
> > index a7309a3d1a47..5317fe787149 100644
> > --- a/drivers/power/supply/Makefile
> > +++ b/drivers/power/supply/Makefile
> > @@ -78,6 +78,7 @@ obj-$(CONFIG_CHARGER_MAX77693)      +=3D
> > max77693_charger.o
> >  obj-$(CONFIG_CHARGER_MAX8997)        +=3D max8997_charger.o
> >  obj-$(CONFIG_CHARGER_MAX8998)        +=3D max8998_charger.o
> >  obj-$(CONFIG_CHARGER_MP2629) +=3D mp2629_charger.o
> > +obj-$(CONFIG_CHARGER_MT6360) +=3D mt6360_charger.o
> >  obj-$(CONFIG_CHARGER_QCOM_SMBB)      +=3D qcom_smbb.o
> >  obj-$(CONFIG_CHARGER_BQ2415X)        +=3D bq2415x_charger.o
> >  obj-$(CONFIG_CHARGER_BQ24190)        +=3D bq24190_charger.o
> > diff --git a/drivers/power/supply/mt6360_charger.c
> > b/drivers/power/supply/mt6360_charger.c
> > new file mode 100644
> > index 000000000000..07fa0b3870e0
> > --- /dev/null
> > +++ b/drivers/power/supply/mt6360_charger.c
> > @@ -0,0 +1,856 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) 2021 MediaTek Inc.
> > + */
> > +
> > +#include <linux/init.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/kernel.h>
> > +#include <linux/linear_range.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/power_supply.h>
> > +#include <linux/property.h>
> > +#include <linux/regmap.h>
> > +#include <linux/regulator/driver.h>
> > +
> > +#define MT6360_PMU_CHG_CTRL1 0x311
> > +#define MT6360_PMU_CHG_CTRL2 0x312
> > +#define MT6360_PMU_CHG_CTRL3 0x313
> > +#define MT6360_PMU_CHG_CTRL4 0x314
> > +#define MT6360_PMU_CHG_CTRL5 0x315
> > +#define MT6360_PMU_CHG_CTRL6 0x316
> > +#define MT6360_PMU_CHG_CTRL7 0x317
> > +#define MT6360_PMU_CHG_CTRL8 0x318
> > +#define MT6360_PMU_CHG_CTRL9 0x319
> > +#define MT6360_PMU_CHG_CTRL10        0x31A
> > +#define MT6360_PMU_DEVICE_TYPE       0x322
> > +#define MT6360_PMU_USB_STATUS1       0x327
> > +#define MT6360_PMU_CHG_STAT  0x34A
> > +#define MT6360_PMU_CHG_CTRL19        0x361
> > +#define MT6360_PMU_FOD_STAT  0x3E7
> > +
> > +/* MT6360_PMU_CHG_CTRL1 */
> > +#define MT6360_FSLP_SHFT     (3)
> > +#define MT6360_FSLP_MASK     BIT(MT6360_FSLP_SHFT)
> > +#define MT6360_OPA_MODE_SHFT (0)
> > +#define MT6360_OPA_MODE_MASK BIT(MT6360_OPA_MODE_SHFT)
> > +/* MT6360_PMU_CHG_CTRL2 */
> > +#define MT6360_IINLMTSEL_SHFT        (2)
> > +#define MT6360_IINLMTSEL_MASK        GENMASK(3, 2)
> > +/* MT6360_PMU_CHG_CTRL3 */
> > +#define MT6360_IAICR_SHFT    (2)
> > +#define MT6360_IAICR_MASK    GENMASK(7, 2)
> > +#define MT6360_ILIM_EN_MASK  BIT(0)
> > +/* MT6360_PMU_CHG_CTRL4 */
> > +#define MT6360_VOREG_SHFT    (1)
> > +#define MT6360_VOREG_MASK    GENMASK(7, 1)
> > +/* MT6360_PMU_CHG_CTRL5 */
> > +#define MT6360_VOBST_MASK    GENMASK(7, 2)
> > +/* MT6360_PMU_CHG_CTRL6 */
> > +#define MT6360_VMIVR_SHFT      (1)
> > +#define MT6360_VMIVR_MASK      GENMASK(7, 1)
> > +/* MT6360_PMU_CHG_CTRL7 */
> > +#define MT6360_ICHG_SHFT     (2)
> > +#define MT6360_ICHG_MASK     GENMASK(7, 2)
> > +/* MT6360_PMU_CHG_CTRL8 */
> > +#define MT6360_IPREC_SHFT    (0)
> > +#define MT6360_IPREC_MASK    GENMASK(3, 0)
> > +/* MT6360_PMU_CHG_CTRL9 */
> > +#define MT6360_IEOC_SHFT     (4)
> > +#define MT6360_IEOC_MASK     GENMASK(7, 4)
> > +/* MT6360_PMU_CHG_CTRL10 */
> > +#define MT6360_OTG_OC_MASK   GENMASK(3, 0)
> > +/* MT6360_PMU_DEVICE_TYPE */
> > +#define MT6360_USBCHGEN_MASK BIT(7)
> > +/* MT6360_PMU_USB_STATUS1 */
> > +#define MT6360_USB_STATUS_SHFT       (4)
> > +#define MT6360_USB_STATUS_MASK       GENMASK(6, 4)
> > +/* MT6360_PMU_CHG_STAT */
> > +#define MT6360_CHG_STAT_SHFT (6)
> > +#define MT6360_CHG_STAT_MASK GENMASK(7, 6)
> > +#define MT6360_VBAT_LVL_MASK BIT(5)
> > +/* MT6360_PMU_CHG_CTRL19 */
> > +#define MT6360_VINOVP_SHFT   (5)
> > +#define MT6360_VINOVP_MASK   GENMASK(6, 5)
> > +/* MT6360_PMU_FOD_STAT */
> > +#define MT6360_CHRDET_EXT_MASK       BIT(4)
> > +
> > +enum {
> > +     MT6360_RANGE_VMIVR,
> > +     MT6360_RANGE_ICHG,
> > +     MT6360_RANGE_VOREG,
> > +     MT6360_RANGE_AICR,
> > +     MT6360_RANGE_IPREC,
> > +     MT6360_RANGE_IEOC,
> > +     MT6360_RANGE_MAX,
> > +};
> > +
> > +#define MT6360_LINEAR_RANGE(idx, _min, _min_sel, _max_sel, _step)
> > \
> > +     [idx] =3D {                                                      =
 \
> > +             .min =3D _min,
> > \
> > +             .min_sel =3D _min_sel,
> > \
> > +             .max_sel =3D _max_sel,
> > \
> > +             .step =3D _step,
> > \
> > +     }
> >
>
> Do you think REGULATOR_LINEAR_RANGE() would fit this? Or is the naming
> a problem there? (Just a minor thing, no need to re-spin for this)
>

Yes, it is fit for this but REGULATOR_LINEAR_RANGE is used for
regulator which is defined in regulator/driver.h.
I think it's better to defined ours and add idx for easy to read.
Is it better to re-use REGULATOR_LINEAR_RANGE?

> //snip
>
> > +static int mt6360_charger_probe(struct platform_device *pdev)
> > +{
> > +     struct mt6360_chg_info *mci;
> > +     struct power_supply_config charger_cfg =3D {};
> > +     struct regulator_config config =3D { };
> > +     int ret;
> > +
> > +     mci =3D devm_kzalloc(&pdev->dev, sizeof(*mci), GFP_KERNEL);
> > +     if (!mci)
> > +             return -ENOMEM;
> > +
> > +     mci->dev =3D &pdev->dev;
> > +     mci->vinovp =3D 6500000;
> > +     mutex_init(&mci->chgdet_lock);
> > +     platform_set_drvdata(pdev, mci);
> > +     INIT_WORK(&mci->chrdet_work, &mt6360_chrdet_work);
>
> //snip
>
> > +
> > +static int mt6360_charger_remove(struct platform_device *pdev)
> > +{
> > +     struct mt6360_chg_info *mci =3D platform_get_drvdata(pdev);
> > +
> > +     cancel_work_sync(&mci->chrdet_work);
> > +
> > +     return 0;
> > +}
>
> Just as a note, devm_work_autocancel() should hopefully be included at
> next cycle. Then you might be able to drop the .remove().
>

ACK, I will replace it, thanks.

> FWIW:
> Reviewed-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
>
> Best Regards
>         Matti Vaittinen
>
