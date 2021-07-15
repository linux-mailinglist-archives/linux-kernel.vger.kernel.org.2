Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9603C9C3A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 11:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240622AbhGOJ62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 05:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbhGOJ6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 05:58:25 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB3CC06175F;
        Thu, 15 Jul 2021 02:55:31 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 59-20020a9d0ac10000b0290462f0ab0800so5535422otq.11;
        Thu, 15 Jul 2021 02:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yWF3Hvbgh08HpLzNYqi8W7Brg9KKqZnQKe3nWZ0LC5s=;
        b=HPhiKoMkJZXa9bsTbSdkwz7TUv6P9ceRvRKuYcrse7TVngZPeqfeHPdYi8OsBVQiAW
         NkCwWWYCyhftC1Ny141mwLwk6XdOq7zXLnqqApCPqCj70nhfhpQtRigKSt9Prj11FP1H
         qA8rf4LA/lrsjiY+qQtI7b1l1EZVvjUIl++m1mvAsRMEmn6+qohwZlXmVMlxqwtEVxaQ
         taPFtClWlgYRNoXrPN3xbC5lxbIonzk7JQ3F+umayQnE/q9ER+Fu0yH5FMpU3PL8gZez
         mT9kiAhWe7J5FNDB84dUpiPBhs/f1BK7eDGx3I4kDE/Tt/J3UUcgKYjvvC3VykpbbS+R
         LN3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yWF3Hvbgh08HpLzNYqi8W7Brg9KKqZnQKe3nWZ0LC5s=;
        b=LfXBobU0QbvUMgFgBZJokrOYm6az/cjy5duHL0ygIXWtJtW5RBuYykFqyUtFLfjE4/
         E8XkSyzDxfh/8efssaKH6s1isc3I8rPkT9XiizIuw/k9E6w1qTC8S2n3/IMaU1tCQvft
         A+3hvcUQ0gsK9IgtXKqKRsrmF7fgN43t02mK2DpFPkm87GEMPR5Z40/X2lqM3IFERv9a
         wCTaztQtNspN9niLKeWWXiKWrZFyT8BND5Po7j+oFIiuXIy8uaL8R5FJeD9GjGB0KhId
         9tK+payDay4ZDpUtrkA/SUsYa38p5vO38kFLEIzI36gGyk9kZEfTagHMRIDiZylkSzFT
         67Vw==
X-Gm-Message-State: AOAM533rXcirvIrRIr+B+PLSv7NYTHK7QWc4h0yYBjS1jY7zIylgsC87
        EFkHx9GayXO2uVU0uZmSJtE6KFdIDiUg6iZkyYU=
X-Google-Smtp-Source: ABdhPJyIgNb7oBpKMThx7HzTU8Ne7Cr5wa3uzuGtL50ndLqf4fL2il7J/7s2sHuu+CohNSPurKfAa/Bq86/XWGpeG/k=
X-Received: by 2002:a05:6830:19cd:: with SMTP id p13mr2053060otp.362.1626342930535;
 Thu, 15 Jul 2021 02:55:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210624105517.3886963-1-hsinyi@chromium.org>
In-Reply-To: <20210624105517.3886963-1-hsinyi@chromium.org>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Thu, 15 Jul 2021 11:55:19 +0200
Message-ID: <CAFqH_51_QxzhDuHT823StDQ4esYtnFXwz1OLTFrxXA7MpX06+Q@mail.gmail.com>
Subject: Re: [PATCH v6 RESEND 1/3] gpu: drm: separate panel orientation
 property creating and value setting
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Paul <sean@poorly.run>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hsin-Yi,

Thank you for your patch.

Missatge de Hsin-Yi Wang <hsinyi@chromium.org> del dia dj., 24 de juny
2021 a les 12:55:
>
> drm_dev_register() sets connector->registration_state to
> DRM_CONNECTOR_REGISTERED and dev->registered to true. If
> drm_connector_set_panel_orientation() is first called after
> drm_dev_register(), it will fail several checks and results in following
> warning.
>

In fact, results with the following warning


