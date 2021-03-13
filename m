Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6009C33A1C6
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 23:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233462AbhCMWyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 17:54:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:56674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231205AbhCMWyQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 17:54:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id ADF9164E87;
        Sat, 13 Mar 2021 22:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615676055;
        bh=drMYg0O/spcA145YsC2y40gm+EcWIarmoaXI8NzJ4A0=;
        h=In-Reply-To:References:Subject:From:To:Date:From;
        b=r4bc8AnGLFzQlg2wGI9djpUMk4T5MlaZKPglvCUq4OE9MKoCA0UIQJd5zJMoJ1Fmd
         7jo1yo+IBSfMVn15yJLiZeLavv6SGdWEDBbMdef2EHx/f64wupsR5piGCL/MMw4zfE
         mfNNLwTqj6pLHGiT1HBxerAEaylf7nD5FzjIZu5zYR7j2kjFvJoTlQmDSE3vvOQwf/
         85Tx76MyMVQRVRZNVdVBWeFtgwLLx193tIHXbjL1pm3AE039DrGJTG/6GlfZya8vQ3
         g0lycSWwHGCChiYHrfCfHU5W4fQo3KuMR4hEVFoFQwxdgOYf0d9/a/t1MwFxqIJ6z7
         eixaDC1laWoCA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210225194201.17001-5-noltari@gmail.com>
References: <20210225194201.17001-1-noltari@gmail.com> <20210225194201.17001-5-noltari@gmail.com>
Subject: Re: [PATCH 4/4] clk: bcm: Add BCM63268 timer clock and reset driver
From:   Stephen Boyd <sboyd@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Michael Turquette <mturquette@baylibre.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        devicetree@vger.kernel.org, jonas.gorski@gmail.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alvaro Fernandez Rojas <noltari@gmail.com>
Date:   Sat, 13 Mar 2021 14:54:14 -0800
Message-ID: <161567605436.1478170.6501285044585961586@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alvaro Fernandez Rojas (2021-02-25 11:42:01)
> diff --git a/drivers/clk/bcm/clk-bcm63268-timer.c b/drivers/clk/bcm/clk-b=
cm63268-timer.c
> new file mode 100644
> index 000000000000..5609c4ddb50c
> --- /dev/null
> +++ b/drivers/clk/bcm/clk-bcm63268-timer.c
> @@ -0,0 +1,232 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * BCM63268 Timer Clock and Reset Controller Driver
> + *
> + * Copyright (C) 2021 =C3=81lvaro Fern=C3=A1ndez Rojas <noltari@gmail.co=
m>
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/delay.h>
> +#include <linux/init.h>

Is this used?

> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/reset-controller.h>
> +
> +#include <dt-bindings/clock/bcm63268-clock.h>
> +
> +#define BCM63268_TIMER_RESET_SLEEP_MIN_US      10000
> +#define BCM63268_TIMER_RESET_SLEEP_MAX_US      20000
> +
> +struct bcm63268_tclkrst_hw {
> +       void __iomem *regs;
> +       spinlock_t lock;
> +
> +       struct reset_controller_dev rcdev;
> +       struct clk_hw_onecell_data data;
> +};
> +
> +struct bcm63268_tclk_table_entry {
> +       const char * const name;
> +       u8 bit;
> +       unsigned long flags;

This isn't used. Drop it?

> +};
> +
> +static const struct bcm63268_tclk_table_entry bcm63268_timer_clocks[] =
=3D {
> +       {
> +               .name =3D "ephy1",
> +               .bit =3D BCM63268_TCLK_EPHY1,
> +       }, {
> +               .name =3D "ephy2",
> +               .bit =3D BCM63268_TCLK_EPHY2,
> +       }, {
> +               .name =3D "ephy3",
> +               .bit =3D BCM63268_TCLK_EPHY3,
> +       }, {
> +               .name =3D "gphy1",
> +               .bit =3D BCM63268_TCLK_GPHY1,
> +       }, {
> +               .name =3D "dsl",
> +               .bit =3D BCM63268_TCLK_DSL,
> +       }, {
> +               .name =3D "wakeon_ephy",
> +               .bit =3D BCM63268_TCLK_WAKEON_EPHY,
> +       }, {
> +               .name =3D "wakeon_dsl",
> +               .bit =3D BCM63268_TCLK_WAKEON_DSL,
> +       }, {
> +               .name =3D "fap1_pll",
> +               .bit =3D BCM63268_TCLK_FAP1,
> +       }, {
> +               .name =3D "fap2_pll",
> +               .bit =3D BCM63268_TCLK_FAP2,
> +       }, {
> +               .name =3D "uto_50",
> +               .bit =3D BCM63268_TCLK_UTO_50,
> +       }, {
> +               .name =3D "uto_extin",
> +               .bit =3D BCM63268_TCLK_UTO_EXTIN,
> +       }, {
> +               .name =3D "usb_ref",
> +               .bit =3D BCM63268_TCLK_USB_REF,
> +       }, {
> +               /* sentinel */
> +       }
> +};
> +
> +static inline struct bcm63268_tclkrst_hw *
> +to_bcm63268_timer_reset(struct reset_controller_dev *rcdev)
> +{
> +       return container_of(rcdev, struct bcm63268_tclkrst_hw, rcdev);
> +}
> +
> +static int bcm63268_timer_reset_update(struct reset_controller_dev *rcde=
v,
> +                               unsigned long id, bool assert)
> +{
> +       struct bcm63268_tclkrst_hw *reset =3D to_bcm63268_timer_reset(rcd=
ev);
> +       unsigned long flags;
> +       uint32_t val;
> +
> +       spin_lock_irqsave(&reset->lock, flags);
> +       val =3D __raw_readl(reset->regs);
> +       if (assert)
> +               val &=3D ~BIT(id);
> +       else
> +               val |=3D BIT(id);
> +       __raw_writel(val, reset->regs);
> +       spin_unlock_irqrestore(&reset->lock, flags);
> +
> +       return 0;
> +}
> +
> +static int bcm63268_timer_reset_assert(struct reset_controller_dev *rcde=
v,
> +                               unsigned long id)
> +{
> +       return bcm63268_timer_reset_update(rcdev, id, true);
> +}
> +
> +static int bcm63268_timer_reset_deassert(struct reset_controller_dev *rc=
dev,
> +                                 unsigned long id)
> +{
> +       return bcm63268_timer_reset_update(rcdev, id, false);
> +}
> +
> +static int bcm63268_timer_reset_reset(struct reset_controller_dev *rcdev,
> +                              unsigned long id)
> +{
> +       bcm63268_timer_reset_update(rcdev, id, true);
> +       usleep_range(BCM63268_TIMER_RESET_SLEEP_MIN_US,
> +                    BCM63268_TIMER_RESET_SLEEP_MAX_US);
> +
> +       bcm63268_timer_reset_update(rcdev, id, false);
> +       /*
> +        * Ensure component is taken out reset state by sleeping also aft=
er
> +        * deasserting the reset. Otherwise, the component may not be rea=
dy
> +        * for operation.
> +        */
> +       usleep_range(BCM63268_TIMER_RESET_SLEEP_MIN_US,
> +                    BCM63268_TIMER_RESET_SLEEP_MAX_US);
> +
> +       return 0;
> +}
> +
> +static int bcm63268_timer_reset_status(struct reset_controller_dev *rcde=
v,
> +                               unsigned long id)
> +{
> +       struct bcm63268_tclkrst_hw *reset =3D to_bcm63268_timer_reset(rcd=
ev);
> +
> +       return !(__raw_readl(reset->regs) & BIT(id));
> +}
> +
> +static struct reset_control_ops bcm63268_timer_reset_ops =3D {
> +       .assert =3D bcm63268_timer_reset_assert,
> +       .deassert =3D bcm63268_timer_reset_deassert,
> +       .reset =3D bcm63268_timer_reset_reset,
> +       .status =3D bcm63268_timer_reset_status,
> +};
> +
> +static int bcm63268_tclk_probe(struct platform_device *pdev)
> +{
> +       struct device *dev =3D &pdev->dev;
> +       const struct bcm63268_tclk_table_entry *entry, *table;
> +       struct bcm63268_tclkrst_hw *hw;
> +       u8 maxbit =3D 0;
> +       int i, ret;
> +
> +       table =3D of_device_get_match_data(dev);
> +       if (!table)
> +               return -EINVAL;
> +
> +       for (entry =3D table; entry->name; entry++)
> +               maxbit =3D max_t(u8, maxbit, entry->bit);

Is max_t() required? Hopefully just max() can be used.

> +       maxbit++;
> +
> +       hw =3D devm_kzalloc(&pdev->dev, struct_size(hw, data.hws, maxbit),
> +                         GFP_KERNEL);
> +       if (!hw)
> +               return -ENOMEM;
> +
> +       platform_set_drvdata(pdev, hw);
> +
> +       spin_lock_init(&hw->lock);
> +
> +       hw->data.num =3D maxbit;
> +       for (i =3D 0; i < maxbit; i++)
> +               hw->data.hws[i] =3D ERR_PTR(-ENODEV);
> +
> +       hw->regs =3D devm_platform_ioremap_resource(pdev, 0);
> +       if (IS_ERR(hw->regs))
> +               return PTR_ERR(hw->regs);
> +
> +       for (entry =3D table; entry->name; entry++) {
> +               struct clk_hw *clk;

Please move this declaration to start of the function instead of local
to this loop.

> +
> +               clk =3D clk_hw_register_gate(dev, entry->name, NULL,
> +                                          entry->flags, hw->regs, entry-=
>bit,
> +                                          CLK_GATE_BIG_ENDIAN, &hw->lock=
);
> +               if (IS_ERR(clk)) {
> +                       ret =3D PTR_ERR(clk);
> +                       goto out_err;
> +               }
> +
> +               hw->data.hws[entry->bit] =3D clk;
> +       }
> +
> +       ret =3D of_clk_add_hw_provider(dev->of_node, of_clk_hw_onecell_ge=
t,

Please use devm or unregister this on failure.

> +                                    &hw->data);
> +       if (!ret)
> +               return 0;
> +
> +       hw->rcdev.of_node =3D dev->of_node;
> +       hw->rcdev.ops =3D &bcm63268_timer_reset_ops;
> +
> +       ret =3D devm_reset_controller_register(dev, &hw->rcdev);
> +       if (ret)
> +               dev_err(dev, "Failed to register reset controller\n");

Why do we only register reset controller on failure to add the clk hw
provider?

> +
> +out_err:
> +       for (i =3D 0; i < hw->data.num; i++) {
> +               if (!IS_ERR(hw->data.hws[i]))
> +                       clk_hw_unregister_gate(hw->data.hws[i]);
> +       }
> +
