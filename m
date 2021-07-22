Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A62E93D2546
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 16:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbhGVNcT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 22 Jul 2021 09:32:19 -0400
Received: from aposti.net ([89.234.176.197]:54362 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232105AbhGVNcS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 09:32:18 -0400
Date:   Thu, 22 Jul 2021 15:12:43 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 3/3] drm/panel-simple: add Gopher 2b LCD panel
To:     Artjom Vejsel <akawolf0@gmail.com>
Cc:     thierry.reding@gmail.com, sam@ravnborg.org,
        dri-devel@lists.freedesktop.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <7TGNWQ.L2GCQQC1CJ603@crapouillou.net>
In-Reply-To: <20210722140432.1426173-4-akawolf0@gmail.com>
References: <20210722140432.1426173-1-akawolf0@gmail.com>
        <20210722140432.1426173-4-akawolf0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Artjom,

Le jeu., juil. 22 2021 at 17:04:32 +0300, Artjom Vejsel 
<akawolf0@gmail.com> a écrit :
> The Gopher 2b LCD panel is used in Gopher 2b handhelds.
> It's simple panel with NewVision NV3047 driver,
> but SPI lines are not connected.
> It has no specific name, since it's unique to that handhelds.
> lot name at AliExpress: 4.3 inch 40PIN TFT LCD Screen COG
> NV3047 Drive IC 480(RGB)*272 No Touch 24Bit RGB Interface
> 
> Signed-off-by: Artjom Vejsel <akawolf0@gmail.com>
> ---
>  drivers/gpu/drm/panel/panel-simple.c | 44 
> ++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c 
> b/drivers/gpu/drm/panel/panel-simple.c
> index 9b286bd4444f..9cce6b63a147 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -4306,6 +4306,47 @@ static const struct panel_desc 
> yes_optoelectronics_ytc700tlag_05_201c = {
>  	.connector_type = DRM_MODE_CONNECTOR_LVDS,
>  };
> 
> +static const struct drm_display_mode 
> qishenglong_gopher2b_lcd_panel_modes[] = {
> +	{ /* 60 Hz */
> +		.clock = 10800,
> +		.hdisplay = 480,
> +		.hsync_start = 480 + 77,
> +		.hsync_end = 480 + 77 + 41,
> +		.htotal = 480 + 77 + 41 + 2,
> +		.vdisplay = 272,
> +		.vsync_start = 272 + 16,
> +		.vsync_end = 272 + 16 + 10,
> +		.vtotal = 272 + 16 + 10 + 2,
> +		.flags = DRM_MODE_FLAG_NVSYNC | DRM_MODE_FLAG_NHSYNC,
> +	},
> +	{ /* 50 Hz */
> +		.clock = 10800,
> +		.hdisplay = 480,
> +		.hsync_start = 480 + 17,
> +		.hsync_end = 480 + 17 + 41,
> +		.htotal = 480 + 17 + 41 + 2,
> +		.vdisplay = 272,
> +		.vsync_start = 272 + 116,
> +		.vsync_end = 272 + 116 + 10,
> +		.vtotal = 272 + 116 + 10 + 2,
> +		.flags = DRM_MODE_FLAG_NVSYNC | DRM_MODE_FLAG_NHSYNC,
> +	},
> +};
> +
> +static const struct panel_desc qishenglong_gopher2b_lcd_panel = {
> +	.modes = qishenglong_gopher2b_lcd_panel_modes,
> +	.num_modes = ARRAY_SIZE(qishenglong_gopher2b_lcd_panel_modes),
> +	.num_modes = 1,

Thank you for your patch. From a quick look though, you have .num_modes 
listed twice here. I believe the second line should be removed.

Cheers,
-Paul

> +	.bpc = 8,
> +	.size = {
> +		.width = 95,
> +		.height = 54,
> +	},
> +	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
> +	.bus_flags = DRM_BUS_FLAG_DE_HIGH | 
> DRM_BUS_FLAG_PIXDATA_SAMPLE_NEGEDGE,
> +	.connector_type = DRM_MODE_CONNECTOR_DPI,
> +};
> +
>  static const struct drm_display_mode arm_rtsm_mode[] = {
>  	{
>  		.clock = 65000,
> @@ -4753,6 +4794,9 @@ static const struct of_device_id 
> platform_of_match[] = {
>  	}, {
>  		.compatible = "yes-optoelectronics,ytc700tlag-05-201c",
>  		.data = &yes_optoelectronics_ytc700tlag_05_201c,
> +	}, {
> +		.compatible = "qishenglong,gopher2b-lcd-panel",
> +		.data = &qishenglong_gopher2b_lcd_panel,
>  	}, {
>  		/* Must be the last entry */
>  		.compatible = "panel-dpi",
> --
> 2.32.0


