Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14B953ADC44
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jun 2021 03:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbhFTBrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 21:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbhFTBrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 21:47:14 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B79B6C061574
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jun 2021 18:45:02 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3FB32557;
        Sun, 20 Jun 2021 03:44:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1624153498;
        bh=DZueLPFxASqP+rQsSO7Xy6Q0cc34R5fuvJfDHhELKjQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pTfTYsxANWYdiKnfhan3sz0KW7hxFUdxh6fAE3vvL+mQWxWeqarjJFHN/cWk5+fJC
         V/9BaLzIJvI03tnpvHXLtNNK4CSODHdrKz3Vc+2KHRdcburJY0Y+XONtD8TkJfHQCQ
         Bp9sIiINj2BkFzVpvW1ryUqY3/wAQQ4mPmdG7o2k=
Date:   Sun, 20 Jun 2021 04:44:33 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Maxime Ripard <maxime@cerno.tech>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc:     Marek Vasut <marex@denx.de>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Eric Anholt <eric@anholt.net>,
        Tim Gover <tim.gover@raspberrypi.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Andrzej Hajda <a.hajda@samsung.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        Phil Elwell <phil@raspberrypi.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] drm/vc4: dsi: Only register our component once a DSI
 device is attached
Message-ID: <YM6dgVb12oITNfc0@pendragon.ideasonboard.com>
References: <20200707101912.571531-1-maxime@cerno.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200707101912.571531-1-maxime@cerno.tech>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

I'm testing this, and I'm afraid it causes an issue with all the
I2C-controlled bridges. I'm focussing on the newly merged ti-sn65dsi83
driver at the moment, but other are affected the same way.

With this patch, the DSI component is only added when the DSI device is
attached to the host with mipi_dsi_attach(). In the ti-sn65dsi83 driver,
this happens in the bridge attach callback, which is called when the
bridge is attached by a call to drm_bridge_attach() in vc4_dsi_bind().
This creates a circular dependency, and the DRM/KMS device is never
created.

How should this be solved ? Dave, I think you have shown an interest in
the sn65dsi83 recently, any help would be appreciated. On a side note,
I've tested the ti-sn65dsi83 driver on a v5.10 RPi kernel, without much
success (on top of commit e1499baa0b0c I get a very weird frame rate -
147 fps of 99 fps instead of 60 fps - and nothing on the screen, and on
top of the latest v5.10 RPi branch, I get lock-related warnings at every
page flip), which is why I tried v5.12 and noticed this patch. Is it
worth trying to bring up the display on the v5.10 RPi kernel in parallel
to fixing the issue introduced in this patch, or is DSI known to be
broken there ?

On Tue, Jul 07, 2020 at 12:19:12PM +0200, Maxime Ripard wrote:
> If the DSI driver is the last to probe, component_add will try to run all
> the bind callbacks straight away and return the error code.
> 
> However, since we depend on a power domain, we're pretty much guaranteed to
> be in that case on the BCM2711, and are just lucky on the previous SoCs
> since the v3d also depends on that power domain and is further in the probe
> order.
> 
> In that case, the DSI host will not stick around in the system: the DSI
> bind callback will be executed, will not find any DSI device attached and
> will return EPROBE_DEFER, and we will then remove the DSI host and ask to
> be probed later on.
> 
> But since that host doesn't stick around, DSI devices like the RaspberryPi
> touchscreen whose probe is not linked to the DSI host (unlike the usual DSI
> devices that will be probed through the call to mipi_dsi_host_register)
> cannot attach to the DSI host, and we thus end up in a situation where the
> DSI host cannot probe because the panel hasn't probed yet, and the panel
> cannot probe because the DSI host hasn't yet.
> 
> In order to break this cycle, let's wait until there's a DSI device that
> attaches to the DSI host to register the component and allow to progress
> further.
> 
> Suggested-by: Andrzej Hajda <a.hajda@samsung.com>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---
>  drivers/gpu/drm/vc4/vc4_dsi.c | 25 ++++++++-----------------
>  1 file changed, 8 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vc4/vc4_dsi.c b/drivers/gpu/drm/vc4/vc4_dsi.c
> index eaf276978ee7..19aab4e7e209 100644
> --- a/drivers/gpu/drm/vc4/vc4_dsi.c
> +++ b/drivers/gpu/drm/vc4/vc4_dsi.c
> @@ -1246,10 +1246,12 @@ static ssize_t vc4_dsi_host_transfer(struct mipi_dsi_host *host,
>  	return ret;
>  }
>  
> +static const struct component_ops vc4_dsi_ops;
>  static int vc4_dsi_host_attach(struct mipi_dsi_host *host,
>  			       struct mipi_dsi_device *device)
>  {
>  	struct vc4_dsi *dsi = host_to_dsi(host);
> +	int ret;
>  
>  	dsi->lanes = device->lanes;
>  	dsi->channel = device->channel;
> @@ -1284,6 +1286,12 @@ static int vc4_dsi_host_attach(struct mipi_dsi_host *host,
>  		return 0;
>  	}
>  
> +	ret = component_add(&dsi->pdev->dev, &vc4_dsi_ops);
> +	if (ret) {
> +		mipi_dsi_host_unregister(&dsi->dsi_host);
> +		return ret;
> +	}
> +
>  	return 0;
>  }
>  
> @@ -1662,7 +1670,6 @@ static int vc4_dsi_dev_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct vc4_dsi *dsi;
> -	int ret;
>  
>  	dsi = devm_kzalloc(dev, sizeof(*dsi), GFP_KERNEL);
>  	if (!dsi)
> @@ -1670,26 +1677,10 @@ static int vc4_dsi_dev_probe(struct platform_device *pdev)
>  	dev_set_drvdata(dev, dsi);
>  
>  	dsi->pdev = pdev;
> -
> -	/* Note, the initialization sequence for DSI and panels is
> -	 * tricky.  The component bind above won't get past its
> -	 * -EPROBE_DEFER until the panel/bridge probes.  The
> -	 * panel/bridge will return -EPROBE_DEFER until it has a
> -	 * mipi_dsi_host to register its device to.  So, we register
> -	 * the host during pdev probe time, so vc4 as a whole can then
> -	 * -EPROBE_DEFER its component bind process until the panel
> -	 * successfully attaches.
> -	 */
>  	dsi->dsi_host.ops = &vc4_dsi_host_ops;
>  	dsi->dsi_host.dev = dev;
>  	mipi_dsi_host_register(&dsi->dsi_host);
>  
> -	ret = component_add(&pdev->dev, &vc4_dsi_ops);
> -	if (ret) {
> -		mipi_dsi_host_unregister(&dsi->dsi_host);
> -		return ret;
> -	}
> -
>  	return 0;
>  }
>  

-- 
Regards,

Laurent Pinchart
