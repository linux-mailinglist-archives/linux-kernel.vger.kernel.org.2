Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF5DB400386
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 18:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350123AbhICQjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 12:39:17 -0400
Received: from mga09.intel.com ([134.134.136.24]:17730 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350115AbhICQjQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 12:39:16 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10096"; a="219477882"
X-IronPort-AV: E=Sophos;i="5.85,265,1624345200"; 
   d="scan'208";a="219477882"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2021 09:38:02 -0700
X-IronPort-AV: E=Sophos;i="5.85,265,1624345200"; 
   d="scan'208";a="462453533"
Received: from seangorm-mobl.amr.corp.intel.com (HELO [10.251.136.111]) ([10.251.136.111])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2021 09:38:01 -0700
Subject: Re: [PATCH v2 1/2] ASoC: SOF: imx: Add code to manage DSP related
 clocks
To:     Daniel Baluta <daniel.baluta@oss.nxp.com>, broonie@kernel.org,
        lgirdwood@gmail.com, robh+dt@kernel.org,
        ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com
Cc:     devicetree@vger.kernel.org, shawnguo@kernel.org,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        peter.ujfalusi@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, s-anna@ti.com,
        Daniel Baluta <daniel.baluta@nxp.com>
References: <20210903145340.225511-1-daniel.baluta@oss.nxp.com>
 <20210903145340.225511-2-daniel.baluta@oss.nxp.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <bffb60bf-2497-2025-c16c-5519c96f9769@linux.intel.com>
Date:   Fri, 3 Sep 2021 11:06:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210903145340.225511-2-daniel.baluta@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/3/21 9:53 AM, Daniel Baluta wrote:
> From: Daniel Baluta <daniel.baluta@nxp.com>
> 
> There are two types of clocks:
> 	* DSP IP clocks
> 	* DAI clocks
> 
> This clocks are necessary in order to power up DSP and DAIs.
> 
> We choose to enable DAI clocks here because of the way i.MX8/i.MX8X
> design handles resources (including clocks).
> 
> All clocks are managed by a separate core (named SCU) which communicates
> with Linux managed ARM core via a well known API.
> 
> We parse and enable the clocks in probe function and disable them in
> remove function.
> 
> Future patches will introduce Power Management support so that we
> disable clocks while DSP is not used or system enters power save.
> 
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>  sound/soc/sof/imx/imx-common.c | 44 ++++++++++++++++++++++++++++++++++
>  sound/soc/sof/imx/imx-common.h | 13 ++++++++++
>  sound/soc/sof/imx/imx8.c       | 37 ++++++++++++++++++++++++++++
>  sound/soc/sof/imx/imx8m.c      | 34 ++++++++++++++++++++++++++
>  4 files changed, 128 insertions(+)
> 
> diff --git a/sound/soc/sof/imx/imx-common.c b/sound/soc/sof/imx/imx-common.c
> index 8826ef94f04a..f9d650ad3846 100644
> --- a/sound/soc/sof/imx/imx-common.c
> +++ b/sound/soc/sof/imx/imx-common.c
> @@ -74,4 +74,48 @@ void imx8_dump(struct snd_sof_dev *sdev, u32 flags)
>  }
>  EXPORT_SYMBOL(imx8_dump);
>  
> +int imx8_parse_clocks(struct snd_sof_dev *sdev, struct imx_clocks *clks)
> +{
> +	int ret;
> +
> +	ret = devm_clk_bulk_get(sdev->dev, clks->num_dsp_clks, clks->dsp_clks);
> +	if (ret) {
> +		dev_err(sdev->dev, "Failed to request DSP clocks\n");
> +		return ret;
> +	}
> +
> +	ret = devm_clk_bulk_get_optional(sdev->dev, clks->num_dai_clks, clks->dai_clks);
> +	if (ret) {
> +		dev_err(sdev->dev, "Failed to request DAI clks\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(imx8_parse_clocks);
> +
> +int imx8_enable_clocks(struct snd_sof_dev *sdev, struct imx_clocks *clks)
> +{
> +	int ret;
> +
> +	ret = clk_bulk_prepare_enable(clks->num_dsp_clks, clks->dsp_clks);
> +	if (ret)
> +		return ret;
> +	ret = clk_bulk_prepare_enable(clks->num_dai_clks, clks->dai_clks);
> +	if (ret) {
> +		clk_bulk_disable_unprepare(clks->num_dsp_clks, clks->dsp_clks);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(imx8_enable_clocks);
> +
> +void imx8_disable_clocks(struct snd_sof_dev *sdev, struct imx_clocks *clks)
> +{
> +	clk_bulk_disable_unprepare(clks->num_dsp_clks, clks->dsp_clks);
> +	clk_bulk_disable_unprepare(clks->num_dai_clks, clks->dai_clks);
> +}
> +EXPORT_SYMBOL(imx8_disable_clocks);
> +
>  MODULE_LICENSE("Dual BSD/GPL");
> diff --git a/sound/soc/sof/imx/imx-common.h b/sound/soc/sof/imx/imx-common.h
> index 1cc7d6704182..54fba9fcd861 100644
> --- a/sound/soc/sof/imx/imx-common.h
> +++ b/sound/soc/sof/imx/imx-common.h
> @@ -3,6 +3,8 @@
>  #ifndef __IMX_COMMON_H__
>  #define __IMX_COMMON_H__
>  
> +#include <linux/clk.h>
> +
>  #define EXCEPT_MAX_HDR_SIZE	0x400
>  #define IMX8_STACK_DUMP_SIZE 32
>  
> @@ -13,4 +15,15 @@ void imx8_get_registers(struct snd_sof_dev *sdev,
>  
>  void imx8_dump(struct snd_sof_dev *sdev, u32 flags);
>  
> +struct imx_clocks {
> +	struct clk_bulk_data *dsp_clks;
> +	int num_dsp_clks;
> +	struct clk_bulk_data *dai_clks;
> +	int num_dai_clks;
> +};
> +
> +int imx8_parse_clocks(struct snd_sof_dev *sdev, struct imx_clocks *clks);
> +int imx8_enable_clocks(struct snd_sof_dev *sdev, struct imx_clocks *clks);
> +void imx8_disable_clocks(struct snd_sof_dev *sdev, struct imx_clocks *clks);
> +
>  #endif
> diff --git a/sound/soc/sof/imx/imx8.c b/sound/soc/sof/imx/imx8.c
> index fc1720c211a3..5370d34edd61 100644
> --- a/sound/soc/sof/imx/imx8.c
> +++ b/sound/soc/sof/imx/imx8.c
> @@ -41,6 +41,25 @@
>  #define MBOX_OFFSET	0x800000
>  #define MBOX_SIZE	0x1000
>  
> +/* DSP clocks */
> +struct clk_bulk_data imx8_dsp_clks[] = {
> +	{ .id = "ipg" },
> +	{ .id = "ocram" },
> +	{ .id = "core" },
> +};
> +
> +/* DAI clocks */
> +struct clk_bulk_data imx8_dai_clks[] = {
> +	{ .id = "esai0_core" },
> +	{ .id = "esai0_extal" },
> +	{ .id = "esai0_spba" },
> +	{ .id = "sai1_bus" },
> +	{ .id = "sai1_mclk0" },
> +	{ .id = "sai1_mclk1" },
> +	{ .id = "sai1_mclk2" },
> +	{ .id = "sai1_mclk3" },
> +};
> +
>  struct imx8_priv {
>  	struct device *dev;
>  	struct snd_sof_dev *sdev;
> @@ -57,6 +76,7 @@ struct imx8_priv {
>  	struct device **pd_dev;
>  	struct device_link **link;
>  
> +	struct imx_clocks *clks;
>  };
>  
>  static void imx8_get_reply(struct snd_sof_dev *sdev)
> @@ -223,6 +243,10 @@ static int imx8_probe(struct snd_sof_dev *sdev)
>  	if (!priv)
>  		return -ENOMEM;
>  
> +	priv->clks = devm_kzalloc(&pdev->dev, sizeof(*priv->clks), GFP_KERNEL);
> +	if (!priv->clks)
> +		return -ENOMEM;
> +
>  	sdev->num_cores = 1;
>  	sdev->pdata->hw_pdata = priv;
>  	priv->dev = sdev->dev;
> @@ -336,6 +360,18 @@ static int imx8_probe(struct snd_sof_dev *sdev)
>  	/* set default mailbox offset for FW ready message */
>  	sdev->dsp_box.offset = MBOX_OFFSET;
>  
> +	/* init clocks info */
> +	priv->clks->dsp_clks = imx8_dsp_clks;
> +	priv->clks->num_dsp_clks = ARRAY_SIZE(imx8_dsp_clks);
> +	priv->clks->dai_clks = imx8_dai_clks;
> +	priv->clks->num_dai_clks = ARRAY_SIZE(imx8_dai_clks);
> +
> +	ret = imx8_parse_clocks(sdev, priv->clks);
> +	if (ret < 0)
> +		goto exit_pdev_unregister;
> +
> +	imx8_enable_clocks(sdev, priv->clks);
> +
>  	return 0;
>  
>  exit_pdev_unregister:
> @@ -354,6 +390,7 @@ static int imx8_remove(struct snd_sof_dev *sdev)
>  	struct imx8_priv *priv = sdev->pdata->hw_pdata;
>  	int i;
>  
> +	imx8_disable_clocks(sdev, priv->clks);
>  	platform_device_unregister(priv->ipc_dev);
>  
>  	for (i = 0; i < priv->num_domains; i++) {
> diff --git a/sound/soc/sof/imx/imx8m.c b/sound/soc/sof/imx/imx8m.c
> index 30624fafc632..fea1b72bebaa 100644
> --- a/sound/soc/sof/imx/imx8m.c
> +++ b/sound/soc/sof/imx/imx8m.c
> @@ -23,6 +23,21 @@
>  #define MBOX_OFFSET	0x800000
>  #define MBOX_SIZE	0x1000
>  
> +struct clk_bulk_data imx8m_dsp_clks[] = {
> +	{ .id = "ipg" },
> +	{ .id = "ocram" },
> +	{ .id = "core" },
> +};
> +
> +struct clk_bulk_data imx8m_dai_clks[] = {
> +	{ .id = "sai3_bus" },
> +	{ .id = "sai3_mclk0" },
> +	{ .id = "sai3_mclk1" },
> +	{ .id = "sai3_mclk2" },
> +	{ .id = "sai3_mclk3" },
> +	{ .id = "sdma3_root" },
> +};
> +
>  struct imx8m_priv {
>  	struct device *dev;
>  	struct snd_sof_dev *sdev;
> @@ -30,6 +45,8 @@ struct imx8m_priv {
>  	/* DSP IPC handler */
>  	struct imx_dsp_ipc *dsp_ipc;
>  	struct platform_device *ipc_dev;
> +
> +	struct imx_clocks *clks;
>  };
>  
>  static void imx8m_get_reply(struct snd_sof_dev *sdev)
> @@ -143,6 +160,10 @@ static int imx8m_probe(struct snd_sof_dev *sdev)
>  	if (!priv)
>  		return -ENOMEM;
>  
> +	priv->clks = devm_kzalloc(&pdev->dev, sizeof(*priv->clks), GFP_KERNEL);
> +	if (!priv->clks)
> +		return -ENOMEM;
> +
>  	sdev->num_cores = 1;
>  	sdev->pdata->hw_pdata = priv;
>  	priv->dev = sdev->dev;
> @@ -211,6 +232,18 @@ static int imx8m_probe(struct snd_sof_dev *sdev)
>  	/* set default mailbox offset for FW ready message */
>  	sdev->dsp_box.offset = MBOX_OFFSET;
>  
> +	/* init clocks info */
> +	priv->clks->dsp_clks = imx8m_dsp_clks;
> +	priv->clks->num_dsp_clks = ARRAY_SIZE(imx8m_dsp_clks);
> +	priv->clks->dai_clks = imx8m_dai_clks;
> +	priv->clks->num_dai_clks = ARRAY_SIZE(imx8m_dai_clks);
> +
> +	ret = imx8_parse_clocks(sdev, priv->clks);
> +	if (ret < 0)
> +		goto exit_pdev_unregister;
> +
> +	imx8_enable_clocks(sdev, priv->clks);
> +
>  	return 0;
>  
>  exit_pdev_unregister:
> @@ -222,6 +255,7 @@ static int imx8m_remove(struct snd_sof_dev *sdev)
>  {
>  	struct imx8m_priv *priv = sdev->pdata->hw_pdata;
>  
> +	imx8_disable_clocks(sdev, priv->clks);
>  	platform_device_unregister(priv->ipc_dev);
>  
>  	return 0;
> 
