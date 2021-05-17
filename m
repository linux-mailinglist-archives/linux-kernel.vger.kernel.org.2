Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A030383A74
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 18:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241256AbhEQQuK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 17 May 2021 12:50:10 -0400
Received: from aposti.net ([89.234.176.197]:49728 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240137AbhEQQtj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 12:49:39 -0400
Date:   Mon, 17 May 2021 17:48:09 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 1/2] drm: xlnx: add is_layer_vid() to simplify the code
To:     quanyang.wang@windriver.com
Cc:     Hyun Kwon <hyun.kwon@xilinx.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Michal Simek <michal.simek@xilinx.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Message-Id: <90G9TQ.H0YO8VGDCBTU@crapouillou.net>
In-Reply-To: <20210513114540.1241122-2-quanyang.wang@windriver.com>
References: <20210513114540.1241122-1-quanyang.wang@windriver.com>
        <20210513114540.1241122-2-quanyang.wang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quanyang,

Le jeu., mai 13 2021 at 19:45:39 +0800, quanyang.wang@windriver.com a 
écrit :
> From: Quanyang Wang <quanyang.wang@windriver.com>
> 
> Add a new function is_layer_vid() to simplify the code that
> judges if a layer is the video layer.
> 
> Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
> ---
>  drivers/gpu/drm/xlnx/zynqmp_disp.c | 39 
> +++++++++++++++++-------------
>  1 file changed, 22 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp.c 
> b/drivers/gpu/drm/xlnx/zynqmp_disp.c
> index 109d627968ac..c55e24412f8c 100644
> --- a/drivers/gpu/drm/xlnx/zynqmp_disp.c
> +++ b/drivers/gpu/drm/xlnx/zynqmp_disp.c
> @@ -434,30 +434,35 @@ static void zynqmp_disp_avbuf_write(struct 
> zynqmp_disp_avbuf *avbuf,
>  	writel(val, avbuf->base + reg);
>  }
> 
> +static bool is_layer_vid(struct zynqmp_disp_layer *layer)

'layer' should be const.

