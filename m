Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36E2E3BEC59
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 18:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbhGGQic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 12:38:32 -0400
Received: from mga17.intel.com ([192.55.52.151]:55266 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230280AbhGGQia (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 12:38:30 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10037"; a="189718249"
X-IronPort-AV: E=Sophos;i="5.84,220,1620716400"; 
   d="scan'208";a="189718249"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2021 09:35:36 -0700
X-IronPort-AV: E=Sophos;i="5.84,220,1620716400"; 
   d="scan'208";a="645442795"
Received: from cmcarran-mobl.amr.corp.intel.com (HELO [10.213.189.140]) ([10.213.189.140])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2021 09:35:35 -0700
Subject: Re: [PATCH 07/12] ASoC: amd: add ACP5x pcm dma driver ops
To:     Vijendar Mukunda <vijendar.mukunda@amd.com>, broonie@kernel.org,
        alsa-devel@alsa-project.org
Cc:     Sunil-kumar.Dommati@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>, Alexander.Deucher@amd.com
References: <20210707055623.27371-1-vijendar.mukunda@amd.com>
 <20210707055623.27371-8-vijendar.mukunda@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <c2ca7755-9a28-792f-78b1-5be62474672a@linux.intel.com>
Date:   Wed, 7 Jul 2021 11:27:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210707055623.27371-8-vijendar.mukunda@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/7/21 12:56 AM, Vijendar Mukunda wrote:
> This patch adds ACP5x PCM driver DMA operations.
> 
> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> ---
>  sound/soc/amd/vangogh/acp5x-pcm-dma.c | 306 +++++++++++++++++++++++++-
>  sound/soc/amd/vangogh/acp5x.h         | 106 +++++++++
>  2 files changed, 410 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/amd/vangogh/acp5x-pcm-dma.c b/sound/soc/amd/vangogh/acp5x-pcm-dma.c
> index d79712587d30..a4235cf33548 100644
> --- a/sound/soc/amd/vangogh/acp5x-pcm-dma.c
> +++ b/sound/soc/amd/vangogh/acp5x-pcm-dma.c
> @@ -17,8 +17,42 @@
>  
>  #define DRV_NAME "acp5x_i2s_dma"
>  
> -static const struct snd_soc_component_driver acp5x_i2s_component = {
> -	.name		= DRV_NAME,
> +static const struct snd_pcm_hardware acp5x_pcm_hardware_playback = {
> +	.info = SNDRV_PCM_INFO_INTERLEAVED |
> +		SNDRV_PCM_INFO_BLOCK_TRANSFER |
> +		SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID |
> +		SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_RESUME,
> +	.formats = SNDRV_PCM_FMTBIT_S16_LE |  SNDRV_PCM_FMTBIT_S8 |
> +		   SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S32_LE,

is S24_4LE supported? seems more useful than 8-bit audio these days, no?

> +static void config_acp5x_dma(struct i2s_stream_instance *rtd, int direction)
> +{
> +	u16 page_idx;
> +	u32 low, high, val, acp_fifo_addr, reg_fifo_addr;
> +	u32 reg_dma_size, reg_fifo_size;
> +	dma_addr_t addr;
> +
> +	addr = rtd->dma_addr;
> +	if (direction == SNDRV_PCM_STREAM_PLAYBACK) {
> +		switch (rtd->i2s_instance) {
> +		case I2S_HS_INSTANCE:
> +			val = ACP_SRAM_HS_PB_PTE_OFFSET;
> +			break;
> +		case I2S_SP_INSTANCE:
> +		default:
> +			val = ACP_SRAM_SP_PB_PTE_OFFSET;
> +		}
> +	} else {
> +		switch (rtd->i2s_instance) {
> +		case I2S_HS_INSTANCE:
> +			val = ACP_SRAM_HS_CP_PTE_OFFSET;
> +			break;
> +		case I2S_SP_INSTANCE:
> +		default:
> +			val = ACP_SRAM_SP_CP_PTE_OFFSET;
> +		}
> +	}
> +	/* Group Enable */
> +	acp_writel(ACP_SRAM_PTE_OFFSET | BIT(31), rtd->acp5x_base +
> +		   ACPAXI2AXI_ATU_BASE_ADDR_GRP_1);
> +	acp_writel(PAGE_SIZE_4K_ENABLE, rtd->acp5x_base +
> +		   ACPAXI2AXI_ATU_PAGE_SIZE_GRP_1);
> +
> +	for (page_idx = 0; page_idx < rtd->num_pages; page_idx++) {
> +		/* Load the low address of page int ACP SRAM through SRBM */
> +		low = lower_32_bits(addr);
> +		high = upper_32_bits(addr);
> +
> +		acp_writel(low, rtd->acp5x_base + ACP_SCRATCH_REG_0 + val);
> +		high |= BIT(31);
> +		acp_writel(high, rtd->acp5x_base + ACP_SCRATCH_REG_0 + val
> +			   + 4);

use single line? I find the indentation style quite an eyesore...


> +		/* Move to next physically contiguous page */
> +		val += 8;
> +		addr += PAGE_SIZE;
> +	}
> +
> +	if (direction == SNDRV_PCM_STREAM_PLAYBACK) {
> +		switch (rtd->i2s_instance) {
> +		case I2S_HS_INSTANCE:
> +			reg_dma_size = ACP_HS_TX_DMA_SIZE;
> +			acp_fifo_addr = ACP_SRAM_PTE_OFFSET +
> +					HS_PB_FIFO_ADDR_OFFSET;
> +			reg_fifo_addr = ACP_HS_TX_FIFOADDR;
> +			reg_fifo_size = ACP_HS_TX_FIFOSIZE;
> +			acp_writel(I2S_HS_TX_MEM_WINDOW_START,
> +				   rtd->acp5x_base + ACP_HS_TX_RINGBUFADDR);
> +			break;
> +
> +		case I2S_SP_INSTANCE:
> +		default:
> +			reg_dma_size = ACP_I2S_TX_DMA_SIZE;
> +			acp_fifo_addr = ACP_SRAM_PTE_OFFSET +
> +					SP_PB_FIFO_ADDR_OFFSET;
> +			reg_fifo_addr =	ACP_I2S_TX_FIFOADDR;
> +			reg_fifo_size = ACP_I2S_TX_FIFOSIZE;
> +			acp_writel(I2S_SP_TX_MEM_WINDOW_START,
> +				   rtd->acp5x_base + ACP_I2S_TX_RINGBUFADDR);
> +		}
> +	} else {
> +		switch (rtd->i2s_instance) {
> +		case I2S_HS_INSTANCE:
> +			reg_dma_size = ACP_HS_RX_DMA_SIZE;
> +			acp_fifo_addr = ACP_SRAM_PTE_OFFSET +
> +					HS_CAPT_FIFO_ADDR_OFFSET;
> +			reg_fifo_addr = ACP_HS_RX_FIFOADDR;
> +			reg_fifo_size = ACP_HS_RX_FIFOSIZE;
> +			acp_writel(I2S_HS_RX_MEM_WINDOW_START,
> +				   rtd->acp5x_base + ACP_HS_RX_RINGBUFADDR);
> +			break;
> +
> +		case I2S_SP_INSTANCE:
> +		default:
> +			reg_dma_size = ACP_I2S_RX_DMA_SIZE;
> +			acp_fifo_addr = ACP_SRAM_PTE_OFFSET +
> +					SP_CAPT_FIFO_ADDR_OFFSET;
> +			reg_fifo_addr = ACP_I2S_RX_FIFOADDR;
> +			reg_fifo_size = ACP_I2S_RX_FIFOSIZE;
> +			acp_writel(I2S_SP_RX_MEM_WINDOW_START,
> +				   rtd->acp5x_base + ACP_I2S_RX_RINGBUFADDR);
> +		}
> +	}
> +	acp_writel(DMA_SIZE, rtd->acp5x_base + reg_dma_size);
> +	acp_writel(acp_fifo_addr, rtd->acp5x_base + reg_fifo_addr);
> +	acp_writel(FIFO_SIZE, rtd->acp5x_base + reg_fifo_size);
> +	acp_writel(BIT(I2S_RX_THRESHOLD) | BIT(HS_RX_THRESHOLD)
> +		   | BIT(I2S_TX_THRESHOLD) | BIT(HS_TX_THRESHOLD),
> +		   rtd->acp5x_base + ACP_EXTERNAL_INTR_CNTL);
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
> +		pr_err("pinfo failed\n");

that seems like a rather useless message. if you want a log at least use dev_err(component->dev

> +	}
> +	size = params_buffer_bytes(params);
> +	rtd->dma_addr = substream->dma_buffer.addr;
> +	rtd->num_pages = (PAGE_ALIGN(size) >> PAGE_SHIFT);
> +	config_acp5x_dma(rtd, substream->stream);
> +	return 0;
> +}
> +
