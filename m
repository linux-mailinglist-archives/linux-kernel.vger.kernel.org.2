Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76F243640AE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 13:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238748AbhDSLoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 07:44:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20873 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232530AbhDSLoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 07:44:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618832617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=328beX0Y8euNQ3/bq0gYCGzKWoHwLr1bHGXl0+OSrSs=;
        b=PLvhTVm/eK9A+JWM3mcVo8Qq25PXkmrebG46dGkMLLfNTE7k5Nm7IofeHCUWcBve3gF5HO
        QenlP8dwJ7e1x09ogEueUStrsYH+uBW/fowsek4ZVFz943PvFRcQu35DhembAyKRBl8D1b
        7JXJmKeVa3Glr0/FYd3+Z1jX/CSlw5o=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-591-7tAxeCr8MRGYmKMyzQJ3Pw-1; Mon, 19 Apr 2021 07:43:35 -0400
X-MC-Unique: 7tAxeCr8MRGYmKMyzQJ3Pw-1
Received: by mail-wr1-f72.google.com with SMTP id 65-20020adf94c70000b0290106f90d4e1bso4642596wrr.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 04:43:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=328beX0Y8euNQ3/bq0gYCGzKWoHwLr1bHGXl0+OSrSs=;
        b=bwgFXUqByl9FTvG2OsrC8akfT/2DzlnrzdD0J/LyOOMJsYt2llcwLdipZN2yatBKXH
         XESCkoRJsJXWgm/xJobow/HYruRVKgevEy4MTILoWw0BgePWYhPcWDhMfPWd/OoA5gZO
         CltOxkXoo7Za3ab2xc5bCXASdSogGSVHNdX3Ss/NEQpHSz8ZK8awxqGmw13nTOUvaz1F
         ADSxZ9dHLg//Pw9ef2Pzla625C4SWGiS/IsM1atAOBTS7HWoyMbbBWmCRwdCRh0Kgpqh
         krOOBd4funb27wYtkFxIFlLbwlsW+VUoNlPJU/+qWYcDjd4W+ub/CEo+f4xkT4DA5tKa
         7/qA==
X-Gm-Message-State: AOAM5320Jj4/SzbBuMZni9yji/ITy4pQDOGL+c1eiQdzvL5Q76SSYWeD
        MELu6Q7NFHpNfk1vDTRpcaS1pN3ucyVBVZM3CSOSjrtBhpe7/aiul5zha7NqVdKkToDstj9dCyP
        pCmUjzDlCm2Q0MkFztXEywv5ZgYLELaApYVeCxk3v
X-Received: by 2002:a5d:524d:: with SMTP id k13mr14473074wrc.113.1618832614885;
        Mon, 19 Apr 2021 04:43:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwOgVCGSvDVcpbecEJkN3C9WOb/HAPuFV3M1eNh/o4kfj3wD4qQBo8QFWYdgxFRz7QrP15fBD3eaP9svuQ95yc=
X-Received: by 2002:a5d:524d:: with SMTP id k13mr14473060wrc.113.1618832614773;
 Mon, 19 Apr 2021 04:43:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210416143725.2769053-1-lee.jones@linaro.org> <20210416143725.2769053-7-lee.jones@linaro.org>
In-Reply-To: <20210416143725.2769053-7-lee.jones@linaro.org>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Mon, 19 Apr 2021 13:43:24 +0200
Message-ID: <CACO55ttdMHPf3UrGAsY+vNxaq66QKi7FdbeyfLiFx6Hnst0tJA@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH 06/40] drm/nouveau/nvkm/engine/gr/gf100: Demote
 non-conformant kernel-doc header
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
>  drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c:992: warning: Function parameter or member 'gr' not described in 'gf100_gr_wait_idle'
>
> Cc: Ben Skeggs <bskeggs@redhat.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org
> Cc: nouveau@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c b/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c
> index 397ff4fe9df89..69e6008f99196 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c
> @@ -982,7 +982,7 @@ gf100_gr_zbc_init(struct gf100_gr *gr)
>         }
>  }
>
> -/**
> +/*
>   * Wait until GR goes idle. GR is considered idle if it is disabled by the
>   * MC (0x200) register, or GR is not busy and a context switch is not in
>   * progress.
> --
> 2.27.0
>
> _______________________________________________
> Nouveau mailing list
> Nouveau@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/nouveau
>

