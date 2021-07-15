Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72CF53C9CB0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 12:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241382AbhGOKfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 06:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241374AbhGOKfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 06:35:19 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9B6C061760
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 03:32:26 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id w13so3397324wmc.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 03:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yErtTWgcO6FK0iGfpzstg3ohtWyGpJF37AOcLp6i0rU=;
        b=E3h11f88UUXXnGCXjPiHxeLqM1eLAL34bmABWBW3eR4vCSamRe50aBxoNDXPDTXClz
         3stoYZgpeJzJ4ZNKea+jrOzDRDhXHuth/SD0jb5u8zbMPlj1mEsMWJ7/DQ9qJe/MM6sY
         ppqrkU7yEaJ04hGr2gXlKJj+YqhBOXp1ivpFQ2dUe/Xbf3f8hqxupCOIdJQn9X/eYh/L
         OCwVZU685IULo0bNHfpGhnx8/Kl7ip4u8NMXw/XEXarquwuIakxzzyl6QbAnZyS3sPAU
         tOr7OHGRQUox5FFrfR18+V67aPaY2Q8wxdIRJR/vZl2wY6Q3StaAf0kLOVXwS97R4Sqs
         DMmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yErtTWgcO6FK0iGfpzstg3ohtWyGpJF37AOcLp6i0rU=;
        b=HIXPj/tqZ4gpa+wDfblQoij0httbOo0iiLYkWAr+aQAF6qNH0fL01tdJU/TGhHG+U3
         h63/gMKt3+ba8y3fXI+8ruuZvah4mA/AlRkTFH7PhMEdtZjpbYXARmow/l+VQ1q9A7G7
         dLQVZNTAp9TKbhg6+gN89OjDZqo/tek62+vISWY2wt6tO7DUg45/c+RbVkBKJvtnZqyd
         emRxNzp2mHNfSmt0+/cP+W5pKSvxOv4ZrNSGb48DEePJPmIvbKT7mKmYef3HxosBgeq6
         xpFgFa/gE+WpDebnUcd2/kMtV1iwyENMZBR1I6y5z5xxZbTA1HtQam3ECG8552k7raG4
         +jCQ==
X-Gm-Message-State: AOAM533XBV5LVAggQYkIXkboxUGGkJKVus8Mq7kPpbNLjYjQWRS0USLH
        LSn86dcJegaI9C90/O2p1avEFXCMA08p6w==
X-Google-Smtp-Source: ABdhPJyLJnG8rhsApFP959gtYhzUIb21xHkuZxXHeM6/w3dCR+i1WWHgNlCr5cYEBBkk2uF7+TbbKA==
X-Received: by 2002:a7b:c84d:: with SMTP id c13mr9961444wml.30.1626345144763;
        Thu, 15 Jul 2021 03:32:24 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id r9sm4319671wmq.25.2021.07.15.03.32.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 03:32:24 -0700 (PDT)
Subject: Re: [PATCH v2 09/16] ASoC: qcom: audioreach: add q6apm-dai support
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        bjorn.andersson@linaro.org, broonie@kernel.org, robh@kernel.org
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        bgoswami@codeaurora.org, lgirdwood@gmail.com, tiwai@suse.de,
        plai@codeaurora.org, linux-kernel@vger.kernel.org
References: <20210714153039.28373-1-srinivas.kandagatla@linaro.org>
 <20210714153039.28373-10-srinivas.kandagatla@linaro.org>
 <9b669a36-f9e4-bd90-7b02-e55fe5b99814@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <90aafeb0-57dd-a309-e08f-a4ff31ad0853@linaro.org>
