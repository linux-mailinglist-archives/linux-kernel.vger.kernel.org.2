Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 565DE35D1F7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 22:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238662AbhDLU1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 16:27:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:47070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237641AbhDLU1g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 16:27:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DAA80611C9;
        Mon, 12 Apr 2021 20:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618259238;
        bh=1+4KYDIHljL2KQAWWmokYPPs36J7vyw8CPMGNDtoN5g=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=tsVI6pDsryMf0h9Lje1ZYHwpUCb2/ofclSajhc77s31PaWHr8b7be7KvKdtsWGo1f
         mz3kyInEMHHxe7ShH1ZN0rjnsJdAPX2iRZwsi2SrpOUdJXF6xJ0dN7gSKebxNuewTj
         XR6mWGcMYsbinjGSqTxPXJFDar+3Pp8X5xr6fXtw21BDHZpvzEug0awOEwr/U1egR6
         ZyJyVEjzF31IFkB1cXlKjeKC9FxEcx+bZzlBF41N5raNy27OtfdFFR2MXJ/SJVYPNa
         mehS2uvJtMLlTMKQzXybLyMEKcU4t5bnCPMv4vszOeWFT7l57hemQ/btZ/Rb1gGXXb
         glN4OF2SUBMYg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210410111356.467340-4-jbrunet@baylibre.com>
References: <20210410111356.467340-1-jbrunet@baylibre.com> <20210410111356.467340-4-jbrunet@baylibre.com>
Subject: Re: [PATCH 3/5] ASoC: rt5682: clock driver must use the clock provider API
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Date:   Mon, 12 Apr 2021 13:27:16 -0700
Message-ID: <161825923642.3764895.16526540466177115640@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jerome Brunet (2021-04-10 04:13:54)
> Clock drivers ops should not the clk API but the clock provider (clk_hw)
> instead.
>=20
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  sound/soc/codecs/rt5682.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/sound/soc/codecs/rt5682.c b/sound/soc/codecs/rt5682.c
> index 0e2a10ed11da..2eee02ac8d49 100644
> --- a/sound/soc/codecs/rt5682.c
> +++ b/sound/soc/codecs/rt5682.c
> @@ -2634,7 +2634,7 @@ static int rt5682_wclk_set_rate(struct clk_hw *hw, =
unsigned long rate,
>                 container_of(hw, struct rt5682_priv,
>                              dai_clks_hw[RT5682_DAI_WCLK_IDX]);
>         struct snd_soc_component *component =3D rt5682->component;
> -       struct clk *parent_clk;
> +       struct clk_hw *parent_hw;
>         const char * const clk_name =3D clk_hw_get_name(hw);
>         int pre_div;
>         unsigned int clk_pll2_out;
> @@ -2649,8 +2649,8 @@ static int rt5682_wclk_set_rate(struct clk_hw *hw, =
unsigned long rate,
>          *
>          * It will set the codec anyway by assuming mclk is 48MHz.
>          */
> -       parent_clk =3D clk_get_parent(hw->clk);
> -       if (!parent_clk)
> +       parent_hw =3D clk_hw_get_parent(hw);
> +       if (!parent_hw)
>                 dev_warn(component->dev,
>                         "Parent mclk of wclk not acquired in driver. Plea=
se ensure mclk was provided as %d Hz.\n",
>                         CLK_PLL2_FIN);

Can this code be removed? I don't know why we care to check if the clk
has a parent or not.
