Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 874E4326951
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 22:21:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbhBZVRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 16:17:11 -0500
Received: from mga06.intel.com ([134.134.136.31]:7114 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230079AbhBZVRG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 16:17:06 -0500
IronPort-SDR: B9LYK6BvnV2iOGKIxrpcwSKZl7wlvEZpJakuNlj9tJPeUNOc2uzT/Sg3lsbR5/tw+fD8EuMIDE
 CYvW3TI+KK0w==
X-IronPort-AV: E=McAfee;i="6000,8403,9907"; a="247418664"
X-IronPort-AV: E=Sophos;i="5.81,209,1610438400"; 
   d="scan'208";a="247418664"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2021 13:15:13 -0800
IronPort-SDR: XHJF39AQuMxzrmE/rm6sKjMb9x2aD/1wN7vm+ZhZBKi0T1G5BOSr3p95PH592uHBEKcd9qx6/8
 wtOYyx754PjA==
X-IronPort-AV: E=Sophos;i="5.81,209,1610438400"; 
   d="scan'208";a="432910738"
Received: from esnyder-desk.amr.corp.intel.com (HELO [10.255.230.205]) ([10.255.230.205])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2021 13:15:11 -0800
Subject: Re: [PATCH] ASoC: Intel: boards: sof-wm8804: add check for PLL
 setting
To:     Colin King <colin.king@canonical.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210226185653.1071321-1-colin.king@canonical.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <644f14f9-52b5-235d-76fa-ec35668542cd@linux.intel.com>
Date:   Fri, 26 Feb 2021 14:54:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210226185653.1071321-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/26/21 12:56 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently the return from snd_soc_dai_set_pll is not checking for
> failure, this is the only driver in the kernel that ignores this,
> so it probably should be added for sake of completeness.  Fix this
> by adding an error return check.
> 
> Addresses-Coverity: ("Unchecked return value")
> Fixes: f139546fb7d4 ("ASoC: Intel: boards: sof-wm8804: support for Hifiberry Digiplus boards")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>   sound/soc/intel/boards/sof_wm8804.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/intel/boards/sof_wm8804.c b/sound/soc/intel/boards/sof_wm8804.c
> index a46ba13e8eb0..6a181e45143d 100644
> --- a/sound/soc/intel/boards/sof_wm8804.c
> +++ b/sound/soc/intel/boards/sof_wm8804.c
> @@ -124,7 +124,11 @@ static int sof_wm8804_hw_params(struct snd_pcm_substream *substream,
>   	}
>   
>   	snd_soc_dai_set_clkdiv(codec_dai, WM8804_MCLK_DIV, mclk_div);
> -	snd_soc_dai_set_pll(codec_dai, 0, 0, sysclk, mclk_freq);
> +	ret = snd_soc_dai_set_pll(codec_dai, 0, 0, sysclk, mclk_freq);
> +	if (ret < 0) {
> +		dev_err(rtd->card->dev, "Failed to set WM8804 PLL\n");
> +		return ret;
> +	}
>   
>   	ret = snd_soc_dai_set_sysclk(codec_dai, WM8804_TX_CLKSRC_PLL,
>   				     sysclk, SND_SOC_CLOCK_OUT);
> 
