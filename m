Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2A6533A258
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 03:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233723AbhCNCQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 21:16:23 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:45190 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbhCNCPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 21:15:51 -0500
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0320E55C;
        Sun, 14 Mar 2021 03:15:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1615688150;
        bh=DKsxYktuuGnusRXJGBQqTLHN0r6C6x8dBcI2xv+gbos=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pHZm8riY74l8W/JQpcFEYe4VWPBYb0NL+62WF/W5j5QFq89rRy2pRwspPS8FAKb4J
         IQIq1kOlo4eQUT43Px638X5Qa0Jdm+dh52yD7ZS3KFuhyJgn/di4uG+rlJvdAQkdYs
         DvJ/a2dxMDfmW9eIb3nDkaXc2UfSoII0crFFJNjo=
Date:   Sun, 14 Mar 2021 04:15:14 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     angkery <angkery@163.com>
Cc:     tomba@kernel.org, airlied@linux.ie, daniel@ffwll.ch,
        sebastian.reichel@collabora.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Junlin Yang <yangjunlin@yulong.com>
Subject: Re: [PATCH] drm/omap: dsi: fix unsigned expression compared with zero
Message-ID: <YE1xsg0gm0nNR8hy@pendragon.ideasonboard.com>
References: <20210312071445.1721-1-angkery@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210312071445.1721-1-angkery@163.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Junlin,

Thank you for the patch.

On Fri, Mar 12, 2021 at 03:14:45PM +0800, angkery wrote:
> From: Junlin Yang <yangjunlin@yulong.com>
> 
> r is "u32" always >= 0,mipi_dsi_create_packet may return little than zero.
> so r < 0 condition is never accessible.
> 
> Fixes coccicheck warnings:
> ./drivers/gpu/drm/omapdrm/dss/dsi.c:2155:5-6:
> WARNING: Unsigned expression compared with zero: r < 0
> 
> Signed-off-by: Junlin Yang <yangjunlin@yulong.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Tomi, will you take this in your tree ?

> ---
>  drivers/gpu/drm/omapdrm/dss/dsi.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/omapdrm/dss/dsi.c b/drivers/gpu/drm/omapdrm/dss/dsi.c
> index 8e11612..b31d750 100644
> --- a/drivers/gpu/drm/omapdrm/dss/dsi.c
> +++ b/drivers/gpu/drm/omapdrm/dss/dsi.c
> @@ -2149,11 +2149,12 @@ static int dsi_vc_send_short(struct dsi_data *dsi, int vc,
>  			     const struct mipi_dsi_msg *msg)
>  {
>  	struct mipi_dsi_packet pkt;
> +	int ret;
>  	u32 r;
>  
> -	r = mipi_dsi_create_packet(&pkt, msg);
> -	if (r < 0)
> -		return r;
> +	ret = mipi_dsi_create_packet(&pkt, msg);
> +	if (ret < 0)
> +		return ret;
>  
>  	WARN_ON(!dsi_bus_is_locked(dsi));
>  

-- 
Regards,

Laurent Pinchart
