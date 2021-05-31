Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EADF396760
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 19:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbhEaRsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 13:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbhEaRrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 13:47:53 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D768C0612B0
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 10:24:43 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id z8so6491000wrp.12
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 10:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=npCJsIAlG0AK9KBENp32ZM+mC6ayXbFk+En/Omp/21w=;
        b=lo6+BR3ozPLp5b6btwKr8E00QvJKGphA3AdNvgEKPrH7TDIss2jrGGXYW+GpRyUYKS
         bnFhsI2foJPLq2md028wP3qWQrv+cy/fdaDfWqpOrqn48W1u84Y2190CL+SGarkTIDGz
         4IGMmFu29XPRhMmtaryBKD4ShkENOHfGBJjSK3Lv6zidffPaiC3icEq7zkXMxV2JqXNs
         Z773X2cjcHvLd2DwU3TmeZ3df/PMIKlUvUTgUyG3n96yf818zWY+KK8gxHiLhOu3OtX5
         gaPEQ1YCCTwYc9J+AtSlqQgeT9HSDbR5D1BojK7ShZzcLPLlwg60GCLQHlmHast4byds
         upuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=npCJsIAlG0AK9KBENp32ZM+mC6ayXbFk+En/Omp/21w=;
        b=ENVgNLUjRYpR8QqHryyV7P11yrAzrLXjmkYpxwFj7cgxvBqn/V3YR2UqHgw0zdMd9a
         M/rPDiafUv3OI9fNq0CjkIh+wkN4ScuCgJFVkE+iC5wCzCU6wdcVNl6x6aTz4mnd28iL
         u+grOQ+ETB2gPEDbXpSD2IFwdBCeo7O9CwatH5pjVCfAq6jhgSm8BqDjHv584+FfCMRn
         cuzL7aj5EVbhIS57f6yoTHZXYq22IHcV/aMxjqcq63Aeimc+EW3Qod+tar01C5trQ09n
         I7SsJgH3b+MmgPHaj9XbOtit9Au0NYQabPcIk6O2knclJhvlmbMUXWEeeObIuKE5dc01
         vavg==
X-Gm-Message-State: AOAM5339dzjk0nJrEYzosaGB3yNwTJJTp0tsQzwxcXUoohovY9SgYq63
        QVv383cgiCYE/F0uHP+GiZAmr9e1aRvxIQ==
X-Google-Smtp-Source: ABdhPJwfIhebaxVtlRqoOrfF4WPi9JPXzuniJFs+svcj4biNbP9l8Xc5FO9VQ1eFURCiKU0dCa8mDw==
X-Received: by 2002:a5d:4d05:: with SMTP id z5mr22877966wrt.127.1622481881791;
        Mon, 31 May 2021 10:24:41 -0700 (PDT)
Received: from kista.localnet (cpe-86-58-17-133.cable.triera.net. [86.58.17.133])
        by smtp.gmail.com with ESMTPSA id b135sm90191wmb.5.2021.05.31.10.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 10:24:41 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Roman Stratiienko <r.stratiienko@gmail.com>
Cc:     mripard@kernel.org, wens@csie.org, jernej.skrabec@siol.net,
        megous@megous.com, linux-sunxi@googlegroups.com,
        dri-devel@lists.freedesktop.org,
        Roman Stratiienko <r.stratiienko@gmail.com>
Subject: Re: [PATCH v4 1/2] drm/sun4i: Add mode_set callback to the engine
Date:   Mon, 31 May 2021 19:24:40 +0200
Message-ID: <2404786.ubhusWIBXB@kista>
In-Reply-To: <20210528203036.17999-2-r.stratiienko@gmail.com>
References: <20210528203036.17999-1-r.stratiienko@gmail.com> <20210528203036.17999-2-r.stratiienko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Dne petek, 28. maj 2021 ob 22:30:35 CEST je Roman Stratiienko napisal(a):
> Create callback to allow updating engine's registers on mode change.
> 
> Signed-off-by: Roman Stratiienko <r.stratiienko@gmail.com>
> Reviewed-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  drivers/gpu/drm/sun4i/sun4i_crtc.c   |  3 +++
>  drivers/gpu/drm/sun4i/sunxi_engine.h | 12 ++++++++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun4i_crtc.c b/drivers/gpu/drm/sun4i/
sun4i_crtc.c
> index 45d9eb552d86..8f01a6b2bbef 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_crtc.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_crtc.c
> @@ -146,6 +146,9 @@ static void sun4i_crtc_mode_set_nofb(struct drm_crtc 
*crtc)
>  	struct sun4i_crtc *scrtc = drm_crtc_to_sun4i_crtc(crtc);
>  
>  	sun4i_tcon_mode_set(scrtc->tcon, encoder, mode);
> +
> +	if (scrtc->engine->ops->mode_set)
> +		scrtc->engine->ops->mode_set(scrtc->engine, mode);
>  }
>  
>  static const struct drm_crtc_helper_funcs sun4i_crtc_helper_funcs = {
> diff --git a/drivers/gpu/drm/sun4i/sunxi_engine.h b/drivers/gpu/drm/sun4i/
sunxi_engine.h
> index 548710a936d5..7faa844646ff 100644
> --- a/drivers/gpu/drm/sun4i/sunxi_engine.h
> +++ b/drivers/gpu/drm/sun4i/sunxi_engine.h
> @@ -9,6 +9,7 @@
>  struct drm_plane;
>  struct drm_device;
>  struct drm_crtc_state;
> +struct drm_display_mode;
>  
>  struct sunxi_engine;
>  
> @@ -108,6 +109,17 @@ struct sunxi_engine_ops {
>  	 * This function is optional.
>  	 */
>  	void (*vblank_quirk)(struct sunxi_engine *engine);
> +
> +	/**
> +	 * @mode_set:
> +	 *
> +	 * This callback is used to update engine registers that
> +	 * responsible for display frame size and other mode attributes.
> +	 *
> +	 * This function is optional.
> +	 */
> +	void (*mode_set)(struct sunxi_engine *engine,
> +			 struct drm_display_mode *mode);

Mark mode as const.

Best regards,
Jernej

>  };
>  
>  /**
> 


