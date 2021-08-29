Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6ED3FA92F
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 07:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233657AbhH2FJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 01:09:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:58706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229634AbhH2FJN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 01:09:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5805E60ED8;
        Sun, 29 Aug 2021 05:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630213701;
        bh=wgS8fyizTRitjX77P/RKKO8L0gk7tazv8+ZJ1asJWh8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Rmp//pFz2dG6M4kaTQj+v0xbQNBdhUTLjx0KwVsCaVIRaDgJHh9ry2V1Ro16tfbm5
         E346bUqgSEHsjifhyMqOKft5nUYBQrN0t+8809ZGEuk77ZK18KBuk4ttHh63zrli6Z
         a9b36iKAawatqKqo54XVFH1UqEcVk5A2Ti5FSi1l76+SwC776bsrWItjsKojBYjZh1
         sORqyZbFmlNvmjKH9Sk/gDM7gP+26HOhFqAQV0F7xLHwSAOD6e87aMznE1srbp89T8
         M57pFrPA9tARl4Y6HnN0+iOAxjRMZ6y+tUL21mUNY9zxGXhJc1+nkTtt5Ty8lMaHl+
         Ir4wDz5ryA0yg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210804092244.390376-4-nobuhiro1.iwamatsu@toshiba.co.jp>
References: <20210804092244.390376-1-nobuhiro1.iwamatsu@toshiba.co.jp> <20210804092244.390376-4-nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: [PATCH v4 3/4] clk: visconti: Add support common clock driver and reset driver
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        punit1.agrawal@toshiba.co.jp, yuji2.ishikawa@toshiba.co.jp,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     Michael Turquette <mturquette@baylibre.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Rob Herring <robh+dt@kernel.org>
Date:   Sat, 28 Aug 2021 22:08:20 -0700
Message-ID: <163021370000.2676726.5709178579074165441@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Nobuhiro Iwamatsu (2021-08-04 02:22:43)
> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> index 5f06879d7fe9..dbf70fdecfc8 100644
> --- a/drivers/clk/Makefile
> +++ b/drivers/clk/Makefile
> @@ -116,6 +116,7 @@ obj-y                                       +=3D ti/
>  obj-$(CONFIG_CLK_UNIPHIER)             +=3D uniphier/
>  obj-$(CONFIG_ARCH_U8500)               +=3D ux500/
>  obj-y                                  +=3D versatile/
> +obj-$(CONFIG_ARCH_VISCONTI)            +=3D visconti/

Can we have an actual Kconfig symbol for this so we can compile test the
driver?

>  ifeq ($(CONFIG_COMMON_CLK), y)
>  obj-$(CONFIG_X86)                      +=3D x86/
>  endif
> diff --git a/drivers/clk/visconti/Makefile b/drivers/clk/visconti/Makefile
> new file mode 100644
> index 000000000000..c1254fd52b31
> --- /dev/null
> +++ b/drivers/clk/visconti/Makefile
> @@ -0,0 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +# Makefile for Toshiba Visconti clock
> +
> +obj-y  +=3D clkc.o pll.o reset.o
> +obj-y  +=3D pll-tmpv770x.o clkc-tmpv770x.o
> diff --git a/drivers/clk/visconti/clkc-tmpv770x.c b/drivers/clk/visconti/=
clkc-tmpv770x.c
> new file mode 100644
> index 000000000000..6ee5c5179f7c
> --- /dev/null
> +++ b/drivers/clk/visconti/clkc-tmpv770x.c
> @@ -0,0 +1,232 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Toshiba Visconti clock controller
> + *
> + * Copyright (c) 2021 TOSHIBA CORPORATION
> + * Copyright (c) 2021 Toshiba Electronic Devices & Storage Corporation
> + *
> + * Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> + */
> +
> +#include <dt-bindings/clock/toshiba,tmpv770x.h>
> +#include <dt-bindings/reset/toshiba,tmpv770x.h>

Please include these after linux headers.

> +#include <linux/clk.h>

Is it a clk provider or a clk consumer? Hopefully it's a clk provider,
and thus this should be clk-provider.h instead of clk.h for the
consumer.

