Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 016313DE133
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 23:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbhHBVFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 17:05:33 -0400
Received: from mga03.intel.com ([134.134.136.65]:44789 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231605AbhHBVFb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 17:05:31 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10064"; a="213565262"
X-IronPort-AV: E=Sophos;i="5.84,289,1620716400"; 
   d="scan'208";a="213565262"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2021 14:05:20 -0700
X-IronPort-AV: E=Sophos;i="5.84,289,1620716400"; 
   d="scan'208";a="501960736"
Received: from skarumur-mobl.amr.corp.intel.com (HELO [10.212.72.192]) ([10.212.72.192])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2021 14:05:18 -0700
Subject: Re: [PATCH] ASoC: Intel: boards: Fix CONFIG_SND_SOC_SDW_MOCKUP select
To:     Nathan Chancellor <nathan@kernel.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20210802190351.3201677-1-nathan@kernel.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <3929126b-b4f0-bdf5-56f5-28662c7b7b44@linux.intel.com>
Date:   Mon, 2 Aug 2021 16:05:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210802190351.3201677-1-nathan@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/2/21 2:03 PM, Nathan Chancellor wrote:
> When CONFIG_SND_SOC_INTEL_SOUNDWIRE_SOF_MACH is enabled without
> CONFIG_EXPERT, there is a Kconfig warning about unmet dependencies:
> 
> WARNING: unmet direct dependencies detected for SND_SOC_SDW_MOCKUP
>   Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] &&
> EXPERT [=n] && SOUNDWIRE [=y]
>   Selected by [y]:
>   - SND_SOC_INTEL_SOUNDWIRE_SOF_MACH [=y] && ...
> 
> Selecting a symbol does not account for dependencies so if symbol A
> selects symbol B which depends on symbol C, symbol B or its select of
> symbol A should depend on symbol C as well.
> 
> Make the CONFIG_SND_SOC_SDW_MOCKUP select in
> CONFIG_SND_SOC_INTEL_SOUNDWIRE_SOF_MACH depend on CONFIG_EXPERT as the
> help text for CONFIG_SND_SOC_SDW_MOCKUP indicates it is intended to be a
> development option.
> 
> Fixes: 0ccac3bcf356 ("ASoC: Intel: boards: sof_sdw: add SoundWire mockup codecs for tests")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
> 
> An alternative here is if CONFIG_SND_SOC_INTEL_SOUNDWIRE_SOF_MACH wants
> to unconditionally select CONFIG_SND_SOC_SDW_MOCKUP, the "depends on
> EXPERT" can be moved to the prompt (tristate "..." if EXPERT). I am
> happy to send a new patch if that is what is desired.

Thanks for the patch Nathan, I added this depends on EXPERT and forgot
about it when I updated the machine driver.

Maybe a better alternate would be

imply SND_SOC_SDW_MOCKUP

We don't necessarily want the EXPERT part to be shown in the machine
driver lists.


> 
>  sound/soc/intel/boards/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/intel/boards/Kconfig b/sound/soc/intel/boards/Kconfig
> index 046955bf717c..8284c46d7435 100644
> --- a/sound/soc/intel/boards/Kconfig
> +++ b/sound/soc/intel/boards/Kconfig
> @@ -602,7 +602,7 @@ config SND_SOC_INTEL_SOUNDWIRE_SOF_MACH
>  	select SND_SOC_DMIC
>  	select SND_SOC_INTEL_HDA_DSP_COMMON
>  	select SND_SOC_INTEL_SOF_MAXIM_COMMON
> -	select SND_SOC_SDW_MOCKUP
> +	select SND_SOC_SDW_MOCKUP if EXPERT
>  	help
>  	  Add support for Intel SoundWire-based platforms connected to
>  	  MAX98373, RT700, RT711, RT1308 and RT715
> 
> base-commit: 170c0d7460fc4aa522995ae4096b5a442f50a1fc
> 
