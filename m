Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B301634DCC2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 02:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbhC3ADe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 20:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbhC3ADJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 20:03:09 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58ACC061762
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 17:03:08 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id E2B03102;
        Tue, 30 Mar 2021 02:03:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1617062585;
        bh=z08DZ+zSaLkhCxLYzk2DbSu2wZCH3gpsOvQtJqa4s8c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I7jDfa1MyAI8vHprTjDaLv0F2CW7Ew2AwAn8x8RYuQmM2Zk9dI87gr5Aj3oqBwXxZ
         5FdT9LJE0XpTaoSm6Ww6EyL6bqiSlW0uJoC7d/jtmXhDHGA/LVpZMF/EnGJF+4qtnj
         2lrV+B8/IVPTk0EJ1jDpfYWf/I0z4ZMwdBECJw5I=
Date:   Tue, 30 Mar 2021 03:02:20 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, dafna3@gmail.com, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de, airlied@linux.ie, daniel@ffwll.ch,
        enric.balletbo@collabora.com
Subject: Re: [PATCH v2 1/3] drm/mediatek: Switch the hdmi bridge ops to the
 atomic versions
Message-ID: <YGJqjPp2COsP18As@pendragon.ideasonboard.com>
References: <20210329153632.17559-1-dafna.hirschfeld@collabora.com>
 <20210329153632.17559-2-dafna.hirschfeld@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210329153632.17559-2-dafna.hirschfeld@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dafna,

Thank you for the patch.

On Mon, Mar 29, 2021 at 05:36:30PM +0200, Dafna Hirschfeld wrote:
> The bridge operation '.enable' and the audio cb '.get_eld'
> access hdmi->conn. In the future we will want to support
> the flag DRM_BRIDGE_ATTACH_NO_CONNECTOR and then we will
> not have direct access to the connector.
> The atomic version '.atomic_enable' allows accessing the
> current connector from the state.
> This patch switches the bridge to the atomic version to
> prepare access to the connector in later patches.
> 
> Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/gpu/drm/mediatek/mtk_hdmi.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
> index 8ee55f9e2954..f2c810b767ef 100644
> --- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
> @@ -1357,7 +1357,8 @@ static bool mtk_hdmi_bridge_mode_fixup(struct drm_bridge *bridge,
>  	return true;
>  }
>  
> -static void mtk_hdmi_bridge_disable(struct drm_bridge *bridge)
> +static void mtk_hdmi_bridge_atomic_disable(struct drm_bridge *bridge,
> +					   struct drm_bridge_state *old_bridge_state)
>  {
>  	struct mtk_hdmi *hdmi = hdmi_ctx_from_bridge(bridge);
>  
> @@ -1371,7 +1372,8 @@ static void mtk_hdmi_bridge_disable(struct drm_bridge *bridge)
>  	hdmi->enabled = false;
>  }
>  
> -static void mtk_hdmi_bridge_post_disable(struct drm_bridge *bridge)
> +static void mtk_hdmi_bridge_atomic_post_disable(struct drm_bridge *bridge,
> +						struct drm_bridge_state *old_state)
>  {
>  	struct mtk_hdmi *hdmi = hdmi_ctx_from_bridge(bridge);
>  
> @@ -1406,7 +1408,8 @@ static void mtk_hdmi_bridge_mode_set(struct drm_bridge *bridge,
>  	drm_mode_copy(&hdmi->mode, adjusted_mode);
>  }
>  
> -static void mtk_hdmi_bridge_pre_enable(struct drm_bridge *bridge)
> +static void mtk_hdmi_bridge_atomic_pre_enable(struct drm_bridge *bridge,
> +					      struct drm_bridge_state *old_state)
>  {
>  	struct mtk_hdmi *hdmi = hdmi_ctx_from_bridge(bridge);
>  
> @@ -1426,7 +1429,8 @@ static void mtk_hdmi_send_infoframe(struct mtk_hdmi *hdmi,
>  		mtk_hdmi_setup_vendor_specific_infoframe(hdmi, mode);
>  }
>  
> -static void mtk_hdmi_bridge_enable(struct drm_bridge *bridge)
> +static void mtk_hdmi_bridge_atomic_enable(struct drm_bridge *bridge,
> +					  struct drm_bridge_state *old_state)
>  {
>  	struct mtk_hdmi *hdmi = hdmi_ctx_from_bridge(bridge);
>  
> @@ -1440,13 +1444,16 @@ static void mtk_hdmi_bridge_enable(struct drm_bridge *bridge)
>  }
>  
>  static const struct drm_bridge_funcs mtk_hdmi_bridge_funcs = {
> +	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
> +	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
> +	.atomic_reset = drm_atomic_helper_bridge_reset,
>  	.attach = mtk_hdmi_bridge_attach,
>  	.mode_fixup = mtk_hdmi_bridge_mode_fixup,
> -	.disable = mtk_hdmi_bridge_disable,
> -	.post_disable = mtk_hdmi_bridge_post_disable,
> +	.atomic_disable = mtk_hdmi_bridge_atomic_disable,
> +	.atomic_post_disable = mtk_hdmi_bridge_atomic_post_disable,
>  	.mode_set = mtk_hdmi_bridge_mode_set,
> -	.pre_enable = mtk_hdmi_bridge_pre_enable,
> -	.enable = mtk_hdmi_bridge_enable,
> +	.atomic_pre_enable = mtk_hdmi_bridge_atomic_pre_enable,
> +	.atomic_enable = mtk_hdmi_bridge_atomic_enable,
>  };
>  
>  static int mtk_hdmi_dt_parse_pdata(struct mtk_hdmi *hdmi,

-- 
Regards,

Laurent Pinchart
