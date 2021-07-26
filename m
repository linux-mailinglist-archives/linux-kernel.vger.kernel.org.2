Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC4C93D5E74
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 17:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236349AbhGZPH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 11:07:56 -0400
Received: from mga11.intel.com ([192.55.52.93]:44731 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236179AbhGZPGO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 11:06:14 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10057"; a="209151258"
X-IronPort-AV: E=Sophos;i="5.84,270,1620716400"; 
   d="scan'208";a="209151258"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2021 08:46:05 -0700
X-IronPort-AV: E=Sophos;i="5.84,270,1620716400"; 
   d="scan'208";a="455807917"
Received: from jwconner-mobl1.amr.corp.intel.com (HELO [10.209.169.36]) ([10.209.169.36])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2021 08:46:03 -0700
Subject: Re: [PATCH] ASoC: Intel: sof_da7219_mx98360a: fail to initialize
 soundcard
To:     Brent Lu <brent.lu@intel.com>, alsa-devel@alsa-project.org
Cc:     Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Paul Olaru <paul.olaru@oss.nxp.com>,
        Zou Wei <zou_wei@huawei.com>,
        Rander Wang <rander.wang@intel.com>
References: <20210726094525.5748-1-brent.lu@intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <c878f42c-5f44-0e54-785b-36988cc2fe22@linux.intel.com>
Date:   Mon, 26 Jul 2021 09:08:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210726094525.5748-1-brent.lu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/26/21 4:45 AM, Brent Lu wrote:
> The default codec for speaker amp's DAI Link is max98373 and will be
> overwritten in probe function if the board id is sof_da7219_mx98360a.
> However, the probe function does not do it because the board id is
> changed in earlier commit.
> 
> Fixes: 1cc04d195dc2 ("ASoC: Intel: sof_da7219_max98373: shrink platform_id below 20 characters")
> Signed-off-by: Brent Lu <brent.lu@intel.com>

Nice catch indeed.

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>  sound/soc/intel/boards/sof_da7219_max98373.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/intel/boards/sof_da7219_max98373.c b/sound/soc/intel/boards/sof_da7219_max98373.c
> index 896251d742fe..b7b3b0bf994a 100644
> --- a/sound/soc/intel/boards/sof_da7219_max98373.c
> +++ b/sound/soc/intel/boards/sof_da7219_max98373.c
> @@ -404,7 +404,7 @@ static int audio_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	/* By default dais[0] is configured for max98373 */
> -	if (!strcmp(pdev->name, "sof_da7219_max98360a")) {
> +	if (!strcmp(pdev->name, "sof_da7219_mx98360a")) {
>  		dais[0] = (struct snd_soc_dai_link) {
>  			.name = "SSP1-Codec",
>  			.id = 0,
> 
