Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72F8B4303E2
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 19:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243986AbhJPRVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 13:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbhJPRVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 13:21:03 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9C9C061570;
        Sat, 16 Oct 2021 10:18:54 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id z20so51594234edc.13;
        Sat, 16 Oct 2021 10:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=eDrZAVgr6gXztfY6YuCojIIzJX8BkmSmkXn/eMUrmak=;
        b=OBc44gbIyexm/ldgbuh4Qm7kyybFebIcCNPLtfZszfK+t6YH7gKp5jS2eNOZSJm4Fh
         qKBaSOu8S5V3JdecaBFvdVoqmuEvjncgi/RDaqw1auxwDPSK0qKfiFhjrvnp/AnjB3X2
         EAQjLDEORaqBGAoMDYgFEiBWP83P2UQ4FkehEEOC7lrQoWLz7bAtKd5quuSR3S0LyHcH
         FujAmmMaLy6kX+9EFXwcZf1KSWcqf8OwaqkwChg3rvUhsMB3OoJ9QuE/I9WhKrUvgHs4
         uTBtz6rDmu8l6ESnzcuqWRrQRJai8L9un3OIHBO6UeGI8DSoG6DQQf26fmVd031R5A5I
         6CaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=eDrZAVgr6gXztfY6YuCojIIzJX8BkmSmkXn/eMUrmak=;
        b=Fpy7hRWmoF3L0hCT+uMqiicwQtGwt1rBVD8qe0q1h4mANsVz7oYZdNDpqFMsWajGqr
         HVZButnKTNLlw+9Xbu8F+MhN6hZ/eU5FLmyl/E4F4mDf2Gs42cQJKTVpUqV6oxBVF8iI
         P3uYAfG5u4k32VeOgmpDUvSF8DsPieTAwJii42RTjJoK+zrKppzsI3fh7OuJTxD/SOTy
         /aoluAfkmJ+u0QEs42a/EejNITzRhJbyh0npX4VukFRPKfGt5v8aEMDJGQzfgRiA7Ct8
         z3P/Ew/QGr2TYyPg98Oq3szWw1qs0mDn/5lpJXfL/sUP0aF6JTheqlekp/Ee8nUsIm8U
         0y6A==
X-Gm-Message-State: AOAM530IC73PxI8lkMoNpjFTBqQncxk8M8/YPFP7FyGDavFUZf0Tb8ih
        vZ5QVJhts2LJkp8i4Qk+h9Y=
X-Google-Smtp-Source: ABdhPJzgG/uUWDXa8uM9FOuCmMlIcs36QVxE3caz5llmugfKanOMr7zzlV9f9Le21vZCaDnD22NKng==
X-Received: by 2002:a05:6402:3186:: with SMTP id di6mr27724723edb.225.1634404732989;
        Sat, 16 Oct 2021 10:18:52 -0700 (PDT)
Received: from [172.16.20.20] ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id c8sm7012426edt.55.2021.10.16.10.18.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Oct 2021 10:18:52 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.7\))
Subject: Re: [PATCH] clk: meson: gxbb: Add the spread spectrum bit for MPLL0
 on GXBB
