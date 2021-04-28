Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0375D36DB6F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239061AbhD1PSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:18:24 -0400
Received: from mga14.intel.com ([192.55.52.115]:16742 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229805AbhD1PSY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:18:24 -0400
IronPort-SDR: mUpYq0N7Qel4RlQno1R4W0TCNezC9vVNZIaTy8FTQjfwI6w5JyKWVWP0yNQDg1p8RrF5MT1RBQ
 vzi92VNWU0hg==
X-IronPort-AV: E=McAfee;i="6200,9189,9968"; a="196318619"
X-IronPort-AV: E=Sophos;i="5.82,258,1613462400"; 
   d="scan'208";a="196318619"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2021 08:17:38 -0700
IronPort-SDR: v7aXp3XAG64N5KnxOone90boPMhRuHAx6C1pPUPFr8uHerT0fLoM1+VX/WGeRvFfVJTSiCoxZ6
 mHbc9/4mFgCw==
X-IronPort-AV: E=Sophos;i="5.82,258,1613462400"; 
   d="scan'208";a="619348552"
Received: from sachanta-mobl.amr.corp.intel.com (HELO [10.209.170.35]) ([10.209.170.35])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2021 08:17:37 -0700
Subject: Re: [PATCH 2/2] ASoC: da7219: do not request a new clock consummer
 reference
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Stephen Boyd <sboyd@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20210428122632.46244-1-jbrunet@baylibre.com>
 <20210428122632.46244-3-jbrunet@baylibre.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <ddf546e9-e160-d865-0a49-a25a1ea4ca96@linux.intel.com>
Date:   Wed, 28 Apr 2021 10:17:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210428122632.46244-3-jbrunet@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/28/21 7:26 AM, Jerome Brunet wrote:
> This reverts commit 12f8127fe9e6154dd4197df97e44f3fd67583071.
> 
> There is problem with clk_hw_get_hw(). Using it pins the clock provider to
> itself, making it impossible to remove the module.
> 
> Revert commit 12f8127fe9e6 ("ASoC: da7219: properly get clk from the
> provider") until this gets sorted out.
> 
> Reported-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

I added this patch in the SOF tree and the CI results are back to 
normal: https://sof-ci.01.org/linuxpr/PR2879/build5689/devicetest/

Tested-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Thanks Jerome, this was a surprising/hard-to-detect side effect.

> ---
>   sound/soc/codecs/da7219.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
> index bd3c523a8617..13009d08b09a 100644
> --- a/sound/soc/codecs/da7219.c
> +++ b/sound/soc/codecs/da7219.c
> @@ -2181,10 +2181,7 @@ static int da7219_register_dai_clks(struct snd_soc_component *component)
>   				 ret);
>   			goto err;
>   		}
> -
> -		da7219->dai_clks[i] = devm_clk_hw_get_clk(dev, dai_clk_hw, NULL);
> -		if (IS_ERR(da7219->dai_clks[i]))
> -			return PTR_ERR(da7219->dai_clks[i]);
> +		da7219->dai_clks[i] = dai_clk_hw->clk;
>   
>   		/* For DT setup onecell data, otherwise create lookup */
>   		if (np) {
> 
