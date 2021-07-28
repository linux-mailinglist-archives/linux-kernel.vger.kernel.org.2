Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD033D8FAD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 15:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237514AbhG1NxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 09:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237461AbhG1NuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 09:50:23 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95ADBC0613C1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 06:50:20 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id c16so2612832wrp.13
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 06:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5nk08liL6xM6tni0O/Qofi3TB0RrJ0qVNosrXfZf3ss=;
        b=C0v7KGOuH87mfnZJk161YE7J5kEQOLAMMiYiHbysRjukrdx8GJPlXMsqs5VKIQDodr
         BWOgR1Jd8JRz5Z2KseBBAEsmweajGRa8Qyg/C/Ut1j60eKeIKqpyRGYOcEd6xqjTLlIg
         /U61FrJdOlYQwGCmx7APaLCO/3q09imZP780rmK9pnLWrbBjCKZGjTXP9AAaR95XIwd9
         OMS0uBPJ69QsLySxFmV0VH3+7Zl/90tLMlzzsp0m8dWgdSolWw8u8v6r+2oNkKbwxOd3
         DrAOMYq/zs0qCqFtUtapO31Ou9fv9e2ZVJD3G2+IXj1iCh83BT8cR9E9XHw5SrKEZ5hi
         SeeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5nk08liL6xM6tni0O/Qofi3TB0RrJ0qVNosrXfZf3ss=;
        b=Trg2LYwHx+PfMFa+xmtYU3TWT8BNdS25ic016Ik0lP7UElNXAU6QX4q3irzsIG1wRr
         Rbm/TrbiEssQWNG/Pk+4VLst1N80GdBvnO9W580UCPjtYsOqVxZ3jYehcbVlRgyak1ux
         wio5mzqsg0mDC5pghPi7MxRZQU+cJpWJ6pQZVZiEtLBJE691OYtaCEOAIwvHGsu2sg5g
         6OLbUZGwPH1xAaQSVnosV1haJE1ayIcHLHcQ8ZGO3a8UrqFxRZR0AeRVXJVE3dXbceWx
         VtbBqJZIYSJRR1tgBZ077Xi3NPbPDMCPc164PFQV30RYjNY2Pb/jtn7sjy0x0a1ePQ+d
         7+7w==
X-Gm-Message-State: AOAM531VhSdtYrhQ4JI1ppteuwGFeoLZEmqq7D3NxFPi75dT0vUg3dNX
        sVGRUdbb5kpFXSxvih+gz04/Rm1oORTaDmA2XG7t/g==
X-Google-Smtp-Source: ABdhPJwYyHo1QSgbYr3nl6s5W0aeC2KmP6i6dQh8jmpQZP7FT3ag4Oa5GI9sKpCyn/PY4o2Kers2CEbQd0SIhxISmM4=
X-Received: by 2002:adf:c3c4:: with SMTP id d4mr20277232wrg.27.1627480219074;
 Wed, 28 Jul 2021 06:50:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210707092257.1465109-1-maxime@cerno.tech> <20210707092257.1465109-2-maxime@cerno.tech>
In-Reply-To: <20210707092257.1465109-2-maxime@cerno.tech>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Wed, 28 Jul 2021 14:50:03 +0100
Message-ID: <CAPY8ntDdjtB5Hs=XiwWg5Nng5UOrrHxV_A5vALhvLtfv=uphaQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] drm/vc4: hdmi: Make sure the controller is powered
 up during bind
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <mripard@kernel.org>,
        Emma Anholt <emma@anholt.net>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Phil Elwell <phil@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Dom Cobley <dom@raspberrypi.com>,
        linux-rpi-kernel@lists.infradead.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        LKML <linux-kernel@vger.kernel.org>,
        bcm-kernel-feedback-list@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime

On Wed, 7 Jul 2021 at 10:23, Maxime Ripard <maxime@cerno.tech> wrote:
>
> In the bind hook, we actually need the device to have the HSM clock
> running during the final part of the display initialisation where we
> reset the controller and initialise the CEC component.
>
> Failing to do so will result in a complete, silent, hang of the CPU.
>
> Fixes: 411efa18e4b0 ("drm/vc4: hdmi: Move the HSM clock enable to runtime_pm")
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---
>  drivers/gpu/drm/vc4/vc4_hdmi.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
> index aab1b36ceb3c..dac47b100b8b 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> @@ -2176,6 +2176,18 @@ static int vc4_hdmi_bind(struct device *dev, struct device *master, void *data)
>                         vc4_hdmi->disable_4kp60 = true;
>         }
>
> +       /*
> +        * We need to have the device powered up at this point to call
> +        * our reset hook and for the CEC init.
> +        */
> +       ret = vc4_hdmi_runtime_resume(dev);

vc4_hdmi_runtime_resume is within a #ifdef CONFIG_PM block, so
potentially isn't defined.
Admittedly we "select PM" in Kconfig so it should always be enabled,
so perhaps it's better to just remove the #ifdef CONFIG_PM around the
resume and suspend functions.

That's possibly a separate issue to the issue that this patch is
addressing, but may explain the test bot's failure. Otherwise
Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> +       if (ret)
> +               goto err_put_ddc;
> +
> +       pm_runtime_get_noresume(dev);
> +       pm_runtime_set_active(dev);
> +       pm_runtime_enable(dev);
> +
>         if (vc4_hdmi->variant->reset)
>                 vc4_hdmi->variant->reset(vc4_hdmi);
>
> @@ -2187,8 +2199,6 @@ static int vc4_hdmi_bind(struct device *dev, struct device *master, void *data)
>                 clk_prepare_enable(vc4_hdmi->pixel_bvb_clock);
>         }
>
> -       pm_runtime_enable(dev);
> -
>         drm_simple_encoder_init(drm, encoder, DRM_MODE_ENCODER_TMDS);
>         drm_encoder_helper_add(encoder, &vc4_hdmi_encoder_helper_funcs);
>
> @@ -2208,6 +2218,8 @@ static int vc4_hdmi_bind(struct device *dev, struct device *master, void *data)
>                              vc4_hdmi_debugfs_regs,
>                              vc4_hdmi);
>
> +       pm_runtime_put_sync(dev);
> +
>         return 0;
>
>  err_free_cec:
> @@ -2216,6 +2228,7 @@ static int vc4_hdmi_bind(struct device *dev, struct device *master, void *data)
>         vc4_hdmi_connector_destroy(&vc4_hdmi->connector);
>  err_destroy_encoder:
>         drm_encoder_cleanup(encoder);
> +       pm_runtime_put_sync(dev);
>         pm_runtime_disable(dev);
>  err_put_ddc:
>         put_device(&vc4_hdmi->ddc->dev);
> --
> 2.31.1
>
