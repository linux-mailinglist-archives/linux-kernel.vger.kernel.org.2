Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BBD33A96F4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 12:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbhFPKLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 06:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231638AbhFPKLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 06:11:52 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C4EC061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 03:09:46 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id m41-20020a05600c3b29b02901b9e5d74f02so1356867wms.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 03:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pnPqh9N14clerujBTsaFymDQrrCAmrrrodGlT/qhT1A=;
        b=a6YsDy3EfJHT4noQ6OCK4HVcjoNdt2+UP3CahKSdO5dpXPL+vt/vN1fsaCjvLR9P91
         ekSB9nDNntyTOwfQ3HGXPpq9DNagIfuMpw/K3MkmSuC12x5F35V1HRW4JBllabvfCm96
         t9eIj0orBMh62HB7s+esbOTrUq16QTXN1rNVzQU/XHvWPSEEdD7ERSDq9tlO49L9G9gF
         LUoxtAhlNQUpxyVh3Sk9vpJkMyqQT5hQsomUHEto2Ob+fdrRj+1pbr+NlS2qzsdVg5De
         2Wk7Q69jUqy/q/9fffbw0dAlSf1Nzx7M7JRZfckwgn97iRNxyj45ADvBzxR3NuFKxU5X
         ftBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pnPqh9N14clerujBTsaFymDQrrCAmrrrodGlT/qhT1A=;
        b=j2esIrTQaQEtYRnlCKudhwijmmk5xEEdT2/CwRIEj+d8s1e0O+U6kwhGa4KzorWi1s
         fvxCVUQaUBB0pIUORYjqts9WuyXb5P5WBUY3uv8Q/1GiqBr8EuGgB9ymUuQVtSagm0DC
         2p4+FgORpI6Gke4V4h4UVeVply5w7mt0KzDF4l17HUDwFVyMINJzSzbPRbk6q531YB7u
         y8ivvLdij4m+7PaAFvZ5ZN+N8/djZMqHNXr65fo9aDQ4m24GT7K/h/qbUCU335uIV2rC
         5F3AoushZv/sRge4VFUn0LcIosIaGDWWtch9TW4cxnKpWXLVe5QAj7b/L3QmjW0UDjva
         nZIw==
X-Gm-Message-State: AOAM533lyQLHode70TQ95K8J0vCU+JeMgyD0U1eI22Fb0rwOSHj/PVQo
        Qg0Rj4sKOvg7UNOtox41gnMdWK/s/P2Tha57WgtaKQ==
X-Google-Smtp-Source: ABdhPJzwSTHY0WLaZOasvU71NaaNjSXnp2erfTSfaBvuAB7Qv3uUl4+8ERP3WHenb8IgpJPpoGZdxkMA6BVJjNDXjIk=
X-Received: by 2002:a7b:c013:: with SMTP id c19mr10270068wmb.158.1623838185332;
 Wed, 16 Jun 2021 03:09:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210524132018.264396-1-maxime@cerno.tech>
In-Reply-To: <20210524132018.264396-1-maxime@cerno.tech>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Wed, 16 Jun 2021 11:09:29 +0100
Message-ID: <CAPY8ntAqh2wEhN2wO_RQ2jJ7X3ovwB_5UwbrbPypDOhd1KVN6A@mail.gmail.com>
Subject: Re: [PATCH] drm/vc4: hdmi: Rely on interrupts to handle hotplug
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Eric Anholt <eric@anholt.net>,
        Phil Elwell <phil@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Dom Cobley <dom@raspberrypi.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Ripard <mripard@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 May 2021 at 14:20, Maxime Ripard <maxime@cerno.tech> wrote:
>
> DRM currently polls for the HDMI connector status every 10s, which can
> be an issue when we connect/disconnect a display quickly or the device
> on the other end only issues a hotplug pulse (for example on EDID
> change).
>
> Switch the driver to rely on the internal controller logic for the
> BCM2711/RPi4.

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---
>  drivers/gpu/drm/vc4/vc4_hdmi.c | 44 ++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
> index c27b287d2053..3988969f7410 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> @@ -1510,6 +1510,46 @@ static int vc4_hdmi_audio_init(struct vc4_hdmi *vc4_hdmi)
>
>  }
>
> +static irqreturn_t vc4_hdmi_hpd_irq_thread(int irq, void *priv)
> +{
> +       struct vc4_hdmi *vc4_hdmi = priv;
> +       struct drm_device *dev = vc4_hdmi->connector.dev;
> +
> +       if (dev)
> +               drm_kms_helper_hotplug_event(dev);
> +
> +       return IRQ_HANDLED;
> +}
> +
> +static int vc4_hdmi_hotplug_init(struct vc4_hdmi *vc4_hdmi)
> +{
> +       struct platform_device *pdev = vc4_hdmi->pdev;
> +       struct device *dev = &pdev->dev;
> +       int ret;
> +
> +       if (vc4_hdmi->variant->external_irq_controller) {
> +               ret = devm_request_threaded_irq(dev,
> +                                               platform_get_irq_byname(pdev, "hpd-connected"),
> +                                               NULL,
> +                                               vc4_hdmi_hpd_irq_thread, IRQF_ONESHOT,
> +                                               "vc4 hdmi hpd connected", vc4_hdmi);
> +               if (ret)
> +                       return ret;
> +
> +               ret = devm_request_threaded_irq(dev,
> +                                               platform_get_irq_byname(pdev, "hpd-removed"),
> +                                               NULL,
> +                                               vc4_hdmi_hpd_irq_thread, IRQF_ONESHOT,
> +                                               "vc4 hdmi hpd disconnected", vc4_hdmi);
> +               if (ret)
> +                       return ret;
> +
> +               connector->polled = DRM_CONNECTOR_POLL_HPD;
> +       }
> +
> +       return 0;
> +}
> +
>  #ifdef CONFIG_DRM_VC4_HDMI_CEC
>  static irqreturn_t vc4_cec_irq_handler_rx_thread(int irq, void *priv)
>  {
> @@ -2060,6 +2100,10 @@ static int vc4_hdmi_bind(struct device *dev, struct device *master, void *data)
>         if (ret)
>                 goto err_destroy_encoder;
>
> +       ret = vc4_hdmi_hotplug_init(vc4_hdmi);
> +       if (ret)
> +               goto err_destroy_conn;
> +
>         ret = vc4_hdmi_cec_init(vc4_hdmi);
>         if (ret)
>                 goto err_destroy_conn;
> --
> 2.31.1
>
