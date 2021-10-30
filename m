Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7D884407E1
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 09:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbhJ3HmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Oct 2021 03:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbhJ3HmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Oct 2021 03:42:02 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1C7C061570;
        Sat, 30 Oct 2021 00:39:32 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id f8so24723848edy.4;
        Sat, 30 Oct 2021 00:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=WnDflYyo3vnsJsPrmBMpCvW7yx+6ot4PlCCkUYxmJpI=;
        b=Kzc+uy1+PCn3EvrvI8PrXqlgdfCwC7Tav4/plDfcCM+GWP9TvRR7q+b1cDjhYJzN3N
         6UA7flRe6Zt33mfuxPjmILgU/854GrFQNYRo3habjmJgiWnP4eP8VB3qYfFc5kyEfayI
         5r71lZF3XSHM5/sMUV8pgcjqRnE5OWJIVxQpDvTfXDV857mEOcuD6AaqIpVdSbeXjro4
         5c6/49gQK2NMAei2dLi83ua+I9Q+dlCu8bklkL4tCYriZ5UHtbrt1uPHxBl/5KDMFenI
         ZzFWRolG+ToY9UbrdaVJzCu5NuQpcMC3mubdlENTxhAzEgoZzku0/I997vxqt7U76Nf+
         Zfcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=WnDflYyo3vnsJsPrmBMpCvW7yx+6ot4PlCCkUYxmJpI=;
        b=FSqq+/SKzp9pk6mLjdmD8sseQcpQf9IzxLxeFFviYvznIJUwPUA96H/jg9TI/DiwI7
         mF5kIsAoMt4It88UQv+0CFRdnGqKDno0DTpBzmIU+dLpsw7ZBZmDEibcoGggo9sXqBe7
         wlFRkidR8A+zMsJ6UNH8scwTpIoO7FW3XZ3COHQ/9PRz+DfkEwGkFNMInjG9U83ANTtH
         /9dV2YbDFZ3VNM+6RAsJEr6eQ9jjq+SvoyeCWiJYC3fQkNzuB1QPpucAhX3p3/mMDnv3
         K2sYAzi1hPVyvddnbV7s/4WPbae/LlOHqIYYo7tL3+uYz6086NLDRKrYrloIq9vNs+os
         PTmw==
X-Gm-Message-State: AOAM530fAAuiylBXjw0IcXj+YdgzrA3cYVuLYpRqVPe2xNgZuv7uWisJ
        s+A3MzE4YpVK+bc3FP39FPo=
X-Google-Smtp-Source: ABdhPJz7JfGatjQ7hHHqwrX7DDpASIlPz2talrTheUGX9T6ZDp9zPBd5ZSJIa/UhER9UwE3geNl1eQ==
X-Received: by 2002:a17:907:1c15:: with SMTP id nc21mr5512560ejc.510.1635579570680;
        Sat, 30 Oct 2021 00:39:30 -0700 (PDT)
Received: from [172.16.20.20] ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id o22sm3925764ejy.50.2021.10.30.00.39.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Oct 2021 00:39:30 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.7\))
Subject: Re: [PATCH v2] clk: meson: gxbb: Fix the SDM_EN bit for MPLL0 on GXBB
From:   Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <20211027185326.1653827-1-martin.blumenstingl@googlemail.com>
Date:   Sat, 30 Oct 2021 11:39:27 +0400
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <691BBB53-101E-464F-965A-3CD6EB63F27E@gmail.com>
References: <20211027185326.1653827-1-martin.blumenstingl@googlemail.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
X-Mailer: Apple Mail (2.3608.120.23.2.7)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 27 Oct 2021, at 10:53 pm, Martin Blumenstingl =
<martin.blumenstingl@googlemail.com> wrote:
>=20
> There are reports that 48kHz audio does not work on his WeTek Play 2

Typo to fixup when applying ^ s/his/the

