Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEF4443A436
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 22:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236257AbhJYURm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 16:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235236AbhJYURd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 16:17:33 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27082C090825
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 12:46:55 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id d21-20020a9d4f15000000b0054e677e0ac5so16421293otl.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 12:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=fHhhI8Ak42Q18aY+dcy+21zqQH/15Y/iNTqR57Dkngc=;
        b=FOWRYX3k7+DN1wrq2N8uK3JzIceGy4DiJYsYcNZb6WwPZR1ygfCB1bnB+12tP3TOcg
         hlpUR5N9zp6njEPosHwgwOJUnZEuIqZMCr+nKzEcUtAzAe5JWAQp7AoBugej33Wtf6ZY
         KOoqDOt09XZ3/SnYmRtbp3tBqdlkHLm7DI8mE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=fHhhI8Ak42Q18aY+dcy+21zqQH/15Y/iNTqR57Dkngc=;
        b=i08XulODY167cJLXDEC7KDegYQaLDYVxYuDJOl9rDVlqNW4TDEMF48TxlrF4F7MAzy
         G1eb2SqGJNizgUeAMZcaItPwPqPfC8FdV42y3RajHef0mRJTzuU7hlkJHdcSDM1sCc1T
         QR488QJYUuerRtWQrTdPwG/7ao0umMPW4zm0Q8A7O9Nbq/GzkvbcSqKUOT9PNVGRtZbg
         mUGR6Yrh0I1CMsx8ozgBSj3Lka6R/N+lbyZg1CRAEuOibc4fZzv29yFTaGpqk6xnL7gR
         HbCmBBI+wk7ajno6+JsSv4hYR8Wo14I09ETlMvcejbm64qO9JFgeTXu3MZC9io5j0fRR
         XT9A==
X-Gm-Message-State: AOAM531RyGioWIe/eEXQTutSievbhBHgoy0EU6V1wK/SavvklzLo/0q3
        p6pWmxPuVR9gsMzFrar2orEwn+B+7Tz0qg/Cy9zB9w==
X-Google-Smtp-Source: ABdhPJy1T18HNchhwFipfCc9rCZgREY7DdueXcirUcNgUZQyLJ/R41flW96WnLfaF8Dt1w0/pRVZPk7k+Qp+T+okxRg=
X-Received: by 2002:a9d:12f4:: with SMTP id g107mr15516593otg.77.1635191214463;
 Mon, 25 Oct 2021 12:46:54 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 25 Oct 2021 12:46:53 -0700
MIME-Version: 1.0
In-Reply-To: <168101fa5937d841d7073e94db246df9@codeaurora.org>
References: <1633060859-22969-1-git-send-email-skakit@codeaurora.org>
 <1633060859-22969-4-git-send-email-skakit@codeaurora.org> <CAE-0n50HiFin8+ZmrbCoK=CCq4JM5JKGN=fTDrS9wGdTb8uzAQ@mail.gmail.com>
 <168101fa5937d841d7073e94db246df9@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Mon, 25 Oct 2021 12:46:53 -0700
Message-ID: <CAE-0n53zhYcUJZQPkdGqeK4cb-vPqc-zHQboKQxMuO+fV4jVPQ@mail.gmail.com>
Subject: Re: [PATCH V2 3/4] regulator: Add a regulator driver for the PM8008 PMIC
To:     skakit@codeaurora.org
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Das Srinagesh <gurus@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mka@chromium.org,
        collinsd@codeaurora.org, subbaram@codeaurora.org,
        kgunda@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting skakit@codeaurora.org (2021-10-22 05:28:34)
