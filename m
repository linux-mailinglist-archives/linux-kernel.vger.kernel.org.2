Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE24B3C8980
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 19:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239092AbhGNRR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 13:17:26 -0400
Received: from mga01.intel.com ([192.55.52.88]:35631 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238962AbhGNRRY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 13:17:24 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10045"; a="232208042"
X-IronPort-AV: E=Sophos;i="5.84,239,1620716400"; 
   d="scan'208";a="232208042"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2021 10:14:32 -0700
X-IronPort-AV: E=Sophos;i="5.84,239,1620716400"; 
   d="scan'208";a="413353770"
Received: from alpinagh-mobl1.amr.corp.intel.com (HELO [10.212.71.223]) ([10.212.71.223])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2021 10:14:30 -0700
Subject: Re: [PATCH v2 09/16] ASoC: qcom: audioreach: add q6apm-dai support
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        bjorn.andersson@linaro.org, broonie@kernel.org, robh@kernel.org
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        bgoswami@codeaurora.org, lgirdwood@gmail.com, tiwai@suse.de,
        plai@codeaurora.org, linux-kernel@vger.kernel.org
References: <20210714153039.28373-1-srinivas.kandagatla@linaro.org>
 <20210714153039.28373-10-srinivas.kandagatla@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <9b669a36-f9e4-bd90-7b02-e55fe5b99814@linux.intel.com>
Date:   Wed, 14 Jul 2021 11:59:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210714153039.28373-10-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> +static void event_handler(uint32_t opcode, uint32_t token,
> +			  uint32_t *payload, void *priv)
> +{
> +	struct q6apm_dai_rtd *prtd = priv;
> +	struct snd_pcm_substream *substream = prtd->substream;
> +
> +	switch (opcode) {
> +	case APM_CLIENT_EVENT_CMD_EOS_DONE:
> +		prtd->state = Q6APM_STREAM_STOPPED;
> +		break;
> +	case APM_CLIENT_EVENT_DATA_WRITE_DONE: {
> +		prtd->pcm_irq_pos += prtd->pcm_count;
> +		snd_pcm_period_elapsed(substream);

A comment on the relationship between data writes and periods would be nice. It looks like the code assumes the period and data transfers are identical, but periods can be chosen by applications, can't they?

> +		if (prtd->state == Q6APM_STREAM_RUNNING) {
> +			q6apm_write_async(prtd->graph,
> +					   prtd->pcm_count, 0, 0, NO_TIMESTAMP);
> +		}
> +
> +		break;
> +		}
> +	case APM_CLIENT_EVENT_DATA_READ_DONE:
> +		prtd->pcm_irq_pos += prtd->pcm_count;
> +		snd_pcm_period_elapsed(substream);
> +		if (prtd->state == Q6APM_STREAM_RUNNING)
> +			q6apm_read(prtd->graph);
> +
> +		break;
> +	default:
> +		break;
> +	}
> +}

> +static int q6apm_dai_trigger(struct snd_soc_component *component,
> +			     struct snd_pcm_substream *substream, int cmd)
> +{
> +	struct snd_pcm_runtime *runtime = substream->runtime;
> +	struct q6apm_dai_rtd *prtd = runtime->private_data;
> +	int ret = 0;
> +
> +	switch (cmd) {
> +	case SNDRV_PCM_TRIGGER_START:
> +	case SNDRV_PCM_TRIGGER_RESUME:
> +	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> +		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
> +			ret = q6apm_write_async(prtd->graph, prtd->pcm_count, 0, 0, NO_TIMESTAMP);
> +		break;
> +	case SNDRV_PCM_TRIGGER_STOP:
> +		prtd->state = Q6APM_STREAM_STOPPED;
> +		//ret = q6apm_cmd_nowait(prtd->graph, CMD_EOS);
> +		break;
> +	case SNDRV_PCM_TRIGGER_SUSPEND:
> +	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
> +		//ret = q6apm_cmd_nowait(prtd->graph, CMD_PAUSE);

these // comments are odd, with a clear imbalance between suspend/resume and pause_push/pause_release... 
is this intentional or a left-over from an experiment?

> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static int q6apm_dai_open(struct snd_soc_component *component,
> +			  struct snd_pcm_substream *substream)
> +{
> +	struct snd_pcm_runtime *runtime = substream->runtime;
> +	struct snd_soc_pcm_runtime *soc_prtd = substream->private_data;
> +	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(soc_prtd, 0);
> +	struct q6apm_dai_rtd *prtd;
> +	struct q6apm_dai_data *pdata;
> +	struct device *dev = component->dev;
> +	int ret;
> +	int graph_id;
> +
> +	graph_id = cpu_dai->driver->id;
> +
> +	pdata = snd_soc_component_get_drvdata(component);
> +	if (!pdata) {
> +		dev_err(component->dev, "Drv data not found ..\n");
> +		return -EINVAL;
> +	}
> +
> +	prtd = kzalloc(sizeof(*prtd), GFP_KERNEL);
> +	if (prtd == NULL)
> +		return -ENOMEM;
> +
> +	prtd->substream = substream;
> +
> +	prtd->graph = q6apm_graph_open(dev, (q6apm_cb)event_handler,
> +				       prtd, graph_id);
> +	if (IS_ERR(prtd->graph)) {
> +		pr_info("%s: Could not allocate memory\n", __func__);
> +		ret = PTR_ERR(prtd->graph);
> +		kfree(prtd);
> +		return ret;
> +	}
> +
> +	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
> +		runtime->hw = q6apm_dai_hardware_playback;
> +	else if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
> +		runtime->hw = q6apm_dai_hardware_capture;
> +
> +	/* Ensure that buffer size is a multiple of period size */
> +	ret = snd_pcm_hw_constraint_integer(runtime,
> +					    SNDRV_PCM_HW_PARAM_PERIODS);
> +	if (ret < 0)
> +		dev_err(dev, "snd_pcm_hw_constraint_integer failed\n");
> +
> +	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> +		ret = snd_pcm_hw_constraint_minmax(runtime,
> +			SNDRV_PCM_HW_PARAM_BUFFER_BYTES,
> +			BUFFER_BYTES_MIN, BUFFER_BYTES_MAX);
> +		if (ret < 0) {
> +			dev_err(dev, "constraint for buffer bytes min max ret = %d\n",
> +									ret);
> +		}
> +	}
> +
> +	ret = snd_pcm_hw_constraint_step(runtime, 0,
> +					 SNDRV_PCM_HW_PARAM_PERIOD_BYTES, 32);
> +	if (ret < 0) {
> +		dev_err(dev, "constraint for period bytes step ret = %d\n",
> +								ret);
> +	}
> +	ret = snd_pcm_hw_constraint_step(runtime, 0,
> +					 SNDRV_PCM_HW_PARAM_BUFFER_BYTES, 32);
> +	if (ret < 0) {
> +		dev_err(dev, "constraint for buffer bytes step ret = %d\n",
> +								ret);
> +	}

dev_err() used but no return code sent?

> +
> +	runtime->private_data = prtd;
> +	runtime->dma_bytes = BUFFER_BYTES_MAX;
> +	if (pdata->sid < 0)
> +		prtd->phys = substream->dma_buffer.addr;
> +	else
> +		prtd->phys = substream->dma_buffer.addr | (pdata->sid << 32);
> +
> +	snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);
> +
> +	return 0;
> +}

> +static int q6apm_dai_hw_params(struct snd_soc_component *component,
> +			       struct snd_pcm_substream *substream,
> +			       struct snd_pcm_hw_params *params)
> +{
> +	struct snd_pcm_runtime *runtime = substream->runtime;
> +	struct q6apm_dai_rtd *prtd = runtime->private_data;
> +
> +	prtd->pcm_size = params_buffer_bytes(params);
> +	prtd->periods = params_periods(params);
> +
> +	switch (params_format(params)) {
> +	case SNDRV_PCM_FORMAT_S16_LE:
> +		prtd->bits_per_sample = 16;
> +		break;
> +	case SNDRV_PCM_FORMAT_S24_LE:
> +		prtd->bits_per_sample = 24;
> +		break;

default:
    return -EINVAL
?

> +	}
> +
> +	return 0;
> +}
> +

