Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 475ED3CED50
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 22:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383125AbhGSRwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 13:52:53 -0400
Received: from mga01.intel.com ([192.55.52.88]:33823 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241373AbhGSRn6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 13:43:58 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10050"; a="232883868"
X-IronPort-AV: E=Sophos;i="5.84,252,1620716400"; 
   d="scan'208";a="232883868"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2021 11:24:36 -0700
X-IronPort-AV: E=Sophos;i="5.84,252,1620716400"; 
   d="scan'208";a="414430046"
Received: from rraymond-mobl1.amr.corp.intel.com (HELO [10.209.130.70]) ([10.209.130.70])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2021 11:24:35 -0700
Subject: Re: [PATCH V3 06/12] ASoC: amd: irq handler changes for ACP5x PCM dma
 driver
To:     Vijendar Mukunda <vijendar.mukunda@amd.com>, broonie@kernel.org,
        alsa-devel@alsa-project.org
Cc:     Sunil-kumar.Dommati@amd.com,
        open list <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Alexander.Deucher@amd.com,
        krisman@collabora.com
References: <20210719165140.16143-1-vijendar.mukunda@amd.com>
 <20210719165140.16143-7-vijendar.mukunda@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <a9566929-0fa0-f8f0-58ce-99a1e111e6a2@linux.intel.com>
Date:   Mon, 19 Jul 2021 13:11:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210719165140.16143-7-vijendar.mukunda@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> +static irqreturn_t i2s_irq_handler(int irq, void *dev_id)
> +{
> +	struct i2s_dev_data *vg_i2s_data;
> +	u16 irq_flag;
> +	u32 val;
> +
> +	vg_i2s_data = dev_id;
> +	if (!vg_i2s_data)
> +		return IRQ_NONE;
> +
> +	irq_flag = 0;
> +	val = acp_readl(vg_i2s_data->acp5x_base + ACP_EXTERNAL_INTR_STAT);
> +	if ((val & BIT(HS_TX_THRESHOLD)) && vg_i2s_data->play_stream) {
> +		acp_writel(BIT(HS_TX_THRESHOLD), vg_i2s_data->acp5x_base +
> +			   ACP_EXTERNAL_INTR_STAT);
> +		snd_pcm_period_elapsed(vg_i2s_data->play_stream);
> +		irq_flag = 1;
> +	}
> +	if ((val & BIT(I2S_TX_THRESHOLD)) &&
> +	    vg_i2s_data->i2ssp_play_stream) {

use single line?

> +		acp_writel(BIT(I2S_TX_THRESHOLD),
> +			   vg_i2s_data->acp5x_base + ACP_EXTERNAL_INTR_STAT);
> +		snd_pcm_period_elapsed(vg_i2s_data->i2ssp_play_stream);
> +		irq_flag = 1;
> +	}
> +
> +	if ((val & BIT(HS_RX_THRESHOLD)) && vg_i2s_data->capture_stream) {
> +		acp_writel(BIT(HS_RX_THRESHOLD), vg_i2s_data->acp5x_base +
> +			   ACP_EXTERNAL_INTR_STAT);
> +		snd_pcm_period_elapsed(vg_i2s_data->capture_stream);
> +		irq_flag = 1;
> +	}
> +	if ((val & BIT(I2S_RX_THRESHOLD)) &&
> +	    vg_i2s_data->i2ssp_capture_stream) {

use single line?

> +		acp_writel(BIT(I2S_RX_THRESHOLD),
> +			   vg_i2s_data->acp5x_base + ACP_EXTERNAL_INTR_STAT);
> +		snd_pcm_period_elapsed(vg_i2s_data->i2ssp_capture_stream);
> +		irq_flag = 1;
> +	}
> +
> +	if (irq_flag)
> +		return IRQ_HANDLED;
> +	else
> +		return IRQ_NONE;
> +}
> +
>  static int acp5x_audio_probe(struct platform_device *pdev)
>  {
>  	struct resource *res;
>  	struct i2s_dev_data *adata;
> +	unsigned int irqflags;
>  	int status;
>  
>  	if (!pdev->dev.platform_data) {
> @@ -47,6 +94,14 @@ static int acp5x_audio_probe(struct platform_device *pdev)
>  					 resource_size(res));
>  	if (!adata->acp5x_base)
>  		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> +	if (!res) {
> +		dev_err(&pdev->dev, "IORESOURCE_IRQ FAILED\n");
> +		return -ENODEV;
> +	}
> +
> +	adata->i2s_irq = res->start;
>  	dev_set_drvdata(&pdev->dev, adata);
>  	status = devm_snd_soc_register_component(&pdev->dev,
>  						 &acp5x_i2s_component,
> @@ -55,6 +110,12 @@ static int acp5x_audio_probe(struct platform_device *pdev)
>  		dev_err(&pdev->dev, "Fail to register acp i2s component\n");
>  		return -ENODEV;
>  	}
> +	status = devm_request_irq(&pdev->dev, adata->i2s_irq, i2s_irq_handler,
> +				  irqflags, "ACP5x_I2S_IRQ", adata);
> +	if (status) {
> +		dev_err(&pdev->dev, "ACP5x I2S IRQ request failed\n");
> +		return -ENODEV;
> +	}

return status?

>  	return 0;
>  }
>  
> diff --git a/sound/soc/amd/vangogh/acp5x.h b/sound/soc/amd/vangogh/acp5x.h
> index d2853738eb17..18df2b5a4283 100644
> --- a/sound/soc/amd/vangogh/acp5x.h
> +++ b/sound/soc/amd/vangogh/acp5x.h
> @@ -31,9 +31,18 @@
>  #define ACP5x_HS_TDM_REG_END	0x1242824
>  #define I2S_MODE 0x00
>  #define ACP5x_I2S_MODE 0x00
> +#define	I2S_RX_THRESHOLD 27
> +#define	I2S_TX_THRESHOLD 28
> +#define	HS_TX_THRESHOLD 24
> +#define	HS_RX_THRESHOLD 23
>  
>  struct i2s_dev_data {
> +	unsigned int i2s_irq;
>  	void __iomem *acp5x_base;
> +	struct snd_pcm_substream *play_stream;
> +	struct snd_pcm_substream *capture_stream;
> +	struct snd_pcm_substream *i2ssp_play_stream;
> +	struct snd_pcm_substream *i2ssp_capture_stream;
>  };
>  
>  /* common header file uses exact offset rather than relative
> 
