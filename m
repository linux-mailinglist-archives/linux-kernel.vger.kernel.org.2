Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFD73E2611
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 10:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbhHFI1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 04:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244046AbhHFI1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 04:27:05 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A9BC061385
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 01:19:05 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id r1so7983078iln.6
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 01:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vIww8QZWLaOp0+QSkUA4VMHuBwDjb/r3R281dHn75KE=;
        b=DAzYPGXRjFlLoNcLfn3esPMzHD5carrhiX2mMEp2UY/biI8oVc45OAusfeo6lcxebK
         knI3kCjRuBW8AQqxcG3lGuLMrE5JrDueJVc6sG8r1ipD4Mk+SSeMUbi6sTo8ZV1x2r+d
         Ny3Ps5QIbfXAkjpcjGeuKexumCRdiUe1KO7T9r2VkSEi6JXeJgE3SF3WObLeBy28mxkq
         KkvqabSpKsqSw1jalEOld4SXo+o1GijxNMeZABTmw11AiuxO+/thjY/ZE+uhB8WOvtE5
         LAgujoc/O1MninAV3coQ5daNXFuC+5/VHrQApI/d4hVfDqcADAhhwfhq9kwPZAdepaBC
         B2Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vIww8QZWLaOp0+QSkUA4VMHuBwDjb/r3R281dHn75KE=;
        b=AgusBsjXB4Vb1busGFmoXKj3KrcsuMDaYCnzP3XDM4wJ7aXDnrLWyNW4wKQXb3W4DG
         +y6JCGjwQEqCUMQlnXeA9Jdfzh5SVrK14Nj1cqzkbe1w/ZQtpdTLn9qn92YogWIaluWw
         KVIFBES7wfJ/CzBx09AEQCE7Vg/3ek/QMCMXG0gPc35mjVo3IErfeOc/AIfZM7OGV0QJ
         kKfiskdlSTSSM5D6zJoBLb7xFHwlTQXb+mGuTBHrd2TSRTpTavAnaP1XaAdRuIrDsEJd
         RqhRkMJnuevdCYOhTvFxca4H9upcghF5Lta7LQaOM1o5FeOKEt3ddpm374eeZ5+d1WhC
         K8NA==
X-Gm-Message-State: AOAM533To09aFthL+hSHWZEYnOyyAYUgFlOXEGh7dzSXXpCsrCTpTgwW
        vyic3azb4TWnDi6+SIOMDP6VPoT8LHHDDYljR4s=
X-Google-Smtp-Source: ABdhPJyTM2uCk42ks+bpzHCrhp6hZ6u5kPffe8NAkVWdbwtdxxyC1VNflgzgzhm0QYxHLS8QLMDYAvUETXDpODIKaYM=
X-Received: by 2002:a05:6e02:1d8d:: with SMTP id h13mr215231ila.40.1628237944603;
 Fri, 06 Aug 2021 01:19:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210805085611.864188-1-lee.jones@linaro.org>
