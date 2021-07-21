Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC2063D0E92
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 14:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234249AbhGULZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 07:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236463AbhGULY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 07:24:59 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2AFBC0613E0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 05:05:04 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id f17so1916922wrt.6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 05:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=z6z6wcsCD0sgswylDcSLb5hJNlUUlxqeQM6i1pyENB8=;
        b=Pwmq/YdDmpsIlO2A2QRk6mJt4pqqfcVj1+GAnKLpdRZROoy1WP0Ahtu6IsX2NZCwey
         I6B62etiKj6ilJ+LvoSviQJkvnmZVR/NG75sDFjoi4ZnZliV1t89Ql2qqttaXT13dkFF
         LAQ4NrxOZIkMLM5mItPLq7SIiJUUHGlAwHLSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=z6z6wcsCD0sgswylDcSLb5hJNlUUlxqeQM6i1pyENB8=;
        b=QyoKlTIyBXtUhDTPq6C0L84dz+7496RgKS/tiLw6JlseM54MFBnbJ9YdDutNxI3Yo+
         dHKWqbYGLja2NvaLKtt2OiMqe9vKGpsQsLy9Y1f4nXfe7CHBiHJxBX8jSXVI5Iu73riU
         zgV5YBQfwenPOR9+R4sebRiWVvKMnQgQABH20LdvZLrPGH7RLohhc9VeP7d/b6nK2PTM
         vL6Ui2f6tRRzis/08dZJLKUDxfJtNYWqGPqPPUTyZKGZ8vPG3KTebEGLfVhf9bQQvRml
         6XQOJ2EKsKEualDQdOLY2dQao9CYkRvee1qk62AI793wRQ/oSD0D/zZF9BUsbu2P4xJq
         7/Ww==
X-Gm-Message-State: AOAM531uOzb1sEiGsWWVgYJNpbb5FMMKt3V2vr/2QmBiDt21Yy+6oDLa
        dQFsvQOUCQQ+5SJ9a7vXKvHtAw==
X-Google-Smtp-Source: ABdhPJysxSwXxGVP2K2pQwV/yw6g/ztlYnUO5QhknYExb/6qci30zTKDiDX0fOLM3erwYlbkfytHoA==
X-Received: by 2002:a5d:5550:: with SMTP id g16mr10124556wrw.342.1626869103477;
        Wed, 21 Jul 2021 05:05:03 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id z7sm13593957wrt.94.2021.07.21.05.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 05:05:03 -0700 (PDT)
Date:   Wed, 21 Jul 2021 14:05:01 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Robert Foss <robert.foss@linaro.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 04/10] drm/bridge: Document the probe issue with MIPI-DSI
 bridges
Message-ID: <YPgNbVoNnq3fTMN2@phenom.ffwll.local>
Mail-Followup-To: Maxime Ripard <maxime@cerno.tech>,
        Robert Foss <robert.foss@linaro.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>, Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20210720134525.563936-1-maxime@cerno.tech>
 <20210720134525.563936-5-maxime@cerno.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210720134525.563936-5-maxime@cerno.tech>
X-Operating-System: Linux phenom 5.10.0-7-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 20, 2021 at 03:45:19PM +0200, Maxime Ripard wrote:
> Interactions between bridges, panels, MIPI-DSI host and the component
> framework are not trivial and can lead to probing issues when
> implementing a display driver. Let's document the various cases we need
> too consider, and the solution to support all the cases.
> 
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

I still have this dream that eventually we resurrect a patch to add
device_link to bridges/panels (ideally automatically), to help with some
of the suspend/resume issues around here.

Will this make things worse?

I think it'd be really good to figure that out with some coding, since if
we have incompatible solution to handle probe issues vs suspend/resume
issues, we're screwed.

Atm the duct-tape is to carefully move things around between suspend and
suspend_early hooks (and resume and resume_late) and hope it all works ...
-Daniel