> +#include <linux/platform_device.h>
> +
> +#include "clkc.h"
> +#include "reset.h"
> +
> +static DEFINE_SPINLOCK(tmpv770x_clk_lock);
> +static DEFINE_SPINLOCK(tmpv770x_rst_lock);
> +
> +static const struct visconti_fixed_clk fixed_clk_tables[] =3D {
> +       /* PLL1 */
> +       /* PICMPT0/1, PITSC, PIUWDT, PISWDT, PISBUS, PIPMU, PIGPMU, PITMU=
 */
> +       /* PIEMM, PIMISC, PIGCOMM, PIDCOMM, PIMBUS, PIGPIO, PIPGM */
> +       { TMPV770X_CLK_PIPLL1_DIV4, "pipll1_div4", "pipll1", 0, 1, 4, },
> +       /* PISBUS */
> +       { TMPV770X_CLK_PIPLL1_DIV2, "pipll1_div2", "pipll1", 0, 1, 2, },
> +       /* PICOBUS_CLK */
> +       { TMPV770X_CLK_PIPLL1_DIV1, "pipll1_div1", "pipll1", 0, 1, 1, },
> +       /* PIDNNPLL */
> +       /* CONN_CLK, PIMBUS, PICRC0/1 */
> +       { TMPV770X_CLK_PIDNNPLL_DIV1, "pidnnpll_div1", "pidnnpll", 0, 1, =
1, },
> +       { TMPV770X_CLK_PIREFCLK, "pirefclk", "osc2-clk", 0, 1, 1, },
> +       { TMPV770X_CLK_WDTCLK, "wdtclk", "osc2-clk", 0, 1, 1, },
> +};
> +
> +static const struct visconti_clk_gate_table pietherpll_clk_gate_tables[]=
 =3D {
> +       /* pietherpll */
> +       { TMPV770X_CLK_PIETHER_2P5M, "piether_2p5m", "pietherpll",
> +               CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, 0x34, 0x134, 4, =
200,

There's quite a lot of CLK_IGNORE_UNUSED. Should these be
CLK_IS_CRITICAL instead, and then only the ones that are truly critical
to the system still running should be marked as critical along with a
comment explaining what they're clocking and why that device isn't
probing and enabling the clks itself.

> +               TMPV770X_RESET_PIETHER_2P5M, },
> +       { TMPV770X_CLK_PIETHER_25M, "piether_25m", "pietherpll",
> +               CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, 0x34, 0x134, 5, =
20,
> +               TMPV770X_RESET_PIETHER_25M, },
> +       { TMPV770X_CLK_PIETHER_50M, "piether_50m", "pietherpll",
> +               CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, 0x34, 0x134, 6, =
10,
> +               TMPV770X_RESET_PIETHER_50M, },
> +       { TMPV770X_CLK_PIETHER_125M, "piether_125m", "pietherpll",
> +               CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, 0x34, 0x134, 7, =
4,
> +               TMPV770X_RESET_PIETHER_125M, },
> +};
> +
> +static const struct visconti_clk_gate_table clk_gate_tables[] =3D {
> +       { TMPV770X_CLK_HOX, "hox", "pipll1",
> +               CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, 0x4C, 0x14C, 0, =
1,

Lowercase hex please.

> +               TMPV770X_RESET_HOX, },
> +       { TMPV770X_CLK_PCIE_MSTR, "pcie_mstr", "pipll1",
> +               CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, 0x38, 0x138, 0, =
1,
> +               TMPV770X_RESET_PCIE_MSTR, },
> +       { TMPV770X_CLK_PCIE_AUX, "pcie_aux", "pipll1",
> +               CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, 0x38, 0x138, 1, =
24,
> +               TMPV770X_RESET_PCIE_AUX, },
> +       { TMPV770X_CLK_PIINTC, "piintc", "pipll1",
> +               CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, 0x8, 0x108, 0, 2,
> +               TMPV770X_RESET_PIINTC,},
> +       { TMPV770X_CLK_PIETHER_BUS, "piether_bus", "pipll1",
> +               CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, 0x34, 0x134, 0, =
2,
> +               TMPV770X_RESET_PIETHER_BUS, }, /* BUS_CLK */
> +       { TMPV770X_CLK_PISPI0, "pispi0", "pipll1",
> +               CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, 0x28, 0x128, 0, =
2,
> +               TMPV770X_RESET_PISPI0, },
> +       { TMPV770X_CLK_PISPI1, "pispi1", "pipll1",
> +               CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, 0x28, 0x128, 1, =
2,
> +               TMPV770X_RESET_PISPI1, },
> +       { TMPV770X_CLK_PISPI2, "pispi2", "pipll1",
> +               CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, 0x28, 0x128, 2, =
2,
> +               TMPV770X_RESET_PISPI2, },
> +       { TMPV770X_CLK_PISPI3, "pispi3", "pipll1",
> +               CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, 0x28, 0x128, 3, =
2,
> +               TMPV770X_RESET_PISPI3,},
> +       { TMPV770X_CLK_PISPI4, "pispi4", "pipll1",
> +               CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, 0x28, 0x128, 4, =
2,
> +               TMPV770X_RESET_PISPI4, },
> +       { TMPV770X_CLK_PISPI5, "pispi5", "pipll1",
> +               CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, 0x28, 0x128, 5, =
2,
> +               TMPV770X_RESET_PISPI5},
> +       { TMPV770X_CLK_PISPI6, "pispi6", "pipll1",
> +               CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, 0x28, 0x128, 6, =
2,
> +               TMPV770X_RESET_PISPI6,},
> +       { TMPV770X_CLK_PIUART0, "piuart0", "pipll1",
> +               CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, 0x2C, 0x12C, 0, =
4,
> +               TMPV770X_RESET_PIUART0,},
> +       { TMPV770X_CLK_PIUART1, "piuart1", "pipll1",
> +               CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, 0x2C, 0x12C, 1, =
4,
> +               TMPV770X_RESET_PIUART1, },
> +       { TMPV770X_CLK_PIUART2, "piuart2", "pipll1",
> +               CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, 0x2C, 0x12C, 2, =
4,
> +               TMPV770X_RESET_PIUART2, },
> +       { TMPV770X_CLK_PIUART3, "piuart3", "pipll1",
> +               CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, 0x2C, 0x12C, 3, =
4,
> +               TMPV770X_RESET_PIUART3, },
> +       { TMPV770X_CLK_PII2C0, "pii2c0", "pipll1",
> +               CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, 0x30, 0x130, 0, =
4,
> +               TMPV770X_RESET_PII2C0, },
> +       { TMPV770X_CLK_PII2C1, "pii2c1", "pipll1",
> +               CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, 0x30, 0x130, 1, =
4,
> +               TMPV770X_RESET_PII2C1, },
> +       { TMPV770X_CLK_PII2C2, "pii2c2", "pipll1",
> +               CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, 0x30, 0x130, 2, =
4,
> +               TMPV770X_RESET_PII2C2, },
> +       { TMPV770X_CLK_PII2C3, "pii2c3", "pipll1",
> +               CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, 0x30, 0x130, 3, =
4,
> +               TMPV770X_RESET_PII2C3,},
> +       { TMPV770X_CLK_PII2C4, "pii2c4", "pipll1",
> +               CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, 0x30, 0x130, 4, =
4,
> +               TMPV770X_RESET_PII2C4, },
> +       { TMPV770X_CLK_PII2C5, "pii2c5", "pipll1",
> +               CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, 0x30, 0x130, 5, =
4,
> +               TMPV770X_RESET_PII2C5, },
> +       { TMPV770X_CLK_PII2C6, "pii2c6", "pipll1",
> +               CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, 0x30, 0x130, 6, =
4,
> +               TMPV770X_RESET_PII2C6, },
> +       { TMPV770X_CLK_PII2C7, "pii2c7", "pipll1",
> +               CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, 0x30, 0x130, 7, =
4,
> +               TMPV770X_RESET_PII2C7, },
> +       { TMPV770X_CLK_PII2C8, "pii2c8", "pipll1",
> +               CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, 0x30, 0x130, 8, =
4,
> +               TMPV770X_RESET_PII2C8, },
> +       /* PIPCMIF */
> +       { TMPV770X_CLK_PIPCMIF, "pipcmif", "pipll1",
> +               CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, 0x64, 0x164, 0, =
4,
> +               TMPV770X_RESET_PIPCMIF, },
> +       /* PISYSTEM */
> +       { TMPV770X_CLK_WRCK, "wrck", "pipll1",
> +               CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, 0x68, 0x168, 9, =
32,
> +               -1, }, /* No reset */
> +       { TMPV770X_CLK_PICKMON, "pickmon", "pipll1",
> +               CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, 0x10, 0x110, 8, =
4,
> +               TMPV770X_RESET_PICKMON, },
> +       { TMPV770X_CLK_SBUSCLK, "sbusclk", "pipll1",
> +               CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, 0x14, 0x114, 0, =
4,
> +               TMPV770X_RESET_SBUSCLK, },
> +};
> +
> +static const struct visconti_reset_data clk_reset_data[] =3D {
> +       [TMPV770X_RESET_PIETHER_2P5M]   =3D { 0x434, 0x534, 4, },
> +       [TMPV770X_RESET_PIETHER_25M]    =3D { 0x434, 0x534, 5, },
> +       [TMPV770X_RESET_PIETHER_50M]    =3D { 0x434, 0x534, 6, },
> +       [TMPV770X_RESET_PIETHER_125M]   =3D { 0x434, 0x534, 7, },
> +       [TMPV770X_RESET_HOX]            =3D { 0x44C, 0x54C, 0, },
> +       [TMPV770X_RESET_PCIE_MSTR]      =3D { 0x438, 0x538, 0, },
> +       [TMPV770X_RESET_PCIE_AUX]       =3D { 0x438, 0x538, 1, },
> +       [TMPV770X_RESET_PIINTC]         =3D { 0x408, 0x508, 0, },
> +       [TMPV770X_RESET_PIETHER_BUS]    =3D { 0x434, 0x534, 0, },
> +       [TMPV770X_RESET_PISPI0]         =3D { 0x428, 0x528, 0, },
> +       [TMPV770X_RESET_PISPI1]         =3D { 0x428, 0x528, 1, },
> +       [TMPV770X_RESET_PISPI2]         =3D { 0x428, 0x528, 2, },
> +       [TMPV770X_RESET_PISPI3]         =3D { 0x428, 0x528, 3, },
> +       [TMPV770X_RESET_PISPI4]         =3D { 0x428, 0x528, 4, },
> +       [TMPV770X_RESET_PISPI5]         =3D { 0x428, 0x528, 5, },
> +       [TMPV770X_RESET_PISPI6]         =3D { 0x428, 0x528, 6, },
> +       [TMPV770X_RESET_PIUART0]        =3D { 0x42C, 0x52C, 0, },
> +       [TMPV770X_RESET_PIUART1]        =3D { 0x42C, 0x52C, 1, },
> +       [TMPV770X_RESET_PIUART2]        =3D { 0x42C, 0x52C, 2, },
> +       [TMPV770X_RESET_PIUART3]        =3D { 0x42C, 0x52C, 3, },
> +       [TMPV770X_RESET_PII2C0]         =3D { 0x430, 0x530, 0, },
> +       [TMPV770X_RESET_PII2C1]         =3D { 0x430, 0x530, 1, },
> +       [TMPV770X_RESET_PII2C2]         =3D { 0x430, 0x530, 2, },
> +       [TMPV770X_RESET_PII2C3]         =3D { 0x430, 0x530, 3, },
> +       [TMPV770X_RESET_PII2C4]         =3D { 0x430, 0x530, 4, },
> +       [TMPV770X_RESET_PII2C5]         =3D { 0x430, 0x530, 5, },
> +       [TMPV770X_RESET_PII2C6]         =3D { 0x430, 0x530, 6, },
> +       [TMPV770X_RESET_PII2C7]         =3D { 0x430, 0x530, 7, },
> +       [TMPV770X_RESET_PII2C8]         =3D { 0x430, 0x530, 8, },
> +       [TMPV770X_RESET_PIPCMIF]        =3D { 0x464, 0x564, 0, },
> +       [TMPV770X_RESET_PICKMON]        =3D { 0x410, 0x510, 8, },
> +       [TMPV770X_RESET_SBUSCLK]        =3D { 0x414, 0x514, 0, },
> +};
> +
> +static void __init tmpv770x_clkc_setup_clks(struct device_node *np)
> +{
> +       struct visconti_clk_provider *ctx;
> +       struct regmap *regmap;
> +       int ret, i;
> +
> +       regmap =3D device_node_to_regmap(np);

Is it inside a syscon?

> +       if (IS_ERR(regmap))
> +               return;
> +
> +       ctx =3D visconti_init_clk(np, regmap, TMPV770X_NR_CLK);
> +       if (IS_ERR(ctx))
> +               return;
> +
> +       ret =3D visconti_register_reset_controller(np, regmap, clk_reset_=
data,
> +                                                TMPV770X_NR_RESET,
> +                                                &visconti_reset_ops,
> +                                                &tmpv770x_rst_lock);
> +       if (ret) {
> +               pr_err("Failed to register reset controller: %d\n", ret);
> +               return;
> +       }
> +
> +       for (i =3D 0; i < (ARRAY_SIZE(fixed_clk_tables)); i++)
> +               ctx->clk_data.clks[fixed_clk_tables[i].id] =3D
> +                       clk_register_fixed_factor(NULL,
> +                                               fixed_clk_tables[i].name,
> +                                               fixed_clk_tables[i].paren=
t,
> +                                               fixed_clk_tables[i].flag,
> +                                               fixed_clk_tables[i].mult,
> +                                               fixed_clk_tables[i].div);
> +
> +       ret =3D visconti_clk_register_gates(ctx, clk_gate_tables,
> +                                   ARRAY_SIZE(clk_gate_tables), clk_rese=
t_data,
> +                                   &tmpv770x_clk_lock);
> +       if (ret) {
> +               pr_err("Failed to register main clock gate: %d\n", ret);
> +               return;
> +       }
> +
> +       ret =3D visconti_clk_register_gates(ctx, pietherpll_clk_gate_tabl=
es,
> +                                   ARRAY_SIZE(pietherpll_clk_gate_tables=
),
> +                                   clk_reset_data, &tmpv770x_clk_lock);
> +       if (ret) {
> +               pr_err("Failed to register pietherpll clock gate: %d\n", =
ret);
> +               return;
> +       }
> +
> +       of_clk_add_provider(np, of_clk_src_onecell_get, &ctx->clk_data);
> +}
> +
> +CLK_OF_DECLARE_DRIVER(tmpv770x_clkc, "toshiba,tmpv7708-pismu", tmpv770x_=
clkc_setup_clks);

