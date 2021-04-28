Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEE7B36DCCB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 18:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240572AbhD1QRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 12:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239774AbhD1QRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 12:17:20 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B392BC061574
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 09:16:35 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id q192so20954462ybg.4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 09:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6XXKhWivBSiK0NUKDt4xItDduSTkSI/DwmkHBVIryfE=;
        b=YD7+rQwZcFk9G5WfMpF2SXvysZJiFPSNUB3ux7Ts9/pxBovPkuuYtjCpojtGEwY0zf
         /kkrBf94JI9OFohX2Vu1j7vth1Ang5WI3vJKsFfby8hG6HRoj5fDAVQR+wG+J0HTU1Fx
         6WETSMYtWrCaC+3T2iIL10+a43BNMyUKmazERfc21vzI+zSj88vK4HbAoW6MDAeCH8Y2
         aAfDMyns5pgBnV6tOx1hfniDKHe3HXlJmCgSY8rZFuAf5FrYbga6vhoUITc+aDFeM5nH
         ay+BaVxn0K/jK+e+rN45JiDT90J8yhCdXE8dQms+0o295Gr+GCfVdzDZWnytjy1ArE3M
         rmNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6XXKhWivBSiK0NUKDt4xItDduSTkSI/DwmkHBVIryfE=;
        b=L61LNWlBGRic5Y36R1rK0bSl1O65KFJjoWSyMkzIfl2TNtsNEi8uYPKYCwik8I2ILQ
         WkSTr7RDX/ypTj22elC3OsHs1OEpIcsV+5+EreGy0iSSK3qvdRc7lusmhDDVr4MVOBON
         QRS3GmTeFZQnjqgnC4R+/JRIkvZMQExLrbwb2B8Y+n2ZRSWR2UBaRBtdrXW+mnHL5QAn
         V0b0OHKU4lrc+zJyhUC9OtySPfmvkUlEJHK5lU/iNWfmQtjluxScWt7Th2KsKdwmxWA6
         cVby+0WRj349ui/uUwzwUxtvOtoPxc787aMM07aAPb23QCgMcukgihTRYM4TxjYTCETM
         4k5Q==
X-Gm-Message-State: AOAM531q/j6D/PiHgnNvaJhb8VpiN930r6x4ENBlwbDjZowKi9KPtqtq
        vios7KuCQneo7adwR2KDKGCY8Q6SLhjARY3zfBmxQQ==
X-Google-Smtp-Source: ABdhPJyk+0pdGni0YhDJHRrFSzkV+84hkmtaaAKvqYezlshGZOUwoDR3b5BQB/gwJO2y45E+fpNGPMjUpRVSeso7ysM=
X-Received: by 2002:a25:be09:: with SMTP id h9mr42591798ybk.239.1619626595052;
 Wed, 28 Apr 2021 09:16:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210428045533.564724-1-hsinyi@chromium.org>
In-Reply-To: <20210428045533.564724-1-hsinyi@chromium.org>
From:   Sean Paul <sean@poorly.run>
Date:   Wed, 28 Apr 2021 12:15:59 -0400
Message-ID: <CAMavQKKJp-d-ji6Ao8=1Mnx0pA0+YBregZ4aS0OS1sEqKCoE8w@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] gpu: drm: separate panel orientation property
 creating and value setting
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2021 at 12:55 AM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>


Thank you for revising the patchset, this looks much better to me!


/snip

>
> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
> index 7631f76e7f34..cda83314d7ad 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c

/snip

> @@ -2173,8 +2173,8 @@ EXPORT_SYMBOL(drm_connector_set_vrr_capable_property);
>   * @connector: connector for which to set the panel-orientation property.
>   * @panel_orientation: drm_panel_orientation value to set
>   *
> - * This function sets the connector's panel_orientation and attaches
> - * a "panel orientation" property to the connector.
> + * This function sets the connector's panel_orientation value. If the property
> + * doesn't exist, it will create one first.

I still don't think this function should overload initialization and
assignment. I'd prefer we just removed the creation from
set_panel_orientation entirely so this WARN can't be hit.


