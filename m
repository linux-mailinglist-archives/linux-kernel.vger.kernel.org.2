Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56C7B37358F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 09:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbhEEH2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 03:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbhEEH2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 03:28:23 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D0CC061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 00:27:26 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id m9so654758wrx.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 00:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fTqXNGzbTSVFQhK/swTSDs7zLrzEFbUi3UKZNre76o8=;
        b=vlyKFO9kYvefMZA5Qkz8Tu5XHiYtXPkVeInRSA8WcA7XDnC7yZmbMm3U/z5CbbueXl
         g0vT2FhoJIuOV3/vBoZGQtK7KL9UBvI1BE0fJU7vqcQUOCwWb11qYInpstygfpz80IFD
         gU5/yn3ihWOOHfSQdcwV9gIdPRn1r2v8Moi93HSWedg7UJfQVGq8NO+M8WPaDNrcwQCl
         ifPkRyVMPSX6FhnQ5ZB2Dwu6yFh3pt9XsrrbsPR04Ux2eCHvfQq3FlYBDMcw28a3qFKx
         +0q2N2piuwx/S4SkB/YrbKqHegvJ893g8/xTpMUKkpelOYNk7I5N9Amx/MC/YHd+y0Ve
         w6LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=fTqXNGzbTSVFQhK/swTSDs7zLrzEFbUi3UKZNre76o8=;
        b=ewjjD5M20Eea5Z/ZVBPamz9pBk7sFqJ9fXcICQtFIOOa5hnOZYzv74RG3q4fmA3Ye6
         uz8xQ3sqhK9BuLXITrOoJVTE729BY5t+h8kwwvFtgQS1zx7dZha7itkN/W0goYbkN4F4
         6sjmzpXNjLVDabHg/4lOMTOs+7wbss5U7kO6n8KcWW07fWZADrho+nM0WlNtrx3hG46y
         AgXK94mp6SwBBTvypnodZZkQJ31ylJQ61qyS8uwu4bwq9Yy2UVqhaaI9kBvSvpVRLcG6
         vwYg/Kuc9fL1UyBxbT96zqjj4PzwzRay0o38a63tQQgufiSDSM0DwCQrk0dgKiuBWcC0
         rhiw==
X-Gm-Message-State: AOAM5311jRhz41adovbjG6j3EDZP3fieN7Xd+DmRsAE+taZSPg4kcs5q
        Rxa+dGkhgpXdpFa6+I9Mgdo9wfoH+RKtcXOd
X-Google-Smtp-Source: ABdhPJyFB/lcrtW9M7nGTwjlT0jt5wEmILG38hBgbAYglsIexcgf3R9tDMPnc28EuExwswUNRcp0Sg==
X-Received: by 2002:a5d:6352:: with SMTP id b18mr36652433wrw.76.1620199645180;
        Wed, 05 May 2021 00:27:25 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:90c:e290:6eb3:66ab:cb1e:ef0? ([2a01:e0a:90c:e290:6eb3:66ab:cb1e:ef0])
        by smtp.gmail.com with ESMTPSA id h8sm4606700wmq.19.2021.05.05.00.27.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 May 2021 00:27:24 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] sound: meson: g12a-toacodec: add support for SM1
 TOACODEC
To:     jbrunet@baylibre.com, broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210505072607.3815442-1-narmstrong@baylibre.com>
 <20210505072607.3815442-4-narmstrong@baylibre.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <a2d7df9e-5fb7-0c86-b0b0-2a5cdfab8823@baylibre.com>
