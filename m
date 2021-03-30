Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7458834DCD6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 02:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbhC3ALj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 20:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbhC3ALG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 20:11:06 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3ED0C061764
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 17:11:05 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 132E0102;
        Tue, 30 Mar 2021 02:11:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1617063064;
        bh=OtmjXysaK3jwvqRhlDAGqT+DeH6Z5I5DdTqxmZqQzOc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BFsXz7fd5fP8gpej7uSTUYBcJLg0TeErPBtcFQN+5msxzpmNK4thZeGxyQ3JP8fSn
         MYJ/ito/BRdqhFFVZtKGhF3h/qcyQSDZAN4HrJD58FSfzSOX3ozGstIO2YBuvbGOY6
         DoMas8msWu84ewY7ZreWkz9nUvsFeXaUiSrjjY+Q=
Date:   Tue, 30 Mar 2021 03:10:19 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, dafna3@gmail.com, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de, airlied@linux.ie, daniel@ffwll.ch,
        enric.balletbo@collabora.com
Subject: Re: [PATCH v2 3/3] drm/mediatek: in struct mtk_hdmi, replace conn
 field with curr_conn ptr
Message-ID: <YGJsa1LaiCzVrzCn@pendragon.ideasonboard.com>
References: <20210329153632.17559-1-dafna.hirschfeld@collabora.com>
 <20210329153632.17559-4-dafna.hirschfeld@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210329153632.17559-4-dafna.hirschfeld@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dafna,

Thank you for the patch.

On Mon, Mar 29, 2021 at 05:36:32PM +0200, Dafna Hirschfeld wrote:
> The mtk_hdmi does not support creating a bridge with a connector.
> Therefore the field 'conn' should be removed from the mtk_hdmi struct.
> It is replaced with a pointer curr_conn that points to the current
> connector which can be access through the global state.
> 
> Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>

The patch looks good to me, but I'd squash it with 2/3 otherwise I think
you'll break bisection. On the other hand, given that the HDMI support
is already broken... :-)

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

But you need to make sure this patch will get backported to stable along
2/3, probably by adding a fixes tag. Or squashing it with 2/3, up to
you.

> ---
>  drivers/gpu/drm/mediatek/mtk_hdmi.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
> index 1eeb211b1536..0d95d2cfe3de 100644
> --- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
> @@ -153,7 +153,7 @@ struct mtk_hdmi_conf {
>  struct mtk_hdmi {
>  	struct drm_bridge bridge;
>  	struct drm_bridge *next_bridge;
> -	struct drm_connector conn;
> +	struct drm_connector *curr_conn;/* current connector (only valid when 'enabled') */
>  	struct device *dev;
>  	const struct mtk_hdmi_conf *conf;
>  	struct phy *phy;
> @@ -969,7 +969,7 @@ static int mtk_hdmi_setup_avi_infoframe(struct mtk_hdmi *hdmi,
>  	ssize_t err;
>  
>  	err = drm_hdmi_avi_infoframe_from_display_mode(&frame,
> -						       &hdmi->conn, mode);
> +						       hdmi->curr_conn, mode);
>  	if (err < 0) {
>  		dev_err(hdmi->dev,
>  			"Failed to get AVI infoframe from mode: %zd\n", err);
> @@ -1049,7 +1049,7 @@ static int mtk_hdmi_setup_vendor_specific_infoframe(struct mtk_hdmi *hdmi,
>  	ssize_t err;
>  
>  	err = drm_hdmi_vendor_infoframe_from_display_mode(&frame,
> -							  &hdmi->conn, mode);
> +							  hdmi->curr_conn, mode);
>  	if (err) {
>  		dev_err(hdmi->dev,
>  			"Failed to get vendor infoframe from mode: %zd\n", err);
> @@ -1322,6 +1322,8 @@ static void mtk_hdmi_bridge_atomic_disable(struct drm_bridge *bridge,
>  	clk_disable_unprepare(hdmi->clk[MTK_HDMI_CLK_HDMI_PIXEL]);
>  	clk_disable_unprepare(hdmi->clk[MTK_HDMI_CLK_HDMI_PLL]);
>  
> +	hdmi->curr_conn = NULL;
> +
>  	hdmi->enabled = false;
>  }
>  
> @@ -1385,8 +1387,13 @@ static void mtk_hdmi_send_infoframe(struct mtk_hdmi *hdmi,
>  static void mtk_hdmi_bridge_atomic_enable(struct drm_bridge *bridge,
>  					  struct drm_bridge_state *old_state)
>  {
> +	struct drm_atomic_state *state = old_state->base.state;
>  	struct mtk_hdmi *hdmi = hdmi_ctx_from_bridge(bridge);
>  
> +	/* Retrieve the connector through the atomic state. */
> +	hdmi->curr_conn = drm_atomic_get_new_connector_for_encoder(state,
> +								   bridge->encoder);
> +
>  	mtk_hdmi_output_set_display_mode(hdmi, &hdmi->mode);
>  	clk_prepare_enable(hdmi->clk[MTK_HDMI_CLK_HDMI_PLL]);
>  	clk_prepare_enable(hdmi->clk[MTK_HDMI_CLK_HDMI_PIXEL]);
> @@ -1625,8 +1632,10 @@ static int mtk_hdmi_audio_get_eld(struct device *dev, void *data, uint8_t *buf,
>  {
>  	struct mtk_hdmi *hdmi = dev_get_drvdata(dev);
>  
> -	memcpy(buf, hdmi->conn.eld, min(sizeof(hdmi->conn.eld), len));
> -
> +	if (hdmi->enabled)
> +		memcpy(buf, hdmi->curr_conn->eld, min(sizeof(hdmi->curr_conn->eld), len));
> +	else
> +		memset(buf, 0, len);
>  	return 0;
>  }
>  

-- 
Regards,

Laurent Pinchart
