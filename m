Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9CFE396771
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 19:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbhEaRv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 13:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbhEaRve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 13:51:34 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D970FC06129D
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 10:43:50 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso9264675wmh.4
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 10:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c1dJWE8/bqoCozTf9T8+BdpYclpzU/+Dc7lE6AxNEBI=;
        b=NRPVFwDD8rEy52Orpm6xKCsHgJxm4qfxSPBFHaO3O2WwBO4O/bV2q8L5eMpFYpcF9N
         yMdUV5k6zQ3mqa5b4WTncfq5XO5/7JG1TQzHtyF/mv7eo3I4yUDmmRg0qbysdsrxthkd
         tZIbyUGGtnyavyiJkWgmYZyW1JeFXRc/SOE2E92lYynPtxJ/VHGlUzz+BAij0RsTeohU
         VA9dcXAu+yVKNutno+1Xe0BQQ8m8wwaEOcAkXsRjxRWqd3JxEi6HSPGmYWN9UrjbZYKx
         egONNoYdEU29I6R3SNxWqD2tIijUxDWxxxusYic72vPLvTDFw8ArOMdGO8kyQLF4Ltwn
         uEUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c1dJWE8/bqoCozTf9T8+BdpYclpzU/+Dc7lE6AxNEBI=;
        b=tiAmIi5k9nn+DxA6B4LujF+dBHdVwhUdbahmSq4Y/BdnXynZSJAOJl137x7gkokK29
         4KJvzCtsowaAqR1KRbAoF824QOCBb7fQ8bHQbH/gQwnYSjnhM3hvVweiI6i+nGKUJG7A
         xO5jih7a+hxQr5aIHTluRVC3ecghaxDFWzqdBv2DjztS2BZ24pornNyN1RQss5dP/yiX
         ZKucYv37CD+Da+re/EDyzJXbQAYiU6u5hMn41jJB6zaTQD8WFUKn28CA2G16AwugTYoz
         tW68v5zcTRN3nDRr5SA8rLr7ta65TCHX0HkRITSEFzBbbQxXWF2Ht42GfyAWOI6dVaZI
         FG7A==
X-Gm-Message-State: AOAM533jr8j3NSRE0kfpfcIS+j/YTUbYouAPvdPfQyVQiTY+fbDPJb5M
        jglX+BvFBvgyp7O4N8qup+NbjoOsNRRt3g==
X-Google-Smtp-Source: ABdhPJyXboJnieQj2LScZWMlnYwhxPqeFGUI7x53NANeeCFFPQRA4whYlsvlHjRf03scAH/8Y5WWaQ==
X-Received: by 2002:a7b:c252:: with SMTP id b18mr22627030wmj.32.1622483029523;
        Mon, 31 May 2021 10:43:49 -0700 (PDT)
Received: from kista.localnet (cpe-86-58-17-133.cable.triera.net. [86.58.17.133])
        by smtp.gmail.com with ESMTPSA id m5sm137060wmq.6.2021.05.31.10.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 10:43:48 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Roman Stratiienko <r.stratiienko@gmail.com>, megous@megous.com
Cc:     mripard@kernel.org, wens@csie.org, linux-sunxi@googlegroups.com,
        dri-devel@lists.freedesktop.org,
        Roman Stratiienko <r.stratiienko@gmail.com>
Subject: Re: [PATCH v4 2/2] drm/sun4i: Use CRTC size instead of primary plane size as mixer frame
Date:   Mon, 31 May 2021 19:43:42 +0200
Message-ID: <2057488.cpEgfWUaUY@kista>
In-Reply-To: <20210528203036.17999-3-r.stratiienko@gmail.com>
References: <20210528203036.17999-1-r.stratiienko@gmail.com> <20210528203036.17999-3-r.stratiienko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

General note, you should send Allwinner specific patches to linux-
sunxi@lists.linux.dev too. It's already in MAINTAINERS, but probably it's not 
yet propagated in all trees.

Dne petek, 28. maj 2021 ob 22:30:36 CEST je Roman Stratiienko napisal(a):
> Fixes corrupted display picture when primary plane isn't full-screen.

You should expand this a bit more. Most importantly why this fixes a bug? Rule 
of thumb - if you used word "fix" in commit message, most of the time you 
should add Fixes tag too.