From:   Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <20211016145939.15643-1-martin.blumenstingl@googlemail.com>
Date:   Sat, 16 Oct 2021 21:18:49 +0400
Cc:     linux-amlogic@lists.infradead.org, jbrunet@baylibre.com,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <BA5C537C-0595-4ABA-A71A-C5722F8E94A6@gmail.com>
References: <20211016145939.15643-1-martin.blumenstingl@googlemail.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
X-Mailer: Apple Mail (2.3608.120.23.2.7)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 16 Oct 2021, at 6:59 pm, Martin Blumenstingl =
<martin.blumenstingl@googlemail.com> wrote:
>=20
> Christian reports that 48kHz audio does not work on his WeTek Play 2
> (which uses a GXBB SoC), while 44.1kHz audio works fine on the same
> board. He also reports that 48kHz audio works on GXL and GXM SoCs,
> which are using an (almost) identical AIU (audio controller).
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
> The 3.14 vendor kernel uses the following code to enable SSEN only for
> MPLL0 (where con_reg2 is HHI_MPLL_CNTL and SSEN_shift is 25):
> 	if (strncmp(hw->clk->name, "mpll_clk_out0", 13) =3D=3D 0) {
> 		val =3D readl(mpll->con_reg2);
> 		val |=3D 1 <<  mpll->SSEN_shift;
> 		writel(val, mpll->con_reg2);
> 	}
>=20
> Add the SSEN (spread spectrum enable) bit and add the
> CLK_MESON_MPLL_SPREAD_SPECTRUM flag to enable this bit for MPLL0. Do
> this for GXBB *only* since GXL doesn't seem to care if this bit is set
> or not, meaning that meson-clk-msr always sees (approximately) the =
same
> frequency as common clock framework.
>=20
> Fixes: 8925dbd03bb29b ("clk: meson: gxbb: no spread spectrum on mpll")
> Reported-by: Christian Hewitt <christianshewitt@gmail.com>
> Signed-off-by: Martin Blumenstingl =
<martin.blumenstingl@googlemail.com>

Tested with a selection of different media at 41KHz and 48KHz on GXBB
(WeTek Play2 and Hub) and GXL (LePotato).

Tested-by: Christian Hewitt <christianshewitt@gmail.com>

> ---
> drivers/clk/meson/gxbb.c | 50 +++++++++++++++++++++++++++++++++++++---
> 1 file changed, 47 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
> index d6eed760327d..673bc915c7d9 100644
> --- a/drivers/clk/meson/gxbb.c
> +++ b/drivers/clk/meson/gxbb.c
> @@ -713,6 +713,41 @@ static struct clk_regmap gxbb_mpll_prediv =3D {
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
> +			.reg_off =3D HHI_MPLL_CNTL7,
> +			.shift   =3D 15,
> +			.width	 =3D 1,
> +		},
> +		.n2 =3D {
> +			.reg_off =3D HHI_MPLL_CNTL7,
> +			.shift   =3D 16,
> +			.width   =3D 9,
> +		},
> +		.ssen =3D {
> +			.reg_off =3D HHI_MPLL_CNTL,
> +			.shift   =3D 25,
> +			.width   =3D 1,
> +		},
> +		.flags =3D CLK_MESON_MPLL_SPREAD_SPECTRUM,
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
> @@ -749,7 +784,16 @@ static struct clk_regmap gxbb_mpll0 =3D {
> 	.hw.init =3D &(struct clk_init_data){
> 		.name =3D "mpll0",
> 		.ops =3D &clk_regmap_gate_ops,
> -		.parent_hws =3D (const struct clk_hw *[]) { =
&gxbb_mpll0_div.hw },
> +		.parent_data =3D &(const struct clk_parent_data) {
> +			/*
> +			 * Note:
> +			 * GXL and GXBB have different SSEN =
requirements. We
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
> @@ -3044,7 +3088,7 @@ static struct clk_hw_onecell_data =
gxl_hw_onecell_data =3D {
> 		[CLKID_VAPB_1]		    =3D &gxbb_vapb_1.hw,
> 		[CLKID_VAPB_SEL]	    =3D &gxbb_vapb_sel.hw,
> 		[CLKID_VAPB]		    =3D &gxbb_vapb.hw,
> -		[CLKID_MPLL0_DIV]	    =3D &gxbb_mpll0_div.hw,
> +		[CLKID_MPLL0_DIV]	    =3D &gxl_mpll0_div.hw,
> 		[CLKID_MPLL1_DIV]	    =3D &gxbb_mpll1_div.hw,
> 		[CLKID_MPLL2_DIV]	    =3D &gxbb_mpll2_div.hw,
> 		[CLKID_MPLL_PREDIV]	    =3D &gxbb_mpll_prediv.hw,
> @@ -3439,7 +3483,7 @@ static struct clk_regmap *const =
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

