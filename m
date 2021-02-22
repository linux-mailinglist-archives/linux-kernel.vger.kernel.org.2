Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3007F321091
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 06:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbhBVFzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 00:55:49 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:56172 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbhBVFzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 00:55:47 -0500
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0C9C1344;
        Mon, 22 Feb 2021 06:55:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1613973305;
        bh=s5Sf/8itHX3j/tX54sgaRdM+CLR9kswsZj0KP+smwyo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t21IH+Ye39Y0Mp3BGrGaxYYuREWC1aK8Gts+hbw69RcrQ254uOgUD2o7bKYMKNk3x
         bmfgW+gG8PhMvzQULviLdxHoiJ1PZhTydNWmN8w8AK/4cOH1YVcQZ7W93CAulBkpIj
         3Nm7mkMblnhijbqIkj+LTM+4Qtl/6ky+oCa8LpUQ=
Date:   Mon, 22 Feb 2021 07:54:38 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v3 5/7] drm: bridge: Queue the bridge chain instead of
 stacking
Message-ID: <YDNHHk+9uIMGKZVF@pendragon.ideasonboard.com>
References: <20210214194102.126146-1-jagan@amarulasolutions.com>
 <20210214194102.126146-6-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210214194102.126146-6-jagan@amarulasolutions.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jagan,

Thank you for the patch.

On Mon, Feb 15, 2021 at 01:11:00AM +0530, Jagan Teki wrote:
> drm_bridge_attach has stacked the bridge chain, so the bridge
> that gets pushed last can trigger its bridge function pre_enable
> first from drm_atomic_bridge_chain_pre_enable.
> 
> This indeed gives a chance to trigger slave bridge pre_enable
> first without triggering its host bridge pre_enable for the
> usual host to slave device model like DSI host with panel slave.
> 
> For fully enabled bridge drivers, host bridge pre_enable has all
> host related clock, reset, PHY configuration code that needs to
> initialized before sending commands or configuration from a slave
> to communicate its host.
> 
> Queue the bridge chain instead of stacking it so-that the bridges
> that got enqueued first can have a chance to trigger first.

First of all, won't thus break all the drivers that currently rely on
the existing behaviour ?

> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v3:
> - new patch
> 
>  drivers/gpu/drm/drm_bridge.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index 64f0effb52ac..e75d1a080c55 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -191,9 +191,9 @@ int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
>  	bridge->encoder = encoder;
>  
>  	if (previous)
> -		list_add(&bridge->chain_node, &previous->chain_node);
> +		list_add_tail(&bridge->chain_node, &previous->chain_node);
>  	else
> -		list_add(&bridge->chain_node, &encoder->bridge_chain);
> +		list_add_tail(&bridge->chain_node, &encoder->bridge_chain);

Then, this will create a really weird order, as the list will contain
bridges in the reverse order. Assuming three bridges, A, B and C, which
are connected at the hardware level as follows:

Encoder -> A -> B -> C

the list would contain

Encoder -> C -> B -> A

This isn't intuitive, and if you want to reverse the order in which
bridge operations are called, it would be better to do so in the
operations themselves, for instance replacing
list_for_each_entry_reverse() with list_for_each_entry() in
drm_atomic_bridge_chain_pre_enable(). Still, this will likely break
drivers that depend on the existing order, so I don't think that's an
acceptable solution as-is.

>  
>  	if (bridge->funcs->attach) {
>  		ret = bridge->funcs->attach(bridge, flags);

-- 
Regards,

Laurent Pinchart
