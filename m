Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 672733FFCF3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 11:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348755AbhICJVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 05:21:24 -0400
Received: from mga07.intel.com ([134.134.136.100]:3320 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234912AbhICJVW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 05:21:22 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10095"; a="283079580"
X-IronPort-AV: E=Sophos;i="5.85,264,1624345200"; 
   d="scan'208";a="283079580"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2021 02:20:23 -0700
X-IronPort-AV: E=Sophos;i="5.85,264,1624345200"; 
   d="scan'208";a="467868530"
Received: from pstarove-mobl4.ger.corp.intel.com (HELO [10.251.212.94]) ([10.251.212.94])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2021 02:20:20 -0700
Subject: Re: [PATCH v3 1/2] ASoC: max98927: Handle reset gpio when probing i2c
To:     Alejandro <atafalla@dnyon.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>
References: <cover.1630632805.git.atafalla@dnyon.com>
 <04a18f4115539752429da55fb857834cea0944e5.1630632805.git.atafalla@dnyon.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
Message-ID: <80973391-4579-e14b-6def-ed81f367a4a5@linux.intel.com>
Date:   Fri, 3 Sep 2021 12:20:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <04a18f4115539752429da55fb857834cea0944e5.1630632805.git.atafalla@dnyon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/09/2021 04:49, Alejandro wrote:
> From: Alejandro Tafalla <atafalla@dnyon.com>
> 
> Drive the reset gpio if defined in the DTS node.
> 
> Signed-off-by: Alejandro Tafalla <atafalla@dnyon.com>
> ---
>  sound/soc/codecs/max98927.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/sound/soc/codecs/max98927.c b/sound/soc/codecs/max98927.c
> index 8b206ee77709..daf06b503433 100644
> --- a/sound/soc/codecs/max98927.c
> +++ b/sound/soc/codecs/max98927.c
> @@ -868,6 +868,7 @@ static int max98927_i2c_probe(struct i2c_client *i2c,
>  	int ret = 0, value;
>  	int reg = 0;
>  	struct max98927_priv *max98927 = NULL;
> +	struct gpio_desc *reset_gpio;
>  
>  	max98927 = devm_kzalloc(&i2c->dev,
>  		sizeof(*max98927), GFP_KERNEL);
> @@ -898,6 +899,19 @@ static int max98927_i2c_probe(struct i2c_client *i2c,
>  		return ret;
>  	}
>  
> +	reset_gpio
> +		= devm_gpiod_get_optional(&i2c->dev, "reset", GPIOD_OUT_LOW);

If this is a 'reset' pin then it's ACTIVE state is when it places the
device to _reset_.
GPIOD_OUT_LOW == Deasserted state of the GPIO line.

If the reset pin should be pulled low for reset (GPIO_ACTIVE_LOW) and
you want the device initially  in reset then you need GPIOD_OUT_HIGH,
because:
GPIOD_OUT_HIGH == Asserted state of the GPIO line.

Same goes for the gpiod_set_value_cansleep():
0 - deasserted
1 = asserted

and this all depends on how the gpio is defined in DT
(GPIO_ACTIVE_LOW/HIGH), which depends on how the documentation refers to
the pin...

reset pin:
low to keep the device in reset, high to release it from reset:
GPIO_ACTIVE_LOW
gpiod_set_value_cansleep(0) to enable
gpiod_set_value_cansleep(1) to disable


enable pin:
high to enable the part, low to disable
GPIO_ACTIVE_HIGH
gpiod_set_value_cansleep(1) to enable
gpiod_set_value_cansleep(0) to disable

In both cases
electrical 0: reset/disable
electrical 1: enable

> +	if (IS_ERR(reset_gpio)) {
> +		ret = PTR_ERR(reset_gpio);
> +		return dev_err_probe(&i2c->dev, ret, "failed to request GPIO reset pin");
> +	}
> +
> +	if (reset_gpio) {
> +		usleep_range(8000, 10000);
> +		gpiod_set_value_cansleep(reset_gpio, 1);
> +		usleep_range(1000, 5000);
> +	}
> +

You might want to put the device to reset on remove at minimum.

>  	/* Check Revision ID */
>  	ret = regmap_read(max98927->regmap,
>  		MAX98927_R01FF_REV_ID, &reg);
> 

-- 
Péter
