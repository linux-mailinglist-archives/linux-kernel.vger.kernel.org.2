Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD39D429870
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 22:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235059AbhJKUzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 16:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233598AbhJKUzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 16:55:15 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D10C061570
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 13:53:15 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id E30C1FD3;
        Mon, 11 Oct 2021 22:53:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1633985591;
        bh=nCb8Pc9naD2hvMjfW8POZXXVTuH3lwEik2nOAUzxErs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UlB6Wf+qefW7KJvFUnr+gFvcPuYsv2t1/hswzV3aznYW3IaGpfFroFBRohPEWX+8q
         7lnIl8l1T2w+XgdS7KZrga9ft08+VJCMp2YvePTWFNM9gjkN8y/VsExqEZwC8Njp6V
         2eGC1/0eR4ZP76xdLjn2WbSSb1VClAzGJEG0DWVU=
Date:   Mon, 11 Oct 2021 23:52:57 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Marek Vasut <marex@denx.de>,
        Stefan Agner <stefan@agner.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Ondrej Jirman <megous@megous.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 4/5] drm: mxsfb: Print failed bus format in hex
Message-ID: <YWSkKSBnqTMGq/s7@pendragon.ideasonboard.com>
References: <cover.1633959458.git.agx@sigxcpu.org>
 <c84b34855abbb85cd25bbb5126db302f88327640.1633959458.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c84b34855abbb85cd25bbb5126db302f88327640.1633959458.git.agx@sigxcpu.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guido,

Thank you for the patch.

On Mon, Oct 11, 2021 at 03:41:26PM +0200, Guido Günther wrote:
> media-bus-formats.h has them in hexadecimal as well so matching with
> that file saves one conversion when debugging.
> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> Reviewed-by: Robert Foss <robert.foss@linaro.org>
> ---
>  drivers/gpu/drm/mxsfb/mxsfb_kms.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/mxsfb/mxsfb_kms.c b/drivers/gpu/drm/mxsfb/mxsfb_kms.c
> index af6c620adf6e..d6abd2077114 100644
> --- a/drivers/gpu/drm/mxsfb/mxsfb_kms.c
> +++ b/drivers/gpu/drm/mxsfb/mxsfb_kms.c
> @@ -89,7 +89,7 @@ static void mxsfb_set_formats(struct mxsfb_drm_private *mxsfb,
>  		ctrl |= CTRL_BUS_WIDTH_24;
>  		break;
>  	default:
> -		dev_err(drm->dev, "Unknown media bus format %d\n", bus_format);
> +		dev_err(drm->dev, "Unknown media bus format 0x%x\n", bus_format);

I may have gone for 0x%04x as current media bus formats all hold in 16
bits, but it's not big deal.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

>  		break;
>  	}
>  

-- 
Regards,

Laurent Pinchart
