Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CAF036E034
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 22:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241876AbhD1UWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 16:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240497AbhD1UWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 16:22:18 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD99C06138A
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 13:21:33 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id v13so3923639ilj.8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 13:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3FlfJuCO/i0lHXz9Yi8JuX0LHEp/FCSt5EvXf/XQhbw=;
        b=Twe/v+kPHslIBdnujIpFoTmjqKiXz3Qw86igYBt6JKw9MRVlLASnJezyH+2HX0D5/y
         1S+ZoIf/DhA5jzqOmWyOdNWhi372TPnKzo2U1odOVbpIh9peetD1cWRUTXNOuHiur8RF
         CTAf8QNFFktBK+T6i7jMTFhiGslZ/9XyFimZ73V5HSutx9tH2bKP85o42syoYOj9MinU
         N7vUUXLASROmijnkzZEYDKhs1CIZcc88YyxWOpDVZ46m4dn3JJAqyEJPLohCA9ebVbju
         OYL1e2aCMN1Gi1lP9HTfavKkJuXnOqd3N6Tdd5CHP0iPUiI120LMpSdC1aXMgJjhs6dD
         oW4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3FlfJuCO/i0lHXz9Yi8JuX0LHEp/FCSt5EvXf/XQhbw=;
        b=aWFzxEuaqQcvbIB+5ygUk5PtyBD52h86ywydnBgCtTVgh2LgqnP685bUKOVvIZV259
         fXkakC8tLTjjJDkPfgeH64ISDtTBxZZzsnDoTQyNOvrGaWpTtOH5eBy2KqYM3g/S0Sjf
         Kv8kibsQQpCXI3LiefXD9aJiUpV/JVmhzZFc9s8bvbi19xSpCurrak/n2LfA/yrlmSdt
         /x8dCEVe6OWcbtPDgvws2mFvTXPBn0VayqoPiibIUupcfLMdt0xS1ZvcemsYR5XNMiGV
         qofzOvB/TPMbR0NFo+BCfHegJPbKzvC7xVs9U71hl/NnQ40CEVl7DFfaZRbPR/Kpw/VJ
         tiAA==
X-Gm-Message-State: AOAM530KwEpTh5U5/pKg91MOgWsCpEwGNX6uUx/fELClEBMELV2PeNyK
        Tn6xWosEzC/023vxJTSJ87AOFe+zpMiCjoTDTWhNGpRBUbI=
X-Google-Smtp-Source: ABdhPJxW0HbA94ewF7F3weEGbYhyR1USNUWGh56KyTn6uWBkUkN9dCEH3OgkE9YeiRwCBSERhbC4leLYiC4JNncqOlo=
X-Received: by 2002:a05:6e02:1d06:: with SMTP id i6mr24290849ila.165.1619641292908;
 Wed, 28 Apr 2021 13:21:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210428170416.1027484-1-hsinyi@chromium.org> <20210428170416.1027484-3-hsinyi@chromium.org>
In-Reply-To: <20210428170416.1027484-3-hsinyi@chromium.org>
From:   Sean Paul <sean@poorly.run>
Date:   Wed, 28 Apr 2021 16:20:56 -0400
Message-ID: <CAMavQK+RJATzOVfgRhpU5i3kGsYM2-y4whgZMTdwNnK=z63nYA@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] drm/i915: init panel orientation property
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

On Wed, Apr 28, 2021 at 1:04 PM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>
> Creating the panel orientation property first since we separate the
> property creating and value setting.

This should probably be included in patch 1 so you don't regress i915
in between patches.

Sean

>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
>  drivers/gpu/drm/i915/display/icl_dsi.c  | 1 +
>  drivers/gpu/drm/i915/display/intel_dp.c | 1 +
>  drivers/gpu/drm/i915/display/vlv_dsi.c  | 1 +
>  3 files changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/i915/display/icl_dsi.c b/drivers/gpu/drm/i915/display/icl_dsi.c
> index 9282978060b0..162fb3cf0f5a 100644
> --- a/drivers/gpu/drm/i915/display/icl_dsi.c
> +++ b/drivers/gpu/drm/i915/display/icl_dsi.c
> @@ -1903,6 +1903,7 @@ static void icl_dsi_add_properties(struct intel_connector *connector)
>
>         connector->base.state->scaling_mode = DRM_MODE_SCALE_ASPECT;
>
> +       drm_connector_attach_scaling_mode_property(&connector->base);
>         drm_connector_set_panel_orientation_with_quirk(&connector->base,
>                                 intel_dsi_get_panel_orientation(connector),
>                                 connector->panel.fixed_mode->hdisplay,
> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
> index a5231ac3443a..f1d664e5abb2 100644
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
> index 9bee99fe5495..853855482af1 100644
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
> --
> 2.31.1.498.g6c1eba8ee3d-goog
>
