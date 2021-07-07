Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C49C53BEC58
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 18:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbhGGQi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 12:38:29 -0400
Received: from mga17.intel.com ([192.55.52.151]:55266 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230238AbhGGQi2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 12:38:28 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10037"; a="189718237"
X-IronPort-AV: E=Sophos;i="5.84,220,1620716400"; 
   d="scan'208";a="189718237"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2021 09:35:32 -0700
X-IronPort-AV: E=Sophos;i="5.84,220,1620716400"; 
   d="scan'208";a="645442779"
Received: from cmcarran-mobl.amr.corp.intel.com (HELO [10.213.189.140]) ([10.213.189.140])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2021 09:35:31 -0700
Subject: Re: [PATCH 06/12] ASoC: amd: irq handler changes for ACP5x PCM dma
 driver
To:     Vijendar Mukunda <vijendar.mukunda@amd.com>, broonie@kernel.org,
        alsa-devel@alsa-project.org
Cc:     Sunil-kumar.Dommati@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>, Alexander.Deucher@amd.com
References: <20210707055623.27371-1-vijendar.mukunda@amd.com>
 <20210707055623.27371-7-vijendar.mukunda@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <6ae6e658-692e-70f2-6bda-ce139168aae3@linux.intel.com>
Date:   Wed, 7 Jul 2021 11:20:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210707055623.27371-7-vijendar.mukunda@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> +static irqreturn_t i2s_irq_handler(int irq, void *dev_id)
> +{
> +	struct i2s_dev_data *vg_i2s_data;
> +	u16 play_flag, cap_flag;
> +	u32 val;
> +
> +	vg_i2s_data = dev_id;
> +	if (!vg_i2s_data)
> +		return IRQ_NONE;
> +
> +	play_flag = 0;
> +	cap_flag = 0;
> +	val = acp_readl(vg_i2s_data->acp5x_base + ACP_EXTERNAL_INTR_STAT);
> +	if ((val & BIT(HS_TX_THRESHOLD)) && vg_i2s_data->play_stream) {
> +		acp_writel(BIT(HS_TX_THRESHOLD), vg_i2s_data->acp5x_base +
> +			   ACP_EXTERNAL_INTR_STAT);
> +		snd_pcm_period_elapsed(vg_i2s_data->play_stream);
> +		play_flag = 1;
> +	}
> +	if ((val & BIT(I2S_TX_THRESHOLD)) &&
> +	    vg_i2s_data->i2ssp_play_stream) {
> +		acp_writel(BIT(I2S_TX_THRESHOLD),
> +			   vg_i2s_data->acp5x_base + ACP_EXTERNAL_INTR_STAT);
> +		snd_pcm_period_elapsed(vg_i2s_data->i2ssp_play_stream);
> +		play_flag = 1;
> +	}
> +
> +	if ((val & BIT(HS_RX_THRESHOLD)) && vg_i2s_data->capture_stream) {
> +		acp_writel(BIT(HS_RX_THRESHOLD), vg_i2s_data->acp5x_base +
> +			   ACP_EXTERNAL_INTR_STAT);
> +		snd_pcm_period_elapsed(vg_i2s_data->capture_stream);
> +		cap_flag = 1;
> +	}
> +	if ((val & BIT(I2S_RX_THRESHOLD)) &&
> +	    vg_i2s_data->i2ssp_capture_stream) {
> +		acp_writel(BIT(I2S_RX_THRESHOLD),
> +			   vg_i2s_data->acp5x_base + ACP_EXTERNAL_INTR_STAT);
> +		snd_pcm_period_elapsed(vg_i2s_data->i2ssp_capture_stream);
> +		cap_flag = 1;
> +	}
> +
> +	if (play_flag | cap_flag)

it doesn't seem terribly useful to use two variables if you can use one?

> +		return IRQ_HANDLED;
> +	else
> +		return IRQ_NONE;
> +}
> +