> (which uses a GXBB SoC), while 44.1kHz audio works fine on the same
> board. There are also reports of 48kHz audio working fine on GXL and
> GXM SoCs, which are using an (almost) identical AIU (audio =
controller).
>=20
> Experimenting has shown that MPLL0 is causing this problem. In the =
.dts
> we have by default:
> 	assigned-clocks =3D <&clkc CLKID_MPLL0>,
> 			  <&clkc CLKID_MPLL1>,
> 			  <&clkc CLKID_MPLL2>;
> 	assigned-clock-rates =3D <294912000>,
> 			       <270950400>,
> 			       <393216000>;
> The MPLL0 rate is divisible by 48kHz without remainder and the MPLL1
> rate is divisible by 44.1kHz without remainder. Swapping these two =
clock
> rates "fixes" 48kHz audio but breaks 44.1kHz audio.
>=20
> Everything looks normal when looking at the info provided by the =
common
> clock framework while playing 48kHz audio (via I2S with mclk-fs =3D =
256):
>        mpll_prediv                 1        1        0  2000000000
>           mpll0_div                1        1        0   294909641
>              mpll0                 1        1        0   294909641
>                 cts_amclk_sel       1        1        0   294909641
>                    cts_amclk_div       1        1        0    12287902
>                       cts_amclk       1        1        0    12287902
>=20
> meson-clk-msr however shows that the actual MPLL0 clock is off by more
> than 38MHz:
>        mp0_out               333322917    +/-10416Hz
>=20
> The rate seen by meson-clk-msr is very close to what we would get when
> SDM (the fractional part) was ignored:
>  (2000000000Hz * 16384) / ((16384 * 6) =3D 333.33MHz
> If SDM was considered the we should get close to:
>  (2000000000Hz * 16384) / ((16384 * 6) + 12808) =3D 294.9MHz
>=20
> Further experimenting shows that HHI_MPLL_CNTL7[15] does not have any
> effect on the rate of MPLL0 as seen my meson-clk-msr (regardless of
> whether that bit is zero or one the rate is always the same according =
to
> meson-clk-msr). Using HHI_MPLL_CNTL[25] on the other hand as SDM_EN
> results in SDM being considered for the rate output by the hardware. =
The
> rate - as seen by meson-clk-msr - matches with what we expect when
> SDM_EN is enabled (fractional part is being considered, resulting in a
> 294.9MHz output) or disable (fractional part being ignored, resulting =
in
> a 333.33MHz output).
>=20
> Reported-by: Christian Hewitt <christianshewitt@gmail.com>
> Signed-off-by: Martin Blumenstingl =
<martin.blumenstingl@googlemail.com>

Tested on WP2/Odroid C2 (fixed) and VIM1/LePotato (still good), thanks!

Tested-by: Christian Hewitt <christianshewitt@gmail.com>

> ---
> changes since v1 at [0]:
> - consider HHI_MPLL_CNTL[25] as SDM_EN bit after Jerome helped me
>  understand the purpose of SDM_EN and gave some explanation why this
>  can't be a spread spectrum bit
>=20
>=20
> [0] =
https://patchwork.kernel.org/project/linux-amlogic/patch/20211016145939.15=
643-1-martin.blumenstingl@googlemail.com/
>=20
>=20
> drivers/clk/meson/gxbb.c | 44 +++++++++++++++++++++++++++++++++++++---
> 1 file changed, 41 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
> index d6eed760327d..608e0e8ca49a 100644
> --- a/drivers/clk/meson/gxbb.c
> +++ b/drivers/clk/meson/gxbb.c
> @@ -713,6 +713,35 @@ static struct clk_regmap gxbb_mpll_prediv =3D {
> };
>=20
> static struct clk_regmap gxbb_mpll0_div =3D {
> +	.data =3D &(struct meson_clk_mpll_data){
> +		.sdm =3D {
> +			.reg_off =3D HHI_MPLL_CNTL7,
> +			.shift   =3D 0,
> +			.width   =3D 14,
> +		},
> +		.sdm_en =3D {
> +			.reg_off =3D HHI_MPLL_CNTL,
> +			.shift   =3D 25,
> +			.width	 =3D 1,
> +		},
> +		.n2 =3D {
> +			.reg_off =3D HHI_MPLL_CNTL7,
> +			.shift   =3D 16,
> +			.width   =3D 9,
> +		},
> +		.lock =3D &meson_clk_lock,
> +	},
> +	.hw.init =3D &(struct clk_init_data){
> +		.name =3D "mpll0_div",
> +		.ops =3D &meson_clk_mpll_ops,
> +		.parent_hws =3D (const struct clk_hw *[]) {
> +			&gxbb_mpll_prediv.hw
> +		},
> +		.num_parents =3D 1,
> +	},
> +};
> +
> +static struct clk_regmap gxl_mpll0_div =3D {
> 	.data =3D &(struct meson_clk_mpll_data){
> 		.sdm =3D {
> 			.reg_off =3D HHI_MPLL_CNTL7,
> @@ -749,7 +778,16 @@ static struct clk_regmap gxbb_mpll0 =3D {
> 	.hw.init =3D &(struct clk_init_data){
> 		.name =3D "mpll0",
> 		.ops =3D &clk_regmap_gate_ops,
> -		.parent_hws =3D (const struct clk_hw *[]) { =
&gxbb_mpll0_div.hw },
> +		.parent_data =3D &(const struct clk_parent_data) {
> +			/*
> +			 * Note:
> +			 * GXL and GXBB have different SDM_EN registers. =
We
> +			 * fallback to the global naming string =
mechanism so
> +			 * mpll0_div picks up the appropriate one.
> +			 */
> +			.name =3D "mpll0_div",
> +			.index =3D -1,
> +		},
> 		.num_parents =3D 1,
> 		.flags =3D CLK_SET_RATE_PARENT,
> 	},
> @@ -3044,7 +3082,7 @@ static struct clk_hw_onecell_data =
gxl_hw_onecell_data =3D {
> 		[CLKID_VAPB_1]		    =3D &gxbb_vapb_1.hw,
> 		[CLKID_VAPB_SEL]	    =3D &gxbb_vapb_sel.hw,
> 		[CLKID_VAPB]		    =3D &gxbb_vapb.hw,
> -		[CLKID_MPLL0_DIV]	    =3D &gxbb_mpll0_div.hw,
> +		[CLKID_MPLL0_DIV]	    =3D &gxl_mpll0_div.hw,
> 		[CLKID_MPLL1_DIV]	    =3D &gxbb_mpll1_div.hw,
> 		[CLKID_MPLL2_DIV]	    =3D &gxbb_mpll2_div.hw,
> 		[CLKID_MPLL_PREDIV]	    =3D &gxbb_mpll_prediv.hw,
> @@ -3439,7 +3477,7 @@ static struct clk_regmap *const =
gxl_clk_regmaps[] =3D {
> 	&gxbb_mpll0,
> 	&gxbb_mpll1,
> 	&gxbb_mpll2,
> -	&gxbb_mpll0_div,
> +	&gxl_mpll0_div,
> 	&gxbb_mpll1_div,
> 	&gxbb_mpll2_div,
> 	&gxbb_cts_amclk_div,
> --=20
> 2.33.1
>=20
>=20

