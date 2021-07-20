Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F87C3D01E0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 20:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbhGTSG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 14:06:58 -0400
Received: from mga05.intel.com ([192.55.52.43]:2800 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229818AbhGTSGw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 14:06:52 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10051"; a="296869491"
X-IronPort-AV: E=Sophos;i="5.84,255,1620716400"; 
   d="scan'208";a="296869491"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2021 11:47:29 -0700
X-IronPort-AV: E=Sophos;i="5.84,255,1620716400"; 
   d="scan'208";a="462146675"
Received: from aremenni-mobl.amr.corp.intel.com (HELO [10.209.130.10]) ([10.209.130.10])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2021 11:47:28 -0700
Subject: Re: [PATCH v4 07/12] ASoC: amd: add ACP5x pcm dma driver ops
To:     Vijendar Mukunda <Vijendar.Mukunda@amd.com>, broonie@kernel.org,
        alsa-devel@alsa-project.org
Cc:     Sunil-kumar.Dommati@amd.com,
        open list <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Alexander.Deucher@amd.com,
        krisman@collabora.com
References: <20210720163732.23003-1-Vijendar.Mukunda@amd.com>
 <20210720163732.23003-8-Vijendar.Mukunda@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <331065bd-32d5-45eb-37fc-d4fc76c23fe8@linux.intel.com>
Date:   Tue, 20 Jul 2021 13:27:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210720163732.23003-8-Vijendar.Mukunda@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> +static int acp5x_dma_open(struct snd_soc_component *component,
> +			  struct snd_pcm_substream *substream)
> +{
> +	struct snd_pcm_runtime *runtime;
> +	struct snd_soc_pcm_runtime *prtd;
> +	struct i2s_dev_data *adata;
> +	struct i2s_stream_instance *i2s_data;
> +	int ret;
> +
> +	runtime = substream->runtime;
> +	prtd = asoc_substream_to_rtd(substream);
> +	component = snd_soc_rtdcom_lookup(prtd, DRV_NAME);
> +	adata = dev_get_drvdata(component->dev);
> +
> +	i2s_data = kzalloc(sizeof(*i2s_data), GFP_KERNEL);
> +	if (!i2s_data)
> +		return -EINVAL;

return -ENOMEM?

> +
> +	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
> +		runtime->hw = acp5x_pcm_hardware_playback;
> +	else
> +		runtime->hw = acp5x_pcm_hardware_capture;
> +
> +	ret = snd_pcm_hw_constraint_integer(runtime,
> +					    SNDRV_PCM_HW_PARAM_PERIODS);
> +	if (ret < 0) {
> +		dev_err(component->dev, "set integer constraint failed\n");
> +		kfree(i2s_data);
> +		return ret;
> +	}
> +	i2s_data->acp5x_base = adata->acp5x_base;
> +	runtime->private_data = i2s_data;
> +	return ret;
> +}
> +
> +static int acp5x_dma_hw_params(struct snd_soc_component *component,
> +			       struct snd_pcm_substream *substream,
> +			       struct snd_pcm_hw_params *params)
> +{
> +	struct i2s_stream_instance *rtd;
> +	struct snd_soc_pcm_runtime *prtd;
> +	struct snd_soc_card *card;
> +	struct acp5x_platform_info *pinfo;
> +	struct i2s_dev_data *adata;
> +	u64 size;
> +
> +	prtd = asoc_substream_to_rtd(substream);
> +	card = prtd->card;
> +	pinfo = snd_soc_card_get_drvdata(card);
> +	adata = dev_get_drvdata(component->dev);
> +	rtd = substream->runtime->private_data;
> +
> +	if (!rtd)
> +		return -EINVAL;
> +
> +	if (pinfo) {
> +		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> +			rtd->i2s_instance = pinfo->play_i2s_instance;
> +			switch (rtd->i2s_instance) {
> +			case I2S_HS_INSTANCE:
> +				adata->play_stream = substream;
> +				break;
> +			case I2S_SP_INSTANCE:
> +			default:
> +				adata->i2ssp_play_stream = substream;
> +			}
> +		} else {
> +			rtd->i2s_instance = pinfo->cap_i2s_instance;
> +			switch (rtd->i2s_instance) {
> +			case I2S_HS_INSTANCE:
> +				adata->capture_stream = substream;
> +				break;
> +			case I2S_SP_INSTANCE:
> +			default:
> +				adata->i2ssp_capture_stream = substream;
> +			}
> +		}
> +	} else {
> +		dev_err(component->dev, "pinfo failed\n");

should you bail here with e.g. return -EINVAL?

> +	}
> +	size = params_buffer_bytes(params);
> +	rtd->dma_addr = substream->dma_buffer.addr;
> +	rtd->num_pages = (PAGE_ALIGN(size) >> PAGE_SHIFT);
> +	config_acp5x_dma(rtd, substream->stream);
> +	return 0;
> +}

