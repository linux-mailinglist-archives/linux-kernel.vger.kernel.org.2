Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 150C93492BA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 14:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbhCYNHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 09:07:08 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:51684 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbhCYNGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 09:06:34 -0400
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3F2A9560;
        Thu, 25 Mar 2021 14:06:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1616677593;
        bh=zyD87Hn+HLk3ohniAT8LyCOMOPd0duWdLkzlHytc2cI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pOmY6XK/bMh1qaDIDAvHG6k2STVvYL1q6b5tw5eeMD6gprFOtpw7WVwpn78SvQmrE
         JGwdwULQla15C5S8IX2Qp5PnvFTvfcMh8EM6QJUyFGpgDWTaszryuMst/XeLI2G+QL
         QiOZwWsto6rwa5BgziN24UQCw/O/77QRwH7meOJM=
Date:   Thu, 25 Mar 2021 15:05:50 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     Tomi Valkeinen <tomba@kernel.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Jyri Sarha <jsarha@ti.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kael_w@yeah.net
Subject: Re: [PATCH] [v2] drivers: gpu: drm: Remove duplicate declaration
Message-ID: <YFyKriqHBgtWiX2q@pendragon.ideasonboard.com>
References: <20210325111028.864628-1-wanjiabing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210325111028.864628-1-wanjiabing@vivo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wan,

Thank you for the patch.

On Thu, Mar 25, 2021 at 07:10:24PM +0800, Wan Jiabing wrote:
> struct dss_device has been declared. Remove the duplicate.
> And sort these forward declarations alphabetically.
> 
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Tomi, I assume you'll handle this patch, please let me know if you don't
plan to do so.

> ---
> Changelog:
> v2:
> - Sort forward declarations alphabetically.
> ---
>  drivers/gpu/drm/omapdrm/dss/omapdss.h | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/omapdrm/dss/omapdss.h b/drivers/gpu/drm/omapdrm/dss/omapdss.h
> index a40abeafd2e9..040d5a3e33d6 100644
> --- a/drivers/gpu/drm/omapdrm/dss/omapdss.h
> +++ b/drivers/gpu/drm/omapdrm/dss/omapdss.h
> @@ -48,16 +48,15 @@
>  #define DISPC_IRQ_ACBIAS_COUNT_STAT3	(1 << 29)
>  #define DISPC_IRQ_FRAMEDONE3		(1 << 30)
>  
> -struct dss_device;
> -struct omap_drm_private;
> -struct omap_dss_device;
>  struct dispc_device;
> +struct drm_connector;
>  struct dss_device;
>  struct dss_lcd_mgr_config;
> +struct hdmi_avi_infoframe;
> +struct omap_drm_private;
> +struct omap_dss_device;
>  struct snd_aes_iec958;
>  struct snd_cea_861_aud_if;
> -struct hdmi_avi_infoframe;
> -struct drm_connector;
>  
>  enum omap_display_type {
>  	OMAP_DISPLAY_TYPE_NONE		= 0,

-- 
Regards,

Laurent Pinchart
