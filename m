Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0E3A341FC2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 15:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbhCSOjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 10:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbhCSOjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 10:39:17 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D48C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 07:39:16 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id u19so3815380pgh.10
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 07:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xqUIitizMTnYW6S9ohgcqJQ/J1W0YdhVn6Dv9vqrskk=;
        b=SZEnYT7h6DCwyjpq+7bIJP9gm9gyX8+UPSBYtn1U4Ml2edHlstmfKmS7tzo1gVFGGy
         tVIK6T1X69l6L0KBTvH6T3V5b5QYtMRA6hH6ki9WecNYdezFAA/+l/jNwMgt2t8BAm1A
         pZKpWz++WWGHtOWWkc8XVl3IBMjaPYJWv0Yhsv7reWTonWSlm2/UdZDUfrckcQa/as6m
         qHE51eDJJ8+t2beaAm/D3r6+sexCG2oHXenD7PZaSgcpSC8f2FMAnOlMq1hSpJuRGyXy
         j90nuX8PJ8m/ToLUQ/FBWBrpuEQ2rQ+ACJDGKNtaP/hRO3U9rokQks1V74Uy0a8qSQzF
         YPeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xqUIitizMTnYW6S9ohgcqJQ/J1W0YdhVn6Dv9vqrskk=;
        b=izd8An7L8VK8ML2V6S1bFq0BzrYUPWG+csLdWEdtWvpbqyBhwNdr/fplWbt1DQ/X+J
         lUHbhGhhG9uQ69GzXFpgWMLjFn/RYv0D66WFhZTt1y5J9I92KgZISUIcpg/Y3NyUGFvi
         1H20dH9h6ZxonClDS/qiBjUmCYVAjcinbLSJ+00xfTR0EjxPKcDOpAr7csvjn6cFDNOb
         Yi9RqtnoVJl3zE8xwv/McQuzcMc9hfpb5A/udcbauCTk4uW2UYS3D0XqFMl2ZAwtRfme
         VYkeEaSxDk9N/lPnmqHSAljD4PeF1kChZytKJ+c8ucJ5BaSn626jVKQ0V4Yg0w6wWffg
         qM0g==
X-Gm-Message-State: AOAM531qnGwxS/i0iF4PLn0ZoWFKis22WRwU9Fm4wpFDN1tP7EKaMzU7
        67gVbFnyE05Kns/KAQ/WtrQe3koKEArj8pxT1g/apA==
X-Google-Smtp-Source: ABdhPJxyzaVRIHKqWtfgcw3n5NOIEIk5UCwoTeZ+Esn+3nxwGg5PiW1JJdRjbupSYVJzlFjyNK41/72RfVqZUtibaz8=
X-Received: by 2002:a62:80cf:0:b029:1f3:1959:2e42 with SMTP id
 j198-20020a6280cf0000b02901f319592e42mr9452067pfd.39.1616164756499; Fri, 19
 Mar 2021 07:39:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210219215326.2227596-1-lyude@redhat.com> <20210219215326.2227596-11-lyude@redhat.com>
In-Reply-To: <20210219215326.2227596-11-lyude@redhat.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Fri, 19 Mar 2021 15:39:05 +0100
Message-ID: <CAG3jFyvL99-b_F2e=A2SsfkiOV5Un3GZUeOfV_Uxb4YxiSf6UA@mail.gmail.com>
Subject: Re: [PATCH 10/30] drm/bridge/analogix/anx6345: Add missing
 drm_dp_aux_unregister() call
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
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Torsten Duwe <duwe@lst.de>, Joe Perches <joe@perches.com>,
        Icenowy Zheng <icenowy@aosc.io>,
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
> Another driver I found that seems to forget to unregister it's DP AUX
> device. Let's fix this by adding anx6345_bridge_detach().
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  drivers/gpu/drm/bridge/analogix/analogix-anx6345.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c b/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
> index d9164fab044d..8e016ba7c54a 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
> @@ -574,6 +574,11 @@ static int anx6345_bridge_attach(struct drm_bridge *bridge,
>         return 0;
>  }
>
> +static void anx6345_bridge_detach(struct drm_bridge *bridge)
> +{
> +       drm_dp_aux_unregister(&bridge_to_anx6345(bridge)->aux);
> +}
> +
>  static enum drm_mode_status
>  anx6345_bridge_mode_valid(struct drm_bridge *bridge,
>                           const struct drm_display_info *info,
> @@ -624,6 +629,7 @@ static void anx6345_bridge_enable(struct drm_bridge *bridge)
>
>  static const struct drm_bridge_funcs anx6345_bridge_funcs = {
>         .attach = anx6345_bridge_attach,
> +       .detach = anx6345_bridge_detach,
>         .mode_valid = anx6345_bridge_mode_valid,
>         .disable = anx6345_bridge_disable,
>         .enable = anx6345_bridge_enable,
> --
> 2.29.2
>
