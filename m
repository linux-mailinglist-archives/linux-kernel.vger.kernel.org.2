Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A534436F7AC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 11:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbhD3JSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 05:18:45 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:52800 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229507AbhD3JSp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 05:18:45 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 40E37FB03;
        Fri, 30 Apr 2021 11:17:55 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id mNeG7bnrk71z; Fri, 30 Apr 2021 11:17:53 +0200 (CEST)
Date:   Fri, 30 Apr 2021 11:17:52 +0200
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Liu Ying <victor.liu@nxp.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        a.hajda@samsung.com, narmstrong@baylibre.com,
        robert.foss@linaro.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@siol.net, airlied@linux.ie,
        daniel@ffwll.ch, robert.chiras@nxp.com, linux-imx@nxp.com
Subject: Re: [PATCH v3 0/3] drm/bridge: nwl-dsi: Get MIPI DSI controller and
 PHY ready in ->mode_set()
Message-ID: <YIvLQLEjWjCFVmXI@bogon.m.sigxcpu.org>
References: <1619170003-4817-1-git-send-email-victor.liu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1619170003-4817-1-git-send-email-victor.liu@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liu,
On Fri, Apr 23, 2021 at 05:26:40PM +0800, Liu Ying wrote:
> Hi,
> 
> This series aims to make the nwl-dsi bridge be able to connect with
> more MIPI DSI panels.  Some MIPI DSI panel drivers like 'raydium,rm68200'
> send MIPI_DCS_SET_DISPLAY_ON commands in panel_funcs->prepare(), which
> requires the MIPI DSI controller and PHY to be ready beforehand.
> However, the existing nwl-dsi driver gets the MIPI DSI controller and
> PHY ready in bridge_funcs->pre_enable(), which happens after the
> panel_funcs->prepare().  So, this series shifts the bridge operation
> ealier from bridge_funcs->pre_enable() to bridge_funcs->mode_set().
> 
> Patch 3/3 does the essential bridge operation shift.
> 
> Patch 1/3 and 2/3 are split from the original single patch in v2 and
> are needed by patch 3/3.  This split-up helps clarify changes better.
> The split-up is done in this way:
> 
> 1) Patch 1/3 forces a full modeset when crtc_state->active is changed to
>    be true(which implies only connector's DPMS is brought out of "Off"
>    status, though not necessarily).  This makes sure ->mode_set() and
>    ->atomic_disable() will be called in pairs.
> 2) Patch 2/3 removes a check on unchanged HS clock rate from ->mode_set(),
>    to make sure MIPI DSI controller and PHY are brought up and taken down
>    in pairs.
> 3) Patch 3/3 shifts the bridge operation as the last step.

Looks good to me and tested on imx8mq Librem 5 Devkit with

https://lore.kernel.org/linux-arm-kernel/cover.1617968250.git.agx@sigxcpu.org/

on top so

Reviewed-by: Guido Günther <agx@sigxcpu.org>
Tested-by: Guido Günther <agx@sigxcpu.org>

Cheers,
 -- Guido

> 
> 
> v2->v3:
> * Split the single patch in v2 into 3 patches. (Neil)
> 
> v1->v2:
> * Fix a typo in commit message - s/unchange/unchanged/
> 
> 
> Liu Ying (3):
>   drm/bridge: nwl-dsi: Force a full modeset when crtc_state->active is
>     changed to be true
>   drm/bridge: nwl-dsi: Remove a check on unchanged HS clock rate from
>     ->mode_set()
>   drm/bridge: nwl-dsi: Get MIPI DSI controller and PHY ready in
>     ->mode_set()
> 
>  drivers/gpu/drm/bridge/nwl-dsi.c | 86 +++++++++++++++++---------------
>  1 file changed, 46 insertions(+), 40 deletions(-)
> 
> -- 
> 2.25.1
> 