> On 2021-10-06 00:05, Stephen Boyd wrote:
> > Quoting Satya Priya (2021-09-30 21:00:58)
> >> diff --git a/drivers/regulator/qcom-pm8008-regulator.c
> >> b/drivers/regulator/qcom-pm8008-regulator.c
> >> new file mode 100644
> >> index 0000000..5dacaa4
> >> --- /dev/null
> >> +++ b/drivers/regulator/qcom-pm8008-regulator.c
> >> @@ -0,0 +1,320 @@
> >> +// SPDX-License-Identifier: GPL-2.0-only
> >> +/* Copyright (c) 2021, The Linux Foundation. All rights reserved. */
> >> +
> >> +#include <linux/delay.h>
[...]
> >> +
> >> +static int pm8008_regulator_get_voltage(struct regulator_dev *rdev)
> >> +{
> >> +       struct pm8008_regulator *pm8008_reg = rdev_get_drvdata(rdev);
> >> +       u8 vset_raw[2];
> >> +       int rc;
> >> +
> >> +       rc = pm8008_read(pm8008_reg->regmap,
> >> +                       LDO_VSET_LB_REG(pm8008_reg->base),
> >> +                       vset_raw, 2);
> >
> > Can this be an __le16 mV?
> >
>
> Below is the diff after changing as per your suggestion, Please correct
> me if wrong.
>
> -       u8 vset_raw[2];
> +       __le16 mV;
>          int rc;
>
> -       rc = pm8008_read(pm8008_reg->regmap,
> -                       LDO_VSET_LB_REG(pm8008_reg->base),
> -                       vset_raw, 2);
> +       rc = regmap_bulk_read(pm8008_reg->regmap,
> +                       LDO_VSET_LB_REG(pm8008_reg->base), &mV, 2);
>          if (rc < 0) {
>                  dev_err(pm8008_reg->dev, "failed to read regulator
> voltage rc=%d\n", rc);
>                  return rc;
>          }
>
> -       return (vset_raw[1] << 8 | vset_raw[0]) * 1000;
> +       return le16_to_cpu(mV) * 1000;

Looks good. Does mV need to be casted when passed to regmap_bulk_read()?

>
> Below is the diff:
>
> -       int rc = 0, mv;
> -       u8 vset_raw[2];
> +       int rc, mv;
> +       u16 vset_raw;
>          [...]
> -       vset_raw[0] = mv & 0xff;
> -       vset_raw[1] = (mv & 0xff00) >> 8;
> -       rc = pm8008_write(pm8008_reg->regmap,
> LDO_VSET_LB_REG(pm8008_reg->base),
> -                       vset_raw, 2);
> +       vset_raw = cpu_to_le16(mv);
> +
> +       rc = regmap_bulk_write(pm8008_reg->regmap,
> +                       LDO_VSET_LB_REG(pm8008_reg->base), &vset_raw,
> +                       sizeof(vset_raw));
>

Ok, thanks

> >> +               dev_err(dev, "%s: failed to get regulator data\n",
> >> name);
> >> +               return -ENODATA;
> >> +       }
> >> +
> >> +       init_data->constraints.input_uV =
> >> init_data->constraints.max_uV;
> >> +       reg_config.dev = dev;
> >> +       reg_config.init_data = init_data;
> >> +       reg_config.driver_data = pm8008_reg;
> >> +       reg_config.of_node = reg_node;
> >> +
> >> +       pm8008_reg->rdesc.type = REGULATOR_VOLTAGE;
> >> +       pm8008_reg->rdesc.ops = &pm8008_regulator_ops;
> >> +       pm8008_reg->rdesc.name = init_data->constraints.name;
> >> +       pm8008_reg->rdesc.supply_name = reg_data[i].supply_name;
> >> +       pm8008_reg->rdesc.uV_step = VSET_STEP_UV;
> >> +       pm8008_reg->rdesc.min_uV = reg_data[i].min_uv;
> >> +       pm8008_reg->rdesc.n_voltages
> >> +               = ((reg_data[i].max_uv - reg_data[i].min_uv)
> >> +                       / pm8008_reg->rdesc.uV_step) + 1;
> >> +
> >> +       pm8008_reg->rdesc.enable_reg = LDO_ENABLE_REG(base);
> >> +       pm8008_reg->rdesc.enable_mask = ENABLE_BIT;
> >> +       pm8008_reg->rdesc.min_dropout_uV = reg_data[i].min_dropout_uv;
> >> +       of_property_read_u32(reg_node, "qcom,min-dropout-voltage",
> >> +                            &pm8008_reg->rdesc.min_dropout_uV);
> >
> > Why do we allow DT to override this? Isn't it a property of the
> > hardware
> > that doesn't change? So the driver can hardcode the knowledge about the
> > dropout.
> >
>
> The headroom values change with targets. We are adding some default
> headroom values in the driver and later overwriting them with the actual
> values specified in the DT.

What do you mean by "targets"? Is that the SoC the PMIC is paired with?
I'd prefer it be a standard regulator property instead of qcom specific
if it actually needs to be different based on different devices.

>
> >> +
> >> +       pm8008_reg->rdev = devm_regulator_register(dev,
> >> &pm8008_reg->rdesc,
> >
> > Is this assignment ever used? Seems like it would be better to merely
> >
> >       return PTR_ERR_OR_ZERO(devm_regulator_register(dev, ...));
> >
>
> Okay.
>
> >> +                                               &reg_config);
> >> +       if (IS_ERR(pm8008_reg->rdev)) {
> >> +               rc = PTR_ERR(pm8008_reg->rdev);
> >> +               dev_err(dev, "%s: failed to register regulator
> >> rc=%d\n",
> >> +                               pm8008_reg->rdesc.name, rc);
> >> +               return rc;
> >> +       }
> >> +
> >> +       dev_dbg(dev, "%s regulator registered\n", name);
> >> +
> >> +       return 0;
> >> +}
> >> +
> >> +static int pm8008_parse_regulator(struct regmap *regmap, struct
> >> device *dev)
> >> +{
> >> +       int rc = 0;
> >
> > Drop initialization.
> >
>
> Okay.
>
> >> +       const char *name;
> >> +       struct device_node *child;
> >> +       struct pm8008_regulator *pm8008_reg;
> >> +
> >> +       /* parse each subnode and register regulator for regulator
> >> child */
> >> +       for_each_available_child_of_node(dev->of_node, child) {
> >> +               pm8008_reg = devm_kzalloc(dev, sizeof(*pm8008_reg),
> >> GFP_KERNEL);
> >> +
> >> +               pm8008_reg->regmap = regmap;
> >> +               pm8008_reg->of_node = child;
> >> +               pm8008_reg->dev = dev;
> >> +
> >> +               rc = of_property_read_string(child, "regulator-name",
> >> &name);
> >> +               if (rc)
> >> +                       continue;
> >> +
> >> +               rc = pm8008_register_ldo(pm8008_reg, name);
> >
> > Can we use the of_parse_cb similar to qcom_spmi-regulator.c?
> >
>
> Are you suggesting to remove the pm8008_register_ldo API and add its
> contents in probe itself and then use of_parse_cb callback like in
> qcom_spmi-regulator.c?

Yes

>
> Do we have any advantage using that here? Also I am not exactly sure
> what all contents to put in that. Seems like we can put the step rate
> and min-dropout-voltage configurations in there.

Right. The regulator code is setup to do "DT parsing stuff" for each
regulator node already, so you don't need to duplicate that logic in
this driver. That's the main goal, consolidate regulator matching and
iteration into the core. Maybe Mark has more info.
