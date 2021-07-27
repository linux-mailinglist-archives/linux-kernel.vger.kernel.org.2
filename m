Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C276C3D722F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 11:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236087AbhG0JmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 05:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236046AbhG0JmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 05:42:22 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0D7C061757
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 02:42:21 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id y12so6463424edo.6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 02:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8fwQRqMvjgAY6jqV3zlS3GTvqGBBIFqRUeOfjbqNkn4=;
        b=Vgfr+F5s6Bc5u+uBdMFEhmPySf4LlqpmA8B3AA57fdSa5RwUSGJbIA6tW/1gVcaXOU
         Vo7X6tgClf+huAZ2z6IUZubQy5E7JzTpiWc2YEhbw46JuKlohm1vKn3zNdJG5ZAW8UAd
         UsIMO676lnPLuTnVA+C6Na7p2LQ0GHrw5luy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8fwQRqMvjgAY6jqV3zlS3GTvqGBBIFqRUeOfjbqNkn4=;
        b=iEb3bJ3kpEud+7oMr3uC0QEs+5yOdxa7WZwic/DX4NBCeDihvVKxy/gz+XckcMqlyO
         q0NrH0X6Tpc6dBUMvLhA+GTnSlPokIQbW26Aon7eiLxML4r9YAfMw0sb9fSqPkNVqO6V
         7AZrD0aPxGpjQsb0FqrY5tmdeIkh2TmhJvOnn0ynY0r8WhiD8cLZ6xsybtLpRNOn9sNe
         x2C+EouK0ctOQjh+ZuEmm4isCbsP5CrZ8Tu70XDbuBJOUMbTYnDt/IA8AvZtt5SZWjl9
         y2pT7kbGtN9T/uI53XHdmhbk0G8EPGJ+Rk3BeAY3Ui+zURfQpcIN6oHVe6SzCf0asWtZ
         /Uwg==
X-Gm-Message-State: AOAM5323gWLTtdBMZ8bPtEfVNwm/LrUuqXNBH5EP4fHpWI47lHZY0KBw
        PIoOKPPiX6dUQQRjdFz32loeD8u2gHo8jd+KcOdygA==
X-Google-Smtp-Source: ABdhPJyeCw9Vo5e9UrsFOswe3Y1tnwFbw3IAOf1WcRCfMxjGuFl09sckUW6CTR3uJUSW6D+U6LZrWYW/ZJWeDClExRU=
X-Received: by 2002:a05:6402:430b:: with SMTP id m11mr7510996edc.55.1627378940202;
 Tue, 27 Jul 2021 02:42:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210720134525.563936-1-maxime@cerno.tech> <20210720134525.563936-5-maxime@cerno.tech>
In-Reply-To: <20210720134525.563936-5-maxime@cerno.tech>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Tue, 27 Jul 2021 15:12:09 +0530
Message-ID: <CAMty3ZD5rpYHtW-Rs4i=XvBmiVEaeWNu1j=QE3mFJTjSPJTpxQ@mail.gmail.com>
Subject: Re: [PATCH 04/10] drm/bridge: Document the probe issue with MIPI-DSI bridges
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
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 20, 2021 at 7:15 PM Maxime Ripard <maxime@cerno.tech> wrote:
>
> Interactions between bridges, panels, MIPI-DSI host and the component
> framework are not trivial and can lead to probing issues when
> implementing a display driver. Let's document the various cases we need
> too consider, and the solution to support all the cases.
>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
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

There is an another problem occur for this scenario in the case of kms
hotplug driver, sun6i_mipi_dsi.c. When host attach wait till drm
device pointer found and drm device pointer would found only when bind
done, and bind would complete only when &drm_bridge_funcs.attach hooks
are complete. But, If DSI driver is fully bridge driven then this
attach in bind will trigger panel_bridge hook attach and at this point
we cannot get panel_bridge at all which indeed second attach would
would failed.

This is one of the reason I'm trying to use drm_bridge_attach host
attach itself instead of component bind, not yet succeeded.

Thanks,
Jagan.
