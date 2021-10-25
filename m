Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B67C439DDC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 19:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234120AbhJYRuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 13:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbhJYRuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 13:50:23 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2452C061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 10:48:00 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7FE173F0;
        Mon, 25 Oct 2021 19:47:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1635184077;
        bh=6ZtEAw8d5dNncwEtVoiWSHFcOFRwfR0tsZKRdCAYWJA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qp4OotbRMjxwZb8+8CSpjYMkfqzAubNtAh16zhdBB9vNUtvk+CqugPqfTWFP1Wrp9
         lZv8D3Q3AkECaxtv7vtA9pzgLgYwHYtdJu6nSo9QsKI3GLuSu6REFidVFlFH5GUKX9
         q6Z36DUpCGtGwgxs1Z8zOf1gKkDO4DEGx6g7Yk1o=
Date:   Mon, 25 Oct 2021 20:47:35 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Julian Braha <julianbraha@gmail.com>
Cc:     robert.foss@linaro.org, a.hajda@samsung.com,
        narmstrong@baylibre.com, jonas@kwiboo.se, jernej.skrabec@gmail.com,
        airlied@linux.ie, daniel@ffwll.ch, jagan@amarulasolutions.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: bridge: fix unmet dependency on DRM_KMS_HELPER for
 DRM_PANEL_BRIDGE
Message-ID: <YXbtt2M+I41qH2ME@pendragon.ideasonboard.com>
References: <20211025174202.32396-1-julianbraha@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211025174202.32396-1-julianbraha@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Julian,

Thank you for the patch.

On Mon, Oct 25, 2021 at 01:42:02PM -0400, Julian Braha wrote:
> When DRM_CHIPONE_ICN6211 is selected, and DRM_KMS_HELPER is not selected,
> Kbuild gives the following warning:
> 
> WARNING: unmet direct dependencies detected for DRM_PANEL_BRIDGE
>   Depends on [n]: HAS_IOMEM [=y] && DRM_BRIDGE [=y] && DRM_KMS_HELPER [=n]
>   Selected by [y]:
>   - DRM_CHIPONE_ICN6211 [=y] && HAS_IOMEM [=y] && DRM [=y] && DRM_BRIDGE [=y] && OF [=y]
> 
> This is because DRM_CHIPONE_ICN6211 selects DRM_PANEL_BRIDGE
> without depending on or selecting DRM_KMS_HELPER,
> despite DRM_PANEL_BRIDGE depending on DRM_KMS_HELPER.
> 
> This unmet dependency bug was detected by Kismet,
> a static analysis tool for Kconfig.
> Please advise if this is not the appropriate solution.

Shouldn't DRM_PANEL_BRIDGE select DRM_KMS_HELPER instead of depending on
it ?

> Fixes: ce517f18944e ("drm: bridge: Add Chipone ICN6211 MIPI-DSI to RGB bridge")
> Reviewed-by: Robert Foss <robert.foss@linaro.org>
> Signed-off-by: Julian Braha <julianbraha@gmail.com>
> ---
>  drivers/gpu/drm/bridge/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> index 431b6e12a81f..a630cb8fd1c8 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -30,6 +30,7 @@ config DRM_CDNS_DSI
>  config DRM_CHIPONE_ICN6211
>  	tristate "Chipone ICN6211 MIPI-DSI/RGB Converter bridge"
>  	depends on OF
> +  select DRM_KMS_HELPER
>  	select DRM_MIPI_DSI
>  	select DRM_PANEL_BRIDGE
>  	help

-- 
Regards,

Laurent Pinchart