> Add a function to create panel orientation property and set default value
> to UNKNOWN, so drivers can call this function to init the property earlier
> , and let the panel set the real value later.
>
> [    4.480976] ------------[ cut here ]------------
> [    4.485603] WARNING: CPU: 5 PID: 369 at drivers/gpu/drm/drm_mode_object.c:45 __drm_mode_object_add+0xb4/0xbc
> <snip>
> [    4.609772] Call trace:
> [    4.612208]  __drm_mode_object_add+0xb4/0xbc
> [    4.616466]  drm_mode_object_add+0x20/0x2c
> [    4.620552]  drm_property_create+0xdc/0x174
> [    4.624723]  drm_property_create_enum+0x34/0x98
> [    4.629241]  drm_connector_set_panel_orientation+0x64/0xa0
> [    4.634716]  boe_panel_get_modes+0x88/0xd8
> [    4.638802]  drm_panel_get_modes+0x2c/0x48
> [    4.642887]  panel_bridge_get_modes+0x1c/0x28
> [    4.647233]  drm_bridge_connector_get_modes+0xa0/0xd4
> [    4.652273]  drm_helper_probe_single_connector_modes+0x218/0x700
> [    4.658266]  drm_mode_getconnector+0x1b4/0x45c
> [    4.662699]  drm_ioctl_kernel+0xac/0x128
> [    4.666611]  drm_ioctl+0x268/0x410
> [    4.670002]  drm_compat_ioctl+0xdc/0xf0
> [    4.673829]  __arm64_compat_sys_ioctl+0xc8/0x100
> [    4.678436]  el0_svc_common+0xf4/0x1c0
> [    4.682174]  do_el0_svc_compat+0x28/0x3c
> [    4.686088]  el0_svc_compat+0x10/0x1c
> [    4.689738]  el0_sync_compat_handler+0xa8/0xcc
> [    4.694171]  el0_sync_compat+0x178/0x180
> [    4.698082] ---[ end trace b4f2db9d9c88610b ]---
> [    4.702721] ------------[ cut here ]------------
> [    4.707329] WARNING: CPU: 5 PID: 369 at drivers/gpu/drm/drm_mode_object.c:243 drm_object_attach_property+0x48/0xb8
> <snip>
> [    4.833830] Call trace:
> [    4.836266]  drm_object_attach_property+0x48/0xb8
> [    4.840958]  drm_connector_set_panel_orientation+0x84/0xa0
> [    4.846432]  boe_panel_get_modes+0x88/0xd8
> [    4.850516]  drm_panel_get_modes+0x2c/0x48
> [    4.854600]  panel_bridge_get_modes+0x1c/0x28
> [    4.858946]  drm_bridge_connector_get_modes+0xa0/0xd4
> [    4.863984]  drm_helper_probe_single_connector_modes+0x218/0x700
> [    4.869978]  drm_mode_getconnector+0x1b4/0x45c
> [    4.874410]  drm_ioctl_kernel+0xac/0x128
> [    4.878320]  drm_ioctl+0x268/0x410
> [    4.881711]  drm_compat_ioctl+0xdc/0xf0
> [    4.885536]  __arm64_compat_sys_ioctl+0xc8/0x100
> [    4.890142]  el0_svc_common+0xf4/0x1c0
> [    4.893879]  do_el0_svc_compat+0x28/0x3c
> [    4.897791]  el0_svc_compat+0x10/0x1c
> [    4.901441]  el0_sync_compat_handler+0xa8/0xcc
> [    4.905873]  el0_sync_compat+0x178/0x180
> [    4.909783] ---[ end trace b4f2db9d9c88610c ]---
>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reviewed-by: Sean Paul <seanpaul@chromium.org>

And that patch fixes the problem, apart from, not being an expert, but
the change looks reasonable to me, there is already some reviewed tags
and I'm not sure I am the appropriate to review it but I can

Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

As together with the other two patches works and I don't see any
problem on the Lenovo IdeaPad Duet.

