Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D52AA34E4A4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 11:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbhC3JnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 05:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbhC3JnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 05:43:13 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978ABC061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 02:43:12 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 822021F45916
Subject: Re: [PATCH] drm/mediatek: Add missing MODULE_DEVICE_TABLE()
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     matthias.bgg@gmail.com, drinkcat@chromium.org, hsinyi@chromium.org,
        Collabora Kernel ML <kernel@collabora.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20210203110717.686204-1-enric.balletbo@collabora.com>
Message-ID: <8c8309fb-babe-3ed4-d2a1-111fbab91e9f@collabora.com>
Date:   Tue, 30 Mar 2021 11:43:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210203110717.686204-1-enric.balletbo@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/2/21 12:07, Enric Balletbo i Serra wrote:
> From: Boris Brezillon <boris.brezillon@collabora.com>
> 
> This patch adds the missing MODULE_DEVICE_TABLE definitions on different
> Mediatek drivers which generates correct modalias for automatic loading
> when these drivers are compiled as an external module.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

A gentle ping for someone to review this patchset :-)

Thanks,
  Enric

> ---
> 
>  drivers/gpu/drm/mediatek/mtk_cec.c      | 2 ++
>  drivers/gpu/drm/mediatek/mtk_dpi.c      | 1 +
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c  | 1 +
>  drivers/gpu/drm/mediatek/mtk_dsi.c      | 1 +
>  drivers/gpu/drm/mediatek/mtk_hdmi.c     | 1 +
>  drivers/gpu/drm/mediatek/mtk_hdmi_ddc.c | 1 +
>  6 files changed, 7 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_cec.c b/drivers/gpu/drm/mediatek/mtk_cec.c
> index cb29b649fcdb..3b86e626e459 100644
> --- a/drivers/gpu/drm/mediatek/mtk_cec.c
> +++ b/drivers/gpu/drm/mediatek/mtk_cec.c
> @@ -7,6 +7,7 @@
>  #include <linux/delay.h>
>  #include <linux/io.h>
>  #include <linux/interrupt.h>
> +#include <linux/module.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
>  
> @@ -247,6 +248,7 @@ static const struct of_device_id mtk_cec_of_ids[] = {
>  	{ .compatible = "mediatek,mt8173-cec", },
>  	{}
>  };
> +MODULE_DEVICE_TABLE(of, mtk_cec_of_ids);
>  
>  struct platform_driver mtk_cec_driver = {
>  	.probe = mtk_cec_probe,
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
> index 52f11a63a330..2680370652fd 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> @@ -822,6 +822,7 @@ static const struct of_device_id mtk_dpi_of_ids[] = {
>  	},
>  	{ },
>  };
> +MODULE_DEVICE_TABLE(of, mtk_dpi_of_ids);
>  
>  struct platform_driver mtk_dpi_driver = {
>  	.probe = mtk_dpi_probe,
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> index 5f49a809689b..e4645c8ae1c0 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -470,6 +470,7 @@ static const struct of_device_id mtk_drm_of_ids[] = {
>  	  .data = &mt8183_mmsys_driver_data},
>  	{ }
>  };
> +MODULE_DEVICE_TABLE(of, mtk_drm_of_ids);
>  
>  static int mtk_drm_probe(struct platform_device *pdev)
>  {
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> index 0527480c07be..c71ce62d1bec 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -1193,6 +1193,7 @@ static const struct of_device_id mtk_dsi_of_match[] = {
>  	  .data = &mt8183_dsi_driver_data },
>  	{ },
>  };
> +MODULE_DEVICE_TABLE(of, mtk_dsi_of_match);
>  
>  struct platform_driver mtk_dsi_driver = {
>  	.probe = mtk_dsi_probe,
> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
> index 8ee55f9e2954..b4696a9d73f7 100644
> --- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
> @@ -1818,6 +1818,7 @@ static const struct of_device_id mtk_drm_hdmi_of_ids[] = {
>  	},
>  	{}
>  };
> +MODULE_DEVICE_TABLE(of, mtk_drm_hdmi_of_ids);
>  
>  static struct platform_driver mtk_hdmi_driver = {
>  	.probe = mtk_drm_hdmi_probe,
> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_ddc.c b/drivers/gpu/drm/mediatek/mtk_hdmi_ddc.c
> index 62dbad5675bb..6207eac88550 100644
> --- a/drivers/gpu/drm/mediatek/mtk_hdmi_ddc.c
> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi_ddc.c
> @@ -335,6 +335,7 @@ static const struct of_device_id mtk_hdmi_ddc_match[] = {
>  	{ .compatible = "mediatek,mt8173-hdmi-ddc", },
>  	{},
>  };
> +MODULE_DEVICE_TABLE(of, mtk_hdmi_ddc_match);
>  
>  struct platform_driver mtk_hdmi_ddc_driver = {
>  	.probe = mtk_hdmi_ddc_probe,
> 
