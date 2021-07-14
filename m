Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 123C83C8981
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 19:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239449AbhGNRR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 13:17:28 -0400
Received: from mga01.intel.com ([192.55.52.88]:35631 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229767AbhGNRR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 13:17:26 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10045"; a="232208048"
X-IronPort-AV: E=Sophos;i="5.84,239,1620716400"; 
   d="scan'208";a="232208048"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2021 10:14:34 -0700
X-IronPort-AV: E=Sophos;i="5.84,239,1620716400"; 
   d="scan'208";a="413353781"
Received: from alpinagh-mobl1.amr.corp.intel.com (HELO [10.212.71.223]) ([10.212.71.223])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2021 10:14:33 -0700
Subject: Re: [PATCH v2 10/16] ASoC: qcom: audioreach: add bedai support
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        bjorn.andersson@linaro.org, broonie@kernel.org, robh@kernel.org
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        bgoswami@codeaurora.org, lgirdwood@gmail.com, tiwai@suse.de,
        plai@codeaurora.org, linux-kernel@vger.kernel.org
References: <20210714153039.28373-1-srinivas.kandagatla@linaro.org>
 <20210714153039.28373-11-srinivas.kandagatla@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <cb2636b9-e88f-76c3-129a-5cbb2cd017b2@linux.intel.com>
Date:   Wed, 14 Jul 2021 12:03:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210714153039.28373-11-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> +static int q6dma_hw_params(struct snd_pcm_substream *substream,
> +			   struct snd_pcm_hw_params *params,
> +			   struct snd_soc_dai *dai)
> +{
> +	struct q6apm_bedai_data *dai_data = dev_get_drvdata(dai->dev);
> +	struct q6apm_cdc_dma_cfg *cfg = &dai_data->port_config[dai->id].dma_cfg;
> +
> +	cfg->bit_width = params_width(params);
> +	cfg->sample_rate = params_rate(params);
> +	cfg->num_channels = params_channels(params);
> +
> +	switch (params_format(params)) {
> +	case SNDRV_PCM_FORMAT_S16_LE:
> +		dai_data->bits_per_sample[dai->id] = 16;
> +		break;
> +	case SNDRV_PCM_FORMAT_S24_LE:
> +		dai_data->bits_per_sample[dai->id] = 24;
> +		break;

default:
    return -EINVAL;

?

> +	}
> +
> +	return 0;
> +}
> +
> +static void q6apm_bedai_shutdown(struct snd_pcm_substream *substream,
> +				struct snd_soc_dai *dai)
> +{
> +	struct q6apm_bedai_data *dai_data = dev_get_drvdata(dai->dev);
> +	int rc;
> +
> +	if (!dai_data->is_port_started[dai->id])
> +		return;
> +	rc = q6apm_graph_stop(dai_data->graph[dai->id]);
> +	if (rc < 0)
> +		dev_err(dai->dev, "fail to close APM port (%d)\n", rc);
> +
> +	q6apm_graph_close(dai_data->graph[dai->id]);
> +	dai_data->is_port_started[dai->id] = false;

difficult to follow, this mixes '!start', 'stop', 'close'


> +
> +}
> +
> +static int q6apm_bedai_prepare(struct snd_pcm_substream *substream,
> +			       struct snd_soc_dai *dai)
> +{
> +	struct q6apm_bedai_data *dai_data = dev_get_drvdata(dai->dev);
> +	struct q6apm_cdc_dma_cfg *cfg = &dai_data->port_config[dai->id].dma_cfg;
> +	int graph_id = dai->id;
> +	int rc;
> +	int ret;
> +	struct q6apm_graph *graph;
> +
> +	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> +		graph = q6apm_graph_open(dai->dev, NULL, dai->dev, graph_id);
> +		if (IS_ERR(graph)) {
> +			dev_err(dai->dev, "Failed to open graph (%d)\n",
> +				graph_id);
> +			ret = PTR_ERR(graph);
> +			return ret;
> +		}
> +		dai_data->graph[graph_id] = graph;
> +	}
> +
> +	rc = q6apm_graph_media_format_pcm(dai_data->graph[dai->id],
> +					  substream->stream, cfg->sample_rate,
> +					  cfg->num_channels, NULL, cfg->bit_width);
> +
> +	rc = q6apm_graph_prepare(dai_data->graph[dai->id]);

any good static analyzer would tell you you didn't test rc before overriding it..

this looks rather questionable.

> +	rc = q6apm_graph_start(dai_data->graph[dai->id]);
> +	if (rc < 0) {
> +		dev_err(dai->dev, "fail to start APM port %x\n", dai->id);
> +		return rc;
> +	}
> +	dai_data->is_port_started[dai->id] = true;
> +
> +	return 0;
> +}
 