>   *
>   * Calling this function on a connector where the panel_orientation has
>   * already been set is a no-op (e.g. the orientation has been overridden with
> @@ -2206,18 +2206,16 @@ int drm_connector_set_panel_orientation(
>
>         prop = dev->mode_config.panel_orientation_property;
>         if (!prop) {
> -               prop = drm_property_create_enum(dev, DRM_MODE_PROP_IMMUTABLE,
> -                               "panel orientation",
> -                               drm_panel_orientation_enum_list,
> -                               ARRAY_SIZE(drm_panel_orientation_enum_list));
> -               if (!prop)
> -                       return -ENOMEM;
> +               int ret;
>
> -               dev->mode_config.panel_orientation_property = prop;
> +               ret = drm_connector_init_panel_orientation_property(connector);
> +               if (ret)
> +                       return ret;
> +               prop = dev->mode_config.panel_orientation_property;
>         }
>
> -       drm_object_attach_property(&connector->base, prop,
> -                                  info->panel_orientation);
> +       drm_object_property_set_value(&connector->base, prop,
> +                                     info->panel_orientation);
>         return 0;
>  }
>  EXPORT_SYMBOL(drm_connector_set_panel_orientation);
> @@ -2225,7 +2223,7 @@ EXPORT_SYMBOL(drm_connector_set_panel_orientation);
>  /**
>   * drm_connector_set_panel_orientation_with_quirk -
>   *     set the connector's panel_orientation after checking for quirks
> - * @connector: connector for which to init the panel-orientation property.
> + * @connector: connector for which to set the panel-orientation property.
>   * @panel_orientation: drm_panel_orientation value to set
>   * @width: width in pixels of the panel, used for panel quirk detection
>   * @height: height in pixels of the panel, used for panel quirk detection
> @@ -2252,6 +2250,40 @@ int drm_connector_set_panel_orientation_with_quirk(
>  }
>  EXPORT_SYMBOL(drm_connector_set_panel_orientation_with_quirk);
>
> +/**
> + * drm_connector_init_panel_orientation_property -
> + *     create the connector's panel orientation property
> + *
> + * This function attaches a "panel orientation" property to the connector
> + * and initializes its value to DRM_MODE_PANEL_ORIENTATION_UNKNOWN.
> + *
> + * The value of the property can be set by drm_connector_set_panel_orientation()
> + * or drm_connector_set_panel_orientation_with_quirk() later.
> + *
> + * Returns:
> + * Zero on success, negative errno on failure.
> + */
> +int drm_connector_init_panel_orientation_property(
> +       struct drm_connector *connector)
> +{
> +       struct drm_device *dev = connector->dev;
> +       struct drm_property *prop;
> +
> +       prop = drm_property_create_enum(dev, DRM_MODE_PROP_IMMUTABLE,
> +                       "panel orientation",
> +                       drm_panel_orientation_enum_list,
> +                       ARRAY_SIZE(drm_panel_orientation_enum_list));
> +       if (!prop)
> +               return -ENOMEM;
> +
> +       dev->mode_config.panel_orientation_property = prop;
> +       drm_object_attach_property(&connector->base, prop,
> +                                  DRM_MODE_PANEL_ORIENTATION_UNKNOWN);
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL(drm_connector_init_panel_orientation_property);
> +
>  int drm_connector_set_obj_prop(struct drm_mode_object *obj,
>                                     struct drm_property *property,
>                                     uint64_t value)
> diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> index 1922b278ffad..4396c1c4a5db 100644
> --- a/include/drm/drm_connector.h
> +++ b/include/drm/drm_connector.h
> @@ -1696,6 +1696,8 @@ int drm_connector_set_panel_orientation_with_quirk(
>         struct drm_connector *connector,
>         enum drm_panel_orientation panel_orientation,
>         int width, int height);
> +int drm_connector_init_panel_orientation_property(
> +       struct drm_connector *connector);
>  int drm_connector_attach_max_bpc_property(struct drm_connector *connector,
>                                           int min, int max);
>
> --
> 2.31.1.498.g6c1eba8ee3d-goog
>
