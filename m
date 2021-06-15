Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D63F33A869F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 18:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbhFOQiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 12:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbhFOQiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 12:38:15 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520D4C061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 09:36:09 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id v22so28099652lfa.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 09:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=meiWr2OjeMDLBdcZeHPehaSP6RNTxl7Lje2/hZwYpE4=;
        b=ijDJ50RMtof0HF/zW49gqcFZHU47UgEVK32PgtGgxFfu+tm8EO4wlvldQCEoofwTIY
         K++4CVNdaX38itMpgcAEaidm2ab2bhFm0Km6IH+4RdL6wUs5xN5p1cLWvuaHmJFdiWg+
         0VsMtrI/oOsRmrT6ySRN+WPdtZfXKyKmdD7/Qro8bvEmTOJs4HpRzAujRqtcjpyBawdW
         ifIu7aKtsQlxwadr9htP2DVlEw+UJrfuBXl5YU66kGN9c2U7ZLw9/qoJxdXzRdGl2W7C
         +3/lPrjPWBjEDgLqDXXrEvVd8Jcn8AMBHIbtNTLjAMLGLzQr3QsQzZoGXSLw1n4CdB84
         6yrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=meiWr2OjeMDLBdcZeHPehaSP6RNTxl7Lje2/hZwYpE4=;
        b=PGSIypyyEcF2T67XpqNuO3J9rczav+Qmw4qkvdgH3HHTIcMNRDJw4YmZBqS67V+ZKd
         lVFyIjN7Aw+WQJDrUQccC3/Rz+FmryO5UZfe5aNqh3SP7kKMX1JcskY/IGo+pTCJteS+
         kn75APHeAERXZqQ6vA9z9F66G1bSV6xeSF9+bbbvuIAzuquWGJqL2HD1ZP42xdXsuFqO
         nQ01uhqXdWya2dDa6klegnPZn0bEi8+23/DOy1CXKKtJZF6bYBX5mV7vs3HWmKRYTbDH
         T0UyBl5AsRKhiopWt5SotFozdgYSWq1Ed/hcN09RExKjNtgZTxIPyNfkWT70YEqpTrem
         7lwA==
X-Gm-Message-State: AOAM532UCwF3mPtsVTaZ0kzuo0cl3nYi3u1IOOePLhEEF7lvSipS3Ven
        zhY3V4bLNAevmJqhA6CzjAhVl5Xut+CKPunSAGY=
X-Google-Smtp-Source: ABdhPJzWxTEgl6BuB/zt8ICoRVQHE+trtOJ8DSn4pVvBHJxXUAm0hOwol2kqUHV8jE3SezojBczj28hfHdMvckjT6XE=
X-Received: by 2002:a05:6512:23a0:: with SMTP id c32mr202592lfv.554.1623774967500;
 Tue, 15 Jun 2021 09:36:07 -0700 (PDT)
MIME-Version: 1.0
References: <1623774501-23647-1-git-send-email-u0084500@gmail.com>
In-Reply-To: <1623774501-23647-1-git-send-email-u0084500@gmail.com>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Wed, 16 Jun 2021 00:35:55 +0800
Message-ID: <CADiBU39QEM3srCRM_9sevVNRi4EK95MTq60w-KSgUoqv_92w5A@mail.gmail.com>
Subject: Re: [PATCH] regulator: rt6160: Revert chagne and fix vsel high/low
 suspend voltage logic
To:     Mark Brown <broonie@kernel.org>, axel.lin@ingics.com
Cc:     lgirdwood@gmail.com, lkml <linux-kernel@vger.kernel.org>,
        ChiYuan Huang <cy_huang@richtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I may misunderstand logic in suspend voltage.

The vsel active level is for the normal voltage, the opposite level is
the suspend voltage.

In the suspend voltage callback, I wrote donw the wrong logic.
This patch is to fix it and reverse Axel's change.
I need vsel_active_low variable in suspend voltage callback, not just in lo=
cal.

