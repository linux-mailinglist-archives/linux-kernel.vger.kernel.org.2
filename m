Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61B4B344881
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 16:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbhCVPDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 11:03:03 -0400
Received: from mga18.intel.com ([134.134.136.126]:47949 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230374AbhCVPCp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 11:02:45 -0400
IronPort-SDR: cIau+ra5OF9zZgtpaIZbn6J0TY58dJRz4PPvWmRYJ7fXVJ5xNJC88ZlSDhk7dwV2/7Jufh+hzw
 VSh+TWpPE7yQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="177860414"
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="177860414"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 08:02:43 -0700
IronPort-SDR: u3aD4+sXSNHn4oGh2ba65rVnKcyCTTG35itJSJYwa+yzzkQkzHLzY6/uSeVrWvK6YOFe911W2o
 bViIxFxgxdug==
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="451767712"
Received: from kaschuma-mobl1.amr.corp.intel.com (HELO [10.212.220.31]) ([10.212.220.31])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 08:02:42 -0700
Subject: Re: [PATCH] ASoC: Intel: Handle device properties with software node
 API
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20210322110638.2681-1-heikki.krogerus@linux.intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <786795eb-6832-fd7d-4674-65be394c083d@linux.intel.com>
Date:   Mon, 22 Mar 2021 10:02:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210322110638.2681-1-heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/22/21 6:06 AM, Heikki Krogerus wrote:
> The function device_add_properties() is going to be removed.
> Replacing it with software node API equivalents.
> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
> Hi,
> 
> This patch depends on a fix from mainline, available in v5.12-rc4:
> 
> 	2a92c90f2ecc ("software node: Fix device_add_software_node()")
> 
> Cheers,
> ---
>   sound/soc/intel/boards/bytcht_es8316.c      |  2 +-
>   sound/soc/intel/boards/bytcr_rt5640.c       |  2 +-
>   sound/soc/intel/boards/bytcr_rt5651.c       |  2 +-
>   sound/soc/intel/boards/sof_sdw_rt711.c      | 20 +++++++++++++++-----
>   sound/soc/intel/boards/sof_sdw_rt711_sdca.c | 20 +++++++++++++++-----
>   5 files changed, 33 insertions(+), 13 deletions(-)
> 
> diff --git a/sound/soc/intel/boards/bytcht_es8316.c b/sound/soc/intel/boards/bytcht_es8316.c
> index 06df2d46d910b..4a9817a95928c 100644
> --- a/sound/soc/intel/boards/bytcht_es8316.c
> +++ b/sound/soc/intel/boards/bytcht_es8316.c
> @@ -544,7 +544,7 @@ static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
>   		props[cnt++] = PROPERTY_ENTRY_BOOL("everest,jack-detect-inverted");
>   
>   	if (cnt) {
> -		ret = device_add_properties(codec_dev, props);
> +		ret = device_create_managed_software_node(codec_dev, props, NULL);

I don't think this is correct. This is using the codec_dev device, but 
this property is created in the machine driver - different device. I 
think the proper fix is to remove the property in the machine driver 
.remove() callback, as done below for the SoundWire case, and not to 
rely on devm_ with the wrong device.

there was a thread between July and October on this in 
https://github.com/thesofproject/linux/pull/2306/

It seems that we need to restart this work.

Heikki, do you mind if I take your patches (keeping you as the author) 
and rework+test them with the SOF tree + CI ?

>   		if (ret) {
>   			put_device(codec_dev);
>   			return ret;
> diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
> index 59d6d47c8d829..661dad81e5bce 100644
> --- a/sound/soc/intel/boards/bytcr_rt5640.c
> +++ b/sound/soc/intel/boards/bytcr_rt5640.c
> @@ -918,7 +918,7 @@ static int byt_rt5640_add_codec_device_props(const char *i2c_dev_name)
>   	if (byt_rt5640_quirk & BYT_RT5640_JD_NOT_INV)
>   		props[cnt++] = PROPERTY_ENTRY_BOOL("realtek,jack-detect-not-inverted");
>   
> -	ret = device_add_properties(i2c_dev, props);
> +	ret = device_create_managed_software_node(i2c_dev, props, NULL);
>   	put_device(i2c_dev);
>   
>   	return ret;
> diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
> index 148b7b1bd3e8c..4cb6ef4c3a3d9 100644
> --- a/sound/soc/intel/boards/bytcr_rt5651.c
> +++ b/sound/soc/intel/boards/bytcr_rt5651.c
> @@ -547,7 +547,7 @@ static int byt_rt5651_add_codec_device_props(struct device *i2c_dev)
>   	if (byt_rt5651_quirk & BYT_RT5651_JD_NOT_INV)
>   		props[cnt++] = PROPERTY_ENTRY_BOOL("realtek,jack-detect-not-inverted");
>   
> -	return device_add_properties(i2c_dev, props);
> +	return device_create_managed_software_node(i2c_dev, props, NULL);
>   }
>   
>   static int byt_rt5651_init(struct snd_soc_pcm_runtime *runtime)
> diff --git a/sound/soc/intel/boards/sof_sdw_rt711.c b/sound/soc/intel/boards/sof_sdw_rt711.c
> index 04074c09dded9..b7c635c0fadd5 100644
> --- a/sound/soc/intel/boards/sof_sdw_rt711.c
> +++ b/sound/soc/intel/boards/sof_sdw_rt711.c
> @@ -24,19 +24,29 @@
>   static int rt711_add_codec_device_props(const char *sdw_dev_name)
>   {
>   	struct property_entry props[MAX_NO_PROPS] = {};
> +	struct fwnode_handle *fwnode;
>   	struct device *sdw_dev;
>   	int ret;
>   
> +	if (!SOF_RT711_JDSRC(sof_sdw_quirk))
> +		return 0;
> +
>   	sdw_dev = bus_find_device_by_name(&sdw_bus_type, NULL, sdw_dev_name);
>   	if (!sdw_dev)
>   		return -EPROBE_DEFER;
>   
> -	if (SOF_RT711_JDSRC(sof_sdw_quirk)) {
> -		props[0] = PROPERTY_ENTRY_U32("realtek,jd-src",
> -					      SOF_RT711_JDSRC(sof_sdw_quirk));
> +	props[0] = PROPERTY_ENTRY_U32("realtek,jd-src",
> +				      SOF_RT711_JDSRC(sof_sdw_quirk));
> +
> +	fwnode = fwnode_create_software_node(props, NULL);
> +	if (IS_ERR(fwnode)) {
> +		put_device(sdw_dev);
> +		return PTR_ERR(fwnode);
>   	}
>   
> -	ret = device_add_properties(sdw_dev, props);
> +	ret = device_add_software_node(sdw_dev, to_software_node(fwnode));
> +
> +	fwnode_handle_put(fwnode);
>   	put_device(sdw_dev);
>   
>   	return ret;
> @@ -144,7 +154,7 @@ int sof_sdw_rt711_exit(struct device *dev, struct snd_soc_dai_link *dai_link)
>   	if (!sdw_dev)
>   		return -EINVAL;
>   
> -	device_remove_properties(sdw_dev);
> +	device_remove_software_node(sdw_dev);
>   	put_device(sdw_dev);
>   
>   	return 0;
> diff --git a/sound/soc/intel/boards/sof_sdw_rt711_sdca.c b/sound/soc/intel/boards/sof_sdw_rt711_sdca.c
> index 19496f0f9110c..300a52d155069 100644
> --- a/sound/soc/intel/boards/sof_sdw_rt711_sdca.c
> +++ b/sound/soc/intel/boards/sof_sdw_rt711_sdca.c
> @@ -24,19 +24,29 @@
>   static int rt711_sdca_add_codec_device_props(const char *sdw_dev_name)
>   {
>   	struct property_entry props[MAX_NO_PROPS] = {};
> +	struct fwnode_handle *fwnode;
>   	struct device *sdw_dev;
>   	int ret;
>   
> +	if (!SOF_RT711_JDSRC(sof_sdw_quirk))
> +		return 0;
> +
>   	sdw_dev = bus_find_device_by_name(&sdw_bus_type, NULL, sdw_dev_name);
>   	if (!sdw_dev)
>   		return -EPROBE_DEFER;
>   
> -	if (SOF_RT711_JDSRC(sof_sdw_quirk)) {
> -		props[0] = PROPERTY_ENTRY_U32("realtek,jd-src",
> -					      SOF_RT711_JDSRC(sof_sdw_quirk));
> +	props[0] = PROPERTY_ENTRY_U32("realtek,jd-src",
> +				      SOF_RT711_JDSRC(sof_sdw_quirk));
> +
> +	fwnode = fwnode_create_software_node(props, NULL);
> +	if (IS_ERR(fwnode)) {
> +		put_device(sdw_dev);
> +		return PTR_ERR(fwnode);
>   	}
>   
> -	ret = device_add_properties(sdw_dev, props);
> +	ret = device_add_software_node(sdw_dev, to_software_node(fwnode));
> +
> +	fwnode_handle_put(fwnode);
>   	put_device(sdw_dev);
>   
>   	return ret;
> @@ -144,7 +154,7 @@ int sof_sdw_rt711_sdca_exit(struct device *dev, struct snd_soc_dai_link *dai_lin
>   	if (!sdw_dev)
>   		return -EINVAL;
>   
> -	device_remove_properties(sdw_dev);
> +	device_remove_software_node(sdw_dev);
>   	put_device(sdw_dev);
>   
>   	return 0;
> 
