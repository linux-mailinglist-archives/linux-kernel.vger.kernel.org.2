Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B397341FC0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 15:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbhCSOid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 10:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbhCSOiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 10:38:03 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F01EC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 07:38:03 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id o2so3051043plg.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 07:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r8t+Haw8hnnyPI1A8ckYO+AnKAwkWRp0vTVGtS6IUlo=;
        b=VHOSnptigraQrnHtiYP3M5TJPLgguQqQNkJ+HKd6uE/tEHIW1D2lCZYt4kluq/2Uyo
         +XIW78QJtL/XDkFFfwtHiv31BNMpBs+3fONQIb0wj4848a0o8Nvc/e4aIs0pkwMAblku
         GAA/cn8GOMk3KVKy/PN5Y9R5fA0FccSOupDMtLD/c+JgPqJU+pGEvGd/d/0DTs1kvd7J
         qgE7tuYaHWJfSY2oUN6QbFQCwn8sw2WEPS2upkrhFubBrn4vhwpswSpZuAJ3eAIGGZuV
         9H9YKEuPCTliyuPzVKa5nnr7CvtuIstrFaSr+ovqhzSSSqV17hqiKOimHpNyb8R1EJ3b
         IPWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r8t+Haw8hnnyPI1A8ckYO+AnKAwkWRp0vTVGtS6IUlo=;
        b=qAdiL0Nf4ts6YyeZo9krrb373GX71GmMtZZkzeRIhFn/TJlNQPG4Q1B1io7V7EKmDK
         /eVzIr+Ll/GFVER90oIWCDWXBxknrVsZmXOouyKzp1lbsRzT+fVfUT9wHs59UmdQ8hh2
         BLNj0eF+L/C+939cobH87lvu+be/oxwvbltz09oDZBtgeoa6g30qcMvSB5B7Qqc1PysO
         2IrpKDfz75CXpJzFTujRU/ANtBC5xKHhApZWyulO9J5SbX5XdOQFHrryDmdAYON6k6Cw
         1t1LAX5YA8H7LwGMBkvl4aLvAeOqbJFzukhFW3osk3+1BBDeKle6OtOq2ewbsDxrVrYw
         yTmA==
X-Gm-Message-State: AOAM531xDQe4PUDna6GwyOeHFcfjWwF/2y3sPPY/OtnkD/2k1wHIO48y
        c7VlOb/80QSuXYiMd0SSvmmGoQw4xCspx2GUqDH1mYZxBwsCX7gV
X-Google-Smtp-Source: ABdhPJw8c9CchTDySBs3NZLqT/TkgcU8jgQYXzTtozt8IS+78Ccw8naSaLYw4NWbogbCmYjnH85XuIvZ55HTa3abjoE=
X-Received: by 2002:a17:902:7d8d:b029:e6:4061:b767 with SMTP id
 a13-20020a1709027d8db02900e64061b767mr14682850plm.32.1616164682659; Fri, 19
 Mar 2021 07:38:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210219215326.2227596-1-lyude@redhat.com> <20210219215326.2227596-10-lyude@redhat.com>
In-Reply-To: <20210219215326.2227596-10-lyude@redhat.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Fri, 19 Mar 2021 15:37:51 +0100
Message-ID: <CAG3jFyvW3YxG8jNq9krRJmWUbTFc3sXNXTjnsY0Pmgky6GJgQQ@mail.gmail.com>
Subject: Re: [PATCH 09/30] drm/bridge/analogix/anx78xx: Cleanup on error in anx78xx_bridge_attach()
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
        Boris Brezillon <boris.brezillon@collabora.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Sam Ravnborg <sam@ravnborg.org>, Torsten Duwe <duwe@lst.de>,
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
> Just another issue I noticed while correcting usages of
> drm_dp_aux_init()/drm_dp_aux_register() around the tree. If any of the
> steps in anx78xx_bridge_attach() fail, we end up leaking resources. So,
> let's fix that (and fix leaking a DP AUX adapter in the process) by
> unrolling on errors.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c b/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c
> index 338dd8531d4b..f20558618220 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c
> @@ -918,7 +918,7 @@ static int anx78xx_bridge_attach(struct drm_bridge *bridge,
>                                  DRM_MODE_CONNECTOR_DisplayPort);
>         if (err) {
>                 DRM_ERROR("Failed to initialize connector: %d\n", err);
> -               return err;
> +               goto aux_unregister;
>         }
>
>         drm_connector_helper_add(&anx78xx->connector,
> @@ -930,16 +930,21 @@ static int anx78xx_bridge_attach(struct drm_bridge *bridge,
>                                            bridge->encoder);
>         if (err) {
>                 DRM_ERROR("Failed to link up connector to encoder: %d\n", err);
> -               return err;
> +               goto connector_cleanup;
>         }
>
>         err = drm_connector_register(&anx78xx->connector);
>         if (err) {
>                 DRM_ERROR("Failed to register connector: %d\n", err);
> -               return err;
> +               goto connector_cleanup;
>         }
>
>         return 0;
> +connector_cleanup:
> +       drm_connector_cleanup(&anx78xx->connector);
> +aux_unregister:
> +       drm_dp_aux_unregister(&anx78xx->aux);
> +       return err;
>  }
>
>  static void anx78xx_bridge_detach(struct drm_bridge *bridge)
> --
> 2.29.2
>
