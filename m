Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05D1633D671
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 16:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237742AbhCPPFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 11:05:14 -0400
Received: from mga02.intel.com ([134.134.136.20]:36598 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237719AbhCPPEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 11:04:43 -0400
IronPort-SDR: aHv2qZalMt61IT8rfKapTKYPL3g+Z6LUMRd0DsK5IkP618hZuacNktFqYfoPWe1KH2/ENAeKAF
 7BqTcTq9gsgA==
X-IronPort-AV: E=McAfee;i="6000,8403,9924"; a="176404656"
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="176404656"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 08:04:20 -0700
IronPort-SDR: YC7LK2aFTcT6LnAtvcCc4nMk/R44atwIFuYMtUDBE2/7U66n9IXLT7mcZJrW2nA7ZFUJ9WWq5i
 SuAT3KRfPY8w==
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="601856872"
Received: from mdacha-mobl3.amr.corp.intel.com (HELO [10.212.75.21]) ([10.212.75.21])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 08:04:17 -0700
Subject: Re: [PATCH v2] ASoC: Intel: sof_rt5682: Add ALC1015Q-VB speaker amp
 support
To:     Brent Lu <brent.lu@intel.com>, alsa-devel@alsa-project.org
Cc:     Oder Chiou <oder_chiou@realtek.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Dharageswari R <dharageswari.r@intel.com>,
        Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        linux-kernel@vger.kernel.org, Jie Yang <yang.jie@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Fred Oh <fred.oh@linux.intel.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Mark Brown <broonie@kernel.org>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Libin Yang <libin.yang@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Yong Zhi <yong.zhi@intel.com>
References: <20210316094632.12360-1-brent.lu@intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <3e48f98a-247f-1784-2d72-ccd6feae1cd4@linux.intel.com>
Date:   Tue, 16 Mar 2021 10:04:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210316094632.12360-1-brent.lu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/16/21 4:46 AM, Brent Lu wrote:
> This patch adds jsl_rt5682_rt1015p which supports the RT5682 headset
> codec and ALC1015Q-VB speaker amplifier combination on JasperLake
> platform.
> 
> This driver also applies for ALC1015Q-CG running in auto-mode.
> 
> Signed-off-by: Brent Lu <brent.lu@intel.com>
> ---
>   sound/soc/intel/boards/Kconfig                |  1 +
>   sound/soc/intel/boards/sof_realtek_common.c   | 99 +++++++++++++++++++
>   sound/soc/intel/boards/sof_realtek_common.h   |  7 ++
>   sound/soc/intel/boards/sof_rt5682.c           | 19 +++-
>   .../intel/common/soc-acpi-intel-jsl-match.c   | 13 +++
>   5 files changed, 137 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/intel/boards/Kconfig b/sound/soc/intel/boards/Kconfig
> index d1d28129a32b..58379393b8e4 100644
> --- a/sound/soc/intel/boards/Kconfig
> +++ b/sound/soc/intel/boards/Kconfig
> @@ -457,6 +457,7 @@ config SND_SOC_INTEL_SOF_RT5682_MACH
>   	select SND_SOC_MAX98373_I2C
>   	select SND_SOC_RT1011
>   	select SND_SOC_RT1015
> +	select SND_SOC_RT1015P
>   	select SND_SOC_RT5682_I2C
>   	select SND_SOC_DMIC
>   	select SND_SOC_HDAC_HDMI
> diff --git a/sound/soc/intel/boards/sof_realtek_common.c b/sound/soc/intel/boards/sof_realtek_common.c
> index f3cf73c620ba..5dd0eb438aa3 100644
> --- a/sound/soc/intel/boards/sof_realtek_common.c
> +++ b/sound/soc/intel/boards/sof_realtek_common.c
> @@ -7,6 +7,7 @@
>   #include <sound/pcm.h>
>   #include <sound/pcm_params.h>
>   #include <sound/soc.h>
> +#include <sound/soc-acpi.h>
>   #include <sound/soc-dai.h>
>   #include <sound/soc-dapm.h>
>   #include <uapi/sound/asound.h>
> @@ -136,3 +137,101 @@ void sof_rt1011_codec_conf(struct snd_soc_card *card)
>   	card->codec_conf = rt1011_codec_confs;
>   	card->num_configs = ARRAY_SIZE(rt1011_codec_confs);
>   }
> +
> +/*
> + * rt1015:  i2c mode driver for ALC1015 and ALC1015Q
> + * rt1015p: auto-mode driver for ALC1015, ALC1015Q, and ALC1015Q-VB
> + */
> +static const struct snd_soc_dapm_route rt1015p_1dev_dapm_routes[] = {
> +	/* speaker */
> +	{ "Left Spk", NULL, "Speaker" },
> +	{ "Right Spk", NULL, "Speaker" },
> +};
> +
> +static const struct snd_soc_dapm_route rt1015p_2dev_dapm_routes[] = {
> +	/* speaker */
> +	{ "Left Spk", NULL, "Left Speaker" },
> +	{ "Right Spk", NULL, "Right Speaker" },
> +};

