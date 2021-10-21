Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46F93436038
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 13:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbhJULaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 07:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbhJULai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 07:30:38 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C1FC06161C;
        Thu, 21 Oct 2021 04:28:22 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 2F02D1F449A2
Subject: Re: [PATCH v2 1/2] ASoC: SOF: mediatek: Add mt8195 dsp clock support
To:     YC Hung <yc.hung@mediatek.com>, broonie@kernel.org, tiwai@suse.com,
        robh+dt@kernel.org, matthias.bgg@gmail.com
Cc:     alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, daniel.baluta@nxp.com,
        trevor.wu@mediatek.com, allen-kh.cheng@mediatek.com
References: <20211021035841.2365-1-yc.hung@mediatek.com>
 <20211021035841.2365-2-yc.hung@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <1eed3c3a-61d7-17df-0ec2-01c44f45e226@collabora.com>
Date:   Thu, 21 Oct 2021 13:28:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211021035841.2365-2-yc.hung@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 21/10/21 05:58, YC Hung ha scritto:
> Add adsp clock on/off support on mt8195 platform.
> 
> Signed-off-by: YC Hung <yc.hung@mediatek.com>
> ---
>   sound/soc/sof/mediatek/mt8195/Makefile     |   2 +-
>   sound/soc/sof/mediatek/mt8195/mt8195-clk.c | 164 +++++++++++++++++++++
>   sound/soc/sof/mediatek/mt8195/mt8195-clk.h |  29 ++++
>   sound/soc/sof/mediatek/mt8195/mt8195.c     |  23 ++-
>   4 files changed, 215 insertions(+), 3 deletions(-)
>   create mode 100644 sound/soc/sof/mediatek/mt8195/mt8195-clk.c
>   create mode 100644 sound/soc/sof/mediatek/mt8195/mt8195-clk.h
> 

Hello,
Thanks for the patch! However, there's something to improve:

> diff --git a/sound/soc/sof/mediatek/mt8195/Makefile b/sound/soc/sof/mediatek/mt8195/Makefile
> index 60fca24c068a..650f4bce99b2 100644
> --- a/sound/soc/sof/mediatek/mt8195/Makefile
> +++ b/sound/soc/sof/mediatek/mt8195/Makefile
> @@ -1,4 +1,4 @@
>   # SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
> -snd-sof-mt8195-objs := mt8195.o mt8195-loader.o
> +snd-sof-mt8195-objs := mt8195.o mt8195-clk.o mt8195-loader.o
>   obj-$(CONFIG_SND_SOC_SOF_MT8195) += snd-sof-mt8195.o
>   
> diff --git a/sound/soc/sof/mediatek/mt8195/mt8195-clk.c b/sound/soc/sof/mediatek/mt8195/mt8195-clk.c
> new file mode 100644
> index 000000000000..1988421f7f7b
> --- /dev/null
> +++ b/sound/soc/sof/mediatek/mt8195/mt8195-clk.c
> @@ -0,0 +1,164 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
> +//
> +// Copyright(c) 2021 Mediatek Corporation. All rights reserved.
> +//
> +// Author: YC Hung <yc.hung@mediatek.com>
> +//
> +// Hardware interface for mt8195 DSP clock
> +
> +#include <linux/clk.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/io.h>
> +#include "mt8195.h"
> +#include "mt8195-clk.h"
> +
> +struct clk *clk_handle[ADSP_CLK_NUM];

I think that this one can be moved to `struct adsp_priv` (or elsewhere, if more
appropriate) as to not use global variables/handles.

> +
> +int platform_parse_clock(struct device *dev)
> +{
> +	clk_handle[CLK_TOP_ADSP] = devm_clk_get(dev, "adsp_sel");
> +	if (IS_ERR(clk_handle[CLK_TOP_ADSP])) {
> +		dev_err(dev, "clk_get(\"adsp_sel\") failed\n");
> +		return PTR_ERR(clk_handle[CLK_TOP_ADSP]);
> +	}
> +
> +	clk_handle[CLK_TOP_CLK26M] = devm_clk_get(dev, "clk26m_ck");
> +	if (IS_ERR(clk_handle[CLK_TOP_CLK26M])) {
> +		dev_err(dev, "clk_get(\"clk26m_ck\") failed\n");
> +		return PTR_ERR(clk_handle[CLK_TOP_CLK26M]);
> +	}
> +
> +	clk_handle[CLK_TOP_AUDIO_LOCAL_BUS] = devm_clk_get(dev, "audio_local_bus");
> +	if (IS_ERR(clk_handle[CLK_TOP_AUDIO_LOCAL_BUS])) {
> +		dev_err(dev, "clk_get(\"audio_local_bus\") failed\n");
> +		return PTR_ERR(clk_handle[CLK_TOP_AUDIO_LOCAL_BUS]);
> +	}
> +
> +	clk_handle[CLK_TOP_MAINPLL_D7_D2] = devm_clk_get(dev, "mainpll_d7_d2");
> +	if (IS_ERR(clk_handle[CLK_TOP_MAINPLL_D7_D2])) {
> +		dev_err(dev, "clk_get(\"mainpll_d7_d2\") failed\n");
> +		return PTR_ERR(clk_handle[CLK_TOP_MAINPLL_D7_D2]);
> +	}
> +
> +	clk_handle[CLK_SCP_ADSP_AUDIODSP] = devm_clk_get(dev, "scp_adsp_audiodsp");
> +	if (IS_ERR(clk_handle[CLK_SCP_ADSP_AUDIODSP])) {
> +		dev_err(dev, "clk_get(\"scp_adsp_audiodsp\") failed\n");
> +		return PTR_ERR(clk_handle[CLK_SCP_ADSP_AUDIODSP]);
> +	}
> +
> +	clk_handle[CLK_TOP_AUDIO_H] = devm_clk_get(dev, "audio_h");
> +	if (IS_ERR(clk_handle[CLK_TOP_AUDIO_H])) {
> +		dev_err(dev, "clk_get(\"audio_h_sel\") failed\n");
> +		return PTR_ERR(clk_handle[CLK_TOP_AUDIO_H]);
> +	}
> +
> +	return 0;
> +}
> +
> +int adsp_enable_clock(struct device *dev)

