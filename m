Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD1F93183D2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 04:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbhBKDGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 22:06:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:57902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229763AbhBKDGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 22:06:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1D26164EBB;
        Thu, 11 Feb 2021 03:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613012737;
        bh=4ecn8gSYd2ADWPrcofKdtHOgmHlpK9CW62M5mx9kvEM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=V695XtNOqM6levao0KD4RikBk8G3B6h18TRcdFGZqOrwxOQqEc/C2jHdFrKKFNfB0
         XCHGt1ZKPkAp20gid5/h3YX6XcsoSNMSBIcQ0alVYil1B49+Yj4PsqtPg6tHeunCfu
         H0eEI844tP9t5Dfc/xyvvXS7Btia66ciMyNx5thPnbk+kToKKWbIge/ME6JTrHubMB
         gFQihkoAcBDGWBvvgUUATv2VemDY/yEhfCGEzV2PA81gmD3Gd79FGP2GqZw3Pzuacr
         WR53l8KViWv4ajW6yv5dcJtsG2h+bhIEbWO4CSIxan/d5PP/3PQtOwR+RSgGjVOCQj
         U2U/kfC4OnivQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210105192956.2059505-1-dinguyen@kernel.org>
References: <20210105192956.2059505-1-dinguyen@kernel.org>
Subject: Re: [PATCH] clk: socfpga: agilex: add clock driver for eASIC N5X platform
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     dinguyen@kernel.org, mturquette@baylibre.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Dinh Nguyen <dinguyen@kernel.org>
Date:   Wed, 10 Feb 2021 19:05:35 -0800
Message-ID: <161301273585.1254594.15922396130376508467@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dinh Nguyen (2021-01-05 11:29:56)
> Add support for Intel's eASIC N5X platform. The clock manager driver for
> the N5X is very similar to the Agilex platform, we can re-use most of
> the Agilex clock driver.
>=20
> This patch makes the necessary changes for the driver to differentiate
> between the Agilex and the N5X platforms.
>=20
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> ---

Sorry this patch fell off my radar.

I ran checkpatch

WARNING: function definition argument 'struct platform_device *' should als=
o have an identifier name
#135: FILE: drivers/clk/socfpga/clk-agilex.c:500:
+       int (*probe_func)(struct platform_device *);

WARNING: Statements terminations use 1 semicolon
#140: FILE: drivers/clk/socfpga/clk-agilex.c:505:
+       return  probe_func(pdev);;

