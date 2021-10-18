Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A68784315D1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 12:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbhJRKVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 06:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbhJRKVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 06:21:49 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8CBC06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 03:19:38 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id r7so40414961wrc.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 03:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=Nt/DsbKNf/U6oEyp70zMTCvXerDbHSsEBUDTCVY5SZk=;
        b=5prZanh3ZiXhFVmZwmd5KUugHHD62JYZdj6kbC7LvJgiZdHYH0s0vO011ti4DMcnZr
         qlQoIAao/4qCYznRVSDHoZM1iigy+9qF1q1pHveIgmx4x9E8sURQmiSwMXdNhZ673ljE
         lELpcTfmf2l7n07+dqsYEyopKg+GWb9oXfd3rdgRzmwhAspBbEUI+6eiCUtEx13p3Qu4
         7qKY17EBlz1W9WgxHQhHYTOPzTOmkEVcwlLSoEbDg8lRec4pojWfGdBm6h+KohIOQFt/
         a8dobw/8/6VTGUerqw4ruNgiT07VNLCwUJeCNAVqjT+IDLpPaN4kFqqimnd2lG+vGAJe
         EcGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=Nt/DsbKNf/U6oEyp70zMTCvXerDbHSsEBUDTCVY5SZk=;
        b=5DEtOY/JuyYCrLdmRqRme7orxRRLQ68WSo4t7bGnw8tFP9WS9DgfYPlkqJkvF8FnGf
         vFx/0FoQpcdoZwzmKBQdBJhFtXw1+dWgdJbPnzsMZXjn9ugRfNfInu+BUMW8D7b93//o
         E7A48vxQ6jf7RnidUDDyPW/COqjVTN3WBYJwiXyTq3x9TNy0PEqRunJOQrAiaGRHsNSn
         4lEIb1LSvms38ormuFYDirE5AsWJxcvc376WDHn2AaRXIaMP25AjrFpi+jEZ7ms5fHxy
         HckzFSFhf6cvTUlqLTQQlZDnMFFIuNn//vhQXKisQCVoieYWomCiL2HApGV5MnXUDH+A
         DiOA==
X-Gm-Message-State: AOAM5307hnMSzebpJbYoFUg2F4C1XXY1ILQslsm41v6/i2fAjGOYiuwx
        vlcp8Sa3wPB6HqAeKcyQ74Gglg==
X-Google-Smtp-Source: ABdhPJzDG8zynX/vI4wK2ttElJLD5TxdXfRAChpQdZOTiLhuvQVv+a2L+hRjAsFbPLNZJPD3ux8LKA==
X-Received: by 2002:adf:a54f:: with SMTP id j15mr34068977wrb.218.1634552377158;
        Mon, 18 Oct 2021 03:19:37 -0700 (PDT)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id r5sm3208324wmh.28.2021.10.18.03.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 03:19:36 -0700 (PDT)
References: <20211016145939.15643-1-martin.blumenstingl@googlemail.com>
User-agent: mu4e 1.6.6; emacs 27.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org
Cc:     narmstrong@baylibre.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Christian Hewitt <christianshewitt@gmail.com>
Subject: Re: [PATCH] clk: meson: gxbb: Add the spread spectrum bit for MPLL0
 on GXBB
Date:   Mon, 18 Oct 2021 11:54:45 +0200
In-reply-to: <20211016145939.15643-1-martin.blumenstingl@googlemail.com>
Message-ID: <1j5ytuvdmw.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat 16 Oct 2021 at 16:59, Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:

> Christian reports that 48kHz audio does not work on his WeTek Play 2
> (which uses a GXBB SoC), while 44.1kHz audio works fine on the same
> board. He also reports that 48kHz audio works on GXL and GXM SoCs,
> which are using an (almost) identical AIU (audio controller).

The above is a bit "personal" - it is not great fit for the commit
description. Please rephrase or put it in comment section bellow

>
> Experimenting has shown that MPLL0 is causing this problem. In the .dts
> we have by default:
> 	assigned-clocks = <&clkc CLKID_MPLL0>,
> 			  <&clkc CLKID_MPLL1>,
> 			  <&clkc CLKID_MPLL2>;
> 	assigned-clock-rates = <294912000>,
> 			       <270950400>,
> 			       <393216000>;
> The MPLL0 rate is divisible by 48kHz without remainder and the MPLL1
> rate is divisible by 44.1kHz without remainder. Swapping these two clock
> rates "fixes" 48kHz audio but breaks 44.1kHz audio.
>
> Everything looks normal when looking at the info provided by the common
> clock framework while playing 48kHz audio (via I2S with mclk-fs = 256):
>         mpll_prediv                 1        1        0  2000000000
>            mpll0_div                1        1        0   294909641
>               mpll0                 1        1        0   294909641
>                  cts_amclk_sel       1        1        0   294909641
>                     cts_amclk_div       1        1        0    12287902
>                        cts_amclk       1        1        0    12287902
>
> meson-clk-msr however shows that the actual MPLL0 clock is off by more
> than 38MHz:
>         mp0_out               333322917    +/-10416Hz
>
> The 3.14 vendor kernel uses the following code to enable SSEN only for
> MPLL0 (where con_reg2 is HHI_MPLL_CNTL and SSEN_shift is 25):
> 	if (strncmp(hw->clk->name, "mpll_clk_out0", 13) == 0) {
> 		val = readl(mpll->con_reg2);
> 		val |= 1 <<  mpll->SSEN_shift;
> 		writel(val, mpll->con_reg2);
> 	}
>
> Add the SSEN (spread spectrum enable) bit and add the
> CLK_MESON_MPLL_SPREAD_SPECTRUM flag to enable this bit for MPLL0. Do
> this for GXBB *only* since GXL doesn't seem to care if this bit is set
> or not, meaning that meson-clk-msr always sees (approximately) the same
> frequency as common clock framework.

 1 - it is odd that we need to poke a bit in the register related to the
 fixed PLL but ok ...
 2 - 3.14 does yes, 4.9 does not soooo ... no real proof there
 3 - That is the most important to me: the effect you described clearly is
 not spread spectrum.

