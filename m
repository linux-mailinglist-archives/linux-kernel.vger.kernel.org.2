Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59691383AC2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 19:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235587AbhEQRK6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 17 May 2021 13:10:58 -0400
Received: from aposti.net ([89.234.176.197]:52370 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232261AbhEQRK4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 13:10:56 -0400
Date:   Mon, 17 May 2021 18:09:26 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 2/2] drm: xlnx: consolidate the functions which
 programming AUDIO_VIDEO_SELECT register
To:     quanyang.wang@windriver.com
Cc:     Hyun Kwon <hyun.kwon@xilinx.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Michal Simek <michal.simek@xilinx.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Message-Id: <QZG9TQ.LU7WK53ECH511@crapouillou.net>
In-Reply-To: <20210513114540.1241122-3-quanyang.wang@windriver.com>
References: <20210513114540.1241122-1-quanyang.wang@windriver.com>
        <20210513114540.1241122-3-quanyang.wang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le jeu., mai 13 2021 at 19:45:40 +0800, quanyang.wang@windriver.com a 
écrit :
> From: Quanyang Wang <quanyang.wang@windriver.com>
> 
> For now, the functions zynqmp_disp_avbuf_enable/disable_audio and
> zynqmp_disp_avbuf_enable/disable_video are all programming the 
> register
> AV_BUF_OUTPUT_AUDIO_VIDEO_SELECT to select the output for audio or 
> video.
> And in the future, many drm properties (like video_tpg, audio_tpg,
> audio_pl, etc) also need to access it. So let's introduce some 
> variables
> of enum type and consolidate the code to unify handling this.
> 
> Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
> ---
>  drivers/gpu/drm/xlnx/zynqmp_disp.c      | 166 
> ++++++++++++++----------
>  drivers/gpu/drm/xlnx/zynqmp_disp_regs.h |  15 +--
>  2 files changed, 101 insertions(+), 80 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp.c 
> b/drivers/gpu/drm/xlnx/zynqmp_disp.c
> index c55e24412f8c..a82bc88a98aa 100644
> --- a/drivers/gpu/drm/xlnx/zynqmp_disp.c
> +++ b/drivers/gpu/drm/xlnx/zynqmp_disp.c
> @@ -102,12 +102,39 @@ enum zynqmp_disp_layer_id {
> 
>  /**
>   * enum zynqmp_disp_layer_mode - Layer mode
> - * @ZYNQMP_DISP_LAYER_NONLIVE: non-live (memory) mode
> + * @ZYNQMP_DISP_LAYER_MEM: memory mode
>   * @ZYNQMP_DISP_LAYER_LIVE: live (stream) mode
> + * @ZYNQMP_DISP_LAYER_TPG: tpg mode (only for video layer)
> + * @ZYNQMP_DISP_LAYER_DISABLE: disable mode
>   */
>  enum zynqmp_disp_layer_mode {
> -	ZYNQMP_DISP_LAYER_NONLIVE,
> -	ZYNQMP_DISP_LAYER_LIVE
> +	ZYNQMP_DISP_LAYER_MEM,
> +	ZYNQMP_DISP_LAYER_LIVE,
> +	ZYNQMP_DISP_LAYER_TPG,
> +	ZYNQMP_DISP_LAYER_DISABLE
> +};
> +
> +enum avbuf_vid_mode {
> +	VID_MODE_LIVE,
> +	VID_MODE_MEM,
> +	VID_MODE_TPG,
> +	VID_MODE_NONE
> +};
> +
> +enum avbuf_gfx_mode {
> +	GFX_MODE_DISABLE,
> +	GFX_MODE_MEM,
> +	GFX_MODE_LIVE,
> +	GFX_MODE_NONE
> +};
> +
> +enum avbuf_aud_mode {
> +	AUD1_MODE_LIVE,
> +	AUD1_MODE_MEM,
> +	AUD1_MODE_TPG,
> +	AUD1_MODE_DISABLE,
> +	AUD2_MODE_DISABLE,
> +	AUD2_MODE_ENABLE
>  };
> 
>  /**
> @@ -542,92 +569,98 @@ static void 
> zynqmp_disp_avbuf_disable_channels(struct zynqmp_disp_avbuf *avbuf)
>  }
> 
>  /**
> - * zynqmp_disp_avbuf_enable_audio - Enable audio
> + * zynqmp_disp_avbuf_output_select - Select the buffer manager 
> outputs
>   * @avbuf: Audio/video buffer manager
> + * @layer: The layer
> + * @mode: The mode for this layer
>   *
> - * Enable all audio buffers with a non-live (memory) source.
> + * Select the buffer manager outputs for @layer.
>   */
> -static void zynqmp_disp_avbuf_enable_audio(struct zynqmp_disp_avbuf 
> *avbuf)
> +static void zynqmp_disp_avbuf_output_select(struct zynqmp_disp_avbuf 
> *avbuf,
> +					   struct zynqmp_disp_layer *layer, u32 mode)

You can put 'mode' on a new line to avoid getting over 80 characters.

>  {
> -	u32 val;
> -
> -	val = zynqmp_disp_avbuf_read(avbuf, ZYNQMP_DISP_AV_BUF_OUTPUT);
> -	val &= ~ZYNQMP_DISP_AV_BUF_OUTPUT_AUD1_MASK;
> -	val |= ZYNQMP_DISP_AV_BUF_OUTPUT_AUD1_MEM;
> -	val |= ZYNQMP_DISP_AV_BUF_OUTPUT_AUD2_EN;
> -	zynqmp_disp_avbuf_write(avbuf, ZYNQMP_DISP_AV_BUF_OUTPUT, val);
> +	u32 reg;
> +
> +	reg = zynqmp_disp_avbuf_read(avbuf, ZYNQMP_DISP_AV_BUF_OUTPUT);

Empty line here (spacing before comment)

> +	/* Select audio mode when the layer is NULL */
> +	if (layer == NULL) {
> +		if (mode >= AUD2_MODE_DISABLE) {
> +			reg &= ~ZYNQMP_DISP_AV_BUF_OUTPUT_AUD2_MASK;
> +			reg |= (mode - AUD2_MODE_DISABLE)
> +				<< ZYNQMP_DISP_AV_BUF_OUTPUT_AUD2_SHIFT;

Please consider using the FIELD_PREP() macro from <linux/bitfield.h>. 
Then you can get rid of your *_SHIFT macros.

> +		} else {
> +			reg &= ~ZYNQMP_DISP_AV_BUF_OUTPUT_AUD1_MASK;
> +			reg |= mode << ZYNQMP_DISP_AV_BUF_OUTPUT_AUD1_SHIFT;
> +		}
> +	} else if (is_layer_vid(layer)) {
> +		reg &= ~ZYNQMP_DISP_AV_BUF_OUTPUT_VID1_MASK;
> +		reg |= mode << ZYNQMP_DISP_AV_BUF_OUTPUT_VID1_SHIFT;
> +	} else {
> +		reg &= ~ZYNQMP_DISP_AV_BUF_OUTPUT_VID2_MASK;
> +		reg |= mode << ZYNQMP_DISP_AV_BUF_OUTPUT_VID2_SHIFT;
> +	}

Empty line here (spacing after block)

> +	zynqmp_disp_avbuf_write(avbuf, ZYNQMP_DISP_AV_BUF_OUTPUT, reg);
>  }
> 
>  /**
> - * zynqmp_disp_avbuf_disable_audio - Disable audio
> + * zynqmp_disp_avbuf_enable_audio - Enable audio
>   * @avbuf: Audio/video buffer manager
>   *
> - * Disable all audio buffers.
> + * Enable all audio buffers.
>   */
> -static void zynqmp_disp_avbuf_disable_audio(struct zynqmp_disp_avbuf 
> *avbuf)
> +static void zynqmp_disp_avbuf_enable_audio(struct zynqmp_disp_avbuf 
> *avbuf)
>  {
> -	u32 val;
> -
> -	val = zynqmp_disp_avbuf_read(avbuf, ZYNQMP_DISP_AV_BUF_OUTPUT);
> -	val &= ~ZYNQMP_DISP_AV_BUF_OUTPUT_AUD1_MASK;
> -	val |= ZYNQMP_DISP_AV_BUF_OUTPUT_AUD1_DISABLE;

Same as above with FIELD_PREP().

> -	val &= ~ZYNQMP_DISP_AV_BUF_OUTPUT_AUD2_EN;
> -	zynqmp_disp_avbuf_write(avbuf, ZYNQMP_DISP_AV_BUF_OUTPUT, val);
> +	zynqmp_disp_avbuf_output_select(avbuf, NULL, AUD1_MODE_MEM);
> +	zynqmp_disp_avbuf_output_select(avbuf, NULL, AUD2_MODE_ENABLE);
>  }
> 
>  /**
> - * zynqmp_disp_avbuf_enable_video - Enable a video layer
> + * zynqmp_disp_avbuf_disable_audio - Disable audio
>   * @avbuf: Audio/video buffer manager
> - * @layer: The layer
> - * @mode: Operating mode of layer
>   *
> - * Enable the video/graphics buffer for @layer.
> + * Disable all audio buffers.
>   */
> -static void zynqmp_disp_avbuf_enable_video(struct zynqmp_disp_avbuf 
> *avbuf,
> -					   struct zynqmp_disp_layer *layer,
> -					   enum zynqmp_disp_layer_mode mode)
> +static void zynqmp_disp_avbuf_disable_audio(struct zynqmp_disp_avbuf 
> *avbuf)
>  {
> -	u32 val;
> -
> -	val = zynqmp_disp_avbuf_read(avbuf, ZYNQMP_DISP_AV_BUF_OUTPUT);
> -	if (is_layer_vid(layer)) {
> -		val &= ~ZYNQMP_DISP_AV_BUF_OUTPUT_VID1_MASK;
> -		if (mode == ZYNQMP_DISP_LAYER_NONLIVE)
> -			val |= ZYNQMP_DISP_AV_BUF_OUTPUT_VID1_MEM;
> -		else
> -			val |= ZYNQMP_DISP_AV_BUF_OUTPUT_VID1_LIVE;
> -	} else {
> -		val &= ~ZYNQMP_DISP_AV_BUF_OUTPUT_VID2_MASK;
> -		val |= ZYNQMP_DISP_AV_BUF_OUTPUT_VID2_MEM;
> -		if (mode == ZYNQMP_DISP_LAYER_NONLIVE)
> -			val |= ZYNQMP_DISP_AV_BUF_OUTPUT_VID2_MEM;
> -		else
> -			val |= ZYNQMP_DISP_AV_BUF_OUTPUT_VID2_LIVE;
> -	}
> -	zynqmp_disp_avbuf_write(avbuf, ZYNQMP_DISP_AV_BUF_OUTPUT, val);
> +	zynqmp_disp_avbuf_output_select(avbuf, NULL, AUD1_MODE_DISABLE);
> +	zynqmp_disp_avbuf_output_select(avbuf, NULL, AUD2_MODE_DISABLE);
>  }
> 
>  /**
> - * zynqmp_disp_avbuf_disable_video - Disable a video layer
> - * @avbuf: Audio/video buffer manager
> + * zynqmp_disp_avbuf_set_layer_output -Set layer output

You're missing a space after the dash character.

>   * @layer: The layer
> + * @mode: The layer mode
>   *
> - * Disable the video/graphics buffer for @layer.
> + * Set output for @layer
>   */
> -static void zynqmp_disp_avbuf_disable_video(struct zynqmp_disp_avbuf 
> *avbuf,
> -					    struct zynqmp_disp_layer *layer)
> +static void zynqmp_disp_avbuf_set_layer_output(struct 
> zynqmp_disp_layer *layer,
> +					   enum zynqmp_disp_layer_mode mode)
>  {
> -	u32 val;
> -
> -	val = zynqmp_disp_avbuf_read(avbuf, ZYNQMP_DISP_AV_BUF_OUTPUT);
> -	if (is_layer_vid(layer)) {
> -		val &= ~ZYNQMP_DISP_AV_BUF_OUTPUT_VID1_MASK;
> -		val |= ZYNQMP_DISP_AV_BUF_OUTPUT_VID1_NONE;
> -	} else {
> -		val &= ~ZYNQMP_DISP_AV_BUF_OUTPUT_VID2_MASK;
> -		val |= ZYNQMP_DISP_AV_BUF_OUTPUT_VID2_DISABLE;
> +	int val;
> +	struct zynqmp_disp *disp = layer->disp;

I'd swap these two lines above - variables are usually defined in 
"reverse christmas tree" order, the longest line first, the smallest 
line last. No big deal though.

> +
> +	switch (mode) {
> +	case ZYNQMP_DISP_LAYER_LIVE:
> +		val = is_layer_vid(layer) ? VID_MODE_LIVE : GFX_MODE_LIVE;
> +		break;
> +	case ZYNQMP_DISP_LAYER_MEM:
> +		val = is_layer_vid(layer) ? VID_MODE_MEM : GFX_MODE_MEM;
> +		break;
> +	case ZYNQMP_DISP_LAYER_TPG:
> +		if (!is_layer_vid(layer)) {
> +			dev_err(disp->dev, "gfx layer has no tpg mode\n");
> +			return;
> +		}
> +		val = VID_MODE_TPG;
> +		break;
> +	case ZYNQMP_DISP_LAYER_DISABLE:
> +		val = is_layer_vid(layer) ? VID_MODE_NONE : GFX_MODE_DISABLE;
> +		break;
> +	default:
> +		dev_err(disp->dev, "invalid layer mode\n");
> +		return;
>  	}
> -	zynqmp_disp_avbuf_write(avbuf, ZYNQMP_DISP_AV_BUF_OUTPUT, val);

While you're at it, you can add an empty line here (spacing after block)

> +	zynqmp_disp_avbuf_output_select(&disp->avbuf, layer, val);
>  }
> 
>  /**
> @@ -1030,11 +1063,10 @@ zynqmp_disp_layer_find_format(struct 
> zynqmp_disp_layer *layer,
>   */
>  static void zynqmp_disp_layer_enable(struct zynqmp_disp_layer *layer)
>  {
> -	zynqmp_disp_avbuf_enable_video(&layer->disp->avbuf, layer,
> -				       ZYNQMP_DISP_LAYER_NONLIVE);
> +	zynqmp_disp_avbuf_set_layer_output(layer, ZYNQMP_DISP_LAYER_MEM);
>  	zynqmp_disp_blend_layer_enable(&layer->disp->blend, layer);
> 
> -	layer->mode = ZYNQMP_DISP_LAYER_NONLIVE;
> +	layer->mode = ZYNQMP_DISP_LAYER_MEM;
>  }
> 
>  /**
> @@ -1051,7 +1083,7 @@ static void zynqmp_disp_layer_disable(struct 
> zynqmp_disp_layer *layer)
>  	for (i = 0; i < layer->drm_fmt->num_planes; i++)
>  		dmaengine_terminate_sync(layer->dmas[i].chan);
> 
> -	zynqmp_disp_avbuf_disable_video(&layer->disp->avbuf, layer);
> +	zynqmp_disp_avbuf_set_layer_output(layer, 
> ZYNQMP_DISP_LAYER_DISABLE);
>  	zynqmp_disp_blend_layer_disable(&layer->disp->blend, layer);
>  }
> 
> diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp_regs.h 
> b/drivers/gpu/drm/xlnx/zynqmp_disp_regs.h
> index f92a006d5070..dad3e356d9ab 100644
> --- a/drivers/gpu/drm/xlnx/zynqmp_disp_regs.h
> +++ b/drivers/gpu/drm/xlnx/zynqmp_disp_regs.h
> @@ -120,23 +120,12 @@
>  #define ZYNQMP_DISP_AV_BUF_OUTPUT			0x70
>  #define ZYNQMP_DISP_AV_BUF_OUTPUT_VID1_SHIFT		0
>  #define ZYNQMP_DISP_AV_BUF_OUTPUT_VID1_MASK		(0x3 << 0)
> -#define ZYNQMP_DISP_AV_BUF_OUTPUT_VID1_LIVE		(0 << 0)
> -#define ZYNQMP_DISP_AV_BUF_OUTPUT_VID1_MEM		(1 << 0)
> -#define ZYNQMP_DISP_AV_BUF_OUTPUT_VID1_PATTERN		(2 << 0)
> -#define ZYNQMP_DISP_AV_BUF_OUTPUT_VID1_NONE		(3 << 0)
>  #define ZYNQMP_DISP_AV_BUF_OUTPUT_VID2_SHIFT		2
>  #define ZYNQMP_DISP_AV_BUF_OUTPUT_VID2_MASK		(0x3 << 2)
> -#define ZYNQMP_DISP_AV_BUF_OUTPUT_VID2_DISABLE		(0 << 2)
> -#define ZYNQMP_DISP_AV_BUF_OUTPUT_VID2_MEM		(1 << 2)
> -#define ZYNQMP_DISP_AV_BUF_OUTPUT_VID2_LIVE		(2 << 2)
> -#define ZYNQMP_DISP_AV_BUF_OUTPUT_VID2_NONE		(3 << 2)
>  #define ZYNQMP_DISP_AV_BUF_OUTPUT_AUD1_SHIFT		4
>  #define ZYNQMP_DISP_AV_BUF_OUTPUT_AUD1_MASK		(0x3 << 4)
> -#define ZYNQMP_DISP_AV_BUF_OUTPUT_AUD1_PL		(0 << 4)
> -#define ZYNQMP_DISP_AV_BUF_OUTPUT_AUD1_MEM		(1 << 4)
> -#define ZYNQMP_DISP_AV_BUF_OUTPUT_AUD1_PATTERN		(2 << 4)
> -#define ZYNQMP_DISP_AV_BUF_OUTPUT_AUD1_DISABLE		(3 << 4)
> -#define ZYNQMP_DISP_AV_BUF_OUTPUT_AUD2_EN		BIT(6)
> +#define ZYNQMP_DISP_AV_BUF_OUTPUT_AUD2_MASK		(0x1 << 6)
> +#define ZYNQMP_DISP_AV_BUF_OUTPUT_AUD2_SHIFT		6

Please use BIT() or GENMASK(). You don't need the _SHIFT macros if you 
use FIELD_PREP() / FIELD_GET().

Cheers,
-Paul

>  #define ZYNQMP_DISP_AV_BUF_HCOUNT_VCOUNT_INT0		0x74
>  #define ZYNQMP_DISP_AV_BUF_HCOUNT_VCOUNT_INT1		0x78
>  #define ZYNQMP_DISP_AV_BUF_PATTERN_GEN_SELECT		0x100