WARNING: DT compatible string "intel,n5x-clkmgr" appears un-documented -- c=
heck ./Documentation/devicetree/bindings/
#147: FILE: drivers/clk/socfpga/clk-agilex.c:511:
+       { .compatible =3D "intel,n5x-clkmgr",

WARNING: struct clk_ops should normally be const
#290: FILE: drivers/clk/socfpga/clk-pll-s10.c:166:
+static struct clk_ops n5x_clk_pll_ops =3D {

WARNING: struct clk_ops should normally be const
#296: FILE: drivers/clk/socfpga/clk-pll-s10.c:172:
+static struct clk_ops agilex_clk_pll_ops =3D {

WARNING: function definition argument 'const struct stratix10_pll_clock *' =
should also have an identifier name
#367: FILE: drivers/clk/socfpga/stratix10-clk.h:78:
+struct clk *n5x_register_pll(const struct stratix10_pll_clock *,

WARNING: function definition argument 'void __iomem *' should also have an =
identifier name
#367: FILE: drivers/clk/socfpga/stratix10-clk.h:78:
+struct clk *n5x_register_pll(const struct stratix10_pll_clock *,

WARNING: function definition argument 'const struct n5x_perip_c_clock *' sh=
ould also have an identifier name
#371: FILE: drivers/clk/socfpga/stratix10-clk.h:82:
+struct clk *n5x_register_periph(const struct n5x_perip_c_clock *,

WARNING: function definition argument 'void __iomem *' should also have an =
identifier name
#371: FILE: drivers/clk/socfpga/stratix10-clk.h:82:
+struct clk *n5x_register_periph(const struct n5x_perip_c_clock *,

Can you fix these up and resend?

>  drivers/clk/socfpga/clk-agilex.c     | 88 +++++++++++++++++++++++++++-
>  drivers/clk/socfpga/clk-periph-s10.c | 53 +++++++++++++++++
>  drivers/clk/socfpga/clk-pll-s10.c    | 85 ++++++++++++++++++++++++++-
>  drivers/clk/socfpga/stratix10-clk.h  | 15 +++++
>  4 files changed, 238 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/clk/socfpga/clk-periph-s10.c b/drivers/clk/socfpga/c=
lk-periph-s10.c
> index 397b77b89b16..135581c41c05 100644
> --- a/drivers/clk/socfpga/clk-periph-s10.c
> +++ b/drivers/clk/socfpga/clk-periph-s10.c
> @@ -15,6 +15,21 @@
> =20
>  #define to_periph_clk(p) container_of(p, struct socfpga_periph_clk, hw.h=
w)
> =20
> +static unsigned long n5x_clk_peri_c_clk_recalc_rate(struct clk_hw *hwclk,
> +                                            unsigned long parent_rate)
> +{
> +       struct socfpga_periph_clk *socfpgaclk =3D to_periph_clk(hwclk);
> +       unsigned long div;
> +       unsigned long shift =3D socfpgaclk->shift;
> +       u32 val;
> +
> +       val =3D readl(socfpgaclk->hw.reg);
> +       val &=3D (0x1F << shift);

Prefer lowercase hex.

> +       div =3D (val >> shift) + 1;
> +
> +       return parent_rate / div;
> +}
> +
>  static unsigned long clk_peri_c_clk_recalc_rate(struct clk_hw *hwclk,
>                                              unsigned long parent_rate)
>  {
> @@ -63,6 +78,11 @@ static u8 clk_periclk_get_parent(struct clk_hw *hwclk)
>         return parent;
>  }
> =20
> +static const struct clk_ops n5x_peri_c_clk_ops =3D {
> +       .recalc_rate =3D n5x_clk_peri_c_clk_recalc_rate,
> +       .get_parent =3D clk_periclk_get_parent,
> +};
> +
>  static const struct clk_ops peri_c_clk_ops =3D {
>         .recalc_rate =3D clk_peri_c_clk_recalc_rate,
>         .get_parent =3D clk_periclk_get_parent,
> @@ -107,6 +127,39 @@ struct clk *s10_register_periph(const struct stratix=
10_perip_c_clock *clks,
>         return clk;
>  }
> =20
> +struct clk *n5x_register_periph(const struct n5x_perip_c_clock *clks,
> +                               void __iomem *regbase)
> +{
> +       struct clk *clk;
> +       struct socfpga_periph_clk *periph_clk;
> +       struct clk_init_data init;
> +       const char *name =3D clks->name;
> +       const char *parent_name =3D clks->parent_name;
> +
> +       periph_clk =3D kzalloc(sizeof(*periph_clk), GFP_KERNEL);
> +       if (WARN_ON(!periph_clk))
> +               return NULL;
> +
> +       periph_clk->hw.reg =3D regbase + clks->offset;
> +       periph_clk->shift =3D clks->shift;
> +
> +       init.name =3D name;
> +       init.ops =3D &n5x_peri_c_clk_ops;
> +       init.flags =3D clks->flags;
> +
> +       init.num_parents =3D clks->num_parents;
> +       init.parent_names =3D parent_name ? &parent_name : NULL;
> +
> +       periph_clk->hw.hw.init =3D &init;
> +
> +       clk =3D clk_register(NULL, &periph_clk->hw.hw);

Can you use clk_hw_register?

> +       if (WARN_ON(IS_ERR(clk))) {
> +               kfree(periph_clk);
> +               return NULL;
> +       }
> +       return clk;
> +}
> +
>  struct clk *s10_register_cnt_periph(const struct stratix10_perip_cnt_clo=
ck *clks,
>                                     void __iomem *regbase)
>  {
[...]
> @@ -214,3 +260,40 @@ struct clk *agilex_register_pll(const struct stratix=
10_pll_clock *clks,
>         }
>         return clk;
>  }
> +
> +struct clk *n5x_register_pll(const struct stratix10_pll_clock *clks,
> +                            void __iomem *reg)
> +{
> +       struct clk *clk;
> +       struct socfpga_pll *pll_clk;
> +       struct clk_init_data init;
> +       const char *name =3D clks->name;
> +
> +       pll_clk =3D kzalloc(sizeof(*pll_clk), GFP_KERNEL);
> +       if (WARN_ON(!pll_clk))
> +               return NULL;
> +
> +       pll_clk->hw.reg =3D reg + clks->offset;
> +
> +       if (streq(name, SOCFPGA_BOOT_CLK))
> +               init.ops =3D &clk_boot_ops;
> +       else
> +               init.ops =3D &n5x_clk_pll_ops;
> +
> +       init.name =3D name;
> +       init.flags =3D clks->flags;
> +
> +       init.num_parents =3D clks->num_parents;
> +       init.parent_names =3D NULL;
> +       init.parent_data =3D clks->parent_data;
> +       pll_clk->hw.hw.init =3D &init;
> +
> +       pll_clk->hw.bit_idx =3D SOCFPGA_PLL_POWER;
> +
> +       clk =3D clk_register(NULL, &pll_clk->hw.hw);

Can you use clk_hw_register?

> +       if (WARN_ON(IS_ERR(clk))) {
> +               kfree(pll_clk);
> +               return NULL;
> +       }
> +       return clk;
> +}