Spread spectrum varies the frequencies quickly, IOW it makes the
frequencies unstable. Some stuff do not need a particularly stable rate
and it can help with EM compatibility. This is not desirable for audio.

So 2 things:
 - If this bit really enables spread spectrum on MPLL0 (or worse, the
 Fixed PLL) - checking clk measure is not enough. It is just a mean of
 the rate seen by the SoC itself. You would not see the effect of the
 spread spectrum here ... you need to capture the clock output with a
 scope for that.

 - Or the bit is incorrectly documented (or DDS0_SSEN does not mean
 spread spectrum). If it is not a spread spectrum function, then this
 patch seems to indicate it is and it is misleading.

Either way, I'm not OK with it.

To me, the rate drop that happens when you flip this bit looks more like
the effect SDM_EN should have.

Could you check the internal values (n2 and sdm) compare this to the
output rate you actually get ? see if this leads to anything ? does
SDM_EN really has an effect on this MPLL ? it is a combination of both ?

>
> Fixes: 8925dbd03bb29b ("clk: meson: gxbb: no spread spectrum on mpll")
> Reported-by: Christian Hewitt <christianshewitt@gmail.com>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  drivers/clk/meson/gxbb.c | 50 +++++++++++++++++++++++++++++++++++++---
>  1 file changed, 47 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
> index d6eed760327d..673bc915c7d9 100644
> --- a/drivers/clk/meson/gxbb.c
> +++ b/drivers/clk/meson/gxbb.c
> @@ -713,6 +713,41 @@ static struct clk_regmap gxbb_mpll_prediv = {
>  };
>  
>  static struct clk_regmap gxbb_mpll0_div = {
> +	.data = &(struct meson_clk_mpll_data){
> +		.sdm = {
> +			.reg_off = HHI_MPLL_CNTL7,
> +			.shift   = 0,
> +			.width   = 14,
> +		},
> +		.sdm_en = {
> +			.reg_off = HHI_MPLL_CNTL7,
> +			.shift   = 15,
> +			.width	 = 1,
> +		},
> +		.n2 = {
> +			.reg_off = HHI_MPLL_CNTL7,
> +			.shift   = 16,
> +			.width   = 9,
> +		},
> +		.ssen = {
> +			.reg_off = HHI_MPLL_CNTL,
> +			.shift   = 25,
> +			.width   = 1,
> +		},
> +		.flags = CLK_MESON_MPLL_SPREAD_SPECTRUM,
> +		.lock = &meson_clk_lock,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "mpll0_div",
> +		.ops = &meson_clk_mpll_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&gxbb_mpll_prediv.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap gxl_mpll0_div = {
>  	.data = &(struct meson_clk_mpll_data){
>  		.sdm = {
>  			.reg_off = HHI_MPLL_CNTL7,
> @@ -749,7 +784,16 @@ static struct clk_regmap gxbb_mpll0 = {
>  	.hw.init = &(struct clk_init_data){
>  		.name = "mpll0",
>  		.ops = &clk_regmap_gate_ops,
> -		.parent_hws = (const struct clk_hw *[]) { &gxbb_mpll0_div.hw },
> +		.parent_data = &(const struct clk_parent_data) {
> +			/*
> +			 * Note:
> +			 * GXL and GXBB have different SSEN requirements. We
> +			 * fallback to the global naming string mechanism so
> +			 * mpll0_div picks up the appropriate one.
> +			 */
> +			.name = "mpll0_div",
> +			.index = -1,
> +		},
>  		.num_parents = 1,
>  		.flags = CLK_SET_RATE_PARENT,
>  	},
> @@ -3044,7 +3088,7 @@ static struct clk_hw_onecell_data gxl_hw_onecell_data = {
>  		[CLKID_VAPB_1]		    = &gxbb_vapb_1.hw,
>  		[CLKID_VAPB_SEL]	    = &gxbb_vapb_sel.hw,
>  		[CLKID_VAPB]		    = &gxbb_vapb.hw,
> -		[CLKID_MPLL0_DIV]	    = &gxbb_mpll0_div.hw,
> +		[CLKID_MPLL0_DIV]	    = &gxl_mpll0_div.hw,
>  		[CLKID_MPLL1_DIV]	    = &gxbb_mpll1_div.hw,
>  		[CLKID_MPLL2_DIV]	    = &gxbb_mpll2_div.hw,
>  		[CLKID_MPLL_PREDIV]	    = &gxbb_mpll_prediv.hw,
> @@ -3439,7 +3483,7 @@ static struct clk_regmap *const gxl_clk_regmaps[] = {
>  	&gxbb_mpll0,
>  	&gxbb_mpll1,
>  	&gxbb_mpll2,
> -	&gxbb_mpll0_div,
> +	&gxl_mpll0_div,
>  	&gxbb_mpll1_div,
>  	&gxbb_mpll2_div,
>  	&gxbb_cts_amclk_div,

