Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE413CAEB7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 23:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbhGOVuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 17:50:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38375 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230025AbhGOVuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 17:50:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626385644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6VbJoFGn3iVtEo23nu3H2b6uKsNM79IeS4yIQ3LlXnk=;
        b=jQNAE4HAjWd+BVLQp4XeJZ3YhYFb8/Ok38IyJvEEoqs4U5yUDXqHSzgqH9icwVYmcvCt8D
        bquF2DMRYuhUZUM850OFCejBu4mspma4StJkVGg8RHj9XTJKccxxJTyAY2vuFwPi6WR2O4
        tU/igaQJ3x5RZ2mb6d5nUgq9Z3gB1pQ=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-fl15pTIrPrakqat8FAinSQ-1; Thu, 15 Jul 2021 17:47:22 -0400
X-MC-Unique: fl15pTIrPrakqat8FAinSQ-1
Received: by mail-qt1-f197.google.com with SMTP id q1-20020a05622a0301b029025f76cabdfcso1993381qtw.15
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 14:47:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=6VbJoFGn3iVtEo23nu3H2b6uKsNM79IeS4yIQ3LlXnk=;
        b=DftnG1+m7w9H90IyZmqb19qll2Teh1gPpqWaSu4jl1ij2mgJITN6sJgPOyZCzE0X2r
         EzpMkUhvuBu2g0Uu9z48h1WjHqtxmI5EioAlQSNTTpxnQcR3qZNJPpSo1xU0n4eNL68R
         Cp+RlaiLbxQwk2D7CBQ3hDq2gDmDdlEYZp1uKdGSwS16Z8LLtovCqErt2dM4C18f8hhM
         liIEJ1TSFHlIYGgtkKiW5EqRXqJfjpFVL6Ild2shetXr1uFvT/4nV0XuCZPqiP5k1tH7
         tV0V6BZqlNoyQfJPCdfqtq81dzaXyccKErlhvXRv6HcgKX5xCzMjQX8CIrU1Di2HgKz+
         AcuA==
X-Gm-Message-State: AOAM5309NwiqFhh4C8ih8yec2qL/oVWfeG8piVgrZH1bJvEXINN/kgIF
        ahd0yQqWhma7snwTFbAcES3VvPkv0zk11uNTV9y9toDjoUNKFXcGtgWgnwAnA8KNaBPA/j+PDZm
        qi5X3vOiKOyfIhFhzCKpkDTAc
X-Received: by 2002:a37:596:: with SMTP id 144mr6005310qkf.147.1626385642393;
        Thu, 15 Jul 2021 14:47:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwf6CxMuCywKlr13sMEvKt2RmDZXJ3nQGJyosoC9dHBut/1SP4vBw0DEf6PE92oUlap1x+XxQ==
X-Received: by 2002:a37:596:: with SMTP id 144mr6005296qkf.147.1626385642176;
        Thu, 15 Jul 2021 14:47:22 -0700 (PDT)
Received: from Ruby.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id u3sm2549187qtg.16.2021.07.15.14.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 14:47:21 -0700 (PDT)
Message-ID: <9c9c3878de9640239b51fb961e949d2b075dc5ac.camel@redhat.com>
Subject: Re: [PATCH -next] drm: nouveau: fix disp.c build when
 NOUVEAU_BACKLIGHT is not enabled
From:   Lyude Paul <lyude@redhat.com>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org
Date:   Thu, 15 Jul 2021 17:47:20 -0400
In-Reply-To: <20210714171523.413-1-rdunlap@infradead.org>
References: <20210714171523.413-1-rdunlap@infradead.org>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Lyude Paul <lyude@redhat.com>

On Wed, 2021-07-14 at 10:15 -0700, Randy Dunlap wrote:
> Fix build errors and warnings when
> # CONFIG_DRM_NOUVEAU_BACKLIGHT is not set
> 
> ../drivers/gpu/drm/nouveau/dispnv50/disp.c: In function
> ‘nv50_sor_atomic_disable’:
> ../drivers/gpu/drm/nouveau/dispnv50/disp.c:1665:52: error: ‘struct
> nouveau_connector’ has no member named ‘backlight’
>   struct nouveau_backlight *backlight = nv_connector->backlight;
>                                                     ^~
> ../drivers/gpu/drm/nouveau/dispnv50/disp.c:1670:28: error: dereferencing
> pointer to incomplete type ‘struct nouveau_backlight’
>   if (backlight && backlight->uses_dpcd) {
> 
> and then fix subsequent build warnings after the above are fixed:
> 
> ../drivers/gpu/drm/nouveau/dispnv50/disp.c: In function
> ‘nv50_sor_atomic_disable’:
> ../drivers/gpu/drm/nouveau/dispnv50/disp.c:1669:6: warning: unused variable
> ‘ret’ [-Wunused-variable]
>   int ret;
>       ^~~
> ../drivers/gpu/drm/nouveau/dispnv50/disp.c:1662:22: warning: unused variable
> ‘drm’ [-Wunused-variable]
>   struct nouveau_drm *drm = nouveau_drm(nv_encoder->base.base.dev);
>                       ^~~
> 
> Fixes: 6eca310e8924 ("drm/nouveau/kms/nv50-: Add basic DPCD backlight
> support for nouveau")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Ben Skeggs <bskeggs@redhat.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: nouveau@lists.freedesktop.org
> Cc: Lyude Paul <lyude@redhat.com>
> ---
>  drivers/gpu/drm/nouveau/dispnv50/disp.c |    8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> --- linux-next-20210714.orig/drivers/gpu/drm/nouveau/dispnv50/disp.c
> +++ linux-next-20210714/drivers/gpu/drm/nouveau/dispnv50/disp.c
> @@ -1659,23 +1659,27 @@ static void
>  nv50_sor_atomic_disable(struct drm_encoder *encoder, struct
> drm_atomic_state *state)
>  {
>         struct nouveau_encoder *nv_encoder = nouveau_encoder(encoder);
> -       struct nouveau_drm *drm = nouveau_drm(nv_encoder->base.base.dev);
>         struct nouveau_crtc *nv_crtc = nouveau_crtc(nv_encoder->crtc);
>         struct nouveau_connector *nv_connector =
> nv50_outp_get_old_connector(state, nv_encoder);
> +#ifdef CONFIG_DRM_NOUVEAU_BACKLIGHT
> +       struct nouveau_drm *drm = nouveau_drm(nv_encoder->base.base.dev);
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
> -               int ret = drm_dp_dpcd_readb(aux, DP_SET_POWER, &pwr);
> +               ret = drm_dp_dpcd_readb(aux, DP_SET_POWER, &pwr);
>  
>                 if (ret == 0) {
>                         pwr &= ~DP_SET_POWER_MASK;
> 

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

