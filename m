Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9C93EA978
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 19:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235914AbhHLRaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 13:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234465AbhHLRao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 13:30:44 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DAD5C061756
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 10:30:19 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id w14so10837806pjh.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 10:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=shNhrzerEsE2zV1N+PkQAZcTS3bJIsjxwVv+ONT+kpc=;
        b=dthu5PluI8SIpcGHuz8JNqyfTKjTeq/PS3sko15q/c71jvM7uhnrzAmMOkoByfl71N
         SGjlDrMO8rYb/Kmzko0/UOldzVK7JeHMMSmwx3uxViyzeVS7PjaN25w0RmOHmBxMajfo
         kZLqVaYoQlmpVWITeDANdz+vB1B1iSCXQtLr4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=shNhrzerEsE2zV1N+PkQAZcTS3bJIsjxwVv+ONT+kpc=;
        b=hJZ8ryyNOScj6TkIgZRcxHlYSjFGsYklE19PYL3YLtXPGQkRRZUP9Nx2k8FA1PMpNa
         7QtTVV82Y/y8/tOere7dKo8QWh3brhNN6oCDKh5x6Wrw7shioxY8pwbbeNQKgW7BJP2e
         5r8BPFjex66EVSyExgGtjGsJzaFNpup5sunO+rzD5s6N7lJezJYctGK0lgOFMO6TmhfD
         CGvmKULM7oHIjO/u6OepqddTmtZvuzHK5z1N4Rxzp9Q0pQU+C07dacbtgPLmnARL4ezV
         m8Gshltk2L1XdxsKhGbm1UtBJlc0eQhDEHDph4mCQc1h1R/SDy5V3bOGb4yyIbjaCu7C
         EZ4A==
X-Gm-Message-State: AOAM533Mgq7HbmONAott1qQu3OimikXT960n0F/z9L9j2QKF5Rb1NcWF
        ZEFcel3SFAeIpe0AT/aKFhO5zHjBa4OpWg==
X-Google-Smtp-Source: ABdhPJytjia50EuLnI5c4vR751QI66Gi5kfja7DX4nNhMFfkscqdEusF7ry2abKTFbGLZKYo75Freg==
X-Received: by 2002:a17:903:22cd:b0:12d:8876:eea7 with SMTP id y13-20020a17090322cd00b0012d8876eea7mr1324508plg.75.1628789418443;
        Thu, 12 Aug 2021 10:30:18 -0700 (PDT)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com. [209.85.216.52])
        by smtp.gmail.com with ESMTPSA id e7sm4224139pfe.124.2021.08.12.10.30.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Aug 2021 10:30:18 -0700 (PDT)
Received: by mail-pj1-f52.google.com with SMTP id fa24-20020a17090af0d8b0290178bfa69d97so11935348pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 10:30:18 -0700 (PDT)
X-Received: by 2002:a05:6602:2159:: with SMTP id y25mr3762841ioy.61.1628788948245;
 Thu, 12 Aug 2021 10:22:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210811235253.924867-1-robdclark@gmail.com> <20210811235253.924867-5-robdclark@gmail.com>
In-Reply-To: <20210811235253.924867-5-robdclark@gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 12 Aug 2021 10:22:15 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V_bE0MfHDZn=u98UZ1eDw7vQXMpG=btwW6XGGqCF4brw@mail.gmail.com>
Message-ID: <CAD=FV=V_bE0MfHDZn=u98UZ1eDw7vQXMpG=btwW6XGGqCF4brw@mail.gmail.com>
Subject: Re: [PATCH 4/4] drm/bridge: ti-sn65dsi86: Add NO_CONNECTOR support
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Rob Clark <robdclark@chromium.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Aug 11, 2021 at 4:51 PM Rob Clark <robdclark@gmail.com> wrote:
>
> From: Rob Clark <robdclark@chromium.org>
>
> Slightly awkward to fish out the display_info when we aren't creating
> own connector.  But I don't see an obvious better way.
>
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 34 +++++++++++++++++++++++----
>  1 file changed, 29 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> index 38dcc49eccaf..dc8112bab3d3 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> @@ -693,9 +693,11 @@ static int ti_sn_bridge_attach(struct drm_bridge *bridge,
>                 return ret;
>         }
>
> -       ret = ti_sn_bridge_connector_init(pdata);
> -       if (ret < 0)
> -               goto err_conn_init;
> +       if (!(flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR)) {
> +               ret = ti_sn_bridge_connector_init(pdata);
> +               if (ret < 0)
> +                       goto err_conn_init;
> +       }
>
>         /*
>          * TODO: ideally finding host resource and dsi dev registration needs
> @@ -757,7 +759,8 @@ static int ti_sn_bridge_attach(struct drm_bridge *bridge,
>  err_dsi_attach:
>         mipi_dsi_device_unregister(dsi);
>  err_dsi_host:
> -       drm_connector_cleanup(&pdata->connector);
> +       if (!(flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR))
> +               drm_connector_cleanup(&pdata->connector);
>  err_conn_init:
>         drm_dp_aux_unregister(&pdata->aux);
>         return ret;
> @@ -806,9 +809,30 @@ static void ti_sn_bridge_set_dsi_rate(struct ti_sn65dsi86 *pdata)
>         regmap_write(pdata->regmap, SN_DSIA_CLK_FREQ_REG, val);
>  }
>
> +/*
> + * Find the connector and fish out the bpc from display_info.  It would
> + * be nice if we could get this instead from drm_bridge_state, but that
> + * doesn't yet appear to be the case.
> + */
>  static unsigned int ti_sn_bridge_get_bpp(struct ti_sn65dsi86 *pdata)
>  {
> -       if (pdata->connector.display_info.bpc <= 6)
> +       struct drm_bridge *bridge = &pdata->bridge;
> +       struct drm_connector_list_iter conn_iter;
> +       struct drm_connector *connector;
> +       unsigned bpc = 0;
> +
> +       drm_connector_list_iter_begin(bridge->dev, &conn_iter);
> +       drm_for_each_connector_iter(connector, &conn_iter) {
> +               if (drm_connector_has_possible_encoder(connector, bridge->encoder)) {
> +                       bpc = connector->display_info.bpc;
> +                       break;
> +               }
> +       }
> +       drm_connector_list_iter_end(&conn_iter);

This looks reasonable to me. I'll plan to apply it to drm-misc-next
sometime next week to give Laurent a chance to comment on whether this
causes any problems with his planned support for full DP using this
bridge chip. IIUC that means it'll hit mainline 1 rev later, but as
per IRC comments this should be fine.

Reviewed-by: Douglas Anderson <dianders@chromium.org>


-Doug
