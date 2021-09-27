Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3A24196C6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 16:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234865AbhI0O4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 10:56:25 -0400
Received: from mga07.intel.com ([134.134.136.100]:33287 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234782AbhI0O4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 10:56:24 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10120"; a="288150364"
X-IronPort-AV: E=Sophos;i="5.85,326,1624345200"; 
   d="scan'208";a="288150364"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2021 07:54:46 -0700
X-IronPort-AV: E=Sophos;i="5.85,326,1624345200"; 
   d="scan'208";a="486172557"
Received: from asen4-mobl2.amr.corp.intel.com (HELO [10.212.27.2]) ([10.212.27.2])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2021 07:54:45 -0700
Subject: Re: [PATCH] ASoC: max98373: Mark cache dirty before entering sleep
To:     Ryan Lee <ryans.lee@maximintegrated.com>, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        yung-chuan.liao@linux.intel.com,
        guennadi.liakhovetski@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     sathya.prakash.m.r@intel.com, ryan.lee.maxim@gmail.com
References: <20210924221305.17886-1-ryans.lee@maximintegrated.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <1b21bbf1-12c7-726d-bff8-76ec88ff8635@linux.intel.com>
Date:   Mon, 27 Sep 2021 09:54:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210924221305.17886-1-ryans.lee@maximintegrated.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/24/21 5:13 PM, Ryan Lee wrote:
> Amp lose its register values in case amp power loss or
> 'ForceReset' over Soundwire SCP_ctrl register(0x0044) or
> HW_RESET pin control during the audio suspend and resume.
> Mark cache dirty before audio suspension to restore
> existing values when audio resume.
> 
> Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
> ---
>  sound/soc/codecs/max98373-sdw.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/soc/codecs/max98373-sdw.c b/sound/soc/codecs/max98373-sdw.c
> index dc520effc61c..a7e4a6e880b0 100644
> --- a/sound/soc/codecs/max98373-sdw.c
> +++ b/sound/soc/codecs/max98373-sdw.c
> @@ -259,6 +259,7 @@ static __maybe_unused int max98373_suspend(struct device *dev)
>  		regmap_read(max98373->regmap, max98373->cache[i].reg, &max98373->cache[i].val);
>  
>  	regcache_cache_only(max98373->regmap, true);
> +	regcache_mark_dirty(max98373->regmap);

We already do the following sequence in max98373_io_init() when the
amplifier re-attaches:

	if (max98373->first_hw_init) {
		regcache_cache_bypass(max98373->regmap, false);
		regcache_mark_dirty(max98373->regmap);
	}

I don't see what marking the cache as dirty on suspend might do, we will
do a sync only in the resume step.

IIRC this is a patch that we've seen before and removed since it wasn't
aligned with any other codec driver.

Does this actually improve anything?


