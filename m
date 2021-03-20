Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E801F342967
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 01:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbhCTAVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 20:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhCTAVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 20:21:40 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82AF1C061760
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 17:21:39 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 236598D3;
        Sat, 20 Mar 2021 01:21:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1616199695;
        bh=YxyYG0rUzewpkZSqO4W7En5pkRKvoNodFD5mlHd1GTk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d7IhFfS2Lv6sm+CBEt1QwgBC8BEsPfNz4YumUCf5tRZ8+by6MAIe0sVm92jSPtaNX
         lL2HCvxfBPZ+fz076pYKZ7nBlZfx6R8xUYp/Ec1dXOsS7MCOPuErg0tLU+d50Upz1a
         p8qQWdOpRX8/WbMPUQ31l4x9DadCoxbOo0Ia8c+A=
Date:   Sat, 20 Mar 2021 02:20:56 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
        Sandy Huang <hjc@rock-chips.com>,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] drm/rockchip: Remove unused variable
Message-ID: <YFU/6Hm1CuVL8MlO@pendragon.ideasonboard.com>
References: <20210319152920.262035-1-maxime@cerno.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210319152920.262035-1-maxime@cerno.tech>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

Thank you for the patch.

On Fri, Mar 19, 2021 at 04:29:20PM +0100, Maxime Ripard wrote:
> Commit 977697e20b3d ("drm/atomic: Pass the full state to planes atomic
> disable and update") added the old_state variable instead of what used
> to be a parameter, but it also removed the sole user of that variable in
> the vop_plane_atomic_update function leading to an usused variable.
> Remove it.
> 
> Fixes: 977697e20b3d ("drm/atomic: Pass the full state to planes atomic disable and update")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> index 81c70d7a0471..64469439ddf2 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> @@ -879,8 +879,6 @@ static void vop_plane_atomic_disable(struct drm_plane *plane,
>  static void vop_plane_atomic_update(struct drm_plane *plane,
>  		struct drm_atomic_state *state)
>  {
> -	struct drm_plane_state *old_state = drm_atomic_get_old_plane_state(state,
> -									   plane);
>  	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state,
>  									   plane);
>  	struct drm_crtc *crtc = new_state->crtc;

-- 
Regards,

Laurent Pinchart