cy_huang <u0084500@gmail.com> =E6=96=BC 2021=E5=B9=B46=E6=9C=8816=E6=97=A5 =
=E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=8812:28=E5=AF=AB=E9=81=93=EF=BC=9A
>
> From: ChiYuan Huang <cy_huang@richtek.com>
>
> Revert change and fix vsel logic in suspend voltage logic.
>
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
>  drivers/regulator/rt6160-regulator.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/regulator/rt6160-regulator.c b/drivers/regulator/rt6=
160-regulator.c
> index ccd023d..1cdb1f4 100644
> --- a/drivers/regulator/rt6160-regulator.c
> +++ b/drivers/regulator/rt6160-regulator.c
> @@ -42,6 +42,7 @@ struct rt6160_priv {
>         struct regulator_desc desc;
>         struct gpio_desc *enable_gpio;
>         struct regmap *regmap;
> +       bool vsel_active_low;
>         bool enable_state;
>  };
>
> @@ -127,15 +128,19 @@ static unsigned int rt6160_get_mode(struct regulato=
r_dev *rdev)
>
>  static int rt6160_set_suspend_voltage(struct regulator_dev *rdev, int uV=
)
>  {
> +       struct rt6160_priv *priv =3D rdev_get_drvdata(rdev);
>         struct regmap *regmap =3D rdev_get_regmap(rdev);
> +       unsigned int reg =3D RT6160_REG_VSELH;
>         int vsel;
>
>         vsel =3D regulator_map_voltage_linear(rdev, uV, uV);
>         if (vsel < 0)
>                 return vsel;
>
> -       return regmap_update_bits(regmap, rdev->desc->vsel_reg,
> -                                 RT6160_VSEL_MASK, vsel);
> +       if (!priv->vsel_active_low)
> +               reg =3D RT6160_REG_VSELL;
> +
> +       return regmap_update_bits(regmap, reg, RT6160_VSEL_MASK, vsel);
>  }
>
>  static int rt6160_get_error_flags(struct regulator_dev *rdev, unsigned i=
nt *flags)
> @@ -223,7 +228,6 @@ static int rt6160_probe(struct i2c_client *i2c)
>         struct rt6160_priv *priv;
>         struct regulator_config regulator_cfg =3D {};
>         struct regulator_dev *rdev;
> -       bool vsel_active_low;
>         unsigned int devid;
>         int ret;
>
> @@ -231,8 +235,7 @@ static int rt6160_probe(struct i2c_client *i2c)
>         if (!priv)
>                 return -ENOMEM;
>
> -       vsel_active_low =3D
> -               device_property_present(&i2c->dev, "richtek,vsel-active-l=
ow");
> +       priv->vsel_active_low =3D device_property_present(&i2c->dev, "ric=
htek,vsel-active-low");
>
>         priv->enable_gpio =3D devm_gpiod_get_optional(&i2c->dev, "enable"=
, GPIOD_OUT_HIGH);
>         if (IS_ERR(priv->enable_gpio)) {
> @@ -264,10 +267,7 @@ static int rt6160_probe(struct i2c_client *i2c)
>         priv->desc.owner =3D THIS_MODULE;
>         priv->desc.min_uV =3D RT6160_VOUT_MINUV;
>         priv->desc.uV_step =3D RT6160_VOUT_STPUV;
> -       if (vsel_active_low)
> -               priv->desc.vsel_reg =3D RT6160_REG_VSELL;
> -       else
> -               priv->desc.vsel_reg =3D RT6160_REG_VSELH;
> +       priv->desc.vsel_reg =3D RT6160_REG_VSELH;
>         priv->desc.vsel_mask =3D RT6160_VSEL_MASK;
>         priv->desc.n_voltages =3D RT6160_N_VOUTS;
>         priv->desc.ramp_reg =3D RT6160_REG_CNTL;
> @@ -276,6 +276,8 @@ static int rt6160_probe(struct i2c_client *i2c)
>         priv->desc.n_ramp_values =3D ARRAY_SIZE(rt6160_ramp_tables);
>         priv->desc.of_map_mode =3D rt6160_of_map_mode;
>         priv->desc.ops =3D &rt6160_regulator_ops;
> +       if (priv->vsel_active_low)
> +               priv->desc.vsel_reg =3D RT6160_REG_VSELL;
>
>         regulator_cfg.dev =3D &i2c->dev;
>         regulator_cfg.of_node =3D i2c->dev.of_node;
> --
> 2.7.4
>