In-Reply-To: <20210805085611.864188-1-lee.jones@linaro.org>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Fri, 6 Aug 2021 18:19:00 +1000
Message-ID: <CAKmqyKMPg8kikB7Ym6qc+VYAwt0DvyXK+xqu3SwgJwcaCyUrbA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mfd: simple-mfd-i2c: Add support for registering
 devices via MFD cells
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michael Walle <michael@walle.cc>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 5, 2021 at 6:56 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> More devices are cropping up requiring only Regmap initialisation and
> child registration functionality.  We currently only support that if
> all required devices are represented by their own Device Tree nodes
> complete with compatible strings.
>
> However, not everyone is happy with adding empty nodes that provide no
> additional device information into the Device Tree.
>
> Rather than have a plethora of mostly empty, function-less drivers in
> MFD, we'll support those simple cases in here instead via MFD cells.
>
> Cc: Michael Walle <michael@walle.cc>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Alistair Francis <alistair23@gmail.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
> v2:
>  - Check for empty of_device_id .data entry
>
>  drivers/mfd/simple-mfd-i2c.c | 41 +++++++++++++++++++++++++++++-------
>  drivers/mfd/simple-mfd-i2c.h | 32 ++++++++++++++++++++++++++++
>  2 files changed, 65 insertions(+), 8 deletions(-)
>  create mode 100644 drivers/mfd/simple-mfd-i2c.h
>
> diff --git a/drivers/mfd/simple-mfd-i2c.c b/drivers/mfd/simple-mfd-i2c.c
> index 87f684cff9a17..583e8c7924af0 100644
> --- a/drivers/mfd/simple-mfd-i2c.c
> +++ b/drivers/mfd/simple-mfd-i2c.c
> @@ -2,39 +2,64 @@
>  /*
>   * Simple MFD - I2C
>   *
> + * Author(s):
> + *     Michael Walle <michael@walle.cc>
> + *     Lee Jones <lee.jones@linaro.org>
> + *
>   * This driver creates a single register map with the intention for it to be
>   * shared by all sub-devices.  Children can use their parent's device structure
>   * (dev.parent) in order to reference it.
>   *
>   * Once the register map has been successfully initialised, any sub-devices
> - * represented by child nodes in Device Tree will be subsequently registered.
> + * represented by child nodes in Device Tree or via the MFD cells in this file
> + * will be subsequently registered.
>   */
>
>  #include <linux/i2c.h>
>  #include <linux/kernel.h>
> +#include <linux/mfd/core.h>
>  #include <linux/module.h>
>  #include <linux/of_platform.h>
>  #include <linux/regmap.h>
>
> -static const struct regmap_config simple_regmap_config = {
> +#include "simple-mfd-i2c.h"
> +
> +static const struct regmap_config regmap_config_8r_8v = {
>         .reg_bits = 8,
>         .val_bits = 8,
>  };
>
>  static int simple_mfd_i2c_probe(struct i2c_client *i2c)
>  {
> -       const struct regmap_config *config;
> +       const struct simple_mfd_data *simple_mfd_data;
> +       const struct regmap_config *regmap_config;
>         struct regmap *regmap;
> +       int ret;
> +
> +       simple_mfd_data = device_get_match_data(&i2c->dev);
>
> -       config = device_get_match_data(&i2c->dev);
> -       if (!config)
> -               config = &simple_regmap_config;
> +       /* If no regmap_config is specified, use the default 8reg and 8val bits */
> +       if (!simple_mfd_data || !simple_mfd_data->regmap_config)
> +               regmap_config = &regmap_config_8r_8v;
> +       else
> +               regmap_config = simple_mfd_data->regmap_config;
>
> -       regmap = devm_regmap_init_i2c(i2c, config);
> +       regmap = devm_regmap_init_i2c(i2c, regmap_config);
>         if (IS_ERR(regmap))
>                 return PTR_ERR(regmap);
>
> -       return devm_of_platform_populate(&i2c->dev);
> +       /* If no MFD cells are spedified, use register the DT child nodes instead */
> +       if (!simple_mfd_data || !simple_mfd_data->mfd_cell)
> +               return devm_of_platform_populate(&i2c->dev);
> +
> +       ret = devm_mfd_add_devices(&i2c->dev, PLATFORM_DEVID_AUTO,
> +                                  simple_mfd_data->mfd_cell,
> +                                  simple_mfd_data->mfd_cell_size,
> +                                  NULL, 0, NULL);
> +       if (!ret)

Shouldn't this be `if (ret)` instead?

With that changed this works for me as well:

Reviewed-by: Alistair Francis <alistair@alistair23.me>
Tested-by: Alistair Francis <alistair@alistair23.me>

Alistair

> +               dev_err(&i2c->dev, "Failed to add child devices\n");
> +
> +       return ret;
>  }
>
>  static const struct of_device_id simple_mfd_i2c_of_match[] = {
> diff --git a/drivers/mfd/simple-mfd-i2c.h b/drivers/mfd/simple-mfd-i2c.h
> new file mode 100644
> index 0000000000000..7cb2bdd347d97
> --- /dev/null
> +++ b/drivers/mfd/simple-mfd-i2c.h
> @@ -0,0 +1,32 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Simple MFD - I2C
> + *
> + * Author: Lee Jones <lee.jones@linaro.org>
> + *
> + * This driver creates a single register map with the intention for it to be
> + * shared by all sub-devices.  Children can use their parent's device structure
> + * (dev.parent) in order to reference it.
> + *
> + * This driver creates a single register map with the intention for it to be
> + * shared by all sub-devices.  Children can use their parent's device structure
> + * (dev.parent) in order to reference it.
> + *
> + * Once the register map has been successfully initialised, any sub-devices
> + * represented by child nodes in Device Tree or via the MFD cells in the
> + * associated C file will be subsequently registered.
> + */
> +
> +#ifndef __MFD_SIMPLE_MFD_I2C_H
> +#define __MFD_SIMPLE_MFD_I2C_H
> +
> +#include <linux/mfd/core.h>
> +#include <linux/regmap.h>
> +
> +struct simple_mfd_data {
> +       const struct regmap_config *regmap_config;
> +       const struct mfd_cell *mfd_cell;
> +       size_t mfd_cell_size;
> +};
> +
> +#endif /* __MFD_SIMPLE_MFD_I2C_H */
> --
> 2.32.0.605.g8dce9f2422-goog
>