You are using this function only in this file, please make it static.

> +{
> +	int ret;
> +
> +	ret = clk_prepare_enable(clk_handle[CLK_TOP_MAINPLL_D7_D2]);
> +	if (ret) {
> +		dev_err(dev, "%s clk_prepare_enable(mainpll_d7_d2) fail %d\n",
> +			__func__, ret);
> +		return ret;
> +	}
> +
> +	ret = clk_prepare_enable(clk_handle[CLK_TOP_ADSP]);
> +	if (ret) {
> +		dev_err(dev, "%s clk_prepare_enable(adsp_sel) fail %d\n",
> +			__func__, ret);
> +		goto disable_mainpll_d7_d2_clk;
> +	}
> +
> +	ret = clk_prepare_enable(clk_handle[CLK_TOP_AUDIO_LOCAL_BUS]);
> +	if (ret) {
> +		dev_err(dev, "%s clk_prepare_enable(audio_local_bus) fail %d\n",
> +			__func__, ret);
> +		goto disable_dsp_sel_clk;
> +	}
> +
> +	ret = clk_prepare_enable(clk_handle[CLK_SCP_ADSP_AUDIODSP]);
> +	if (ret) {
> +		dev_err(dev, "%s clk_prepare_enable(scp_adsp_audiodsp) fail %d\n",
> +			__func__, ret);
> +		goto disable_audio_local_bus_clk;
> +	}
> +
> +	ret = clk_prepare_enable(clk_handle[CLK_TOP_AUDIO_H]);
> +	if (ret) {
> +		dev_err(dev, "%s clk_prepare_enable(audio_h) fail %d\n",
> +			__func__, ret);
> +		goto disable_scp_adsp_audiodsp_clk;
> +	}
> +
> +	return 0;
> +
> +disable_scp_adsp_audiodsp_clk:
> +	clk_disable_unprepare(clk_handle[CLK_SCP_ADSP_AUDIODSP]);
> +disable_audio_local_bus_clk:
> +	clk_disable_unprepare(clk_handle[CLK_TOP_AUDIO_LOCAL_BUS]);
> +disable_dsp_sel_clk:
> +	clk_disable_unprepare(clk_handle[CLK_TOP_ADSP]);
> +disable_mainpll_d7_d2_clk:
> +	clk_disable_unprepare(clk_handle[CLK_TOP_MAINPLL_D7_D2]);
> +
> +	return ret;
> +}
> +
> +void adsp_disable_clock(struct device *dev)

Same here...

> +{
> +	clk_disable_unprepare(clk_handle[CLK_TOP_AUDIO_H]);
> +	clk_disable_unprepare(clk_handle[CLK_SCP_ADSP_AUDIODSP]);
> +	clk_disable_unprepare(clk_handle[CLK_TOP_AUDIO_LOCAL_BUS]);
> +	clk_disable_unprepare(clk_handle[CLK_TOP_ADSP]);
> +	clk_disable_unprepare(clk_handle[CLK_TOP_MAINPLL_D7_D2]);
> +}
> +
> +int adsp_default_clk_init(struct device *dev, int enable)

...and same here.

Also, your `enable` parameter can logically (currently) only have two meanings:
enable, or disable; I think that it would be better to use a bool instead.

> +{
> +	int ret = 0;
> +
> +	dev_dbg(dev, "%s: %s\n", __func__, enable ? "on" : "off");
> +
> +	if (enable) {
> +		ret = clk_set_parent(clk_handle[CLK_TOP_ADSP],
> +				     clk_handle[CLK_TOP_CLK26M]);
> +		if (ret) {
> +			dev_err(dev, "failed to set dsp_sel to clk26m: %d\n", ret);
> +			return ret;
> +		}
> +
> +		ret = clk_set_parent(clk_handle[CLK_TOP_AUDIO_LOCAL_BUS],
> +				     clk_handle[CLK_TOP_MAINPLL_D7_D2]);
> +		if (ret) {
> +			dev_err(dev, "set audio_local_bus failed %d\n", ret);
> +			return ret;
> +		}
> +

I think it'd be a good idea to...

> +		ret = adsp_enable_clock(dev);
> +		if (ret)

		if (ret) {

> +			dev_err(dev, "failed to adsp_enable_clock: %d\n", ret);

			return ret;
		}

> +
> +		return ret;

...and remove this return...

> +	}
> +

	} else {

> +	adsp_disable_clock(dev);

	}

