Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C78F41F190
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 17:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353938AbhJAPye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 11:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbhJAPyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 11:54:31 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A00C06177D
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 08:52:47 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id g2so8302605pfc.6
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 08:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=W/2GzNB3u7TT74q9PP+qr3+N2+FbkoiA6tUqxu1t9uk=;
        b=BlZFV/FP1uVSPdR/tPI438iaxuP71Hl/02jq4Q+B9+U+0kjLBbKDPDjXSYC5UAbKOP
         +OmHjKtRjb9gEJ9IUzlOvD4mVL4YkU0f3ifg0nBStp6Tn0WO8ubCRPHIfXdE5AAY5y0w
         PGfluAAYRZjK7Oi0BJgcvYjs8gc+XFUorBLu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=W/2GzNB3u7TT74q9PP+qr3+N2+FbkoiA6tUqxu1t9uk=;
        b=wM7h7uqOHmcksmDUbLksYGN8UJO/Y4AEj3l8E7kSDhQtRsMMnuGHRp5aKm3lE1pvgc
         R+ucrlIVWihWhyPvHtWB2kX9csFWJ2E4ArGYsyfHkCLnK0+Cf7XekdDjh9lhR/B30dxG
         tKb3BNrNIfCl2S2Pg3zViFfA1DvbQpHOFMVprkmVJ55nQMPre6bcp6446H7m8qp9TVyW
         zRHnMreHegOFC3ILAz4kI0yyQXv8vl8HOWzxG4Ya+EFIs23k/uRkuHMIwh3VLrhUeQtN
         uiC9DlQjYOBnr3+C1pkugqtOKdpEJ+6CoVhGlCQSp74ncWT9NwA4Uec+ST0i7IUX51x6
         yOpQ==
X-Gm-Message-State: AOAM533WVT27uxbV21Vf0z/LqZ9r9BfF/olQ/pN4eFG1LMmiThQasy70
        Z2zzOyO4unyZjwRX/TQCJb3n0w==
X-Google-Smtp-Source: ABdhPJxbW/w0AacFdyk0ikXT+slEN8/ifKr5jE1IrW4gPBXgMAtnj1+sCIqCQNOpG9muNHWycaARPw==
X-Received: by 2002:a63:f30c:: with SMTP id l12mr10226543pgh.360.1633103566594;
        Fri, 01 Oct 2021 08:52:46 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:f57f:9f3a:1408:a801])
        by smtp.gmail.com with UTF8SMTPSA id n14sm6885211pgd.48.2021.10.01.08.52.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Oct 2021 08:52:46 -0700 (PDT)
Date:   Fri, 1 Oct 2021 08:52:44 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, plai@codeaurora.org,
        bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
        srinivas.kandagatla@linaro.org, rohitkr@codeaurora.org,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        swboyd@chromium.org, judyhsiao@chromium.org,
        Venkata Prasad Potturu <potturu@codeaurora.org>
Subject: Re: [PATCH 4/8] ASoC: qcom: Add lapss CPU driver for codec dma
 control
Message-ID: <YVcuzEXA4Ej3HpHH@google.com>
References: <1633087292-1378-1-git-send-email-srivasam@codeaurora.org>
 <1633087292-1378-5-git-send-email-srivasam@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1633087292-1378-5-git-send-email-srivasam@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 01, 2021 at 04:51:28PM +0530, Srinivasa Rao Mandadapu wrote:
> Subject: ASoC: qcom: Add lapss CPU driver for codec dma control

nit: s/lapss/lpass/

