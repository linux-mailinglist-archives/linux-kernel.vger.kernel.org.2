Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67E5931B80E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 12:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbhBOLdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 06:33:54 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:49044 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbhBOLdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 06:33:51 -0500
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8E421743;
        Mon, 15 Feb 2021 12:33:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1613388787;
        bh=BSgf0lC6W+ct3DtqLQSUhG6tO3u7JlCBUaYD+QzMLM0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EgmmopHf3kv7TTNawif/+EmlpdCSDo47+mb7iaF061ccajG0OBzJWsU4PdRxuWaOf
         +9pQNVksrZh4rGKm/H7yo83wluOvxiHwGhDVm9DCdn8JfOvCBpTe20OgvDz4r10YSA
         NsMjd/tXZmAeh14fMAkEW9j0V8I82GJb5dkuAMuw=
Date:   Mon, 15 Feb 2021 13:32:41 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Sandy Huang <hjc@rock-chips.com>,
        Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com
Subject: Re: [PATCH] drm/bridge: dw-mipi-dsi: Move drm_bridge_add into probe
Message-ID: <YCpb2b8TskrKQBYY@pendragon.ideasonboard.com>
References: <20210203091306.140518-1-jagan@amarulasolutions.com>
 <1660529.M3retTD8dW@diego>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1660529.M3retTD8dW@diego>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

On Wed, Feb 03, 2021 at 01:05:43PM +0100, Heiko Stübner wrote:
> Am Mittwoch, 3. Februar 2021, 10:13:06 CET schrieb Jagan Teki:
> > Usual I2C configured DSI bridge drivers have drm_bridge_add
> > in probe and mipi_dsi_attach in bridge attach functions.
> > 
> > With, this approach the drm pipeline is unable to find the
> > dsi bridge in stm drm drivers since the dw-mipi-dsi bridge is
> > adding drm bridge during bridge attach operations instead of
> > the probe.
> 
> Shouldn't the STM drm driver not simply defer if it's missing
> a bridge that is referenced in the devicetree or somewhere?
> 
> > This specific issue may not encounter for rockchip drm dsi
> > drivers, since rockchip drm uses component binding operations,
> > unlike stm drm drivers.
> > 
> > So, possible solutions are
> > 1. Move drm_bridge_add into the dw-mipi-dsi probe.
> > 2. Add mipi_dsi_attach in the bridge drivers probe.
> > 3. Add component binding operations for stm drm drivers.
> 
> personally I'd like number (3) a lot ;-) .

We have different opinions on this topic :-) The component framework
adds a layer of complexity that can be avoided with probe deferral in
most cases. The main reason why probe deferral isn't always enough is
circular dependencies, which unless I'm mistaken isn't an issue here.

> With your approach, at least the component-based variants would
> end up with multiple probe cycles, getting clocks etc until at some point
> the panel has probed, where in the current way of things, the probe is
> done once and we continue bringup once the panel has probed and called
> dsi-attach to signal it is present.
> 
> Which was actually what Andrzej wished for, when I moved the Rockchip
> dsi to the common driver.
> 
> Or at least make it configurable via a param to the common dw-dsi probe
> function. Especially as I also need the dsi bridge-less when used as a
> simple means for the configuring the internal dphy to rx-mode, see [0]
> 
> Heiko
> 
> [0] https://lore.kernel.org/dri-devel/20210202145632.1263136-1-heiko@sntech.de/
> 
> > Option 1 is a relatively possible solution as most of the
> > mainline drm dsi with bridge drivers have a similar approach
> > to their dsi host vs bridge registration.
> > 
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > ---
> >  drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 35 +++++++++----------
> >  1 file changed, 17 insertions(+), 18 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> > index 6b268f9445b3..8a535041f071 100644
> > --- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> > +++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> > @@ -314,8 +314,6 @@ static int dw_mipi_dsi_host_attach(struct mipi_dsi_host *host,
> >  {
> >  	struct dw_mipi_dsi *dsi = host_to_dsi(host);
> >  	const struct dw_mipi_dsi_plat_data *pdata = dsi->plat_data;
> > -	struct drm_bridge *bridge;
> > -	struct drm_panel *panel;
> >  	int ret;
> >  
> >  	if (device->lanes > dsi->plat_data->max_data_lanes) {
> > @@ -329,22 +327,6 @@ static int dw_mipi_dsi_host_attach(struct mipi_dsi_host *host,
> >  	dsi->format = device->format;
> >  	dsi->mode_flags = device->mode_flags;
> >  
> > -	ret = drm_of_find_panel_or_bridge(host->dev->of_node, 1, 0,
> > -					  &panel, &bridge);
> > -	if (ret)
> > -		return ret;
> > -
> > -	if (panel) {
> > -		bridge = drm_panel_bridge_add_typed(panel,
> > -						    DRM_MODE_CONNECTOR_DSI);
> > -		if (IS_ERR(bridge))
> > -			return PTR_ERR(bridge);
> > -	}
> > -
> > -	dsi->panel_bridge = bridge;
> > -
> > -	drm_bridge_add(&dsi->bridge);
> > -
> >  	if (pdata->host_ops && pdata->host_ops->attach) {
> >  		ret = pdata->host_ops->attach(pdata->priv_data, device);
> >  		if (ret < 0)
> > @@ -1105,6 +1087,8 @@ __dw_mipi_dsi_probe(struct platform_device *pdev,
> >  	struct device *dev = &pdev->dev;
> >  	struct reset_control *apb_rst;
> >  	struct dw_mipi_dsi *dsi;
> > +	struct drm_bridge *bridge;
> > +	struct drm_panel *panel;
> >  	int ret;
> >  
> >  	dsi = devm_kzalloc(dev, sizeof(*dsi), GFP_KERNEL);
> > @@ -1167,6 +1151,20 @@ __dw_mipi_dsi_probe(struct platform_device *pdev,
> >  	dw_mipi_dsi_debugfs_init(dsi);
> >  	pm_runtime_enable(dev);
> >  
> > +	ret = drm_of_find_panel_or_bridge(dev->of_node, 1, 0,
> > +					  &panel, &bridge);
> > +	if (ret)
> > +		return ERR_PTR(ret);
> > +
> > +	if (panel) {
> > +		bridge = drm_panel_bridge_add_typed(panel,
> > +						    DRM_MODE_CONNECTOR_DSI);
> > +		if (IS_ERR(bridge))
> > +			return ERR_PTR(-ENODEV);
> > +	}
> > +
> > +	dsi->panel_bridge = bridge;
> > +
> >  	dsi->dsi_host.ops = &dw_mipi_dsi_host_ops;
> >  	dsi->dsi_host.dev = dev;
> >  	ret = mipi_dsi_host_register(&dsi->dsi_host);
> > @@ -1181,6 +1179,7 @@ __dw_mipi_dsi_probe(struct platform_device *pdev,
> >  #ifdef CONFIG_OF
> >  	dsi->bridge.of_node = pdev->dev.of_node;
> >  #endif
> > +	drm_bridge_add(&dsi->bridge);
> >  
> >  	return dsi;
> >  }

-- 
Regards,

Laurent Pinchart