Any chance this can be a platform driver?

> diff --git a/drivers/clk/visconti/clkc.c b/drivers/clk/visconti/clkc.c
> new file mode 100644
> index 000000000000..32b6f6266154
> --- /dev/null
> +++ b/drivers/clk/visconti/clkc.c
> @@ -0,0 +1,220 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Toshiba Visconti clock controller
> + *
> + * Copyright (c) 2021 TOSHIBA CORPORATION
> + * Copyright (c) 2021 Toshiba Electronic Devices & Storage Corporation
> + *
> + * Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> + */
> +#include <linux/clk-provider.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +#include <linux/string.h>
> +
> +#include "clkc.h"
> +
> +static inline struct visconti_clk_gate *to_visconti_clk_gate(struct clk_=
hw *hw)
> +{
> +       return container_of(hw, struct visconti_clk_gate, hw);
> +}
> +
> +static int visconti_gate_clk_is_enabled(struct clk_hw *hw)
> +{
> +       struct visconti_clk_gate *gate =3D to_visconti_clk_gate(hw);
> +       u32 clk =3D BIT(gate->ck_idx);
> +       u32 val;
> +
> +       regmap_read(gate->regmap, gate->ckon_offset, &val);
> +       return (val & clk) ? 1 : 0;
> +}
> +
> +static void visconti_gate_clk_disable(struct clk_hw *hw)
> +{
> +       struct visconti_clk_gate *gate =3D to_visconti_clk_gate(hw);
> +       u32 clk =3D BIT(gate->ck_idx);
> +       u32 rst =3D BIT(gate->rs_idx);
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(gate->lock, flags);
> +
> +       if (visconti_gate_clk_is_enabled(hw)) {

So we never disable the clk?

> +               spin_unlock_irqrestore(gate->lock, flags);
> +               return;
> +       }
> +
> +       /* Reset release */
> +       regmap_update_bits(gate->regmap, gate->rson_offset, rst, 1);
> +
> +       udelay(100);
> +
> +       /* Disable clock */
> +       regmap_update_bits(gate->regmap, gate->ckoff_offset, clk, 1);
> +       spin_unlock_irqrestore(gate->lock, flags);
> +}
> +
> +static int visconti_gate_clk_enable(struct clk_hw *hw)
> +{
> +       struct visconti_clk_gate *gate =3D to_visconti_clk_gate(hw);
> +       u32 clk =3D BIT(gate->ck_idx);
> +       u32 rst =3D BIT(gate->rs_idx);
> +       unsigned long flags;
> +       u32 val;
> +
> +       spin_lock_irqsave(gate->lock, flags);
> +
> +       if (visconti_gate_clk_is_enabled(hw)) {

The core framework should only call down to here if the clk is actually
disabled. This check can be removed.

> +               spin_unlock_irqrestore(gate->lock, flags);
> +               return 0;
> +       }
> +
> +       regmap_update_bits(gate->regmap, gate->ckon_offset, clk, 1);
> +       /* Need read back */

Why? Please indicate why instead of just saying what the code is doing.

> +       regmap_read(gate->regmap, gate->ckon_offset, &val);
> +
> +       udelay(100);
> +       /* Reset release */
> +       regmap_update_bits(gate->regmap, gate->rsoff_offset, rst, 1);
> +       /* Need read back */
> +       regmap_read(gate->regmap, gate->ckoff_offset, &val);
> +       spin_unlock_irqrestore(gate->lock, flags);
> +
> +       return 0;
> +}
> +
> +static const struct clk_ops visconti_clk_gate_ops =3D {
> +       .enable =3D visconti_gate_clk_enable,
> +       .disable =3D visconti_gate_clk_disable,
> +       .is_enabled =3D visconti_gate_clk_is_enabled,
> +};
> +
> +static struct clk_hw *visconti_clk_register_gate(struct device *dev,
> +                                                const char *name,
> +                                                const char *parent_name,
> +                                                struct regmap *regmap,
> +                                                const struct visconti_cl=
k_gate_table *clks,
> +                                                u32    rson_offset,
> +                                                u32    rsoff_offset,
> +                                                u8     rs_idx,
> +                                                spinlock_t *lock)
> +{
> +       struct visconti_clk_gate *gate;
> +       struct clk_init_data init;
> +       struct clk_hw *hw;
> +       int ret;
> +
> +       gate =3D kzalloc(sizeof(*gate), GFP_KERNEL);
> +       if (!gate)
> +               return ERR_PTR(-ENOMEM);
> +
> +       init.name =3D name;
> +       init.ops =3D &visconti_clk_gate_ops;
> +       init.flags =3D clks->flags;
> +       init.parent_names =3D parent_name ? &parent_name : NULL;
> +       init.num_parents =3D parent_name ? 1 : 0;

Do some clks have parents and other clks don't? Or do they always have
parents? Preferably it's one or the other. And if there are parents,
please use clk_parent_data instead of parent_names.

> +
> +       gate->regmap =3D regmap;
> +       gate->ckon_offset =3D clks->ckon_offset;
> +       gate->ckoff_offset =3D clks->ckoff_offset;
> +       gate->ck_idx =3D clks->ck_idx;
> +       gate->rson_offset =3D rson_offset;
> +       gate->rsoff_offset =3D rsoff_offset;
> +       gate->rs_idx =3D rs_idx;
> +       gate->lock =3D lock;
> +       gate->hw.init =3D &init;
> +
> +       hw =3D &gate->hw;
> +       ret =3D clk_hw_register(dev, hw);

Is the dev non-NULL? If yes then can devm be used?

> +       if (ret) {
> +               kfree(gate);
> +               hw =3D ERR_PTR(ret);
> +       }
> +
> +       return hw;
> +}
> +
> +int visconti_clk_register_gates(struct visconti_clk_provider *data,
> +                                const struct visconti_clk_gate_table *cl=
ks,
> +                                int num_gate, const struct visconti_rese=
t_data *reset,
> +                                spinlock_t *lock)
> +{
> +       u32 rson_offset, rsoff_offset;
> +       struct clk_hw *hw_clk;
> +       u8 rs_idx;
> +       int i;
> +
> +       for (i =3D 0; i < num_gate; i++) {
> +               struct clk *clk;
> +               char *div_name;
> +
> +               div_name =3D kasprintf(GFP_KERNEL, "%s_div", clks[i].name=
);
> +               if (!div_name)
> +                       return -ENOMEM;
> +
> +               if (clks[i].rs_id >=3D 0) {
> +                       rson_offset =3D reset[clks[i].rs_id].rson_offset;
> +                       rsoff_offset =3D reset[clks[i].rs_id].rsoff_offse=
t;
> +                       rs_idx =3D reset[clks[i].rs_id].rs_idx;
> +               } else {
> +                       rson_offset =3D rsoff_offset =3D rs_idx =3D -1;
> +               }
> +
> +               clk =3D clk_register_fixed_factor(NULL, div_name, clks[i]=
.parent,
> +                                               0, 1, clks[i].div);
> +               if (IS_ERR(clk))
> +                       return PTR_ERR(clk);
> +
> +               hw_clk =3D visconti_clk_register_gate(NULL,

Oh it's always NULL? Sad

> +                                               clks[i].name,
> +                                               div_name,
> +                                               data->regmap,
> +                                               &clks[i],
> +                                               rson_offset,
> +                                               rsoff_offset,
> +                                               rs_idx,
> +                                               lock);
> +               kfree(div_name);
> +               if (IS_ERR(hw_clk)) {
> +                       pr_err("%s: failed to register clock %s\n",
> +                              __func__, clks[i].name);
> +                       return PTR_ERR(hw_clk);
> +               }
> +
> +               data->clk_data.clks[clks[i].id] =3D hw_clk->clk;
> +       }
> +
> +       return 0;
> +}
> +
> +struct visconti_clk_provider *visconti_init_clk(struct device_node *np,
> +                                               struct regmap *regmap,
> +                                               unsigned long nr_clks)
> +{
> +       struct visconti_clk_provider *ctx;
> +       struct clk **clk_table;
> +       int i;
> +
> +       ctx =3D kzalloc(sizeof(struct visconti_clk_provider), GFP_KERNEL);

sizeof(*ctx)?

> +       if (!ctx)
> +               return ERR_PTR(-ENOMEM);
> +
> +       clk_table =3D kcalloc(nr_clks, sizeof(struct clk *), GFP_KERNEL);

sizeof(*clk_table)?

> +       if (!clk_table)
> +               goto err;
> +
> +       for (i =3D 0; i < nr_clks; ++i)
> +               clk_table[i] =3D ERR_PTR(-ENOENT);
> +       ctx->node =3D np;
> +       ctx->regmap =3D regmap;
> +       ctx->clk_data.clks =3D clk_table;
> +       ctx->clk_data.clk_num =3D nr_clks;
> +
> +       return ctx;
> +err:
> +       kfree(ctx);
> +       return ERR_PTR(-ENOMEM);
> +}
> diff --git a/drivers/clk/visconti/clkc.h b/drivers/clk/visconti/clkc.h
> new file mode 100644
> index 000000000000..4df8788d635a
> --- /dev/null
> +++ b/drivers/clk/visconti/clkc.h
> @@ -0,0 +1,75 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Toshiba Visconti clock controller
> + *
> + * Copyright (c) 2021 TOSHIBA CORPORATION
> + * Copyright (c) 2021 Toshiba Electronic Devices & Storage Corporation
> + *
> + * Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> + */
> +
> +#ifndef _VISCONTI_CLKC_H_
> +#define _VISCONTI_CLKC_H_
> +
> +#include <linux/mfd/syscon.h>
> +#include <linux/clk-provider.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/delay.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +#include <linux/string.h>
> +#include <linux/io.h>
> +#include <linux/spinlock.h>
> +
> +#include "reset.h"
> +
> +struct visconti_clk_provider {
> +       struct device_node      *node;
> +       struct regmap           *regmap;
> +       struct clk_onecell_data clk_data;
> +};
> +
> +struct visconti_clk_gate_table {
> +       unsigned int    id;
> +       const char      *name;
> +       const char      *parent;
> +       u8              flags;
> +       u32             ckon_offset;
> +       u32             ckoff_offset;
> +       u8              ck_idx;
> +       unsigned int    div;
> +       u8              rs_id;
> +};
> +
> +struct visconti_fixed_clk {
> +       unsigned int    id;
> +       const char      *name;
> +       const char      *parent;
> +       unsigned long   flag;
> +       unsigned int    mult;
> +       unsigned int    div;
> +};
> +
> +struct visconti_clk_gate {
> +       struct clk_hw   hw;
> +       struct regmap   *regmap;
> +       u32             ckon_offset;
> +       u32             ckoff_offset;
> +       u8              ck_idx;
> +       u8              flags;
> +       u32             rson_offset;
> +       u32             rsoff_offset;
> +       u8              rs_idx;
> +       spinlock_t      *lock;
> +};
> +
> +struct visconti_clk_provider *visconti_init_clk(struct device_node *np,
> +                                               struct regmap *regmap,
> +                                               unsigned long nr_clks);
> +int visconti_clk_register_gates(struct visconti_clk_provider *data,
> +                                const struct visconti_clk_gate_table *cl=
ks,
> +                                int num_gate,
> +                                const struct visconti_reset_data *reset,
> +                                spinlock_t *lock);
> +#endif /* _VISCONTI_CLKC_H_ */
> diff --git a/drivers/clk/visconti/pll-tmpv770x.c b/drivers/clk/visconti/p=
ll-tmpv770x.c
> new file mode 100644
> index 000000000000..a0874cb6a67b
> --- /dev/null
> +++ b/drivers/clk/visconti/pll-tmpv770x.c
> @@ -0,0 +1,85 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Toshiba Visconti PLL controller
> + *
> + * Copyright (c) 2021 TOSHIBA CORPORATION
> + * Copyright (c) 2021 Toshiba Electronic Devices & Storage Corporation
> + *
> + * Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> + */
> +
> +#include <dt-bindings/clock/toshiba,tmpv770x.h>
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/of_address.h>
> +#include <linux/slab.h>
> +
> +#include "pll.h"
> +
> +static DEFINE_SPINLOCK(tmpv770x_pll_lock);
> +
> +static const struct visconti_pll_rate_table pipll0_rates[] __initconst =
=3D {
> +       VISCONTI_PLL_RATE(840000000, 0x1, 0x0, 0x1, 0x54, 0x000000, 0x2, =
0x1),
> +       VISCONTI_PLL_RATE(780000000, 0x1, 0x0, 0x1, 0x4E, 0x000000, 0x2, =
0x1),
> +       VISCONTI_PLL_RATE(600000000, 0x1, 0x0, 0x1, 0x3C, 0x000000, 0x2, =
0x1),
> +       { /* sentinel */ },
> +};
> +
> +static const struct visconti_pll_rate_table piddrcpll_rates[] __initcons=
t =3D {
> +       VISCONTI_PLL_RATE(780000000, 0x1, 0x0, 0x1, 0x4E, 0x000000, 0x2, =
0x1),
> +       VISCONTI_PLL_RATE(760000000, 0x1, 0x0, 0x1, 0x4C, 0x000000, 0x2, =
0x1),
> +       { /* sentinel */ },
> +};
> +
> +static const struct visconti_pll_rate_table pivoifpll_rates[] __initcons=
t =3D {
> +       VISCONTI_PLL_RATE(165000000, 0x1, 0x0, 0x1, 0x42, 0x000000, 0x4, =
0x2),
> +       VISCONTI_PLL_RATE(148500000, 0x1, 0x1, 0x1, 0x3B, 0x666666, 0x4, =
0x2),
> +       VISCONTI_PLL_RATE(96000000, 0x1, 0x0, 0x1, 0x30, 0x000000, 0x5, 0=
x2),
> +       VISCONTI_PLL_RATE(74250000, 0x1, 0x1, 0x1, 0x3B, 0x666666, 0x4, 0=
x4),
> +       VISCONTI_PLL_RATE(54000000, 0x1, 0x0, 0x1, 0x36, 0x000000, 0x5, 0=
x4),
> +       VISCONTI_PLL_RATE(48000000, 0x1, 0x0, 0x1, 0x30, 0x000000, 0x5, 0=
x4),
> +       VISCONTI_PLL_RATE(35750000, 0x1, 0x1, 0x1, 0x32, 0x0CCCCC, 0x7, 0=
x4),
> +       { /* sentinel */ },
> +};
> +
> +static const struct visconti_pll_rate_table piimgerpll_rates[] __initcon=
st =3D {
> +       VISCONTI_PLL_RATE(165000000, 0x1, 0x0, 0x1, 0x42, 0x000000, 0x4, =
0x2),
> +       VISCONTI_PLL_RATE(96000000, 0x1, 0x0, 0x1, 0x30, 0x000000, 0x5, 0=
x2),
> +       VISCONTI_PLL_RATE(54000000, 0x1, 0x0, 0x1, 0x36, 0x000000, 0x5, 0=
x4),
> +       VISCONTI_PLL_RATE(48000000, 0x1, 0x0, 0x1, 0x30, 0x000000, 0x5, 0=
x4),
> +       { /* sentinel */ },
> +};
> +
> +static const struct visconti_pll_info pll_info[] __initconst =3D {
> +       { TMPV770X_PLL_PIPLL0, "pipll0", "osc2-clk", 0, 0x0, pipll0_rates=
 },
> +       { TMPV770X_PLL_PIDDRCPLL, "piddrcpll", "osc2-clk", 0, 0x500, pidd=
rcpll_rates },
> +       { TMPV770X_PLL_PIVOIFPLL, "pivoifpll", "osc2-clk", 0, 0x600, pivo=
ifpll_rates },
> +       { TMPV770X_PLL_PIIMGERPLL, "piimgerpll", "osc2-clk", 0, 0x700, pi=
imgerpll_rates },
> +};
> +
> +static void __init tmpv770x_setup_plls(struct device_node *np)
> +{
> +       struct visconti_pll_provider *ctx;
> +       void __iomem *reg_base;
> +
> +       reg_base =3D of_iomap(np, 0);
> +       if (!reg_base)
> +               return;
> +
> +       ctx =3D visconti_init_pll(np, reg_base, TMPV770X_NR_PLL);
> +       if (IS_ERR(ctx)) {
> +               iounmap(reg_base);
> +               return;
> +       }
> +
> +       ctx->clk_data.clks[TMPV770X_PLL_PIPLL1] =3D
> +               clk_register_fixed_rate(NULL, "pipll1", NULL, 0, 60000000=
0);
> +       ctx->clk_data.clks[TMPV770X_PLL_PIDNNPLL] =3D
> +               clk_register_fixed_rate(NULL, "pidnnpll", NULL, 0, 500000=
000);
> +       ctx->clk_data.clks[TMPV770X_PLL_PIETHERPLL] =3D
> +               clk_register_fixed_rate(NULL, "pietherpll", NULL, 0, 5000=
00000);
> +
> +       visconti_register_plls(ctx, pll_info, ARRAY_SIZE(pll_info), &tmpv=
770x_pll_lock);
> +}
> +
> +CLK_OF_DECLARE_DRIVER(tmpv770x_plls, "toshiba,tmpv7708-pipllct", tmpv770=
x_setup_plls);

