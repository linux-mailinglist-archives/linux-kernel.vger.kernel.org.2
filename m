Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4233149E5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 09:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbhBIIB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 03:01:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:39216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229517AbhBIIBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 03:01:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 27CCC64E6F;
        Tue,  9 Feb 2021 08:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612857642;
        bh=PrZKwTBAEkhO9oVwFzz9vR4RpjecGA222H6u+Smz3/g=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=RZfSdW4MONU6xyHZcAlXF3UuyrNKwqpNx49sUuIUYtO86OB+31RzMa1O7dF6M8YBN
         S9MNPiFRGvoUA8A7uoT3UZCXdmXkFdNWGQbJ+sjvPOwuF+KFSBJW6x2gxRNadUf4bP
         TGupFGxUhX0KPEaei1olRQFWoplvhuVhF2qYSql41c20wThIpVrLDHHKFENyYOEJl2
         h6MSfwndGoBOY8w349HyrpUO+EjDiPP8L/NShDsheNvOfjRpZ9QV9QdZU2yJWTiPRZ
         i9t4psH+djtVZrQpkwSgDJim/iW8woBnt+ZvJELngCF1WqDRt/z1M9KYOY8Du/SNoX
         y0os1dyaKr6Yg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210126090120.19900-3-gabriel.fernandez@foss.st.com>
References: <20210126090120.19900-1-gabriel.fernandez@foss.st.com> <20210126090120.19900-3-gabriel.fernandez@foss.st.com>
Subject: Re: [PATCH v2 02/14] clk: stm32mp1: merge 'ck_hse_rtc' and 'ck_rtc' into one clock
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To:     Alexandre Torgue <alexandre.torgue@st.com>,
        Etienne Carriere <etienne.carriere@st.com>,
        Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, marex@denx.de
Date:   Tue, 09 Feb 2021 00:00:40 -0800
Message-ID: <161285764074.418021.15522379930579131077@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting gabriel.fernandez@foss.st.com (2021-01-26 01:01:08)
> From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
>=20
> 'ck_rtc' has multiple clocks as input (ck_hsi, ck_lsi, and ck_hse).
> A divider is available only on the specific rtc input for ck_hse.
> This Merge will facilitate to have a more coherent clock tree
> in no trusted / trusted world.
>=20
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
> ---
>  drivers/clk/clk-stm32mp1.c | 49 +++++++++++++++++++++++++++++++++-----
>  1 file changed, 43 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/clk/clk-stm32mp1.c b/drivers/clk/clk-stm32mp1.c
> index 35d5aee8f9b0..0e1d4427a8df 100644
> --- a/drivers/clk/clk-stm32mp1.c
> +++ b/drivers/clk/clk-stm32mp1.c
> @@ -245,7 +245,7 @@ static const char * const dsi_src[] =3D {
>  };
> =20
>  static const char * const rtc_src[] =3D {
> -       "off", "ck_lse", "ck_lsi", "ck_hse_rtc"
> +       "off", "ck_lse", "ck_lsi", "ck_hse"
>  };
> =20
>  static const char * const mco1_src[] =3D {
> @@ -1031,6 +1031,42 @@ static struct clk_hw *clk_register_cktim(struct de=
vice *dev, const char *name,
>         return hw;
>  }
> =20
> +/* The divider of RTC clock concerns only ck_hse clock */
> +#define HSE_RTC 3
> +
> +static unsigned long clk_divider_rtc_recalc_rate(struct clk_hw *hw,
> +                                                unsigned long parent_rat=
e)
> +{
> +       if (clk_hw_get_parent(hw) =3D=3D clk_hw_get_parent_by_index(hw, H=
SE_RTC))
> +               return clk_divider_ops.recalc_rate(hw, parent_rate);
> +
> +       return parent_rate;
> +}
> +
> +static long clk_divider_rtc_round_rate(struct clk_hw *hw, unsigned long =
rate,
> +                                      unsigned long *prate)
> +{
> +       if (clk_hw_get_parent(hw) =3D=3D clk_hw_get_parent_by_index(hw, H=
SE_RTC))

This clk op can be called at basically any time. Maybe this should use
the determine rate op and then look to see what the parent is that comes
in via the rate request structure? Or is the intention to keep this
pinned to one particular parent? Looking at this right now it doesn't
really make much sense why the current parent state should play into
what rate the clk can round to, unless there is some more clk flags
going on that constrain the ability to change this clk's parent.

> +               return clk_divider_ops.round_rate(hw, rate, prate);
> +
> +       return *prate;
> +}
> +
> +static int clk_divider_rtc_set_rate(struct clk_hw *hw, unsigned long rat=
e,
> +                                   unsigned long parent_rate)
> +{
> +       if (clk_hw_get_parent(hw) =3D=3D clk_hw_get_parent_by_index(hw, H=
SE_RTC))
> +               return clk_divider_ops.set_rate(hw, rate, parent_rate);
> +
> +       return parent_rate;
> +}
> +
