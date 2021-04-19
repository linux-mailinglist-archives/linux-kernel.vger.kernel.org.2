Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 627B33640B2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 13:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238734AbhDSLoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 07:44:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50293 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232530AbhDSLoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 07:44:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618832633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UIAlb9HdBCrRLbA00IatqDn0EvB3C3eeDIiT2Wrei18=;
        b=Q3SZUKFOsTnrOUi9nnu0tAcbqxq7hZOamqv+c0P9nxL+9hDtEsg+43/z/+qO3XF9+aTAoY
        BScKPrpU3i2to/dzX0CKt+7Q0+j7Q0wO0KpgngUfJN/5PaTF6ljKCTM9iM77AZmAhGx4db
        MdjfKt95O3+0NUDt9pkENQ7aurUszDA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-449-fk_PSDl1PW-KM5JAZauY2Q-1; Mon, 19 Apr 2021 07:43:51 -0400
X-MC-Unique: fk_PSDl1PW-KM5JAZauY2Q-1
Received: by mail-wr1-f69.google.com with SMTP id 91-20020adf82e40000b0290106e67e7bfcso6137676wrc.5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 04:43:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UIAlb9HdBCrRLbA00IatqDn0EvB3C3eeDIiT2Wrei18=;
        b=lEifEbMfqA/OLS9hbyE0wZ3gNnrii/HUiCx4oAW/59SyyTQ2hJ8tKclH1nFXzTrRaf
         3P3eOyXe+8aHiksiVZMyrw5LC2Iw/KtAIwYbDcGOXO09NGE4TPbXs4ikwnmTaBLb4zJB
         XFzWv0R/QFVfbecJwboXcA6817tEfSYKMoYfu4L+2iOdneolLcLpDiwSMJ76+Y+ALKyr
         vdnmcsTYV7UquyKyW29IICUMXoam4MH7zdBgcF5m2+dUbdNAT67+HM/f+aAM2FrV1Cxy
         oB2pchAOf75VWFvBqLxrVaOBd0A66q3R2QPPRFOBTdIYJlb/TO7MRbZZlqPAys3gzukz
         0w8g==
X-Gm-Message-State: AOAM532Nsbwwg2FvNEfANVx8kADkPShUwr9/wPC/pEODMHCuF9BDoXgj
        6CCCudRqiuSV0+pIxYfjrwBX4JzxvW9PRHP8CGiGIkNHID62jCmGviguu0eAtlx/TFed4b5jb6I
        f8h6UnL8q2Mfed2kQuEoALOtKrvDGJ6mZZtTmlvWT
X-Received: by 2002:a5d:4689:: with SMTP id u9mr13938289wrq.10.1618832630667;
        Mon, 19 Apr 2021 04:43:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZFUZPXmteljMabJNWgNVI9Opvidiv/0XIcrby9r0EikNzgvp6/EpF3Cg7Zaq7P9Vbfx4BOYpgUjju1Vgg2Kc=
X-Received: by 2002:a5d:4689:: with SMTP id u9mr13938282wrq.10.1618832630547;
 Mon, 19 Apr 2021 04:43:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210416143725.2769053-1-lee.jones@linaro.org> <20210416143725.2769053-6-lee.jones@linaro.org>
In-Reply-To: <20210416143725.2769053-6-lee.jones@linaro.org>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Mon, 19 Apr 2021 13:43:40 +0200
Message-ID: <CACO55tt+J=xmEPB=4HsDdNGrw9c5UaY_2R7BTwqYrLyiLNK6og@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH 05/40] drm/nouveau/nvkm/subdev/volt/gk20a:
 Demote non-conformant kernel-doc headers
To:     Lee Jones <lee.jones@linaro.org>
Cc:     David Airlie <airlied@linux.ie>,
        nouveau <nouveau@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Karol Herbst <kherbst@redhat.com>

On Fri, Apr 16, 2021 at 4:37 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=1 kernel build warning(s):
>
>  drivers/gpu/drm/nouveau/nvkm/subdev/volt/gk20a.c:53: warning: Function parameter or member 'speedo' not described in 'gk20a_volt_get_cvb_voltage'
>  drivers/gpu/drm/nouveau/nvkm/subdev/volt/gk20a.c:53: warning: Function parameter or member 's_scale' not described in 'gk20a_volt_get_cvb_voltage'
>  drivers/gpu/drm/nouveau/nvkm/subdev/volt/gk20a.c:53: warning: Function parameter or member 'coef' not described in 'gk20a_volt_get_cvb_voltage'
>  drivers/gpu/drm/nouveau/nvkm/subdev/volt/gk20a.c:69: warning: Function parameter or member 'speedo' not described in 'gk20a_volt_get_cvb_t_voltage'
>  drivers/gpu/drm/nouveau/nvkm/subdev/volt/gk20a.c:69: warning: Function parameter or member 'temp' not described in 'gk20a_volt_get_cvb_t_voltage'
>  drivers/gpu/drm/nouveau/nvkm/subdev/volt/gk20a.c:69: warning: Function parameter or member 's_scale' not described in 'gk20a_volt_get_cvb_t_voltage'
>  drivers/gpu/drm/nouveau/nvkm/subdev/volt/gk20a.c:69: warning: Function parameter or member 't_scale' not described in 'gk20a_volt_get_cvb_t_voltage'
>  drivers/gpu/drm/nouveau/nvkm/subdev/volt/gk20a.c:69: warning: Function parameter or member 'coef' not described in 'gk20a_volt_get_cvb_t_voltage'
>
> Cc: Ben Skeggs <bskeggs@redhat.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org
> Cc: nouveau@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/gpu/drm/nouveau/nvkm/subdev/volt/gk20a.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/volt/gk20a.c b/drivers/gpu/drm/nouveau/nvkm/subdev/volt/gk20a.c
> index 8c2faa9645111..ccac88da88648 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/volt/gk20a.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/volt/gk20a.c
> @@ -45,7 +45,7 @@ static const struct cvb_coef gk20a_cvb_coef[] = {
>         /* 852 */ { 1608418, -21643, -269,     0,    763,  -48},
>  };
>
> -/**
> +/*
>   * cvb_mv = ((c2 * speedo / s_scale + c1) * speedo / s_scale + c0)
>   */
>  static inline int
> @@ -58,7 +58,7 @@ gk20a_volt_get_cvb_voltage(int speedo, int s_scale, const struct cvb_coef *coef)
>         return mv;
>  }
>
> -/**
> +/*
>   * cvb_t_mv =
>   * ((c2 * speedo / s_scale + c1) * speedo / s_scale + c0) +
>   * ((c3 * speedo / s_scale + c4 + c5 * T / t_scale) * T / t_scale)
> --
> 2.27.0
>
> _______________________________________________
> Nouveau mailing list
> Nouveau@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/nouveau
>

