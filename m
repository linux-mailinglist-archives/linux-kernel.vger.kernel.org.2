Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF2630A8B7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 14:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbhBAN25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 08:28:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbhBAN2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 08:28:25 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E07C061756
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 05:27:44 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1l6ZEx-0008V4-Vr; Mon, 01 Feb 2021 14:27:39 +0100
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1l6ZEu-00077M-Bs; Mon, 01 Feb 2021 14:27:36 +0100
Date:   Mon, 1 Feb 2021 14:27:36 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Oliver Graute <oliver.graute@gmail.com>
Cc:     thierry.reding@gmail.com, Fabio Estevam <festevam@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/panel: simple: add SGD GKTW70SDAD1SD
Message-ID: <20210201132736.dbqnyzn7dbu7dsmq@pengutronix.de>
References: <1611947364-30688-1-git-send-email-oliver.graute@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611947364-30688-1-git-send-email-oliver.graute@gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 14:11:55 up 61 days,  3:18, 32 users,  load average: 0.28, 0.17,
 0.09
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oliver,

thanks for the patch :)

On 21-01-29 20:09, Oliver Graute wrote:
> Add support for the Solomon Goldentek Display Model: GKTW70SDAD1SD
> to panel-simple.
> 
> The panel spec from Variscite can be found at:
> https://www.variscite.com/wp-content/uploads/2017/12/VLCD-CAP-GLD-RGB.pdf
> 
> Signed-off-by: Oliver Graute <oliver.graute@gmail.com>
> Cc: Marco Felsch <m.felsch@pengutronix.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> ---
> 
> v2:
> 
> - changed bpc to 6
> - set max value of pixelclock
> - increased hfront_porch and hback_porch
> - dropped connector-type
> 
> adding of bus_format = MEDIA_BUS_FMT_RGB666_1X18 results in wrong colors.
> omitting bus_format and using some default is good (Tux Pinguin is colored
> fine)
> 
>  drivers/gpu/drm/panel/panel-simple.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index 2be358f..c129a8c 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -3336,6 +3336,28 @@ static const struct panel_desc satoz_sat050at40h12r2 = {
>  	.connector_type = DRM_MODE_CONNECTOR_LVDS,
>  };
>  
> +static const struct display_timing sgd_gktw70sdad1sd_timing = {
> +	.pixelclock = {30000000, 30000000, 40000000},
> +	.hactive = { 800, 800, 800},
> +	.hfront_porch = {40, 40, 40},
> +	.hback_porch = {40, 40, 40},
> +	.hsync_len = {48, 48, 48},
> +	.vactive = {480, 480, 480},
> +	.vfront_porch = {13, 13, 13},
> +	.vback_porch = {29, 29, 29},
> +	.vsync_len = {3, 3, 3},

Please add also:

	.flags = DISPLAY_FLAGS_HSYNC_LOW | DISPLAY_FLAGS_VSYNC_LOW |
		 DISPLAY_FLAGS_DE_HIGH | DISPLAY_FLAGS_PIXDATA_NEGEDGE,

> +};
> +
> +static const struct panel_desc sgd_gktw70sdad1sd = {
> +	.timings = &sgd_gktw70sdad1sd_timing,
> +	.num_timings = 1,
> +	.bpc = 6,
> +	.size = {
> +		.width = 153,
> +		.height = 86,
> +	},

and:

	.delay = {
		.prepare = 20 + 20 + 10 + 10, /* T0 + T2 + T3 + T4 */
		.enable = 50, /* T5 */
		.disable = 50, /* T5 */
		.unprepare =  10 + 10 + 20 + 20, /* T4 + T3 + T2 + T0 */
	};

Regards,
  Marco


> +};

> +
>  static const struct drm_display_mode sharp_ld_d5116z01b_mode = {
>  	.clock = 168480,
>  	.hdisplay = 1920,
> @@ -4222,6 +4244,9 @@ static const struct of_device_id platform_of_match[] = {
>  		.compatible = "satoz,sat050at40h12r2",
>  		.data = &satoz_sat050at40h12r2,
>  	}, {
> +		.compatible = "sgd,gktw70sdad1sd",
> +		.data = &sgd_gktw70sdad1sd,
> +	}, {
>  		.compatible = "sharp,ld-d5116z01b",
>  		.data = &sharp_ld_d5116z01b,
>  	}, {
> -- 
> 2.7.4
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