DECLARE_DRIVER is for when more than one device needs to probe the node
in DT. Is that happening here? If so, please add a comment indicating
what the other driver is.

> diff --git a/drivers/clk/visconti/pll.c b/drivers/clk/visconti/pll.c
> new file mode 100644
> index 000000000000..7baa9512fad9
> --- /dev/null
> +++ b/drivers/clk/visconti/pll.c
> @@ -0,0 +1,369 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Toshiba Visconti PLL driver
> + *
> + * Copyright (c) 2021 TOSHIBA CORPORATION
> + * Copyright (c) 2021 Toshiba Electronic Devices & Storage Corporation
> + *
> + * Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/delay.h>
> +#include <linux/slab.h>
> +#include <linux/io.h>
> +
> +#include "pll.h"
> +
> +struct visconti_pll {
> +       struct clk_hw   hw;
> +       void __iomem    *pll_base;
> +       spinlock_t      *lock;
> +       int rate_count;

size_t? And then place next to rate_table so we know they're related
please.

> +       unsigned long flags;
> +       const struct visconti_pll_rate_table *rate_table;
> +       struct visconti_pll_provider *ctx;
> +};
> +
> +#define PLL_CONF_REG           0x0000
> +#define PLL_CTRL_REG           0x0004
> +#define PLL_FRACMODE_REG       0x0010
> +#define PLL_INTIN_REG          0x0014
> +#define PLL_FRACIN_REG         0x0018
> +#define PLL_REFDIV_REG         0x001C
> +#define PLL_POSTDIV_REG                0x0020
> +
> +#define PLL_CONFIG_SEL         BIT(0)
> +#define PLL_PLLEN              BIT(4)
> +#define PLL_BYPASS             BIT(16)
> +#define PLL_INTIN_MASK         GENMASK(11, 0)
> +#define PLL_FRACIN_MASK                GENMASK(23, 0)
> +#define PLL_REFDIV_MASK                GENMASK(5, 0)
> +#define PLL_POSTDIV_MASK       GENMASK(2, 0)
> +
> +static inline struct visconti_pll *to_visconti_pll(struct clk_hw *hw)
> +{
> +       return container_of(hw, struct visconti_pll, hw);
> +}
> +
> +static void visconti_pll_get_params(struct visconti_pll *pll,
> +                                   struct visconti_pll_rate_table *rate_=
table)
> +{
> +       u32 postdiv, val;
> +
> +       val =3D readl(pll->pll_base + PLL_FRACMODE_REG);
> +       rate_table->dacen =3D (val >> 4) & 0x1;

What is 0x1? Some bitfield? Can it be a #define at least? Same for 4.
Better yet, use GENMASK and FIELD_PREP() and FIELD_GET() macros.

> +       rate_table->dsmen =3D val & 0x1;
> +       rate_table->fracin =3D readl(pll->pll_base + PLL_FRACIN_REG) & PL=
L_FRACIN_MASK;
> +       rate_table->intin =3D readl(pll->pll_base + PLL_INTIN_REG) & PLL_=
INTIN_MASK;
> +       rate_table->refdiv =3D readl(pll->pll_base + PLL_REFDIV_REG) & PL=
L_REFDIV_MASK;
> +
> +       postdiv =3D readl(pll->pll_base + PLL_POSTDIV_REG);
> +       rate_table->postdiv1 =3D postdiv & PLL_POSTDIV_MASK;
> +       rate_table->postdiv2 =3D (postdiv >> 4) & PLL_POSTDIV_MASK;
> +}
> +
> +static const struct visconti_pll_rate_table *visconti_get_pll_settings(s=
truct visconti_pll *pll,
> +                                                                      un=
signed long rate)
> +{
> +       const struct visconti_pll_rate_table *rate_table =3D pll->rate_ta=
ble;
> +       int i;
> +
> +       for (i =3D 0; i < pll->rate_count; i++) {
> +               if (rate =3D=3D rate_table[i].rate)
> +                       return &rate_table[i];
> +       }

Drop braces please.

> +
> +       return NULL;
> +}
> +
> +static unsigned long visconti_get_pll_rate_from_data(struct visconti_pll=
 *pll,
> +                                                    struct visconti_pll_=
rate_table *rate)

