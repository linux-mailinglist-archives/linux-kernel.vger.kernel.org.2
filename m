Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9E236B8BB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 20:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234216AbhDZSLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 14:11:25 -0400
Received: from mga06.intel.com ([134.134.136.31]:21345 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234124AbhDZSLU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 14:11:20 -0400
IronPort-SDR: AKR+MbEjSQco2u4ZB9eDB2cUu2fAA7t9oxW325zmyqHc1tCB++Yg/Tfvv9rs0QlijRL6fXpqjW
 I/MqPxFsU+Og==
X-IronPort-AV: E=McAfee;i="6200,9189,9966"; a="257685292"
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; 
   d="scan'208";a="257685292"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2021 11:10:38 -0700
IronPort-SDR: K72HWpNsFCd9TOfs43j9Odj/ZvFi2zNZSVWmmvIHxJHOmsIvAH0TBpzbK166BtHyvVtB7i/k6E
 SInRtm+FY+DA==
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; 
   d="scan'208";a="403006760"
Received: from fdubuc-mobl1.amr.corp.intel.com (HELO [10.212.41.8]) ([10.212.41.8])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2021 11:10:37 -0700
Subject: Re: [PATCH v2 5/5] ASoC: da7219: properly get clk from the provider
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Stephen Boyd <sboyd@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20210421120512.413057-1-jbrunet@baylibre.com>
 <20210421120512.413057-6-jbrunet@baylibre.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <69eaa840-ed77-fc01-2925-7e5e9998e80f@linux.intel.com>
Date:   Mon, 26 Apr 2021 13:10:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210421120512.413057-6-jbrunet@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/21/21 7:05 AM, Jerome Brunet wrote:
> Instead of using the clk embedded in the clk_hw (which is meant to go
> away), a clock provider which need to interact with its own clock should
> request clk reference through the clock provider API.
> 
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

This patch seems to introduce a regression in our modprobe/rmmod tests

https://github.com/thesofproject/linux/pull/2870

RMMOD	snd_soc_da7219
rmmod: ERROR: Module snd_soc_da7219 is in use

Reverting this patch restores the ability to remove the module.

Wondering if devm_ increases a module/device refcount somehow?

> ---
>   sound/soc/codecs/da7219.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
> index 13009d08b09a..bd3c523a8617 100644
> --- a/sound/soc/codecs/da7219.c
> +++ b/sound/soc/codecs/da7219.c
> @@ -2181,7 +2181,10 @@ static int da7219_register_dai_clks(struct snd_soc_component *component)
>   				 ret);
>   			goto err;
>   		}
> -		da7219->dai_clks[i] = dai_clk_hw->clk;
> +
> +		da7219->dai_clks[i] = devm_clk_hw_get_clk(dev, dai_clk_hw, NULL);
> +		if (IS_ERR(da7219->dai_clks[i]))
> +			return PTR_ERR(da7219->dai_clks[i]);
>   
>   		/* For DT setup onecell data, otherwise create lookup */
>   		if (np) {
> 
