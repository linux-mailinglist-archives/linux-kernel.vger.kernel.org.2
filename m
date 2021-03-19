Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6850D341FEA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 15:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbhCSOn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 10:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbhCSOnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 10:43:55 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7DEDC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 07:43:55 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id ga23-20020a17090b0397b02900c0b81bbcd4so6865096pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 07:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=86LC+1JkNbbYNnfKum5G/BlJ9HpQquJ6GZDdITyjMEY=;
        b=ESqHg/Y6nunNSt2A+n9NWRNhz9fMlfBI4MSa8ZUCLsFHV6hBHTbyKTb5LvtUBy3sDl
         tZ3TZCOfAxuslM6hVBzvZBG+WDWr6+KKfr45IXsC++3CgBLssBEmOYJPoltIUCj5Ab5r
         Ps5BzO93U4v5ATBIff4UXI55yoi3tueb3M2Mxsxr8AalFKT0qmZjt0ytDLMrSuh+Xjv2
         nn1qSIhjlu63a0/GM1HyDQ0gsQjhbyl0d2JTYfEuiD0xDFDASfbE81sV/e6NUMEG69T/
         p4rrhKaWnvLHgogq2P8lT5x0kwhxjSmRELfZbJfWCaMnzgbK6aqmocai87gZbkTlRmnh
         tqaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=86LC+1JkNbbYNnfKum5G/BlJ9HpQquJ6GZDdITyjMEY=;
        b=E69oEzcdK01iBd8+EScCdyWT/FkFRFxbIzmRBpqTbFxcLgxAFjxtY6+degsepobQuW
         5tygVEanXJA2DJ7kYoraFvPK02Vsx5aAfFBMgyl52bQSx7TCaYS85sSP2Ws933D0qIYT
         lbXrGkyRB4nxlg8BXbo3a8bGPRt/sFZjGs2ZQCfUr571fv6ibli9HkaKZhAOHGrl11ux
         YzbBMNI4pGGOjgn64l/zJIEMiboadSE+jwK7ETV53m/7wOxZ5OkVylDvY5TzWqpHp2v7
         pZ108aXhxX/3FwvrHuNbopI9W9nZvl7JK0kxPUfbr74jjX69OpnlO4ZTCsPophUFXp5+
         pngg==
X-Gm-Message-State: AOAM531ZyTIWl3WfNqhDkFzfRCAW4GVXdBlBNDmUV3WOZBDyvTIkBiA2
        lV3E+tsHgKjbwGKdQF5rDGw8SzbsXqxtOl1LZyoFhQ==
X-Google-Smtp-Source: ABdhPJxMIHdTlGCXNCULSxlRJJagvj2AatBYPGQF37Ua2ikdmUUVJ4WnoNWSgNo0fgfSZ+4tH2iCCodydlKkCHKtvhM=
X-Received: by 2002:a17:90a:be07:: with SMTP id a7mr10386254pjs.75.1616165035134;
 Fri, 19 Mar 2021 07:43:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210219215326.2227596-1-lyude@redhat.com> <20210219215326.2227596-12-lyude@redhat.com>
In-Reply-To: <20210219215326.2227596-12-lyude@redhat.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Fri, 19 Mar 2021 15:43:44 +0100
Message-ID: <CAG3jFyvMb+ENOnM4Ug8Vkfk1uGThQj=+M96mf3ef0e9jzapoCw@mail.gmail.com>
Subject: Re: [PATCH 11/30] drm/bridge/analogix/anx6345: Don't link encoder
 until after connector registration
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
        Sam Ravnborg <sam@ravnborg.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Icenowy Zheng <icenowy@aosc.io>, Torsten Duwe <duwe@lst.de>,
        Joe Perches <joe@perches.com>,
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
> Another case of linking an encoder to a connector after the connector's
> been registered. The proper place to do this is before connector
> registration, so let's fix that.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  drivers/gpu/drm/bridge/analogix/analogix-anx6345.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c b/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
> index 8e016ba7c54a..6258f16da0e8 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
> @@ -556,12 +556,6 @@ static int anx6345_bridge_attach(struct drm_bridge *bridge,
>         drm_connector_helper_add(&anx6345->connector,
>                                  &anx6345_connector_helper_funcs);
>
> -       err = drm_connector_register(&anx6345->connector);
> -       if (err) {
> -               DRM_ERROR("Failed to register connector: %d\n", err);
> -               return err;
> -       }
> -
>         anx6345->connector.polled = DRM_CONNECTOR_POLL_HPD;
>
>         err = drm_connector_attach_encoder(&anx6345->connector,
> @@ -571,6 +565,12 @@ static int anx6345_bridge_attach(struct drm_bridge *bridge,
>                 return err;
>         }
>
> +       err = drm_connector_register(&anx6345->connector);
> +       if (err) {
> +               DRM_ERROR("Failed to register connector: %d\n", err);
> +               return err;
> +       }
> +
>         return 0;
>  }
>
> --
> 2.29.2
>
