Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22B72332E60
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 19:37:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbhCIShI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 13:37:08 -0500
Received: from mga14.intel.com ([192.55.52.115]:26942 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230425AbhCISgf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 13:36:35 -0500
IronPort-SDR: SQSXEmnj6I84Im0AgupESx+pgJDAVTCL4ymsmrt9sRb1BS1blwY407V4ha7V2cd2vDOqREhkDF
 wnhwBckhfFdA==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="187663117"
X-IronPort-AV: E=Sophos;i="5.81,236,1610438400"; 
   d="scan'208";a="187663117"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2021 10:36:31 -0800
IronPort-SDR: kr+VeUdpNy+cFy6d7E55hbJQY+csJAzJdSCTe8rz9Cmo4X4VSrfdC7HbcYZVo1MzRUKlkUVlAk
 p3mTwOSIf54A==
X-IronPort-AV: E=Sophos;i="5.81,236,1610438400"; 
   d="scan'208";a="437735766"
Received: from ankitama-mobl1.amr.corp.intel.com (HELO [10.209.121.187]) ([10.209.121.187])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2021 10:36:29 -0800
Subject: Re: [PATCH] ASoC: amd: add support for rt5682 codec in machine driver
To:     Vijendar Mukunda <Vijendar.Mukunda@amd.com>, broonie@kernel.org,
        alsa-devel@alsa-project.org
Cc:     Alexander.Deucher@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
References: <1615301217-4556-1-git-send-email-Vijendar.Mukunda@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <e8c08384-93be-ee88-80b2-381f154bfa19@linux.intel.com>
Date:   Tue, 9 Mar 2021 12:36:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1615301217-4556-1-git-send-email-Vijendar.Mukunda@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> +++ b/sound/soc/amd/Kconfig
> @@ -5,14 +5,15 @@ config SND_SOC_AMD_ACP
>   	 This option enables ACP DMA support on AMD platform.
>   
>   config SND_SOC_AMD_CZ_DA7219MX98357_MACH
> -	tristate "AMD CZ support for DA7219 and MAX9835"
> +	tristate "AMD CZ support for DA7219, RT5682 and MAX9835"
>   	select SND_SOC_DA7219
> +	select SND_SOC_RT5682

select SND_SOC_RT5682_I2C

>   	select SND_SOC_MAX98357A
>   	select SND_SOC_ADAU7002
>   	select REGULATOR
>   	depends on SND_SOC_AMD_ACP && I2C && GPIOLIB
>   	help
> -	 This option enables machine driver for DA7219 and MAX9835.
> +	 This option enables machine driver for DA7219, RT5682 and MAX9835.
>   
>   config SND_SOC_AMD_CZ_RT5645_MACH
>   	tristate "AMD CZ support for RT5645"
> diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
> index 849288d..ff2b639 100644
> --- a/sound/soc/amd/acp-da7219-max98357a.c
> +++ b/sound/soc/amd/acp-da7219-max98357a.c
> @@ -1,7 +1,7 @@
>   /*
>    * Machine driver for AMD ACP Audio engine using DA7219 & MAX98357 codec
>    *
> - * Copyright 2017 Advanced Micro Devices, Inc.
> + * Copyright 2017-2021 Advanced Micro Devices, Inc.
>    *
>    * Permission is hereby granted, free of charge, to any person obtaining a
>    * copy of this software and associated documentation files (the "Software"),

convert to SPDX?

> @@ -41,14 +41,19 @@
>   #include "acp.h"
>   #include "../codecs/da7219.h"
>   #include "../codecs/da7219-aad.h"
> +#include "../codecs/rt5682.h"
>   
>   #define CZ_PLAT_CLK 48000000
>   #define DUAL_CHANNEL		2
> +#define RT5682_PLL_FREQ (48000 * 512)
>   
>   static struct snd_soc_jack cz_jack;
>   static struct clk *da7219_dai_wclk;
>   static struct clk *da7219_dai_bclk;
> -extern bool bt_uart_enable;
> +static struct clk *rt5682_dai_wclk;
> +static struct clk *rt5682_dai_bclk;
> +extern int bt_uart_enable;
> +void *soc_is_rltk_max(struct device *dev);
>   
>   static int cz_da7219_init(struct snd_soc_pcm_runtime *rtd)
>   {
> @@ -128,6 +133,88 @@ static void da7219_clk_disable(void)
>   	clk_disable_unprepare(da7219_dai_bclk);
>   }
>   
> +static int cz_rt5682_init(struct snd_soc_pcm_runtime *rtd)
> +{
> +	int ret;
> +	struct snd_soc_card *card = rtd->card;
> +	struct snd_soc_dai *codec_dai = asoc_rtd_to_codec(rtd, 0);
> +	struct snd_soc_component *component = codec_dai->component;
> +
> +	dev_info(codec_dai->dev, "codec dai name = %s\n", codec_dai->name);
> +
> +	/* Set codec sysclk */
> +	ret = snd_soc_dai_set_sysclk(codec_dai, RT5682_SCLK_S_PLL2,
> +				     RT5682_PLL_FREQ, SND_SOC_CLOCK_IN);
> +	if (ret < 0) {
> +		dev_err(codec_dai->dev,
> +			"Failed to set rt5682 SYSCLK: %d\n", ret);
> +		return ret;
> +	}
> +	/* set codec PLL */
> +	ret = snd_soc_dai_set_pll(codec_dai, RT5682_PLL2, RT5682_PLL2_S_MCLK,
> +				  CZ_PLAT_CLK, RT5682_PLL_FREQ);
> +	if (ret < 0) {
> +		dev_err(codec_dai->dev, "can't set rt5682 PLL: %d\n", ret);
> +		return ret;
> +	}
> +
> +	rt5682_dai_wclk = devm_clk_get(component->dev, "rt5682-dai-wclk");
> +	if (IS_ERR(rt5682_dai_wclk))
> +		return PTR_ERR(rt5682_dai_wclk);
> +
> +	rt5682_dai_bclk = devm_clk_get(component->dev, "rt5682-dai-bclk");
> +	if (IS_ERR(rt5682_dai_bclk))
> +		return PTR_ERR(rt5682_dai_bclk);
> +
> +	ret = snd_soc_card_jack_new(card, "Headset Jack",
> +				    SND_JACK_HEADSET | SND_JACK_LINEOUT |
> +				    SND_JACK_BTN_0 | SND_JACK_BTN_1 |
> +				    SND_JACK_BTN_2 | SND_JACK_BTN_3,
> +				    &cz_jack, NULL, 0);
> +	if (ret) {
> +		dev_err(card->dev, "HP jack creation failed %d\n", ret);
> +		return ret;
> +	}
> +
> +	snd_jack_set_key(cz_jack.jack, SND_JACK_BTN_0, KEY_PLAYPAUSE);
> +	snd_jack_set_key(cz_jack.jack, SND_JACK_BTN_1, KEY_VOLUMEUP);
> +	snd_jack_set_key(cz_jack.jack, SND_JACK_BTN_2, KEY_VOLUMEDOWN);
> +	snd_jack_set_key(cz_jack.jack, SND_JACK_BTN_3, KEY_VOICECOMMAND);
> +
> +	ret = snd_soc_component_set_jack(component, &cz_jack, NULL);
> +	if (ret) {
> +		dev_err(rtd->dev, "Headset Jack call-back failed: %d\n", ret);
> +		return ret;
> +	}
> +	return 0;
> +}
> +
> +static int rt5682_clk_enable(struct snd_pcm_substream *substream)
> +{
> +	int ret = 0;

useless init

> +	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
> +
> +	/*
> +	 * Set wclk to 48000 because the rate constraint of this driver is
> +	 * 48000. ADAU7002 spec: "The ADAU7002 requires a BCLK rate that is
> +	 * minimum of 64x the LRCLK sample rate." DA7219 is the only clk
> +	 * source so for all codecs we have to limit bclk to 64X lrclk.

copy doesn't seem correct, this isn't about DA7219

> +	 */
> +	clk_set_rate(rt5682_dai_wclk, 48000);
> +	clk_set_rate(rt5682_dai_bclk, 48000 * 64);
> +	ret = clk_prepare_enable(rt5682_dai_bclk);
> +	if (ret < 0) {
> +		dev_err(rtd->dev, "can't enable master clock %d\n", ret);
> +		return ret;
> +	}
> +	return ret;
> +}
> +