> +
> +	return ret;

...and then, since you are covering all of the error cases before the end of
this function, here you should just

	return 0;

> +}
> +
> +int adsp_clock_on(struct device *dev)
> +{
> +	/* Open ADSP clock */
> +	return adsp_default_clk_init(dev, 1);
> +}
> +
> +int adsp_clock_off(struct device *dev)
> +{
> +	/* Close ADSP clock */
> +	return adsp_default_clk_init(dev, 0);
> +}
> +
> diff --git a/sound/soc/sof/mediatek/mt8195/mt8195-clk.h b/sound/soc/sof/mediatek/mt8195/mt8195-clk.h
> new file mode 100644
> index 000000000000..f985d141552a
> --- /dev/null
> +++ b/sound/soc/sof/mediatek/mt8195/mt8195-clk.h
> @@ -0,0 +1,29 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * Copyright (c) 2021 MediaTek Corporation. All rights reserved.
> + *
> + *  Header file for the mt8195 DSP clock  definition
> + */
> +
> +#ifndef __MT8195_CLK_H
> +#define __MT8195_CLK_H
> +
> +/*DSP clock*/

/* DSP clock id */

> +enum ADSP_CLK_ID {

lowercase please: enum adsp_clk_id

> +	CLK_TOP_ADSP,
> +	CLK_TOP_CLK26M,
> +	CLK_TOP_AUDIO_LOCAL_BUS,
> +	CLK_TOP_MAINPLL_D7_D2,
> +	CLK_SCP_ADSP_AUDIODSP,
> +	CLK_TOP_AUDIO_H,
> +	ADSP_CLK_NUM

What about ADSP_CLK_MAX instead?
Personal preference here, nothing worrying.

> +};
> +
> +int platform_parse_clock(struct device *dev);
> +int adsp_default_clk_init(struct device *dev, int enable);
> +int adsp_enable_clock(struct device *dev);
> +void adsp_disable_clock(struct device *dev);
> +int adsp_clock_on(struct device *dev);
> +int adsp_clock_off(struct device *dev);
> +#endif
> diff --git a/sound/soc/sof/mediatek/mt8195/mt8195.c b/sound/soc/sof/mediatek/mt8195/mt8195.c
> index 99075598a35a..f323da58057b 100644
> --- a/sound/soc/sof/mediatek/mt8195/mt8195.c
> +++ b/sound/soc/sof/mediatek/mt8195/mt8195.c
> @@ -25,6 +25,7 @@
>   #include "../adsp_helper.h"
>   #include "../mediatek-ops.h"
>   #include "mt8195.h"
> +#include "mt8195-clk.h"
>   
>   static int platform_parse_resource(struct platform_device *pdev, void *data)
>   {
> @@ -231,10 +232,23 @@ static int mt8195_dsp_probe(struct snd_sof_dev *sdev)
>   	if (ret)
>   		return ret;
>   
> +	ret = platform_parse_clock(&pdev->dev);
> +	if (ret) {
> +		dev_err(sdev->dev, "platform_parse_clock failed\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = adsp_clock_on(&pdev->dev);
> +	if (ret) {
> +		dev_err(sdev->dev, "adsp_clock_on fail!\n");
> +		return -EINVAL;
> +	}
> +
>   	ret = adsp_sram_power_on(sdev->dev, true);
>   	if (ret) {
>   		dev_err(sdev->dev, "adsp_sram_power_on fail!\n");
> -		return ret;
> +		ret = -EINVAL;
> +		goto exit_clk_disable;
Why are you overriding adsp_sram_power_on()'s return value?
As of now, this function is supposed to return -ENOMEM or 0.. and you
shouldn't override the return value with -EINVAL here.

>   	}
>   
>   	ret = adsp_memory_remap_init(&pdev->dev, priv->adsp);
> @@ -282,6 +296,8 @@ static int mt8195_dsp_probe(struct snd_sof_dev *sdev)
>   
>   err_adsp_sram_power_off:
>   	adsp_sram_power_on(&pdev->dev, false);
> +exit_clk_disable:
> +	adsp_clock_off(&pdev->dev);
>   
>   	return ret;
>   }
> @@ -290,7 +306,10 @@ static int mt8195_dsp_remove(struct snd_sof_dev *sdev)
>   {
>   	struct platform_device *pdev = container_of(sdev->dev, struct platform_device, dev);
>   
> -	return adsp_sram_power_on(&pdev->dev, false);
> +	adsp_sram_power_on(&pdev->dev, false);
> +	adsp_clock_off(&pdev->dev);
> +
> +	return 0;
>   }
>   
>   /* on mt8195 there is 1 to 1 match between type and BAR idx */
> 

Regards,
- Angelo
