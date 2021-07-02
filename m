Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06E703B9A5E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 03:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234576AbhGBBGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 21:06:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:49724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230369AbhGBBGv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 21:06:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EC320613DA;
        Fri,  2 Jul 2021 01:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625187860;
        bh=6lTjGlBo1chEWk8zH/z2MaOn2rpR7j/WephiT1Q6uDE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=IP+Y2SZXVQQb5iXv1/hQ7YV6dfKIcp5Ti5vkvU+HiW7ojIKVho+h2BN0WKEDeruDu
         /TZP3qDxT8uOpuhgT1ojJ7+GjalDMrFj4y2cMKgUY1kZ2qMmqw6iZnV2W56h5Zn9BS
         c+VAndazUNxxr4jFisx0dOOLi/ONSdyTrU9/OONI2NEwLu0C65voJUelDnKFVd5QlH
         6vZjqaBWXVrIq+3xstRPlP0hkCrAxiAz/PlIQVe5eG3kFQXtNw8gmF5JkPhlwsp/HM
         zmV2uVqtseKHDIMRjHxfxBgvwot4lx5tLaz5uD9THlQ+4Mekw1D5BRIA5ChFScRGfv
         749U3EfjsiCYQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210627223959.188139-3-martin.blumenstingl@googlemail.com>
References: <20210627223959.188139-1-martin.blumenstingl@googlemail.com> <20210627223959.188139-3-martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v3 2/3] clk: divider: Switch from .round_rate to .determine_rate by default
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     narmstrong@baylibre.com, jbrunet@baylibre.com,
        khilman@baylibre.com, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-clk@vger.kernel.org, mturquette@baylibre.com
Date:   Thu, 01 Jul 2021 18:04:18 -0700
Message-ID: <162518785878.3570193.8070459883237401552@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Martin Blumenstingl (2021-06-27 15:39:58)
> .determine_rate is meant to replace .round_rate. The former comes with a
> benefit which is especially relevant on 32-bit systems: since
> .determine_rate uses an "unsigned long" (compared to a "signed long"
> which is used by .round_rate) the maximum value on 32-bit systems
> increases from 2^31 (or approx. 2.14GHz) to 2^32 (or approx. 4.29GHz).
> Switch to a .determine_rate implementation by default so 32-bit systems
> can benefit from the increased maximum value as well as so we have one
> fewer user of .round_rate.
>=20
> Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  drivers/clk/clk-divider.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
> index 87ba4966b0e8..9e05e81116af 100644
> --- a/drivers/clk/clk-divider.c
> +++ b/drivers/clk/clk-divider.c
> @@ -425,8 +425,8 @@ long divider_ro_round_rate_parent(struct clk_hw *hw, =
struct clk_hw *parent,
>  }
>  EXPORT_SYMBOL_GPL(divider_ro_round_rate_parent);
> =20
> -static long clk_divider_round_rate(struct clk_hw *hw, unsigned long rate,
> -                               unsigned long *prate)
> +static int clk_divider_determine_rate(struct clk_hw *hw,
> +                                     struct clk_rate_request *req)
>  {
>         struct clk_divider *divider =3D to_clk_divider(hw);
> =20
> @@ -437,13 +437,13 @@ static long clk_divider_round_rate(struct clk_hw *h=
w, unsigned long rate,
>                 val =3D clk_div_readl(divider) >> divider->shift;
>                 val &=3D clk_div_mask(divider->width);
> =20
> -               return divider_ro_round_rate(hw, rate, prate, divider->ta=
ble,
> -                                            divider->width, divider->fla=
gs,
> -                                            val);
> +               return divider_ro_determine_rate(hw, req, divider->table,
> +                                                divider->width,
> +                                                divider->flags, val);
>         }
> =20
> -       return divider_round_rate(hw, rate, prate, divider->table,
> -                                 divider->width, divider->flags);
> +       return divider_determine_rate(hw, req, divider->table, divider->w=
idth,
> +                                     divider->flags);
>  }
> =20
>  int divider_get_val(unsigned long rate, unsigned long parent_rate,
> @@ -500,14 +500,14 @@ static int clk_divider_set_rate(struct clk_hw *hw, =
unsigned long rate,
> =20
>  const struct clk_ops clk_divider_ops =3D {
>         .recalc_rate =3D clk_divider_recalc_rate,
> -       .round_rate =3D clk_divider_round_rate,
> +       .determine_rate =3D clk_divider_determine_rate,

Guess was right.

 $ git grep clk_divider_ops -- drivers/clk/imx/
 drivers/clk/imx/clk-divider-gate.c:     return clk_divider_ops.round_rate(=
hw, rate, prate);

>         .set_rate =3D clk_divider_set_rate,
>  };
>  EXPORT_SYMBOL_GPL(clk_divider_ops);
> =20
>  const struct clk_ops clk_divider_ro_ops =3D {
>         .recalc_rate =3D clk_divider_recalc_rate,
> -       .round_rate =3D clk_divider_round_rate,
> +       .determine_rate =3D clk_divider_determine_rate,
