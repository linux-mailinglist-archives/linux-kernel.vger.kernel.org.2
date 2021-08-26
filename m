Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 768723F8DE0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 20:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232759AbhHZSdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 14:33:31 -0400
Received: from mga07.intel.com ([134.134.136.100]:15146 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230064AbhHZSda (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 14:33:30 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10088"; a="281532642"
X-IronPort-AV: E=Sophos;i="5.84,354,1620716400"; 
   d="scan'208";a="281532642"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2021 11:32:42 -0700
X-IronPort-AV: E=Sophos;i="5.84,354,1620716400"; 
   d="scan'208";a="474302955"
Received: from hjasuja-mobl.amr.corp.intel.com (HELO [10.251.134.37]) ([10.251.134.37])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2021 11:32:41 -0700
Subject: Re: [PATCH] [v3] ASoC: Intel: sof_rt5682: Add support for max98390
 speaker amp
To:     Mark Hsieh <mark_hsieh@wistron.corp-partner.google.com>,
        alsa-devel@alsa-project.org
Cc:     cezary.rojewski@intel.com, kai.vehmanen@linux.intel.com,
        mac.chiang@intel.com, lance.hou@intel.com, broonie@kernel.org,
        brent.lu@intel.com, bard.liao@intel.com,
        liam.r.girdwood@linux.intel.com, yang.jie@linux.intel.com,
        perex@perex.cz, linux-kernel@vger.kernel.org,
        mark_hsieh@wistron.com
References: <20210826103032.22262-1-mark_hsieh@wistron.corp-partner.google.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <7caa519c-edf6-2c4a-4ca4-6adb41f5985d@linux.intel.com>
Date:   Thu, 26 Aug 2021 08:06:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210826103032.22262-1-mark_hsieh@wistron.corp-partner.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/26/21 5:30 AM, Mark Hsieh wrote:
> Configure adl_max98390_rt5682 to support the rt5682 headset codec
> and max98390 speaker.
> 
> Signed-off-by: Mark Hsieh <mark_hsieh@wistron.corp-partner.google.com>

LGTM, thanks!

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>  sound/soc/intel/boards/Kconfig                |  1 +
>  sound/soc/intel/boards/sof_maxim_common.c     | 57 +++++++++++++++++++
>  sound/soc/intel/boards/sof_maxim_common.h     | 12 ++++
>  sound/soc/intel/boards/sof_rt5682.c           | 19 +++++++
>  .../intel/common/soc-acpi-intel-adl-match.c   | 13 +++++
>  5 files changed, 102 insertions(+)
> 
> diff --git a/sound/soc/intel/boards/Kconfig b/sound/soc/intel/boards/Kconfig
> index 7e29b0d911e2..0017c08c5a62 100644
> --- a/sound/soc/intel/boards/Kconfig
> +++ b/sound/soc/intel/boards/Kconfig
> @@ -470,6 +470,7 @@ config SND_SOC_INTEL_SOF_RT5682_MACH
>  	select SND_SOC_RT1015
>  	select SND_SOC_RT1015P
>  	select SND_SOC_RT5682_I2C
> +	select SND_SOC_MAX98390
>  	select SND_SOC_DMIC
>  	select SND_SOC_HDAC_HDMI
>  	select SND_SOC_INTEL_HDA_DSP_COMMON
> diff --git a/sound/soc/intel/boards/sof_maxim_common.c b/sound/soc/intel/boards/sof_maxim_common.c
> index e9c52f8b6428..a6fcf6e08996 100644
> --- a/sound/soc/intel/boards/sof_maxim_common.c
> +++ b/sound/soc/intel/boards/sof_maxim_common.c
> @@ -133,6 +133,63 @@ void max_98373_set_codec_conf(struct snd_soc_card *card)
>  }
>  EXPORT_SYMBOL_NS(max_98373_set_codec_conf, SND_SOC_INTEL_SOF_MAXIM_COMMON);
>  
> +/*
> + * Maxim MAX98390
> + */
> +
> +static struct snd_soc_codec_conf max_98390_codec_conf[] = {
> +	{
> +		.dlc = COMP_CODEC_CONF(MAX_98390_DEV0_NAME),
> +		.name_prefix = "Right",
> +	},
> +	{
> +		.dlc = COMP_CODEC_CONF(MAX_98390_DEV1_NAME),
> +		.name_prefix = "Left",
> +	},
> +};
> +
> +struct snd_soc_dai_link_component max_98390_components[] = {
> +	{  /* For Right */
> +		.name = MAX_98390_DEV0_NAME,
> +		.dai_name = MAX_98390_CODEC_DAI,
> +	},
> +	{  /* For Left */
> +		.name = MAX_98390_DEV1_NAME,
> +		.dai_name = MAX_98390_CODEC_DAI,
> +	},
> +};
> +EXPORT_SYMBOL_NS(max_98390_components, SND_SOC_INTEL_SOF_MAXIM_COMMON);
> +
> +static int max_98390_hw_params(struct snd_pcm_substream *substream,
> +			       struct snd_pcm_hw_params *params)
> +{
> +	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
> +	struct snd_soc_dai *codec_dai;
> +	int i;
> +
> +	for_each_rtd_codec_dais(rtd, i, codec_dai) {
> +		/* DEV0 tdm slot configuration */
> +		if (!strcmp(codec_dai->component->name, MAX_98390_DEV0_NAME))
> +			snd_soc_dai_set_tdm_slot(codec_dai, 0x03, 3, 2, 16);
> +		/* DEV1 tdm slot configuration */
> +		if (!strcmp(codec_dai->component->name, MAX_98390_DEV1_NAME))
> +			snd_soc_dai_set_tdm_slot(codec_dai, 0x0C, 3, 2, 16);
> +	}
> +	return 0;
> +}
> +
> +const struct snd_soc_ops max_98390_ops = {
> +	.hw_params = max_98390_hw_params,
> +};
> +EXPORT_SYMBOL_NS(max_98390_ops, SND_SOC_INTEL_SOF_MAXIM_COMMON);
> +
> +void max_98390_set_codec_conf(struct snd_soc_card *card)
> +{
> +	card->codec_conf = max_98390_codec_conf;
> +	card->num_configs = ARRAY_SIZE(max_98390_codec_conf);
> +}
> +EXPORT_SYMBOL_NS(max_98390_set_codec_conf, SND_SOC_INTEL_SOF_MAXIM_COMMON);
> +
>  /*
>   * Maxim MAX98357A
>   */
> diff --git a/sound/soc/intel/boards/sof_maxim_common.h b/sound/soc/intel/boards/sof_maxim_common.h
> index 2674f1e373ef..bad7b5303280 100644
> --- a/sound/soc/intel/boards/sof_maxim_common.h
> +++ b/sound/soc/intel/boards/sof_maxim_common.h
> @@ -24,6 +24,18 @@ int max_98373_spk_codec_init(struct snd_soc_pcm_runtime *rtd);
>  void max_98373_set_codec_conf(struct snd_soc_card *card);
>  int max_98373_trigger(struct snd_pcm_substream *substream, int cmd);
>  
> +/*
> + * Maxim MAX98390
> + */
> +#define MAX_98390_CODEC_DAI	"max98390-aif1"
> +#define MAX_98390_DEV0_NAME	"i2c-MX98390:00"
> +#define MAX_98390_DEV1_NAME	"i2c-MX98390:01"
> +
> +extern struct snd_soc_dai_link_component max_98390_components[2];
> +extern const struct snd_soc_ops max_98390_ops;
> +
> +void max_98390_set_codec_conf(struct snd_soc_card *card);
> +
>  /*
>   * Maxim MAX98357A
>   */
> diff --git a/sound/soc/intel/boards/sof_rt5682.c b/sound/soc/intel/boards/sof_rt5682.c
> index 39217223d50c..18b6ef311462 100644
> --- a/sound/soc/intel/boards/sof_rt5682.c
> +++ b/sound/soc/intel/boards/sof_rt5682.c
> @@ -49,6 +49,7 @@
>  #define SOF_RT1015P_SPEAKER_AMP_PRESENT		BIT(16)
>  #define SOF_MAX98373_SPEAKER_AMP_PRESENT	BIT(17)
>  #define SOF_MAX98360A_SPEAKER_AMP_PRESENT	BIT(18)
> +#define SOF_MAX98390_SPEAKER_AMP_PRESENT	BIT(23)
>  
>  /* BT audio offload: reserve 3 bits for future */
>  #define SOF_BT_OFFLOAD_SSP_SHIFT		19
> @@ -781,6 +782,13 @@ static struct snd_soc_dai_link *sof_card_dai_links_create(struct device *dev,
>  		} else if (sof_rt5682_quirk &
>  				SOF_RT1011_SPEAKER_AMP_PRESENT) {
>  			sof_rt1011_dai_link(&links[id]);
> +		} else if (sof_rt5682_quirk &
> +				SOF_MAX98390_SPEAKER_AMP_PRESENT) {
> +			links[id].codecs = max_98390_components;
> +			links[id].num_codecs = ARRAY_SIZE(max_98390_components);
> +			links[id].init = max_98373_spk_codec_init;
> +			links[id].ops = &max_98390_ops;
> +			links[id].dpcm_capture = 1;
>  		} else {
>  			max_98357a_dai_link(&links[id]);
>  		}
> @@ -917,6 +925,8 @@ static int sof_audio_probe(struct platform_device *pdev)
>  		sof_rt1011_codec_conf(&sof_audio_card_rt5682);
>  	else if (sof_rt5682_quirk & SOF_RT1015P_SPEAKER_AMP_PRESENT)
>  		sof_rt1015p_codec_conf(&sof_audio_card_rt5682);
> +	else if (sof_rt5682_quirk & SOF_MAX98390_SPEAKER_AMP_PRESENT)
> +		max_98390_set_codec_conf(&sof_audio_card_rt5682);
>  
>  	if (sof_rt5682_quirk & SOF_SSP_BT_OFFLOAD_PRESENT)
>  		sof_audio_card_rt5682.num_links++;
> @@ -1043,6 +1053,15 @@ static const struct platform_device_id board_ids[] = {
>  					SOF_RT5682_SSP_AMP(2) |
>  					SOF_RT5682_NUM_HDMIDEV(4)),
>  	},
> +	{
> +		.name = "adl_max98390_rt5682",
> +		.driver_data = (kernel_ulong_t)(SOF_RT5682_MCLK_EN |
> +					SOF_RT5682_SSP_CODEC(0) |
> +					SOF_SPEAKER_AMP_PRESENT |
> +					SOF_MAX98390_SPEAKER_AMP_PRESENT |
> +					SOF_RT5682_SSP_AMP(2) |
> +					SOF_RT5682_NUM_HDMIDEV(4)),
> +	},
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(platform, board_ids);
> diff --git a/sound/soc/intel/common/soc-acpi-intel-adl-match.c b/sound/soc/intel/common/soc-acpi-intel-adl-match.c
> index a0f6a69c7038..2db152998e4a 100644
> --- a/sound/soc/intel/common/soc-acpi-intel-adl-match.c
> +++ b/sound/soc/intel/common/soc-acpi-intel-adl-match.c
> @@ -280,6 +280,11 @@ static const struct snd_soc_acpi_codecs adl_max98357a_amp = {
>  	.codecs = {"MX98357A"}
>  };
>  
> +static const struct snd_soc_acpi_codecs adl_max98390_amp = {
> +	.num_codecs = 1,
> +	.codecs = {"MX98390"}
> +};
> +
>  struct snd_soc_acpi_mach snd_soc_acpi_intel_adl_machines[] = {
>  	{
>  		.id = "10EC5682",
> @@ -297,6 +302,14 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_adl_machines[] = {
>  		.sof_fw_filename = "sof-adl.ri",
>  		.sof_tplg_filename = "sof-adl-max98357a-rt5682.tplg",
>  	},
> +	{
> +		.id = "10EC5682",
> +		.drv_name = "adl_max98390_rt5682",
> +		.machine_quirk = snd_soc_acpi_codec_list,
> +		.quirk_data = &adl_max98390_amp,
> +		.sof_fw_filename = "sof-adl.ri",
> +		.sof_tplg_filename = "sof-adl-max98390-rt5682.tplg",
> +	},
>  	{},
>  };
>  EXPORT_SYMBOL_GPL(snd_soc_acpi_intel_adl_machines);
> 
