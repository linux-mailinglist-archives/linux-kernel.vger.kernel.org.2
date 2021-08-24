Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B98E83F5FA7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 16:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237566AbhHXOAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 10:00:40 -0400
Received: from mga06.intel.com ([134.134.136.31]:64109 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237503AbhHXOAh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 10:00:37 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10085"; a="278326142"
X-IronPort-AV: E=Sophos;i="5.84,347,1620716400"; 
   d="scan'208";a="278326142"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2021 06:59:53 -0700
X-IronPort-AV: E=Sophos;i="5.84,347,1620716400"; 
   d="scan'208";a="535814629"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.213.4.79]) ([10.213.4.79])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2021 06:59:48 -0700
Subject: Re: [PATCH] [v2] ASoC: Intel: sof_rt5682: Add support for max98390
 speaker amp
To:     Mark Hsieh <mark_hsieh@wistron.corp-partner.google.com>,
        alsa-devel@alsa-project.org
Cc:     kai.vehmanen@linux.intel.com, pierre-louis.bossart@linux.intel.com,
        mac.chiang@intel.com, lance.hou@intel.com, broonie@kernel.org,
        brent.lu@intel.com, bard.liao@intel.com,
        liam.r.girdwood@linux.intel.com, yang.jie@linux.intel.com,
        perex@perex.cz, linux-kernel@vger.kernel.org,
        mark_hsieh@wistron.com
References: <20210824132109.1392-1-mark_hsieh@wistron.corp-partner.google.com>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <a2cb1661-328f-81ac-813b-7629a28ed766@intel.com>
Date:   Tue, 24 Aug 2021 15:59:44 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210824132109.1392-1-mark_hsieh@wistron.corp-partner.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-24 3:21 PM, Mark Hsieh wrote:
> Configure adl_max98390_rt5682 to support the rt5682 headset codec and max98390 speaker
> 

Unsure if line-length for commit messages has been extended to 100 as it 
was the case for code parts but this line certainly exceeds default.

> BUG=b:191811888
> TEST=emerge-brya chromeos-kernel-5_10
> 

Are these two tags meaningful for upstream kernel?

> Signed-off-by: Mark Hsieh <mark_hsieh@wistron.corp-partner.google.com>
> ---
>   sound/soc/intel/boards/Kconfig                |  1 +
>   sound/soc/intel/boards/sof_maxim_common.c     | 59 +++++++++++++++++++
>   sound/soc/intel/boards/sof_maxim_common.h     | 12 ++++
>   sound/soc/intel/boards/sof_rt5682.c           | 20 ++++++-
>   .../intel/common/soc-acpi-intel-adl-match.c   | 13 ++++
>   5 files changed, 104 insertions(+), 1 deletion(-)
> 

...

> +static int max_98390_hw_params(struct snd_pcm_substream *substream,
> +			       struct snd_pcm_hw_params *params)
> +{
> +	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
> +	struct snd_soc_dai *codec_dai;
> +	int j;

We usually start from 'i' when it comes to choosing iteration-variable 
names.

> +
> +	for_each_rtd_codec_dais(rtd, j, codec_dai) {
> +		if (!strcmp(codec_dai->component->name, MAX_98390_DEV0_NAME)) {
> +			/* DEV0 tdm slot configuration */
> +			snd_soc_dai_set_tdm_slot(codec_dai, 0x03, 3, 2, 16);
> +		}

Suggesting to move comment one line up as you ideally want to explain 
the reasoning behind if-statement, not the actual execution statement.

Once that is done, both parenthesis can be dropped.

> +		if (!strcmp(codec_dai->component->name, MAX_98390_DEV1_NAME)) {
> +			/* DEV1 tdm slot configuration */
> +			snd_soc_dai_set_tdm_slot(codec_dai, 0x0C, 3, 2, 16);
> +		}

Same applies here.

> +	}
> +	return 0;
> +}
> +

...

