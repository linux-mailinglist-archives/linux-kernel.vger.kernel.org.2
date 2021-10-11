Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11B0E428944
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 10:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235348AbhJKJAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 05:00:39 -0400
Received: from smtprelay0123.hostedemail.com ([216.40.44.123]:40128 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235182AbhJKJAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 05:00:38 -0400
Received: from omf08.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id A19B9180498C4;
        Mon, 11 Oct 2021 08:58:37 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf08.hostedemail.com (Postfix) with ESMTPA id BCA631A29FC;
        Mon, 11 Oct 2021 08:58:35 +0000 (UTC)
Message-ID: <e71f1db7fecefa1f8eccd29d5a6cad3c126a1753.camel@perches.com>
Subject: Re: [PATCH 06/13] ASoC: amd: add acp6x irq handler
From:   Joe Perches <joe@perches.com>
To:     Vijendar Mukunda <Vijendar.Mukunda@amd.com>, broonie@kernel.org,
        alsa-devel@alsa-project.org
Cc:     Alexander.Deucher@amd.com, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, Mario.Limonciello@amd.com,
        Richard.Gong@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
Date:   Mon, 11 Oct 2021 01:58:34 -0700
In-Reply-To: <20211011055621.13240-7-Vijendar.Mukunda@amd.com>
References: <20211011055621.13240-1-Vijendar.Mukunda@amd.com>
         <20211011055621.13240-7-Vijendar.Mukunda@amd.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.10
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: BCA631A29FC
X-Stat-Signature: ekf4w1htyoc117ttotrgwqhc66msjcy8
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19emX/HhWPToL33rXhnSxB272awpFz6qdk=
X-HE-Tag: 1633942715-698277
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-10-11 at 11:26 +0530, Vijendar Mukunda wrote:
> Add ACP6x irq handler for handling irq events for ACP IP.
> Add pdm irq events handling.
> Whenever audio data equal to the PDM watermark level are consumed,
> interrupt is generated. Acknowledge the interrupt.

> diff --git a/sound/soc/amd/yc/pci-acp6x.c b/sound/soc/amd/yc/pci-acp6x.c
[]
> @@ -116,6 +118,33 @@ static int acp6x_deinit(void __iomem *acp_base)
>  	return 0;
>  }
> 
> +static irqreturn_t acp6x_irq_handler(int irq, void *dev_id)
> +{
> +	struct acp6x_dev_data *adata;
> +	struct pdm_dev_data *yc_pdm_data;
> +	u16 irq_flag;

irq_flag seems unnecessary.

> +	u32 val;
> +
> +	adata = dev_id;
> +	if (!adata)
> +		return IRQ_NONE;
> +
> +	irq_flag = 0;
> +	val = acp6x_readl(adata->acp6x_base + ACP_EXTERNAL_INTR_STAT);
> +	if (val & BIT(PDM_DMA_STAT)) {
> +		yc_pdm_data = dev_get_drvdata(&adata->pdev[0]->dev);
> +		acp6x_writel(BIT(PDM_DMA_STAT), adata->acp6x_base + ACP_EXTERNAL_INTR_STAT);
> +		if (yc_pdm_data->capture_stream)
> +			snd_pcm_period_elapsed(yc_pdm_data->capture_stream);
> +		irq_flag = 1;

Could be:

		return IRQ_HANDLED;

> +	}
> +
> +	if (irq_flag)
> +		return IRQ_HANDLED;
> +	else
> +		return IRQ_NONE;

and
	return IRQ_NONE;

> +}


