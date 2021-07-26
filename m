Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2458C3D560A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 11:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbhGZIVy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 26 Jul 2021 04:21:54 -0400
Received: from aposti.net ([89.234.176.197]:51096 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231728AbhGZIVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 04:21:53 -0400
Date:   Mon, 26 Jul 2021 10:02:08 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v3 3/3] drm/panel-simple: add Gopher 2b LCD panel
To:     Artjom Vejsel <akawolf0@gmail.com>
Cc:     thierry.reding@gmail.com, sam@ravnborg.org,
        dri-devel@lists.freedesktop.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <K3HUWQ.S5LBW8E092T01@crapouillou.net>
In-Reply-To: <20210725221527.1771892-4-akawolf0@gmail.com>
References: <20210725221527.1771892-1-akawolf0@gmail.com>
        <20210725221527.1771892-4-akawolf0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Artjom,

Le lun., juil. 26 2021 at 01:15:27 +0300, Artjom Vejsel 
<akawolf0@gmail.com> a écrit :
> The Gopher 2b LCD panel is used in Gopher 2b handhelds.
> It's simple panel with NewVision NV3047 driver, but SPI lines are not 
> connected.
> It has no specific name, since it's unique to that handhelds.
> lot name at AliExpress: 4.3 inch 40PIN TFT LCD Screen COG NV3047 
> Drive IC 480(RGB)*272 No Touch 24Bit RGB Interface

 From what I gathered the Gopher2's LCD panel is the exact same that is 
inside the RS-07 handheld. According to the teardown (in [1]), the 
RS-07 panel is a Amelin AML043056B0-40 (see [2]).

Could you verify that? According to the photos, the product code is 
written on the flexible connector.

If that's the case, instead of using the 
"qishenglong,gopher2b-lcd-panel" compatible string, could you use 
"amelin,aml043056b0-40"?

Cheers,
-Paul

[1]: https://steward-fu.github.io/website/handheld/rs07/teardown.htm
[2]: http://www.amelin.com.cn/en/h-pd-355.html

> 
> Signed-off-by: Artjom Vejsel <akawolf0@gmail.com>
> ---
>  drivers/gpu/drm/panel/panel-simple.c | 43 
> ++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c 
> b/drivers/gpu/drm/panel/panel-simple.c
> index 9b286bd4444f..6b69c0c70814 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -3563,6 +3563,46 @@ static const struct panel_desc qd43003c0_40 = {
>  	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
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
>  static const struct display_timing rocktech_rk070er9427_timing = {
>  	.pixelclock = { 26400000, 33300000, 46800000 },
>  	.hactive = { 800, 800, 800 },
> @@ -4651,6 +4691,9 @@ static const struct of_device_id 
> platform_of_match[] = {
>  	}, {
>  		.compatible = "qiaodian,qd43003c0-40",
>  		.data = &qd43003c0_40,
> +	}, {
> +		.compatible = "qishenglong,gopher2b-lcd-panel",
> +		.data = &qishenglong_gopher2b_lcd_panel,
>  	}, {
>  		.compatible = "rocktech,rk070er9427",
>  		.data = &rocktech_rk070er9427,
> --
> 2.32.0
> 