> +{
> +	return (layer->id == ZYNQMP_DISP_LAYER_VID) ? true : false;

return layer->id == ZYNQMP_DISP_LAYER_VID;

The rest looks good.

With these fixed:
Acked-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

> +}
> +
>  /**
>   * zynqmp_disp_avbuf_set_format - Set the input format for a layer
>   * @avbuf: Audio/video buffer manager
> - * @layer: The layer ID
> + * @layer: The layer
>   * @fmt: The format information
>   *
>   * Set the video buffer manager format for @layer to @fmt.
>   */
>  static void zynqmp_disp_avbuf_set_format(struct zynqmp_disp_avbuf 
> *avbuf,
> -					 enum zynqmp_disp_layer_id layer,
> +					 struct zynqmp_disp_layer *layer,
>  					 const struct zynqmp_disp_format *fmt)
>  {
>  	unsigned int i;
>  	u32 val;
> 
>  	val = zynqmp_disp_avbuf_read(avbuf, ZYNQMP_DISP_AV_BUF_FMT);
> -	val &= layer == ZYNQMP_DISP_LAYER_VID
> +	val &= is_layer_vid(layer)
>  	    ? ~ZYNQMP_DISP_AV_BUF_FMT_NL_VID_MASK
>  	    : ~ZYNQMP_DISP_AV_BUF_FMT_NL_GFX_MASK;
>  	val |= fmt->buf_fmt;
>  	zynqmp_disp_avbuf_write(avbuf, ZYNQMP_DISP_AV_BUF_FMT, val);
> 
>  	for (i = 0; i < ZYNQMP_DISP_AV_BUF_NUM_SF; i++) {
> -		unsigned int reg = layer == ZYNQMP_DISP_LAYER_VID
> +		unsigned int reg = is_layer_vid(layer)
>  				 ? ZYNQMP_DISP_AV_BUF_VID_COMP_SF(i)
>  				 : ZYNQMP_DISP_AV_BUF_GFX_COMP_SF(i);
> 
> @@ -573,19 +578,19 @@ static void 
> zynqmp_disp_avbuf_disable_audio(struct zynqmp_disp_avbuf *avbuf)
>  /**
>   * zynqmp_disp_avbuf_enable_video - Enable a video layer
>   * @avbuf: Audio/video buffer manager
> - * @layer: The layer ID
> + * @layer: The layer
>   * @mode: Operating mode of layer
>   *
>   * Enable the video/graphics buffer for @layer.
>   */
>  static void zynqmp_disp_avbuf_enable_video(struct zynqmp_disp_avbuf 
> *avbuf,
> -					   enum zynqmp_disp_layer_id layer,
> +					   struct zynqmp_disp_layer *layer,
>  					   enum zynqmp_disp_layer_mode mode)
>  {
>  	u32 val;
> 
>  	val = zynqmp_disp_avbuf_read(avbuf, ZYNQMP_DISP_AV_BUF_OUTPUT);
> -	if (layer == ZYNQMP_DISP_LAYER_VID) {
> +	if (is_layer_vid(layer)) {
>  		val &= ~ZYNQMP_DISP_AV_BUF_OUTPUT_VID1_MASK;
>  		if (mode == ZYNQMP_DISP_LAYER_NONLIVE)
>  			val |= ZYNQMP_DISP_AV_BUF_OUTPUT_VID1_MEM;
> @@ -605,17 +610,17 @@ static void 
> zynqmp_disp_avbuf_enable_video(struct zynqmp_disp_avbuf *avbuf,
>  /**
>   * zynqmp_disp_avbuf_disable_video - Disable a video layer
>   * @avbuf: Audio/video buffer manager
> - * @layer: The layer ID
> + * @layer: The layer
>   *
>   * Disable the video/graphics buffer for @layer.
>   */
>  static void zynqmp_disp_avbuf_disable_video(struct zynqmp_disp_avbuf 
> *avbuf,
> -					    enum zynqmp_disp_layer_id layer)
> +					    struct zynqmp_disp_layer *layer)
>  {
>  	u32 val;
> 
>  	val = zynqmp_disp_avbuf_read(avbuf, ZYNQMP_DISP_AV_BUF_OUTPUT);
> -	if (layer == ZYNQMP_DISP_LAYER_VID) {
> +	if (is_layer_vid(layer)) {
>  		val &= ~ZYNQMP_DISP_AV_BUF_OUTPUT_VID1_MASK;
>  		val |= ZYNQMP_DISP_AV_BUF_OUTPUT_VID1_NONE;
>  	} else {
> @@ -807,7 +812,7 @@ static void 
> zynqmp_disp_blend_layer_set_csc(struct zynqmp_disp_blend *blend,
>  		}
>  	}
> 
> -	if (layer->id == ZYNQMP_DISP_LAYER_VID)
> +	if (is_layer_vid(layer))
>  		reg = ZYNQMP_DISP_V_BLEND_IN1CSC_COEFF(0);
>  	else
>  		reg = ZYNQMP_DISP_V_BLEND_IN2CSC_COEFF(0);
> @@ -818,7 +823,7 @@ static void 
> zynqmp_disp_blend_layer_set_csc(struct zynqmp_disp_blend *blend,
>  		zynqmp_disp_blend_write(blend, reg + 8, coeffs[i + swap[2]]);
>  	}
> 
> -	if (layer->id == ZYNQMP_DISP_LAYER_VID)
> +	if (is_layer_vid(layer))
>  		reg = ZYNQMP_DISP_V_BLEND_IN1CSC_OFFSET(0);
>  	else
>  		reg = ZYNQMP_DISP_V_BLEND_IN2CSC_OFFSET(0);
> @@ -1025,7 +1030,7 @@ zynqmp_disp_layer_find_format(struct 
> zynqmp_disp_layer *layer,
>   */
>  static void zynqmp_disp_layer_enable(struct zynqmp_disp_layer *layer)
>  {
> -	zynqmp_disp_avbuf_enable_video(&layer->disp->avbuf, layer->id,
> +	zynqmp_disp_avbuf_enable_video(&layer->disp->avbuf, layer,
>  				       ZYNQMP_DISP_LAYER_NONLIVE);
>  	zynqmp_disp_blend_layer_enable(&layer->disp->blend, layer);
> 
> @@ -1046,7 +1051,7 @@ static void zynqmp_disp_layer_disable(struct 
> zynqmp_disp_layer *layer)
>  	for (i = 0; i < layer->drm_fmt->num_planes; i++)
>  		dmaengine_terminate_sync(layer->dmas[i].chan);
> 
> -	zynqmp_disp_avbuf_disable_video(&layer->disp->avbuf, layer->id);
> +	zynqmp_disp_avbuf_disable_video(&layer->disp->avbuf, layer);
>  	zynqmp_disp_blend_layer_disable(&layer->disp->blend, layer);
>  }
> 
> @@ -1067,7 +1072,7 @@ static void zynqmp_disp_layer_set_format(struct 
> zynqmp_disp_layer *layer,
>  	layer->disp_fmt = zynqmp_disp_layer_find_format(layer, 
> info->format);
>  	layer->drm_fmt = info;
> 
> -	zynqmp_disp_avbuf_set_format(&layer->disp->avbuf, layer->id,
> +	zynqmp_disp_avbuf_set_format(&layer->disp->avbuf, layer,
>  				     layer->disp_fmt);
> 
>  	/*
> @@ -1244,8 +1249,8 @@ static int zynqmp_disp_create_planes(struct 
> zynqmp_disp *disp)
>  			drm_formats[j] = layer->info->formats[j].drm_fmt;
> 
>  		/* Graphics layer is primary, and video layer is overlay. */
> -		type = i == ZYNQMP_DISP_LAYER_GFX
> -		     ? DRM_PLANE_TYPE_PRIMARY : DRM_PLANE_TYPE_OVERLAY;
> +		type = is_layer_vid(layer)
> +		     ? DRM_PLANE_TYPE_OVERLAY : DRM_PLANE_TYPE_PRIMARY;
>  		ret = drm_universal_plane_init(disp->drm, &layer->plane, 0,
>  					       &zynqmp_disp_plane_funcs,
>  					       drm_formats,


