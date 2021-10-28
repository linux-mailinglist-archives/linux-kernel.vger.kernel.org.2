Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A392643E2E1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 15:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbhJ1OAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 10:00:53 -0400
Received: from mga17.intel.com ([192.55.52.151]:13436 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231208AbhJ1OAt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 10:00:49 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10150"; a="211180582"
X-IronPort-AV: E=Sophos;i="5.87,190,1631602800"; 
   d="scan'208";a="211180582"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2021 06:58:05 -0700
X-IronPort-AV: E=Sophos;i="5.87,190,1631602800"; 
   d="scan'208";a="573755634"
Received: from sjsanghv-mobl.amr.corp.intel.com (HELO [10.212.61.51]) ([10.212.61.51])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2021 06:58:03 -0700
Subject: Re: [PATCH] ASoc: Intel: glk_rt5682_max98357a: support ALC5682I-VS
 codec
To:     Brent Lu <brent.lu@intel.com>, alsa-devel@alsa-project.org
Cc:     Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Rander Wang <rander.wang@intel.com>,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Olaru <paul.olaru@oss.nxp.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Julian Braha <julianbraha@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
References: <20211028060203.446093-1-brent.lu@intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <2ca92247-70c6-a092-8fe2-cfca9d6f18e6@linux.intel.com>
Date:   Thu, 28 Oct 2021 08:58:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211028060203.446093-1-brent.lu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




> @@ -592,12 +610,29 @@ static int geminilake_audio_probe(struct platform_device *pdev)
>  	struct snd_soc_acpi_mach *mach;
>  	const char *platform_name;
>  	struct snd_soc_card *card;
> -	int ret;
> +	int ret, i;
>  
>  	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
>  	if (!ctx)
>  		return -ENOMEM;
>  
> +	/* Detect the headset codec variant */
> +	if (acpi_dev_present("RTL5682", NULL, -1)) {
> +		/* ALC5682I-VS is detected */
> +		ctx->is_rt5682s = 1;
> +
> +		for (i = 0; i < glk_audio_card_rt5682_m98357a.num_links; i++) {
> +			if (strcmp(geminilake_dais[i].name, "SSP2-Codec"))
> +				continue;
> +
> +			/* update the dai link to use rt5682s codec */
> +			geminilake_dais[i].codecs = ssp2_codec_5682s;
> +			geminilake_dais[i].num_codecs = ARRAY_SIZE(ssp2_codec_5682s);
> +			break;
> +		}
> +	} else
> +		ctx->is_rt5682s = 0;
> +

nit-pick: this branch is not required, the field is already reset with
kzalloc().

>  	INIT_LIST_HEAD(&ctx->hdmi_pcm_list);
>  
>  	card = &glk_audio_card_rt5682_m98357a;
> diff --git a/sound/soc/intel/common/soc-acpi-intel-glk-match.c b/sound/soc/intel/common/soc-acpi-intel-glk-match.c
> index 32fff9389eb3..4de4add74443 100644
> --- a/sound/soc/intel/common/soc-acpi-intel-glk-match.c
> +++ b/sound/soc/intel/common/soc-acpi-intel-glk-match.c
> @@ -40,6 +40,15 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_glk_machines[] = {
>  		.sof_fw_filename = "sof-glk.ri",
>  		.sof_tplg_filename = "sof-glk-rt5682.tplg",
>  	},
> +	{
> +		.id = "RTL5682",
> +		.drv_name = "glk_rt5682_max98357a",
> +		.fw_filename = "intel/dsp_fw_glk.bin",

Have you actually tested with this firmware? if not, it's probably
better not to list it as an option.

> +		.machine_quirk = snd_soc_acpi_codec_list,
> +		.quirk_data = &glk_codecs,
> +		.sof_fw_filename = "sof-glk.ri",
> +		.sof_tplg_filename = "sof-glk-rt5682.tplg",
> +	},
>  	{
>  		.id = "10134242",
>  		.drv_name = "glk_cs4242_mx98357a",
> 