Date:   Wed, 5 May 2021 09:27:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210505072607.3815442-4-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/05/2021 09:26, Neil Armstrong wrote:
> This adds support for the TOACODEC found in Amlogic SM1 SoCs.
> 
> The bits are shifted for more selection of clock sources, so this only
> maps the same support for G12A to the SM1 bits.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  sound/soc/meson/g12a-toacodec.c | 64 ++++++++++++++++++++++++++++++++-
>  1 file changed, 63 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/meson/g12a-toacodec.c b/sound/soc/meson/g12a-toacodec.c
> index 2084c9542c9c..5437ecba9c47 100644
> --- a/sound/soc/meson/g12a-toacodec.c
> +++ b/sound/soc/meson/g12a-toacodec.c
> @@ -21,13 +21,22 @@
>  
>  #define TOACODEC_CTRL0			0x0
>  #define  CTRL0_ENABLE_SHIFT		31
> +#define  CTRL0_DAT_SEL_SM1_MSB		19
> +#define  CTRL0_DAT_SEL_SM1_LSB		18
>  #define  CTRL0_DAT_SEL_MSB		15
>  #define  CTRL0_DAT_SEL_LSB		14
> +#define  CTRL0_LANE_SEL_SM1		16
>  #define  CTRL0_LANE_SEL			12
> +#define  CTRL0_LRCLK_SEL_SM1_MSB	14
> +#define  CTRL0_LRCLK_SEL_SM1_LSB	12
>  #define  CTRL0_LRCLK_SEL_MSB		9
>  #define  CTRL0_LRCLK_SEL_LSB		8
> +#define  CTRL0_LRCLK_INV_SM1		BIT(10)
> +#define  CTRL0_BLK_CAP_INV_SM1		BIT(9)
>  #define  CTRL0_BLK_CAP_INV		BIT(7)
> +#define  CTRL0_BCLK_O_INV_SM1		BIT(8)
>  #define  CTRL0_BCLK_O_INV		BIT(6)
> +#define  CTRL0_BCLK_SEL_SM1_MSB		6
>  #define  CTRL0_BCLK_SEL_MSB		5
>  #define  CTRL0_BCLK_SEL_LSB		4
>  #define  CTRL0_MCLK_SEL			GENMASK(2, 0)
> @@ -41,6 +50,7 @@ struct g12a_toacodec {
>  };
>  
>  struct g12a_toacodec_match_data {
> +	const struct snd_soc_component_driver *component_drv;
>  	struct reg_field field_dat_sel;
>  	struct reg_field field_lrclk_sel;
>  	struct reg_field field_bclk_sel;
> @@ -98,11 +108,20 @@ static SOC_ENUM_SINGLE_DECL(g12a_toacodec_mux_enum, TOACODEC_CTRL0,
>  			    CTRL0_DAT_SEL_LSB,
>  			    g12a_toacodec_mux_texts);
>  
> +static SOC_ENUM_SINGLE_DECL(sm1_toacodec_mux_enum, TOACODEC_CTRL0,
> +			    CTRL0_DAT_SEL_SM1_LSB,
> +			    g12a_toacodec_mux_texts);
> +
>  static const struct snd_kcontrol_new g12a_toacodec_mux =
>  	SOC_DAPM_ENUM_EXT("Source", g12a_toacodec_mux_enum,
>  			  snd_soc_dapm_get_enum_double,
>  			  g12a_toacodec_mux_put_enum);
>  
> +static const struct snd_kcontrol_new sm1_toacodec_mux =
> +	SOC_DAPM_ENUM_EXT("Source", sm1_toacodec_mux_enum,
> +			  snd_soc_dapm_get_enum_double,
> +			  g12a_toacodec_mux_put_enum);
> +
>  static const struct snd_kcontrol_new g12a_toacodec_out_enable =
>  	SOC_DAPM_SINGLE_AUTODISABLE("Switch", TOACODEC_CTRL0,
>  				    CTRL0_ENABLE_SHIFT, 1, 0);
> @@ -114,6 +133,13 @@ static const struct snd_soc_dapm_widget g12a_toacodec_widgets[] = {
>  			    &g12a_toacodec_out_enable),
>  };
>  
> +static const struct snd_soc_dapm_widget sm1_toacodec_widgets[] = {
> +	SND_SOC_DAPM_MUX("SRC", SND_SOC_NOPM, 0, 0,
> +			 &sm1_toacodec_mux),
> +	SND_SOC_DAPM_SWITCH("OUT EN", SND_SOC_NOPM, 0, 0,
> +			    &g12a_toacodec_out_enable),
> +};
> +
>  static int g12a_toacodec_input_hw_params(struct snd_pcm_substream *substream,
>  					 struct snd_pcm_hw_params *params,
>  					 struct snd_soc_dai *dai)
> @@ -184,6 +210,13 @@ static int g12a_toacodec_component_probe(struct snd_soc_component *c)
>  				       CTRL0_BLK_CAP_INV);
>  }
>  
> +static int sm1_toacodec_component_probe(struct snd_soc_component *c)
> +{
> +	/* Initialize the static clock parameters */
> +	return snd_soc_component_write(c, TOACODEC_CTRL0,
> +				       CTRL0_BLK_CAP_INV_SM1);
> +}
> +
>  static const struct snd_soc_dapm_route g12a_toacodec_routes[] = {
>  	{ "SRC", "I2S A", "IN A Playback" },
>  	{ "SRC", "I2S B", "IN B Playback" },
> @@ -196,6 +229,10 @@ static const struct snd_kcontrol_new g12a_toacodec_controls[] = {
>  	SOC_SINGLE("Lane Select", TOACODEC_CTRL0, CTRL0_LANE_SEL, 3, 0),
>  };
>  
> +static const struct snd_kcontrol_new sm1_toacodec_controls[] = {
> +	SOC_SINGLE("Lane Select", TOACODEC_CTRL0, CTRL0_LANE_SEL_SM1, 3, 0),
> +};
> +
>  static const struct snd_soc_component_driver g12a_toacodec_component_drv = {
>  	.probe			= g12a_toacodec_component_probe,
>  	.controls		= g12a_toacodec_controls,
> @@ -208,6 +245,18 @@ static const struct snd_soc_component_driver g12a_toacodec_component_drv = {
>  	.non_legacy_dai_naming	= 1,
>  };
>  
> +static const struct snd_soc_component_driver sm1_toacodec_component_drv = {
> +	.probe			= sm1_toacodec_component_probe,
> +	.controls		= sm1_toacodec_controls,
> +	.num_controls		= ARRAY_SIZE(sm1_toacodec_controls),
> +	.dapm_widgets		= sm1_toacodec_widgets,
> +	.num_dapm_widgets	= ARRAY_SIZE(sm1_toacodec_widgets),
> +	.dapm_routes		= g12a_toacodec_routes,
> +	.num_dapm_routes	= ARRAY_SIZE(g12a_toacodec_routes),
> +	.endianness		= 1,
> +	.non_legacy_dai_naming	= 1,
> +};
> +
>  static const struct regmap_config g12a_toacodec_regmap_cfg = {
>  	.reg_bits	= 32,
>  	.val_bits	= 32,
> @@ -215,16 +264,29 @@ static const struct regmap_config g12a_toacodec_regmap_cfg = {
>  };
>  
>  static const struct g12a_toacodec_match_data g12a_toacodec_match_data = {
> +	.component_drv	= &g12a_toacodec_component_drv,
>  	.field_dat_sel	= REG_FIELD(TOACODEC_CTRL0, CTRL0_DAT_SEL_LSB, CTRL0_DAT_SEL_MSB),
>  	.field_lrclk_sel = REG_FIELD(TOACODEC_CTRL0, CTRL0_LRCLK_SEL_LSB, CTRL0_LRCLK_SEL_MSB),
>  	.field_bclk_sel	= REG_FIELD(TOACODEC_CTRL0, CTRL0_BCLK_SEL_LSB, CTRL0_BCLK_SEL_MSB),
>  };
>  
> +static const struct g12a_toacodec_match_data sm1_toacodec_match_data = {
> +	.component_drv	= &sm1_toacodec_component_drv,
> +	.field_dat_sel	= REG_FIELD(TOACODEC_CTRL0, CTRL0_DAT_SEL_SM1_LSB, CTRL0_DAT_SEL_SM1_MSB),
> +	.field_lrclk_sel = REG_FIELD(TOACODEC_CTRL0, CTRL0_LRCLK_SEL_SM1_LSB,
> +				     CTRL0_LRCLK_SEL_SM1_MSB),
> +	.field_bclk_sel	= REG_FIELD(TOACODEC_CTRL0, CTRL0_BCLK_SEL_LSB, CTRL0_BCLK_SEL_SM1_MSB),
> +};
> +
>  static const struct of_device_id g12a_toacodec_of_match[] = {
>  	{
>  		.compatible = "amlogic,g12a-toacodec",
>  		.data = &g12a_toacodec_match_data,
>  	},
> +	{
> +		.compatible = "amlogic,sm1-toacodec",
> +		.data = &sm1_toacodec_match_data,
> +	},
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, g12a_toacodec_of_match);
> @@ -278,7 +340,7 @@ static int g12a_toacodec_probe(struct platform_device *pdev)
>  		return PTR_ERR(priv->field_bclk_sel);
>  
>  	return devm_snd_soc_register_component(dev,
> -			&g12a_toacodec_component_drv, g12a_toacodec_dai_drv,
> +			data->component_drv, g12a_toacodec_dai_drv,
>  			ARRAY_SIZE(g12a_toacodec_dai_drv));
>  }
>  
> 

Oops, spurious one, please ignore it.

Neil
