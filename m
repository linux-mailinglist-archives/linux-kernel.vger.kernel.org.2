Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7309A348C2B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 10:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbhCYJF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 05:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhCYJFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 05:05:31 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96307C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 02:05:31 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8985E8C9;
        Thu, 25 Mar 2021 10:05:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1616663124;
        bh=/SywUhKN0TyjTDbmFwZZQmOsTEDAh0nvpn/dDHY+Nrc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E7IpUKonP2G+CJe0y9GlvUurm3qlQRRoNc7AkmcfWBCfMISo5Ik/lbtQ6istzeDaS
         xZmjZw3gtxKL0qrD/M+DDg84q4Up8U+Dpph2k+j5GBQI4zrazi5GVvUw0KFJztt9D1
         SLXV047N1+/VlnlDZoqEXc8KZhd4SJ8vcXPRHdts=
Date:   Thu, 25 Mar 2021 11:04:39 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     Tomi Valkeinen <tomba@kernel.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Jyri Sarha <jsarha@ti.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kael_w@yeah.net
Subject: Re: [PATCH] drivers: gpu: drm: Remove duplicate declaration
Message-ID: <YFxSJ/EQWilHfT51@pendragon.ideasonboard.com>
References: <20210325045022.847135-1-wanjiabing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210325045022.847135-1-wanjiabing@vivo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wan,

Thank you for the patch.

On Thu, Mar 25, 2021 at 12:50:19PM +0800, Wan Jiabing wrote:
> struct dss_device has been declared at 51st line. 
> Remove the duplicate.
> 
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
>  drivers/gpu/drm/omapdrm/dss/omapdss.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/omapdrm/dss/omapdss.h b/drivers/gpu/drm/omapdrm/dss/omapdss.h
> index a40abeafd2e9..2658aadee09a 100644
> --- a/drivers/gpu/drm/omapdrm/dss/omapdss.h
> +++ b/drivers/gpu/drm/omapdrm/dss/omapdss.h
> @@ -52,7 +52,6 @@ struct dss_device;
>  struct omap_drm_private;
>  struct omap_dss_device;
>  struct dispc_device;
> -struct dss_device;
>  struct dss_lcd_mgr_config;
>  struct snd_aes_iec958;
>  struct snd_cea_861_aud_if;

While at it, could you sort these forward declarations alphabetically,
so that duplicates are easier to see ?

-- 
Regards,

Laurent Pinchart
