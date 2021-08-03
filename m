Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C63633DEF41
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 15:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236228AbhHCNsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 09:48:19 -0400
Received: from mga06.intel.com ([134.134.136.31]:29443 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236260AbhHCNsN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 09:48:13 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10064"; a="274748534"
X-IronPort-AV: E=Sophos;i="5.84,291,1620716400"; 
   d="scan'208";a="274748534"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2021 06:48:01 -0700
X-IronPort-AV: E=Sophos;i="5.84,291,1620716400"; 
   d="scan'208";a="521256861"
Received: from vmustya-mobl1.amr.corp.intel.com (HELO [10.213.171.71]) ([10.213.171.71])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2021 06:48:00 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: Intel: sof_rt5682: Add max98390 echo reference
 support
To:     Mark Hsieh <mark_hsieh@wistron.corp-partner.google.com>,
        alsa-devel@alsa-project.org
Cc:     cezary.rojewski@intel.com, kai.vehmanen@linux.intel.com,
        mac.chiang@intel.com, lance.hou@intel.com, broonie@kernel.org,
        brent.lu@intel.com, bard.liao@intel.com,
        liam.r.girdwood@linux.intel.com, yang.jie@linux.intel.com,
        perex@perex.cz, linux-kernel@vger.kernel.org,
        mark_hsieh@wistron.com
References: <20210803092013.10749-1-mark_hsieh@wistron.corp-partner.google.com>
Message-ID: <1160d111-fe9c-3a66-fab0-e11675b86169@linux.intel.com>
Date:   Tue, 3 Aug 2021 08:46:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210803092013.10749-1-mark_hsieh@wistron.corp-partner.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit subject is not really correct, it's not about echo reference
support, it's really about basic support for max98390

My main objection is that there's a rather large copy-paste from the
max98373 code, when the only change I can see is the device and dai
names, see below

> +/*
> + * Maxim MAX98390
> + */
> +
> +const struct snd_soc_dapm_route max_98390_dapm_routes[] = {
> +	/* speaker */
> +	{ "Left Spk", NULL, "Left BE_OUT" },
> +	{ "Right Spk", NULL, "Right BE_OUT" },
> +};
> +EXPORT_SYMBOL_NS(max_98390_dapm_routes, SND_SOC_INTEL_SOF_MAXIM_COMMON);
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
> +		.name = MAX_98373_DEV0_NAME,
> +		.dai_name = MAX_98390_CODEC_DAI,
> +	},
> +	{  /* For Left */
> +		.name = MAX_98373_DEV1_NAME,

you've even left two references to 98373 in this structure...

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
> +	int j;
> +
> +	for_each_rtd_codec_dais(rtd, j, codec_dai) {
> +		if (!strcmp(codec_dai->component->name, MAX_98390_DEV0_NAME)) {
> +			/* DEV0 tdm slot configuration */
> +			snd_soc_dai_set_tdm_slot(codec_dai, 0x03, 3, 8, 32);
> +		}
> +		if (!strcmp(codec_dai->component->name, MAX_98390_DEV1_NAME)) {
> +			/* DEV1 tdm slot configuration */
> +			snd_soc_dai_set_tdm_slot(codec_dai, 0x0C, 3, 8, 32);
> +		}
> +	}
> +	return 0;
> +}
> +
> +int max_98390_trigger(struct snd_pcm_substream *substream, int cmd)
> +{
> +	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
> +	struct snd_soc_dai *codec_dai;
> +	struct snd_soc_dai *cpu_dai;
> +	int j;
> +	int ret = 0;
> +
> +	/* set spk pin by playback only */
> +	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
> +		return 0;
> +
> +	cpu_dai = asoc_rtd_to_cpu(rtd, 0);
> +	for_each_rtd_codec_dais(rtd, j, codec_dai) {
> +		struct snd_soc_dapm_context *dapm =
> +				snd_soc_component_get_dapm(cpu_dai->component);
> +		char pin_name[MAX_98390_PIN_NAME];
> +
> +		snprintf(pin_name, ARRAY_SIZE(pin_name), "%s Spk",
> +			 codec_dai->component->name_prefix);
> +
> +		switch (cmd) {
> +		case SNDRV_PCM_TRIGGER_START:
> +		case SNDRV_PCM_TRIGGER_RESUME:
> +		case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> +			ret = snd_soc_dapm_enable_pin(dapm, pin_name);
> +			if (!ret)
> +				snd_soc_dapm_sync(dapm);
> +			break;
> +		case SNDRV_PCM_TRIGGER_STOP:
> +		case SNDRV_PCM_TRIGGER_SUSPEND:
> +		case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
> +			ret = snd_soc_dapm_disable_pin(dapm, pin_name);
> +			if (!ret)
> +				snd_soc_dapm_sync(dapm);
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_NS(max_98390_trigger, SND_SOC_INTEL_SOF_MAXIM_COMMON);
> +
> +struct snd_soc_ops max_98390_ops = {
> +	.hw_params = max_98390_hw_params,
> +	.trigger = max_98390_trigger,
> +};
> +EXPORT_SYMBOL_NS(max_98390_ops, SND_SOC_INTEL_SOF_MAXIM_COMMON);
> +
> +int max_98390_spk_codec_init(struct snd_soc_pcm_runtime *rtd)
> +{
> +	struct snd_soc_card *card = rtd->card;
> +	int ret;
> +
> +	ret = snd_soc_dapm_add_routes(&card->dapm, max_98390_dapm_routes,
> +				      ARRAY_SIZE(max_98390_dapm_routes));
> +	if (ret)
> +		dev_err(rtd->dev, "Speaker map addition failed: %d\n", ret);
> +	return ret;
> +}
> +EXPORT_SYMBOL_NS(max_98390_spk_codec_init, SND_SOC_INTEL_SOF_MAXIM_COMMON);
> +
> +void max_98390_set_codec_conf(struct snd_soc_card *card)
> +{
> +	card->codec_conf = max_98390_codec_conf;
> +	card->num_configs = ARRAY_SIZE(max_98390_codec_conf);
> +}
> +EXPORT_SYMBOL_NS(max_98390_set_codec_conf, SND_SOC_INTEL_SOF_MAXIM_COMMON);
> +

... and until this line, I don't see much difference with 98373
>  /*
>   * Maxim MAX98357A
>   */
> diff --git a/sound/soc/intel/boards/sof_maxim_common.h b/sound/soc/intel/boards/sof_maxim_common.h
> index 2674f1e373ef..e1ad25dfb915 100644
> --- a/sound/soc/intel/boards/sof_maxim_common.h
> +++ b/sound/soc/intel/boards/sof_maxim_common.h
> @@ -24,6 +24,21 @@ int max_98373_spk_codec_init(struct snd_soc_pcm_runtime *rtd);
>  void max_98373_set_codec_conf(struct snd_soc_card *card);
>  int max_98373_trigger(struct snd_pcm_substream *substream, int cmd);
>  
> +/*
> + * Maxim MAX98390
> + */
> +#define MAX_98390_CODEC_DAI	"max98390-aif1"
> +#define MAX_98390_DEV0_NAME	"i2c-MX98390:00"
> +#define MAX_98390_DEV1_NAME	"i2c-MX98390:01"

again it really seems like this is the only difference?

> +
> +extern struct snd_soc_dai_link_component max_98390_components[2];
> +extern struct snd_soc_ops max_98390_ops;
> +extern const struct snd_soc_dapm_route max_98390_dapm_routes[];
> +
> +int max_98390_spk_codec_init(struct snd_soc_pcm_runtime *rtd);
> +void max_98390_set_codec_conf(struct snd_soc_card *card);
> +int max_98390_trigger(struct snd_pcm_substream *substream, int cmd);
> +
>  /*
>   * Maxim MAX98357A
>   */
> diff --git a/sound/soc/intel/boards/sof_rt5682.c b/sound/soc/intel/boards/sof_rt5682.c
> index 39217223d50c..ea4b8056db62 100644
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
> @@ -162,6 +163,19 @@ static const struct dmi_system_id sof_rt5682_quirk_table[] = {
>  					SOF_RT5682_SSP_AMP(2) |
>  					SOF_RT5682_NUM_HDMIDEV(4)),
>  	},
> +	{
> +		.callback = sof_rt5682_quirk_cb,
> +		.matches = {
> +			DMI_MATCH(DMI_PRODUCT_FAMILY, "Google_Brya"),
> +			DMI_MATCH(DMI_OEM_STRING, "AUDIO-MAX98390_ALC5682I_I2S"),
> +		},
> +		.driver_data = (void *)(SOF_RT5682_MCLK_EN |
> +					SOF_RT5682_SSP_CODEC(0) |
> +					SOF_SPEAKER_AMP_PRESENT |
> +					SOF_MAX98390_SPEAKER_AMP_PRESENT |
> +					SOF_RT5682_SSP_AMP(2) |
> +					SOF_RT5682_NUM_HDMIDEV(4)),
> +	},

this should be in a separate patch?

>  	{}
>  };
>  
> @@ -445,6 +459,14 @@ static int sof_card_late_probe(struct snd_soc_card *card)
>  		if (err < 0)
>  			return err;
>  	}
> +	if (sof_rt5682_quirk & SOF_MAX98390_SPEAKER_AMP_PRESENT) {
> +		/* Disable Left and Right Spk pin after boot */
> +		snd_soc_dapm_disable_pin(dapm, "Left Spk");
> +		snd_soc_dapm_disable_pin(dapm, "Right Spk");
> +		err = snd_soc_dapm_sync(dapm);
> +		if (err < 0)
> +			return err;
> +	}
>  	return hdac_hdmi_jack_port_init(component, &card->dapm);
>  }
>  
> @@ -781,6 +803,13 @@ static struct snd_soc_dai_link *sof_card_dai_links_create(struct device *dev,
>  		} else if (sof_rt5682_quirk &
>  				SOF_RT1011_SPEAKER_AMP_PRESENT) {
>  			sof_rt1011_dai_link(&links[id]);
> +		} else if (sof_rt5682_quirk &
> +				SOF_MAX98390_SPEAKER_AMP_PRESENT) {
> +			links[id].codecs = max_98390_components;
> +			links[id].num_codecs = ARRAY_SIZE(max_98390_components);
> +			links[id].init = max_98390_spk_codec_init;
> +			links[id].ops = &max_98390_ops;
> +			links[id].dpcm_capture = 1;
>  		} else {
>  			max_98357a_dai_link(&links[id]);
>  		}
> @@ -917,7 +946,8 @@ static int sof_audio_probe(struct platform_device *pdev)
>  		sof_rt1011_codec_conf(&sof_audio_card_rt5682);
>  	else if (sof_rt5682_quirk & SOF_RT1015P_SPEAKER_AMP_PRESENT)
>  		sof_rt1015p_codec_conf(&sof_audio_card_rt5682);
> -
> +	else if (sof_rt5682_quirk & SOF_MAX98390_SPEAKER_AMP_PRESENT)
> +		max_98390_set_codec_conf(&sof_audio_card_rt5682);
>  	if (sof_rt5682_quirk & SOF_SSP_BT_OFFLOAD_PRESENT)
>  		sof_audio_card_rt5682.num_links++;
>  
> @@ -1043,6 +1073,17 @@ static const struct platform_device_id board_ids[] = {
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
> +					SOF_RT5682_NUM_HDMIDEV(4) |
> +					SOF_BT_OFFLOAD_SSP(2) |
> +					SOF_SSP_BT_OFFLOAD_PRESENT),

I don't get why this is different from the 'Google Brya' quirk above -
which is missing the BT_OFFLOAD information.

If this is not for the same device/configuration, we should have
different patches or a better set of comments that keeps track of the
differences.

And now that I think of it, this may be a mistake. Usually the headset
uses SSP0, the amp SSP1 and BT offload SSP2. I am pretty sure you cannot
use SSP2 for BT offload as well as the amplifier links, the
configurations are different.

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
