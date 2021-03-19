Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5563418E6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 10:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbhCSJzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 05:55:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48924 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229814AbhCSJzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 05:55:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616147722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3Bs/uc42CyNw28LGCDWnaaSfmqCsvJEY+pIrcxWbjT4=;
        b=PqJF6z09Mrw+HIWA1+IzrklEC8LC66bOuQoWrftalbkVNBiNJ1cMWrpIdjfhg5529cW9zJ
        cmi6jRABjzItQJoqtCY5zMETAO95MjQ37J7I6FiCyaTFoVC9Q1BfnjKQPhLPBcHDwk/+wY
        CqvtUTN+igEngx2iZ9mwmKdzAt3lroA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-pvvAb1cDMs6NTw2xH5MaDQ-1; Fri, 19 Mar 2021 05:55:20 -0400
X-MC-Unique: pvvAb1cDMs6NTw2xH5MaDQ-1
Received: by mail-wr1-f70.google.com with SMTP id m9so21606479wrx.6
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 02:55:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Bs/uc42CyNw28LGCDWnaaSfmqCsvJEY+pIrcxWbjT4=;
        b=r94CPsIgm2wGc1LG/u95N8CHFFrx+PsZCcflsSN5pb+FxlXB3qO8rQe1mOOb9wuCml
         MCvBQdX36v/8zU2VasS3mAQS+uJC78eO0KauqToYTRrZNDHL0/HGkpG+WkmANbvHajij
         vEIRkd/TcMp2nWKlSFGStUyvB724ofbSFX39zX/+6pp0JbiF+gRFFvd8VCi6NDT0XlEN
         5xDNwlt9WbUkczr03PMaoq5S3+55dQpQb/oVtHh4QmRiuLTsHSLlSfvNZIB9mGb0ByJF
         wer37ghXkLOnjE2DdT3Tdw7oxC1yu3yF+0kYdP8lui/1cFYtv5oFdrR00FTmXRrtycy0
         atVw==
X-Gm-Message-State: AOAM532zbRULCm8THOtkMTMWnhK48eWMbofi3zMDpPyhUts3LSmKKbVN
        Y5NOHVIOEbQhEaDkjZtW/GJrKdHBFwZdasEUuNSHqyuyVDjDzKiNphQY+ekC/lbnWxFVpN2P9uG
        7TcLCeTQOiwoxwtrUnBF0RC6XgBNN7Aiu2OhL1rzq
X-Received: by 2002:a1c:ddc6:: with SMTP id u189mr2996532wmg.171.1616147719839;
        Fri, 19 Mar 2021 02:55:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw2w6RvVCfzpx4+7sRy74TxWSXSVvH+JqsUT+aEy6DCSrzWG7WAtBYMLzlvmCuYIkNsjk82Q1/s3kjxTw2KrEw=
X-Received: by 2002:a1c:ddc6:: with SMTP id u189mr2996519wmg.171.1616147719709;
 Fri, 19 Mar 2021 02:55:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210319082428.3294591-1-lee.jones@linaro.org> <20210319082428.3294591-6-lee.jones@linaro.org>
In-Reply-To: <20210319082428.3294591-6-lee.jones@linaro.org>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Fri, 19 Mar 2021 10:55:09 +0100
Message-ID: <CACO55ttxZ9NdeMsBy8fDSFnv5VwJ4tP1y3zJUjmNybBgAtcOpg@mail.gmail.com>
Subject: Re: [PATCH 05/19] drm/nouveau/nvkm/subdev/volt/gk20a: Demote
 non-conformant kernel-doc headers
To:     Lee Jones <lee.jones@linaro.org>
Cc:     David Airlie <airlied@linux.ie>,
        nouveau <nouveau@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2021 at 9:24 AM Lee Jones <lee.jones@linaro.org> wrote:
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
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>

Reviewed-by: Karol Herbst <kherbst@redhat.com>

