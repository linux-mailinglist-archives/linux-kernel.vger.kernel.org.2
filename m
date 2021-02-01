Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C242830B1DB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 22:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbhBAVD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 16:03:59 -0500
Received: from mga07.intel.com ([134.134.136.100]:19314 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229831AbhBAVDy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 16:03:54 -0500
IronPort-SDR: gBS0oKuU7kzKXuuNKdwBL/vJ8SJMF8mpeld13fUpppd6sglFQPloQRbJ2yKAFiGDsobiY2B+aw
 eD5DyLYenw9A==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="244835312"
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="244835312"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 13:03:07 -0800
IronPort-SDR: EeMcGpsK8a4WXBQnfF2gIr9r5pBNhA59Ldx84FRM6gZw4bgPX8N11Yn4ozZScjVCtQzoMTNkEZ
 D2ET/79A2yQA==
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="391135495"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.213.23.187]) ([10.213.23.187])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 13:03:04 -0800
Subject: Re: [PATCH] ASoC: Intel: catpt: remove unneeded semicolon
To:     Yang Li <yang.lee@linux.alibaba.com>, perex@perex.cz
Cc:     tiwai@suse.com, broonie@kernel.org, yang.jie@linux.intel.com,
        liam.r.girdwood@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <1612166481-121376-1-git-send-email-yang.lee@linux.alibaba.com>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <fb3dd21b-dde6-d9f7-e497-a443f60e7493@intel.com>
Date:   Mon, 1 Feb 2021 22:03:01 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <1612166481-121376-1-git-send-email-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-02-01 9:01 AM, Yang Li wrote:
> Eliminate the following coccicheck warning:
> ./sound/soc/intel/catpt/pcm.c:355:2-3: Unneeded semicolon
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>   sound/soc/intel/catpt/pcm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/intel/catpt/pcm.c b/sound/soc/intel/catpt/pcm.c
> index e5d54bb..88a0879 100644
> --- a/sound/soc/intel/catpt/pcm.c
> +++ b/sound/soc/intel/catpt/pcm.c
> @@ -352,7 +352,7 @@ static int catpt_dai_apply_usettings(struct snd_soc_dai *dai,
>   		break;
>   	default:
>   		return 0;
> -	};
> +	}
>   
>   	list_for_each_entry(pos, &component->card->snd_card->controls, list) {
>   		if (pos->private_data == component &&
> 

Hello Yang,

Your patch is much appreciated.

I noticed that more mistakes such as this have been made in the code. 
Could you please also update switch-statements in other parts of catpt 
(from what I've found, pcm.c has 2 occurrences while loader.c has 1)?

Regards,
Czarek
