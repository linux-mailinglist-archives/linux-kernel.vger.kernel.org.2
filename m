Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1AA74243D9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 19:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234560AbhJFRUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 13:20:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40231 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229564AbhJFRUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 13:20:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633540705;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2PpmHn3PcyjjyynAoAMsgJjLIl1Zdj/mUP7+mmshxP8=;
        b=HgM28k8Fqtdm2P2A6OrXl8OYGxiq+I26O9aZWD9Fv4VVpYXN8QFndvQu14ZGKjjs3quJiA
        oEyInH3cRboNTqqUs/G6tckp5ggQPbZ+kq6yVG+ktCWg5ReTNNu68vKJW19RbqBNcDlZMZ
        w6q3Izv9fnSFnWx/AaO/RKvShoxVmf4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-JU9nDCgcPFuMK74UlOkDGg-1; Wed, 06 Oct 2021 13:18:24 -0400
X-MC-Unique: JU9nDCgcPFuMK74UlOkDGg-1
Received: by mail-ed1-f70.google.com with SMTP id i7-20020a50d747000000b003db0225d219so3353571edj.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 10:18:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2PpmHn3PcyjjyynAoAMsgJjLIl1Zdj/mUP7+mmshxP8=;
        b=hUtyj+wjKT+MUJqt8uPJf4jlgTTbH5fkU+tHh5bAMBXCRerJk0lwuCmzHr+qiWEvkY
         IsCukTdaKf0Dq3ZaFKPoQQeH34dyploGL7WdgOclzta58ff1DBgwIDVXJyqh2Ms0lowx
         3Tllbf0ujKZ/JNMQA/3wm01fvDdK8lEIlfmT8oOvo8fQyFZoc0hTnCB/MJlv0DOgJKJ7
         yz2/SYc7RyRsO5W3evPFobJ66LMXp8OprFQmmpYLjaoIQeu0jfi1gheL/ZjtEQUncW/0
         CS6GZVrUOEIOjWHMvq4xsxq7u3yX0cluogRL/hxXGN4favGGzCSqCqrfzHhd24bfsL/5
         MkMg==
X-Gm-Message-State: AOAM531XpnRTl5tMf8ukgvDbG+ZsxaEqniEC6CAii3r0h2hrA82sBd3g
        q8p33hTJcEUCyFCrPWxcTChloQGnj3B6oVNNbrHzAmKv1fSH2Cw7fhCQJFodXway8Y3FJrOSZxE
        Bwxs1bjqObe32EbBHGKfqRd6F
X-Received: by 2002:a17:907:a425:: with SMTP id sg37mr34568045ejc.131.1633540702859;
        Wed, 06 Oct 2021 10:18:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw1BvjDAZEMviJ4dEjLZD8gYS4yNLjwOSOq0r35Uy86+K/bHkQqHFeSH0onmswULd503o8E/w==
X-Received: by 2002:a17:907:a425:: with SMTP id sg37mr34567964ejc.131.1633540702365;
        Wed, 06 Oct 2021 10:18:22 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id r19sm10293205edt.54.2021.10.06.10.18.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Oct 2021 10:18:18 -0700 (PDT)
Subject: Re: [PATCH 3/3] ASoC: Intel: sof_rt5682: use id_alt to enumerate
 rt5682s
To:     Brent Lu <brent.lu@intel.com>, alsa-devel@alsa-project.org,
        Bard liao <yung-chuan.liao@linux.intel.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Yong Zhi <yong.zhi@intel.com>,
        Vamshi Krishna Gopal <vamshi.krishna.gopal@intel.com>,
        linux-kernel@vger.kernel.org, Rander Wang <rander.wang@intel.com>,
        Bard Liao <bard.liao@intel.com>,
        Malik_Hsu <malik_hsu@wistron.corp-partner.google.com>,
        Libin Yang <libin.yang@intel.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Paul Olaru <paul.olaru@oss.nxp.com>,
        Curtis Malainey <cujomalainey@chromium.org>,
        Mac Chiang <mac.chiang@intel.com>,
        Gongjun Song <gongjun.song@intel.com>
References: <20211006161805.938950-1-brent.lu@intel.com>
 <20211006161805.938950-4-brent.lu@intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <fdcdf447-352f-3dbc-f55d-b3bb3588dca3@redhat.com>
