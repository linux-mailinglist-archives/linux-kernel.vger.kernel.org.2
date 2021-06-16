Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6D883A981B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 12:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232444AbhFPKvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 06:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbhFPKvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 06:51:37 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8588DC061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 03:49:30 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id l9so1002179wms.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 03:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bA8bsqrupYSnAqh0tIsts0fYr4yat05kU2FFTIr3l8Y=;
        b=l+CoA4GzVmHjEe18yALMSGdlxroaIRXA+mGWsTJEXzxmi4h/XJfwahB6BIE31NMC/W
         cLDRgn6zqexCXfxotxOmbuoWFBMJwF3IZDF/wUuUgHtZqv9hcE1PISLl6Ogz6YZdB5ck
         D9hxxAXPkIeSyjCP2Cbc4kYaPq0i3BdRAqec3ljhrShwX0cYp15bTe+W/P+HcsiaDU1l
         H6daBYehRM3CDZVrqUqLKPDnDkXAWR5AOAdiHNW2XrCX8kOkdJ7yV1cJEaGnmGt3md4W
         Hy8YoPlduo+kIhkOeNtlaaJBtlPuUAe2RKoLEJYQL4ZEFZPbodHSwRkEYfEpm0XcBZh9
         BOtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bA8bsqrupYSnAqh0tIsts0fYr4yat05kU2FFTIr3l8Y=;
        b=QJ3le8enciiNzpauTWLDWxRFY3aS6EhDOhhHtx4SkvIJf/I6XEh3ev5S6djB15LGgm
         buS9fRHCJ0j0I3DsDcG6OYdGzpNuGjGTZSa0iV6B2VleiVd0g/bXWO/FSxDOU/tXoIy+
         krvQWBRL1HbpsfeAaW7x2GzFXVJgY/+JMO7jf6GBl0KMaHz9X2hRiGHfWxnSPs5UDU71
         18r1Ix5wwmH/b8i7/1XAgh6GbCm18ShUHd9hRjKSiXNtUpooX2GHAx7vKu0dat05pBbS
         OpDVhuPlYNe1NbKSYahNv/avFPPQN28cfDoGbqlarhDINmbPSmRIdltp82cFP1Tam+jG
         UGxw==
X-Gm-Message-State: AOAM531hZ0KQ2haYEM0gZ9DdTwEmIdSXVSjulxp8P/H+PKyF2zgmFUGL
        4PAfGXzMhGeQKs0fFbMdetZCpq0b4iKr61uPp6Qdlw==
X-Google-Smtp-Source: ABdhPJwhDIwIaJw1Oyz3AVz+ittcROb6mcknz6385wLKjGs9jysEoL6/JYl5zGz4bhFOIaoDkQVbuoeipVvKZKJjTKc=
X-Received: by 2002:a1c:f70d:: with SMTP id v13mr4328043wmh.183.1623840569148;
 Wed, 16 Jun 2021 03:49:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210525091059.234116-1-maxime@cerno.tech> <20210525091059.234116-3-maxime@cerno.tech>
In-Reply-To: <20210525091059.234116-3-maxime@cerno.tech>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Wed, 16 Jun 2021 11:49:13 +0100
Message-ID: <CAPY8ntBzDNwdQsyYzdHkCuZOARwWBmM9B7SEdzrYUQBYymKVOg@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/vc4: hdmi: Move the HSM clock enable to runtime_pm
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

Hi Maxime

On Tue, 25 May 2021 at 10:11, Maxime Ripard <maxime@cerno.tech> wrote:
>
> In order to access the HDMI controller, we need to make sure the HSM
> clock is enabled. If we were to access it with the clock disabled, the
> CPU would completely hang, resulting in an hard crash.
>
> Since we have different code path that would require it, let's move that
> clock enable / disable to runtime_pm that will take care of the
> reference counting for us.

