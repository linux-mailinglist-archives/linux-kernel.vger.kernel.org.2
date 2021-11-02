Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20D6444380A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 22:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbhKBVz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 17:55:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:59222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229628AbhKBVz1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 17:55:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0D7E460E08;
        Tue,  2 Nov 2021 21:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635889972;
        bh=+puO1KwLqb0QCA9FpzLKqvicjHb2V7kw3IRn3IkgR9o=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=l+BYIyhHlvR0cze4als5Myq56hEsCNz4giUp8WKMyXFEgtaKoUTAnJNYcTuDINEE2
         tu9jCwaut/veW3VGjU/A8yaIx933f8VRNWrzWQANE2T9gCGzXlb5cZyoFoODG8Ohwg
         tJ1waerZZxhFkQLge016LXQJcPRYQwaHqmu6wpP98lwrgN91y7/vxVuSUakz7LVHWV
         QwSvMrg5ZcnErfp9u07X3xYRNzdGYNbIX1WBzBI5mG4R29Pacdrs9gdIypVop468pe
         rclzQrmS5KFAda3lnxOmOa+LC4wyS/wfTvUp7HuB+hFOH6M81DeG5y+iQTOM11g0XC
         /xAxDMn4HUdEA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211019074030.31294-4-kavyasree.kotagiri@microchip.com>
References: <20211019074030.31294-1-kavyasree.kotagiri@microchip.com> <20211019074030.31294-4-kavyasree.kotagiri@microchip.com>
Subject: Re: [PATCH v9 3/3] clk: lan966x: Add lan966x SoC clock driver
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     nicolas.ferre@microchip.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        UNGLinuxDriver@microchip.com, Eugen.Hristev@microchip.com,
        Kavyasree.Kotagiri@microchip.com, Manohar.Puri@microchip.com
To:     Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>,
        mturquette@baylibre.com, robh+dt@kernel.org
Date:   Tue, 02 Nov 2021 14:52:50 -0700
Message-ID: <163588997070.2993099.15915757233630724042@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kavyasree Kotagiri (2021-10-19 00:40:30)
> diff --git a/drivers/clk/clk-lan966x.c b/drivers/clk/clk-lan966x.c
> new file mode 100644
> index 000000000000..19bec94e1551
> --- /dev/null
> +++ b/drivers/clk/clk-lan966x.c
> @@ -0,0 +1,240 @@
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
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +#include <dt-bindings/clock/microchip,lan966x.h>
> +
> +#define GCK_ENA         BIT(0)
> +#define GCK_SRC_SEL     GENMASK(9, 8)
> +#define GCK_PRESCALER   GENMASK(23, 16)
> +
> +#define DIV_MAX                255
> +
> +static const char *clk_names[N_CLOCKS] =3D {
> +       "qspi0", "qspi1", "qspi2", "sdmmc0",
> +       "pi", "mcan0", "mcan1", "flexcom0",
> +       "flexcom1", "flexcom2", "flexcom3",
> +       "flexcom4", "timer1", "usb_refclk",
> +};
> +
> +struct lan966x_gck {
> +       struct clk_hw hw;
> +       void __iomem *reg;
> +};
> +#define to_lan966x_gck(hw) container_of(hw, struct lan966x_gck, hw)
> +
> +static const struct clk_parent_data lan966x_gck_pdata[] =3D {
> +       { .fw_name =3D "cpu_clk", .name =3D "cpu_clk" },

name shouldn't be required if the binding is new. That's the case
right?


> +       { .fw_name =3D "ddr_clk", .name =3D "ddr_clk" },
> +       { .fw_name =3D "sys_clk", .name =3D "sys_clk" },
> +};
> +
