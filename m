Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73F0535A2F3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 18:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234017AbhDIQW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 12:22:57 -0400
Received: from mga03.intel.com ([134.134.136.65]:50719 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232395AbhDIQWq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 12:22:46 -0400
IronPort-SDR: bc3yPWVyjWhkT6GfB1XhFLvZSIj70qUok42XmoAca9XvDmade0mLtP/SuI99x8fTigf6Y/OtsM
 fQKhZAYMAR8g==
X-IronPort-AV: E=McAfee;i="6000,8403,9949"; a="193834951"
X-IronPort-AV: E=Sophos;i="5.82,209,1613462400"; 
   d="scan'208";a="193834951"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2021 09:22:32 -0700
IronPort-SDR: VaQNFTTlcncnSAeVCU4i7GQ4isH2oSsQWCJ8+4m2g35L4aaY6wP5VRPb3AEEXzkj49/rHGB66D
 F0UWNVjupBwA==
X-IronPort-AV: E=Sophos;i="5.82,209,1613462400"; 
   d="scan'208";a="380705479"
Received: from ravikira-mobl1.amr.corp.intel.com (HELO [10.212.11.141]) ([10.212.11.141])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2021 09:22:31 -0700
Subject: Re: [PATCH] ASoC: Intel: bytcr_wm5102: remove useless variable
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        cezary.rojewski@intel.com
Cc:     liam.r.girdwood@linux.intel.com, yang.jie@linux.intel.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <1617948506-84638-1-git-send-email-jiapeng.chong@linux.alibaba.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <ec10b000-34da-b4e8-8fa4-abb366557646@linux.intel.com>
Date:   Fri, 9 Apr 2021 10:37:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <1617948506-84638-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/9/21 1:08 AM, Jiapeng Chong wrote:
> Fix the following gcc warning:
> 
> sound/soc/intel/boards/bytcr_wm5102.c:216:40: warning:
> ‘byt_wm5102_dai_params’ defined but not used.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Thanks for the patch.

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>   sound/soc/intel/boards/bytcr_wm5102.c | 8 --------
>   1 file changed, 8 deletions(-)
> 
> diff --git a/sound/soc/intel/boards/bytcr_wm5102.c b/sound/soc/intel/boards/bytcr_wm5102.c
> index f38850e..fd584e3 100644
> --- a/sound/soc/intel/boards/bytcr_wm5102.c
> +++ b/sound/soc/intel/boards/bytcr_wm5102.c
> @@ -213,14 +213,6 @@ static int byt_wm5102_init(struct snd_soc_pcm_runtime *runtime)
>   	return 0;
>   }
>   
> -static const struct snd_soc_pcm_stream byt_wm5102_dai_params = {
> -	.formats = SNDRV_PCM_FMTBIT_S16_LE,
> -	.rate_min = 48000,
> -	.rate_max = 48000,
> -	.channels_min = 2,
> -	.channels_max = 2,
> -};
> -
>   static int byt_wm5102_codec_fixup(struct snd_soc_pcm_runtime *rtd,
>   				  struct snd_pcm_hw_params *params)
>   {
> 
