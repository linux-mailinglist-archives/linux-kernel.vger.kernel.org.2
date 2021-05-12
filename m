Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 354E037C0C0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 16:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbhELOx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 10:53:58 -0400
Received: from mga07.intel.com ([134.134.136.100]:11241 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231162AbhELOxz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 10:53:55 -0400
IronPort-SDR: BJltbjT1RMvl7Mv6aTLtmU91NkbBubwJCy+QYeRRsBInk5pyf3V/nRsqQiqgUyHOcvHC5sC7bL
 N/CjJvNQcpRw==
X-IronPort-AV: E=McAfee;i="6200,9189,9982"; a="263650806"
X-IronPort-AV: E=Sophos;i="5.82,293,1613462400"; 
   d="scan'208";a="263650806"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2021 07:52:46 -0700
IronPort-SDR: cA6Zs510rHgQ6GkS8D4I8JMdHFHQypk/xImYgpETYmwZqd5kFXM15Z5wxzVPeZQ9aidlivSjlH
 DTsE4qIgJrvA==
X-IronPort-AV: E=Sophos;i="5.82,293,1613462400"; 
   d="scan'208";a="437236918"
Received: from cwitkows-mobl.amr.corp.intel.com (HELO [10.212.100.147]) ([10.212.100.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2021 07:52:44 -0700
Subject: Re: [PATCH -next] ASoC: intel/boards: add missing MODULE_DEVICE_TABLE
To:     Zou Wei <zou_wei@huawei.com>, cezary.rojewski@intel.com,
        liam.r.girdwood@linux.intel.com, yang.jie@linux.intel.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        kuninori.morimoto.gx@renesas.com, kai.vehmanen@linux.intel.com,
        brent.lu@intel.com, ranjani.sridharan@linux.intel.com,
        yong.zhi@intel.com, dharageswari.r@intel.com,
        sathyanarayana.nujella@intel.com, fred.oh@linux.intel.com,
        tzungbi@google.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <1620791647-16024-1-git-send-email-zou_wei@huawei.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <50fa973b-aa9f-ccb4-8020-9d38a63e2c30@linux.intel.com>
Date:   Wed, 12 May 2021 08:41:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1620791647-16024-1-git-send-email-zou_wei@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/11/21 10:54 PM, Zou Wei wrote:
> This patch adds missing MODULE_DEVICE_TABLE definition which generates
> correct modalias for automatic loading of this driver when it is built
> as an external module.

I have a limited understanding of all this, but we already support the 
machine drivers as modules and things work fine.

I wonder if this MODULE_DEVICE_TABLE generates the alias automatically, 
which would make the existing ones added manually at the end of the 
files unnecessary? If that was the case, then we should remove those 
MODULE_ALIAS as well, no?

MODULE_DESCRIPTION("SOF Audio Machine driver");
MODULE_AUTHOR("Bard Liao <bard.liao@intel.com>");
MODULE_AUTHOR("Sathya Prakash M R <sathya.prakash.m.r@intel.com>");
MODULE_AUTHOR("Brent Lu <brent.lu@intel.com>");
MODULE_LICENSE("GPL v2");
MODULE_ALIAS("platform:sof_rt5682");
MODULE_ALIAS("platform:tgl_max98357a_rt5682");
MODULE_ALIAS("platform:jsl_rt5682_rt1015");
MODULE_ALIAS("platform:tgl_max98373_rt5682");
MODULE_ALIAS("platform:jsl_rt5682_max98360a");
MODULE_ALIAS("platform:cml_rt1015_rt5682");
MODULE_ALIAS("platform:tgl_rt1011_rt5682");
MODULE_ALIAS("platform:jsl_rt5682_rt1015p");

> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>
> ---
>   sound/soc/intel/boards/sof_da7219_max98373.c | 1 +
>   sound/soc/intel/boards/sof_rt5682.c          | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/sound/soc/intel/boards/sof_da7219_max98373.c b/sound/soc/intel/boards/sof_da7219_max98373.c
> index f3cb077..8d1ad89 100644
> --- a/sound/soc/intel/boards/sof_da7219_max98373.c
> +++ b/sound/soc/intel/boards/sof_da7219_max98373.c
> @@ -440,6 +440,7 @@ static const struct platform_device_id board_ids[] = {
>   	},
>   	{ }
>   };
> +MODULE_DEVICE_TABLE(platform, board_ids);
>   
>   static struct platform_driver audio = {
>   	.probe = audio_probe,
> diff --git a/sound/soc/intel/boards/sof_rt5682.c b/sound/soc/intel/boards/sof_rt5682.c
> index 58548ea..cf1d053 100644
> --- a/sound/soc/intel/boards/sof_rt5682.c
> +++ b/sound/soc/intel/boards/sof_rt5682.c
> @@ -968,6 +968,7 @@ static const struct platform_device_id board_ids[] = {
>   	},
>   	{ }
>   };
> +MODULE_DEVICE_TABLE(platform, board_ids);
>   
>   static struct platform_driver sof_audio = {
>   	.probe = sof_audio_probe,
> 