> ---
>  drivers/gpu/drm/drm_connector.c         | 58 ++++++++++++++++++-------
>  drivers/gpu/drm/i915/display/icl_dsi.c  |  1 +
>  drivers/gpu/drm/i915/display/intel_dp.c |  1 +
>  drivers/gpu/drm/i915/display/vlv_dsi.c  |  1 +
>  include/drm/drm_connector.h             |  2 +
>  5 files changed, 47 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
> index 7631f76e7f345..7189baaabf416 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -1210,7 +1210,7 @@ static const struct drm_prop_enum_list dp_colorspaces[] = {
>   *     INPUT_PROP_DIRECT) will still map 1:1 to the actual LCD panel
>   *     coordinates, so if userspace rotates the picture to adjust for
>   *     the orientation it must also apply the same transformation to the
> - *     touchscreen input coordinates. This property is initialized by calling
> + *     touchscreen input coordinates. This property value is set by calling
>   *     drm_connector_set_panel_orientation() or
>   *     drm_connector_set_panel_orientation_with_quirk()
>   *
> @@ -2173,8 +2173,8 @@ EXPORT_SYMBOL(drm_connector_set_vrr_capable_property);
>   * @connector: connector for which to set the panel-orientation property.
>   * @panel_orientation: drm_panel_orientation value to set
>   *
> - * This function sets the connector's panel_orientation and attaches
> - * a "panel orientation" property to the connector.
> + * This function sets the connector's panel_orientation value. If the property
> + * doesn't exist, it will return an error.
>   *
>   * Calling this function on a connector where the panel_orientation has
>   * already been set is a no-op (e.g. the orientation has been overridden with
> @@ -2205,19 +2205,11 @@ int drm_connector_set_panel_orientation(
>         info->panel_orientation = panel_orientation;
>
>         prop = dev->mode_config.panel_orientation_property;
> -       if (!prop) {
> -               prop = drm_property_create_enum(dev, DRM_MODE_PROP_IMMUTABLE,
> -                               "panel orientation",
> -                               drm_panel_orientation_enum_list,
> -                               ARRAY_SIZE(drm_panel_orientation_enum_list));
> -               if (!prop)
> -                       return -ENOMEM;
> -
> -               dev->mode_config.panel_orientation_property = prop;
> -       }
> +       if (WARN_ON(!prop))
> +               return -EINVAL;
>
> -       drm_object_attach_property(&connector->base, prop,
> -                                  info->panel_orientation);
> +       drm_object_property_set_value(&connector->base, prop,
> +                                     info->panel_orientation);
>         return 0;
>  }
>  EXPORT_SYMBOL(drm_connector_set_panel_orientation);
> @@ -2225,7 +2217,7 @@ EXPORT_SYMBOL(drm_connector_set_panel_orientation);
>  /**
>   * drm_connector_set_panel_orientation_with_quirk -
>   *     set the connector's panel_orientation after checking for quirks
> - * @connector: connector for which to init the panel-orientation property.
> + * @connector: connector for which to set the panel-orientation property.
>   * @panel_orientation: drm_panel_orientation value to set
>   * @width: width in pixels of the panel, used for panel quirk detection
>   * @height: height in pixels of the panel, used for panel quirk detection
> @@ -2252,6 +2244,40 @@ int drm_connector_set_panel_orientation_with_quirk(
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
> diff --git a/drivers/gpu/drm/i915/display/icl_dsi.c b/drivers/gpu/drm/i915/display/icl_dsi.c
> index 9282978060b08..5ac4538e42833 100644
> --- a/drivers/gpu/drm/i915/display/icl_dsi.c
> +++ b/drivers/gpu/drm/i915/display/icl_dsi.c
> @@ -1903,6 +1903,7 @@ static void icl_dsi_add_properties(struct intel_connector *connector)
>
>         connector->base.state->scaling_mode = DRM_MODE_SCALE_ASPECT;
>
> +       drm_connector_init_panel_orientation_property(&connector->base);
>         drm_connector_set_panel_orientation_with_quirk(&connector->base,
>                                 intel_dsi_get_panel_orientation(connector),
>                                 connector->panel.fixed_mode->hdisplay,
> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
> index a5231ac3443aa..f1d664e5abb28 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> @@ -5263,6 +5263,7 @@ static bool intel_edp_init_connector(struct intel_dp *intel_dp,
>         intel_panel_setup_backlight(connector, pipe);
>
>         if (fixed_mode) {
> +               drm_connector_init_panel_orientation_property(connector);
>                 drm_connector_set_panel_orientation_with_quirk(connector,
>                                 dev_priv->vbt.orientation,
>                                 fixed_mode->hdisplay, fixed_mode->vdisplay);
> diff --git a/drivers/gpu/drm/i915/display/vlv_dsi.c b/drivers/gpu/drm/i915/display/vlv_dsi.c
> index 9bee99fe54954..853855482af14 100644
> --- a/drivers/gpu/drm/i915/display/vlv_dsi.c
> +++ b/drivers/gpu/drm/i915/display/vlv_dsi.c
> @@ -1632,6 +1632,7 @@ static void vlv_dsi_add_properties(struct intel_connector *connector)
>
>                 connector->base.state->scaling_mode = DRM_MODE_SCALE_ASPECT;
>
> +               drm_connector_init_panel_orientation_property(&connector->base);
>                 drm_connector_set_panel_orientation_with_quirk(
>                                 &connector->base,
>                                 intel_dsi_get_panel_orientation(connector),
> diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> index 1922b278ffadf..4396c1c4a5dbc 100644
> --- a/include/drm/drm_connector.h
> +++ b/include/drm/drm_connector.h
> @@ -1696,6 +1696,8 @@ int drm_connector_set_panel_orientation_with_quirk(
>         struct drm_connector *connector,
>         enum drm_panel_orientation panel_orientation,
>         int width, int height);
> +int drm_connector_init_panel_orientation_property(
> +       struct drm_connector *connector);

nit: this could be probably in one line

>  int drm_connector_attach_max_bpc_property(struct drm_connector *connector,
>                                           int min, int max);
>
> --
> 2.32.0.288.g62a8d224e6-goog
>
