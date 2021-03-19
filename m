Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7285341FA1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 15:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbhCSOg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 10:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbhCSOfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 10:35:53 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 585EDC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 07:35:53 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id v23so3039649ple.9
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 07:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0R7vCUqOiWqusGQdLDA2yAGdzDAYsdMM6CojvsuIllk=;
        b=dYE81wS7DSKdB7GyR7+XAISp1t5pL/zSDfGVzIkbDNtoK9UFhOBsBQloCz5aWC1JAw
         lb3M2Iovl8eVPmG9iOIr/YUjCSJAhPTN/g+p6UMu6/Y1VjFTY32AXsOmDiENYV+o4uYU
         2E6IrTuBArSyTrhCPYpg4mJiuwrSs7OAHvKo0A4CJV1bCBDO7aWZsxn8OtdcMNW1ZA7u
         S+elXIqViLr/nD7rTq4htiUkJ5lo2uGNeF21pedQKl0u5C8M9VsU/JvlO1Bjey6pA7C4
         ANLJaApZfubVYKU033BWxll74mz1LZeSHXGAp7PYpcEbxUnJW9WBOVD/HMYy5a3wMAlo
         KCQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0R7vCUqOiWqusGQdLDA2yAGdzDAYsdMM6CojvsuIllk=;
        b=RMqv8y8al9iZWAMAWNVg5kpuUBxnEsgMEkL3143+eAlA1ldfGeGLPsDDK+XUum7+kC
         7+ED1b+302f80raHAoHeSNHR9h8CNvECp+eB2SbQnkIOQdPbq6DHyDvIBY6xNp0iUnDE
         zXbRNUIr5z2Sdkj/mBVTPYwnUUH90h32bcvKqavlOHYIMs1WPKqxgSyJWeb8QJSskFHT
         tKwcG5J7QiGYJnosVVYj+Pzcg4b3NU1jRPYZ49dOhco5CU7SNy71Oa0pMJ4C0ox7awXq
         hK/S82azWebv8403ocPSkoaWAWrtHyTo6o3OBd/d6hdJytRIZs2EkRiMePrFLV8BbwvM
         riZQ==
X-Gm-Message-State: AOAM530VWTgNRr/OJsEnY8u5b0N/p2tlfWagGbmHQpQFRfWq3uVeTg05
        D5PW4CdD2KFutuUzc8XglSq/7pUll7jRN5IOAIt91A==
X-Google-Smtp-Source: ABdhPJx6mz7QtxY42zHzQ4OwZrXSYkhmbs+ESa/8sPIZwAXqhmt9XhBi9MDQuYZrkn0CZzsEUeDWOtF7VrY+uzB9bCI=
X-Received: by 2002:a17:90a:4a8f:: with SMTP id f15mr10307132pjh.19.1616164552793;
 Fri, 19 Mar 2021 07:35:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210219215326.2227596-1-lyude@redhat.com> <20210219215326.2227596-9-lyude@redhat.com>
In-Reply-To: <20210219215326.2227596-9-lyude@redhat.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Fri, 19 Mar 2021 15:35:41 +0100
Message-ID: <CAG3jFyto=4U7wqtw92Escsu9cXGV=xD8SUKm_UUm7bRmYPUYxA@mail.gmail.com>
Subject: Re: [PATCH 08/30] drm/bridge/analogix/anx78xx: Setup encoder before
 registering connector
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
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Torsten Duwe <duwe@lst.de>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Lyude,

Thanks for the patch, it looks good to me.

Reviewed-by: Robert Foss <robert.foss@linaro.org>

On Fri, 19 Feb 2021 at 22:56, Lyude Paul <lyude@redhat.com> wrote:
>
> Since encoder mappings for connectors are exposed to userspace, we should
> be attaching the encoder before exposing the connector to userspace. Just a
> drive-by fix for an issue I noticed while fixing up usages of
> drm_dp_aux_init()/drm_dp_aux_register() across the tree.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c b/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c
> index ec4607dc01eb..338dd8531d4b 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c
> @@ -924,12 +924,6 @@ static int anx78xx_bridge_attach(struct drm_bridge *bridge,
>         drm_connector_helper_add(&anx78xx->connector,
>                                  &anx78xx_connector_helper_funcs);
>
> -       err = drm_connector_register(&anx78xx->connector);
> -       if (err) {
> -               DRM_ERROR("Failed to register connector: %d\n", err);
> -               return err;
> -       }
> -
>         anx78xx->connector.polled = DRM_CONNECTOR_POLL_HPD;
>
>         err = drm_connector_attach_encoder(&anx78xx->connector,
> @@ -939,6 +933,12 @@ static int anx78xx_bridge_attach(struct drm_bridge *bridge,
>                 return err;
>         }
>
> +       err = drm_connector_register(&anx78xx->connector);
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
