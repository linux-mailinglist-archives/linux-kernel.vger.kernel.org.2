Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2E3C429EED
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 09:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234281AbhJLHtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 03:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbhJLHtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 03:49:20 -0400
Received: from mail.kmu-office.ch (mail.kmu-office.ch [IPv6:2a02:418:6a02::a2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31ACC061570
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 00:47:19 -0700 (PDT)
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 9B0935C4F2C;
        Tue, 12 Oct 2021 09:47:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1634024836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=idxeNrESK9BP1LmBlXetHo/Zea0ePRTKjI8acYZFbjA=;
        b=COK1pFADRNUB2bUX3TNx1IBPD4jUVa+lCgE7EvocCZwIdLntbJ8BZ3DQGyAtOQVsukvOiy
        RK7HtdAcG/EKGQ0HrQw6RzrWlFxwyKOggkJpDQm/MJrTk1k1D7oORlSxMuP0LNVvjJIr3O
        zKodCzhNCCve/P1NQ3GGx2PEvS+t1Lc=
MIME-Version: 1.0
Date:   Tue, 12 Oct 2021 09:47:16 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Marek Vasut <marex@denx.de>,
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
In-Reply-To: <c84b34855abbb85cd25bbb5126db302f88327640.1633959458.git.agx@sigxcpu.org>
References: <cover.1633959458.git.agx@sigxcpu.org>
 <c84b34855abbb85cd25bbb5126db302f88327640.1633959458.git.agx@sigxcpu.org>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <736c1ab73b7d7db5b86ec4902cebec20@agner.ch>
X-Sender: stefan@agner.ch
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-10-11 15:41, Guido Günther wrote:
> media-bus-formats.h has them in hexadecimal as well so matching with
> that file saves one conversion when debugging.
> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> Reviewed-by: Robert Foss <robert.foss@linaro.org>

Acked-by: Stefan Agner <stefan@agner.ch>

> ---
>  drivers/gpu/drm/mxsfb/mxsfb_kms.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/mxsfb/mxsfb_kms.c
> b/drivers/gpu/drm/mxsfb/mxsfb_kms.c
> index af6c620adf6e..d6abd2077114 100644
> --- a/drivers/gpu/drm/mxsfb/mxsfb_kms.c
> +++ b/drivers/gpu/drm/mxsfb/mxsfb_kms.c
> @@ -89,7 +89,7 @@ static void mxsfb_set_formats(struct mxsfb_drm_private *mxsfb,
>  		ctrl |= CTRL_BUS_WIDTH_24;
>  		break;
>  	default:
> -		dev_err(drm->dev, "Unknown media bus format %d\n", bus_format);
> +		dev_err(drm->dev, "Unknown media bus format 0x%x\n", bus_format);
>  		break;
>  	}
