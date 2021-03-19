Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E433F341FF2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 15:45:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbhCSOpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 10:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbhCSOop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 10:44:45 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2829FC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 07:44:45 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id r17so3828161pgi.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 07:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iGtWWRPtYaesVII9xVuarQ74BpkCKYVsirQYS4eH+kw=;
        b=VQopFqQ7Oi/j1u/8XxsX/Ys7cEFxGEox7f1bx6NoTv7BEvoz2YuGPDmss5cNrpjOzy
         VAEKj4MFXAwl6WPpkX+M+hI1Hu7VonNAkypLrCqWQSz2YlE6bFVZrX+y7MYzhM61hIBF
         hMAVmp/+eBnAWvLEUGT385c0lLIE3zNjKg3yEbrxcspNhbT85xP1rQObj/i7c8C1DsTJ
         RuyzGHHLesk4ojCDSC8eApoQe9iKz0uFKGjxbFcDZGqjP1i/Qc/4i9fpNqpKjlA8WYdG
         V7Lj9zoGrF4wQEB5h/JkCwP+fOh8CXDTsErgXHi2Lk46AUjB3sux/6XHCsHuo2j0YsyK
         KJbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iGtWWRPtYaesVII9xVuarQ74BpkCKYVsirQYS4eH+kw=;
        b=Vta2rQQ9nC9tZv/IHDFWKz+OBgbyZEhYvgrSTxHrEeANugoCaFrRENjfWuDDADUZwq
         iZU9h8DzyHbs1KZJa2cidq/FyEehGPMMTwuMjTzdBi/Faf0saz10OSGgcgFlkVaTZCU2
         xDvhj5+BbQ75ChZPkk7JF1vSCOSCyIQ4+FXw19GpZdPj4JesCaDhlVXEKXoLTm2sPiuC
         FfV7PETkTyiSkU/troqBRUmR7PtXcq5viE+tWSK5Ea0kjYgp+4XGfW7hRLuPUiEwIxty
         yVsKHJRgeICOlXsrYNdjtK+9ytU4mh5sWT0+oxhENR0vwKRUvGoicEjH1FCCrmm2oq9z
         J3ug==
X-Gm-Message-State: AOAM532jdGEX4yiS751bEaUZP++IHGDRmcUmDUimcavQIwuhDsTP9qcN
        B4qpQOQjDzpSOSYob4mFRtB2vXhgXgyxVju52YinZQ==
X-Google-Smtp-Source: ABdhPJzrBJishtLlW1vLHQuX3g9moCjtqg8gvKyfKMXQAVynNrWk794TQB88/EgV8doHLowCXDYIwqS+scDaYBD2Ma4=
X-Received: by 2002:a63:ee4b:: with SMTP id n11mr11862551pgk.265.1616165084661;
 Fri, 19 Mar 2021 07:44:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210219215326.2227596-1-lyude@redhat.com> <20210219215326.2227596-13-lyude@redhat.com>
In-Reply-To: <20210219215326.2227596-13-lyude@redhat.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Fri, 19 Mar 2021 15:44:33 +0100
Message-ID: <CAG3jFysehSDHFFXAAc5VexAjyVhCq6hUyD8yWFsE6V3hv_9iPA@mail.gmail.com>
Subject: Re: [PATCH 12/30] drm/bridge/analogix/anx6345: Cleanup on errors in anx6345_bridge_attach()
To:     Lyude Paul <lyude@redhat.com>
Cc:     intel-gfx@lists.freedesktop.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>, Torsten Duwe <duwe@lst.de>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Joe Perches <joe@perches.com>, Icenowy Zheng <icenowy@aosc.io>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Lyude,

Thanks for the patch, it looks good to me.

Reviewed-by: Robert Foss <robert.foss@linaro.org>

On Fri, 19 Feb 2021 at 22:58, Lyude Paul <lyude@redhat.com> wrote:
>
> Another drive-by fix I found when fixing DP AUX adapter across the kernel
> tree - make sure we don't leak resources (and by proxy-AUX adapters) on
> failures in anx6345_bridge_attach() by unrolling on errors.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  drivers/gpu/drm/bridge/analogix/analogix-anx6345.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c b/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
> index 6258f16da0e8..aa6cda458eb9 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
> @@ -550,7 +550,7 @@ static int anx6345_bridge_attach(struct drm_bridge *bridge,
>                                  DRM_MODE_CONNECTOR_eDP);
>         if (err) {
>                 DRM_ERROR("Failed to initialize connector: %d\n", err);
> -               return err;
> +               goto aux_unregister;
>         }
>
>         drm_connector_helper_add(&anx6345->connector,
> @@ -562,16 +562,21 @@ static int anx6345_bridge_attach(struct drm_bridge *bridge,
>                                            bridge->encoder);
>         if (err) {
>                 DRM_ERROR("Failed to link up connector to encoder: %d\n", err);
> -               return err;
> +               goto connector_cleanup;
>         }
>
>         err = drm_connector_register(&anx6345->connector);
>         if (err) {
>                 DRM_ERROR("Failed to register connector: %d\n", err);
> -               return err;
> +               goto connector_cleanup;
>         }
>
>         return 0;
> +connector_cleanup:
> +       drm_connector_cleanup(&anx6345->connector);
> +aux_unregister:
> +       drm_dp_aux_unregister(&anx6345->aux);
> +       return err;
>  }
>
>  static void anx6345_bridge_detach(struct drm_bridge *bridge)
> --
> 2.29.2
>
