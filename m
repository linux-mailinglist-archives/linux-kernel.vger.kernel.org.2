Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A60D1390EB0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 05:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbhEZDKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 23:10:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:46718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229750AbhEZDKp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 23:10:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8FCEA6128B;
        Wed, 26 May 2021 03:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621998554;
        bh=wBPtpL04qpK8gH7qVHwO7jhI8IygzE0yr7WFFNC43vQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=E3royAXjOPJ38N54cFneV51m2i4IlRsDZUlyjN5R6nml3ui3qywPLe7phxAQpCGcE
         KwB05Y8bnHo8/n7s/tC/Hl3rMKFHrg+pXD1iy4KKUcAWN7S/3NruQ9ElEiDeBmIMUe
         CqhVz7b53aEfxGi/3MZ54csT93+gvxb0OvlyQvV8EkAdlG3grJ3sWiDj7LijDKJjK7
         C3IBeST1wwtMhXWaxojh2G+48NH/NeRobOZ2Ozi6jJV8RYTv64Zq/GNALeNwNEdcnS
         IbIjnzbLDPYLqVHKwc09Pxc8tq7rS7KiVJWxsKKKfUrDQ7xQ6p/3ABoJ6ga5GHrXMF
         yvyTUDJWYOQKg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210524182745.22923-3-sven@svenpeter.dev>
References: <20210524182745.22923-1-sven@svenpeter.dev> <20210524182745.22923-3-sven@svenpeter.dev>
Subject: Re: [PATCH 2/3] clk: add support for gate clocks on Apple SoCs
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Sven Peter <sven@svenpeter.dev>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Arnd Bergmann <arnd@kernel.org>
To:     Sven Peter <sven@svenpeter.dev>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
Date:   Tue, 25 May 2021 20:09:13 -0700
Message-ID: <162199855335.4130789.17766958356597249549@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sven Peter (2021-05-24 11:27:44)
> Add a simple driver for gate clocks found on Apple SoCs. These don't
> have any frequency associated with them and are only used to enable
> access to MMIO regions of various peripherals.

Can we figure out what frequency they are clocking at?

>=20
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index e80918be8e9c..ac987a8cf318 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -245,6 +245,18 @@ config CLK_TWL6040
>           McPDM. McPDM module is using the external bit clock on the McPD=
M bus
>           as functional clock.
> =20
> +config COMMON_CLK_APPLE
> +       tristate "Clock driver for Apple platforms"
> +       depends on ARCH_APPLE && COMMON_CLK

The COMMON_CLK depend is redundant. Please remove.

> +       default ARCH_APPLE
> +       help
> +         Support for clock gates on Apple SoCs such as the M1.
> +
> +         These clock gates do not have a frequency associated with them =
and
> +         are only used to power on/off various peripherals. Generally, a=
 clock
> +         gate needs to be enabled before the respective MMIO region can =
be
> +         accessed.
> +
>  config COMMON_CLK_AXI_CLKGEN
>         tristate "AXI clkgen driver"
>         depends on HAS_IOMEM || COMPILE_TEST
> diff --git a/drivers/clk/clk-apple-gate.c b/drivers/clk/clk-apple-gate.c
> new file mode 100644
> index 000000000000..799e9269758f
> --- /dev/null
> +++ b/drivers/clk/clk-apple-gate.c
> @@ -0,0 +1,152 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Apple SoC clock/power gating driver
> + *
> + * Copyright The Asahi Linux Contributors
> + */
> +
> +#include <linux/clk.h>

Hopefully this can be droped.

> +#include <linux/clkdev.h>

And this one too. clkdev is not modern.

> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/clk-provider.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/platform_device.h>
> +#include <linux/module.h>
> +
> +#define CLOCK_TARGET_MODE_MASK 0x0f

APPLE_ prefix on all these?