const pointers?

> +{
> +       const struct visconti_pll_rate_table *rate_table =3D pll->rate_ta=
ble;
> +       int i;
> +
> +       for (i =3D 0; i < pll->rate_count; i++) {
> +               if (rate_table[i].dacen =3D=3D rate->dacen &&
> +                       rate_table[i].dsmen =3D=3D rate->dsmen &&
> +                       rate_table[i].fracin =3D=3D rate->fracin &&
> +                       rate_table[i].intin =3D=3D rate->intin &&
> +                       rate_table[i].refdiv =3D=3D rate->refdiv &&
> +                       rate_table[i].postdiv1 =3D=3D rate->postdiv1 &&
> +                       rate_table[i].postdiv2 =3D=3D rate->postdiv2)

Is it not the same table? Can we just compare the two pointers instead
of each member?

> +                       return rate_table[i].rate;
> +       }
> +
> +       /* set default */
> +       return rate_table[0].rate;
> +}
> +
> +static long visconti_pll_round_rate(struct clk_hw *hw,
> +                           unsigned long rate, unsigned long *prate)
> +{
> +       struct visconti_pll *pll =3D to_visconti_pll(hw);
> +       const struct visconti_pll_rate_table *rate_table =3D pll->rate_ta=
ble;
> +       int i;
> +
> +       /* Assumming rate_table is in descending order */
> +       for (i =3D 0; i < pll->rate_count; i++) {
> +               if (rate >=3D rate_table[i].rate)
> +                       return rate_table[i].rate;
> +       }

Drop braces please.

> +
> +       /* return minimum supported value */
> +       return rate_table[i - 1].rate;
> +}
> +
> +static unsigned long visconti_pll_recalc_rate(struct clk_hw *hw,
> +                                             unsigned long parent_rate)
> +{
> +       struct visconti_pll *pll =3D to_visconti_pll(hw);
> +       struct visconti_pll_rate_table rate_table;
> +
> +       memset(&rate_table, 0, sizeof(rate_table));
> +       visconti_pll_get_params(pll, &rate_table);
> +
> +       return visconti_get_pll_rate_from_data(pll, &rate_table);

Oh. Can we do math instead?

> +}
> +
> +static int visconti_pll_set_params(struct visconti_pll *pll,
> +                               const struct visconti_pll_rate_table *rat=
e_table)
> +{
> +       /* update pll values */

This comment is worthless. Please remove.

> +       writel(((rate_table->dacen << 4) | rate_table->dsmen),

One too many parenthesis here. Please clean it up.

> +                       pll->pll_base + PLL_FRACMODE_REG);
> +       writel(((rate_table->postdiv2 << 4) | rate_table->postdiv1),

Same.

> +                       pll->pll_base + PLL_POSTDIV_REG);
> +       writel(rate_table->intin, pll->pll_base + PLL_INTIN_REG);
> +       writel(rate_table->fracin, pll->pll_base + PLL_FRACIN_REG);
> +       writel(rate_table->refdiv, pll->pll_base + PLL_REFDIV_REG);
> +
> +       return 0;
> +}
> +
> +static int visconti_pll_set_rate(struct clk_hw *hw, unsigned long rate,
> +                           unsigned long parent_rate)
> +{
> +       struct visconti_pll *pll =3D to_visconti_pll(hw);
> +       const struct visconti_pll_rate_table *rate_table;
> +
> +       /* Get required rate settings from table */

This comment is worthless, please remove.

> +       rate_table =3D visconti_get_pll_settings(pll, rate);
> +       if (!rate_table) {
> +               pr_err("Invalid rate : %lu for pll clk %s\n",

Please don't print anything during set_rate. It can be quite noisy if
something like a cpufreq driver keeps calling this with the incorrect
frequency.

> +                       parent_rate, __clk_get_name(hw->clk));
> +               return -EINVAL;
> +       }
> +
> +       return visconti_pll_set_params(pll, rate_table);
> +}
> +
> +static int visconti_pll_is_enabled(struct clk_hw *hw)
> +{
> +       struct visconti_pll *pll =3D to_visconti_pll(hw);
> +       unsigned long flags;
> +       u32 reg;
> +
> +       spin_lock_irqsave(pll->lock, flags);
> +       reg =3D readl(pll->pll_base + PLL_CTRL_REG);
> +       spin_unlock_irqrestore(pll->lock, flags);

Don't think we need a spinlock to read a register. After this unlocks it
can be disabled anyway, so what's the point to locking here?

> +
> +       return (reg & PLL_PLLEN);
> +}
> +
> +static int visconti_pll_enable(struct clk_hw *hw)
> +{
> +       struct visconti_pll *pll =3D to_visconti_pll(hw);
> +       const struct visconti_pll_rate_table *rate_table =3D pll->rate_ta=
ble;
> +       unsigned long flags;
> +       u32 reg;
> +
> +       if (visconti_pll_is_enabled(hw))
> +               return 0;

Drop.

> +
> +       spin_lock_irqsave(pll->lock, flags);
> +
> +       /* Change to access via register */
> +       writel(PLL_CONFIG_SEL, pll->pll_base + PLL_CONF_REG);
> +
> +       /* Change to BYPASS mode */
> +       reg =3D readl(pll->pll_base + PLL_CTRL_REG);
> +       reg |=3D PLL_BYPASS;
> +       writel(reg, pll->pll_base + PLL_CTRL_REG);
> +
> +       /* Set DIV register .....*/
> +       visconti_pll_set_params(pll, &rate_table[0]);
> +
> +       /* Disable  PLL register */
> +       reg =3D readl(pll->pll_base + PLL_CTRL_REG);
> +       reg &=3D ~PLL_PLLEN;
> +       writel(reg, pll->pll_base + PLL_CTRL_REG);
> +
> +       /* Wait 1us */
> +       udelay(1);
> +
> +       /* Enable PLL register */
> +       reg =3D readl(pll->pll_base + PLL_CTRL_REG);
> +       reg |=3D PLL_PLLEN;
> +       writel(reg, pll->pll_base + PLL_CTRL_REG);
> +
> +       /* Wait 40us */
> +       udelay(40);
> +
> +       /* Change to PLL mode */

Every comment in here is saying what the code is doing. Please remove
them.

> +       reg =3D readl(pll->pll_base + PLL_CTRL_REG);
> +       reg &=3D ~PLL_BYPASS;
> +       writel(reg, pll->pll_base + PLL_CTRL_REG);
> +
> +       spin_unlock_irqrestore(pll->lock, flags);
> +
> +       return 0;
> +}
> +
> +static void visconti_pll_disable(struct clk_hw *hw)
> +{
> +       struct visconti_pll *pll =3D to_visconti_pll(hw);
> +       unsigned long flags;
> +       u32 reg;
> +
> +       if (!visconti_pll_is_enabled(hw))
> +               return;
> +
> +       spin_lock_irqsave(pll->lock, flags);
> +
> +       /* Change to access via register */

This comment is almost useful, except I don't know why we need to change
access, which is the important part.

> +       writel(PLL_CONFIG_SEL, pll->pll_base + PLL_CONF_REG);
> +
> +       /* Change to BYPASS mode */
> +       reg =3D readl(pll->pll_base + PLL_CTRL_REG);
> +       reg |=3D PLL_BYPASS;
> +       writel(reg, pll->pll_base + PLL_CTRL_REG);
> +
> +       /* PLL disable */
> +       reg =3D readl(pll->pll_base + PLL_CTRL_REG);
> +       reg &=3D ~PLL_PLLEN;
> +       writel(reg, pll->pll_base + PLL_CTRL_REG);
> +
> +       spin_unlock_irqrestore(pll->lock, flags);
> +}
> +
> +static const struct clk_ops visconti_pll_ops =3D {
> +       .enable =3D visconti_pll_enable,
> +       .disable =3D visconti_pll_disable,
> +       .is_enabled =3D visconti_pll_is_enabled,
> +       .round_rate =3D visconti_pll_round_rate,
> +       .recalc_rate =3D visconti_pll_recalc_rate,
> +       .set_rate =3D visconti_pll_set_rate,
> +};
> +
> +static struct clk *visconti_register_pll(struct visconti_pll_provider *c=
tx,
> +                                        const char *name,
> +                                        const char *parent_name,
> +                                        int offset,
> +                                        const struct visconti_pll_rate_t=
able *rate_table,
> +                                        u8 clk_pll_flags,

Are the flags used?

> +                                        spinlock_t *lock)
> +{
> +       struct clk_init_data init;
> +       struct visconti_pll *pll;
> +       struct clk *pll_clk;
> +       int len;
> +
> +       pll =3D kzalloc(sizeof(*pll), GFP_KERNEL);
> +       if (!pll)
> +               return ERR_PTR(-ENOMEM);
> +
> +       /* Create the actual pll */

Worthless comment.

> +       init.name =3D name;
> +       init.flags =3D CLK_IGNORE_UNUSED;
> +       init.parent_names =3D &parent_name;
> +       init.num_parents =3D 1;
> +
> +       for (len =3D 0; rate_table[len].rate !=3D 0; )
> +               len++;
> +       pll->rate_count =3D len;
> +       pll->rate_table =3D kmemdup(rate_table,
> +                                 pll->rate_count * sizeof(struct viscont=
i_pll_rate_table),
> +                                 GFP_KERNEL);

Do we need to duplicate the table? Can't that be const?

> +       WARN(!pll->rate_table, "%s: could not allocate rate table for %s\=
n", __func__, name);
> +
> +       init.ops =3D &visconti_pll_ops;
> +       pll->hw.init =3D &init;
> +       pll->pll_base =3D ctx->reg_base + offset;
> +       pll->flags =3D clk_pll_flags;
> +       pll->lock =3D lock;
> +       pll->ctx =3D ctx;
> +
> +       pll_clk =3D clk_register(NULL, &pll->hw);

Please use clk_hw_register().

> +       if (IS_ERR(pll_clk)) {
> +               pr_err("failed to register pll clock %s : %ld\n", name, P=
TR_ERR(pll_clk));
> +               kfree(pll);
> +       }
> +
> +       return pll_clk;
> +}
> +
> +static void visconti_pll_add_lookup(struct visconti_pll_provider *ctx, s=
truct clk *clk,
> +                                   unsigned int id)
> +{
> +       if (ctx->clk_data.clks && id)
> +               ctx->clk_data.clks[id] =3D clk;
> +}
> +
> +void __init visconti_register_plls(struct visconti_pll_provider *ctx,
> +                                  const struct visconti_pll_info *list,
> +                                  unsigned int nr_plls,
> +                                  spinlock_t *lock)
> +{
> +       int idx;
> +
> +       for (idx =3D 0; idx < nr_plls; idx++, list++) {
> +               struct clk *clk;
> +
> +               clk =3D visconti_register_pll(ctx,
> +                                           list->name,
> +                                           list->parent,
> +                                           list->base_reg,
> +                                           list->rate_table,
> +                                           list->flags,
> +                                           lock);
> +               if (IS_ERR(clk)) {
> +                       pr_err("failed to register clock %s\n", list->nam=
e);
> +                       continue;
> +               }
> +
> +               visconti_pll_add_lookup(ctx, clk, list->id);
> +       }
> +}
> +
> +struct visconti_pll_provider * __init visconti_init_pll(struct device_no=
de *np,
> +                                                       void __iomem *bas=
e,
> +                                                       unsigned long nr_=
plls)
> +{
> +       struct visconti_pll_provider *ctx;
> +       struct clk **clk_table;
> +       int i;
> +
> +       ctx =3D kzalloc(sizeof(struct visconti_pll_provider), GFP_KERNEL);
> +       if (!ctx)
> +               return ERR_PTR(-ENOMEM);
> +
> +       clk_table =3D kcalloc(nr_plls, sizeof(struct clk *), GFP_KERNEL);
> +       if (!clk_table)
> +               goto err;
> +
> +       for (i =3D 0; i < nr_plls; ++i)
> +               clk_table[i] =3D ERR_PTR(-ENOENT);
> +
> +       ctx->node =3D np;
> +       ctx->reg_base =3D base;
> +       ctx->clk_data.clks =3D clk_table;
> +       ctx->clk_data.clk_num =3D nr_plls;
> +
> +       return ctx;
> +
> +err:
> +       kfree(ctx);
> +       return ERR_PTR(-ENOMEM);
> +}
> diff --git a/drivers/clk/visconti/pll.h b/drivers/clk/visconti/pll.h
> new file mode 100644
> index 000000000000..ce0ce1d8cd88
> --- /dev/null
> +++ b/drivers/clk/visconti/pll.h
> @@ -0,0 +1,63 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2021 TOSHIBA CORPORATION
> + * Copyright (c) 2021 Toshiba Electronic Devices & Storage Corporation
> + *
> + * Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> + */
> +
> +#ifndef _VISCONTI_PLL_H_
> +#define _VISCONTI_PLL_H_
> +
> +#include <linux/clk-provider.h>
> +#include <linux/regmap.h>
> +#include <linux/spinlock.h>
> +
> +struct visconti_pll_provider {
> +       void __iomem *reg_base;
> +       struct regmap *regmap;
> +       struct clk_onecell_data clk_data;
> +       struct device_node *node;
> +};
> +
> +#define VISCONTI_PLL_RATE(_rate, _dacen, _dsmen, \
> +       _refdiv, _intin, _fracin, _postdiv1, _postdiv2) \
> +{                              \
> +       .rate =3D _rate,          \
> +       .dacen =3D _dacen,        \
> +       .dsmen =3D _dsmen,        \
> +       .refdiv =3D _refdiv,      \
> +       .intin =3D _intin,        \
> +       .fracin =3D _fracin,      \
> +       .postdiv1 =3D _postdiv1,  \
> +       .postdiv2 =3D _postdiv2   \
> +}
> +
> +struct visconti_pll_rate_table {
> +       unsigned long rate;
> +       unsigned int dacen;
> +       unsigned int dsmen;
> +       unsigned int refdiv;
> +       unsigned long intin;
> +       unsigned long fracin;
> +       unsigned int postdiv1;
> +       unsigned int postdiv2;
> +};
> +
> +struct visconti_pll_info {
> +       unsigned int id;
> +       const char *name;
> +       const char *parent;
> +       u8 flags;
> +       unsigned long base_reg;
> +       const struct visconti_pll_rate_table *rate_table;
> +};
> +
> +struct visconti_pll_provider * __init visconti_init_pll(struct device_no=
de *np,
> +                                                       void __iomem *bas=
e,
> +                                                       unsigned long nr_=
plls);
> +void __init visconti_register_plls(struct visconti_pll_provider *ctx,

__init can be dropped from header files. It serves no purpose.

> +                                  const struct visconti_pll_info *list,
> +                                  unsigned int nr_plls, spinlock_t *lock=
);
> +
> +#endif /* _VISCONTI_PLL_H_ */
