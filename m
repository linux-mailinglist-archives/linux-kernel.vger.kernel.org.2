Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF123A755A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 05:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhFODqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 23:46:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26191 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229659AbhFODqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 23:46:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623728641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aHGbJbj0ebE6QT9Ys/qhv9gUQ2vgyk5k0OjPBMHdeRg=;
        b=Kkfv5hng7EIRy8SgK2v0nzyy63XDc8Cuuw1W+ctL2e+45s+cLEcAS6DmV0ZugZuX+MITIn
        KfzuVtUMhMuk/0t0mrnqyeNE2MtsqtUhJQsxRYtLS/DLAsJXU41BL6bti5ycpzWyv+ZBT2
        TBaMHOkBHGCD5pELyo2duAwsbgfudCs=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-vnS2PL6dM6CcaEzxdZBsYw-1; Mon, 14 Jun 2021 23:43:59 -0400
X-MC-Unique: vnS2PL6dM6CcaEzxdZBsYw-1
Received: by mail-qk1-f200.google.com with SMTP id v1-20020a372f010000b02903aa9be319adso17554659qkh.11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 20:43:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=aHGbJbj0ebE6QT9Ys/qhv9gUQ2vgyk5k0OjPBMHdeRg=;
        b=qxM+Cb6ZRAgvS0m9DbHPMSsE0XalNsHXj6p76kjg6QgnDHc7hMZs/ScDY7cqFsGSI2
         L5M32gDMlxtEVBG0kFZ0kQTZ0531FH79F9wlyHuYXEi7wS80drHUdFJovQTzWNXyZgcv
         rZcvcBub2RQK0AuoX4EsgikD7IVkp7wpj+s7qCRS3Zl42VGEuMLcDmeSXfW0/4pSginW
         wzvmyJlEx46/7w+0WJiIW8wwzSmk/bPqIqYDxEoHxLLKh51LAA/JjRn98Tx3+n+0IaFE
         9MFEc4OVMs0/E4CaftH0VWoHTO90lHJrDkiwFjMVhr8sDGlc5A6zwVgF8Weh+fg2+iGQ
         Efjw==
X-Gm-Message-State: AOAM5312GHB5Px6VURNtxfaW6qZpz8Pmh5vKDVoeu2JzNloe+QQsTuo9
        KGamsJDAH2NEqkS1LiwaINjESq93plInRacC/zO590mjC4LjbnR9B4hH/hSs6rRvl4aLOBujyXc
        ouPhzu86bTnoE2+4W8/YEuRgi
X-Received: by 2002:a05:6214:321:: with SMTP id j1mr2711520qvu.38.1623728639294;
        Mon, 14 Jun 2021 20:43:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzuw2F0Hwmy8HsE3YZyb+Uzm7Uyn8BYHYIjsreErLv1PghnFw3ohtOSlSt4INE1txfNq/9atw==
X-Received: by 2002:a05:6214:321:: with SMTP id j1mr2711504qvu.38.1623728639099;
        Mon, 14 Jun 2021 20:43:59 -0700 (PDT)
Received: from Ruby.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id p3sm11128331qti.31.2021.06.14.20.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 20:43:58 -0700 (PDT)
Message-ID: <f3824dfa4b4d40d66e0ab56713ba168fc7952e0d.camel@redhat.com>
Subject: Re: [PATCH] drm: nouveau: fix nouveau_backlight compiling error
From:   Lyude Paul <lyude@redhat.com>
To:     Chen Jiahao <chenjiahao16@huawei.com>, bskeggs@redhat.com,
        airlied@linux.ie, daniel@ffwll.ch, airlied@redhat.com,
        nikola.cornij@amd.com, ville.syrjala@linux.intel.com,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     heying24@huawei.com
Date:   Mon, 14 Jun 2021 23:43:57 -0400
In-Reply-To: <20210615031658.176218-1-chenjiahao16@huawei.com>
References: <20210615031658.176218-1-chenjiahao16@huawei.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This needs a fixes tag:

	Fixes: 6eca310e8924 ("drm/nouveau/kms/nv50-: Add basic DPCD backlight support for nouveau")

with that fixed:

Reviewed-by: Lyude Paul <lyude@redhat.com>

On Tue, 2021-06-15 at 11:16 +0800, Chen Jiahao wrote:
> There is a compiling error in disp.c while not selecting
> CONFIG_DRM_NOUVEAU_BACKLIGHT:
> 
> drivers/gpu/drm/nouveau/dispnv50/disp.c: In function
> ‘nv50_sor_atomic_disable’:
> drivers/gpu/drm/nouveau/dispnv50/disp.c:1665:52: error:
> ‘struct nouveau_connector’ has no member named ‘backlight’
>  1665 |  struct nouveau_backlight *backlight = nv_connector->backlight;
>       |                                                    ^~
> drivers/gpu/drm/nouveau/dispnv50/disp.c:1670:28: error: dereferencing
> pointer
> to incomplete type ‘struct nouveau_backlight’
>  1670 |  if (backlight && backlight->uses_dpcd) {
>       |                            ^~
> 
> The problem is solved by adding the CONFIG_DRM_NOUVEAU_BACKLIGHT dependency
> where struct nouveau_backlight is used.
> 
> Signed-off-by: Chen Jiahao <chenjiahao16@huawei.com>
> ---
>  drivers/gpu/drm/nouveau/dispnv50/disp.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c
> b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> index 093e1f7163b3..d266b7721e29 100644
> --- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
> +++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> @@ -1662,17 +1662,21 @@ nv50_sor_atomic_disable(struct drm_encoder *encoder,
> struct drm_atomic_state *st
>         struct nouveau_drm *drm = nouveau_drm(nv_encoder->base.base.dev);
>         struct nouveau_crtc *nv_crtc = nouveau_crtc(nv_encoder->crtc);
>         struct nouveau_connector *nv_connector =
> nv50_outp_get_old_connector(state, nv_encoder);
> +#ifdef CONFIG_DRM_NOUVEAU_BACKLIGHT
>         struct nouveau_backlight *backlight = nv_connector->backlight;
> +#endif
>         struct drm_dp_aux *aux = &nv_connector->aux;
>         int ret;
>         u8 pwr;
>  
> +#ifdef CONFIG_DRM_NOUVEAU_BACKLIGHT
>         if (backlight && backlight->uses_dpcd) {
>                 ret = drm_edp_backlight_disable(aux, &backlight->edp_info);
>                 if (ret < 0)
>                         NV_ERROR(drm, "Failed to disable backlight on
> [CONNECTOR:%d:%s]: %d\n",
>                                  nv_connector->base.base.id, nv_connector-
> >base.name, ret);
>         }
> +#endif
>  
>         if (nv_encoder->dcb->type == DCB_OUTPUT_DP) {
>                 int ret = drm_dp_dpcd_readb(aux, DP_SET_POWER, &pwr);

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

