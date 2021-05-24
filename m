Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F24B238F264
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 19:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233586AbhEXRln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 13:41:43 -0400
Received: from mga07.intel.com ([134.134.136.100]:53274 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233583AbhEXRlj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 13:41:39 -0400
IronPort-SDR: VikIWC0O64EJEU2JonyeakULWsI3Lfmd9u09y13hKrh9sIbadXz9IqQE2Jm0si2W5uG1abIBsm
 FVHZPfoXHv9A==
X-IronPort-AV: E=McAfee;i="6200,9189,9993"; a="265888579"
X-IronPort-AV: E=Sophos;i="5.82,325,1613462400"; 
   d="scan'208";a="265888579"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2021 10:40:09 -0700
IronPort-SDR: OlsffDRvw6Ck3jliqwWLI7pWWUS5/npJ8ygggjY68fmIX9s4ZMbLsUimSKdr2EGbtrN0r0dRIR
 zyiRPgKH5g0w==
X-IronPort-AV: E=Sophos;i="5.82,325,1613462400"; 
   d="scan'208";a="632710287"
Received: from cagalind-mobl2.amr.corp.intel.com (HELO [10.213.163.143]) ([10.213.163.143])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2021 10:40:08 -0700
Subject: Re: [PATCH] ASoC: Intel: boards: Select SND_SOC_HDAC_HDMI for
 Soundwire machine driver
To:     Richard Fitzgerald <rf@opensource.cirrus.com>, broonie@kernel.org,
        cezary.rojewski@intel.com, liam.r.girdwood@linux.intel.com,
        yang.jie@linux.intel.com,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
References: <20210520163324.19046-1-rf@opensource.cirrus.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <9ed54875-fe77-f70f-9085-0f3b4c9d576e@linux.intel.com>
Date:   Mon, 24 May 2021 11:32:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210520163324.19046-1-rf@opensource.cirrus.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/20/21 11:33 AM, Richard Fitzgerald wrote:
> Add select of SND_SOC_HDAC_HDMI for SND_SOC_INTEL_SOUNDWIRE_SOF_MACH.
> Without this the build results in missing references to
> hdac_hdmi_jack_port_init and hdac_hdmi_jack_init.

Kai, can you comment on this one? There is nothing specific to HDMI in 
this driver.

all the machine driver entries are now protected with a
	depends on SND_HDA_CODEC_HDMI && SND_SOC_SOF_HDA_AUDIO_CODEC

but some entries have the select SND_SOC_HDAC_HDMI, others don't.

Something's inconsistent here, it's not limited to SoundWire I am afraid


> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---
>   sound/soc/intel/boards/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/sound/soc/intel/boards/Kconfig b/sound/soc/intel/boards/Kconfig
> index eef5f4ac87c5..6a1639b14b67 100644
> --- a/sound/soc/intel/boards/Kconfig
> +++ b/sound/soc/intel/boards/Kconfig
> @@ -601,6 +601,7 @@ config SND_SOC_INTEL_SOUNDWIRE_SOF_MACH
>   	select SND_SOC_DMIC
>   	select SND_SOC_INTEL_HDA_DSP_COMMON
>   	select SND_SOC_INTEL_SOF_MAXIM_COMMON
> +	select SND_SOC_HDAC_HDMI
>   	help
>   	  Add support for Intel SoundWire-based platforms connected to
>   	  MAX98373, RT700, RT711, RT1308 and RT715
> 
