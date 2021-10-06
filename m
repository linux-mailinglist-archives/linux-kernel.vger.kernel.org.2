Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E369424253
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 18:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238904AbhJFQPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 12:15:43 -0400
Received: from mga01.intel.com ([192.55.52.88]:10617 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230101AbhJFQPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 12:15:42 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10129"; a="249310184"
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; 
   d="scan'208";a="249310184"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2021 09:09:00 -0700
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; 
   d="scan'208";a="439169402"
Received: from nbasa-mobl2.amr.corp.intel.com (HELO [10.213.170.135]) ([10.213.170.135])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2021 09:08:59 -0700
Subject: Re: [PATCH v1 3/4] ASoC: Intel: bytcr_rt5651: use
 devm_clk_get_optional() for mclk
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
References: <20211006150451.16561-1-andriy.shevchenko@linux.intel.com>
 <20211006150451.16561-3-andriy.shevchenko@linux.intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <2d190513-7ac4-731c-7c9a-1f60a98f6345@linux.intel.com>
Date:   Wed, 6 Oct 2021 10:51:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211006150451.16561-3-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/6/21 10:04 AM, Andy Shevchenko wrote:
> The devm_clk_get_optional() helper returns NULL when devm_clk_get()
> returns -ENOENT. This makes things slightly cleaner. The added benefit
> is mostly cosmetic.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  sound/soc/intel/boards/bytcr_rt5651.c | 69 ++++++++++++---------------
>  1 file changed, 30 insertions(+), 39 deletions(-)
> 
> diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
> index 36f63516f0cb..28c561302e69 100644
> --- a/sound/soc/intel/boards/bytcr_rt5651.c
> +++ b/sound/soc/intel/boards/bytcr_rt5651.c
> @@ -188,13 +188,10 @@ static int platform_clock_control(struct snd_soc_dapm_widget *w,
>  	}
>  
>  	if (SND_SOC_DAPM_EVENT_ON(event)) {
> -		if (byt_rt5651_quirk & BYT_RT5651_MCLK_EN) {
> -			ret = clk_prepare_enable(priv->mclk);
> -			if (ret < 0) {
> -				dev_err(card->dev,
> -					"could not configure MCLK state");
> -				return ret;
> -			}
> +		ret = clk_prepare_enable(priv->mclk);
> +		if (ret < 0) {
> +			dev_err(card->dev, "could not configure MCLK state");
> +			return ret;
>  		}

I don't get why you removed the test on the BYT_RT5651_MCLK_EN quirk,
see below it was designed as a fall-back mode. We don't want to return
an error when we know the clock is not present/desired.


>  		ret = byt_rt5651_prepare_and_enable_pll1(codec_dai, 48000, 50);
>  	} else {
> @@ -207,8 +204,7 @@ static int platform_clock_control(struct snd_soc_dapm_widget *w,
>  					     48000 * 512,
>  					     SND_SOC_CLOCK_IN);
>  		if (!ret)
> -			if (byt_rt5651_quirk & BYT_RT5651_MCLK_EN)
> -				clk_disable_unprepare(priv->mclk);
> +			clk_disable_unprepare(priv->mclk);
>  	}
>  
>  	if (ret < 0) {
> @@ -629,29 +625,25 @@ static int byt_rt5651_init(struct snd_soc_pcm_runtime *runtime)
>  		return ret;
>  	}
>  
> -	if (byt_rt5651_quirk & BYT_RT5651_MCLK_EN) {
> -		/*
> -		 * The firmware might enable the clock at
> -		 * boot (this information may or may not
> -		 * be reflected in the enable clock register).
> -		 * To change the rate we must disable the clock
> -		 * first to cover these cases. Due to common
> -		 * clock framework restrictions that do not allow
> -		 * to disable a clock that has not been enabled,
> -		 * we need to enable the clock first.
> -		 */
> -		ret = clk_prepare_enable(priv->mclk);
> -		if (!ret)
> -			clk_disable_unprepare(priv->mclk);
> +	/*
> +	 * The firmware might enable the clock at boot (this information
> +	 * may or may not be reflected in the enable clock register).
> +	 * To change the rate we must disable the clock first to cover
> +	 * these cases. Due to common clock framework restrictions that
> +	 * do not allow to disable a clock that has not been enabled,
> +	 * we need to enable the clock first.
> +	 */
> +	ret = clk_prepare_enable(priv->mclk);
> +	if (!ret)
> +		clk_disable_unprepare(priv->mclk);
>  
> -		if (byt_rt5651_quirk & BYT_RT5651_MCLK_25MHZ)
> -			ret = clk_set_rate(priv->mclk, 25000000);
> -		else
> -			ret = clk_set_rate(priv->mclk, 19200000);
> +	if (byt_rt5651_quirk & BYT_RT5651_MCLK_25MHZ)
> +		ret = clk_set_rate(priv->mclk, 25000000);
> +	else
> +		ret = clk_set_rate(priv->mclk, 19200000);
>  
> -		if (ret)
> -			dev_err(card->dev, "unable to set MCLK rate\n");
> -	}
> +	if (ret)
> +		dev_err(card->dev, "unable to set MCLK rate\n");

same here, why was the quirk removed?

>  
>  	report = 0;
>  	if (BYT_RT5651_JDSRC(byt_rt5651_quirk))
> @@ -1064,21 +1056,20 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
>  		byt_rt5651_dais[dai_index].cpus->dai_name = "ssp0-port";
>  
>  	if (byt_rt5651_quirk & BYT_RT5651_MCLK_EN) {
> -		priv->mclk = devm_clk_get(dev, "pmc_plt_clk_3");
> +		priv->mclk = devm_clk_get_optional(dev, "pmc_plt_clk_3");
>  		if (IS_ERR(priv->mclk)) {
>  			ret_val = PTR_ERR(priv->mclk);
>  			dev_err(dev,
>  				"Failed to get MCLK from pmc_plt_clk_3: %d\n",
>  				ret_val);
> -			/*
> -			 * Fall back to bit clock usage for -ENOENT (clock not
> -			 * available likely due to missing dependencies), bail
> -			 * for all other errors, including -EPROBE_DEFER
> -			 */
> -			if (ret_val != -ENOENT)
> -				goto err;
> -			byt_rt5651_quirk &= ~BYT_RT5651_MCLK_EN;
> +			goto err;
>  		}
> +		/*
> +		 * Fall back to bit clock usage when clock is not
> +		 * available likely due to missing dependencies.
> +		 */
> +		if (!priv->mclk)
> +			byt_rt5651_quirk &= ~BYT_RT5651_MCLK_EN;

that part in the probe looks fine, but the changes above are controversial.

>  	}
>  
>  	snprintf(byt_rt5651_components, sizeof(byt_rt5651_components),
> 