> +#define CLOCK_TARGET_MODE(m) (((m)&0xf))
> +#define CLOCK_ACTUAL_MODE_MASK 0xf0
> +#define CLOCK_ACTUAL_MODE(m) (((m)&0xf) << 4)
> +
> +#define CLOCK_MODE_ENABLE 0xf
> +#define CLOCK_MODE_DISABLE 0
> +
> +#define CLOCK_ENDISABLE_TIMEOUT 100
> +
> +struct apple_clk_gate {
> +       struct clk_hw hw;
> +       void __iomem *reg;
> +};
> +
> +#define to_apple_clk_gate(_hw) container_of(_hw, struct apple_clk_gate, =
hw)
> +
> +static int apple_clk_gate_endisable(struct clk_hw *hw, int enable)
> +{
> +       struct apple_clk_gate *gate =3D to_apple_clk_gate(hw);
> +       u32 reg;
> +       u32 mode;
> +
> +       if (enable)
> +               mode =3D CLOCK_MODE_ENABLE;
> +       else
> +               mode =3D CLOCK_MODE_DISABLE;
> +
> +       reg =3D readl(gate->reg);
> +       reg &=3D ~CLOCK_TARGET_MODE_MASK;
> +       reg |=3D CLOCK_TARGET_MODE(mode);
> +       writel(reg, gate->reg);
> +
> +       return readl_poll_timeout_atomic(gate->reg, reg,
> +                                        (reg & CLOCK_ACTUAL_MODE_MASK) =
=3D=3D
> +                                                CLOCK_ACTUAL_MODE(mode),
> +                                        1, CLOCK_ENDISABLE_TIMEOUT);

Maybe this

          return readl_poll_timeout_atomic(gate->reg, reg,
		   (reg & CLOCK_ACTUAL_MODE_MASK) =3D=3D CLOCK_ACTUAL_MODE(mode),
		   1, CLOCK_ENDISABLE_TIMEOUT);

at the least please don't break the =3D=3D across two lines.

> +}
> +
> +static int apple_clk_gate_enable(struct clk_hw *hw)
> +{
> +       return apple_clk_gate_endisable(hw, 1);
> +}
> +
> +static void apple_clk_gate_disable(struct clk_hw *hw)
> +{
> +       apple_clk_gate_endisable(hw, 0);
> +}
> +
> +static int apple_clk_gate_is_enabled(struct clk_hw *hw)
> +{
> +       struct apple_clk_gate *gate =3D to_apple_clk_gate(hw);
> +       u32 reg;
> +
> +       reg =3D readl(gate->reg);
> +
> +       if ((reg & CLOCK_ACTUAL_MODE_MASK) =3D=3D CLOCK_ACTUAL_MODE(CLOCK=
_MODE_ENABLE))

Any chance we can use FIELD_GET() and friends? Please don't do bit
shifting stuff inside conditionals as it just makes life more
complicated than it needs to be.

> +               return 1;
> +       return 0;

How about just return <logic>?

> +}
> +
> +static const struct clk_ops apple_clk_gate_ops =3D {
> +       .enable =3D apple_clk_gate_enable,
> +       .disable =3D apple_clk_gate_disable,
> +       .is_enabled =3D apple_clk_gate_is_enabled,
> +};
> +
> +static int apple_gate_clk_probe(struct platform_device *pdev)
> +{
> +       struct device *dev =3D &pdev->dev;
> +       struct device_node *node =3D dev->of_node;
> +       const struct clk_parent_data parent_data[] =3D {
> +               { .index =3D 0 },
> +       };

Yay thanks for not doing it the old way!

> +       struct apple_clk_gate *data;
> +       struct clk_hw *hw;
> +       struct clk_init_data init;
> +       struct resource *res;
> +       int num_parents;
> +       int ret;
> +
> +       data =3D devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +       if (!data)
> +               return -ENOMEM;
> +
> +       res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       data->reg =3D devm_ioremap_resource(dev, res);
> +       if (IS_ERR(data->reg))
> +               return PTR_ERR(data->reg);
> +
> +       num_parents =3D of_clk_get_parent_count(node);

Oh no I spoke too soon.

> +       if (num_parents > 1) {
> +               dev_err(dev, "clock supports at most one parent\n");
> +               return -EINVAL;
> +       }
> +
> +       init.name =3D dev->of_node->name;
> +       init.ops =3D &apple_clk_gate_ops;
> +       init.flags =3D 0;
> +       init.parent_names =3D NULL;
> +       init.parent_data =3D parent_data;
> +       init.num_parents =3D num_parents;
> +
> +       data->hw.init =3D &init;
> +       hw =3D &data->hw;
> +
> +       ret =3D devm_clk_hw_register(dev, hw);
> +       if (ret)
> +               return ret;
> +
> +       return devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, hw);

It looks like a one clk per DT node binding which is not how we do it. I
see Rob has started that discussion on the binding so we can keep that
there.

> +}
> +