> ---
>  Documentation/gpu/drm-kms-helpers.rst |  6 +++
>  drivers/gpu/drm/drm_bridge.c          | 60 +++++++++++++++++++++++++++
>  2 files changed, 66 insertions(+)
> 
> diff --git a/Documentation/gpu/drm-kms-helpers.rst b/Documentation/gpu/drm-kms-helpers.rst
> index 10f8df7aecc0..ec2f65b31930 100644
> --- a/Documentation/gpu/drm-kms-helpers.rst
> +++ b/Documentation/gpu/drm-kms-helpers.rst
> @@ -157,6 +157,12 @@ Display Driver Integration
>  .. kernel-doc:: drivers/gpu/drm/drm_bridge.c
>     :doc: display driver integration
>  
> +Special Care with MIPI-DSI bridges
> +----------------------------------
> +
> +.. kernel-doc:: drivers/gpu/drm/drm_bridge.c
> +   :doc: special care dsi
> +
>  Bridge Operations
>  -----------------
>  
> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index c9a950bfdfe5..81f8dac12367 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -95,6 +95,66 @@
>   * documentation of bridge operations for more details).
>   */
>  
> +/**
> + * DOC: special care dsi
> + *
> + * The interaction between the bridges and other frameworks involved in
> + * the probing of the display driver and the bridge driver can be
> + * challenging. Indeed, there's multiple cases that needs to be
> + * considered:
> + *
> + * - The display driver doesn't use the component framework and isn't a
> + *   MIPI-DSI host. In this case, the bridge driver will probe at some
> + *   point and the display driver should try to probe again by returning
> + *   EPROBE_DEFER as long as the bridge driver hasn't probed.
> + *
> + * - The display driver doesn't use the component framework, but is a
> + *   MIPI-DSI host. The bridge device uses the MIPI-DCS commands to be
> + *   controlled. In this case, the bridge device is a child of the
> + *   display device and when it will probe it's assured that the display
> + *   device (and MIPI-DSI host) is present. The display driver will be
> + *   assured that the bridge driver is connected between the
> + *   &mipi_dsi_host_ops.attach and &mipi_dsi_host_ops.detach operations.
> + *   Therefore, it must run mipi_dsi_host_register() in its probe
> + *   function, and then run drm_bridge_attach() in its
> + *   &mipi_dsi_host_ops.attach hook.
> + *
> + * - The display driver uses the component framework and is a MIPI-DSI
> + *   host. The bridge device uses the MIPI-DCS commands to be
> + *   controlled. This is the same situation than above, and can run
> + *   mipi_dsi_host_register() in either its probe or bind hooks.
> + *
> + * - The display driver uses the component framework and is a MIPI-DSI
> + *   host. The bridge device uses a separate bus (such as I2C) to be
> + *   controlled. In this case, there's no correlation between the probe
> + *   of the bridge and display drivers, so care must be taken to avoid
> + *   an endless EPROBE_DEFER loop, with each driver waiting for the
> + *   other to probe.
> + *
> + * The ideal pattern to cover the last item (and all the others in the
> + * display driver case) is to split the operations like this:
> + *
> + * - In the display driver must run mipi_dsi_host_register() and
> + *   component_add in its probe hook. It will make sure that the
> + *   MIPI-DSI host sticks around, and that the driver's bind can be
> + *   called.
> + *
> + * - In its probe hook, the bridge driver must not try to find its
> + *   MIPI-DSI host or register as a MIPI-DSI device. As far as the
> + *   framework is concerned, it must only call drm_bridge_add().
> + *
> + * - In its bind hook, the display driver must try to find the bridge
> + *   and return -EPROBE_DEFER if it doesn't find it. If it's there, it
> + *   must call drm_bridge_attach(). The MIPI-DSI host is now functional.
> + *
> + * - In its &drm_bridge_funcs.attach hook, the bridge driver can now try
> + *   to find its MIPI-DSI host and can register as a MIPI-DSI device.
> + *
> + * At this point, we're now certain that both the display driver and the
> + * bridge driver are functional and we can't have a deadlock-like
> + * situation when probing.
> + */
> +
>  static DEFINE_MUTEX(bridge_lock);
>  static LIST_HEAD(bridge_list);
>  
> -- 
> 2.31.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