I am confused by these routes...

is this a result of using the codec confs below only when there are 2 
amps with their own enable pin?

You still have 2 amps even in the 1dev case, so I want to make sure the 
code has enough comments so that we don't lose track of the design.

The rest of the code looks fine.

> +static struct snd_soc_codec_conf rt1015p_codec_confs[] = {
> +	{
> +		.dlc = COMP_CODEC_CONF(RT1015P_DEV0_NAME),
> +		.name_prefix = "Left",
> +	},
> +	{
> +		.dlc = COMP_CODEC_CONF(RT1015P_DEV1_NAME),
> +		.name_prefix = "Right",
> +	},
> +};
> +
> +static struct snd_soc_dai_link_component rt1015p_dai_link_components[] = {
> +	{
> +		.name = RT1015P_DEV0_NAME,
> +		.dai_name = RT1015P_CODEC_DAI,
> +	},
> +	{
> +		.name = RT1015P_DEV1_NAME,
> +		.dai_name = RT1015P_CODEC_DAI,
> +	},
> +};
> +
> +static int rt1015p_get_num_codecs(void)
> +{
> +	static int dev_num;
> +
> +	if (dev_num)
> +		return dev_num;
> +
> +	if (!acpi_dev_present("RTL1015", "1", -1))
> +		dev_num = 1;
> +	else
> +		dev_num = 2;
> +
> +	return dev_num;
> +}
> +
> +static int rt1015p_hw_params(struct snd_pcm_substream *substream,
> +			     struct snd_pcm_hw_params *params)
> +{
> +	/* reserved for debugging purpose */
> +
> +	return 0;
> +}
> +
> +static const struct snd_soc_ops rt1015p_ops = {
> +	.hw_params = rt1015p_hw_params,
> +};
> +
> +static int rt1015p_init(struct snd_soc_pcm_runtime *rtd)
> +{
> +	struct snd_soc_card *card = rtd->card;
> +	int ret;
> +
> +	if (rt1015p_get_num_codecs() == 1)
> +		ret = snd_soc_dapm_add_routes(&card->dapm, rt1015p_1dev_dapm_routes,
> +					      ARRAY_SIZE(rt1015p_1dev_dapm_routes));
> +	else
> +		ret = snd_soc_dapm_add_routes(&card->dapm, rt1015p_2dev_dapm_routes,
> +					      ARRAY_SIZE(rt1015p_2dev_dapm_routes));
> +	if (ret)
> +		dev_err(rtd->dev, "Speaker map addition failed: %d\n", ret);
> +	return ret;
> +}
> +
> +void sof_rt1015p_dai_link(struct snd_soc_dai_link *link)
> +{
> +	link->codecs = rt1015p_dai_link_components;
> +	link->num_codecs = rt1015p_get_num_codecs();
> +	link->init = rt1015p_init;
> +	link->ops = &rt1015p_ops;
> +}
> +
> +void sof_rt1015p_codec_conf(struct snd_soc_card *card)
> +{
> +	if (rt1015p_get_num_codecs() == 1)
> +		return;
> +
> +	card->codec_conf = rt1015p_codec_confs;
> +	card->num_configs = ARRAY_SIZE(rt1015p_codec_confs);
> +}
> diff --git a/sound/soc/intel/boards/sof_realtek_common.h b/sound/soc/intel/boards/sof_realtek_common.h
> index 87cb3812b926..cb0b49b2855c 100644
> --- a/sound/soc/intel/boards/sof_realtek_common.h
> +++ b/sound/soc/intel/boards/sof_realtek_common.h
> @@ -21,4 +21,11 @@
>   void sof_rt1011_dai_link(struct snd_soc_dai_link *link);
>   void sof_rt1011_codec_conf(struct snd_soc_card *card);
>   
> +#define RT1015P_CODEC_DAI	"HiFi"
> +#define RT1015P_DEV0_NAME	"RTL1015:00"
> +#define RT1015P_DEV1_NAME	"RTL1015:01"
> +
> +void sof_rt1015p_dai_link(struct snd_soc_dai_link *link);
> +void sof_rt1015p_codec_conf(struct snd_soc_card *card);
> +
>   #endif /* __SOF_REALTEK_COMMON_H */
> diff --git a/sound/soc/intel/boards/sof_rt5682.c b/sound/soc/intel/boards/sof_rt5682.c
> index 55505e207bc0..f4b898c1719f 100644
> --- a/sound/soc/intel/boards/sof_rt5682.c
> +++ b/sound/soc/intel/boards/sof_rt5682.c
> @@ -45,8 +45,9 @@
>   #define SOF_RT1011_SPEAKER_AMP_PRESENT		BIT(13)
>   #define SOF_RT1015_SPEAKER_AMP_PRESENT		BIT(14)
>   #define SOF_RT1015_SPEAKER_AMP_100FS		BIT(15)
> -#define SOF_MAX98373_SPEAKER_AMP_PRESENT	BIT(16)
> -#define SOF_MAX98360A_SPEAKER_AMP_PRESENT	BIT(17)
> +#define SOF_RT1015P_SPEAKER_AMP_PRESENT		BIT(16)
> +#define SOF_MAX98373_SPEAKER_AMP_PRESENT	BIT(17)
> +#define SOF_MAX98360A_SPEAKER_AMP_PRESENT	BIT(18)
>   
>   /* Default: MCLK on, MCLK 19.2M, SSP0  */
>   static unsigned long sof_rt5682_quirk = SOF_RT5682_MCLK_EN |
> @@ -723,6 +724,8 @@ static struct snd_soc_dai_link *sof_card_dai_links_create(struct device *dev,
>   			links[id].num_codecs = ARRAY_SIZE(rt1015_components);
>   			links[id].init = speaker_codec_init_lr;
>   			links[id].ops = &sof_rt1015_ops;
> +		} else if (sof_rt5682_quirk & SOF_RT1015P_SPEAKER_AMP_PRESENT) {
> +			sof_rt1015p_dai_link(&links[id]);
>   		} else if (sof_rt5682_quirk &
>   				SOF_MAX98373_SPEAKER_AMP_PRESENT) {
>   			links[id].codecs = max_98373_components;
> @@ -851,6 +854,8 @@ static int sof_audio_probe(struct platform_device *pdev)
>   		sof_max98373_codec_conf(&sof_audio_card_rt5682);
>   	else if (sof_rt5682_quirk & SOF_RT1011_SPEAKER_AMP_PRESENT)
>   		sof_rt1011_codec_conf(&sof_audio_card_rt5682);
> +	else if (sof_rt5682_quirk & SOF_RT1015P_SPEAKER_AMP_PRESENT)
> +		sof_rt1015p_codec_conf(&sof_audio_card_rt5682);
>   
>   	dai_links = sof_card_dai_links_create(&pdev->dev, ssp_codec, ssp_amp,
>   					      dmic_be_num, hdmi_num);
> @@ -940,6 +945,15 @@ static const struct platform_device_id board_ids[] = {
>   					SOF_RT5682_SSP_AMP(1) |
>   					SOF_RT5682_NUM_HDMIDEV(4)),
>   	},
> +	{
> +		.name = "jsl_rt5682_rt1015p",
> +		.driver_data = (kernel_ulong_t)(SOF_RT5682_MCLK_EN |
> +					SOF_RT5682_MCLK_24MHZ |
> +					SOF_RT5682_SSP_CODEC(0) |
> +					SOF_SPEAKER_AMP_PRESENT |
> +					SOF_RT1015P_SPEAKER_AMP_PRESENT |
> +					SOF_RT5682_SSP_AMP(1)),
> +	},
>   	{ }
>   };
>   
> @@ -966,3 +980,4 @@ MODULE_ALIAS("platform:tgl_max98373_rt5682");
>   MODULE_ALIAS("platform:jsl_rt5682_max98360a");
>   MODULE_ALIAS("platform:cml_rt1015_rt5682");
>   MODULE_ALIAS("platform:tgl_rt1011_rt5682");
> +MODULE_ALIAS("platform:jsl_rt5682_rt1015p");
> diff --git a/sound/soc/intel/common/soc-acpi-intel-jsl-match.c b/sound/soc/intel/common/soc-acpi-intel-jsl-match.c
> index 52238db0bcb5..73fe4f89a82d 100644
> --- a/sound/soc/intel/common/soc-acpi-intel-jsl-match.c
> +++ b/sound/soc/intel/common/soc-acpi-intel-jsl-match.c
> @@ -19,6 +19,11 @@ static struct snd_soc_acpi_codecs rt1015_spk = {
>   	.codecs = {"10EC1015"}
>   };
>   
> +static struct snd_soc_acpi_codecs rt1015p_spk = {
> +	.num_codecs = 1,
> +	.codecs = {"RTL1015"}
> +};
> +
>   static struct snd_soc_acpi_codecs mx98360a_spk = {
>   	.num_codecs = 1,
>   	.codecs = {"MX98360A"}
> @@ -52,6 +57,14 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_jsl_machines[] = {
>   		.quirk_data = &rt1015_spk,
>   		.sof_tplg_filename = "sof-jsl-rt5682-rt1015.tplg",
>   	},
> +	{
> +		.id = "10EC5682",
> +		.drv_name = "jsl_rt5682_rt1015p",
> +		.sof_fw_filename = "sof-jsl.ri",
> +		.machine_quirk = snd_soc_acpi_codec_list,
> +		.quirk_data = &rt1015p_spk,
> +		.sof_tplg_filename = "sof-jsl-rt5682-rt1015.tplg",
> +	},
>   	{
>   		.id = "10EC5682",
>   		.drv_name = "jsl_rt5682_max98360a",
> 