> 
> Signed-off-by: Roman Stratiienko <r.stratiienko@gmail.com>
> ---
>  drivers/gpu/drm/sun4i/sun8i_mixer.c    | 28 ++++++++++++++++++++++++
>  drivers/gpu/drm/sun4i/sun8i_ui_layer.c | 30 --------------------------
>  2 files changed, 28 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/
sun8i_mixer.c
> index 5b42cf25cc86..810c731566c0 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
> @@ -248,6 +248,33 @@ int sun8i_mixer_drm_format_to_hw(u32 format, u32 
*hw_format)
>  	return -EINVAL;
>  }
>  
> +static void sun8i_mode_set(struct sunxi_engine *engine,
> +			   struct drm_display_mode *mode)
> +{
> +	u32 size = SUN8I_MIXER_SIZE(mode->crtc_hdisplay, mode-
>crtc_vdisplay);

CRTC variants are not appropriate here. These are adjusted for interlacing and 
other stuff. This is important during TCON configuration, not here. Just drop 
"crtc_" prefix.

Best regards,
Jernej

> +	struct sun8i_mixer *mixer = engine_to_sun8i_mixer(engine);
> +	u32 bld_base = sun8i_blender_base(mixer);
> +	u32 val;
> +
> +	DRM_DEBUG_DRIVER("Mode change, updating global size W: %u H: %u\n",
> +			 mode->crtc_hdisplay, mode->crtc_vdisplay);
> +	regmap_write(mixer->engine.regs, SUN8I_MIXER_GLOBAL_SIZE, size);
> +	regmap_write(mixer->engine.regs,
> +		     SUN8I_MIXER_BLEND_OUTSIZE(bld_base), size);
> +
> +	if (mode->flags & DRM_MODE_FLAG_INTERLACE)
> +		val = SUN8I_MIXER_BLEND_OUTCTL_INTERLACED;
> +	else
> +		val = 0;
> +
> +	regmap_update_bits(mixer->engine.regs,
> +			   SUN8I_MIXER_BLEND_OUTCTL(bld_base),
> +			   SUN8I_MIXER_BLEND_OUTCTL_INTERLACED,
> +			   val);
> +	DRM_DEBUG_DRIVER("Switching display mixer interlaced mode %s\n",
> +			 val ? "on" : "off");
> +}
> +
>  static void sun8i_mixer_commit(struct sunxi_engine *engine)
>  {
>  	DRM_DEBUG_DRIVER("Committing changes\n");
> @@ -301,6 +328,7 @@ static struct drm_plane **sun8i_layers_init(struct 
drm_device *drm,
>  static const struct sunxi_engine_ops sun8i_engine_ops = {
>  	.commit		= sun8i_mixer_commit,
>  	.layers_init	= sun8i_layers_init,
> +	.mode_set	= sun8i_mode_set,
>  };
>  
>  static const struct regmap_config sun8i_mixer_regmap_config = {
> diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c b/drivers/gpu/drm/sun4i/
sun8i_ui_layer.c
> index 0db164a774a1..d66fff582278 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
> @@ -120,36 +120,6 @@ static int sun8i_ui_layer_update_coord(struct 
sun8i_mixer *mixer, int channel,
>  	insize = SUN8I_MIXER_SIZE(src_w, src_h);
>  	outsize = SUN8I_MIXER_SIZE(dst_w, dst_h);
>  
> -	if (plane->type == DRM_PLANE_TYPE_PRIMARY) {
> -		bool interlaced = false;
> -		u32 val;
> -
> -		DRM_DEBUG_DRIVER("Primary layer, updating global size 
W: %u H: %u\n",
> -				 dst_w, dst_h);
> -		regmap_write(mixer->engine.regs,
> -			     SUN8I_MIXER_GLOBAL_SIZE,
> -			     outsize);
> -		regmap_write(mixer->engine.regs,
> -			     SUN8I_MIXER_BLEND_OUTSIZE(bld_base), 
outsize);
> -
> -		if (state->crtc)
> -			interlaced = state->crtc->state-
>adjusted_mode.flags
> -				& DRM_MODE_FLAG_INTERLACE;
> -
> -		if (interlaced)
> -			val = SUN8I_MIXER_BLEND_OUTCTL_INTERLACED;
> -		else
> -			val = 0;
> -
> -		regmap_update_bits(mixer->engine.regs,
> -				   
SUN8I_MIXER_BLEND_OUTCTL(bld_base),
> -				   
SUN8I_MIXER_BLEND_OUTCTL_INTERLACED,
> -				   val);
> -
> -		DRM_DEBUG_DRIVER("Switching display mixer interlaced 
mode %s\n",
> -				 interlaced ? "on" : "off");
> -	}
> -
>  	/* Set height and width */
>  	DRM_DEBUG_DRIVER("Layer source offset X: %d Y: %d\n",
>  			 state->src.x1 >> 16, state->src.y1 >> 16);
> 