This does change the order of clk_set_rate vs clk_prepare_enable, so
the clock is already running during
vc4_hdmi_encoder_pre_crtc_configure when the pixel rate is known.
However the crtc and HDMI blocks won't be actively passing pixels at
that point, so I don't see an issue with changing the rate. The clock
manager block will sort out the rate change happily.

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> Fixes: 4f6e3d66ac52 ("drm/vc4: Add runtime PM support to the HDMI encoder driver")
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---
>  drivers/gpu/drm/vc4/vc4_hdmi.c | 41 +++++++++++++++++++++++++---------
>  1 file changed, 31 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
> index f9de8632a28b..867009a471e1 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> @@ -632,7 +632,6 @@ static void vc4_hdmi_encoder_post_crtc_powerdown(struct drm_encoder *encoder,
>                    HDMI_READ(HDMI_VID_CTL) & ~VC4_HD_VID_CTL_ENABLE);
>
>         clk_disable_unprepare(vc4_hdmi->pixel_bvb_clock);
> -       clk_disable_unprepare(vc4_hdmi->hsm_clock);
>         clk_disable_unprepare(vc4_hdmi->pixel_clock);
>
>         ret = pm_runtime_put(&vc4_hdmi->pdev->dev);
> @@ -943,13 +942,6 @@ static void vc4_hdmi_encoder_pre_crtc_configure(struct drm_encoder *encoder,
>                 return;
>         }
>
> -       ret = clk_prepare_enable(vc4_hdmi->hsm_clock);
> -       if (ret) {
> -               DRM_ERROR("Failed to turn on HSM clock: %d\n", ret);
> -               clk_disable_unprepare(vc4_hdmi->pixel_clock);
> -               return;
> -       }
> -
>         vc4_hdmi_cec_update_clk_div(vc4_hdmi);
>
>         if (pixel_rate > 297000000)
> @@ -962,7 +954,6 @@ static void vc4_hdmi_encoder_pre_crtc_configure(struct drm_encoder *encoder,
>         ret = clk_set_min_rate(vc4_hdmi->pixel_bvb_clock, bvb_rate);
>         if (ret) {
>                 DRM_ERROR("Failed to set pixel bvb clock rate: %d\n", ret);
> -               clk_disable_unprepare(vc4_hdmi->hsm_clock);
>                 clk_disable_unprepare(vc4_hdmi->pixel_clock);
>                 return;
>         }
> @@ -970,7 +961,6 @@ static void vc4_hdmi_encoder_pre_crtc_configure(struct drm_encoder *encoder,
>         ret = clk_prepare_enable(vc4_hdmi->pixel_bvb_clock);
>         if (ret) {
>                 DRM_ERROR("Failed to turn on pixel bvb clock: %d\n", ret);
> -               clk_disable_unprepare(vc4_hdmi->hsm_clock);
>                 clk_disable_unprepare(vc4_hdmi->pixel_clock);
>                 return;
>         }
> @@ -2097,6 +2087,29 @@ static int vc5_hdmi_init_resources(struct vc4_hdmi *vc4_hdmi)
>         return 0;
>  }
>
> +#ifdef CONFIG_PM
> +static int vc4_hdmi_runtime_suspend(struct device *dev)
> +{
> +       struct vc4_hdmi *vc4_hdmi = dev_get_drvdata(dev);
> +
> +       clk_disable_unprepare(vc4_hdmi->hsm_clock);
> +
> +       return 0;
> +}
> +
> +static int vc4_hdmi_runtime_resume(struct device *dev)
> +{
> +       struct vc4_hdmi *vc4_hdmi = dev_get_drvdata(dev);
> +       int ret;
> +
> +       ret = clk_prepare_enable(vc4_hdmi->hsm_clock);
> +       if (ret)
> +               return ret;
> +
> +       return 0;
> +}
> +#endif
> +
>  static int vc4_hdmi_bind(struct device *dev, struct device *master, void *data)
>  {
>         const struct vc4_hdmi_variant *variant = of_device_get_match_data(dev);
> @@ -2353,11 +2366,19 @@ static const struct of_device_id vc4_hdmi_dt_match[] = {
>         {}
>  };
>
> +
> +static const struct dev_pm_ops vc4_hdmi_pm_ops = {
> +       SET_RUNTIME_PM_OPS(vc4_hdmi_runtime_suspend,
> +                          vc4_hdmi_runtime_resume,
> +                          NULL)
> +};
> +
>  struct platform_driver vc4_hdmi_driver = {
>         .probe = vc4_hdmi_dev_probe,
>         .remove = vc4_hdmi_dev_remove,
>         .driver = {
>                 .name = "vc4_hdmi",
>                 .of_match_table = vc4_hdmi_dt_match,
> +               .pm = &vc4_hdmi_pm_ops,
>         },
>  };
> --
> 2.31.1
>
