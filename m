Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 514BB3A9825
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 12:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbhFPKxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 06:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232306AbhFPKxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 06:53:50 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14B6C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 03:51:43 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id f2so2123571wri.11
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 03:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ror3HEGQij43KsNy/OhimJcbX50+3r96xDmjcLIvB/I=;
        b=tycBPRkwiJJgdgl38Lv7Pbzi1GyJQkD+N4Nlm9LiOW0HqR7WpdS9UVbSMDlJoCBvOX
         DWGtV/5m70Ud6B6RlIJycRtUVvGPR1y/j85WZKDAdXe6+wEzOnY+kgmjDcqi5qs21zds
         kzgM0ZOhi/BNIo10Dj0CRX3OwY513+4wNxfTkQTlguc4mdSzLeqLexhS46IkjZBY9Q/e
         gZpFFAnCE4+FIeiGEeV/Jr2p2/ZUSfviZrKUyQc+Jz0BoaaV12bb86AitfI4Uz+grn6r
         7VJbWX8Iu+bgwSE6d+lPYM+mbcSYFHXGLaw6ZnCcvNAzQHwIlEMpFfczfFvQAxwU8h1b
         r/LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ror3HEGQij43KsNy/OhimJcbX50+3r96xDmjcLIvB/I=;
        b=YtH+OX3AsV7Xla00pM+LrWsVyOw8HVPT2nfsBv7+PBnGi996i/uMnC1St1rvPrUc7m
         9uDfC5XdEeC39cK32BJd7DHDxRdbVsKGzQ+YkzRWF0f0OraJfoFIUNvrB4YAbYGAqJi5
         rfZccpLU0cqSoxTmqBheZ4Vxg/b4D14FmozkEhs8iN+6bZPTcpEEI7/FoRO/DedV9/fN
         pfT+5+lvAkd7dHTii2fFFkD3pAGFLKX0UNbbyJFedb8JOSKr0iy2VNIDhq1q+f6HCes5
         wDrz1vDNc12vGyLNjpaim8FcEQy+fkuBsEsOCqcsAuN0XFuw34s1ZqNJ1FGu/UYG527y
         QT0g==
X-Gm-Message-State: AOAM53153vZTqIjaHjvzFYi3NJA5ljQeVIdPXeqYkkVv8NPIyu8+/CtG
        v611CuMaK62dR6r/i5toc2iaYsscMCRoZMEeCme25g==
X-Google-Smtp-Source: ABdhPJz8mBKR0UC3894Y0jb6bNx9tenCDSO/hzmMNNVW02Aft0Lpe5TMqmF0GWIVfpIPRtcI4B7LzDKl2/sO47r66b8=
X-Received: by 2002:a5d:47ce:: with SMTP id o14mr4501345wrc.273.1623840702553;
 Wed, 16 Jun 2021 03:51:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210525091059.234116-1-maxime@cerno.tech> <20210525091059.234116-4-maxime@cerno.tech>
In-Reply-To: <20210525091059.234116-4-maxime@cerno.tech>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Wed, 16 Jun 2021 11:51:26 +0100
Message-ID: <CAPY8ntDfoKLwWG6pkPNvq78C3e5WzXNCVtCykJrrHhZ0UcrjTg@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/vc4: hdmi: Make sure the controller is powered in detect
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        Boris Brezillon <bbrezillon@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Anholt <eric@anholt.net>, Emma Anholt <emma@anholt.net>,
        Phil Elwell <phil@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Dom Cobley <dom@raspberrypi.com>,
        Maxime Ripard <mripard@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 May 2021 at 10:11, Maxime Ripard <maxime@cerno.tech> wrote:
>
> If the HPD GPIO is not available and drm_probe_ddc fails, we end up
> reading the HDMI_HOTPLUG register, but the controller might be powered
> off resulting in a CPU hang. Make sure we have the power domain and the
> HSM clock powered during the detect cycle to prevent the hang from
> happening.
>
> Fixes: 4f6e3d66ac52 ("drm/vc4: Add runtime PM support to the HDMI encoder driver")
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> ---
>  drivers/gpu/drm/vc4/vc4_hdmi.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
> index 867009a471e1..4b6857467e58 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> @@ -166,6 +166,8 @@ vc4_hdmi_connector_detect(struct drm_connector *connector, bool force)
>         struct vc4_hdmi *vc4_hdmi = connector_to_vc4_hdmi(connector);
>         bool connected = false;
>
> +       WARN_ON(pm_runtime_resume_and_get(&vc4_hdmi->pdev->dev));
> +
>         if (vc4_hdmi->hpd_gpio) {
>                 if (gpio_get_value_cansleep(vc4_hdmi->hpd_gpio) ^
>                     vc4_hdmi->hpd_active_low)
> @@ -187,10 +189,12 @@ vc4_hdmi_connector_detect(struct drm_connector *connector, bool force)
>                         }
>                 }
>
> +               pm_runtime_put(&vc4_hdmi->pdev->dev);
>                 return connector_status_connected;
>         }
>
>         cec_phys_addr_invalidate(vc4_hdmi->cec_adap);
> +       pm_runtime_put(&vc4_hdmi->pdev->dev);
>         return connector_status_disconnected;
>  }
>
> --
> 2.31.1
>
