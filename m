Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDC6405EB7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 23:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345085AbhIIVWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 17:22:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:33218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346721AbhIIVWj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 17:22:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0DE7561131;
        Thu,  9 Sep 2021 21:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631222489;
        bh=XlELzx+Xv+i7SKcZjmeK0dXvvEjoI3jCo0u0b1yHTk8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=YK4RgPSScdldRZ8gjAigcUg72GPOoVnJ2r6Mqegrw7YsTOhCzd6lplak2J1Q8ha1z
         SXZIc3kd7yXjQA5TqE4usb3v/GvfoyixO3qojt/+68YWVUmQKp84edNEUZLaz1hmhx
         4NRMQ/byvYIBOCS1l4RELLd2vEakpYood8hQrVRp5FfHHtp9UZtZytheLoerAYmLi1
         NGXGlS9kWRAmTJp50FSPMDOYDOmMprnEjwqGzD3cWGivp+r8EVb8xpeGIuPobSGS0p
         dZrW1urbysjLNLI/lKJzbPcDAuucs2TAoraBQb3WzBF5lwF+CrrK/eq6WYr12GggBw
         9CR1cL4nFyi8w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210909073947.17438-3-kavyasree.kotagiri@microchip.com>
References: <20210909073947.17438-1-kavyasree.kotagiri@microchip.com> <20210909073947.17438-3-kavyasree.kotagiri@microchip.com>
Subject: Re: [PATCH v3 2/3] clk: lan966x: Add lan966x SoC clock driver
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, UNGLinuxDriver@microchip.com,
        Eugen.Hristev@microchip.com, Kavyasree.Kotagiri@microchip.com,
        Manohar.Puri@microchip.com
To:     Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>,
        mturquette@baylibre.com, robh+dt@kernel.org
Date:   Thu, 09 Sep 2021 14:21:27 -0700
Message-ID: <163122248779.1821005.1043993148772937495@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kavyasree Kotagiri (2021-09-09 00:39:46)
> diff --git a/drivers/clk/clk-lan966x.c b/drivers/clk/clk-lan966x.c
> new file mode 100644
> index 000000000000..4492be90cecf
> --- /dev/null
> +++ b/drivers/clk/clk-lan966x.c
> @@ -0,0 +1,235 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Microchip LAN966x SoC Clock driver.
> + *
> + * Copyright (C) 2021 Microchip Technology, Inc. and its subsidiaries
> + *
> + * Author: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk-provider.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
[...]
> +
> +static int lan966x_clk_probe(struct platform_device *pdev)
> +{
> +       struct clk_hw_onecell_data *hw_data;
> +       struct device *dev =3D &pdev->dev;
> +       const char *parent_names[3];
> +       int i, ret;
> +
> +       hw_data =3D devm_kzalloc(dev, sizeof(*hw_data), GFP_KERNEL);
> +       if (!hw_data)
> +               return -ENOMEM;
> +
> +       base =3D devm_platform_ioremap_resource(pdev, 0);
> +       if (IS_ERR(base))
> +               return PTR_ERR(base);
> +
> +       init.ops =3D &lan966x_gck_ops;
> +       init.num_parents =3D 3;
> +
> +       for (i =3D 0; i < init.num_parents; ++i) {
> +               parent_names[i] =3D of_clk_get_parent_name(pdev->dev.of_n=
ode, i);

Please use clk_parent_data instead of of_clk_get_parent_name().

> +               if (!parent_names[i])
> +                       return -EINVAL;
> +       }
> +
> +       init.parent_names =3D parent_names;
> +       hw_data->num =3D N_CLOCKS;
> +
> +       for (i =3D 0; i < N_CLOCKS; i++) {
> +               init.name =3D clk_names[i];
> +               hw_data->hws[i] =3D lan966x_gck_clk_register(dev, i);
> +               if (IS_ERR(hw_data->hws[i])) {
> +                       dev_err(dev, "failed to register %s clock\n",
> +                               init.name);
> +                       return ret;

return PTR_ERR(hw_data->hws[i]);

> +               }
> +       }
> +
> +       return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, hw=
_data);
> +}
> +
> +static const struct of_device_id lan966x_clk_dt_ids[] =3D {
> +       { .compatible =3D "microchip,lan966x-gck", },
> +       { }
> +};
