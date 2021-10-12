Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2E6429EF1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 09:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234329AbhJLHt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 03:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbhJLHtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 03:49:55 -0400
Received: from mail.kmu-office.ch (mail.kmu-office.ch [IPv6:2a02:418:6a02::a2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56EAC061570
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 00:47:53 -0700 (PDT)
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 6BA4E5C4F33;
        Tue, 12 Oct 2021 09:47:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1634024872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AXnTSKkY2e0B2s1iLcuJef4R1GNt3oOXcC+O+6O479E=;
        b=x0DCFgIAa+/3RjfWTfsgwWOzWn26jcoKH+jtrjTF5UqQpLv/uMuVMMfvIuuCCASsWusATV
        lAfxAGCQ177VNIOVh/1r15Djvq11iPXbhqKPxoGvGeeP81Xfln2h6NBCM5hlfxruwe25Wc
        TB8APEoTMhDE9Xr8lGn/VpM2AIKwa4w=
MIME-Version: 1.0
Date:   Tue, 12 Oct 2021 09:47:52 +0200
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
Subject: Re: [PATCH v3 5/5] drm: mxsfb: Set fallback bus format when the
 bridge doesn't provide one
In-Reply-To: <781f0352052cc50c823c199ef5f53c84902d0580.1633959458.git.agx@sigxcpu.org>
References: <cover.1633959458.git.agx@sigxcpu.org>
 <781f0352052cc50c823c199ef5f53c84902d0580.1633959458.git.agx@sigxcpu.org>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <486b9224d93c829ef2581bc105d8abdd@agner.ch>
X-Sender: stefan@agner.ch
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-10-11 15:41, Guido Günther wrote:
> If a bridge doesn't do any bus format handling MEDIA_BUS_FMT_FIXED is
> returned. Fallback to a reasonable default (MEDIA_BUS_FMT_RGB888_1X24) in
> that case.
> 
> This unbreaks e.g. using mxsfb with the nwl bridge and mipi dsi panels.
> 
> Reported-by: Martin Kepplinger <martink@posteo.de>
> Signed-off-by: Guido Günther <agx@sigxcpu.org>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

Acked-by: Stefan Agner <stefan@agner.ch>

> ---
>  drivers/gpu/drm/mxsfb/mxsfb_kms.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mxsfb/mxsfb_kms.c
> b/drivers/gpu/drm/mxsfb/mxsfb_kms.c
> index d6abd2077114..e3fbb8b58d5d 100644
> --- a/drivers/gpu/drm/mxsfb/mxsfb_kms.c
> +++ b/drivers/gpu/drm/mxsfb/mxsfb_kms.c
> @@ -369,6 +369,12 @@ static void mxsfb_crtc_atomic_enable(struct drm_crtc *crtc,
>  			drm_atomic_get_new_bridge_state(state,
>  							mxsfb->bridge);
>  		bus_format = bridge_state->input_bus_cfg.format;
> +		if (bus_format == MEDIA_BUS_FMT_FIXED) {
> +			dev_warn_once(drm->dev,
> +				      "Bridge does not provide bus format, assuming
> MEDIA_BUS_FMT_RGB888_1X24.\n"
> +				      "Please fix bridge driver by handling atomic_get_input_bus_fmts.\n");
> +			bus_format = MEDIA_BUS_FMT_RGB888_1X24;
> +		}
>  	}
>  
>  	/* If there is no bridge, use bus format from connector */