> diff --git a/sound/soc/intel/boards/sof_rt5682.c b/sound/soc/intel/boards/sof_rt5682.c
> index 39217223d50c..dc4966056b7d 100644
> --- a/sound/soc/intel/boards/sof_rt5682.c
> +++ b/sound/soc/intel/boards/sof_rt5682.c
> @@ -49,6 +49,7 @@
>   #define SOF_RT1015P_SPEAKER_AMP_PRESENT		BIT(16)
>   #define SOF_MAX98373_SPEAKER_AMP_PRESENT	BIT(17)
>   #define SOF_MAX98360A_SPEAKER_AMP_PRESENT	BIT(18)
> +#define SOF_MAX98390_SPEAKER_AMP_PRESENT	BIT(23)
>   
>   /* BT audio offload: reserve 3 bits for future */
>   #define SOF_BT_OFFLOAD_SSP_SHIFT		19
> @@ -781,6 +782,13 @@ static struct snd_soc_dai_link *sof_card_dai_links_create(struct device *dev,
>   		} else if (sof_rt5682_quirk &
>   				SOF_RT1011_SPEAKER_AMP_PRESENT) {
>   			sof_rt1011_dai_link(&links[id]);
> +		} else if (sof_rt5682_quirk &
> +				SOF_MAX98390_SPEAKER_AMP_PRESENT) {

Pretty sure this two lines could be combined - does not exceed 
100character limit.

> +			links[id].codecs = max_98390_components;
> +			links[id].num_codecs = ARRAY_SIZE(max_98390_components);
> +			links[id].init = max_98373_spk_codec_init;
> +			links[id].ops = &max_98390_ops;
> +			links[id].dpcm_capture = 1;
>   		} else {
>   			max_98357a_dai_link(&links[id]);
>   		}
> @@ -917,7 +925,8 @@ static int sof_audio_probe(struct platform_device *pdev)
>   		sof_rt1011_codec_conf(&sof_audio_card_rt5682);
>   	else if (sof_rt5682_quirk & SOF_RT1015P_SPEAKER_AMP_PRESENT)
>   		sof_rt1015p_codec_conf(&sof_audio_card_rt5682);
> -
> +	else if (sof_rt5682_quirk & SOF_MAX98390_SPEAKER_AMP_PRESENT)
> +		max_98390_set_codec_conf(&sof_audio_card_rt5682);
>   	if (sof_rt5682_quirk & SOF_SSP_BT_OFFLOAD_PRESENT)
>   		sof_audio_card_rt5682.num_links++;

Please keep the newline between these two conditional blocks. A new 
if-statement usually translates to new thought and it is good to 
separate those.

>   
> @@ -1043,6 +1052,15 @@ static const struct platform_device_id board_ids[] = {
>   					SOF_RT5682_SSP_AMP(2) |
>   					SOF_RT5682_NUM_HDMIDEV(4)),
>   	},
> +	{
> +		.name = "adl_max98390_rt5682",
> +		.driver_data = (kernel_ulong_t)(SOF_RT5682_MCLK_EN |
> +					SOF_RT5682_SSP_CODEC(0) |
> +					SOF_SPEAKER_AMP_PRESENT |
> +					SOF_MAX98390_SPEAKER_AMP_PRESENT |
> +					SOF_RT5682_SSP_AMP(2) |
> +					SOF_RT5682_NUM_HDMIDEV(4)),
> +	},

This indentation seems off. Though it seems the same applies for the 
rest of the array..

>   	{ }
>   };
>   MODULE_DEVICE_TABLE(platform, board_ids);
> diff --git a/sound/soc/intel/common/soc-acpi-intel-adl-match.c b/sound/soc/intel/common/soc-acpi-intel-adl-match.c
> index a0f6a69c7038..2db152998e4a 100644
> --- a/sound/soc/intel/common/soc-acpi-intel-adl-match.c
> +++ b/sound/soc/intel/common/soc-acpi-intel-adl-match.c
> @@ -280,6 +280,11 @@ static const struct snd_soc_acpi_codecs adl_max98357a_amp = {
>   	.codecs = {"MX98357A"}
>   };
>   
> +static const struct snd_soc_acpi_codecs adl_max98390_amp = {
> +	.num_codecs = 1,
> +	.codecs = {"MX98390"}

For 'forward compatibility' with possible changes to struct 
snd_soc_acpi_codecs, I'd advise appending comma at the end of the line.

> +};
> +

Regards,
Czarek
