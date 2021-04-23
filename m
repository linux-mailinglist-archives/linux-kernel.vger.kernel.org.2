Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44ED1369BDD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 23:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244188AbhDWVIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 17:08:35 -0400
Received: from mail-io1-f51.google.com ([209.85.166.51]:39930 "EHLO
        mail-io1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244156AbhDWVHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 17:07:55 -0400
Received: by mail-io1-f51.google.com with SMTP id k25so7123957iob.6
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 14:07:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vGf4Bqg3eO6JS3gvF6LxMt8XkWMGCm3Fd5yjKYFBgF8=;
        b=jLcS9iXjF38KzWEOw63///3Lzn0drXDKDeOXB2l4vEpOaV+nyaui1EQM8I/2b7p0OP
         nx2fmRsSBOEop5QM7Ng9sxydPQqyGiKVrXomrKiiRla/rrWHwzsE88B4yOfiXczFXdOR
         6GB4ZLMLIM15iFQGcqcuGOnFEtacaAEpd8HOjvXfla7nVWSqaDtOXf5seQ3ExxkEFmKP
         n53QA2N8MlBCuECJg/8hP1kgsPozK1BofmMZcRNy+8PqvLcxfsfpTnTNjGVklz4SFyJe
         SH8j3UX+0ICTFy8ZvmeMzF4QxuE1jcaF/jrc7kllhEBIINaagjvehQjrr6SmOiU27Ni0
         3VFA==
X-Gm-Message-State: AOAM531cM2HU/jkFRoXNxaWadhw6++Pt52NqLniRXFb0yJWeSDADK2tH
        n3lfZZSc/0dmkJEBPWnmffB5z0fHja/ib9CJOCA=
X-Google-Smtp-Source: ABdhPJx/mGXYebrjo1LW38fgTdwSQnNr3RmcE4CILvZv37TRPOr8OlvisBQvXkXDoBESh8c9agnzKhcwdoToZrcFn2Y=
X-Received: by 2002:a5e:d515:: with SMTP id e21mr4718257iom.30.1619212035381;
 Fri, 23 Apr 2021 14:07:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210423184309.207645-1-lyude@redhat.com> <20210423184309.207645-3-lyude@redhat.com>
In-Reply-To: <20210423184309.207645-3-lyude@redhat.com>
From:   Ilia Mirkin <imirkin@alum.mit.edu>
Date:   Fri, 23 Apr 2021 17:07:04 -0400
Message-ID: <CAKb7UvgpMO60gRzmJY0V5nOsT8u9y2hFLazmVJ+pEiedEKOOhQ@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH v4 02/17] drm/nouveau/kms/nv50-: Move AUX
 adapter reg to connector late register/early unregister
To:     Lyude Paul <lyude@redhat.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Ben Skeggs <bskeggs@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some trivia, no comment on the real logic of the changes:

On Fri, Apr 23, 2021 at 2:43 PM Lyude Paul <lyude@redhat.com> wrote:
>
> Since AUX adapters on nouveau have their respective DRM connectors as
> parents, we need to make sure that we register then after their connectors.

then -> them

>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  drivers/gpu/drm/nouveau/nouveau_connector.c | 25 ++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
> index 61e6d7412505..c04044be3d32 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_connector.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
> @@ -401,7 +401,6 @@ nouveau_connector_destroy(struct drm_connector *connector)
>         drm_connector_cleanup(connector);
>         if (nv_connector->aux.transfer) {
>                 drm_dp_cec_unregister_connector(&nv_connector->aux);
> -               drm_dp_aux_unregister(&nv_connector->aux);
>                 kfree(nv_connector->aux.name);
>         }
>         kfree(connector);
> @@ -905,13 +904,29 @@ nouveau_connector_late_register(struct drm_connector *connector)
>         int ret;
>
>         ret = nouveau_backlight_init(connector);
> +       if (ret)
> +               return ret;
>
> +       if (connector->connector_type == DRM_MODE_CONNECTOR_eDP ||
> +           connector->connector_type == DRM_MODE_CONNECTOR_DisplayPort) {
> +               ret = drm_dp_aux_register(&nouveau_connector(connector)->aux);
> +               if (ret)
> +                       goto backlight_fini;
> +       }
> +
> +       return 0;
> +backlight_fini:
> +       nouveau_backlight_fini(connector);
>         return ret;
>  }
>
>  static void
>  nouveau_connector_early_unregister(struct drm_connector *connector)
>  {
> +       if (connector->connector_type == DRM_MODE_CONNECTOR_eDP ||
> +           connector->connector_type == DRM_MODE_CONNECTOR_DisplayPort)
> +               drm_dp_aux_unregister(&nouveau_connector(connector)->aux);
> +
>         nouveau_backlight_fini(connector);
>  }
>
> @@ -1343,14 +1358,14 @@ nouveau_connector_create(struct drm_device *dev,
>                 snprintf(aux_name, sizeof(aux_name), "sor-%04x-%04x",
>                          dcbe->hasht, dcbe->hashm);
>                 nv_connector->aux.name = kstrdup(aux_name, GFP_KERNEL);
> -               ret = drm_dp_aux_register(&nv_connector->aux);
> +               drm_dp_aux_init(&nv_connector->aux);
>                 if (ret) {
> -                       NV_ERROR(drm, "failed to register aux channel\n");
> +                       NV_ERROR(drm, "Failed to init AUX adapter for sor-%04x-%04x: %d\n",

Maybe just use aux_name instead of rebuilding the string again?

> +                                dcbe->hasht, dcbe->hashm, ret);
>                         kfree(nv_connector);
>                         return ERR_PTR(ret);
>                 }
> -               funcs = &nouveau_connector_funcs;
> -               break;
> +               fallthrough;
>         default:
>                 funcs = &nouveau_connector_funcs;
>                 break;
> --
> 2.30.2
>
> _______________________________________________
> Nouveau mailing list
> Nouveau@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/nouveau
