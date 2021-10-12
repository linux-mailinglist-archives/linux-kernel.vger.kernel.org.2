Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B292742ADB1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 22:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234576AbhJLUT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 16:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234542AbhJLUTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 16:19:25 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E482C061570
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 13:17:23 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id D0DDEE52;
        Tue, 12 Oct 2021 22:17:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1634069841;
        bh=4EQuC8eOIJsimF2TBe95dDG7kbMlayntaED2XS2wqug=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XO1ps6R0MZpJdn6usO4hFaoxRJoLnxT5OXPDFe+FIiZZTf5driWZwTEqWNz4YCZBb
         BWBUZ5xy0Axew5U8nQq78u+x23Ro6mfVAdjxr1cQwVF+JSRyInvWT9ea8UNqvSzcYo
         Hr80jyDU6QRL4XpH13j+dFnTWLSinC+Iok7fWsDo=
Date:   Tue, 12 Oct 2021 23:17:07 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: Ignore -EPROBE_DEFER when bridge attach fails
Message-ID: <YWXtQ778N/rn+Jnu@pendragon.ideasonboard.com>
References: <00493cc61d1443dab1c131c46c5890f95f6f9b25.1634068657.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <00493cc61d1443dab1c131c46c5890f95f6f9b25.1634068657.git.agx@sigxcpu.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guido,

Thank you for the patch.

On Tue, Oct 12, 2021 at 09:58:58PM +0200, Guido Günther wrote:
> Otherwise logs are filled with
> 
>   [drm:drm_bridge_attach] *ERROR* failed to attach bridge /soc@0/bus@30800000/mipi-dsi@30a0 0000 to encoder None-34: -517
> 
> when the bridge isn't ready yet.
> 
> Fixes: fb8d617f8fd6 ("drm/bridge: Centralize error message when bridge attach fails")
> Signed-off-by: Guido Günther <agx@sigxcpu.org>
> ---
>  drivers/gpu/drm/drm_bridge.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index a8ed66751c2d..f0508e85ae98 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -227,14 +227,15 @@ int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
>  	bridge->encoder = NULL;
>  	list_del(&bridge->chain_node);
>  
> +	if (ret != -EPROBE_DEFER) {
>  #ifdef CONFIG_OF
> -	DRM_ERROR("failed to attach bridge %pOF to encoder %s: %d\n",
> -		  bridge->of_node, encoder->name, ret);
> +		DRM_ERROR("failed to attach bridge %pOF to encoder %s: %d\n",
> +			  bridge->of_node, encoder->name, ret);
>  #else
> -	DRM_ERROR("failed to attach bridge to encoder %s: %d\n",
> -		  encoder->name, ret);
> +		DRM_ERROR("failed to attach bridge to encoder %s: %d\n",
> +			  encoder->name, ret);
>  #endif
> -
> +	}

This looks fine as such, but I'm concerned about the direction it's
taking. Ideally, probe deferral should happen at probe time, way before
the bridge is attached. Doing otherwise is a step in the wrong direction
in my opinion, and something we'll end up regretting when we'll feel the
pain it inflicts.

>  	return ret;
>  }
>  EXPORT_SYMBOL(drm_bridge_attach);

-- 
Regards,

Laurent Pinchart