Date:   Thu, 15 Jul 2021 11:32:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <9b669a36-f9e4-bd90-7b02-e55fe5b99814@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/07/2021 17:59, Pierre-Louis Bossart wrote:
> 
> 
>> +static void event_handler(uint32_t opcode, uint32_t token,
>> +			  uint32_t *payload, void *priv)
>> +{
>> +	struct q6apm_dai_rtd *prtd = priv;
>> +	struct snd_pcm_substream *substream = prtd->substream;
>> +
>> +	switch (opcode) {
>> +	case APM_CLIENT_EVENT_CMD_EOS_DONE:
>> +		prtd->state = Q6APM_STREAM_STOPPED;
>> +		break;
>> +	case APM_CLIENT_EVENT_DATA_WRITE_DONE: {
>> +		prtd->pcm_irq_pos += prtd->pcm_count;
>> +		snd_pcm_period_elapsed(substream);
> 
> A comment on the relationship between data writes and periods would be nice. It looks like the code assumes the period and data transfers are identical, but periods can be chosen by applications, can't they?

Yes, pcm_count is set to period size, so we get ack for each period.


> 
>> +		if (prtd->state == Q6APM_STREAM_RUNNING) {
>> +			q6apm_write_async(prtd->graph,
>> +					   prtd->pcm_count, 0, 0, NO_TIMESTAMP);
>> +		}
>> +
>> +		break;
>> +		}
>> +	case APM_CLIENT_EVENT_DATA_READ_DONE:
>> +		prtd->pcm_irq_pos += prtd->pcm_count;
>> +		snd_pcm_period_elapsed(substream);
>> +		if (prtd->state == Q6APM_STREAM_RUNNING)
>> +			q6apm_read(prtd->graph);
>> +
>> +		break;
>> +	default:
>> +		break;
>> +	}
>> +}
> 
>> +static int q6apm_dai_trigger(struct snd_soc_component *component,
>> +			     struct snd_pcm_substream *substream, int cmd)
>> +{
>> +	struct snd_pcm_runtime *runtime = substream->runtime;
>> +	struct q6apm_dai_rtd *prtd = runtime->private_data;
>> +	int ret = 0;
>> +
>> +	switch (cmd) {
>> +	case SNDRV_PCM_TRIGGER_START:
>> +	case SNDRV_PCM_TRIGGER_RESUME:
>> +	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
>> +		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
>> +			ret = q6apm_write_async(prtd->graph, prtd->pcm_count, 0, 0, NO_TIMESTAMP);
>> +		break;
>> +	case SNDRV_PCM_TRIGGER_STOP:
>> +		prtd->state = Q6APM_STREAM_STOPPED;
>> +		//ret = q6apm_cmd_nowait(prtd->graph, CMD_EOS);
>> +		break;
>> +	case SNDRV_PCM_TRIGGER_SUSPEND:
>> +	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
>> +		//ret = q6apm_cmd_nowait(prtd->graph, CMD_PAUSE);
> 
> these // comments are odd, with a clear imbalance between suspend/resume and pause_push/pause_release...
> is this intentional or a left-over from an experiment?

Yes, I forgot to clean this up before sending out.

> 
>> +		break;
>> +	default:
>> +		ret = -EINVAL;
>> +		break;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static int q6apm_dai_open(struct snd_soc_component *component,
>> +			  struct snd_pcm_substream *substream)
>> +{
>> +	struct snd_pcm_runtime *runtime = substream->runtime;
>> +	struct snd_soc_pcm_runtime *soc_prtd = substream->private_data;
>> +	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(soc_prtd, 0);
>> +	struct q6apm_dai_rtd *prtd;
>> +	struct q6apm_dai_data *pdata;
>> +	struct device *dev = component->dev;
>> +	int ret;
>> +	int graph_id;
>> +
>> +	graph_id = cpu_dai->driver->id;
>> +
>> +	pdata = snd_soc_component_get_drvdata(component);
>> +	if (!pdata) {
>> +		dev_err(component->dev, "Drv data not found ..\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	prtd = kzalloc(sizeof(*prtd), GFP_KERNEL);
>> +	if (prtd == NULL)
>> +		return -ENOMEM;
>> +
>> +	prtd->substream = substream;
>> +
>> +	prtd->graph = q6apm_graph_open(dev, (q6apm_cb)event_handler,
>> +				       prtd, graph_id);
>> +	if (IS_ERR(prtd->graph)) {
>> +		pr_info("%s: Could not allocate memory\n", __func__);
>> +		ret = PTR_ERR(prtd->graph);
>> +		kfree(prtd);
>> +		return ret;
>> +	}
>> +
>> +	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
>> +		runtime->hw = q6apm_dai_hardware_playback;
>> +	else if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
>> +		runtime->hw = q6apm_dai_hardware_capture;
>> +
>> +	/* Ensure that buffer size is a multiple of period size */
>> +	ret = snd_pcm_hw_constraint_integer(runtime,
>> +					    SNDRV_PCM_HW_PARAM_PERIODS);
>> +	if (ret < 0)
>> +		dev_err(dev, "snd_pcm_hw_constraint_integer failed\n");
>> +
>> +	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
>> +		ret = snd_pcm_hw_constraint_minmax(runtime,
>> +			SNDRV_PCM_HW_PARAM_BUFFER_BYTES,
>> +			BUFFER_BYTES_MIN, BUFFER_BYTES_MAX);
>> +		if (ret < 0) {
>> +			dev_err(dev, "constraint for buffer bytes min max ret = %d\n",
>> +									ret);
>> +		}
>> +	}
>> +
>> +	ret = snd_pcm_hw_constraint_step(runtime, 0,
>> +					 SNDRV_PCM_HW_PARAM_PERIOD_BYTES, 32);
>> +	if (ret < 0) {
>> +		dev_err(dev, "constraint for period bytes step ret = %d\n",
>> +								ret);
>> +	}
>> +	ret = snd_pcm_hw_constraint_step(runtime, 0,
>> +					 SNDRV_PCM_HW_PARAM_BUFFER_BYTES, 32);
>> +	if (ret < 0) {
>> +		dev_err(dev, "constraint for buffer bytes step ret = %d\n",
>> +								ret);
>> +	}
> 
> dev_err() used but no return code sent?

Ack.

> 
>> +
>> +	runtime->private_data = prtd;
>> +	runtime->dma_bytes = BUFFER_BYTES_MAX;
>> +	if (pdata->sid < 0)
>> +		prtd->phys = substream->dma_buffer.addr;
>> +	else
>> +		prtd->phys = substream->dma_buffer.addr | (pdata->sid << 32);
>> +
>> +	snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);
>> +
>> +	return 0;
>> +}
> 
>> +static int q6apm_dai_hw_params(struct snd_soc_component *component,
>> +			       struct snd_pcm_substream *substream,
>> +			       struct snd_pcm_hw_params *params)
>> +{
>> +	struct snd_pcm_runtime *runtime = substream->runtime;
>> +	struct q6apm_dai_rtd *prtd = runtime->private_data;
>> +
>> +	prtd->pcm_size = params_buffer_bytes(params);
>> +	prtd->periods = params_periods(params);
>> +
>> +	switch (params_format(params)) {
>> +	case SNDRV_PCM_FORMAT_S16_LE:
>> +		prtd->bits_per_sample = 16;
>> +		break;
>> +	case SNDRV_PCM_FORMAT_S24_LE:
>> +		prtd->bits_per_sample = 24;
>> +		break;
> 
> default:
>      return -EINVAL
> ?
Ack, will do that in next spin.

--srini
> 
>> +	}
>> +
>> +	return 0;
>> +}
>> +
> 