Date:   Wed, 6 Oct 2021 19:18:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211006161805.938950-4-brent.lu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/6/21 6:18 PM, Brent Lu wrote:
> Use the id_alt field to enumerate rt5682s headphone codec and remove
> redundant entries in tables.
> 
> Signed-off-by: Brent Lu <brent.lu@intel.com>
> ---
>  sound/soc/intel/boards/sof_rt5682.c           | 30 -----------------
>  .../intel/common/soc-acpi-intel-adl-match.c   |  8 +++++
>  .../intel/common/soc-acpi-intel-byt-match.c   |  6 ++++
>  .../intel/common/soc-acpi-intel-cht-match.c   |  6 ++++
>  .../intel/common/soc-acpi-intel-cml-match.c   |  8 +++++
>  .../intel/common/soc-acpi-intel-icl-match.c   |  6 ++++
>  .../intel/common/soc-acpi-intel-jsl-match.c   | 32 +++++--------------
>  .../intel/common/soc-acpi-intel-tgl-match.c   |  8 +++++
>  8 files changed, 50 insertions(+), 54 deletions(-)
> 
> diff --git a/sound/soc/intel/boards/sof_rt5682.c b/sound/soc/intel/boards/sof_rt5682.c
> index 9f1e5ef11b13..9819345cd84c 100644
> --- a/sound/soc/intel/boards/sof_rt5682.c
> +++ b/sound/soc/intel/boards/sof_rt5682.c
> @@ -1050,36 +1050,6 @@ static const struct platform_device_id board_ids[] = {
>  					SOF_RT5682_SSP_AMP(2) |
>  					SOF_RT5682_NUM_HDMIDEV(4)),
>  	},
> -	{
> -		.name = "jsl_rt5682s_rt1015",
> -		.driver_data = (kernel_ulong_t)(SOF_RT5682_MCLK_EN |
> -					SOF_RT5682_MCLK_24MHZ |
> -					SOF_RT5682_SSP_CODEC(0) |
> -					SOF_RT5682S_HEADPHONE_CODEC_PRESENT |
> -					SOF_SPEAKER_AMP_PRESENT |
> -					SOF_RT1015_SPEAKER_AMP_PRESENT |
> -					SOF_RT5682_SSP_AMP(1)),
> -	},
> -	{
> -		.name = "jsl_rt5682s_rt1015p",
> -		.driver_data = (kernel_ulong_t)(SOF_RT5682_MCLK_EN |
> -					SOF_RT5682_MCLK_24MHZ |
> -					SOF_RT5682_SSP_CODEC(0) |
> -					SOF_RT5682S_HEADPHONE_CODEC_PRESENT |
> -					SOF_SPEAKER_AMP_PRESENT |
> -					SOF_RT1015P_SPEAKER_AMP_PRESENT |
> -					SOF_RT5682_SSP_AMP(1)),
> -	},
> -	{
> -		.name = "jsl_rt5682s_mx98360",
> -		.driver_data = (kernel_ulong_t)(SOF_RT5682_MCLK_EN |
> -					SOF_RT5682_MCLK_24MHZ |
> -					SOF_RT5682_SSP_CODEC(0) |
> -					SOF_RT5682S_HEADPHONE_CODEC_PRESENT |
> -					SOF_SPEAKER_AMP_PRESENT |
> -					SOF_MAX98360A_SPEAKER_AMP_PRESENT |
> -					SOF_RT5682_SSP_AMP(1)),
> -	},
>  	{
>  		.name = "adl_mx98360_rt5682",
>  		.driver_data = (kernel_ulong_t)(SOF_RT5682_MCLK_EN |
> diff --git a/sound/soc/intel/common/soc-acpi-intel-adl-match.c b/sound/soc/intel/common/soc-acpi-intel-adl-match.c
> index f5b21a95d222..9478e35bed38 100644
> --- a/sound/soc/intel/common/soc-acpi-intel-adl-match.c
> +++ b/sound/soc/intel/common/soc-acpi-intel-adl-match.c
> @@ -285,9 +285,15 @@ static const struct snd_soc_acpi_codecs adl_max98360a_amp = {
>  	.codecs = {"MX98360A"}
>  };
>  
> +static struct snd_soc_acpi_codecs adl_rt5682s_hp = {
> +	.num_codecs = 1,
> +	.codecs = {"RTL5682"}
> +};
> +
>  struct snd_soc_acpi_mach snd_soc_acpi_intel_adl_machines[] = {
>  	{
>  		.id = "10EC5682",
> +		.id_alt = &adl_rt5682s_hp,
>  		.drv_name = "adl_mx98373_rt5682",
>  		.machine_quirk = snd_soc_acpi_codec_list,
>  		.quirk_data = &adl_max98373_amp,
> @@ -296,6 +302,7 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_adl_machines[] = {
>  	},
>  	{
>  		.id = "10EC5682",
> +		.id_alt = &adl_rt5682s_hp,
>  		.drv_name = "adl_mx98357_rt5682",
>  		.machine_quirk = snd_soc_acpi_codec_list,
>  		.quirk_data = &adl_max98357a_amp,
> @@ -304,6 +311,7 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_adl_machines[] = {
>  	},
>  	{
>  		.id = "10EC5682",
> +		.id_alt = &adl_rt5682s_hp,
>  		.drv_name = "adl_mx98360_rt5682",
>  		.machine_quirk = snd_soc_acpi_codec_list,
>  		.quirk_data = &adl_max98360a_amp,
> diff --git a/sound/soc/intel/common/soc-acpi-intel-byt-match.c b/sound/soc/intel/common/soc-acpi-intel-byt-match.c
> index 510a5f38b7f1..8c66223d7401 100644
> --- a/sound/soc/intel/common/soc-acpi-intel-byt-match.c
> +++ b/sound/soc/intel/common/soc-acpi-intel-byt-match.c
> @@ -120,6 +120,11 @@ static struct snd_soc_acpi_mach *byt_quirk(void *arg)
>  	}
>  }
>  
> +static struct snd_soc_acpi_codecs rt5682s_hp = {
> +	.num_codecs = 1,
> +	.codecs = {"RTL5682"}
> +};
> +
>  struct snd_soc_acpi_mach  snd_soc_acpi_intel_baytrail_machines[] = {
>  	{
>  		.id = "10EC5640",
> @@ -196,6 +201,7 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_baytrail_machines[] = {
>  	},
>  	{
>  		.id = "10EC5682",
> +		.id_alt = &rt5682s_hp,
>  		.drv_name = "sof_rt5682",
>  		.sof_fw_filename = "sof-byt.ri",
>  		.sof_tplg_filename = "sof-byt-rt5682.tplg",

So this is only useful if there actually are any BYT devices using the "RTL5682"
ACPI HID, the 100+ BYT/CHT DSDTs which I've gather over time say there aren't any.

Actually there also aren't any using the non alt "10EC5682" ACPI HID either...

Bard Liao, you added this in commit f70abd75b7c6 ("ASoC: Intel: add sof-rt5682 machine driver")
but I wonder how useful this is. I guess it may be available as (and tested on?) some dev-kit.

But I don't think there us any hardware out there in the wild using this ?





> diff --git a/sound/soc/intel/common/soc-acpi-intel-cht-match.c b/sound/soc/intel/common/soc-acpi-intel-cht-match.c
> index 227424236fd5..6e52110897e9 100644
> --- a/sound/soc/intel/common/soc-acpi-intel-cht-match.c
> +++ b/sound/soc/intel/common/soc-acpi-intel-cht-match.c
> @@ -51,6 +51,11 @@ static struct snd_soc_acpi_mach *cht_quirk(void *arg)
>  		return mach;
>  }
>  
> +static struct snd_soc_acpi_codecs rt5682s_hp = {
> +	.num_codecs = 1,
> +	.codecs = {"RTL5682"}
> +};
> +
>  /* Cherryview-based platforms: CherryTrail and Braswell */
>  struct snd_soc_acpi_mach  snd_soc_acpi_intel_cherrytrail_machines[] = {
>  	{
> @@ -153,6 +158,7 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_cherrytrail_machines[] = {
>  	},
>  	{
>  		.id = "10EC5682",
> +		.id_alt = &rt5682s_hp,
>  		.drv_name = "sof_rt5682",
>  		.sof_fw_filename = "sof-cht.ri",
>  		.sof_tplg_filename = "sof-cht-rt5682.tplg",

Same remark as for the BYT changes.

Regards,

Hans



> diff --git a/sound/soc/intel/common/soc-acpi-intel-cml-match.c b/sound/soc/intel/common/soc-acpi-intel-cml-match.c
> index b591c6fd13fd..ac93d77f47ff 100644
> --- a/sound/soc/intel/common/soc-acpi-intel-cml-match.c
> +++ b/sound/soc/intel/common/soc-acpi-intel-cml-match.c
> @@ -29,6 +29,11 @@ static struct snd_soc_acpi_codecs max98390_spk_codecs = {
>  	.codecs = {"MX98390"}
>  };
>  
> +static struct snd_soc_acpi_codecs rt5682s_hp = {
> +	.num_codecs = 1,
> +	.codecs = {"RTL5682"}
> +};
> +
>  /*
>   * The order of the three entries with .id = "10EC5682" matters
>   * here, because DSDT tables expose an ACPI HID for the MAX98357A
> @@ -45,6 +50,7 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_cml_machines[] = {
>  	},
>  	{
>  		.id = "10EC5682",
> +		.id_alt = &rt5682s_hp,
>  		.drv_name = "cml_rt1015_rt5682",
>  		.machine_quirk = snd_soc_acpi_codec_list,
>  		.quirk_data = &rt1015_spk_codecs,
> @@ -53,6 +59,7 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_cml_machines[] = {
>  	},
>  	{
>  		.id = "10EC5682",
> +		.id_alt = &rt5682s_hp,
>  		.drv_name = "sof_rt5682",
>  		.machine_quirk = snd_soc_acpi_codec_list,
>  		.quirk_data = &max98357a_spk_codecs,
> @@ -61,6 +68,7 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_cml_machines[] = {
>  	},
>  	{
>  		.id = "10EC5682",
> +		.id_alt = &rt5682s_hp,
>  		.drv_name = "sof_rt5682",
>  		.sof_fw_filename = "sof-cml.ri",
>  		.sof_tplg_filename = "sof-cml-rt5682.tplg",
> diff --git a/sound/soc/intel/common/soc-acpi-intel-icl-match.c b/sound/soc/intel/common/soc-acpi-intel-icl-match.c
> index 768ed538c4ea..14430b969e6c 100644
> --- a/sound/soc/intel/common/soc-acpi-intel-icl-match.c
> +++ b/sound/soc/intel/common/soc-acpi-intel-icl-match.c
> @@ -14,6 +14,11 @@ static struct skl_machine_pdata icl_pdata = {
>  	.use_tplg_pcm = true,
>  };
>  
> +static struct snd_soc_acpi_codecs rt5682s_hp = {
> +	.num_codecs = 1,
> +	.codecs = {"RTL5682"}
> +};
> +
>  struct snd_soc_acpi_mach snd_soc_acpi_intel_icl_machines[] = {
>  	{
>  		.id = "INT34C2",
> @@ -25,6 +30,7 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_icl_machines[] = {
>  	},
>  	{
>  		.id = "10EC5682",
> +		.id_alt = &rt5682s_hp,
>  		.drv_name = "sof_rt5682",
>  		.sof_fw_filename = "sof-icl.ri",
>  		.sof_tplg_filename = "sof-icl-rt5682.tplg",
> diff --git a/sound/soc/intel/common/soc-acpi-intel-jsl-match.c b/sound/soc/intel/common/soc-acpi-intel-jsl-match.c
> index 20fd9dcc74af..4ffd91fd6862 100644
> --- a/sound/soc/intel/common/soc-acpi-intel-jsl-match.c
> +++ b/sound/soc/intel/common/soc-acpi-intel-jsl-match.c
> @@ -29,6 +29,11 @@ static struct snd_soc_acpi_codecs mx98360a_spk = {
>  	.codecs = {"MX98360A"}
>  };
>  
> +static struct snd_soc_acpi_codecs rt5682s_hp = {
> +	.num_codecs = 1,
> +	.codecs = {"RTL5682"}
> +};
> +
>  /*
>   * When adding new entry to the snd_soc_acpi_intel_jsl_machines array,
>   * use .quirk_data member to distinguish different machine driver,
> @@ -51,6 +56,7 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_jsl_machines[] = {
>  	},
>  	{
>  		.id = "10EC5682",
> +		.id_alt = &rt5682s_hp,
>  		.drv_name = "jsl_rt5682_rt1015",
>  		.sof_fw_filename = "sof-jsl.ri",
>  		.machine_quirk = snd_soc_acpi_codec_list,
> @@ -59,6 +65,7 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_jsl_machines[] = {
>  	},
>  	{
>  		.id = "10EC5682",
> +		.id_alt = &rt5682s_hp,
>  		.drv_name = "jsl_rt5682_rt1015p",
>  		.sof_fw_filename = "sof-jsl.ri",
>  		.machine_quirk = snd_soc_acpi_codec_list,
> @@ -67,6 +74,7 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_jsl_machines[] = {
>  	},
>  	{
>  		.id = "10EC5682",
> +		.id_alt = &rt5682s_hp,
>  		.drv_name = "jsl_rt5682_mx98360",
>  		.sof_fw_filename = "sof-jsl.ri",
>  		.machine_quirk = snd_soc_acpi_codec_list,
> @@ -81,30 +89,6 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_jsl_machines[] = {
>  		.quirk_data = &mx98360a_spk,
>  		.sof_tplg_filename = "sof-jsl-cs42l42-mx98360a.tplg",
>  	},
> -	{
> -		.id = "RTL5682",
> -		.drv_name = "jsl_rt5682s_rt1015",
> -		.sof_fw_filename = "sof-jsl.ri",
> -		.machine_quirk = snd_soc_acpi_codec_list,
> -		.quirk_data = &rt1015_spk,
> -		.sof_tplg_filename = "sof-jsl-rt5682-rt1015.tplg",
> -	},
> -	{
> -		.id = "RTL5682",
> -		.drv_name = "jsl_rt5682s_rt1015p",
> -		.sof_fw_filename = "sof-jsl.ri",
> -		.machine_quirk = snd_soc_acpi_codec_list,
> -		.quirk_data = &rt1015p_spk,
> -		.sof_tplg_filename = "sof-jsl-rt5682-rt1015.tplg",
> -	},
> -	{
> -		.id = "RTL5682",
> -		.drv_name = "jsl_rt5682s_mx98360",
> -		.sof_fw_filename = "sof-jsl.ri",
> -		.machine_quirk = snd_soc_acpi_codec_list,
> -		.quirk_data = &mx98360a_spk,
> -		.sof_tplg_filename = "sof-jsl-rt5682-mx98360a.tplg",
> -	},
>  	{},
>  };
>  EXPORT_SYMBOL_GPL(snd_soc_acpi_intel_jsl_machines);
> diff --git a/sound/soc/intel/common/soc-acpi-intel-tgl-match.c b/sound/soc/intel/common/soc-acpi-intel-tgl-match.c
> index 9d89f01d6b84..e65bd6db2850 100644
> --- a/sound/soc/intel/common/soc-acpi-intel-tgl-match.c
> +++ b/sound/soc/intel/common/soc-acpi-intel-tgl-match.c
> @@ -358,9 +358,15 @@ static const struct snd_soc_acpi_codecs tgl_rt1011_amp = {
>  	.codecs = {"10EC1011"}
>  };
>  
> +static struct snd_soc_acpi_codecs tgl_rt5682s_hp = {
> +	.num_codecs = 1,
> +	.codecs = {"RTL5682"}
> +};
> +
>  struct snd_soc_acpi_mach snd_soc_acpi_intel_tgl_machines[] = {
>  	{
>  		.id = "10EC5682",
> +		.id_alt = &tgl_rt5682s_hp,
>  		.drv_name = "tgl_mx98357_rt5682",
>  		.machine_quirk = snd_soc_acpi_codec_list,
>  		.quirk_data = &tgl_codecs,
> @@ -369,6 +375,7 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_tgl_machines[] = {
>  	},
>  	{
>  		.id = "10EC5682",
> +		.id_alt = &tgl_rt5682s_hp,
>  		.drv_name = "tgl_mx98373_rt5682",
>  		.machine_quirk = snd_soc_acpi_codec_list,
>  		.quirk_data = &tgl_max98373_amp,
> @@ -377,6 +384,7 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_tgl_machines[] = {
>  	},
>  	{
>  		.id = "10EC5682",
> +		.id_alt = &tgl_rt5682s_hp,
>  		.drv_name = "tgl_rt1011_rt5682",
>  		.machine_quirk = snd_soc_acpi_codec_list,
>  		.quirk_data = &tgl_rt1011_amp,
> 