>
> Add lpass cpu driver to support audio over codec dma for
> ADSP bypass usecase.
> 
> Signed-off-by: Venkata Prasad Potturu <potturu@codeaurora.org>
> Signed-off-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
> ---
>  sound/soc/qcom/lpass-cdc-dma.c | 263 +++++++++++++++++++++++++++++++++++++++++
>  sound/soc/qcom/lpass.h         |   1 +
>  2 files changed, 264 insertions(+)
>  create mode 100644 sound/soc/qcom/lpass-cdc-dma.c
> 
> diff --git a/sound/soc/qcom/lpass-cdc-dma.c b/sound/soc/qcom/lpass-cdc-dma.c
> new file mode 100644
> index 0000000..56b3791
> --- /dev/null
> +++ b/sound/soc/qcom/lpass-cdc-dma.c
> @@ -0,0 +1,263 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2021 The Linux Foundation. All rights reserved.
> + *
> + * lpass-cdc-dma.c -- ALSA SoC WCD -CPU DAI driver for QTi LPASS WCD
> + */
> +
> +#include <linux/module.h>
> +#include <sound/soc.h>
> +#include <sound/soc-dai.h>
> +
> +#include "lpass-lpaif-reg.h"
> +#include "lpass.h"
> +
> +static int __lpass_platform_codec_intf_init(struct snd_soc_dai *dai,
> +					 struct snd_pcm_substream *substream)
> +{
> +	struct snd_soc_pcm_runtime *soc_runtime = asoc_substream_to_rtd(substream);
> +	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(soc_runtime, 0);
> +	struct lpass_data *drvdata = snd_soc_dai_get_drvdata(dai);
> +	struct snd_pcm_runtime *rt = substream->runtime;
> +	struct lpass_pcm_data *pcm_data = rt->private_data;
> +	struct lpass_variant *v = drvdata->variant;
> +	struct lpaif_dmactl *dmactl;
> +	struct regmap *map;
> +	int dir = substream->stream;
> +	int ret, id;
> +	unsigned int dai_id = cpu_dai->driver->id;
> +
> +	if (dir ==  SNDRV_PCM_STREAM_PLAYBACK) {

s/ ==  / == /

> +		dmactl = drvdata->rxtx_rd_dmactl;
> +		map = drvdata->rxtx_lpaif_map;
> +		id = pcm_data->dma_ch;
> +	} else {
> +		if (dai_id == LPASS_CDC_DMA_TX3) {
> +			dmactl = drvdata->rxtx_wr_dmactl;
> +			map = drvdata->rxtx_lpaif_map;
> +			id = pcm_data->dma_ch - v->rxtx_wrdma_channel_start;
> +		} else if (dai_id == LPASS_CDC_DMA_VA_TX0) {
> +			dmactl = drvdata->va_wr_dmactl;
> +			map = drvdata->va_lpaif_map;
> +			id = pcm_data->dma_ch - v->va_wrdma_channel_start;
> +		}
> +	}

'map' is assigned here, but not used in the rest of the function, drop it.

> +
> +	if (dir ==  SNDRV_PCM_STREAM_PLAYBACK) {

s/ ==  / == /

> +		ret = regmap_fields_write(dmactl->codec_intf, id, LPASS_CDC_DMA_RX0_INTERFACE);
> +		if (ret) {
> +			dev_err(soc_runtime->dev,
> +				"error writing to rdmactl reg: %d\n", ret);

Some of the logs print the register name, others don't, why not log it
always?

> +			return ret;
> +		}
> +	    ret = regmap_fields_write(dmactl->codec_fs_sel, id, 0x0);

fix indentation

> +		if (ret) {
> +			dev_err(soc_runtime->dev,
> +				"error writing to rdmactl reg: %d\n", ret);
> +			return ret;
> +		}
> +		ret = regmap_fields_write(dmactl->codec_fs_delay, id, 0x0);
> +		if (ret) {
> +			dev_err(soc_runtime->dev,
> +				"error writing to rdmactl codec_fs_delay reg field: %d\n", ret);
> +			return ret;
> +		}
> +		ret = regmap_fields_write(dmactl->codec_pack, id, 0x1);
> +		if (ret) {
> +			dev_err(soc_runtime->dev,
> +				"error writing to rdmactl codec_pack reg field: %d\n", ret);
> +			return ret;
> +		}
> +		ret = regmap_fields_write(dmactl->codec_enable, id, LPAIF_DMACTL_ENABLE_ON);
> +		if (ret) {
> +			dev_err(soc_runtime->dev,
> +				"error writing to rdmactl reg: %d\n", ret);
> +			return ret;
> +		}
> +

Remove empty line

> +	} else {
> +		ret = regmap_fields_write(dmactl->codec_intf, id, LPASS_CDC_DMA_INTERFACE(dai_id));
> +		if (ret) {
> +			dev_err(soc_runtime->dev,
> +				"error writing to wrdmactl codec_intf reg field: %d\n", ret);
> +			return ret;
> +		}
> +	    ret = regmap_fields_write(dmactl->codec_fs_sel, id, 0x0);

fix indentation

> +		if (ret) {
> +			dev_err(soc_runtime->dev,
> +				"error writing to wrdmactl codec_fs_sel reg field: %d\n", ret);
> +			return ret;
> +		}
> +		ret = regmap_fields_write(dmactl->codec_fs_delay, id, 0x0);
> +		if (ret) {
> +			dev_err(soc_runtime->dev,
> +				"error writing to wrdmactl codec_fs_delay reg field: %d\n", ret);
> +			return ret;
> +		}
> +		ret = regmap_fields_write(dmactl->codec_pack, id, 0x1);
> +		if (ret) {
> +			dev_err(soc_runtime->dev,
> +				"error writing to wrdmactl codec_pack reg field: %d\n", ret);
> +			return ret;
> +		}
> +		ret = regmap_fields_write(dmactl->codec_enable, id, LPAIF_DMACTL_ENABLE_ON);
> +		if (ret) {
> +			dev_err(soc_runtime->dev,
> +				"error writing to wrdmactl codec_enable reg field: %d\n", ret);
> +			return ret;
> +		}

The last four register writes are exactly the same in both branches, only the
logging distinguishes between 'rdmactl' and 'wrdmactl'. Those should be in the
main branch, if you really need to distinguish between 'rdmactl' and 'wrdmactl'
in the logging you can assign a string pointer in the 'if (dir == SNDRV_PCM_STREAM_PLAYBACK)'
branches.

> +	}
> +	return 0;
> +}
> +
> +static int lpass_wcd_daiops_startup(struct snd_pcm_substream *substream,
> +		struct snd_soc_dai *dai)
> +{
> +	struct lpass_data *drvdata = snd_soc_dai_get_drvdata(dai);
> +	int ret, i;
> +
> +	for (i = 0; i < drvdata->cdc_num_clks; i++) {
> +		ret = clk_prepare_enable(drvdata->cdc_dma_clks[i]);
> +		if (ret) {
> +			dev_err(dai->dev, "error in enabling cdc dma clks: %d\n", ret);
> +			return ret;

Disable clocks that have been enabled previously?

> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static void lpass_wcd_daiops_shutdown(struct snd_pcm_substream *substream,
> +		struct snd_soc_dai *dai)
> +{
> +	int i;
> +	struct lpass_data *drvdata = snd_soc_dai_get_drvdata(dai);
> +
> +	for (i = 0; i < drvdata->cdc_num_clks; i++)
> +		clk_disable_unprepare(drvdata->cdc_dma_clks[i]);
> +}
> +
> +static int lpass_wcd_daiops_hw_params(struct snd_pcm_substream *substream,
> +		struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
> +{
> +	struct snd_soc_pcm_runtime *soc_runtime = asoc_substream_to_rtd(substream);
> +	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(soc_runtime, 0);
> +	struct lpaif_dmactl *dmactl;
> +	struct lpass_data *drvdata = snd_soc_dai_get_drvdata(dai);
> +	struct snd_pcm_runtime *rt = substream->runtime;
> +	struct lpass_pcm_data *pcm_data = rt->private_data;
> +	struct lpass_variant *v = drvdata->variant;
> +	struct regmap *map;
> +	int dir = substream->stream;
> +	unsigned int ret, regval;
> +	unsigned int channels = params_channels(params);
> +	int id;
> +	unsigned int dai_id = cpu_dai->driver->id;
> +
> +	if (dir == SNDRV_PCM_STREAM_PLAYBACK) {
> +		dmactl = drvdata->rxtx_rd_dmactl;
> +		map = drvdata->rxtx_lpaif_map;
> +		id = pcm_data->dma_ch;
> +	} else {
> +		if (dai_id == LPASS_CDC_DMA_TX3) {
> +			dmactl = drvdata->rxtx_wr_dmactl;
> +			map = drvdata->rxtx_lpaif_map;
> +			id = pcm_data->dma_ch - v->rxtx_wrdma_channel_start;
> +		} else if (dai_id == LPASS_CDC_DMA_VA_TX0) {
> +			dmactl = drvdata->va_wr_dmactl;
> +			map = drvdata->va_lpaif_map;
> +			id = pcm_data->dma_ch - v->va_wrdma_channel_start;
> +		}
> +	}

The exact same code block is used 3 times in this driver. Add a helper with
'substream' and 'dai' as parameters, which determines 'dmactl and 'id'.
That would also make the variable declaration/assignment section of these
functions signifcantly shorter.

> +
> +	switch (channels) {
> +	case 1:
> +		regval = LPASS_CDC_DMA_INTF_ONE_CHANNEL;
> +		break;
> +	case 2:
> +		regval = LPASS_CDC_DMA_INTF_TWO_CHANNEL;
> +		break;
> +	case 4:
> +		regval = LPASS_CDC_DMA_INTF_FOUR_CHANNEL;
> +		break;
> +	case 6:
> +		regval = LPASS_CDC_DMA_INTF_SIX_CHANNEL;
> +		break;
> +	case 8:
> +		regval = LPASS_CDC_DMA_INTF_EIGHT_CHANNEL;
> +		break;
> +	default:
> +		dev_err(soc_runtime->dev, "invalid PCM config\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = regmap_fields_write(dmactl->codec_channel, id, regval);
> +	if (ret) {
> +		dev_err(soc_runtime->dev,
> +			"error writing to rdmactl codec_channel reg field: %d\n", ret);

not necessarily 'rdmactl'.

> +		return ret;
> +	}
> +	return ret;

	return 0

> +}
> +
> +static int lpass_wcd_daiops_trigger(struct snd_pcm_substream *substream,
> +		int cmd, struct snd_soc_dai *dai)
> +{
> +	struct snd_soc_pcm_runtime *soc_runtime = asoc_substream_to_rtd(substream);
> +	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(soc_runtime, 0);
> +	struct lpass_data *drvdata = snd_soc_dai_get_drvdata(dai);
> +	struct snd_pcm_runtime *rt = substream->runtime;
> +	struct lpass_pcm_data *pcm_data = rt->private_data;
> +	struct lpass_variant *v = drvdata->variant;
> +	int dir = substream->stream;
> +	struct lpaif_dmactl *dmactl;
> +	struct regmap *map;
> +	unsigned int dai_id = cpu_dai->driver->id;
> +	int ret = 0, id;
> +
> +	if (dir == SNDRV_PCM_STREAM_PLAYBACK) {
> +		dmactl = drvdata->rxtx_rd_dmactl;
> +		map = drvdata->rxtx_lpaif_map;
> +		id = pcm_data->dma_ch;
> +	} else {
> +		if (dai_id == LPASS_CDC_DMA_TX3) {
> +			dmactl = drvdata->rxtx_wr_dmactl;
> +			map = drvdata->rxtx_lpaif_map;
> +			id = pcm_data->dma_ch - v->rxtx_wrdma_channel_start;
> +		} else if (dai_id == LPASS_CDC_DMA_VA_TX0) {
> +			dmactl = drvdata->va_wr_dmactl;
> +			map = drvdata->va_lpaif_map;
> +			id = pcm_data->dma_ch - v->va_wrdma_channel_start;
> +		}
> +	}

see above

> +	switch (cmd) {
> +	case SNDRV_PCM_TRIGGER_START:
> +	case SNDRV_PCM_TRIGGER_RESUME:
> +	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> +		__lpass_platform_codec_intf_init(dai, substream);
> +		break;
> +	case SNDRV_PCM_TRIGGER_STOP:
> +	case SNDRV_PCM_TRIGGER_SUSPEND:
> +	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
> +		ret = regmap_fields_write(dmactl->codec_enable, id, LPAIF_DMACTL_ENABLE_OFF);
> +		if (ret) {
> +			dev_err(soc_runtime->dev,
> +				"error writing to rdmactl reg: %d\n", ret);

not necessarily rdmactl, better log that it's the codec enable reg.

> +			return ret;
> +		}
> +
> +		break;
> +	}
> +	return ret;
> +}
> +
> +const struct snd_soc_dai_ops asoc_qcom_lpass_wcd_dai_ops = {
> +	.startup	= lpass_wcd_daiops_startup,
> +	.shutdown	= lpass_wcd_daiops_shutdown,
> +	.hw_params	= lpass_wcd_daiops_hw_params,
> +	.trigger	= lpass_wcd_daiops_trigger,
> +};
> +EXPORT_SYMBOL_GPL(asoc_qcom_lpass_wcd_dai_ops);
> +
> +MODULE_DESCRIPTION("QTi LPASS CDC DMA Driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/sound/soc/qcom/lpass.h b/sound/soc/qcom/lpass.h
> index 058b42d..e0ea698 100644
> --- a/sound/soc/qcom/lpass.h
> +++ b/sound/soc/qcom/lpass.h
> @@ -418,5 +418,6 @@ int asoc_qcom_lpass_cpu_dai_probe(struct snd_soc_dai *dai);
>  extern const struct snd_soc_dai_ops asoc_qcom_lpass_cpu_dai_ops;
>  int lpass_cpu_pcm_new(struct snd_soc_pcm_runtime *rtd,
>  				struct snd_soc_dai *dai);
> +extern const struct snd_soc_dai_ops asoc_qcom_lpass_wcd_dai_ops;
>  
>  #endif /* __LPASS_H__ */
> -- 
> Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
> is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
> 
